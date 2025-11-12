Return-Path: <linux-iio+bounces-26179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A7C503B6
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A6D3B2F3E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 01:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C2288515;
	Wed, 12 Nov 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNaDaWGL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6D284689
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912013; cv=none; b=Qf0JtEx4KpHOvA7+3nZld59XCijEqJ1lsR17sjsfeJ8KTUwfzqdQ4dinQEEBovs4NNSqQ8EdFkgsi6xwemzZ8HAI2J+wv6I7jRrMh+cnoQItCvwGVD3Zm00xmjt+LmA/3toklHEvJ0q6ObefDeyHDRKoTA6dVXONl7aidyV8ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912013; c=relaxed/simple;
	bh=vobJ/1vdObFgvyWypp5ZNLxQcdCa9e4yhVUGVXNVasg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8I/oylwPq4bOl4YqcNfIvbYGYGnxIwF1IZATzWzRA3eotGuzjsNN0w+xsBfe41WKN3W/dXQ5IJN1bBz0GY1C+2C78+P+reIjTcLKMBxZzvHoP+sPrTL3BYJMkmIaHpto7T+obp7CoVhzIIyxpEQ3SLpqvtbarH+bBkyK12qeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNaDaWGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADB7C4CEFB
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912013;
	bh=vobJ/1vdObFgvyWypp5ZNLxQcdCa9e4yhVUGVXNVasg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NNaDaWGLhdkpqdo0gZ5SwEbZrnt6TOUXfWAwTgZrd55x6m7ksZpqqLSSBYWSJvEwX
	 GRI/Yojkb7B+aYIXjFsylhaVk9p3UHNlwWNK+4i4Z/RU09O4IsjcR+clWwERT+Bxx1
	 eiAZIAngHvPGwg67lam6W4OnBoQ3WMEYYW+jdnf8N4yWxyaDUtOECExHAmOdL93NFz
	 sC5PaoiJ+06WiT2uIGBMsh7VJZsd1SH4/ulQofK74K4RXKG8DCTg7S3275dcJ8MSq3
	 3xsqH0kqq9/ol6tM+KCgv9PpNHO0x7jC6Sa2zha6PUR5IFFJ4ALtsSwrkF37ICxI0x
	 xo6ZIqwkxHlyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DF052C53BBF; Wed, 12 Nov 2025 01:46:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220772] NULL pointer dereference in bmc150-accel-core
Date: Wed, 12 Nov 2025 01:46:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220772-217253-hKYWpHfSlh@https.bugzilla.kernel.org/>
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

--- Comment #3 from Vitaliy Tomin (highwaystar.ru@gmail.com) ---
(In reply to Jonathan Cameron from comment #2)
> On Sun, 09 Nov 2025 19:59:38 +0000
> bugzilla-daemon@kernel.org wrote:

> Could you share the names of the triggers under
> /sys/bus/iio/devices/trigger*/name
> and
> cat /proc/interrupts
>=20
> Maybe the tooling is using an hrtimer or sysfs trigger but the
> driver seems to have a validate_trigger callback that should prevent that
> so I think we need a little more information.
>=20
> Thanks
>=20
> Jonathan


There is no such files here:
tomin@fedora:~$ ls /sys/bus/iio/devices/trigger*/name
ls: cannot access '/sys/bus/iio/devices/trigger*/name': No such file or
directory
tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/
'/sys/bus/iio/devices/iio:device0/':
buffer                   events                       in_accel_x_raw=20=20
in_temp_offset  name                          subsystem
buffer0                  firmware_node                in_accel_y_raw=20=20
in_temp_raw     power                         trigger
current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw=20=20
in_temp_scale   sampling_frequency_available  uevent
dev                      in_accel_scale               in_mount_matrix  labe=
l=20=20=20
       scan_elements                 waiting_for_supplier

'/sys/bus/iio/devices/iio:device1/':
buffer                   events                       in_accel_x_raw=20=20
in_temp_offset  name                          subsystem
buffer0                  firmware_node                in_accel_y_raw=20=20
in_temp_raw     power                         trigger
current_timestamp_clock  in_accel_sampling_frequency  in_accel_z_raw=20=20
in_temp_scale   sampling_frequency_available  uevent
dev                      in_accel_scale               in_mount_matrix  labe=
l=20=20=20
       scan_elements                 waiting_for_supplier
tomin@fedora:~$ ls /sys/bus/iio/devices/iio\:device*/trigger
'/sys/bus/iio/devices/iio:device0/trigger':
current_trigger

'/sys/bus/iio/devices/iio:device1/trigger':
current_trigger



tomin@fedora:~$ cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3=20=20=20=20=20=20=20
   1:          0          0         72          0 IR-IO-APIC    1-edge=20=
=20=20=20=20
i8042
   8:          0          0          0          0 IR-IO-APIC    8-edge=20=
=20=20=20=20
rtc0
   9:      10041          0          0          0 IR-IO-APIC    9-fasteoi=
=20=20
acpi
  12:          0          6          0          0 IR-IO-APIC   12-edge=20=
=20=20=20=20
i8042
  14:          8          0          0          0 IR-IO-APIC   14-fasteoi=
=20=20
INTC1057:00
  16:         56          0          0          0 IR-IO-APIC   16-fasteoi=
=20=20
mmc0, i801_smbus
  27:          0          0       5167          0 IR-IO-APIC   27-fasteoi=
=20=20
i2c_designware.1, idma64.1
  29:        236          0          0          0 IR-IO-APIC   29-fasteoi=
=20=20
i2c_designware.3, idma64.3
  31:          0          0          0          0 IR-IO-APIC   31-fasteoi=
=20=20
i2c_designware.5, idma64.5
  32:          0          0          0          0 IR-IO-APIC   32-fasteoi=
=20=20
i2c_designware.6, idma64.6
  33:          0       4921          0          0 IR-IO-APIC   33-fasteoi=
=20=20
i2c_designware.4, idma64.4
  39:          0          0          0          0 IR-IO-APIC   39-fasteoi=
=20=20
pxa2xx-spi.0, idma64.0
  40:          0          0          0          0 IR-IO-APIC   40-fasteoi=
=20=20
i2c_designware.2, idma64.2
 120:          0          1          0          0 IR-PCI-MSI-0000:00:1d.0=
=20=20=20
0-edge      aerdrv, PCIe bwctrl
 121:       9054          0          0          0 IR-PCI-MSI-0000:00:14.0=
=20=20=20
0-edge      xhci_hcd
 126:         10          4          0         30 IR-PCI-MSIX-0000:01:00.0=
=20=20=20
0-edge      nvme0q0
 127:       7450          0          0          0 IR-PCI-MSIX-0000:01:00.0=
=20=20=20
1-edge      nvme0q1
 128:          0       5690          0          0 IR-PCI-MSIX-0000:01:00.0=
=20=20=20
2-edge      nvme0q2
 129:          0          0       5152          0 IR-PCI-MSIX-0000:01:00.0=
=20=20=20
3-edge      nvme0q3
 130:          0          0          0       6240 IR-PCI-MSIX-0000:01:00.0=
=20=20=20
4-edge      nvme0q4
 131:          0      10732      10690       1008 IR-PCI-MSI-0000:00:02.0=
=20=20=20
0-edge      i915
 132:          8          0          0          0 intel-gpio  306  GDIX1001=
:00
 133:          0         49          0          0 IR-PCI-MSI-0000:00:16.0=
=20=20=20
0-edge      mei_me
 134:        883       1015        400        779 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
0-edge      iwlwifi:default_queue
 135:         46         59         35          4 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
1-edge      iwlwifi:queue_1
 136:          5         68          1         17 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
2-edge      iwlwifi:queue_2
 137:         20         30         25         35 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
3-edge      iwlwifi:queue_3
 138:         21        123        114        269 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
4-edge      iwlwifi:queue_4
 139:          0          0          0          5 IR-PCI-MSIX-0000:00:14.3=
=20=20=20
5-edge      iwlwifi:exception
 140:       1213          0          0          0 IR-PCI-MSI-0000:00:1f.3=
=20=20=20
0-edge      snd_hda_intel:card1
 NMI:          8          8          9          8   Non-maskable interrupts
 LOC:      87542      86732      94323      81275   Local timer interrupts
 SPU:          0          0          0          0   Spurious interrupts
 PMI:          8          8          9          8   Performance monitoring
interrupts
 IWI:       2334      10486       9187       2892   IRQ work interrupts
 RTR:          0          0          0          0   APIC ICR read retries
 RES:       1781       1199       1600       3146   Rescheduling interrupts
 CAL:      23231      22621      16364      21816   Function call interrupts
 TLB:       1208       1127       1072       1304   TLB shootdowns
 TRM:        680        680        680        680   Thermal event interrupts
 THR:          0          0          0          0   Threshold APIC interrup=
ts
 DFR:          0          0          0          0   Deferred Error APIC
interrupts
 MCE:          0          0          0          0   Machine check exceptions
 MCP:          3          4          4          4   Machine check polls
 ERR:          0
 MIS:          0
 PIN:          0          0          0          0   Posted-interrupt
notification event
 NPI:          0          0          0          0   Nested posted-interrupt
event
 PIW:          0          0          0          0   Posted-interrupt wakeup
event
 PMN:          0          0          0          0   Posted MSI notification
event

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

