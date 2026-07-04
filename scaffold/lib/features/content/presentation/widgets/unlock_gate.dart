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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: BackButton(color: scheme.onSurface),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.lock_outline,
                          size: 30, color: scheme.onSurface),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Enter your code',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28),
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                      decoration: InputDecoration(
                        hintText: 'Unlock code',
                        errorText: _error ? 'Incorrect code' : null,
                      ),
                      onChanged: (_) {
                        if (_error) setState(() => _error = false);
                      },
                      onSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _submit,
                      child: const Text('Unlock'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
