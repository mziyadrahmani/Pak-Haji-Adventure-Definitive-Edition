@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeNoiseWorley3dFractal

func _init():
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2.0)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.3)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(8, 1.0)
	set_input_port_default_value(9, false)
	set_input_port_default_value(10, 0.0)

func _get_name() -> String:
	return "FractalWorleyNoise3D"

func _get_category() -> String:
	return "RGBA"

func _get_subcategory() -> String:
	return "NoiseFractal"

func _get_description() -> String:
	return "Fractal WorleyNoise3D"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 11

func _get_input_port_name(port: int):
	match port:
		0:
			return "uv"
		1:
			return "octaves"
		2:
			return "period"
		3:
			return "lacunarity"
		4:
			return "persistence"
		5:
			return "angle"
		6:
			return "amplitude"
		7:
			return "shift"
		8:
			return "jitter"
		9:
			return "use_F2"
		10:
			return "time"

func _get_input_port_type(port: int):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_SCALAR
		7:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		8:
			return VisualShaderNode.PORT_TYPE_SCALAR
		9:
			return VisualShaderNode.PORT_TYPE_BOOLEAN
		10:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(port: int) -> String:
	return "result"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(mode):
	var code : String = preload("worley3d_fractal.gdshaderinc").code
	return code

func _get_code(input_vars, output_vars, mode, type):
	var uv = "UV"
	
	if input_vars[0]:
		uv = input_vars[0]
	
	return "%s = _cellularNoise3DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy, %s, %s, %s);" % [
			output_vars[0], uv, input_vars[1], input_vars[2], input_vars[3], input_vars[4],
			input_vars[5], input_vars[6], input_vars[7], input_vars[8], input_vars[9], input_vars[10]]
