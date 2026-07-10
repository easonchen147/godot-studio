class_name Helpers
extends RefCounted

static func safe_queue_free(node: Node) -> void:
	if is_instance_valid(node) and not node.is_queued_for_deletion():
		node.call_deferred("queue_free")

