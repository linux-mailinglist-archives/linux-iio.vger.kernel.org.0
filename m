Return-Path: <linux-iio+bounces-26246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E5C609EA
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25CF4E12FD
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAC2877F7;
	Sat, 15 Nov 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCdSUjtg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD861FFE
	for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763231139; cv=none; b=eAJjbrWi06Ktv3vLW7cAAjSvOockQRr9q7ekKzbXlOqQ0rxKl4VhdV3AQN84g5QIRPkTxUSCj6wu8DekUQY5/DSYMQ0jpv78pGUR7FM2zMyhcL5arHsGPttQ+Qq099Xxd7LQrVlpP+IfRocgnNjj3TgHXUbBEDVTV8qUtlTmQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763231139; c=relaxed/simple;
	bh=Z9JsOPPMl38G25ZhZjjmr7uvk98V9bNUqdJFLV3SqFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAqt2sVSkeoG+KQ5uiOERfDSP5tnnS5UgDfGePN91Eb2CR8plOSVEmkU9U8ogdLavBCZJ00c1E47TgGGooKzwvQKdcCWagarMe8DQ+zKTmFA+og0PQhZSCyV3u59kq21dB5cqX5f8s7YQRXOo87JV4+E7bXoITPkM4lWkS8tCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCdSUjtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0008CC19421
	for <linux-iio@vger.kernel.org>; Sat, 15 Nov 2025 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763231139;
	bh=Z9JsOPPMl38G25ZhZjjmr7uvk98V9bNUqdJFLV3SqFI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pCdSUjtgKsTS9O/ZBwlK8wlVma9Z/olaVDMLP+U/IFn4u/aYGEy+uf2qPVsVGHY+m
	 PaQSZU4Upvg1kj+13u7jg8NsmbslCof0YzQIU2GQZO3uMP8GM/d+HMrVqPuGEWNA9J
	 k1/COO3ukIqtkM/W9gTLeHPy1SYIkm50x47KY/q52UwTY6grJQAl1fcpr3Fe+jre8O
	 mewf1ExJt96b77uMRCrThAcwcIAtBc2cB6iSHwlXttmSj3RCPEyhLl0oLJ1m5BbU8f
	 fSCwAxTM6YD+Kawht/dMjQd+oJKahVriKGx/JXDkW59fct3fPWQa5ETm872m5I4EBU
	 O/XHNcHGptOWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E81DDCAB787; Sat, 15 Nov 2025 18:25:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Sat, 15 Nov 2025 18:25:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220772-217253-6YvaYGoAZn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220772-217253@https.bugzilla.kernel.org/>
References: <bug-220772-217253@https.bugzilla.kernel.org/>
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

--- Comment #4 from Jonathan Cameron (jic23@kernel.org) ---
On Wed, 12 Nov 2025 01:46:52 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D220772
>=20
> --- Comment #3 from Vitaliy Tomin (highwaystar.ru@gmail.com) ---
> (In reply to Jonathan Cameron from comment #2)
> > On Sun, 09 Nov 2025 19:59:38 +0000
> > bugzilla-daemon@kernel.org wrote:=20=20
>=20
> > Could you share the names of the triggers under
> > /sys/bus/iio/devices/trigger*/name
> > and
> > cat /proc/interrupts
> >=20
> > Maybe the tooling is using an hrtimer or sysfs trigger but the
> > driver seems to have a validate_trigger callback that should prevent th=
at
> > so I think we need a little more information.
> >=20
> > Thanks
> >=20
> > Jonathan=20=20
>=20
>=20
> There is no such files here:

Thanks. So to hit the buffer functions is must be in fifo mode
(which runs without a trigger).

Seems the conversation around the original fix should have gone
on a bit longer as it was correct as we do want to enable buffered
support if no interrupts, just not let it run unless a trigger is coming
from elsewhere.

Uwe had the right idea, I just didn't understand it at the time of
that original thread.   I've replied to that thread so hopefully we
can finally get this cleared up.

If you could test what Uwe posted in this message that would be great.

https://lore.kernel.org/all/6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jx=
ptf@jszhnvmj2ffc/

Thanks for the hard work getting me all the info.

Jonathan



> tomin@fedora:~$ ls /sys/bus/iio/devices/trigger*/name
> ls: cannot access '/sys/bus/iio/devices/trigger*/name': No such file or
> directory
> tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/
> '/sys/bus/iio/devices/iio:device0/':
> buffer                   events                       in_accel_x_raw=20=20
> in_temp_offset  name                          subsystem
> buffer0                  firmware_node                in_accel_y_raw=20=20
> in_temp_raw     power                         trigger
> current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw=20=20
> in_temp_scale   sampling_frequency_available  uevent
> dev                      in_accel_scale               in_mount_matrix  la=
bel=20=20
>        scan_elements                 waiting_for_supplier
>=20
> '/sys/bus/iio/devices/iio:device1/':
> buffer                   events                       in_accel_x_raw=20=20
> in_temp_offset  name                          subsystem
> buffer0                  firmware_node                in_accel_y_raw=20=20
> in_temp_raw     power                         trigger
> current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw=20=20
> in_temp_scale   sampling_frequency_available  uevent
> dev                      in_accel_scale               in_mount_matrix  la=
bel=20=20
>        scan_elements                 waiting_for_supplier
> tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/trigger
> '/sys/bus/iio/devices/iio:device0/trigger':
> current_trigger
>=20
> '/sys/bus/iio/devices/iio:device1/trigger':
> current_trigger
>=20
>=20
>=20
> tomin@fedora:~$ cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3=20=20=20=20=20=20=20
>    1:          0          0         72          0 IR-IO-APIC    1-edge=20=
=20=20=20=20
> i8042
>    8:          0          0          0          0 IR-IO-APIC    8-edge=20=
=20=20=20=20
> rtc0
>    9:      10041          0          0          0 IR-IO-APIC    9-fasteoi=
=20=20
> acpi
>   12:          0          6          0          0 IR-IO-APIC   12-edge=20=
=20=20=20=20
> i8042
>   14:          8          0          0          0 IR-IO-APIC   14-fasteoi=
=20=20
> INTC1057:00
>   16:         56          0          0          0 IR-IO-APIC   16-fasteoi=
=20=20
> mmc0, i801_smbus
>   27:          0          0       5167          0 IR-IO-APIC   27-fasteoi=
=20=20
> i2c_designware.1, idma64.1
>   29:        236          0          0          0 IR-IO-APIC   29-fasteoi=
=20=20
> i2c_designware.3, idma64.3
>   31:          0          0          0          0 IR-IO-APIC   31-fasteoi=
=20=20
> i2c_designware.5, idma64.5
>   32:          0          0          0          0 IR-IO-APIC   32-fasteoi=
=20=20
> i2c_designware.6, idma64.6
>   33:          0       4921          0          0 IR-IO-APIC   33-fasteoi=
=20=20
> i2c_designware.4, idma64.4
>   39:          0          0          0          0 IR-IO-APIC   39-fasteoi=
=20=20
> pxa2xx-spi.0, idma64.0
>   40:          0          0          0          0 IR-IO-APIC   40-fasteoi=
=20=20
> i2c_designware.2, idma64.2
>  120:          0          1          0          0 IR-PCI-MSI-0000:00:1d.0=
=20=20=20
> 0-edge      aerdrv, PCIe bwctrl
>  121:       9054          0          0          0 IR-PCI-MSI-0000:00:14.0=
=20=20=20
> 0-edge      xhci_hcd
>  126:         10          4          0         30 IR-PCI-MSIX-0000:01:00.=
0=20=20=20
> 0-edge      nvme0q0
>  127:       7450          0          0          0 IR-PCI-MSIX-0000:01:00.=
0=20=20=20
> 1-edge      nvme0q1
>  128:          0       5690          0          0 IR-PCI-MSIX-0000:01:00.=
0=20=20=20
> 2-edge      nvme0q2
>  129:          0          0       5152          0 IR-PCI-MSIX-0000:01:00.=
0=20=20=20
> 3-edge      nvme0q3
>  130:          0          0          0       6240 IR-PCI-MSIX-0000:01:00.=
0=20=20=20
> 4-edge      nvme0q4
>  131:          0      10732      10690       1008 IR-PCI-MSI-0000:00:02.0=
=20=20=20
> 0-edge      i915
>  132:          8          0          0          0 intel-gpio  306=20
>  GDIX1001:00
>  133:          0         49          0          0 IR-PCI-MSI-0000:00:16.0=
=20=20=20
> 0-edge      mei_me
>  134:        883       1015        400        779 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 0-edge      iwlwifi:default_queue
>  135:         46         59         35          4 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 1-edge      iwlwifi:queue_1
>  136:          5         68          1         17 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 2-edge      iwlwifi:queue_2
>  137:         20         30         25         35 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 3-edge      iwlwifi:queue_3
>  138:         21        123        114        269 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 4-edge      iwlwifi:queue_4
>  139:          0          0          0          5 IR-PCI-MSIX-0000:00:14.=
3=20=20=20
> 5-edge      iwlwifi:exception
>  140:       1213          0          0          0 IR-PCI-MSI-0000:00:1f.3=
=20=20=20
> 0-edge      snd_hda_intel:card1
>  NMI:          8          8          9          8   Non-maskable interrup=
ts
>  LOC:      87542      86732      94323      81275   Local timer interrupts
>  SPU:          0          0          0          0   Spurious interrupts
>  PMI:          8          8          9          8   Performance monitoring
> interrupts
>  IWI:       2334      10486       9187       2892   IRQ work interrupts
>  RTR:          0          0          0          0   APIC ICR read retries
>  RES:       1781       1199       1600       3146   Rescheduling interrup=
ts
>  CAL:      23231      22621      16364      21816   Function call interru=
pts
>  TLB:       1208       1127       1072       1304   TLB shootdowns
>  TRM:        680        680        680        680   Thermal event interru=
pts
>  THR:          0          0          0          0   Threshold APIC interr=
upts
>  DFR:          0          0          0          0   Deferred Error APIC
> interrupts
>  MCE:          0          0          0          0   Machine check excepti=
ons
>  MCP:          3          4          4          4   Machine check polls
>  ERR:          0
>  MIS:          0
>  PIN:          0          0          0          0   Posted-interrupt
> notification event
>  NPI:          0          0          0          0   Nested posted-interru=
pt
> event
>  PIW:          0          0          0          0   Posted-interrupt wake=
up
> event
>  PMN:          0          0          0          0   Posted MSI notificati=
on
> event
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

