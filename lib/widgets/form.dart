import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nisController,
      namaController,
      tpLahirController,
      tgLahirController,
      kelaminController,
      agamaController,
      alamatController;

  AppForm({
    required this.formKey,
    required this.nisController,
    required this.namaController,
    required this.tpLahirController,
    required this.tgLahirController,
    required this.kelaminController,
    required this.agamaController,
    required this.alamatController,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  final List<String> kelaminItems = [
    "",
    "Laki-laki",
    "Perempuan",
  ];

  final List<String> agamaItems = [
    "",
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Khonghucu",
    "Kepercayaan",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          txtNis(),
          const SizedBox(height: 15),
          txtNama(),
          const SizedBox(height: 15),
          txtTempatLahir(),
          const SizedBox(height: 15),
          txtTanggalLahir(),
          const SizedBox(height: 15),
          tbKelamin(),
          const SizedBox(height: 15),
          tbAgama(),
          const SizedBox(height: 15),
          txtAlamat(),
        ],
      ),
    );
  }

  txtNis() {
    return TextFormField(
      controller: widget.nisController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NIS",
        prefixIcon: const Icon(Icons.card_membership),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan NIS' : null,
    );
  }

  txtNama() {
    return TextFormField(
      controller: widget.namaController,
      decoration: InputDecoration(
        labelText: "Nama Siswa",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Nama Siswa' : null,
    );
  }

  txtTempatLahir() {
    return TextFormField(
      controller: widget.tpLahirController,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Tempat Lahir' : null,
    );
  }

  txtTanggalLahir() {
    return TextFormField(
      controller: widget.tgLahirController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Tanggal Lahir",
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            widget.tgLahirController.text = formattedDate;
          });
        }
      },
      validator: (value) => value!.isEmpty ? 'Pilih Tanggal Lahir' : null,
    );
  }

  tbKelamin() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Jenis Kelamin",
        prefixIcon: const Icon(Icons.people),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: widget.kelaminController.text.isNotEmpty
          ? widget.kelaminController.text
          : null,
      items: kelaminItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.kelaminController.text = value.toString();
        });
      },
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Pilih Jenis Kelamin' : null,
    );
  }

  tbAgama() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Agama",
        prefixIcon: const Icon(Icons.mosque),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: widget.agamaController.text.isNotEmpty
          ? widget.agamaController.text
          : null,
      items: agamaItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.agamaController.text = value.toString();
        });
      },
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Pilih Agama' : null,
    );
  }

  txtAlamat() {
    return TextFormField(
      controller: widget.alamatController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "Alamat",
        prefixIcon: const Icon(Icons.home),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Alamat' : null,
    );
  }
}