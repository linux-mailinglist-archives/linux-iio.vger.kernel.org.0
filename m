Return-Path: <linux-iio+bounces-20589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E65AD8C69
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC91B3B3B08
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BD4C97;
	Fri, 13 Jun 2025 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KJs0gc79";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mgCxY3Nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4451275B19;
	Fri, 13 Jun 2025 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818834; cv=none; b=jv7CuYRZumuf0UCVyX3yztGzY5he3CYTgqgMkCVMoSJq9euyFYG6VXaI265dNfShQKS/VrIe6EYOK19ISfOa2GlIS5rWEfIU5PH4jWDlFSkYulXJIuMr7ErmnQta8z+Mob1btyobv9la6+54ndcpeTaEernkQ9Hw4Vc5M7La1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818834; c=relaxed/simple;
	bh=Gy4oKoECbGG0/YZTF4KITEXWhmk0r5T640qQNZbhaBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aWPDrswRPnBd1m2RCeLgbdDk47eJRkjOlpsCZSElEhl3CBseyFxEjBRSmsPM09EZL5TA2lCjAx4M2g3to+qTXBJWhl3CpmxBfIg0fvb9yAu7g1Sf/50DCx/UGNcXFyRenHNT39Z3r4wnTk6rAE3BY14/mgEYoHv8SCjYQah2ljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KJs0gc79; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mgCxY3Nu; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bJfL65DKXz9v78;
	Fri, 13 Jun 2025 14:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749818830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qT3DspTS00mYmQmoGpiLE6YPoKYxcQV+0TFL0LnFypU=;
	b=KJs0gc79ihiOTN7gcmx9PV4BccD9Qd4exr4T2BvXjKMAbMcBeaUyfLp8H7BXpbDQIbifyq
	jIj7sHC1AItK9w03v9COTQQro+4AMbn4ZdeVLFzzG3D3HtCoH3lD/YjAYEcv3QrwzY7dec
	R9x0K7418TROIlLY0a3OejVJL/ItETJJs8LtZSFhLNo64JEbgwUeL41QWaeZtVZsx7F2rl
	8HP14q/4DZdJsmKOXpOl0vbsdBoQCWmvSjmFXLHJ5eLx/wZWQPdoZn54Yf5EG0za+eTBMx
	/nXXoRCqVCVb4s1fycW5iJ4IZbO+zNqccm7otICyEA2hmV8NvFYR6jcJOTbCag==
From: Marek Vasut <marek.vasut+bmc150@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749818828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qT3DspTS00mYmQmoGpiLE6YPoKYxcQV+0TFL0LnFypU=;
	b=mgCxY3NuZhSPKYPMs6xIr+ALzffl3kPM8PWxN2NVFMXsmpyMth1Tr0l4tXNDbmTXfOs3sE
	yxGyeXWsNx9/CuQaN7CZJEP2hsvZK2/oEaA79ov0LmSv39y+g7MDIQzX4VvluQ70OZSmaN
	7YL50rkhmtyu3cbs/x7pc81vOyq22RgIX3CSPO1tYtfgkixqaQP+dd6n3Eez3QbvtGvjF9
	nQZR0C4eKC+a/f3S+M2TmnpfdFEUIfZ98dTgtz14+KOY39SHxy07DPVGRvsb/REih+QqKO
	2Wd7j2kpHFblCgC5cSweXGaxenKNEgnF3fsRd6jQMP7YqYlUgysIxk3cb34Onw==
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no IRQ connected
Date: Fri, 13 Jun 2025 14:45:22 +0200
Message-ID: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 38f3b48b2f101af85bd
X-MBO-RS-META: zbtfkwrk3irdjp6deencctkpx9e34pm4
X-Rspamd-Queue-Id: 4bJfL65DKXz9v78

The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
which leads to bmc150_accel_core_probe() being called with irq=3D0, which
leads to bmc150_accel_interrupts_setup() never being called, which leads
to struct bmc150_accel_data *data ->interrupts[i].info being left unset
to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt=
()
which depends on struct bmc150_accel_data *data ->interrupts[i].info being
non-NULL, and which triggers NULL pointer dereference. This is triggered
e.g. from iio-sensor-proxy.

Fix this by skipping the IRQ register configuration in case there is no
IRQ connected in hardware, in a manner similar to what the driver did in
the very first commit which added the driver.

ACPI table dump:
"
$ acpidump > acpi.dat && acpixtract -sDSDT acpi.dat && iasl -d dsdt.dat
$ grep -A 30 -B 3 BOSC0200 dsdt.dsl
        Device (BMA2)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "BOSC0200")  // _HID: Hardware ID
            Name (_CID, "BOSC0200")  // _CID: Compatible ID
            Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
            Name (_UID, One)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Sett=
ings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
                        AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                        0x00, ResourceConsumer, , Exclusive,
                        )
                })
                Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
            }

            Method (ROTM, 0, NotSerialized)
            {
                Name (SBUF, Package (0x03)
                {
                    "0 1 0",
                    "1 0 0 ",
                    "0 0 1"
                })
                Return (SBUF) /* \_SB_.PCI0.I2C0.BMA2.ROTM.SBUF */
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }
"

Splat, collected from debian unstable, probably not very useful:
"
  BUG: kernel NULL pointer dereference, address: 0000000000000001
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 3 UID: 0 PID: 960 Comm: iio-sensor-prox Not tainted 6.12.22-amd64 #1=
  Debian 6.12.22-1
  Hardware name: Default string Default string/Default string, BIOS 5.12 03=
/04/2019
  RIP: 0010:bmc150_accel_set_interrupt+0x68/0x120 [bmc150_accel_core]
  Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f c1 10 83 c2 01 83 fa 01 7f 64 4=
9 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89 c3 85 c0 75 52 <41> 0f b6 55 01=
 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c 24 6a 00
  RSP: 0018:ffff9aba00f4bb40 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffff01
  RDX: ffffffff9b526790 RSI: 0000000000000202 RDI: ffff8aff20a97504
  RBP: ffff8aff20a97420 R08: ffff8aff02a753e8 R09: 0000000000000000
  R10: ffff9aba00f4bb58 R11: 0000000000000009 R12: ffff8aff02a75550
  R13: 0000000000000000 R14: 0000000000000001 R15: ffff8aff02a75330
  FS:  00007fc47005c940(0000) GS:ffff8b0066d80000(0000) knlGS:0000000000000=
000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000001 CR3: 0000000109218001 CR4: 00000000003726f0
  Call Trace:
   <TASK>
   ? __die_body.cold+0x19/0x27
   ? page_fault_oops+0x15c/0x2e0
   ? exc_page_fault+0x7e/0x180
   ? asm_exc_page_fault+0x26/0x30
   ? rpm_resume+0x310/0x700
   ? bmc150_accel_set_interrupt+0x68/0x120 [bmc150_accel_core]
   bmc150_accel_buffer_postenable+0x5d/0x90 [bmc150_accel_core]
   __iio_update_buffers+0x731/0xb20 [industrialio]
   enable_store+0x84/0xe0 [industrialio]
   kernfs_fop_write_iter+0x13b/0x1f0
   vfs_write+0x28d/0x450
   ksys_write+0x6d/0xf0
   do_syscall_64+0x82/0x190
   ? xas_load+0xd/0xd0
   ? xa_load+0x7b/0xb0
   ? __memcg_slab_free_hook+0xf7/0x140
   ? __x64_sys_close+0x3c/0x80
   ? kmem_cache_free+0x3ee/0x440
   ? syscall_exit_to_user_mode+0x4d/0x210
   ? do_syscall_64+0x8e/0x190
   ? syscall_exit_to_user_mode+0x4d/0x210
   ? do_syscall_64+0x8e/0x190
   ? do_syscall_64+0x8e/0x190
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fc4704629ee
  Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4=
d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f=
 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
  RSP: 002b:00007ffd598afd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007fc47005c940 RCX: 00007fc4704629ee
  RDX: 0000000000000001 RSI: 00007ffd598afec0 RDI: 0000000000000009
  RBP: 00007ffd598afec0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
  R13: 000055680df28490 R14: 00007fc4705ade80 R15: 0000000000000001
   </TASK>
  Modules linked in: rfcomm cmac algif_hash algif_skcipher af_alg bnep snd_=
sof_pci_intel_skl snd_sof_intel_hda_generic soundwire_intel soundwire_gener=
ic_allocation soundwire_cadence snd_sof_intel_hda_common snd_soc_hdac_hda s=
nd_sof_intel_hda_mlink snd_sof_intel_hda binfmt_misc snd_sof_pci snd_sof_xt=
ensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_match snd_soc_acpi soundw=
ire_bus nls_ascii intel_uncore_frequency intel_uncore_frequency_common iwlm=
vm snd_soc_avs nls_cp437 vfat fat snd_hda_codec_hdmi snd_soc_hda_codec snd_=
hda_ext_core x86_pkg_temp_thermal snd_hda_codec_realtek snd_soc_core intel_=
powerclamp mac80211 snd_hda_codec_generic snd_compress snd_hda_scodec_compo=
nent snd_pcm_dmaengine coretemp ext4 snd_hda_intel kvm_intel snd_intel_dspc=
fg snd_intel_sdw_acpi snd_hda_codec btusb libarc4 mei_hdcp mei_pxp iwlwifi =
btrtl mbcache snd_hda_core jbd2 kvm intel_rapl_msr btintel btbcm joydev btm=
tk snd_hwdep rapl cfg80211 snd_pcm snd_timer bluetooth intel_cstate snd pro=
cessor_thermal_device_pci_legacy intel_uncore
   processor_thermal_device processor_thermal_wt_hint pcspkr mei_me process=
or_thermal_rfim processor_thermal_rapl intel_rapl_common rfkill intel_wmi_t=
hunderbolt soundcore mei crc16 bmc150_accel_i2c processor_thermal_wt_req bm=
c150_accel_core intel_pch_thermal processor_thermal_power_floor processor_t=
hermal_mbox intel_soc_dts_iosf intel_xhci_usb_role_switch goodix_ts industr=
ialio_triggered_buffer roles kfifo_buf industrialio int3403_thermal intel_p=
mc_core int340x_thermal_zone soc_button_array ac intel_vsec int3400_thermal=
 pmt_telemetry acpi_pad acpi_thermal_rel pmt_class evdev msr efi_pstore con=
figfs nfnetlink efivarfs ip_tables x_tables autofs4 btrfs blake2b_generic x=
or raid6_pq libcrc32c crc32c_generic dm_crypt dm_mod hid_generic usbhid hid=
 i915 drm_buddy i2c_algo_bit drm_display_helper cec rc_core crct10dif_pclmu=
l ttm crc32_pclmul crc32c_intel ghash_clmulni_intel drm_kms_helper sha512_s=
sse3 nvme sha256_ssse3 sha1_ssse3 nvme_core xhci_pci sdhci_pci drm xhci_hcd=
 cqhci iTCO_wdt sdhci intel_pmc_bxt
   iTCO_vendor_support aesni_intel watchdog gf128mul crypto_simd usbcore cr=
yptd nvme_auth serio_raw mmc_core i2c_i801 intel_lpss_pci i2c_smbus intel_l=
pss usb_common idma64 video battery wmi button
  CR2: 0000000000000001
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:bmc150_accel_set_interrupt+0x68/0x120 [bmc150_accel_core]
  Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f c1 10 83 c2 01 83 fa 01 7f 64 4=
9 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89 c3 85 c0 75 52 <41> 0f b6 55 01=
 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c 24 6a 00
  RSP: 0018:ffff9aba00f4bb40 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000ffffff01
  RDX: ffffffff9b526790 RSI: 0000000000000202 RDI: ffff8aff20a97504
  RBP: ffff8aff20a97420 R08: ffff8aff02a753e8 R09: 0000000000000000
  R10: ffff9aba00f4bb58 R11: 0000000000000009 R12: ffff8aff02a75550
  R13: 0000000000000000 R14: 0000000000000001 R15: ffff8aff02a75330
  FS:  00007fc47005c940(0000) GS:ffff8b0066d80000(0000) knlGS:0000000000000=
000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000001 CR3: 0000000109218001 CR4: 00000000003726f0
  note: iio-sensor-prox[960] exited with irqs disabled
"

Fixes: 8e22f477e143 ("iio: bmc150: refactor interrupt enabling")
Signed-off-by: Marek Vasut <marek.vasut+bmc150@mailbox.org>
---
Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/accel/bmc150-accel-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc1=
50-accel-core.c
index 744a034bb8b5..1c3583ade2b4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150_acc=
el_data *data, int i,
 	if (ret < 0)
 		return ret;
=20
+	if (!info)
+		return 0;
+
 	/* map the interrupt to the appropriate pins */
 	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bitmask,
 				 (state ? info->map_bitmask : 0));
--=20
2.47.2


