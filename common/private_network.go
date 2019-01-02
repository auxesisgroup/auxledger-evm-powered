// Jitender Private Network
package common

var (
	SuperAdmin = "SuperAdmin"
	Admin = "Admin"
	Others = "Others"
)

func IsValidRole(role string) bool{
	switch role {
	    case
	        SuperAdmin,
	        Admin,
	        Others:
	        return true
    }
    return false
}

func CanChangeState(role string) bool{
	if (role == SuperAdmin){
		return true
	}
	return false
}

func CanChangeRole(role string) bool{
	if (role == SuperAdmin){
		return true
	}
	return false
}