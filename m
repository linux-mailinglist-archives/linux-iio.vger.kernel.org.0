Return-Path: <linux-iio+bounces-26105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45098C44352
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7141B1881DAF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEFB303A3C;
	Sun,  9 Nov 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t83T8c7u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CE303CA2
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708048; cv=none; b=KKqakWLmK+8cHT6L9raNCGBh+KlOLqa8MFtSOSH3ORf5SQuPLbkReoOMzfsWIuvCWcwSbrqCvoyrfTEH5zKUbZLDAuMxtGNJqwHXangKoOqYQZhdrr0zXvlC9dRrKaMMBmZUkqJG3qcEYEFboEKNSDT0xmstbaR/My9oEX/6iT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708048; c=relaxed/simple;
	bh=90TeX3iAXvNIobyeHZV8tZssMIEmruUffb0nYFZMXko=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ikI+TrG4gDJNSv9TqSKpYABRVoilGBIXR/Cm1kJHWXXpyrQVOMcAOLMGGdnOq5i847hOzjNVXcKDL1L82/XEokD21cpcTrLR5O3n7RNxkL8tuO0RbuL6ZCkgsjB5GllrxfjLUpMfAiwpPExBGj120sZ4QWxDi3jEinLGiCWc8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t83T8c7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C25BC4CEF8
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708048;
	bh=90TeX3iAXvNIobyeHZV8tZssMIEmruUffb0nYFZMXko=;
	h=From:To:Subject:Date:From;
	b=t83T8c7u+s+igZ0XnVaamN1AjuuoJCKRhjmIko134d8gv5jtrxplS4FK6QtkbkEBj
	 OEQjeIR0a/JO/Qm9BAGJjYPMshU8i1zmHy8jekSfptzeagubLY4Iq6XZPgesjsPDdG
	 tBEIGWm2nlWd3Sq5EgIR4HUvdFXIVacdSwkx3fx80v4KGw3lmW7S1s9twSnPBy3dXq
	 fdY4Qv+3+tvcBk1LwTbxsyoqcs8H/WXGsHpSSWDhApDhQDnQR6ruqE0FF4jxxFiaQ9
	 gtyARhrXvH8iAwT1sxa7fTP+OgkrSQkUMIOmkHtaF+Aut59x3+Spbi6jN0nzhZ/fbS
	 iaZdMTEoeSEAw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E2BFC3279F; Sun,  9 Nov 2025 17:07:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] New: NULL pointer dereference in bmc150-accel-core
Date: Sun, 09 Nov 2025 17:07:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: highwaystar.ru@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220772-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220772

            Bug ID: 220772
           Summary: NULL pointer dereference in bmc150-accel-core
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: highwaystar.ru@gmail.com
        Regression: No

I faced NULL pointer dereference in bmc150-accel-core module trying recent
distros on my Zwide NA08H notebook (2 in 1).=20

On Fedora 43 with both with live media kernel and installed latest update I
have this crash:

[Thu Nov  6 22:36:44 2025] BUG: kernel NULL pointer dereference, address:
0000000000000001
[Thu Nov  6 22:36:44 2025] #PF: supervisor read access in kernel mode
[Thu Nov  6 22:36:44 2025] #PF: error_code(0x0000) - not-present page
[Thu Nov  6 22:36:44 2025] PGD 0 P4D 0=20
[Thu Nov  6 22:36:44 2025] Oops: Oops: 0000 [#1] SMP NOPTI
[Thu Nov  6 22:36:44 2025] CPU: 1 UID: 0 PID: 727 Comm: iio-sensor-prox
Tainted: G        W           6.17.7-300.fc43.x86_64 #1 PREEMPT(lazy)=20
[Thu Nov  6 22:36:44 2025] Tainted: [W]=3DWARN
[Thu Nov  6 22:36:44 2025] Hardware name: ShenZhen ZhiWei Technology Co.,Ltd
NA08H/Zwide Inc., BIOS 5.27 09/11/2025
[Thu Nov  6 22:36:44 2025] RIP: 0010:bmc150_accel_set_interrupt+0x73/0x140
[bmc150_accel_core]
[Thu Nov  6 22:36:44 2025] Code: 84 83 00 00 00 b8 01 00 00 00 f0 0f c1 06 =
83
c0 01 83 f8 01 7f 5f 49 8b 3c 24 be 01 00 00 00 e8 83 fa ff ff 89 c5 85 c0 =
75
4d <0f> b6 53 01 0f b6 33 45 31 c9 45 31 c0 49 8b 3c 24 6a 00 89 d1 e8
[Thu Nov  6 22:36:44 2025] RSP: 0018:ffffd0bf0249bb58 EFLAGS: 00010246
[Thu Nov  6 22:36:44 2025] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00000000ffffff01
[Thu Nov  6 22:36:44 2025] RDX: ffffffffa19cd465 RSI: 0000000000000202 RDI:
ffff8d10c3387904
[Thu Nov  6 22:36:44 2025] RBP: 0000000000000000 R08: 0000000000000000 R09:
ffff8d10c72e7800
[Thu Nov  6 22:36:44 2025] R10: 0000000000000000 R11: fffff0f5041263c0 R12:
ffff8d10c19da578
[Thu Nov  6 22:36:44 2025] R13: ffff8d10c19da338 R14: ffff8d10c3387820 R15:
ffff8d10c19da000
[Thu Nov  6 22:36:44 2025] FS:  00007f5de518f980(0000)
GS:ffff8d148b8c4000(0000) knlGS:0000000000000000
[Thu Nov  6 22:36:44 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Nov  6 22:36:44 2025] CR2: 0000000000000001 CR3: 0000000109d33001 CR4:
0000000000f72ef0
[Thu Nov  6 22:36:44 2025] PKRU: 55555554
[Thu Nov  6 22:36:44 2025] Call Trace:
[Thu Nov  6 22:36:44 2025]  <TASK>
[Thu Nov  6 22:36:44 2025]  ? __pm_runtime_resume+0x5f/0x90
[Thu Nov  6 22:36:44 2025]  bmc150_accel_buffer_postenable+0x5e/0xa0
[bmc150_accel_core]
[Thu Nov  6 22:36:44 2025]  iio_enable_buffers+0x172/0x2c0 [industrialio]
[Thu Nov  6 22:36:44 2025]  __iio_update_buffers+0x237/0x2e0 [industrialio]
[Thu Nov  6 22:36:44 2025]  enable_store+0x81/0xe0 [industrialio]
[Thu Nov  6 22:36:44 2025]  kernfs_fop_write_iter+0x14a/0x200
[Thu Nov  6 22:36:44 2025]  vfs_write+0x25a/0x480
[Thu Nov  6 22:36:44 2025]  ksys_write+0x73/0xf0
[Thu Nov  6 22:36:44 2025]  do_syscall_64+0x7e/0x250
[Thu Nov  6 22:36:44 2025]  ? do_sys_openat2+0xa2/0xe0
[Thu Nov  6 22:36:44 2025]  ? __x64_sys_openat+0x61/0xa0
[Thu Nov  6 22:36:44 2025]  ? do_syscall_64+0xb6/0x250
[Thu Nov  6 22:36:44 2025]  ? __x64_sys_openat+0x61/0xa0
[Thu Nov  6 22:36:44 2025]  ? do_syscall_64+0xb6/0x250
[Thu Nov  6 22:36:44 2025]  ? __x64_sys_close+0x3d/0x80
[Thu Nov  6 22:36:44 2025]  ? do_syscall_64+0xb6/0x250
[Thu Nov  6 22:36:44 2025]  ? irqentry_exit_to_user_mode+0x2c/0x1c0
[Thu Nov  6 22:36:44 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[Thu Nov  6 22:36:44 2025] RIP: 0033:0x7f5de5531982
[Thu Nov  6 22:36:44 2025] Code: 08 0f 85 21 42 ff ff 49 89 fb 48 89 f0 48 =
89
d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 =
0f
05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[Thu Nov  6 22:36:44 2025] RSP: 002b:00007ffc4668e6a8 EFLAGS: 00000246
ORIG_RAX: 0000000000000001
[Thu Nov  6 22:36:44 2025] RAX: ffffffffffffffda RBX: 000056444a53a5b0 RCX:
00007f5de5531982
[Thu Nov  6 22:36:44 2025] RDX: 0000000000000001 RSI: 00007ffc4668e870 RDI:
0000000000000009
[Thu Nov  6 22:36:44 2025] RBP: 00007ffc4668e6d0 R08: 0000000000000000 R09:
0000000000000000
[Thu Nov  6 22:36:44 2025] R10: 0000000000000000 R11: 0000000000000246 R12:
0000000000000001
[Thu Nov  6 22:36:44 2025] R13: 0000000000000001 R14: 00007ffc4668e870 R15:
0000000000000002
[Thu Nov  6 22:36:44 2025]  </TASK>
[Thu Nov  6 22:36:44 2025] Modules linked in: sunrpc snd_hda_codec_intelhdmi
snd_hda_codec_alc269 snd_hda_scodec_component snd_hda_codec_realtek_lib
snd_hda_codec_generic snd_hda_intel bnep snd_sof_pci_intel_tgl
snd_sof_pci_intel_cnl snd_sof_intel_hda_generic soundwire_intel
snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common snd_soc_hdac_hda
snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hdmi soundwire_cade=
nce
snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_acpi_intel_mat=
ch
intel_rapl_msr intel_rapl_common snd_soc_acpi_intel_sdca_quirks
soundwire_generic_allocation snd_soc_acpi crc8 soundwire_bus
x86_pkg_temp_thermal intel_powerclamp coretemp snd_soc_sdca iTCO_wdt kvm_in=
tel
spi_nor intel_pmc_bxt mtd mei_hdcp iTCO_vendor_support mei_pxp joydev
snd_soc_avs kvm snd_soc_hda_codec snd_hda_ext_core snd_hda_codec iwlmvm
snd_hda_core irqbypass rapl snd_intel_dspcfg snd_usb_audio(+)
snd_intel_sdw_acpi mac80211 snd_usbmidi_lib intel_cstate snd_soc_core snd_h=
wdep
snd_ump snd_rawmidi snd_compress ac97_bus snd_pcm_dmaengine
[Thu Nov  6 22:36:44 2025]  libarc4 intel_uncore wmi_bmof snd_seq
snd_seq_device pcspkr uvcvideo snd_pcm spi_intel_pci uvc videobuf2_vmalloc
videobuf2_memops i2c_i801 iwlwifi videobuf2_v4l2 bmi323_i2c bmi323_core
spi_intel i2c_smbus snd_timer vfat videobuf2_common snd fat videodev soundc=
ore
cfg80211 mei_me mc mei idma64 bmc150_accel_i2c igen6_edac bmc150_accel_core
industrialio_triggered_buffer kfifo_buf industrialio goodix_ts intel_pmc_co=
re
pmt_telemetry pmt_discovery soc_button_array pmt_class intel_hid
intel_pmc_ssram_telemetry acpi_tad sparse_keymap acpi_pad btusb btrtl btint=
el
btbcm btmtk bluetooth rfkill loop nfnetlink zram lz4hc_compress lz4_compres=
s xe
drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpuvm drm_exec i915 nvme
sdhci_pci sdhci_uhs2 polyval_clmulni ghash_clmulni_intel sdhci i2c_algo_bit
intel_ish_ipc nvme_core drm_buddy cqhci ttm nvme_keyring mmc_core nvme_auth
spi_pxa2xx_platform drm_display_helper intel_ishtp dw_dmac intel_vsec
spi_pxa2xx_core cec video intel_oc_wdt wmi pinctrl_alderlake serio_raw fuse
i2c_dev

[Thu Nov  6 22:36:44 2025] CR2: 0000000000000001
[Thu Nov  6 22:36:44 2025] ---[ end trace 0000000000000000 ]---
[Thu Nov  6 22:36:44 2025] RIP: 0010:bmc150_accel_set_interrupt+0x73/0x140
[bmc150_accel_core]
[Thu Nov  6 22:36:44 2025] Code: 84 83 00 00 00 b8 01 00 00 00 f0 0f c1 06 =
83
c0 01 83 f8 01 7f 5f 49 8b 3c 24 be 01 00 00 00 e8 83 fa ff ff 89 c5 85 c0 =
75
4d <0f> b6 53 01 0f b6 33 45 31 c9 45 31 c0 49 8b 3c 24 6a 00 89 d1 e8
[Thu Nov  6 22:36:44 2025] RSP: 0018:ffffd0bf0249bb58 EFLAGS: 00010246
[Thu Nov  6 22:36:44 2025] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
00000000ffffff01
[Thu Nov  6 22:36:44 2025] RDX: ffffffffa19cd465 RSI: 0000000000000202 RDI:
ffff8d10c3387904
[Thu Nov  6 22:36:44 2025] RBP: 0000000000000000 R08: 0000000000000000 R09:
ffff8d10c72e7800
[Thu Nov  6 22:36:44 2025] R10: 0000000000000000 R11: fffff0f5041263c0 R12:
ffff8d10c19da578
[Thu Nov  6 22:36:44 2025] R13: ffff8d10c19da338 R14: ffff8d10c3387820 R15:
ffff8d10c19da000
[Thu Nov  6 22:36:44 2025] FS:  00007f5de518f980(0000)
GS:ffff8d148b8c4000(0000) knlGS:0000000000000000
[Thu Nov  6 22:36:44 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

On ubuntu 25.10 same issue:

[ 21.752391] BUG: kernel NULL pointer dereference, address: 0000000000000001
[ 21.752398] #PF: supervisor read access in kernel mode
[ 21.752400] #PF: error_code(0x0000) - not-present page
[ 21.752402] PGD 0 P4D 0
[ 21.752405] Oops: Oops: 0000 [#1] SMP NOPTI
[ 21.752410] CPU: 3 UID: 0 PID: 1154 Comm: iio-sensor-prox Not tainted
6.17.0-5-generic #5-Ubuntu PREEMPT(voluntary)
[ 21.752413] Hardware name: ShenZhen ZhiWei Technology Co.,Ltd NA08H/Zwide
Inc., BIOS 5.27 09/11/2025
[ 21.752415] RIP: 0010:bmc150_accel_set_interrupt+0x7a/0x160
[bmc150_accel_core]
[ 21.752424] Code: 98 00 00 00 b8 01 00 00 00 f0 0f c1 06 83 c0 01 83 f8 01=
 7f
62 49 8b 7d 00 be 01 00 00 00 e8 8d fa ff ff 41 89 c4 85 c0 75 50 <0f> b6 5=
3 01
0f b6 33 45 31 c9 45 31 c0 49 8b 7d 00 6a 00 89 d1 e8
[ 21.752426] RSP: 0018:ffffcf520380fb40 EFLAGS: 00010246
[ 21.752428] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000=
000
[ 21.752430] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000=
000
[ 21.752432] RBP: ffffcf520380fb68 R08: 0000000000000000 R09: 0000000000000=
000
[ 21.752433] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000=
000
[ 21.752434] R13: ffff89218405fd90 R14: ffff892182088c20 R15: ffff8921890c9=
2a8
[ 21.752436] FS: 000076525b7b3940(0000) GS:ffff892531bff000(0000)
knlGS:0000000000000000
[ 21.752438] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 21.752440] CR2: 0000000000000001 CR3: 000000012934d006 CR4: 0000000000f72=
ef0
[ 21.752442] PKRU: 55555554
[ 21.752444] Call Trace:
[ 21.752446] <TASK>
[ 21.752449] bmc150_accel_buffer_postenable+0x6b/0xb0 [bmc150_accel_core]
[ 21.752453] iio_enable_buffers+0x216/0x380 [industrialio]
[ 21.752466] __iio_update_buffers+0x20c/0x2c0 [industrialio]
[ 21.752475] enable_store+0x8e/0x100 [industrialio]
[ 21.752483] dev_attr_store+0x14/0x40
[ 21.752488] sysfs_kf_write+0x71/0x90
[ 21.752491] kernfs_fop_write_iter+0x15e/0x210
[ 21.752495] vfs_write+0x258/0x490
[ 21.752500] ksys_write+0x71/0xf0
[ 21.752503] __x64_sys_write+0x19/0x30
[ 21.752506] x64_sys_call+0x79/0x2330
[ 21.752510] do_syscall_64+0x81/0xc90
[ 21.752514] ? putname+0x78/0xb0
[ 21.752516] ? do_sys_openat2+0xa1/0xe0
[ 21.752519] ? __x64_sys_openat+0x5f/0xa0
[ 21.752521] ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
[ 21.752523] ? do_syscall_64+0xb9/0xc90
[ 21.752525] ? arch_exit_to_user_mode_prepare.isra.0+0xd/0xe0
[ 21.752527] ? do_syscall_64+0xb9/0xc90
[ 21.752529] ? exc_page_fault+0x90/0x1b0
[ 21.752532] entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 21.752535] RIP: 0033:0x76525bb89772
[ 21.752538] Code: 08 0f 85 a1 38 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce=
 4c
89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2=
e 0f
1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 bf 01 00
[ 21.752540] RSP: 002b:00007ffdbc2c8ab8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[ 21.752542] RAX: ffffffffffffffda RBX: 00005bc770573310 RCX: 000076525bb89=
772
[ 21.752544] RDX: 0000000000000001 RSI: 00007ffdbc2c8c20 RDI: 0000000000000=
009
[ 21.752545] RBP: 00007ffdbc2c8ae0 R08: 0000000000000000 R09: 0000000000000=
000
[ 21.752547] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000=
001
[ 21.752548] R13: 0000000000000001 R14: 00007ffdbc2c8c20 R15: 0000000000000=
002
[ 21.752550] </TASK>
[ 21.752551] Modules linked in: rfcomm cmac algif_hash algif_skcipher af_alg
bnep snd_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component
snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_intel
snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl snd_sof_intel_hda_generic
soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda snd_hda_codec_hd=
mi
soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks
soundwire_generic_allocation snd_soc_acpi xe soundwire_bus snd_soc_sdca crc8
binfmt_misc intel_rapl_msr gpu_sched drm_gpuvm drm_gpusvm_helper drm_ttm_he=
lper
drm_exec drm_suballoc_helper snd_soc_avs intel_rapl_common snd_soc_hda_codec
snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_=
acpi
x86_pkg_temp_thermal snd_soc_core snd_usb_audio intel_powerclamp
snd_usbmidi_lib snd_compress ac97_bus snd_hwdep snd_ump snd_pcm_dmaengine
snd_pcm iwlmvm
[ 21.752596] snd_seq_midi coretemp cmdlinepart spi_nor snd_seq_midi_event
mei_hdcp mtd mei_pxp joydev snd_rawmidi mac80211 kvm_intel snd_seq libarc4
uvcvideo i915 videobuf2_vmalloc btusb bmi323_i2c kvm uvc btrtl videobuf2_me=
mops
iwlwifi bmi323_core snd_seq_device drm_buddy snd_timer videobuf2_v4l2 ttm
i2c_i801 videobuf2_common btintel snd spi_intel_pci irqbypass videodev
drm_display_helper i2c_smbus rapl wmi_bmof btbcm btmtk intel_cstate mei_me =
cec
spi_intel i2c_mux soundcore cfg80211 mei mc bluetooth rc_core i2c_algo_bit
igen6_edac bmc150_accel_i2c bmc150_accel_core intel_pmc_core
industrialio_triggered_buffer pmt_telemetry pmt_discovery goodix_ts kfifo_b=
uf
pmt_class intel_hid intel_pmc_ssram_telemetry industrialio soc_button_array
intel_vsec sparse_keymap acpi_tad acpi_pad btrfs blake2b_generic xor raid6_=
pq
input_leds mac_hid sch_fq_codel msr parport_pc ppdev lp parport efi_pstore
nfnetlink dmi_sysfs ip_tables x_tables autofs4 overlay isofs hid_generic us=
bhid
hid uas usb_storage spi_pxa2xx_platform dw_dmac
[ 21.752662] dw_dmac_core spi_pxa2xx_core nvme polyval_clmulni
ghash_clmulni_intel sdhci_pci nvme_core sdhci_uhs2 aesni_intel psmouse
nvme_keyring nvme_auth sdhci serio_raw cqhci intel_ish_ipc intel_lpss_pci
intel_ishtp intel_lpss idma64 video pinctrl_alderlake wmi
[ 21.752680] CR2: 0000000000000001
[ 21.752683] ---[ end trace 0000000000000000 ]---
[ 22.479343] RIP: 0010:bmc150_accel_set_interrupt+0x7a/0x160
[bmc150_accel_core]
[ 22.479354] Code: 98 00 00 00 b8 01 00 00 00 f0 0f c1 06 83 c0 01 83 f8 01=
 7f
62 49 8b 7d 00 be 01 00 00 00 e8 8d fa ff ff 41 89 c4 85 c0 75 50 <0f> b6 5=
3 01
0f b6 33 45 31 c9 45 31 c0 49 8b 7d 00 6a 00 89 d1 e8
[ 22.479356] RSP: 0018:ffffcf520380fb40 EFLAGS: 00010246
[ 22.479360] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000=
000
[ 22.479361] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000=
000
[ 22.479362] RBP: ffffcf520380fb68 R08: 0000000000000000 R09: 0000000000000=
000
[ 22.479364] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000=
000
[ 22.479365] R13: ffff89218405fd90 R14: ffff892182088c20 R15: ffff8921890c9=
2a8
[ 22.479366] FS: 000076525b7b3940(0000) GS:ffff892531bff000(0000)
knlGS:0000000000000000
[ 22.479368] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 22.479370] CR2: 0000000000000001 CR3: 000000012934d006 CR4: 0000000000f72=
ef0
[ 22.479372] PKRU: 55555554
[ 22.479373] note: iio-sensor-prox[1154] exited with irqs disabled
[ 22.693516] NET: Registered PF_QIPCRTR protocol family


Whe trying older distros like ubuntu 25.04 or Fedora 42 there is no such cr=
ash
on same hardware.  This crash results in accelerometers not working, so no
screen rotation. Also there is issue with suspend/resume when this module
crashed.

After some search I've came across this patch
https://lore.kernel.org/lkml/20250613124648.14141-1-marek.vasut+bmc150@mail=
box.org/
 rebuilt  bmc150-accel-core with this patch and loaded fixed module on Fedo=
ra
43. Accelerometer works and no more issues wit suspend/resume.

Fedora bugzilla show such issue already was encountered with kernel 6.15.9=
=20
https://bugzilla.redhat.com/show_bug.cgi?id=3D2389625  and patch above was
disscussed in 6.12 context.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

