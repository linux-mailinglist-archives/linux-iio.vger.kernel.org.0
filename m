Return-Path: <linux-iio+bounces-3410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF0877293
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96611C21332
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A2241E9;
	Sat,  9 Mar 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm+9+LlD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD35200A6
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006933; cv=none; b=QLrisyMj0w/RZZ8TUyjjis0bMOrj1n18a16coPwbdQOHqJnrhwC+o6SqaCkMxMzCD9NpczYw3NwUacJTZn6G3/V37+sOxhOr0g4dsBZsvEGHsotWjuqyCAqt87+Tenr2Omry6xPSP+EnkzdYPBVLweo0hfI/TpTG5FpOGNnMK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006933; c=relaxed/simple;
	bh=HxaM80FIN6V53WflKRjQc/9JfOQRAxds5bqklEkBIP8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s2sswhenJIMA87ygMHLVXUX4HjtglRKX/ofNVLZ9XBLcA4vb9se8FWzKdfHFp+W9C+fEz0tP1DT/skUcsEvtUTrcHpf8s1HY8auQijpxOF4H53KwieBtfmdmKy6q3ucjOx5wlZ2P48sK6McvpxbtwtZ7Rby7JgyHmfYw+CjYZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm+9+LlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 075F3C433F1
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710006933;
	bh=HxaM80FIN6V53WflKRjQc/9JfOQRAxds5bqklEkBIP8=;
	h=From:To:Subject:Date:From;
	b=Mm+9+LlDJkpKjCcf08klM1cOINOsAVzBxroZtNcirfpPJ58KHj75INgy/ktdr2f18
	 94nVu4uc2i7HJjAvlAmlLjiI0XgQ4VIKai6HU52HH7QrTX58CPcKrfcH/jiBXbKNdO
	 qJieIUY60Nfqmu/CqX3xweKIaOvL5YuC9tisuFv/ezViHk9MEe4qL30c2NbTLk0xtz
	 RmYcITtbRf3Do1UOB6T82AhcZCk0G/4fG5RfOI/zHQUgrIiImwiBDkPsd4FVGvuzzQ
	 ljNtcj3JzWLsNbgMgdC3tOxgPj6sbjxZBwW3lUE6PoElrQzYoPzGo8k3KptuhOoYAe
	 L1Z9kGPYSKGrg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0383C4332E; Sat,  9 Mar 2024 17:55:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] New: MXC6655 accelerometer not working with MXC4005
 driver
Date: Sat, 09 Mar 2024 17:55:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218578-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218578

            Bug ID: 218578
           Summary: MXC6655 accelerometer not working with MXC4005 driver
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IIO
          Assignee: drivers_iio@kernel-bugs.kernel.org
          Reporter: kernelbugzilla@kirkschnable.com
        Regression: No

Created attachment 305970
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305970&action=3Dedit
Output from udevadm info -n /dev/iio\:device0 && also some samples of
accelerometer raw values I see in /sys/bus/iio/devices/iio:device:0/.

Hello,

I recently bought two Chuwi tablets which contain MXC6655 accelerometers.  =
The
accelerometers work in Windows 11 and the tablet rotates as expected in
Windows, but upon installing Linux the tablet auto rotation was not working.

The Chuwi tablets are:
- UBook X Pro 2023
- UBook X 2023

This does not appear to be distro specific, as I am seeing the same behavio=
r on
both:
- Linux Mint 21.3, with kernel 5.15.0-91-generic
- Fedora 39 Workstation, with kernel 6.5.6-300.fc39.x86_64

I came across this thread indicating that support was added for this in 2020
via the MXC4005 driver: https://www.spinics.net/lists/linux-iio/msg53171.ht=
ml

This seems to be double confirmed by another issue I found here on this bug
tracker: https://bugzilla.kernel.org/show_bug.cgi?id=3D206703

Unfortunately in my case, I see the MXC4005 driver is in fact loaded and
running, however it appears the raw data is not changing.  When looking at =
the
output from iio-sensor-proxy with "monitor-sensor", the orientation always
reports "left-up".

I tried a test where I watched a cat of all of the files in
/sys/bus/iio/devices/iio:device0/, and I never see the raw data changing wh=
en
the tablet is rotated.  I'm attaching the values I see from the raw data in=
 the
text file.  Interestingly, Fedora reports different raw values, but
iio-sensor-proxy still says orientation is left-up with these values.  In b=
oth
cases, the values don't change when the tablet is rotated.

The output of "udevadm info -n /dev/iio\:device0" is attached too.

lsmod reports that the mxc4005 driver is loaded, along with industrialio and
industrialio_triggered_buffer.  Unloading the mxc4005 module with rmmod cau=
ses
it to disappear from iio-sensor-proxy as expected, but otherwise unloading =
and
reloading the driver seems to have no effect on the symptoms.

If there is any further information I can gather which will be helpful, or =
any
testing I can help with, please let me know.=20

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

