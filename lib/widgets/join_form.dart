import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

enum JoinFormType { service, department }

/// Call this to open the form as a dialog overlay.
void showJoinForm(BuildContext context, {JoinFormType initial = JoinFormType.service}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (_) => _JoinFormDialog(initialType: initial),
  );
}

class _JoinFormDialog extends StatefulWidget {
  final JoinFormType initialType;
  const _JoinFormDialog({required this.initialType});

  @override
  State<_JoinFormDialog> createState() => _JoinFormDialogState();
}

class _JoinFormDialogState extends State<_JoinFormDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  final _formKey = GlobalKey<FormState>();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _messageFocus = FocusNode();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  late JoinFormType _selectedType;
  String? _selectedDept;
  bool _submitted = false;

  static const _departments = [
    'Choir & Worship Team',
    'Ushering Department',
    'Media & AV Production',
    'Children\'s Ministry',
    'Prayer Department',
    'Youth & Young Adults',
  ];

  static const _services = [
    'Bible Studies — Tuesdays 7:00pm',
    'Prophetic Service — Thursdays 7:00pm',
    'Testimony Hour — Fridays 7:00pm',
    'Jabez Hour — Saturdays 7:00am',
    'Glory Service — Sundays 8:00am',
  ];

  String? _selectedService;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _messageFocus.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
    }
  }

  void _closeDialog() {
    _ctrl.reverse().then((_) {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return FadeTransition(
      opacity: _fade,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: mobile ? 16 : 40,
          vertical: mobile ? 24 : 40,
        ),
        child: ScaleTransition(
          scale: _scale,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: mobile ? double.infinity : 620,
              maxHeight: MediaQuery.of(context).size.height * 0.92,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: _submitted ? _buildSuccess() : _buildForm(mobile),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool mobile) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.navyDark, AppTheme.navy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(32, 28, 20, 28),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.teal.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.church_rounded,
                      color: AppTheme.teal, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedType == JoinFormType.service
                            ? 'Join Us This Weekend'
                            : 'Join a Department',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'God Alone International Ministry',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: AppTheme.teal,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _closeDialog,
                  icon: const Icon(Icons.close_rounded,
                      color: Colors.white70, size: 22),
                ),
              ],
            ),
          ),

          // Form type toggle
          Container(
            color: AppTheme.altBg,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              children: [
                _TypeToggle(
                  label: 'Join a Service',
                  icon: Icons.event_available_rounded,
                  selected: _selectedType == JoinFormType.service,
                  onTap: () => setState(() => _selectedType = JoinFormType.service),
                ),
                const SizedBox(width: 12),
                _TypeToggle(
                  label: 'Join a Department',
                  icon: Icons.groups_rounded,
                  selected: _selectedType == JoinFormType.department,
                  onTap: () =>
                      setState(() => _selectedType = JoinFormType.department),
                ),
              ],
            ),
          ),

          // Scrollable form fields
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 28, 32, 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    _FormField(
                      label: 'Full Name',
                      hint: 'e.g. John Mensah',
                      controller: _nameCtrl,
                      focusNode: _nameFocus,
                      nextFocus: _emailFocus,
                      icon: Icons.person_rounded,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 20),

                    // Email
                    _FormField(
                      label: 'Email Address',
                      hint: 'e.g. john@example.com',
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      nextFocus: _phoneFocus,
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(v)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Phone
                    _FormField(
                      label: 'Phone Number',
                      hint: 'e.g. +233 54 591 3298',
                      controller: _phoneCtrl,
                      focusNode: _phoneFocus,
                      icon: Icons.phone_rounded,
                      keyboardType: TextInputType.phone,
                      required: false,
                    ),
                    const SizedBox(height: 20),

                    // Conditional dropdown
                    if (_selectedType == JoinFormType.service) ...[
                      _DropdownField<String>(
                        label: 'Which Service?',
                        hint: 'Select a service',
                        icon: Icons.calendar_today_rounded,
                        value: _selectedService,
                        items: _services,
                        onChanged: (v) => setState(() => _selectedService = v),
                        validator: (v) =>
                            v == null ? 'Please select a service' : null,
                      ),
                    ] else ...[
                      _DropdownField<String>(
                        label: 'Which Department?',
                        hint: 'Select a department',
                        icon: Icons.groups_rounded,
                        value: _selectedDept,
                        items: _departments,
                        onChanged: (v) => setState(() => _selectedDept = v),
                        validator: (v) =>
                            v == null ? 'Please select a department' : null,
                      ),
                    ],
                    const SizedBox(height: 20),

                    // Message
                    _FormField(
                      label: 'Message / Prayer Request',
                      hint: 'Share anything you\'d like us to know…',
                      controller: _messageCtrl,
                      focusNode: _messageFocus,
                      icon: Icons.chat_bubble_rounded,
                      maxLines: 3,
                      required: false,
                    ),
                    const SizedBox(height: 32),

                    // Submit
                    SizedBox(
                      width: double.infinity,
                      child: AppTheme.primaryButton(
                        text: _selectedType == JoinFormType.service
                            ? 'REGISTER FOR SERVICE'
                            : 'SUBMIT APPLICATION',
                        onPressed: _submit,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'We\'ll reach out to you within 24 hours.',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                          color: AppTheme.lightText,
                        ),
                      ),
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

  Widget _buildSuccess() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.teal.withValues(alpha: 0.12),
            ),
            child: const Icon(Icons.check_circle_rounded,
                color: AppTheme.teal, size: 48),
          ),
          const SizedBox(height: 28),
          Text(
            'You\'re All Set!',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppTheme.navyDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _selectedType == JoinFormType.service
                ? 'Thank you, ${_nameCtrl.text.trim().split(' ').first}! We\'ve received your registration and look forward to seeing you at our service.'
                : 'Thank you, ${_nameCtrl.text.trim().split(' ').first}! Your department application has been submitted. We\'ll be in touch soon.',
            style: AppTheme.bodyLarge(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'A confirmation will be sent to ${_emailCtrl.text}.',
            style: GoogleFonts.nunito(
              fontSize: 13,
              color: AppTheme.lightText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTheme.outlinedButton(
                text: 'CLOSE',
                onPressed: _closeDialog,
              ),
              const SizedBox(width: 16),
              AppTheme.primaryButton(
                text: 'FILL ANOTHER',
                onPressed: () => setState(() {
                  _submitted = false;
                  _nameCtrl.clear();
                  _emailCtrl.clear();
                  _phoneCtrl.clear();
                  _messageCtrl.clear();
                  _selectedService = null;
                  _selectedDept = null;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _TypeToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeToggle({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: selected ? AppTheme.teal : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? AppTheme.teal : AppTheme.divider,
              width: 1.5,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppTheme.teal.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16,
                  color: selected ? Colors.white : AppTheme.bodyText),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppTheme.bodyText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool required;
  final String? Function(String?)? validator;

  const _FormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.focusNode,
    this.nextFocus,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.required = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.navyDark,
                letterSpacing: 0.3,
              ),
            ),
            if (!required) ...[
              const SizedBox(width: 6),
              Text(
                'optional',
                style: GoogleFonts.nunito(
                  fontSize: 11,
                  color: AppTheme.lightText,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction:
              nextFocus != null ? TextInputAction.next : TextInputAction.done,
          onFieldSubmitted: (_) {
            if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
          },
          validator: validator ??
              (required
                  ? (v) =>
                      (v == null || v.trim().isEmpty) ? '$label is required' : null
                  : null),
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: AppTheme.darkText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.nunito(
              fontSize: 14,
              color: AppTheme.lightText,
            ),
            prefixIcon: Icon(icon, color: AppTheme.teal, size: 20),
            filled: true,
            fillColor: AppTheme.lightBg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.divider, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.divider, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.teal, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final T? value;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const _DropdownField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.navyDark,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          initialValue: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppTheme.teal, size: 20),
            hintText: hint,
            hintStyle: GoogleFonts.nunito(
              fontSize: 14,
              color: AppTheme.lightText,
            ),
            filled: true,
            fillColor: AppTheme.lightBg,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.divider, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.divider, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.teal, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          style: GoogleFonts.nunito(
            fontSize: 15,
            color: AppTheme.darkText,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(item.toString()),
                  ))
              .toList(),
          onChanged: onChanged,
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: AppTheme.bodyText),
        ),
      ],
    );
  }
}
