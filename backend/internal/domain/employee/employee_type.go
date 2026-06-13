package employee

import "fmt"

type Type string

const (
	Nurse         Type = "NURSE"
	NurseAssistant Type = "NURSE_ASSISTANT"
)

func (t Type) IsValid() bool {
	switch t {
	case Nurse, NurseAssistant:
		return true
	default:
		return false
	}
}

func ParseType(s string) (Type, error) {
	t := Type(s)
	if !t.IsValid() {
		return "", fmt.Errorf("invalid employee type: %s", s)
	}
	return t, nil
}
