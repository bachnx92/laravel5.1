<?php namespace App\Http\Controllers;

use App\Http\Requests\CreateUserRequest;
use App\Http\Requests\UpdateUserRequest;
use App\Models\Permission;
use Illuminate\Http\Request;
use App\Repositories\Criteria\User\UsersWithRoles;
use App\Repositories\Criteria\User\UsersByUsernamesAscending;
use App\Repositories\UserRepository as User;
use App\Repositories\RoleRepository as Role;
use Flash;
use Auth;
use DB;

class UsersController extends Controller {

    /**
     * @var User
     */
    protected $user;

    /**
     * @var Role
     */
    protected $role;

    /**
     * @var Permission
     */
    protected $perm;

    /**
     * @param User $user
     * @param Role $role
     */
    public function __construct(User $user, Role $role, Permission $perm)
    {
        $this->user = $user;
        $this->role = $role;
        $this->perm = $perm;
    }

    /**
     * @return \Illuminate\View\View
     */
    public function index()
    {
        $page_title = trans('admin/users/general.page.index.title'); // "Admin | Users";
        $page_description = trans('admin/users/general.page.index.description'); // "List of users";

        $users = $this->user->pushCriteria(new UsersWithRoles())->pushCriteria(new UsersByUsernamesAscending())->paginate(10);
        return view('admin.users.index', compact('users', 'page_title', 'page_description'));
    }

    /**
     * @return \Illuminate\View\View
     */
    public function show($id)
    {
        $user = $this->user->find($id);

        $page_title = trans('admin/users/general.page.show.title'); // "Admin | User | Show";
        $page_description = trans('admin/users/general.page.show.description', ['full_name' => $user->full_name]); // "Displaying user";

        $roles = $this->role->all();
        $userRoles = $user->roles;
        $roleCollection = \App\Models\Role::take(10)->get(['id', 'display_name'])->lists('display_name', 'id');
        $roleList = [''=>''] + $roleCollection->all();
        $perms = $this->perm->all();

        return view('admin.users.show', compact('user', 'roles', 'perms', 'userRoles', 'roleList', 'page_title', 'page_description'));
    }

    /**
     * @return \Illuminate\View\View
     */
    public function create()
    {
        $page_title = trans('admin/users/general.page.create.title'); // "Admin | User | Create";
        $page_description = trans('admin/users/general.page.create.description'); // "Creating a new user";

        $roles = $this->role->all();
        $perms = $this->perm->all();
        $user = new \App\User();
        $userRoles = $user->roles;
        $roleCollection = \App\Models\Role::take(10)->get(['id', 'display_name'])->lists('display_name', 'id');
        $roleList = [''=>''] + $roleCollection->all();

        return view('admin.users.create', compact('user', 'roles', 'perms', 'roleList', 'userRoles', 'page_title', 'page_description'));
    }

    /**
     * @param CreateUserRequest $request
     *
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function store(CreateUserRequest $request)
    {
        $attributes = $request->all();

        if ( array_key_exists('selected_roles', $attributes) ) {
            $attributes['role'] = explode(",", $attributes['selected_roles']);
        }
        // Create basic user.
        $user = $this->user->create($attributes);
        // Run the update method to set enabled status and roles membership.
        $user->update($attributes);

        Flash::success( trans('admin/users/general.status.created') ); // 'User successfully created');

        return redirect('/admin/users');
    }

    /**
     * @param $id
     *
     * @return \Illuminate\View\View
     */
    public function edit($id)
    {
        $user = $this->user->find($id);

        $page_title = trans('admin/users/general.page.edit.title'); // "Admin | User | Edit";
        $page_description = trans('admin/users/general.page.edit.description', ['full_name' => $user->full_name]); // "Editing user";

        if (!$user->isEditable())
        {
            abort(403);
        }

        $roles = $this->role->all();
        $perms = $this->perm->all();
        $userRoles = $user->roles;
        $roleCollection = \App\Models\Role::take(10)->get(['id', 'display_name'])->lists('display_name', 'id');
        $roleList = [''=>''] + $roleCollection->all();

        return view('admin.users.edit', compact('user', 'roles', 'userRoles', 'roleList', 'perms', 'page_title', 'page_description'));
    }

    /**
     * @param UpdateUserRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function update(UpdateUserRequest $request, $id)
    {
        $user = $this->user->find($id);

        if (!$user->isEditable())
        {
            abort(403);
        }

        $attributes = $request->all();

        if ( array_key_exists('selected_roles', $attributes) ) {
            $attributes['role'] = explode(",", $attributes['selected_roles']);
        }

        $user->update($attributes);

        Flash::success( trans('admin/users/general.status.updated') );

        return redirect('/admin/users');
    }

    /**
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function destroy($id)
    {
        $user = $this->user->find($id);

        

        $this->user->delete($id);

        Flash::success( trans('admin/users/general.status.deleted') );

        return redirect('/admin/users');
    }

    /**
     * Delete Confirm
     *
     * @param   int   $id
     * @return  View
     */
    public function getModalDelete($id)
    {
        $error = null;

        $user = $this->user->find($id);

        if (!$user->isdeletable())
        {
            abort(403);
        }

        $modal_title = trans('admin/users/dialog.delete-confirm.title');
        $modal_cancel = trans('general.button.cancel');
        $modal_ok = trans('general.button.ok');

        if (Auth::user()->id !== $id) {
            $user = $this->user->find($id);
            $modal_route = route('admin.users.delete', array('id' => $user->id));

            $modal_body = trans('admin/users/dialog.delete-confirm.body', ['id' => $user->id, 'full_name' => $user->full_name]);
        }
        else
        {
            $error = trans('admin/users/general.error.cant-delete-yourself');
        }
        return view('modal_confirmation', compact('error', 'modal_route',
            'modal_title', 'modal_body', 'modal_cancel', 'modal_ok'));

    }

    /**
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function enable($id)
    {
        $user = $this->user->find($id);
        $user->enabled = true;
        $user->save();

        Flash::success(trans('admin/users/general.status.enabled'));

        return redirect('/admin/users');
    }

    /**
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function disable($id)
    {
        $user = $this->user->find($id);

        if (!$user->canBeDisabled())
        {
            Flash::error(trans('admin/users/general.error.cant-be-disabled'));
        }
        else
        {
            $user->enabled = false;
            $user->save();
            Flash::success(trans('admin/users/general.status.disabled'));
        }

        return redirect('/admin/users');
    }

    /**
     * @return \Illuminate\View\View
     */
    public function enableSelected(Request $request)
    {
        $chkUsers = $request->input('chkUser');

        if (isset($chkUsers))
        {
            foreach ($chkUsers as $user_id)
            {
                $user = $this->user->find($user_id);
                $user->enabled = true;
                $user->save();
            }
            Flash::success(trans('admin/users/general.status.global-enabled'));
        }
        else
        {
            Flash::warning(trans('admin/users/general.status.no-user-selected'));
        }
        return redirect('/admin/users');
    }

    /**
     * @return \Illuminate\View\View
     */
    public function disableSelected(Request $request)
    {
        $chkUsers = $request->input('chkUser');

        if (isset($chkUsers))
        {
            foreach ($chkUsers as $user_id)
            {
                $user = $this->user->find($user_id);
                if (!$user->canBeDisabled())
                {
                    Flash::error(trans('admin/users/general.error.cant-be-disabled'));
                }
                else
                {
                    $user->enabled = false;
                    $user->save();
                }
            }
            Flash::success(trans('admin/users/general.status.global-disabled'));
        }
        else
        {
            Flash::warning(trans('admin/users/general.status.no-user-selected'));
        }
        return redirect('/admin/users');
    }

    public function searchByName(Request $request)
    {
        $name = $request->input('query');
        $users = DB::table('users')
            ->select(DB::raw('id, first_name || " " || last_name || " (" || username || ")" as text'))
            ->where('first_name', 'like', "%$name%")
            ->orWhere('last_name', 'like', "%$name%")
            ->orWhere('username', 'like', "%$name%")
            ->get();
        return $users;
    }

    public function listByPage(Request $request)
    {
        $skipNumb = $request->input('s');
        $takeNumb = $request->input('t');

        $userCollection = \App\User::skip($skipNumb)->take($takeNumb)
            ->get(['id', 'first_name', 'last_name', 'username'])
            ->lists('full_name_and_username', 'id');
        $userList = $userCollection->all();

        return $userList;
    }


}