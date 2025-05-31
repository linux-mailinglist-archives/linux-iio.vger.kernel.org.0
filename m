Return-Path: <linux-iio+bounces-20094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19491AC9CA0
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 22:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E001898B73
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5D19E98C;
	Sat, 31 May 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PGBFi77Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F95139D;
	Sat, 31 May 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748721730; cv=none; b=CtXa3vplN1/8Kecmjr3kSUVZMzFzygzeq155NBw35kTJNg+iPRi9qXuJ9iNx60gyydmiLfOteb5AMZEMNkhwSX29FUnPS1528vDt4Gfsa/r8DTP+F4ETMFZ0ZEgcDoTlbzUeAVd3W1xgnOeYSL1nq07qvsZ5BeD8aySMG54f4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748721730; c=relaxed/simple;
	bh=F5u/zqVdsQT9+6wH9CrFx51EZ+xbyrbBk9PA4CD0urU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhUZ339dObgYZlLDiKMz940RAyQrNVY+LiCfKBh2TzM9mJJ4Zn+Q9BspMMO+J6u5Fm/ZeV5152bUvMr0x3Nz66LUvX5ODST+CgCThyUTEutvBbiQ5Qk12OXkgZzKD6lBPUgJ0owMB9gXO1/5+EwUBHDYk3wYlExYoTNonZhBPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PGBFi77Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=gI5iYXBpO0MhDxTi0Q/lfUyfMYW+sw/8L7nwq7ZrxiI=; b=PGBFi77YEM4sZMuLQOux/NGVzS
	tKzP5HHiV0IFurqe5V1Fh/WZPHoHnsbSDBtJ+k/CXhVu+zbxYddcSi0ycwMjCZTig8+WZ/YmobZst
	8Gb2DfxvwmvYR9FvDRphlN45kM09W/G7I5aYCbaXJEe1oBgNye0cm8o2WTq0xGhWHgXZF4qIh5PmY
	zAU6m4N6J2thWgeeZMXPzrcSTKOfkbYcPQ44j8QNsTpKPClsIqI1awVXg5IsrVb96/HDttV8EGaiq
	SL4LW+xFgp3MKbkKLp3Cio/Qo87XrcET8TkgAL91O/FOi0qNQgEuSjXhPCq+YgAwLKBQ/bL4grHtK
	v0T1i85g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uLRy2-000n6f-78; Sat, 31 May 2025 19:34:05 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id E2D87BE2DE0; Sat, 31 May 2025 21:34:03 +0200 (CEST)
Date: Sat, 31 May 2025 21:34:03 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Kim Alvefur <zash@zash.se>, 1106411@bugs.debian.org,
	Stephan Gerhold <stephan@gerhold.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc: 1106411@bugs.debian.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: kernel NULL pointer dereference in bmc150_accel_core / RIP:
 0010:bmc150_accel_set_interrupt+0x68/0x120 [bmc150_accel_core]
Message-ID: <aDtZqwjKtpyguppg@eldamar.lan>
References: <174809774197.3242.15028356144506391196.reportbug@spisula.zash.se>
 <aDMuJsV4Mxb1IVoZ@eldamar.lan>
 <174809774197.3242.15028356144506391196.reportbug@spisula.zash.se>
 <aDnt9LkEZjb4DOO-@spisula.zash.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aDnt9LkEZjb4DOO-@spisula.zash.se>
X-Debian-User: carnil

Hi

On Fri, May 30, 2025 at 07:42:12PM +0200, Kim Alvefur wrote:
> On Sun, May 25, 2025 at 04:50:14PM +0200, Salvatore Bonaccorso wrote:
> > Can you please test 6.12.29-1 from unstable (and which should migrate
> > soon to trixie)?
> >=20
> > If you can reproduce the issue, can you please post the full kernel
> > log once the issue has happened, so we get the full context (The
> > previous log is capped).
>=20
> Output of `journalctl --boot --dmseg` from 6.12.29 attached.
>=20
> So far it seems to happen on every boot, between unlocking LUKS and the
> login manager starting.
>=20
> I wonder if this is related to another symptom this machine has, where
> it fails to complete suspend and goes into a state where the only action
> that has any effect is a long-press of the power button to turn it off.

Looking through the boot log I'm noticing the following:

> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply =
vdd not found, using dummy regulator
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply =
vddio not found, using dummy regulator
[...]
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: suppl=
y vdd not found, using dummy regulator
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: suppl=
y vddio not found, using dummy regulator

and iio-sensor-proxy might fail to handle then the bosch 0200
accelerometer. You proobably cannot temporary purge the
iio-sensor-proxy if installed by reverse dependencies, but might you
try to temporarily mask the service and retest a boot?

I'm looping as well the maintainers of IIO subsystem in if this might
ring a bell. For context, the reporter is getting the following trace
(and full boot log is included):

> May 30 19:21:49 spisula kernel: BUG: kernel NULL pointer dereference, add=
ress: 0000000000000001
> May 30 19:21:49 spisula kernel: #PF: supervisor read access in kernel mode
> May 30 19:21:49 spisula kernel: #PF: error_code(0x0000) - not-present page
> May 30 19:21:49 spisula kernel: PGD 0 P4D 0=20
> May 30 19:21:49 spisula kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> May 30 19:21:49 spisula kernel: CPU: 2 UID: 0 PID: 805 Comm: iio-sensor-p=
rox Not tainted 6.12.29-amd64 #1  Debian 6.12.29-1
> May 30 19:21:49 spisula kernel: Hardware name: Acer TravelMate Spin B311R=
-31/Maracas_GL, BIOS V1.18 08/26/2021
> May 30 19:21:49 spisula kernel: RIP: 0010:bmc150_accel_set_interrupt+0x68=
/0x120 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel: Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f=
 c1 10 83 c2 01 83 fa 01 7f 64 49 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89=
 c3 85 c0 75 52 <41> 0f b6 55 01 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c =
24 6a 00
> May 30 19:21:49 spisula kernel: RSP: 0018:ffffb44780e03b10 EFLAGS: 000102=
46
> May 30 19:21:49 spisula kernel: RAX: 0000000000000000 RBX: 00000000000000=
00 RCX: 00000000ffffff01
> May 30 19:21:49 spisula kernel: RDX: ffffffff8d12acf0 RSI: 00000000000002=
02 RDI: ffffa06a42513904
> May 30 19:21:49 spisula kernel: RBP: ffffa06a42513820 R08: ffffa06a4b33fb=
e8 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: ffffb44780e03b28 R11: 00000000000000=
09 R12: ffffa06a4b33fd50
> May 30 19:21:49 spisula kernel: R13: 0000000000000000 R14: 00000000000000=
01 R15: ffffa06a4b33fb30
> May 30 19:21:49 spisula kernel: FS:  00007f368a3d9940(0000) GS:ffffa06abb=
d00000(0000) knlGS:0000000000000000
> May 30 19:21:49 spisula kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001 CR3: 00000001056100=
00 CR4: 0000000000352ef0
> May 30 19:21:49 spisula kernel: Call Trace:
> May 30 19:21:49 spisula kernel:  <TASK>
> May 30 19:21:49 spisula kernel:  bmc150_accel_buffer_postenable+0x5d/0x90=
 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel:  __iio_update_buffers+0x731/0xb20 [indust=
rialio]
> May 30 19:21:49 spisula kernel:  ? __kernfs_setattr+0xa0/0xb0
> May 30 19:21:49 spisula kernel:  enable_store+0x84/0xe0 [industrialio]
> May 30 19:21:49 spisula kernel:  kernfs_fop_write_iter+0x13b/0x1f0
> May 30 19:21:49 spisula kernel:  vfs_write+0x28d/0x450
> May 30 19:21:49 spisula kernel:  ksys_write+0x6d/0xf0
> May 30 19:21:49 spisula kernel:  do_syscall_64+0x82/0x190
> May 30 19:21:49 spisula kernel:  ? do_filp_open+0xc4/0x170
> May 30 19:21:49 spisula kernel:  ? do_sys_openat2+0x9c/0xe0
> May 30 19:21:49 spisula kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
> May 30 19:21:49 spisula kernel:  ? do_syscall_64+0x8e/0x190
> May 30 19:21:49 spisula kernel:  ? do_syscall_64+0x8e/0x190
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> May 30 19:21:49 spisula kernel: RIP: 0033:0x7f368a7df9ee
> May 30 19:21:49 spisula kernel: Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89=
 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89=
 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 =
83 ec 08
> May 30 19:21:49 spisula kernel: RSP: 002b:00007fffd76b67e8 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000001
> May 30 19:21:49 spisula kernel: RAX: ffffffffffffffda RBX: 00007f368a3d99=
40 RCX: 00007f368a7df9ee
> May 30 19:21:49 spisula kernel: RDX: 0000000000000001 RSI: 00007fffd76b69=
90 RDI: 0000000000000009
> May 30 19:21:49 spisula kernel: RBP: 00007fffd76b6990 R08: 00000000000000=
00 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: 0000000000000000 R11: 00000000000002=
46 R12: 0000000000000001
> May 30 19:21:49 spisula kernel: R13: 000055742d68a2a0 R14: 00007f368a92ae=
80 R15: 0000000000000001
> May 30 19:21:49 spisula kernel:  </TASK>
> May 30 19:21:49 spisula kernel: Modules linked in: bnep snd_intel_dspcfg =
zram x86_pkg_temp_thermal uvcvideo snd_intel_sdw_acpi lz4hc_compress lz4_co=
mpress intel_powerclamp processor_thermal_device_pci_legacy btusb videobuf2=
_vmalloc snd_hda_codec coretemp drm_buddy iwlmvm processor_thermal_device b=
trtl uvc snd_hda_core kvm_intel drm_display_helper processor_thermal_wt_hin=
t mac80211 processor_thermal_rfim binfmt_misc btintel videobuf2_memops inte=
l_rapl_msr processor_thermal_rapl cec snd_hwdep kvm libarc4 nls_ascii bmc15=
0_accel_i2c btbcm videobuf2_v4l2 intel_rapl_common acer_wmi rc_core snd_pcm=
 nls_cp437 iwlwifi bmc150_accel_core irqbypass intel_pmc_core btmtk videode=
v processor_thermal_wt_req sparse_keymap mei_pxp mei_hdcp ttm snd_timer vfa=
t industrialio_triggered_buffer rapl intel_vsec processor_thermal_power_flo=
or cfg80211 rtsx_usb_ms bluetooth videobuf2_common platform_profile mei_me =
drm_kms_helper snd fat kfifo_buf intel_cstate pcspkr pmt_telemetry processo=
r_thermal_mbox wmi_bmof memstick mc int3403_thermal rfkill mei i2c_algo_bit
> May 30 19:21:49 spisula kernel:  soundcore industrialio int3400_thermal a=
cer_wireless soc_button_array pmt_class intel_soc_dts_iosf int340x_thermal_=
zone ac acpi_thermal_rel button joydev evdev msr parport_pc ppdev lp parpor=
t efi_pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 cr=
c16 mbcache jbd2 crc32c_generic rtsx_usb_sdmmc rtsx_usb dm_crypt dm_mod crc=
t10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 hi=
d_multitouch sha256_ssse3 hid_generic sha1_ssse3 xhci_pci aesni_intel xhci_=
hcd i2c_hid_acpi sdhci_pci r8169 gf128mul nvme i2c_hid intel_lpss_pci cqhci=
 usbcore realtek crypto_simd nvme_core hid intel_lpss i2c_i801 sdhci wdat_w=
dt mdio_devres cryptd serio_raw watchdog video libphy mmc_core i2c_smbus lp=
c_ich nvme_auth drm idma64 usb_common battery wmi
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001
> May 30 19:21:49 spisula kernel: ---[ end trace 0000000000000000 ]---
> May 30 19:21:49 spisula kernel: RIP: 0010:bmc150_accel_set_interrupt+0x68=
/0x120 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel: Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f=
 c1 10 83 c2 01 83 fa 01 7f 64 49 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89=
 c3 85 c0 75 52 <41> 0f b6 55 01 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c =
24 6a 00
> May 30 19:21:49 spisula kernel: RSP: 0018:ffffb44780e03b10 EFLAGS: 000102=
46
> May 30 19:21:49 spisula kernel: RAX: 0000000000000000 RBX: 00000000000000=
00 RCX: 00000000ffffff01
> May 30 19:21:49 spisula kernel: RDX: ffffffff8d12acf0 RSI: 00000000000002=
02 RDI: ffffa06a42513904
> May 30 19:21:49 spisula kernel: RBP: ffffa06a42513820 R08: ffffa06a4b33fb=
e8 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: ffffb44780e03b28 R11: 00000000000000=
09 R12: ffffa06a4b33fd50
> May 30 19:21:49 spisula kernel: R13: 0000000000000000 R14: 00000000000000=
01 R15: ffffa06a4b33fb30
> May 30 19:21:49 spisula kernel: FS:  00007f368a3d9940(0000) GS:ffffa06abb=
d00000(0000) knlGS:0000000000000000
> May 30 19:21:49 spisula kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001 CR3: 00000001056100=
00 CR4: 0000000000352ef0
> May 30 19:21:49 spisula kernel: note: iio-sensor-prox[805] exited with ir=
qs disabled

Regards,
Salvatore

> May 30 19:21:45 spisula kernel: Linux version 6.12.29-amd64 (debian-kerne=
l@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU=
 ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT_DYNAMIC Debian 6.12.29-1=
 (2025-05-18)
> May 30 19:21:45 spisula kernel: Command line: BOOT_IMAGE=3D/vmlinuz-6.12.=
29-amd64 root=3D/dev/mapper/spisula--vg-root ro quiet
> May 30 19:21:45 spisula kernel: BIOS-provided physical RAM map:
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000000000000-0x0000=
000000057fff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000000058000-0x0000=
000000058fff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000000059000-0x0000=
00000009dfff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x000000000009e000-0x0000=
0000000fffff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000000100000-0x0000=
00000fffffff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000010000000-0x0000=
000012150fff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000012151000-0x0000=
000066fccfff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000066fcd000-0x0000=
000066fd6fff] ACPI data
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000066fd7000-0x0000=
00007447ffff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000074480000-0x0000=
00007792ffff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000077930000-0x0000=
00007798ffff] ACPI NVS
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000077990000-0x0000=
0000779cffff] ACPI data
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x00000000779d0000-0x0000=
000078d59fff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000078d5a000-0x0000=
000079659fff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x000000007965a000-0x0000=
000079bfffff] usable
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000079c00000-0x0000=
00007fffffff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x00000000d3709000-0x0000=
0000d3709fff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x00000000e0000000-0x0000=
0000e3ffffff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x00000000fed01000-0x0000=
0000fed01fff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x00000000ff800000-0x0000=
0000ffffffff] reserved
> May 30 19:21:45 spisula kernel: BIOS-e820: [mem 0x0000000100000000-0x0000=
00017fffffff] usable
> May 30 19:21:45 spisula kernel: NX (Execute Disable) protection: active
> May 30 19:21:45 spisula kernel: APIC: Static calls initialized
> May 30 19:21:45 spisula kernel: efi: EFI v2.6 by INSYDE Corp.
> May 30 19:21:45 spisula kernel: efi: ACPI=3D0x779cf000 ACPI 2.0=3D0x779cf=
014 TPMFinalLog=3D0x77795000 ESRT=3D0x744d4018 SMBIOS=3D0x744c2000 SMBIOS 3=
=2E0=3D0x744c0000 MOKvar=3D0x744a7000 INITRD=3D0x6c0aac18 RNG=3D0x77999018 =
TPMEventLog=3D0x66fcd018=20
> May 30 19:21:45 spisula kernel: random: crng init done
> May 30 19:21:45 spisula kernel: efi: Not removing mem48: MMIO range=3D[0x=
d3709000-0xd3709fff] (4KB) from e820 map
> May 30 19:21:45 spisula kernel: efi: Remove mem49: MMIO range=3D[0xe00000=
00-0xe3ffffff] (64MB) from e820 map
> May 30 19:21:45 spisula kernel: e820: remove [mem 0xe0000000-0xe3ffffff] =
reserved
> May 30 19:21:45 spisula kernel: efi: Not removing mem50: MMIO range=3D[0x=
fed01000-0xfed01fff] (4KB) from e820 map
> May 30 19:21:45 spisula kernel: efi: Remove mem51: MMIO range=3D[0xff8000=
00-0xffffffff] (8MB) from e820 map
> May 30 19:21:45 spisula kernel: e820: remove [mem 0xff800000-0xffffffff] =
reserved
> May 30 19:21:45 spisula kernel: Kernel is locked down from EFI Secure Boo=
t; see man kernel_lockdown.7
> May 30 19:21:45 spisula kernel: secureboot: Secure boot enabled
> May 30 19:21:45 spisula kernel: SMBIOS 3.0.1 present.
> May 30 19:21:45 spisula kernel: DMI: Acer TravelMate Spin B311R-31/Maraca=
s_GL, BIOS V1.18 08/26/2021
> May 30 19:21:45 spisula kernel: DMI: Memory slots populated: 1/1
> May 30 19:21:45 spisula kernel: tsc: Fast TSC calibration using PIT
> May 30 19:21:45 spisula kernel: tsc: Detected 1094.400 MHz processor
> May 30 19:21:45 spisula kernel: e820: update [mem 0x00000000-0x00000fff] =
usable =3D=3D> reserved
> May 30 19:21:45 spisula kernel: e820: remove [mem 0x000a0000-0x000fffff] =
usable
> May 30 19:21:45 spisula kernel: last_pfn =3D 0x180000 max_arch_pfn =3D 0x=
400000000
> May 30 19:21:45 spisula kernel: MTRR map: 8 entries (3 fixed + 5 variable=
; max 23), built from 10 variable MTRRs
> May 30 19:21:45 spisula kernel: x86/PAT: Configuration [0-7]: WB  WC  UC-=
 UC  WB  WP  UC- WT =20
> May 30 19:21:45 spisula kernel: last_pfn =3D 0x79c00 max_arch_pfn =3D 0x4=
00000000
> May 30 19:21:45 spisula kernel: esrt: Reserving ESRT space from 0x0000000=
0744d4018 to 0x00000000744d4050.
> May 30 19:21:45 spisula kernel: Using GB pages for direct mapping
> May 30 19:21:45 spisula kernel: RAMDISK: [mem 0x66fd7000-0x6a3f2fff]
> May 30 19:21:45 spisula kernel: ACPI: Early table checksum verification d=
isabled
> May 30 19:21:45 spisula kernel: ACPI: RSDP 0x00000000779CF014 000024 (v02=
 ACRSYS)
> May 30 19:21:45 spisula kernel: ACPI: XSDT 0x00000000779AC188 000114 (v01=
 ACRSYS ACRPRDCT 00000003      01000013)
> May 30 19:21:45 spisula kernel: ACPI: FACP 0x00000000779C5000 000114 (v06=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: DSDT 0x00000000779B4000 0094E8 (v02=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: FACS 0x0000000077988000 000040
> May 30 19:21:45 spisula kernel: ACPI: FACS 0x0000000077988000 000040
> May 30 19:21:45 spisula kernel: ACPI: UEFI 0x00000000779CE000 000236 (v01=
 ACRSYS ACRPRDCT 00000001 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: UEFI 0x00000000779CD000 000042 (v01=
 ACRSYS ACRPRDCT 00000002 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779CC000 000781 (v01=
 ACRSYS ACRPRDCT 00001000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: TPM2 0x00000000779CB000 000034 (v04=
 ACRSYS ACRPRDCT 00000002 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: MSDM 0x00000000779CA000 000055 (v03=
 ACRSYS ACRPRDCT 00000001 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: BDAT 0x00000000779C9000 000030 (v02=
 ACRSYS ACRPRDCT 00000000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: HPET 0x00000000779C4000 000038 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: LPIT 0x00000000779C3000 00005C (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: APIC 0x00000000779C2000 000084 (v03=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: MCFG 0x00000000779C1000 00003C (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: NPKT 0x00000000779C0000 000065 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: PRAM 0x00000000779BF000 000030 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: WSMT 0x00000000779BE000 000028 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779B0000 003655 (v02=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779AE000 001F20 (v02=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779AD000 000B82 (v02=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779AB000 000BA1 (v01=
 ACRSYS ACRPRDCT 00001000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779AA000 000439 (v02=
 ACRSYS ACRPRDCT 00003000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779A9000 00072B (v02=
 ACRSYS ACRPRDCT 00003000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779A8000 00032D (v02=
 ACRSYS ACRPRDCT 00003000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779A7000 00017C (v02=
 ACRSYS ACRPRDCT 00003000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x00000000779A4000 00274C (v02=
 ACRSYS ACRPRDCT 00003000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0x000000007799D000 00605F (v01=
 ACRSYS ACRPRDCT 00001000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: FPDT 0x000000007799C000 000044 (v01=
 ACRSYS ACRPRDCT 00000002 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: DBGP 0x00000000779C7000 000034 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: DBG2 0x00000000779C8000 000072 (v00=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: DMAR 0x00000000779C6000 0000A8 (v01=
 ACRSYS ACRPRDCT 00000003 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: WDAT 0x000000007799A000 000104 (v01=
 ACRSYS ACRPRDCT 00000000 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: BGRT 0x000000007799B000 000038 (v01=
 ACRSYS ACRPRDCT 00000001 1025 00040000)
> May 30 19:21:45 spisula kernel: ACPI: Reserving FACP table memory at [mem=
 0x779c5000-0x779c5113]
> May 30 19:21:45 spisula kernel: ACPI: Reserving DSDT table memory at [mem=
 0x779b4000-0x779bd4e7]
> May 30 19:21:45 spisula kernel: ACPI: Reserving FACS table memory at [mem=
 0x77988000-0x7798803f]
> May 30 19:21:45 spisula kernel: ACPI: Reserving FACS table memory at [mem=
 0x77988000-0x7798803f]
> May 30 19:21:45 spisula kernel: ACPI: Reserving UEFI table memory at [mem=
 0x779ce000-0x779ce235]
> May 30 19:21:45 spisula kernel: ACPI: Reserving UEFI table memory at [mem=
 0x779cd000-0x779cd041]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779cc000-0x779cc780]
> May 30 19:21:45 spisula kernel: ACPI: Reserving TPM2 table memory at [mem=
 0x779cb000-0x779cb033]
> May 30 19:21:45 spisula kernel: ACPI: Reserving MSDM table memory at [mem=
 0x779ca000-0x779ca054]
> May 30 19:21:45 spisula kernel: ACPI: Reserving BDAT table memory at [mem=
 0x779c9000-0x779c902f]
> May 30 19:21:45 spisula kernel: ACPI: Reserving HPET table memory at [mem=
 0x779c4000-0x779c4037]
> May 30 19:21:45 spisula kernel: ACPI: Reserving LPIT table memory at [mem=
 0x779c3000-0x779c305b]
> May 30 19:21:45 spisula kernel: ACPI: Reserving APIC table memory at [mem=
 0x779c2000-0x779c2083]
> May 30 19:21:45 spisula kernel: ACPI: Reserving MCFG table memory at [mem=
 0x779c1000-0x779c103b]
> May 30 19:21:45 spisula kernel: ACPI: Reserving NPKT table memory at [mem=
 0x779c0000-0x779c0064]
> May 30 19:21:45 spisula kernel: ACPI: Reserving PRAM table memory at [mem=
 0x779bf000-0x779bf02f]
> May 30 19:21:45 spisula kernel: ACPI: Reserving WSMT table memory at [mem=
 0x779be000-0x779be027]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779b0000-0x779b3654]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779ae000-0x779aff1f]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779ad000-0x779adb81]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779ab000-0x779abba0]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779aa000-0x779aa438]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779a9000-0x779a972a]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779a8000-0x779a832c]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779a7000-0x779a717b]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x779a4000-0x779a674b]
> May 30 19:21:45 spisula kernel: ACPI: Reserving SSDT table memory at [mem=
 0x7799d000-0x779a305e]
> May 30 19:21:45 spisula kernel: ACPI: Reserving FPDT table memory at [mem=
 0x7799c000-0x7799c043]
> May 30 19:21:45 spisula kernel: ACPI: Reserving DBGP table memory at [mem=
 0x779c7000-0x779c7033]
> May 30 19:21:45 spisula kernel: ACPI: Reserving DBG2 table memory at [mem=
 0x779c8000-0x779c8071]
> May 30 19:21:45 spisula kernel: ACPI: Reserving DMAR table memory at [mem=
 0x779c6000-0x779c60a7]
> May 30 19:21:45 spisula kernel: ACPI: Reserving WDAT table memory at [mem=
 0x7799a000-0x7799a103]
> May 30 19:21:45 spisula kernel: ACPI: Reserving BGRT table memory at [mem=
 0x7799b000-0x7799b037]
> May 30 19:21:45 spisula kernel: No NUMA configuration found
> May 30 19:21:45 spisula kernel: Faking a node at [mem 0x0000000000000000-=
0x000000017fffffff]
> May 30 19:21:45 spisula kernel: NODE_DATA(0) allocated [mem 0x17ffd5680-0=
x17fffffff]
> May 30 19:21:45 spisula kernel: Zone ranges:
> May 30 19:21:45 spisula kernel:   DMA      [mem 0x0000000000001000-0x0000=
000000ffffff]
> May 30 19:21:45 spisula kernel:   DMA32    [mem 0x0000000001000000-0x0000=
0000ffffffff]
> May 30 19:21:45 spisula kernel:   Normal   [mem 0x0000000100000000-0x0000=
00017fffffff]
> May 30 19:21:45 spisula kernel:   Device   empty
> May 30 19:21:45 spisula kernel: Movable zone start for each node
> May 30 19:21:45 spisula kernel: Early memory node ranges
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000000001000-0x000=
0000000057fff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000000059000-0x000=
000000009dfff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000000100000-0x000=
000000fffffff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000012151000-0x000=
0000066fccfff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000066fd7000-0x000=
000007447ffff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x00000000779d0000-0x000=
0000078d59fff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x000000007965a000-0x000=
0000079bfffff]
> May 30 19:21:45 spisula kernel:   node   0: [mem 0x0000000100000000-0x000=
000017fffffff]
> May 30 19:21:45 spisula kernel: Initmem setup node 0 [mem 0x0000000000001=
000-0x000000017fffffff]
> May 30 19:21:45 spisula kernel: On node 0, zone DMA: 1 pages in unavailab=
le ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA: 1 pages in unavailab=
le ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA: 98 pages in unavaila=
ble ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA32: 8529 pages in unav=
ailable ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA32: 10 pages in unavai=
lable ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA32: 13648 pages in una=
vailable ranges
> May 30 19:21:45 spisula kernel: On node 0, zone DMA32: 2304 pages in unav=
ailable ranges
> May 30 19:21:45 spisula kernel: On node 0, zone Normal: 25600 pages in un=
available ranges
> May 30 19:21:45 spisula kernel: Reserving Intel graphics memory at [mem 0=
x7c000000-0x7fffffff]
> May 30 19:21:45 spisula kernel: ACPI: PM-Timer IO Port: 0x408
> May 30 19:21:45 spisula kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high level=
 lint[0x1])
> May 30 19:21:45 spisula kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high level=
 lint[0x1])
> May 30 19:21:45 spisula kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high level=
 lint[0x1])
> May 30 19:21:45 spisula kernel: ACPI: LAPIC_NMI (acpi_id[0x04] high level=
 lint[0x1])
> May 30 19:21:45 spisula kernel: IOAPIC[0]: apic_id 1, version 32, address=
 0xfec00000, GSI 0-119
> May 30 19:21:45 spisula kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global=
_irq 2 dfl dfl)
> May 30 19:21:45 spisula kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global=
_irq 9 low level)
> May 30 19:21:45 spisula kernel: ACPI: Using ACPI (MADT) for SMP configura=
tion information
> May 30 19:21:45 spisula kernel: ACPI: HPET id: 0x8086a701 base: 0xfed00000
> May 30 19:21:45 spisula kernel: e820: update [mem 0x7176c000-0x717e6fff] =
usable =3D=3D> reserved
> May 30 19:21:45 spisula kernel: TSC deadline timer available
> May 30 19:21:45 spisula kernel: CPU topo: Max. logical packages:   1
> May 30 19:21:45 spisula kernel: CPU topo: Max. logical dies:       1
> May 30 19:21:45 spisula kernel: CPU topo: Max. dies per package:   1
> May 30 19:21:45 spisula kernel: CPU topo: Max. threads per core:   1
> May 30 19:21:45 spisula kernel: CPU topo: Num. cores per package:     4
> May 30 19:21:45 spisula kernel: CPU topo: Num. threads per package:   4
> May 30 19:21:45 spisula kernel: CPU topo: Allowing 4 present CPUs plus 0 =
hotplug CPUs
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x00000000-0x00000fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x00058000-0x00058fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x0009e000-0x000fffff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x10000000-0x12150fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x66fcd000-0x66fd6fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x7176c000-0x717e6fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x74480000-0x779cffff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x78d5a000-0x79659fff]
> May 30 19:21:45 spisula kernel: PM: hibernation: Registered nosave memory=
: [mem 0x79c00000-0xffffffff]
> May 30 19:21:45 spisula kernel: [mem 0x80000000-0xd3708fff] available for=
 PCI devices
> May 30 19:21:45 spisula kernel: Booting paravirtualized kernel on bare ha=
rdware
> May 30 19:21:45 spisula kernel: clocksource: refined-jiffies: mask: 0xfff=
fffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> May 30 19:21:45 spisula kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bit=
s:4 nr_cpu_ids:4 nr_node_ids:1
> May 30 19:21:45 spisula kernel: percpu: Embedded 66 pages/cpu s233472 r81=
92 d28672 u524288
> May 30 19:21:45 spisula kernel: pcpu-alloc: s233472 r8192 d28672 u524288 =
alloc=3D1*2097152
> May 30 19:21:45 spisula kernel: pcpu-alloc: [0] 0 1 2 3=20
> May 30 19:21:45 spisula kernel: Kernel command line: BOOT_IMAGE=3D/vmlinu=
z-6.12.29-amd64 root=3D/dev/mapper/spisula--vg-root ro quiet
> May 30 19:21:45 spisula kernel: Unknown kernel command line parameters "B=
OOT_IMAGE=3D/vmlinuz-6.12.29-amd64", will be passed to user space.
> May 30 19:21:45 spisula kernel: Dentry cache hash table entries: 524288 (=
order: 10, 4194304 bytes, linear)
> May 30 19:21:45 spisula kernel: Inode-cache hash table entries: 262144 (o=
rder: 9, 2097152 bytes, linear)
> May 30 19:21:45 spisula kernel: Fallback order for Node 0: 0=20
> May 30 19:21:45 spisula kernel: Built 1 zonelists, mobility grouping on. =
 Total pages: 998385
> May 30 19:21:45 spisula kernel: Policy zone: Normal
> May 30 19:21:45 spisula kernel: mem auto-init: stack:all(zero), heap allo=
c:on, heap free:off
> May 30 19:21:45 spisula kernel: software IO TLB: area num 4.
> May 30 19:21:45 spisula kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D4, Nodes=3D1
> May 30 19:21:45 spisula kernel: ftrace: allocating 45689 entries in 179 p=
ages
> May 30 19:21:45 spisula kernel: ftrace: allocated 179 pages with 5 groups
> May 30 19:21:45 spisula kernel: Dynamic Preempt: voluntary
> May 30 19:21:45 spisula kernel: rcu: Preemptible hierarchical RCU impleme=
ntation.
> May 30 19:21:45 spisula kernel: rcu:         RCU restricting CPUs from NR=
_CPUS=3D8192 to nr_cpu_ids=3D4.
> May 30 19:21:45 spisula kernel:         Trampoline variant of Tasks RCU e=
nabled.
> May 30 19:21:45 spisula kernel:         Rude variant of Tasks RCU enabled.
> May 30 19:21:45 spisula kernel:         Tracing variant of Tasks RCU enab=
led.
> May 30 19:21:45 spisula kernel: rcu: RCU calculated value of scheduler-en=
listment delay is 25 jiffies.
> May 30 19:21:45 spisula kernel: rcu: Adjusting geometry for rcu_fanout_le=
af=3D16, nr_cpu_ids=3D4
> May 30 19:21:45 spisula kernel: RCU Tasks: Setting shift to 2 and lim to =
1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
> May 30 19:21:45 spisula kernel: RCU Tasks Rude: Setting shift to 2 and li=
m to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
> May 30 19:21:45 spisula kernel: RCU Tasks Trace: Setting shift to 2 and l=
im to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D4.
> May 30 19:21:45 spisula kernel: NR_IRQS: 524544, nr_irqs: 1024, prealloca=
ted irqs: 16
> May 30 19:21:45 spisula kernel: rcu: srcu_init: Setting srcu_struct sizes=
 based on contention.
> May 30 19:21:45 spisula kernel: Console: colour dummy device 80x25
> May 30 19:21:45 spisula kernel: printk: legacy console [tty0] enabled
> May 30 19:21:45 spisula kernel: ACPI: Core revision 20240827
> May 30 19:21:45 spisula kernel: clocksource: hpet: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 99544814920 ns
> May 30 19:21:45 spisula kernel: APIC: Switch to symmetric I/O mode setup
> May 30 19:21:45 spisula kernel: DMAR: Host address width 39
> May 30 19:21:45 spisula kernel: DMAR: DRHD base: 0x000000fed64000 flags: =
0x0
> May 30 19:21:45 spisula kernel: DMAR: dmar0: reg_base_addr fed64000 ver 1=
:0 cap 1c0000c40660462 ecap 9e2ff0505e
> May 30 19:21:45 spisula kernel: DMAR: DRHD base: 0x000000fed65000 flags: =
0x1
> May 30 19:21:45 spisula kernel: DMAR: dmar1: reg_base_addr fed65000 ver 1=
:0 cap d2008c40660462 ecap f050da
> May 30 19:21:45 spisula kernel: DMAR: RMRR base: 0x00000077871000 end: 0x=
00000077890fff
> May 30 19:21:45 spisula kernel: DMAR: RMRR base: 0x0000007b800000 end: 0x=
0000007fffffff
> May 30 19:21:45 spisula kernel: DMAR-IR: IOAPIC id 1 under DRHD base  0xf=
ed65000 IOMMU 1
> May 30 19:21:45 spisula kernel: DMAR-IR: HPET id 0 under DRHD base 0xfed6=
5000
> May 30 19:21:45 spisula kernel: DMAR-IR: Queued invalidation will be enab=
led to support x2apic and Intr-remapping.
> May 30 19:21:45 spisula kernel: DMAR-IR: Enabled IRQ remapping in x2apic =
mode
> May 30 19:21:45 spisula kernel: x2apic enabled
> May 30 19:21:45 spisula kernel: APIC: Switched APIC routing to: cluster x=
2apic
> May 30 19:21:45 spisula kernel: ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2=
 apic2=3D-1 pin2=3D-1
> May 30 19:21:45 spisula kernel: clocksource: tsc-early: mask: 0xfffffffff=
fffffff max_cycles: 0xfc66f4fc7c, max_idle_ns: 440795224246 ns
> May 30 19:21:45 spisula kernel: Calibrating delay loop (skipped), value c=
alculated using timer frequency.. 2188.80 BogoMIPS (lpj=3D4377600)
> May 30 19:21:45 spisula kernel: x86/cpu: SGX disabled or unsupported by B=
IOS.
> May 30 19:21:45 spisula kernel: CPU0: Thermal monitoring enabled (TM1)
> May 30 19:21:45 spisula kernel: x86/cpu: User Mode Instruction Prevention=
 (UMIP) activated
> May 30 19:21:45 spisula kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4M=
B 0
> May 30 19:21:45 spisula kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4M=
B 0, 1GB 0
> May 30 19:21:45 spisula kernel: process: using mwait in idle threads
> May 30 19:21:45 spisula kernel: Spectre V1 : Mitigation: usercopy/swapgs =
barriers and __user pointer sanitization
> May 30 19:21:45 spisula kernel: Spectre V2 : Spectre BHI mitigation: SW B=
HB clearing on syscall and VM exit
> May 30 19:21:45 spisula kernel: Spectre V2 : Mitigation: Enhanced / Autom=
atic IBRS
> May 30 19:21:45 spisula kernel: Spectre V2 : mitigation: Enabling conditi=
onal Indirect Branch Prediction Barrier
> May 30 19:21:45 spisula kernel: Speculative Store Bypass: Mitigation: Spe=
culative Store Bypass disabled via prctl
> May 30 19:21:45 spisula kernel: Register File Data Sampling: Mitigation: =
Clear Register File
> May 30 19:21:45 spisula kernel: x86/fpu: Supporting XSAVE feature 0x001: =
'x87 floating point registers'
> May 30 19:21:45 spisula kernel: x86/fpu: Supporting XSAVE feature 0x002: =
'SSE registers'
> May 30 19:21:45 spisula kernel: x86/fpu: Supporting XSAVE feature 0x008: =
'MPX bounds registers'
> May 30 19:21:45 spisula kernel: x86/fpu: Supporting XSAVE feature 0x010: =
'MPX CSR'
> May 30 19:21:45 spisula kernel: x86/fpu: xstate_offset[3]:  576, xstate_s=
izes[3]:   64
> May 30 19:21:45 spisula kernel: x86/fpu: xstate_offset[4]:  640, xstate_s=
izes[4]:   64
> May 30 19:21:45 spisula kernel: x86/fpu: Enabled xstate features 0x1b, co=
ntext size is 704 bytes, using 'compacted' format.
> May 30 19:21:45 spisula kernel: Freeing SMP alternatives memory: 40K
> May 30 19:21:45 spisula kernel: pid_max: default: 32768 minimum: 301
> May 30 19:21:45 spisula kernel: LSM: initializing lsm=3Dlockdown,capabili=
ty,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
> May 30 19:21:45 spisula kernel: landlock: Up and running.
> May 30 19:21:45 spisula kernel: Yama: disabled by default; enable with sy=
sctl kernel.yama.*
> May 30 19:21:45 spisula kernel: AppArmor: AppArmor initialized
> May 30 19:21:45 spisula kernel: TOMOYO Linux initialized
> May 30 19:21:45 spisula kernel: LSM support for eBPF active
> May 30 19:21:45 spisula kernel: Mount-cache hash table entries: 8192 (ord=
er: 4, 65536 bytes, linear)
> May 30 19:21:45 spisula kernel: Mountpoint-cache hash table entries: 8192=
 (order: 4, 65536 bytes, linear)
> May 30 19:21:45 spisula kernel: smpboot: CPU0: Intel(R) Celeron(R) N4120 =
CPU @ 1.10GHz (family: 0x6, model: 0x7a, stepping: 0x8)
> May 30 19:21:45 spisula kernel: Performance Events: PEBS fmt3+, Goldmont =
plus events, 32-deep LBR, full-width counters, Intel PMU driver.
> May 30 19:21:45 spisula kernel: ... version:                4
> May 30 19:21:45 spisula kernel: ... bit width:              48
> May 30 19:21:45 spisula kernel: ... generic registers:      4
> May 30 19:21:45 spisula kernel: ... value mask:             0000fffffffff=
fff
> May 30 19:21:45 spisula kernel: ... max period:             00007ffffffff=
fff
> May 30 19:21:45 spisula kernel: ... fixed-purpose events:   3
> May 30 19:21:45 spisula kernel: ... event mask:             0000000700000=
00f
> May 30 19:21:45 spisula kernel: signal: max sigframe size: 2032
> May 30 19:21:45 spisula kernel: Estimated ratio of average max frequency =
by base frequency (times 1024): 2420
> May 30 19:21:45 spisula kernel: rcu: Hierarchical SRCU implementation.
> May 30 19:21:45 spisula kernel: rcu:         Max phase no-delay instances=
 is 1000.
> May 30 19:21:45 spisula kernel: Timer migration: 1 hierarchy levels; 8 ch=
ildren per group; 1 crossnode level
> May 30 19:21:45 spisula kernel: NMI watchdog: Enabled. Permanently consum=
es one hw-PMU counter.
> May 30 19:21:45 spisula kernel: smp: Bringing up secondary CPUs ...
> May 30 19:21:45 spisula kernel: smpboot: x86: Booting SMP configuration:
> May 30 19:21:45 spisula kernel: .... node  #0, CPUs:      #1 #2 #3
> May 30 19:21:45 spisula kernel: smp: Brought up 1 node, 4 CPUs
> May 30 19:21:45 spisula kernel: smpboot: Total of 4 processors activated =
(8755.20 BogoMIPS)
> May 30 19:21:45 spisula kernel: node 0 deferred pages initialised in 12ms
> May 30 19:21:45 spisula kernel: Memory: 3744420K/3993540K available (1638=
4K kernel code, 2486K rwdata, 11780K rodata, 4148K init, 4956K bss, 238864K=
 reserved, 0K cma-reserved)
> May 30 19:21:45 spisula kernel: devtmpfs: initialized
> May 30 19:21:45 spisula kernel: x86/mm: Memory block size: 128MB
> May 30 19:21:45 spisula kernel: ACPI: PM: Registering ACPI NVS region [me=
m 0x77930000-0x7798ffff] (393216 bytes)
> May 30 19:21:45 spisula kernel: clocksource: jiffies: mask: 0xffffffff ma=
x_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> May 30 19:21:45 spisula kernel: futex hash table entries: 1024 (order: 4,=
 65536 bytes, linear)
> May 30 19:21:45 spisula kernel: pinctrl core: initialized pinctrl subsyst=
em
> May 30 19:21:45 spisula kernel: NET: Registered PF_NETLINK/PF_ROUTE proto=
col family
> May 30 19:21:45 spisula kernel: DMA: preallocated 512 KiB GFP_KERNEL pool=
 for atomic allocations
> May 30 19:21:45 spisula kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_=
DMA pool for atomic allocations
> May 30 19:21:45 spisula kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_=
DMA32 pool for atomic allocations
> May 30 19:21:45 spisula kernel: audit: initializing netlink subsys (disab=
led)
> May 30 19:21:45 spisula kernel: audit: type=3D2000 audit(1748625696.200:1=
): state=3Dinitialized audit_enabled=3D0 res=3D1
> May 30 19:21:45 spisula kernel: thermal_sys: Registered thermal governor =
'fair_share'
> May 30 19:21:45 spisula kernel: thermal_sys: Registered thermal governor =
'bang_bang'
> May 30 19:21:45 spisula kernel: thermal_sys: Registered thermal governor =
'step_wise'
> May 30 19:21:45 spisula kernel: thermal_sys: Registered thermal governor =
'user_space'
> May 30 19:21:45 spisula kernel: thermal_sys: Registered thermal governor =
'power_allocator'
> May 30 19:21:45 spisula kernel: cpuidle: using governor ladder
> May 30 19:21:45 spisula kernel: cpuidle: using governor menu
> May 30 19:21:45 spisula kernel: ACPI FADT declares the system doesn't sup=
port PCIe ASPM, so disable it
> May 30 19:21:45 spisula kernel: acpiphp: ACPI Hot Plug PCI Controller Dri=
ver version: 0.5
> May 30 19:21:45 spisula kernel: PCI: ECAM [mem 0xe0000000-0xe3ffffff] (ba=
se 0xe0000000) for domain 0000 [bus 00-3f]
> May 30 19:21:45 spisula kernel: PCI: Using configuration type 1 for base =
access
> May 30 19:21:45 spisula kernel: kprobes: kprobe jump-optimization is enab=
led. All kprobes are optimized if possible.
> May 30 19:21:45 spisula kernel: HugeTLB: registered 1.00 GiB page size, p=
re-allocated 0 pages
> May 30 19:21:45 spisula kernel: HugeTLB: 16380 KiB vmemmap can be freed f=
or a 1.00 GiB page
> May 30 19:21:45 spisula kernel: HugeTLB: registered 2.00 MiB page size, p=
re-allocated 0 pages
> May 30 19:21:45 spisula kernel: HugeTLB: 28 KiB vmemmap can be freed for =
a 2.00 MiB page
> May 30 19:21:45 spisula kernel: ACPI: Added _OSI(Module Device)
> May 30 19:21:45 spisula kernel: ACPI: Added _OSI(Processor Device)
> May 30 19:21:45 spisula kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
> May 30 19:21:45 spisula kernel: ACPI: Added _OSI(Processor Aggregator Dev=
ice)
> May 30 19:21:45 spisula kernel: ACPI: 12 ACPI AML tables successfully acq=
uired and loaded
> May 30 19:21:45 spisula kernel: ACPI: Dynamic OEM Table Load:
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0xFFFFA06A40E82600 000102 (v02=
 PmRef  Cpu0Cst  00003001 INTL 20130117)
> May 30 19:21:45 spisula kernel: ACPI: Dynamic OEM Table Load:
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0xFFFFA06A40E83200 00015F (v02=
 PmRef  ApIst    00003000 INTL 20130117)
> May 30 19:21:45 spisula kernel: ACPI: Dynamic OEM Table Load:
> May 30 19:21:45 spisula kernel: ACPI: SSDT 0xFFFFA06A49AF50C0 00008D (v02=
 PmRef  ApCst    00003000 INTL 20130117)
> May 30 19:21:45 spisula kernel: ACPI: EC: EC started
> May 30 19:21:45 spisula kernel: ACPI: EC: interrupt blocked
> May 30 19:21:45 spisula kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D=
0x62
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC =
used to handle transactions
> May 30 19:21:45 spisula kernel: ACPI: Interpreter enabled
> May 30 19:21:45 spisula kernel: ACPI: PM: (supports S0 S3 S4 S5)
> May 30 19:21:45 spisula kernel: ACPI: Using IOAPIC for interrupt routing
> May 30 19:21:45 spisula kernel: PCI: Using host bridge windows from ACPI;=
 if necessary, use "pci=3Dnocrs" and report a bug
> May 30 19:21:45 spisula kernel: PCI: Using E820 reservations for host bri=
dge windows
> May 30 19:21:45 spisula kernel: ACPI: Enabled 10 GPEs in block 00 to 7F
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.RP01.PXP_: New power res=
ource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.RP02.PXP_: New power res=
ource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.RP02.PXSX.DRST: New powe=
r resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.RP03.PXP_: New power res=
ource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.HS02.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.HS04.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.HS05.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.HS09.IBTU.BTPR=
: New power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.SS02.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.SS04.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.XHC_.RHUB.SS05.UPPR: New=
 power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.USBC: New power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.LSPR: New power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.CNVW.WRST: New power res=
ource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.PAUD: New power resource
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.SDPR: New power resource
> May 30 19:21:45 spisula kernel: ACPI: \_TZ_.FN00: New power resource
> May 30 19:21:45 spisula kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000=
 [bus 00-ff])
> May 30 19:21:45 spisula kernel: acpi PNP0A08:00: _OSC: OS supports [Exten=
dedConfig ASPM ClockPM Segments MSI HPX-Type3]
> May 30 19:21:45 spisula kernel: acpi PNP0A08:00: _OSC: OS now controls [P=
CIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
> May 30 19:21:45 spisula kernel: acpi PNP0A08:00: FADT indicates ASPM is u=
nsupported, using BIOS configuration
> May 30 19:21:45 spisula kernel: acpi PNP0A08:00: [Firmware Info]: ECAM [m=
em 0xe0000000-0xe3ffffff] for domain 0000 [bus 00-3f] only partially covers=
 this bridge
> May 30 19:21:45 spisula kernel: PCI host bridge to bus 0000:00
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [io  0=
x0070-0x0077]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [io  0=
x0000-0x006f window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [io  0=
x0078-0x0cf7 window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [io  0=
x0d00-0xffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
x000a0000-0x000fffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
x7c000001-0xbfffffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xe0000000-0xefffffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfea00000-0xfeafffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed00000-0xfed003ff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed01000-0xfed01fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed03000-0xfed03fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed06000-0xfed06fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed08000-0xfed09fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed80000-0xfedbffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfed1c000-0xfed1cfff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [mem 0=
xfee00000-0xfeefffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: root bus resource [bus 0=
0-ff]
> May 30 19:21:45 spisula kernel: pci 0000:00:00.0: [8086:31f0] type 00 cla=
ss 0x060000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:00.1: [8086:318c] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:00.1: BAR 0 [mem 0x80000000-0=
x80007fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:00.3: [8086:3190] type 00 cla=
ss 0x088000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:00.3: BAR 0 [mem 0xa1318000-0=
xa1318fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: [8086:3185] type 00 cla=
ss 0x030000 PCIe Root Complex Integrated Endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: BAR 0 [mem 0xa0000000-0=
xa0ffffff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: BAR 2 [mem 0x90000000-0=
x9fffffff 64bit pref]
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: BAR 4 [io  0x2000-0x203=
f]
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: Video device with shado=
wed ROM at [mem 0x000c0000-0x000dffff]
> May 30 19:21:45 spisula kernel: pci 0000:00:0c.0: [8086:31dc] type 00 cla=
ss 0x028000 PCIe Root Complex Integrated Endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:0c.0: BAR 0 [mem 0xa1310000-0=
xa1313fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:0c.0: PME# supported from D0 =
D3hot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:0e.0: [8086:3198] type 00 cla=
ss 0x040300 PCIe Root Complex Integrated Endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:0e.0: BAR 0 [mem 0xa1314000-0=
xa1317fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:0e.0: BAR 4 [mem 0xa1000000-0=
xa10fffff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:0e.0: PME# supported from D0 =
D3hot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:0f.0: [8086:319a] type 00 cla=
ss 0x078000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:0f.0: BAR 0 [mem 0xa1319000-0=
xa1319fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:0f.0: PME# supported from D3h=
ot
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: [8086:31d8] type 01 cla=
ss 0x060400 PCIe Root Port
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: PCI bridge to [bus 01]
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0:   bridge window [mem 0x=
a1200000-0xa12fffff]
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: PME# supported from D0 =
D3hot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: [8086:31d6] type 01 cla=
ss 0x060400 PCIe Root Port
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: PCI bridge to [bus 02]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0:   bridge window [io  0x=
1000-0x1fff]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0:   bridge window [mem 0x=
a1100000-0xa11fffff]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: PME# supported from D0 =
D3hot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:15.0: [8086:31a8] type 00 cla=
ss 0x0c0330 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:15.0: BAR 0 [mem 0xa1300000-0=
xa130ffff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:15.0: PME# supported from D3h=
ot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:16.0: [8086:31ac] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:16.0: BAR 0 [mem 0xa131a000-0=
xa131afff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:16.0: BAR 2 [mem 0xa131b000-0=
xa131bfff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:16.3: [8086:31b2] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:16.3: BAR 0 [mem 0xa131c000-0=
xa131cfff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:16.3: BAR 2 [mem 0xa131d000-0=
xa131dfff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.0: [8086:31b4] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:17.0: BAR 0 [mem 0xa131e000-0=
xa131efff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.0: BAR 2 [mem 0xa131f000-0=
xa131ffff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.1: [8086:31b6] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:17.1: BAR 0 [mem 0xa1320000-0=
xa1320fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.1: BAR 2 [mem 0xa1321000-0=
xa1321fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.2: [8086:31b8] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:17.2: BAR 0 [mem 0xa1322000-0=
xa1322fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:17.2: BAR 2 [mem 0xa1323000-0=
xa1323fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.0: [8086:31bc] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:18.0: BAR 0 [mem 0xa1324000-0=
xa1324fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.0: BAR 2 [mem 0xa1325000-0=
xa1325fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.1: [8086:31be] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:18.1: BAR 0 [mem 0xa1326000-0=
xa1326fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.1: BAR 2 [mem 0xa1327000-0=
xa1327fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.3: [8086:31ee] type 00 cla=
ss 0x118000 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:18.3: BAR 0 [mem 0xa1328000-0=
xa1328fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:18.3: BAR 2 [mem 0xa1329000-0=
xa1329fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:1c.0: [8086:31cc] type 00 cla=
ss 0x080501 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:1c.0: BAR 0 [mem 0xa132a000-0=
xa132afff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:1c.0: BAR 2 [mem 0xa132b000-0=
xa132bfff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.0: [8086:31e8] type 00 cla=
ss 0x060100 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.1: [8086:31d4] type 00 cla=
ss 0x0c0500 conventional PCI endpoint
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.1: BAR 0 [mem 0xa132c000-0=
xa132c0ff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.1: BAR 4 [io  0x2040-0x205=
f]
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: [2646:500d] type 00 cla=
ss 0x010802 PCIe Endpoint
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: BAR 0 [mem 0xa1200000-0=
xa1203fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: Upstream bridge's Max P=
ayload Size set to 128 (was 256, max 256)
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: Max Payload Size set to=
 128 (was 128, max 128)
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: 16.000 Gb/s available P=
CIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:13.0 (capable of=
 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: PCI bridge to [bus 01]
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: [10ec:8168] type 00 cla=
ss 0x020000 PCIe Endpoint
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: BAR 0 [io  0x1000-0x10f=
f]
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: BAR 2 [mem 0xa1104000-0=
xa1104fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: BAR 4 [mem 0xa1100000-0=
xa1103fff 64bit]
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: Upstream bridge's Max P=
ayload Size set to 128 (was 256, max 256)
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: Max Payload Size set to=
 128 (was 128, max 128)
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: supports D1 D2
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: PME# supported from D0 =
D1 D2 D3hot D3cold
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: PCI bridge to [bus 02]
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKA configured=
 for IRQ 3
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKB configured=
 for IRQ 4
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKC configured=
 for IRQ 5
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKD configured=
 for IRQ 6
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKE configured=
 for IRQ 7
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKF configured=
 for IRQ 9
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKG configured=
 for IRQ 10
> May 30 19:21:45 spisula kernel: ACPI: PCI: Interrupt link LNKH configured=
 for IRQ 11
> May 30 19:21:45 spisula kernel: ACPI Warning: GPE type mismatch (level/ed=
ge) (20240827/evxface-791)
> May 30 19:21:45 spisula kernel: ACPI: EC: interrupt unblocked
> May 30 19:21:45 spisula kernel: ACPI: EC: event unblocked
> May 30 19:21:45 spisula kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D=
0x62
> May 30 19:21:45 spisula kernel: ACPI: EC: GPE=3D0x25
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.LPCB.H_EC: Boot DSDT EC =
initialization complete
> May 30 19:21:45 spisula kernel: ACPI: \_SB_.PCI0.LPCB.H_EC: EC: Used to h=
andle transactions and events
> May 30 19:21:45 spisula kernel: iommu: Default domain type: Translated
> May 30 19:21:45 spisula kernel: iommu: DMA domain TLB invalidation policy=
: lazy mode
> May 30 19:21:45 spisula kernel: pps_core: LinuxPPS API ver. 1 registered
> May 30 19:21:45 spisula kernel: pps_core: Software ver. 5.3.6 - Copyright=
 2005-2007 Rodolfo Giometti <giometti@linux.it>
> May 30 19:21:45 spisula kernel: PTP clock support registered
> May 30 19:21:45 spisula kernel: EDAC MC: Ver: 3.0.0
> May 30 19:21:45 spisula kernel: efivars: Registered efivars operations
> May 30 19:21:45 spisula kernel: NetLabel: Initializing
> May 30 19:21:45 spisula kernel: NetLabel:  domain hash size =3D 128
> May 30 19:21:45 spisula kernel: NetLabel:  protocols =3D UNLABELED CIPSOv=
4 CALIPSO
> May 30 19:21:45 spisula kernel: NetLabel:  unlabeled traffic allowed by d=
efault
> May 30 19:21:45 spisula kernel: PCI: Using ACPI for IRQ routing
> May 30 19:21:45 spisula kernel: PCI: pci_cache_line_size set to 64 bytes
> May 30 19:21:45 spisula kernel: resource: Expanded resource Reserved due =
to conflict with PCI Bus 0000:00
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x00058000-=
0x0005ffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x0009e000-=
0x0009ffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x66fcd000-=
0x67ffffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x7176c000-=
0x73ffffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x74480000-=
0x77ffffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x78d5a000-=
0x7bffffff]
> May 30 19:21:45 spisula kernel: e820: reserve RAM buffer [mem 0x79c00000-=
0x7bffffff]
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: vgaarb: setting as boot=
 VGA device
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: vgaarb: bridge control =
possible
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: vgaarb: VGA device adde=
d: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
> May 30 19:21:45 spisula kernel: vgaarb: loaded
> May 30 19:21:45 spisula kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, =
0, 0, 0, 0, 0
> May 30 19:21:45 spisula kernel: hpet0: 8 comparators, 64-bit 19.200000 MH=
z counter
> May 30 19:21:45 spisula kernel: clocksource: Switched to clocksource tsc-=
early
> May 30 19:21:45 spisula kernel: VFS: Disk quotas dquot_6.6.0
> May 30 19:21:45 spisula kernel: VFS: Dquot-cache hash table entries: 512 =
(order 0, 4096 bytes)
> May 30 19:21:45 spisula kernel: AppArmor: AppArmor Filesystem Enabled
> May 30 19:21:45 spisula kernel: pnp: PnP ACPI init
> May 30 19:21:45 spisula kernel: pnp 00:00: disabling [io  0x164e-0x164f] =
because it overlaps 0000:00:14.0 BAR 13 [io  0x1000-0x1fff]
> May 30 19:21:45 spisula kernel: system 00:00: [io  0x0680-0x069f] has bee=
n reserved
> May 30 19:21:45 spisula kernel: system 00:00: [io  0x0400-0x047f] could n=
ot be reserved
> May 30 19:21:45 spisula kernel: system 00:00: [io  0x0500-0x05fe] has bee=
n reserved
> May 30 19:21:45 spisula kernel: system 00:00: [io  0x0600-0x061f] has bee=
n reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xe0000000-0xefffffff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfea00000-0xfeafffff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed01000-0xfed01fff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed03000-0xfed03fff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed06000-0xfed06fff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed08000-0xfed09fff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed80000-0xfedbffff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfed1c000-0xfed1cfff]=
 has been reserved
> May 30 19:21:45 spisula kernel: system 00:02: [mem 0xfee00000-0xfeefffff]=
 has been reserved
> May 30 19:21:45 spisula kernel: pnp: PnP ACPI: found 4 devices
> May 30 19:21:45 spisula kernel: clocksource: acpi_pm: mask: 0xffffff max_=
cycles: 0xffffff, max_idle_ns: 2085701024 ns
> May 30 19:21:45 spisula kernel: NET: Registered PF_INET protocol family
> May 30 19:21:45 spisula kernel: IP idents hash table entries: 65536 (orde=
r: 7, 524288 bytes, linear)
> May 30 19:21:45 spisula kernel: tcp_listen_portaddr_hash hash table entri=
es: 2048 (order: 3, 32768 bytes, linear)
> May 30 19:21:45 spisula kernel: Table-perturb hash table entries: 65536 (=
order: 6, 262144 bytes, linear)
> May 30 19:21:45 spisula kernel: TCP established hash table entries: 32768=
 (order: 6, 262144 bytes, linear)
> May 30 19:21:45 spisula kernel: TCP bind hash table entries: 32768 (order=
: 8, 1048576 bytes, linear)
> May 30 19:21:45 spisula kernel: TCP: Hash tables configured (established =
32768 bind 32768)
> May 30 19:21:45 spisula kernel: MPTCP token hash table entries: 4096 (ord=
er: 4, 98304 bytes, linear)
> May 30 19:21:45 spisula kernel: UDP hash table entries: 2048 (order: 4, 6=
5536 bytes, linear)
> May 30 19:21:45 spisula kernel: UDP-Lite hash table entries: 2048 (order:=
 4, 65536 bytes, linear)
> May 30 19:21:45 spisula kernel: NET: Registered PF_UNIX/PF_LOCAL protocol=
 family
> May 30 19:21:45 spisula kernel: NET: Registered PF_XDP protocol family
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: PCI bridge to [bus 01]
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0:   bridge window [mem 0x=
a1200000-0xa12fffff]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: PCI bridge to [bus 02]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0:   bridge window [io  0x=
1000-0x1fff]
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0:   bridge window [mem 0x=
a1100000-0xa11fffff]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 4 [io  0x0070-0=
x0077]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 5 [io  0x0000-0=
x006f window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 6 [io  0x0078-0=
x0cf7 window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 7 [io  0x0d00-0=
xffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 8 [mem 0x000a00=
00-0x000fffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 9 [mem 0x7c0000=
01-0xbfffffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 10 [mem 0xe0000=
000-0xefffffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 11 [mem 0xfea00=
000-0xfeafffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 12 [mem 0xfed00=
000-0xfed003ff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 13 [mem 0xfed01=
000-0xfed01fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 14 [mem 0xfed03=
000-0xfed03fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 15 [mem 0xfed06=
000-0xfed06fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 16 [mem 0xfed08=
000-0xfed09fff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 17 [mem 0xfed80=
000-0xfedbffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 18 [mem 0xfed1c=
000-0xfed1cfff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:00: resource 19 [mem 0xfee00=
000-0xfeefffff window]
> May 30 19:21:45 spisula kernel: pci_bus 0000:01: resource 1 [mem 0xa12000=
00-0xa12fffff]
> May 30 19:21:45 spisula kernel: pci_bus 0000:02: resource 0 [io  0x1000-0=
x1fff]
> May 30 19:21:45 spisula kernel: pci_bus 0000:02: resource 1 [mem 0xa11000=
00-0xa11fffff]
> May 30 19:21:45 spisula kernel: PCI: CLS 64 bytes, default 64
> May 30 19:21:45 spisula kernel: DMAR: No ATSR found
> May 30 19:21:45 spisula kernel: DMAR: No SATC found
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature fl1gp_support inconsi=
stent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature pgsel_inv inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature nwfs inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature eafs inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature prs inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature nest inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature mts inconsistent
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature sc_support inconsiste=
nt
> May 30 19:21:45 spisula kernel: DMAR: IOMMU feature dev_iotlb_support inc=
onsistent
> May 30 19:21:45 spisula kernel: DMAR: dmar0: Using Queued invalidation
> May 30 19:21:45 spisula kernel: DMAR: dmar1: Using Queued invalidation
> May 30 19:21:45 spisula kernel: Trying to unpack rootfs image as initramf=
s...
> May 30 19:21:45 spisula kernel: pci 0000:00:02.0: Adding to iommu group 0
> May 30 19:21:45 spisula kernel: pci 0000:00:00.0: Adding to iommu group 1
> May 30 19:21:45 spisula kernel: pci 0000:00:00.1: Adding to iommu group 1
> May 30 19:21:45 spisula kernel: pci 0000:00:00.3: Adding to iommu group 1
> May 30 19:21:45 spisula kernel: pci 0000:00:0c.0: Adding to iommu group 2
> May 30 19:21:45 spisula kernel: pci 0000:00:0e.0: Adding to iommu group 3
> May 30 19:21:45 spisula kernel: pci 0000:00:0f.0: Adding to iommu group 4
> May 30 19:21:45 spisula kernel: pci 0000:00:13.0: Adding to iommu group 5
> May 30 19:21:45 spisula kernel: pci 0000:00:14.0: Adding to iommu group 6
> May 30 19:21:45 spisula kernel: pci 0000:00:15.0: Adding to iommu group 7
> May 30 19:21:45 spisula kernel: pci 0000:00:16.0: Adding to iommu group 8
> May 30 19:21:45 spisula kernel: pci 0000:00:16.3: Adding to iommu group 8
> May 30 19:21:45 spisula kernel: pci 0000:00:17.0: Adding to iommu group 9
> May 30 19:21:45 spisula kernel: pci 0000:00:17.1: Adding to iommu group 9
> May 30 19:21:45 spisula kernel: pci 0000:00:17.2: Adding to iommu group 9
> May 30 19:21:45 spisula kernel: pci 0000:00:18.0: Adding to iommu group 10
> May 30 19:21:45 spisula kernel: pci 0000:00:18.1: Adding to iommu group 10
> May 30 19:21:45 spisula kernel: pci 0000:00:18.3: Adding to iommu group 10
> May 30 19:21:45 spisula kernel: pci 0000:00:1c.0: Adding to iommu group 11
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.0: Adding to iommu group 12
> May 30 19:21:45 spisula kernel: pci 0000:00:1f.1: Adding to iommu group 12
> May 30 19:21:45 spisula kernel: pci 0000:01:00.0: Adding to iommu group 13
> May 30 19:21:45 spisula kernel: pci 0000:02:00.0: Adding to iommu group 14
> May 30 19:21:45 spisula kernel: DMAR: Intel(R) Virtualization Technology =
for Directed I/O
> May 30 19:21:45 spisula kernel: PCI-DMA: Using software bounce buffering =
for IO (SWIOTLB)
> May 30 19:21:45 spisula kernel: software IO TLB: mapped [mem 0x000000006d=
61a000-0x000000007161a000] (64MB)
> May 30 19:21:45 spisula kernel: clocksource: tsc: mask: 0xfffffffffffffff=
f max_cycles: 0xfc66f4fc7c, max_idle_ns: 440795224246 ns
> May 30 19:21:45 spisula kernel: clocksource: Switched to clocksource tsc
> May 30 19:21:45 spisula kernel: Initialise system trusted keyrings
> May 30 19:21:45 spisula kernel: Key type blacklist registered
> May 30 19:21:45 spisula kernel: workingset: timestamp_bits=3D36 max_order=
=3D20 bucket_order=3D0
> May 30 19:21:45 spisula kernel: zbud: loaded
> May 30 19:21:45 spisula kernel: fuse: init (API version 7.41)
> May 30 19:21:45 spisula kernel: integrity: Platform Keyring initialized
> May 30 19:21:45 spisula kernel: integrity: Machine keyring initialized
> May 30 19:21:45 spisula kernel: Key type asymmetric registered
> May 30 19:21:45 spisula kernel: Asymmetric key parser 'x509' registered
> May 30 19:21:45 spisula kernel: Freeing initrd memory: 53360K
> May 30 19:21:45 spisula kernel: Block layer SCSI generic (bsg) driver ver=
sion 0.4 loaded (major 246)
> May 30 19:21:45 spisula kernel: io scheduler mq-deadline registered
> May 30 19:21:45 spisula kernel: ledtrig-cpu: registered to indicate activ=
ity on CPUs
> May 30 19:21:45 spisula kernel: pcieport 0000:00:13.0: PME: Signaling wit=
h IRQ 122
> May 30 19:21:45 spisula kernel: pcieport 0000:00:14.0: PME: Signaling wit=
h IRQ 123
> May 30 19:21:45 spisula kernel: shpchp: Standard Hot Plug PCI Controller =
Driver version: 0.4
> May 30 19:21:45 spisula kernel: ACPI: \_TZ_.TZ01: _AL0 evaluation failure
> May 30 19:21:45 spisula kernel: thermal LNXTHERM:00: registered as therma=
l_zone0
> May 30 19:21:45 spisula kernel: ACPI: thermal: Thermal Zone [TZ01] (39 C)
> May 30 19:21:45 spisula kernel: Serial: 8250/16550 driver, 4 ports, IRQ s=
haring enabled
> May 30 19:21:45 spisula kernel: Linux agpgart interface v0.103
> May 30 19:21:45 spisula kernel: tpm_tis MSFT0101:00: 2.0 TPM (device-id 0=
x1B, rev-id 22)
> May 30 19:21:45 spisula kernel: i8042: PNP: PS/2 Controller [PNP0303:PS2K=
] at 0x60,0x64 irq 1
> May 30 19:21:45 spisula kernel: i8042: PNP: PS/2 appears to have AUX port=
 disabled, if this is incorrect please boot with i8042.nopnp
> May 30 19:21:45 spisula kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> May 30 19:21:45 spisula kernel: mousedev: PS/2 mouse device common for al=
l mice
> May 30 19:21:45 spisula kernel: rtc_cmos 00:03: RTC can wake from S4
> May 30 19:21:45 spisula kernel: rtc_cmos 00:03: registered as rtc0
> May 30 19:21:45 spisula kernel: rtc_cmos 00:03: setting system clock to 2=
025-05-30T17:21:37 UTC (1748625697)
> May 30 19:21:45 spisula kernel: rtc_cmos 00:03: alarms up to one month, y=
3k, 242 bytes nvram
> May 30 19:21:45 spisula kernel: intel_pstate: Intel P-state driver initia=
lizing
> May 30 19:21:45 spisula kernel: efifb: probing for efifb
> May 30 19:21:45 spisula kernel: efifb: framebuffer at 0x90000000, using 4=
128k, total 4128k
> May 30 19:21:45 spisula kernel: efifb: mode is 1366x768x32, linelength=3D=
5504, pages=3D1
> May 30 19:21:45 spisula kernel: efifb: scrolling: redraw
> May 30 19:21:45 spisula kernel: efifb: Truecolor: size=3D8:8:8:8, shift=
=3D24:16:8:0
> May 30 19:21:45 spisula kernel: Console: switching to colour frame buffer=
 device 170x48
> May 30 19:21:45 spisula kernel: fb0: EFI VGA frame buffer device
> May 30 19:21:45 spisula kernel: NET: Registered PF_INET6 protocol family
> May 30 19:21:45 spisula kernel: input: AT Translated Set 2 keyboard as /d=
evices/platform/i8042/serio0/input/input0
> May 30 19:21:45 spisula kernel: Segment Routing with IPv6
> May 30 19:21:45 spisula kernel: In-situ OAM (IOAM) with IPv6
> May 30 19:21:45 spisula kernel: mip6: Mobile IPv6
> May 30 19:21:45 spisula kernel: NET: Registered PF_PACKET protocol family
> May 30 19:21:45 spisula kernel: mpls_gso: MPLS GSO support
> May 30 19:21:45 spisula kernel: microcode: Current revision: 0x00000026
> May 30 19:21:45 spisula kernel: microcode: Updated early from: 0x0000001a
> May 30 19:21:45 spisula kernel: resctrl: L2 allocation detected
> May 30 19:21:45 spisula kernel: IPI shorthand broadcast: enabled
> May 30 19:21:45 spisula kernel: sched_clock: Marking stable (1464003015, =
1124137)->(1472340122, -7212970)
> May 30 19:21:45 spisula kernel: registered taskstats version 1
> May 30 19:21:45 spisula kernel: Loading compiled-in X.509 certificates
> May 30 19:21:45 spisula kernel: Loaded X.509 cert 'Build time autogenerat=
ed kernel key: d2b9abca7af4f2327abcd1e5dc64d5307b4debb2'
> May 30 19:21:45 spisula kernel: Demotion targets for Node 0: null
> May 30 19:21:45 spisula kernel: Key type .fscrypt registered
> May 30 19:21:45 spisula kernel: Key type fscrypt-provisioning registered
> May 30 19:21:45 spisula kernel: Key type encrypted registered
> May 30 19:21:45 spisula kernel: AppArmor: AppArmor sha256 policy hashing =
enabled
> May 30 19:21:45 spisula kernel: integrity: Loading X.509 certificate: UEF=
I:db
> May 30 19:21:45 spisula kernel: integrity: Loaded X.509 cert 'Microsoft W=
indows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> May 30 19:21:45 spisula kernel: integrity: Loading X.509 certificate: UEF=
I:db
> May 30 19:21:45 spisula kernel: integrity: Loaded X.509 cert 'Microsoft C=
orporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> May 30 19:21:45 spisula kernel: integrity: Loading X.509 certificate: UEF=
I:db
> May 30 19:21:45 spisula kernel: integrity: Loaded X.509 cert 'Acer Databa=
se: 84f00f5841571abd2cc11a8c26d5c9c8d2b6b0b5'
> May 30 19:21:45 spisula kernel: integrity: Loading X.509 certificate: UEF=
I:db
> May 30 19:21:45 spisula kernel: integrity: Loaded X.509 cert 'HQSecureFla=
sh: b78a58299f3b8dbd4064615a6e85365a'
> May 30 19:21:45 spisula kernel: integrity: Loading X.509 certificate: UEF=
I:MokListRT (MOKvar table)
> May 30 19:21:45 spisula kernel: integrity: Loaded X.509 cert 'Debian Secu=
re Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
> May 30 19:21:45 spisula kernel: ima: Allocated hash algorithm: sha256
> May 30 19:21:45 spisula kernel: audit: type=3D1807 audit(1748625697.939:2=
): action=3Dmeasure func=3DKEXEC_KERNEL_CHECK res=3D1
> May 30 19:21:45 spisula kernel: audit: type=3D1807 audit(1748625697.939:3=
): action=3Dmeasure func=3DMODULE_CHECK res=3D1
> May 30 19:21:45 spisula kernel: evm: Initialising EVM extended attributes:
> May 30 19:21:45 spisula kernel: evm: security.selinux
> May 30 19:21:45 spisula kernel: evm: security.SMACK64 (disabled)
> May 30 19:21:45 spisula kernel: evm: security.SMACK64EXEC (disabled)
> May 30 19:21:45 spisula kernel: evm: security.SMACK64TRANSMUTE (disabled)
> May 30 19:21:45 spisula kernel: evm: security.SMACK64MMAP (disabled)
> May 30 19:21:45 spisula kernel: evm: security.apparmor
> May 30 19:21:45 spisula kernel: evm: security.ima
> May 30 19:21:45 spisula kernel: evm: security.capability
> May 30 19:21:45 spisula kernel: evm: HMAC attrs: 0x1
> May 30 19:21:45 spisula kernel: RAS: Correctable Errors collector initial=
ized.
> May 30 19:21:45 spisula kernel: Lockdown: swapper/0: hibernation is restr=
icted; see man kernel_lockdown.7
> May 30 19:21:45 spisula kernel: clk: Disabling unused clocks
> May 30 19:21:45 spisula kernel: PM: genpd: Disabling unused power domains
> May 30 19:21:45 spisula kernel: Freeing unused decrypted memory: 2028K
> May 30 19:21:45 spisula kernel: Freeing unused kernel image (initmem) mem=
ory: 4148K
> May 30 19:21:45 spisula kernel: Write protecting the kernel read-only dat=
a: 28672k
> May 30 19:21:45 spisula kernel: Freeing unused kernel image (rodata/data =
gap) memory: 508K
> May 30 19:21:45 spisula kernel: x86/mm: Checked W+X mappings: passed, no =
W+X pages found.
> May 30 19:21:45 spisula kernel: Run /init as init process
> May 30 19:21:45 spisula kernel:   with arguments:
> May 30 19:21:45 spisula kernel:     /init
> May 30 19:21:45 spisula kernel:   with environment:
> May 30 19:21:45 spisula kernel:     HOME=3D/
> May 30 19:21:45 spisula kernel:     TERM=3Dlinux
> May 30 19:21:45 spisula kernel:     BOOT_IMAGE=3D/vmlinuz-6.12.29-amd64
> May 30 19:21:45 spisula kernel: tpm tpm0: auth session is active
> May 30 19:21:45 spisula kernel: wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug=
]: WMBF method block execution control method not found
> May 30 19:21:45 spisula kernel: ACPI: bus type drm_connector registered
> May 30 19:21:45 spisula kernel: lpc_ich 0000:00:1f.0: No MFD cells added
> May 30 19:21:45 spisula kernel: ACPI: battery: Slot [BAT0] (battery prese=
nt)
> May 30 19:21:45 spisula kernel: cryptd: max_cpu_qlen set to 1000
> May 30 19:21:45 spisula kernel: sdhci: Secure Digital Host Controller Int=
erface driver
> May 30 19:21:45 spisula kernel: sdhci: Copyright(c) Pierre Ossman
> May 30 19:21:45 spisula kernel: i801_smbus 0000:00:1f.1: SPD Write Disabl=
e is set
> May 30 19:21:45 spisula kernel: i801_smbus 0000:00:1f.1: SMBus using PCI =
interrupt
> May 30 19:21:45 spisula kernel: hid: raw HID events driver (C) Jiri Kosina
> May 30 19:21:45 spisula kernel: ACPI: bus type USB registered
> May 30 19:21:45 spisula kernel: usbcore: registered new interface driver =
usbfs
> May 30 19:21:45 spisula kernel: usbcore: registered new interface driver =
hub
> May 30 19:21:45 spisula kernel: usbcore: registered new device driver usb
> May 30 19:21:45 spisula kernel: idma64 idma64.0: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: idma64 idma64.1: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: idma64 idma64.2: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: idma64 idma64.3: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: idma64 idma64.4: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: idma64 idma64.5: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: dw-apb-uart.5: ttyS0 at MMIO 0xa1324000 (=
irq =3D 4, base_baud =3D 115200) is a 16550A
> May 30 19:21:45 spisula kernel: idma64 idma64.6: Found Intel integrated D=
MA 64-bit
> May 30 19:21:45 spisula kernel: dw-apb-uart.6: ttyS1 at MMIO 0xa1326000 (=
irq =3D 5, base_baud =3D 115200) is a 16550A
> May 30 19:21:45 spisula kernel: dw-apb-uart.7: ttyS2 at MMIO 0xa1328000 (=
irq =3D 7, base_baud =3D 115200) is a 16550A
> May 30 19:21:45 spisula kernel: nvme nvme0: pci function 0000:01:00.0
> May 30 19:21:45 spisula kernel: nvme nvme0: missing or invalid SUBNQN fie=
ld.
> May 30 19:21:45 spisula kernel: nvme nvme0: 4/0/0 default/read/poll queues
> May 30 19:21:45 spisula kernel:  nvme0n1: p1 p2 p3
> May 30 19:21:45 spisula kernel: r8169 0000:02:00.0: can't disable ASPM; O=
S doesn't have ASPM control
> May 30 19:21:45 spisula kernel: r8169 0000:02:00.0 eth0: RTL8168h/8111h, =
78:72:64:39:a4:b2, XID 541, IRQ 129
> May 30 19:21:45 spisula kernel: r8169 0000:02:00.0 eth0: jumbo features [=
frames: 9194 bytes, tx checksumming: ko]
> May 30 19:21:45 spisula kernel: r8169 0000:02:00.0 enp2s0: renamed from e=
th0
> May 30 19:21:45 spisula kernel: sdhci-pci 0000:00:1c.0: SDHCI controller =
found [8086:31cc] (rev 6)
> May 30 19:21:45 spisula kernel: mmc0: CQHCI version 5.10
> May 30 19:21:45 spisula kernel: mmc0: SDHCI controller on PCI [0000:00:1c=
=2E0] using ADMA 64-bit
> May 30 19:21:45 spisula kernel: i2c_hid_acpi i2c-ELAN9004:00: i2c_hid_get=
_input: IRQ triggered but there's no data
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: xHCI Host Controll=
er
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: new USB bus regist=
ered, assigned bus number 1
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: hcc params 0x20007=
7c1 hci version 0x100 quirks 0x0000000000009810
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: xHCI Host Controll=
er
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: new USB bus regist=
ered, assigned bus number 2
> May 30 19:21:45 spisula kernel: xhci_hcd 0000:00:15.0: Host supports USB =
3.0 SuperSpeed
> May 30 19:21:45 spisula kernel: usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002, bcdDevice=3D 6.12
> May 30 19:21:45 spisula kernel: usb usb1: New USB device strings: Mfr=3D3=
, Product=3D2, SerialNumber=3D1
> May 30 19:21:45 spisula kernel: usb usb1: Product: xHCI Host Controller
> May 30 19:21:45 spisula kernel: usb usb1: Manufacturer: Linux 6.12.29-amd=
64 xhci-hcd
> May 30 19:21:45 spisula kernel: usb usb1: SerialNumber: 0000:00:15.0
> May 30 19:21:45 spisula kernel: hub 1-0:1.0: USB hub found
> May 30 19:21:45 spisula kernel: hub 1-0:1.0: 9 ports detected
> May 30 19:21:45 spisula kernel: usb usb2: New USB device found, idVendor=
=3D1d6b, idProduct=3D0003, bcdDevice=3D 6.12
> May 30 19:21:45 spisula kernel: usb usb2: New USB device strings: Mfr=3D3=
, Product=3D2, SerialNumber=3D1
> May 30 19:21:45 spisula kernel: usb usb2: Product: xHCI Host Controller
> May 30 19:21:45 spisula kernel: usb usb2: Manufacturer: Linux 6.12.29-amd=
64 xhci-hcd
> May 30 19:21:45 spisula kernel: usb usb2: SerialNumber: 0000:00:15.0
> May 30 19:21:45 spisula kernel: hub 2-0:1.0: USB hub found
> May 30 19:21:45 spisula kernel: hub 2-0:1.0: 7 ports detected
> May 30 19:21:45 spisula kernel: mmc0: Failed to initialize a non-removabl=
e card
> May 30 19:21:45 spisula kernel: input: ELAN050C:00 04F3:3149 Mouse as /de=
vices/pci0000:00/0000:00:17.2/i2c_designware.4/i2c-5/i2c-ELAN050C:00/0018:0=
4F3:3149.0001/input/input1
> May 30 19:21:45 spisula kernel: input: ELAN050C:00 04F3:3149 Touchpad as =
/devices/pci0000:00/0000:00:17.2/i2c_designware.4/i2c-5/i2c-ELAN050C:00/001=
8:04F3:3149.0001/input/input3
> May 30 19:21:45 spisula kernel: hid-generic 0018:04F3:3149.0001: input,hi=
draw0: I2C HID v1.00 Mouse [ELAN050C:00 04F3:3149] on i2c-ELAN050C:00
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 Touchscreen =
as /devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/=
0018:04F3:2D58.0002/input/input4
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 as /devices/=
pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/0018:04F3:2D=
58.0002/input/input5
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 as /devices/=
pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/0018:04F3:2D=
58.0002/input/input6
> May 30 19:21:45 spisula kernel: hid-generic 0018:04F3:2D58.0002: input,hi=
draw1: I2C HID v1.00 Device [ELAN9004:00 04F3:2D58] on i2c-ELAN9004:00
> May 30 19:21:45 spisula kernel: input: ELAN050C:00 04F3:3149 Mouse as /de=
vices/pci0000:00/0000:00:17.2/i2c_designware.4/i2c-5/i2c-ELAN050C:00/0018:0=
4F3:3149.0001/input/input8
> May 30 19:21:45 spisula kernel: input: ELAN050C:00 04F3:3149 Touchpad as =
/devices/pci0000:00/0000:00:17.2/i2c_designware.4/i2c-5/i2c-ELAN050C:00/001=
8:04F3:3149.0001/input/input10
> May 30 19:21:45 spisula kernel: hid-multitouch 0018:04F3:3149.0001: input=
,hidraw0: I2C HID v1.00 Mouse [ELAN050C:00 04F3:3149] on i2c-ELAN050C:00
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 as /devices/=
pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/0018:04F3:2D=
58.0002/input/input11
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 UNKNOWN as /=
devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/0018=
:04F3:2D58.0002/input/input12
> May 30 19:21:45 spisula kernel: input: ELAN9004:00 04F3:2D58 UNKNOWN as /=
devices/pci0000:00/0000:00:17.1/i2c_designware.3/i2c-4/i2c-ELAN9004:00/0018=
:04F3:2D58.0002/input/input13
> May 30 19:21:45 spisula kernel: hid-multitouch 0018:04F3:2D58.0002: input=
,hidraw1: I2C HID v1.00 Device [ELAN9004:00 04F3:2D58] on i2c-ELAN9004:00
> May 30 19:21:45 spisula kernel: usb 1-2: new high-speed USB device number=
 2 using xhci_hcd
> May 30 19:21:45 spisula kernel: device-mapper: core: CONFIG_IMA_DISABLE_H=
TABLE is disabled. Duplicate IMA measurements will not be recorded in the I=
MA log.
> May 30 19:21:45 spisula kernel: device-mapper: uevent: version 1.0.3
> May 30 19:21:45 spisula kernel: device-mapper: ioctl: 4.48.0-ioctl (2023-=
03-01) initialised: dm-devel@lists.linux.dev
> May 30 19:21:45 spisula kernel: usb 1-2: New USB device found, idVendor=
=3D04f2, idProduct=3Db6db, bcdDevice=3D62.27
> May 30 19:21:45 spisula kernel: usb 1-2: New USB device strings: Mfr=3D3,=
 Product=3D1, SerialNumber=3D2
> May 30 19:21:45 spisula kernel: usb 1-2: Product: 5MP World Facing
> May 30 19:21:45 spisula kernel: usb 1-2: Manufacturer: Chicony Electronic=
s Co.,Ltd.
> May 30 19:21:45 spisula kernel: usb 1-2: SerialNumber: 0001
> May 30 19:21:45 spisula kernel: usb 1-7: new high-speed USB device number=
 3 using xhci_hcd
> May 30 19:21:45 spisula kernel: usb 1-7: New USB device found, idVendor=
=3D0408, idProduct=3Da061, bcdDevice=3D 0.04
> May 30 19:21:45 spisula kernel: usb 1-7: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D0
> May 30 19:21:45 spisula kernel: usb 1-7: Product: HD User Facing
> May 30 19:21:45 spisula kernel: usb 1-7: Manufacturer: SunplusIT Inc
> May 30 19:21:45 spisula kernel: usb 1-8: new high-speed USB device number=
 4 using xhci_hcd
> May 30 19:21:45 spisula kernel: usb 1-8: New USB device found, idVendor=
=3D0bda, idProduct=3D0129, bcdDevice=3D39.60
> May 30 19:21:45 spisula kernel: usb 1-8: New USB device strings: Mfr=3D1,=
 Product=3D2, SerialNumber=3D3
> May 30 19:21:45 spisula kernel: usb 1-8: Product: USB2.0-CRW
> May 30 19:21:45 spisula kernel: usb 1-8: Manufacturer: Generic
> May 30 19:21:45 spisula kernel: usb 1-8: SerialNumber: 20100201396000000
> May 30 19:21:45 spisula kernel: usb 1-9: new full-speed USB device number=
 5 using xhci_hcd
> May 30 19:21:45 spisula kernel: usbcore: registered new interface driver =
rtsx_usb
> May 30 19:21:45 spisula kernel: usb 1-9: New USB device found, idVendor=
=3D8087, idProduct=3D0aaa, bcdDevice=3D 0.02
> May 30 19:21:46 spisula kernel: usb 1-9: New USB device strings: Mfr=3D0,=
 Product=3D0, SerialNumber=3D0
> May 30 19:21:46 spisula kernel: Lockdown: resume: hibernation is restrict=
ed; see man kernel_lockdown.7
> May 30 19:21:46 spisula kernel: EXT4-fs (dm-1): mounted filesystem af843d=
99-0ced-4405-b68d-4f56cdc24cb4 ro with ordered data mode. Quota mode: none.
> May 30 19:21:46 spisula kernel: Not activating Mandatory Access Control a=
s /sbin/tomoyo-init does not exist.
> May 30 19:21:46 spisula systemd[1]: Inserted module 'autofs4'
> May 30 19:21:46 spisula systemd[1]: systemd 257.5-2 running in system mod=
e (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS=
 +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRY=
PTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCOD=
E +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +S=
YSVINIT +LIBARCHIVE)
> May 30 19:21:46 spisula systemd[1]: Detected architecture x86-64.
> May 30 19:21:46 spisula systemd[1]: Hostname set to <spisula>.
> May 30 19:21:46 spisula kernel: Lockdown: systemd: /dev/mem,kmem,port is =
restricted; see man kernel_lockdown.7
> May 30 19:21:46 spisula systemd[1]: bpf-restrict-fs: LSM BPF program atta=
ched
> May 30 19:21:46 spisula systemd[1]: Queued start job for default target g=
raphical.target.
> May 30 19:21:46 spisula systemd[1]: Created slice system-getty.slice - Sl=
ice /system/getty.
> May 30 19:21:46 spisula systemd[1]: Created slice system-modprobe.slice -=
 Slice /system/modprobe.
> May 30 19:21:46 spisula systemd[1]: Created slice system-systemd\x2dfsck.=
slice - Slice /system/systemd-fsck.
> May 30 19:21:46 spisula systemd[1]: Created slice user.slice - User and S=
ession Slice.
> May 30 19:21:46 spisula systemd[1]: Started systemd-ask-password-console.=
path - Dispatch Password Requests to Console Directory Watch.
> May 30 19:21:46 spisula systemd[1]: Started systemd-ask-password-wall.pat=
h - Forward Password Requests to Wall Directory Watch.
> May 30 19:21:46 spisula systemd[1]: Set up automount proc-sys-fs-binfmt_m=
isc.automount - Arbitrary Executable File Formats File System Automount Poi=
nt.
> May 30 19:21:46 spisula systemd[1]: Expecting device dev-disk-by\x2duuid-=
4287f104\x2d02bb\x2d4f34\x2da6e5\x2dfd766865cf5b.device - /dev/disk/by-uuid=
/4287f104-02bb-4f34-a6e5-fd766865cf5b...
> May 30 19:21:46 spisula systemd[1]: Expecting device dev-disk-by\x2duuid-=
BBC4\x2dE7CD.device - /dev/disk/by-uuid/BBC4-E7CD...
> May 30 19:21:46 spisula systemd[1]: Expecting device dev-mapper-spisula\x=
2d\x2dvg\x2dswap_1.device - /dev/mapper/spisula--vg-swap_1...
> May 30 19:21:46 spisula systemd[1]: Reached target nss-user-lookup.target=
 - User and Group Name Lookups.
> May 30 19:21:46 spisula systemd[1]: Reached target remote-fs.target - Rem=
ote File Systems.
> May 30 19:21:46 spisula systemd[1]: Reached target slices.target - Slice =
Units.
> May 30 19:21:46 spisula systemd[1]: Listening on dm-event.socket - Device=
-mapper event daemon FIFOs.
> May 30 19:21:46 spisula systemd[1]: Listening on lvm2-lvmpolld.socket - L=
VM2 poll daemon socket.
> May 30 19:21:46 spisula systemd[1]: Listening on syslog.socket - Syslog S=
ocket.
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-creds.socket - C=
redential Encryption/Decryption.
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-initctl.socket -=
 initctl Compatibility Named Pipe.
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-journald-dev-log=
=2Esocket - Journal Socket (/dev/log).
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-journald.socket =
- Journal Sockets.
> May 30 19:21:46 spisula systemd[1]: systemd-pcrextend.socket - TPM PCR Me=
asurements was skipped because of an unmet condition check (ConditionSecuri=
ty=3Dmeasured-uki).
> May 30 19:21:46 spisula systemd[1]: systemd-pcrlock.socket - Make TPM PCR=
 Policy was skipped because of an unmet condition check (ConditionSecurity=
=3Dmeasured-uki).
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-udevd-control.so=
cket - udev Control Socket.
> May 30 19:21:46 spisula systemd[1]: Listening on systemd-udevd-kernel.soc=
ket - udev Kernel Socket.
> May 30 19:21:46 spisula systemd[1]: Mounting dev-hugepages.mount - Huge P=
ages File System...
> May 30 19:21:46 spisula systemd[1]: Mounting dev-mqueue.mount - POSIX Mes=
sage Queue File System...
> May 30 19:21:46 spisula systemd[1]: run-lock.mount: Directory /run/lock t=
o mount over is not empty, mounting anyway.
> May 30 19:21:46 spisula systemd[1]: Mounting run-lock.mount - Legacy Lock=
s Directory /run/lock...
> May 30 19:21:46 spisula systemd[1]: Mounting sys-kernel-debug.mount - Ker=
nel Debug File System...
> May 30 19:21:46 spisula systemd[1]: Mounting sys-kernel-tracing.mount - K=
ernel Trace File System...
> May 30 19:21:46 spisula systemd[1]: Starting blk-availability.service - A=
vailability of block devices...
> May 30 19:21:46 spisula systemd[1]: Starting keyboard-setup.service - Set=
 the console keyboard layout...
> May 30 19:21:46 spisula systemd[1]: Starting kmod-static-nodes.service - =
Create List of Static Device Nodes...
> May 30 19:21:46 spisula systemd[1]: Starting lvm2-monitor.service - Monit=
oring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> May 30 19:21:46 spisula systemd[1]: Starting modprobe@configfs.service - =
Load Kernel Module configfs...
> May 30 19:21:46 spisula systemd[1]: Starting modprobe@drm.service - Load =
Kernel Module drm...
> May 30 19:21:46 spisula systemd[1]: Starting modprobe@efi_pstore.service =
- Load Kernel Module efi_pstore...
> May 30 19:21:46 spisula systemd[1]: Starting modprobe@fuse.service - Load=
 Kernel Module fuse...
> May 30 19:21:46 spisula systemd[1]: systemd-fsck-root.service - File Syst=
em Check on Root Device was skipped because of an unmet condition check (Co=
nditionPathExists=3D!/run/initramfs/fsck-root).
> May 30 19:21:46 spisula systemd[1]: systemd-hibernate-clear.service - Cle=
ar Stale Hibernate Storage Info was skipped because of an unmet condition c=
heck (ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-8cf=
2644b-4b0b-428f-9387-6d876050dc67).
> May 30 19:21:46 spisula systemd[1]: Starting systemd-journald.service - J=
ournal Service...
> May 30 19:21:46 spisula systemd[1]: Starting systemd-modules-load.service=
 - Load Kernel Modules...
> May 30 19:21:46 spisula systemd[1]: systemd-pcrmachine.service - TPM PCR =
Machine ID Measurement was skipped because of an unmet condition check (Con=
ditionSecurity=3Dmeasured-uki).
> May 30 19:21:46 spisula systemd[1]: Starting systemd-remount-fs.service -=
 Remount Root and Kernel File Systems...
> May 30 19:21:46 spisula systemd[1]: systemd-tpm2-setup-early.service - Ea=
rly TPM SRK Setup was skipped because of an unmet condition check (Conditio=
nSecurity=3Dmeasured-uki).
> May 30 19:21:46 spisula systemd[1]: Starting systemd-udev-load-credential=
s.service - Load udev Rules from Credentials...
> May 30 19:21:46 spisula systemd[1]: Starting systemd-udev-trigger.service=
 - Coldplug All udev Devices...
> May 30 19:21:46 spisula systemd[1]: Mounted dev-hugepages.mount - Huge Pa=
ges File System.
> May 30 19:21:46 spisula systemd[1]: Mounted dev-mqueue.mount - POSIX Mess=
age Queue File System.
> May 30 19:21:46 spisula systemd[1]: Mounted run-lock.mount - Legacy Locks=
 Directory /run/lock.
> May 30 19:21:46 spisula systemd[1]: Mounted sys-kernel-debug.mount - Kern=
el Debug File System.
> May 30 19:21:46 spisula systemd[1]: Mounted sys-kernel-tracing.mount - Ke=
rnel Trace File System.
> May 30 19:21:46 spisula systemd[1]: Finished blk-availability.service - A=
vailability of block devices.
> May 30 19:21:46 spisula systemd[1]: Finished keyboard-setup.service - Set=
 the console keyboard layout.
> May 30 19:21:46 spisula systemd[1]: Finished kmod-static-nodes.service - =
Create List of Static Device Nodes.
> May 30 19:21:46 spisula systemd[1]: modprobe@drm.service: Deactivated suc=
cessfully.
> May 30 19:21:46 spisula systemd[1]: Finished modprobe@drm.service - Load =
Kernel Module drm.
> May 30 19:21:46 spisula systemd[1]: modprobe@fuse.service: Deactivated su=
ccessfully.
> May 30 19:21:46 spisula systemd[1]: Finished modprobe@fuse.service - Load=
 Kernel Module fuse.
> May 30 19:21:46 spisula systemd[1]: Mounting sys-fs-fuse-connections.moun=
t - FUSE Control File System...
> May 30 19:21:46 spisula systemd[1]: Starting systemd-tmpfiles-setup-dev-e=
arly.service - Create Static Device Nodes in /dev gracefully...
> May 30 19:21:46 spisula systemd[1]: modprobe@configfs.service: Deactivate=
d successfully.
> May 30 19:21:46 spisula systemd[1]: Finished modprobe@configfs.service - =
Load Kernel Module configfs.
> May 30 19:21:46 spisula systemd[1]: Mounting sys-kernel-config.mount - Ke=
rnel Configuration File System...
> May 30 19:21:46 spisula systemd[1]: Mounted sys-fs-fuse-connections.mount=
 - FUSE Control File System.
> May 30 19:21:46 spisula kernel: EXT4-fs (dm-1): re-mounted af843d99-0ced-=
4405-b68d-4f56cdc24cb4 r/w. Quota mode: none.
> May 30 19:21:46 spisula systemd[1]: Finished systemd-remount-fs.service -=
 Remount Root and Kernel File Systems.
> May 30 19:21:46 spisula systemd[1]: systemd-hwdb-update.service - Rebuild=
 Hardware Database was skipped because of an unmet condition check (Conditi=
onNeedsUpdate=3D/etc).
> May 30 19:21:46 spisula kernel: pstore: Using crash dump compression: def=
late
> May 30 19:21:46 spisula systemd[1]: Starting systemd-random-seed.service =
- Load/Save OS Random Seed...
> May 30 19:21:46 spisula systemd[1]: systemd-tpm2-setup.service - TPM SRK =
Setup was skipped because of an unmet condition check (ConditionSecurity=3D=
measured-uki).
> May 30 19:21:46 spisula systemd[1]: Finished systemd-udev-load-credential=
s.service - Load udev Rules from Credentials.
> May 30 19:21:46 spisula systemd[1]: Mounted sys-kernel-config.mount - Ker=
nel Configuration File System.
> May 30 19:21:46 spisula kernel: pstore: Registered efi_pstore as persiste=
nt store backend
> May 30 19:21:46 spisula systemd[1]: modprobe@efi_pstore.service: Deactiva=
ted successfully.
> May 30 19:21:46 spisula systemd-journald[485]: Collecting audit messages =
is disabled.
> May 30 19:21:46 spisula systemd[1]: Finished modprobe@efi_pstore.service =
- Load Kernel Module efi_pstore.
> May 30 19:21:46 spisula kernel: lp: driver loaded but no devices found
> May 30 19:21:46 spisula systemd[1]: Starting systemd-pstore.service - Pla=
tform Persistent Storage Archival...
> May 30 19:21:46 spisula systemd[1]: Finished lvm2-monitor.service - Monit=
oring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
> May 30 19:21:46 spisula systemd[1]: Finished systemd-tmpfiles-setup-dev-e=
arly.service - Create Static Device Nodes in /dev gracefully.
> May 30 19:21:46 spisula systemd[1]: systemd-sysusers.service - Create Sys=
tem Users was skipped because no trigger condition checks were met.
> May 30 19:21:46 spisula systemd[1]: Starting systemd-tmpfiles-setup-dev.s=
ervice - Create Static Device Nodes in /dev...
> May 30 19:21:46 spisula systemd[1]: Finished systemd-random-seed.service =
- Load/Save OS Random Seed.
> May 30 19:21:46 spisula kernel: ppdev: user-space parallel port driver
> May 30 19:21:46 spisula systemd[1]: Finished systemd-pstore.service - Pla=
tform Persistent Storage Archival.
> May 30 19:21:46 spisula systemd[1]: Finished systemd-tmpfiles-setup-dev.s=
ervice - Create Static Device Nodes in /dev.
> May 30 19:21:46 spisula systemd[1]: Reached target local-fs-pre.target - =
Preparation for Local File Systems.
> May 30 19:21:46 spisula systemd[1]: Starting systemd-udevd.service - Rule=
-based Manager for Device Events and Files...
> May 30 19:21:46 spisula systemd[1]: Finished systemd-modules-load.service=
 - Load Kernel Modules.
> May 30 19:21:46 spisula systemd[1]: Starting systemd-sysctl.service - App=
ly Kernel Variables...
> May 30 19:21:46 spisula systemd[1]: Started systemd-journald.service - Jo=
urnal Service.
> May 30 19:21:46 spisula systemd-journald[485]: Received client request to=
 flush runtime journal.
> May 30 19:21:46 spisula kernel: Adding 1003516k swap on /dev/mapper/spisu=
la--vg-swap_1.  Priority:-2 extents:1 across:1003516k SS
> May 30 19:21:46 spisula kernel: input: Lid Switch as /devices/LNXSYSTM:00=
/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C09:00/PNP0C0D:00/input/input15
> May 30 19:21:46 spisula kernel: ACPI: button: Lid Switch [LID0]
> May 30 19:21:46 spisula kernel: input: Power Button as /devices/LNXSYSTM:=
00/LNXSYBUS:00/PNP0C0C:00/input/input16
> May 30 19:21:46 spisula kernel: ACPI: button: Power Button [PWRB]
> May 30 19:21:46 spisula kernel: input: Sleep Button as /devices/LNXSYSTM:=
00/LNXSYBUS:00/PNP0C0E:00/input/input17
> May 30 19:21:46 spisula kernel: ACPI: button: Sleep Button [SLPB]
> May 30 19:21:46 spisula kernel: input: Power Button as /devices/LNXSYSTM:=
00/LNXPWRBN:00/input/input18
> May 30 19:21:46 spisula kernel: ACPI: button: Power Button [PWRF]
> May 30 19:21:46 spisula kernel: ACPI: AC: AC Adapter [ADP1] (off-line)
> May 30 19:21:46 spisula kernel: input: Acer Wireless Radio Control as /de=
vices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:01/PNP0C09:00/10251229:00/i=
nput/input19
> May 30 19:21:46 spisula kernel: Consider using thermal netlink events int=
erface
> May 30 19:21:46 spisula kernel: EXT4-fs (nvme0n1p2): mounting ext2 file s=
ystem using the ext4 subsystem
> May 30 19:21:46 spisula kernel: EXT4-fs (nvme0n1p2): mounted filesystem 4=
287f104-02bb-4f34-a6e5-fd766865cf5b r/w without journal. Quota mode: none.
> May 30 19:21:46 spisula kernel: mc: Linux media interface: v0.10
> May 30 19:21:47 spisula kernel: input: PC Speaker as /devices/platform/pc=
spkr/input/input20
> May 30 19:21:47 spisula kernel: Bluetooth: Core ver 2.22
> May 30 19:21:47 spisula kernel: NET: Registered PF_BLUETOOTH protocol fam=
ily
> May 30 19:21:47 spisula kernel: Bluetooth: HCI device and connection mana=
ger initialized
> May 30 19:21:47 spisula kernel: Bluetooth: HCI socket layer initialized
> May 30 19:21:47 spisula kernel: Bluetooth: L2CAP socket layer initialized
> May 30 19:21:47 spisula kernel: Bluetooth: SCO socket layer initialized
> May 30 19:21:47 spisula kernel: RAPL PMU: API unit is 2^-32 Joules, 4 fix=
ed counters, 655360 ms ovfl timer
> May 30 19:21:47 spisula kernel: RAPL PMU: hw unit of domain pp0-core 2^-1=
4 Joules
> May 30 19:21:47 spisula kernel: RAPL PMU: hw unit of domain package 2^-14=
 Joules
> May 30 19:21:47 spisula kernel: RAPL PMU: hw unit of domain dram 2^-14 Jo=
ules
> May 30 19:21:47 spisula kernel: RAPL PMU: hw unit of domain pp1-gpu 2^-14=
 Joules
> May 30 19:21:47 spisula kernel: cfg80211: Loading compiled-in X.509 certi=
ficates for regulatory database
> May 30 19:21:47 spisula kernel: Loaded X.509 cert 'benh@debian.org: 577e0=
21cb980e0e820821ba7b54b4961b8b4fadf'
> May 30 19:21:47 spisula kernel: Loaded X.509 cert 'romain.perier@gmail.co=
m: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
> May 30 19:21:47 spisula kernel: Loaded X.509 cert 'sforshee: 00b28ddf47ae=
f9cea7'
> May 30 19:21:47 spisula kernel: Loaded X.509 cert 'wens: 61c038651aabdcf9=
4bd0ac7ff06c7248db18c600'
> May 30 19:21:47 spisula kernel: videodev: Linux video capture interface: =
v2.00
> May 30 19:21:47 spisula kernel: Intel(R) Wireless WiFi driver for Linux
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: Detected crf-id 0x2=
816, cnv-id 0x1000100 wfpm id 0x80000000
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: PCI dev 31dc/0034, =
rev=3D0x312, rfid=3D0x105110
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: Detected Intel(R) W=
ireless-AC 9560 160MHz
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 0
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 1
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 2
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 3
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 4
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 6
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 8
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 9
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 10
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 11
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 15
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 16
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 18
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 19
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 20
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 21
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: WRT: Overriding reg=
ion id 28
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: firmware: failed to=
 load iwl-debug-yoyo.bin (-2)
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: firmware: failed to=
 load iwl-debug-yoyo.bin (-2)
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: firmware: failed to=
 load iwl-debug-yoyo.bin (-2)
> May 30 19:21:47 spisula kernel: iwlwifi 0000:00:0c.0: loaded firmware ver=
sion 46.7e3e4b69.0 9000-pu-b0-jf-b0-46.ucode op_mode iwlmvm
> May 30 19:21:47 spisula kernel: acer_wmi: Acer Laptop ACPI-WMI Extras
> May 30 19:21:47 spisula kernel: acer_wmi: Function bitmap for Communicati=
on Button: 0x0
> May 30 19:21:47 spisula kernel: input: Acer WMI hotkeys as /devices/virtu=
al/input/input21
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply =
vdd not found, using dummy regulator
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:00: supply =
vddio not found, using dummy regulator
> May 30 19:21:47 spisula kernel: FAT-fs (nvme0n1p1): Volume was not proper=
ly unmounted. Some data may be corrupt. Please run fsck.
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: suppl=
y vdd not found, using dummy regulator
> May 30 19:21:47 spisula kernel: bmc150_accel_i2c i2c-BOSC0200:base: suppl=
y vddio not found, using dummy regulator
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.003:4=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D"1password" pid=3D655 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.007:5=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D"Discord" pid=3D656 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.007:6=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D"QtWebEngineProcess" pid=3D658 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.007:7=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D4D6F6E676F444220436F6D70617373 pid=3D657 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.007:8=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D"brave" pid=3D661 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.011:9=
): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" na=
me=3D"balena-etcher" pid=3D660 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.011:1=
0): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" n=
ame=3D"buildah" pid=3D662 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.011:1=
1): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" n=
ame=3D"busybox" pid=3D663 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.015:1=
2): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" n=
ame=3D"cam" pid=3D664 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: audit: type=3D1400 audit(1748625708.015:1=
3): apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" n=
ame=3D"ch-run" pid=3D666 comm=3D"apparmor_parser"
> May 30 19:21:48 spisula kernel: intel_rapl_common: Found RAPL domain pack=
age
> May 30 19:21:48 spisula kernel: intel_rapl_common: Found RAPL domain core
> May 30 19:21:48 spisula kernel: intel_rapl_common: Found RAPL domain unco=
re
> May 30 19:21:48 spisula kernel: intel_rapl_common: Found RAPL domain dram
> May 30 19:21:48 spisula kernel: iwlwifi 0000:00:0c.0: base HW address: f4=
:b3:01:63:29:78, OTP minor version: 0x4
> May 30 19:21:48 spisula kernel: ieee80211 phy0: Selected rate control alg=
orithm 'iwl-mvm-rs'
> May 30 19:21:48 spisula kernel: iwlwifi 0000:00:0c.0 wlp0s12f0: renamed f=
rom wlan0
> May 30 19:21:48 spisula kernel: usbcore: registered new interface driver =
btusb
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Bootloader revision 0.1 =
build 42 week 52 2015
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Device revision is 2
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Secure boot is enabled
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: OTP lock is enabled
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: API lock is enabled
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Debug lock is disabled
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Minimum firmware build 1=
 week 10 2014
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Found device firmware: i=
ntel/ibt-17-16-1.sfi
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Boot Address: 0x40800
> May 30 19:21:48 spisula kernel: Bluetooth: hci0: Firmware Version: 201-12=
=2E24
> May 30 19:21:48 spisula kernel: usb 1-2: Found UVC 1.50 device 5MP World =
Facing (04f2:b6db)
> May 30 19:21:48 spisula kernel: usb 1-7: Found UVC 1.00 device HD User Fa=
cing (0408:a061)
> May 30 19:21:48 spisula kernel: nvme nvme0: using unchecked data buffer
> May 30 19:21:48 spisula kernel: usbcore: registered new interface driver =
uvcvideo
> May 30 19:21:48 spisula kernel: zram: Added device: zram0
> May 30 19:21:48 spisula kernel: zram0: detected capacity change from 0 to=
 1907360
> May 30 19:21:48 spisula kernel: Adding 953676k swap on /dev/zram0.  Prior=
ity:100 extents:1 across:953676k SS
> May 30 19:21:48 spisula kernel: Bluetooth: BNEP (Ethernet Emulation) ver =
1.3
> May 30 19:21:48 spisula kernel: Bluetooth: BNEP filters: protocol multica=
st
> May 30 19:21:48 spisula kernel: Bluetooth: BNEP socket layer initialized
> May 30 19:21:49 spisula kernel: BUG: kernel NULL pointer dereference, add=
ress: 0000000000000001
> May 30 19:21:49 spisula kernel: #PF: supervisor read access in kernel mode
> May 30 19:21:49 spisula kernel: #PF: error_code(0x0000) - not-present page
> May 30 19:21:49 spisula kernel: PGD 0 P4D 0=20
> May 30 19:21:49 spisula kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> May 30 19:21:49 spisula kernel: CPU: 2 UID: 0 PID: 805 Comm: iio-sensor-p=
rox Not tainted 6.12.29-amd64 #1  Debian 6.12.29-1
> May 30 19:21:49 spisula kernel: Hardware name: Acer TravelMate Spin B311R=
-31/Maracas_GL, BIOS V1.18 08/26/2021
> May 30 19:21:49 spisula kernel: RIP: 0010:bmc150_accel_set_interrupt+0x68=
/0x120 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel: Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f=
 c1 10 83 c2 01 83 fa 01 7f 64 49 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89=
 c3 85 c0 75 52 <41> 0f b6 55 01 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c =
24 6a 00
> May 30 19:21:49 spisula kernel: RSP: 0018:ffffb44780e03b10 EFLAGS: 000102=
46
> May 30 19:21:49 spisula kernel: RAX: 0000000000000000 RBX: 00000000000000=
00 RCX: 00000000ffffff01
> May 30 19:21:49 spisula kernel: RDX: ffffffff8d12acf0 RSI: 00000000000002=
02 RDI: ffffa06a42513904
> May 30 19:21:49 spisula kernel: RBP: ffffa06a42513820 R08: ffffa06a4b33fb=
e8 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: ffffb44780e03b28 R11: 00000000000000=
09 R12: ffffa06a4b33fd50
> May 30 19:21:49 spisula kernel: R13: 0000000000000000 R14: 00000000000000=
01 R15: ffffa06a4b33fb30
> May 30 19:21:49 spisula kernel: FS:  00007f368a3d9940(0000) GS:ffffa06abb=
d00000(0000) knlGS:0000000000000000
> May 30 19:21:49 spisula kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001 CR3: 00000001056100=
00 CR4: 0000000000352ef0
> May 30 19:21:49 spisula kernel: Call Trace:
> May 30 19:21:49 spisula kernel:  <TASK>
> May 30 19:21:49 spisula kernel:  bmc150_accel_buffer_postenable+0x5d/0x90=
 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel:  __iio_update_buffers+0x731/0xb20 [indust=
rialio]
> May 30 19:21:49 spisula kernel:  ? __kernfs_setattr+0xa0/0xb0
> May 30 19:21:49 spisula kernel:  enable_store+0x84/0xe0 [industrialio]
> May 30 19:21:49 spisula kernel:  kernfs_fop_write_iter+0x13b/0x1f0
> May 30 19:21:49 spisula kernel:  vfs_write+0x28d/0x450
> May 30 19:21:49 spisula kernel:  ksys_write+0x6d/0xf0
> May 30 19:21:49 spisula kernel:  do_syscall_64+0x82/0x190
> May 30 19:21:49 spisula kernel:  ? do_filp_open+0xc4/0x170
> May 30 19:21:49 spisula kernel:  ? do_sys_openat2+0x9c/0xe0
> May 30 19:21:49 spisula kernel:  ? syscall_exit_to_user_mode+0x4d/0x210
> May 30 19:21:49 spisula kernel:  ? do_syscall_64+0x8e/0x190
> May 30 19:21:49 spisula kernel:  ? do_syscall_64+0x8e/0x190
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  ? clear_bhb_loop+0x40/0x90
> May 30 19:21:49 spisula kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> May 30 19:21:49 spisula kernel: RIP: 0033:0x7f368a7df9ee
> May 30 19:21:49 spisula kernel: Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89=
 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89=
 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 =
83 ec 08
> May 30 19:21:49 spisula kernel: RSP: 002b:00007fffd76b67e8 EFLAGS: 000002=
46 ORIG_RAX: 0000000000000001
> May 30 19:21:49 spisula kernel: RAX: ffffffffffffffda RBX: 00007f368a3d99=
40 RCX: 00007f368a7df9ee
> May 30 19:21:49 spisula kernel: RDX: 0000000000000001 RSI: 00007fffd76b69=
90 RDI: 0000000000000009
> May 30 19:21:49 spisula kernel: RBP: 00007fffd76b6990 R08: 00000000000000=
00 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: 0000000000000000 R11: 00000000000002=
46 R12: 0000000000000001
> May 30 19:21:49 spisula kernel: R13: 000055742d68a2a0 R14: 00007f368a92ae=
80 R15: 0000000000000001
> May 30 19:21:49 spisula kernel:  </TASK>
> May 30 19:21:49 spisula kernel: Modules linked in: bnep snd_intel_dspcfg =
zram x86_pkg_temp_thermal uvcvideo snd_intel_sdw_acpi lz4hc_compress lz4_co=
mpress intel_powerclamp processor_thermal_device_pci_legacy btusb videobuf2=
_vmalloc snd_hda_codec coretemp drm_buddy iwlmvm processor_thermal_device b=
trtl uvc snd_hda_core kvm_intel drm_display_helper processor_thermal_wt_hin=
t mac80211 processor_thermal_rfim binfmt_misc btintel videobuf2_memops inte=
l_rapl_msr processor_thermal_rapl cec snd_hwdep kvm libarc4 nls_ascii bmc15=
0_accel_i2c btbcm videobuf2_v4l2 intel_rapl_common acer_wmi rc_core snd_pcm=
 nls_cp437 iwlwifi bmc150_accel_core irqbypass intel_pmc_core btmtk videode=
v processor_thermal_wt_req sparse_keymap mei_pxp mei_hdcp ttm snd_timer vfa=
t industrialio_triggered_buffer rapl intel_vsec processor_thermal_power_flo=
or cfg80211 rtsx_usb_ms bluetooth videobuf2_common platform_profile mei_me =
drm_kms_helper snd fat kfifo_buf intel_cstate pcspkr pmt_telemetry processo=
r_thermal_mbox wmi_bmof memstick mc int3403_thermal rfkill mei i2c_algo_bit
> May 30 19:21:49 spisula kernel:  soundcore industrialio int3400_thermal a=
cer_wireless soc_button_array pmt_class intel_soc_dts_iosf int340x_thermal_=
zone ac acpi_thermal_rel button joydev evdev msr parport_pc ppdev lp parpor=
t efi_pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 cr=
c16 mbcache jbd2 crc32c_generic rtsx_usb_sdmmc rtsx_usb dm_crypt dm_mod crc=
t10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 hi=
d_multitouch sha256_ssse3 hid_generic sha1_ssse3 xhci_pci aesni_intel xhci_=
hcd i2c_hid_acpi sdhci_pci r8169 gf128mul nvme i2c_hid intel_lpss_pci cqhci=
 usbcore realtek crypto_simd nvme_core hid intel_lpss i2c_i801 sdhci wdat_w=
dt mdio_devres cryptd serio_raw watchdog video libphy mmc_core i2c_smbus lp=
c_ich nvme_auth drm idma64 usb_common battery wmi
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001
> May 30 19:21:49 spisula kernel: ---[ end trace 0000000000000000 ]---
> May 30 19:21:49 spisula kernel: RIP: 0010:bmc150_accel_set_interrupt+0x68=
/0x120 [bmc150_accel_core]
> May 30 19:21:49 spisula kernel: Code: 84 86 00 00 00 ba 01 00 00 00 f0 0f=
 c1 10 83 c2 01 83 fa 01 7f 64 49 8b 3c 24 be 01 00 00 00 e8 5e fc ff ff 89=
 c3 85 c0 75 52 <41> 0f b6 55 01 41 0f b6 75 00 45 31 c9 45 31 c0 49 8b 3c =
24 6a 00
> May 30 19:21:49 spisula kernel: RSP: 0018:ffffb44780e03b10 EFLAGS: 000102=
46
> May 30 19:21:49 spisula kernel: RAX: 0000000000000000 RBX: 00000000000000=
00 RCX: 00000000ffffff01
> May 30 19:21:49 spisula kernel: RDX: ffffffff8d12acf0 RSI: 00000000000002=
02 RDI: ffffa06a42513904
> May 30 19:21:49 spisula kernel: RBP: ffffa06a42513820 R08: ffffa06a4b33fb=
e8 R09: 0000000000000000
> May 30 19:21:49 spisula kernel: R10: ffffb44780e03b28 R11: 00000000000000=
09 R12: ffffa06a4b33fd50
> May 30 19:21:49 spisula kernel: R13: 0000000000000000 R14: 00000000000000=
01 R15: ffffa06a4b33fb30
> May 30 19:21:49 spisula kernel: FS:  00007f368a3d9940(0000) GS:ffffa06abb=
d00000(0000) knlGS:0000000000000000
> May 30 19:21:49 spisula kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> May 30 19:21:49 spisula kernel: CR2: 0000000000000001 CR3: 00000001056100=
00 CR4: 0000000000352ef0
> May 30 19:21:49 spisula kernel: note: iio-sensor-prox[805] exited with ir=
qs disabled
> May 30 19:21:49 spisula kernel: evm: overlay not supported
> May 30 19:21:49 spisula kernel: Generic FE-GE Realtek PHY r8169-0-200:00:=
 attached PHY driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] Unknown revision=
 0x06
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] Found GEMINILAKE=
 (device ID 3185) display version 10.00 stepping **
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] Unknown revid 0x=
06
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] VT-d active for =
gfx access
> May 30 19:21:49 spisula kernel: Console: switching to colour dummy device=
 80x25
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: vgaarb: deactivate vga=
 console
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] Using Transparen=
t Hugepages
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] couldn't get mem=
ory information
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: vgaarb: VGA decodes ch=
anged: olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: firmware: failed to lo=
ad i915/glk_dmc_ver1_04.bin (-2)
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: firmware: failed to lo=
ad i915/glk_dmc_ver1_04.bin (-2)
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: firmware: failed to lo=
ad i915/glk_dmc_ver1_04.bin (-2)
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: Direct firmware load f=
or i915/glk_dmc_ver1_04.bin failed with error -2
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] Failed to load D=
MC firmware i915/glk_dmc_ver1_04.bin (-ENOENT). Disabling runtime power man=
agement.
> May 30 19:21:49 spisula kernel: i915 0000:00:02.0: [drm] DMC firmware hom=
epage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmw=
are.git
> May 30 19:21:49 spisula kernel: r8169 0000:02:00.0 enp2s0: Link is Down
> May 30 19:21:49 spisula kernel: mei_hdcp 0000:00:0f.0-b638ab7e-94e2-4ea2-=
a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> May 30 19:21:49 spisula kernel: [drm] Initialized i915 1.6.0 for 0000:00:=
02.0 on minor 0
> May 30 19:21:49 spisula kernel: ACPI: video: Video Device [GFX0] (multi-h=
ead: yes  rom: no  post: no)
> May 30 19:21:49 spisula kernel: input: Video Bus as /devices/LNXSYSTM:00/=
LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input22
> May 30 19:21:49 spisula kernel: fbcon: i915drmfb (fb0) is primary device
> May 30 19:21:49 spisula kernel: snd_hda_intel 0000:00:0e.0: bound 0000:00=
:02.0 (ops i915_audio_component_bind_ops [i915])
> May 30 19:21:50 spisula kernel: iwlwifi 0000:00:0c.0: Registered PHC cloc=
k: iwlwifi-PTP, with index: 0
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Waiting for firmware dow=
nload to complete
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Firmware loaded in 16473=
86 usecs
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Waiting for device to bo=
ot
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Device booted in 13696 u=
secs
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Found Intel DDC paramete=
rs: intel/ibt-17-16-1.ddc
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Applying Intel DDC param=
eters completed
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: Firmware revision 0.1 bu=
ild 201 week 12 2024
> May 30 19:21:50 spisula kernel: Bluetooth: hci0: HCI LE Coded PHY feature=
 bit is set, but its usage is not supported.
> May 30 19:21:50 spisula kernel: Bluetooth: MGMT ver 1.23
> May 30 19:21:50 spisula kernel: NET: Registered PF_ALG protocol family
> May 30 19:21:50 spisula kernel: Console: switching to colour frame buffer=
 device 170x48
> May 30 19:21:51 spisula kernel: i915 0000:00:02.0: [drm] fb0: i915drmfb f=
rame buffer device
> May 30 19:21:51 spisula kernel: Bluetooth: RFCOMM TTY layer initialized
> May 30 19:21:51 spisula kernel: Bluetooth: RFCOMM socket layer initialized
> May 30 19:21:51 spisula kernel: Bluetooth: RFCOMM ver 1.11
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0: autoco=
nfig for ALC256: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:    spe=
aker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:    hp_=
outs=3D1 (0x21/0x0/0x0/0x0/0x0)
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:    mon=
o: mono_out=3D0x0
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:    inp=
uts:
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:      I=
nternal Mic=3D0x12
> May 30 19:21:51 spisula kernel: snd_hda_codec_realtek hdaudioC0D0:      H=
eadset Mic=3D0x19
> May 30 19:21:51 spisula kernel: input: HDA Digital PCBeep as /devices/pci=
0000:00/0000:00:0e.0/sound/card0/input23
> May 30 19:21:51 spisula kernel: input: HDA Intel PCH Front Headphone as /=
devices/pci0000:00/0000:00:0e.0/sound/card0/input24
> May 30 19:21:51 spisula kernel: input: HDA Intel PCH HDMI/DP,pcm=3D3 as /=
devices/pci0000:00/0000:00:0e.0/sound/card0/input25
> May 30 19:21:51 spisula kernel: input: HDA Intel PCH HDMI/DP,pcm=3D7 as /=
devices/pci0000:00/0000:00:0e.0/sound/card0/input26
> May 30 19:21:51 spisula kernel: input: HDA Intel PCH HDMI/DP,pcm=3D8 as /=
devices/pci0000:00/0000:00:0e.0/sound/card0/input27
> May 30 19:21:53 spisula kernel: wlp0s12f0: authenticate with 14:91:82:2e:=
1c:5b (local address=3Df4:b3:01:63:29:78)
> May 30 19:21:53 spisula kernel: wlp0s12f0: send auth to 14:91:82:2e:1c:5b=
 (try 1/3)
> May 30 19:21:53 spisula kernel: wlp0s12f0: authenticated
> May 30 19:21:53 spisula kernel: wlp0s12f0: associate with 14:91:82:2e:1c:=
5b (try 1/3)
> May 30 19:21:53 spisula kernel: wlp0s12f0: RX AssocResp from 14:91:82:2e:=
1c:5b (capab=3D0x11 status=3D0 aid=3D2)
> May 30 19:21:53 spisula kernel: wlp0s12f0: associated
> May 30 19:21:54 spisula kernel: Lockdown: systemd-logind: hibernation is =
restricted; see man kernel_lockdown.7
> May 30 19:21:54 spisula kernel: rfkill: input handler disabled
> May 30 19:22:01 spisula kernel: rfkill: input handler enabled


