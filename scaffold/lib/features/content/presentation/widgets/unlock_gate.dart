import 'package:flutter/material.dart';

class UnlockGate extends StatefulWidget {
  const UnlockGate({
    required this.title,
    required this.onSubmit,
    super.key,
  });

  final String title;

  final bool Function(String code) onSubmit;

  @override
  State<UnlockGate> createState() => _UnlockGateState();
}

class _UnlockGateState extends State<UnlockGate> {
  final _controller = TextEditingController();
  bool _error = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final ok = widget.onSubmit(_controller.text);
    if (!ok) setState(() => _error = true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 56),
            const SizedBox(height: 16),
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Unlock code',
                errorText: _error ? 'Incorrect code' : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) {
                if (_error) setState(() => _error = false);
              },
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _submit, child: const Text('Unlock')),
          ],
        ),
      ),
    );
  }
}
