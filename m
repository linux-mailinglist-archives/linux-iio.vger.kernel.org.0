Return-Path: <linux-iio+bounces-23948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C36B51E83
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2B11C85746
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34332877C4;
	Wed, 10 Sep 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnFQhRte"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81293266B66
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523872; cv=none; b=V9VpCYPTthHy6eINNrO/DJ2qRHcBffeurKHUZm8Cp9o8NNL2fvn+xEMM7LTkznzOL82WfmxUIlMzX53tqeVbyAXPIRhk47bA19ZsaOgw1k3/GfRMzVXOPCp0uvW9CaY5FwweqyiZ54D6Z5Ekf5eF8J6jpIPRhcSwwlvwssqClHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523872; c=relaxed/simple;
	bh=YO0Pcc8DuqQrVrxgTHm45WvbFvbHptDd9AAVrNFxl6Q=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YJ76Vg3Y7Onqfl+lolytbsAWQPb96f/9ZNmEItg0rXfMMet6edLu8ACEUY93659eHPBbVsKehvSc6heaq+zKNiC+MpOhZH7QxCEMzBl7teeTTXIJTQ9D+qP+9VQu8Lkr71/ncCUhthiP6937mS08MpBCpI5Ylopwv3qxyikMqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnFQhRte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 020AAC4CEEB
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523871;
	bh=YO0Pcc8DuqQrVrxgTHm45WvbFvbHptDd9AAVrNFxl6Q=;
	h=From:To:Subject:Date:From;
	b=jnFQhRteuJ3kCT0X9whUqdApdxKt9N5lPRDTApx+TGsY0Vc2tz0pklBLk+vr9meLJ
	 xBghQllRE/v86QYBieJFG3romVGXnhkedA5bejk9X+nDGBVfQr7dX90GBSSOBXyOKr
	 aS3pbg609A3UBr1HIK/Pg1axwY/3LLw6lyCGYLyvJUWTVv+yr2TP0BEaHkSf+/eD7X
	 5RCdpgKwwxBZovzFO6MgksdKIPgDFq+unRMSQOPiWwevcxoiOv9+6R5TC8AYswyv65
	 H8i3/rZlmT78Uj8aivH98D1LcinnCn9kbErAMQue2lHF0B2TZZ9dVCmm1EKgQ/6RcG
	 wPpmkKpYvcW0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E557DC3279F; Wed, 10 Sep 2025 17:04:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220561] New: IIO: hid-sensor-hub: Fails to enumerate
 Accelerometer on SunplusIT (5986:2177) composite device on Lenovo Yoga 7 Gen
 10
Date: Wed, 10 Sep 2025 17:04:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shyamdhokia123@hotmail.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220561-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220561

            Bug ID: 220561
           Summary: IIO: hid-sensor-hub: Fails to enumerate Accelerometer
                    on SunplusIT (5986:2177) composite device on Lenovo
                    Yoga 7 Gen 10
           Product: Drivers
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: shyamdhokia123@hotmail.co.uk
        Regression: No

Created attachment 308652
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308652&action=3Dedit
Standard Kernel Log and Full system Hardware

System Details:
Device: Lenovo Yoga 7 2-in-1 (Gen 10, AMD)
Operating System: Ubuntu 24.04 LTS
Kernel: 6.16.6-061606-generic (and newer mainline kernels tested:
6.17.0-061700rc5-generic)
iio-sensor-proxy version: 3.7 (also tested 3.5, 3.6, 3.8)
Hardware: SunplusIT Inc. Integrated RGB Camera (USB ID 5986:2177)

Problem Description:
Automatic screen rotation does not work on this new laptop model. The root
cause is that the kernel's hid-sensor-hub driver fails to detect and create=
 a
device for the built-in accelerometer.
The laptop uses a composite USB device (the webcam assembly) which provides
multiple functions, including a HID sensor interface. The driver successful=
ly
binds to this interface and enumerates the Ambient Light Sensor (ALS) but
completely ignores the Accelerometer, which is part of the same physical un=
it.
The proximity sensor is not identified by motion-sensor but identified here.

Debugging Steps and Evidence:

iio-sensor-proxy runs stably but monitor-sensor reports =3D=3D=3D No accele=
rometer.
The working Ambient Light Sensor confirms the iio userspace stack is
functional.
code. However it doesn't seem to change value from 120 so likely is still n=
ot
processing the data correctly.

The sensor hub is part of the "Integrated RGB Camera" composite device.
lsusb: Bus 001 Device 002: ID 5986:2177 SunplusIT Inc. Integrated RGB Camera
dmesg: hid-sensor-hub 0003:5986:2177.0003: hiddev0,hidraw2: USB HID v1.11
Device [SunplusIT Inc Integrated RGB Camera]

The driver correctly identifies and creates iio devices for two of the logi=
cal
sensors on the HID interface:
iio:device0: The Ambient Light Sensor (HID-SENSOR-200041).
iio:device1: The Proximity Sensor (HID-SENSOR-200011), whose name attribute=
 is
correctly reported as prox.
This proves the driver can communicate with the device and parse at least p=
art
of its HID Report Descriptor.

No iio device is ever created for the accelerometer (expected HID Usage ID
200073). The ls /sys/bus/iio/devices/ output only ever shows the ALS and
Proximity devices.

Verbose logging was enabled for the hid-sensor-hub module, which was then
forced to re-probe the device (unbind/bind).
The resulting dmesg output is flooded with successful, real-time data
processing events for the Ambient Light Sensor only. This demonstrates the
driver is actively receiving data from the working sensor, although it does=
n't
appear to be interpreted correctly.

Example from the debug log:

[ 2116.082180] hid-sensor-hub 0003:5986:2177.0003: 2 collection_index:a
hid:2004d1 sz:2
[ 2116.082182] hid-sensor-hub 0003:5986:2177.0003: collection->usage 200041

Here, collection->usage 200041 clearly identifies the ALS.

Crucially, in the entire debug log, there is a complete absence of any ment=
ion
of the Accelerometer's Usage ID (200073) or any related data fields (e.g., =
for
X/Y/Z axes).

The hid-sensor-hub driver fails during the parsing of the HID Report Descri=
ptor
for the SunplusIT 5986:2177 device. It successfully parses the logical sens=
ors
for Ambient Light and Proximity but appears to silently fail or misinterpret
the section defining the Accelerometer. Because it fails at this low level,=
 no
kernel device is ever registered, making the accelerometer invisible to the
rest of the OS.
This is a driver-level bug requiring a patch to correctly support this spec=
ific
hardware's descriptor.

Attached Files:
dmidecode and dmesg output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

