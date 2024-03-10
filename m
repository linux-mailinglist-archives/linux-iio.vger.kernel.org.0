Return-Path: <linux-iio+bounces-3432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFEF877692
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97631C20B0B
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322B22324;
	Sun, 10 Mar 2024 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF+dswI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDF3224
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074019; cv=none; b=jjYeIPI50eNV3YDiufuVLUpqw65sgWfMnm67uNRaUpWz25R1HzOiBWVwCGRVUDDgL6gJldmONwIRS9h7A1TesqpcSzqW7eVm79PaOS1Wm+mshUHlQjsWJ1253dMaRDF/fp4UCtKc9cxUtByEPyvP417J93uNwRdd7ZPocl6RIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074019; c=relaxed/simple;
	bh=cTv5z8YfVq/Xp/enBqb0WBSvV84k93XBLhuTBmpBfDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=of6FWvw+iaHWEYfq/Rd/rqZRRob+pSWzFs8LC5gJiY1aMn64rvIBX6f2p6WBWJqu49wvp58tJjed3OuVm+hWpj6IvlylL4GwGYOAu44pSAqAxZB9BvEbO3f7nngoP9UnfvVAiKL7bzyiufxUciEJPs1VY93fxlO04H45u5r4sxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF+dswI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A62FC43390
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710074018;
	bh=cTv5z8YfVq/Xp/enBqb0WBSvV84k93XBLhuTBmpBfDE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sF+dswI6ofckTNlejjwtubzB/dMvRa4RP/6bZ793IZaZpUMl4W9biMdNLgcwHlhZP
	 VbqOC0vXqFD9rkhUXGvR2K2kltcnsjFiFMZVCK7VnupmxXcvVGfHMQ8iLgonQ2NbCr
	 QiGu53EM0ev5ogCMcnx6x8QrbLfjpsRyjhj0vfOcQ+VaepkOAqGc45qTHT3BMBE/d5
	 33DqOkDX8Ir/qDlBtAfxA/P+lRs9PIc3eshshwZU7nTXDU43fTmIORgtHnJ+IkHPei
	 mgN1/T83SEGw4PaaLOm74NMMZlb/+JmUDS60GzjsUA0Vx4J4YiYBQWSo+mljAH338o
	 0gcIzo9Zw42Ew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50AB0C53BD1; Sun, 10 Mar 2024 12:33:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Sun, 10 Mar 2024 12:33:38 +0000
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
Message-ID: <bug-218578-217253-7fLu1ci59H@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218578-217253@https.bugzilla.kernel.org/>
References: <bug-218578-217253@https.bugzilla.kernel.org/>
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

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
On Sat, 09 Mar 2024 17:55:32 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D218578
>=20
>             Bug ID: 218578
>            Summary: MXC6655 accelerometer not working with MXC4005 driver
>            Product: Drivers
>            Version: 2.5
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: kernelbugzilla@kirkschnable.com
>         Regression: No
>=20
> Created attachment 305970
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D305970&action=3Dedi=
t=20=20
> Output from udevadm info -n /dev/iio\:device0 && also some samples of
> accelerometer raw values I see in /sys/bus/iio/devices/iio:device:0/.
>=20
> Hello,
>=20
> I recently bought two Chuwi tablets which contain MXC6655 accelerometers.=
=20
> The
> accelerometers work in Windows 11 and the tablet rotates as expected in
> Windows, but upon installing Linux the tablet auto rotation was not worki=
ng.
>=20

Hi, thanks for the report,

First thought is that there may be some power control hidden in the ACPI
tables.
Could you dump
/sys/firmware/acpi/tables/DSDT
and run it through iasl -d (from acpica-tools)

Find the section related to his accelerometer and post all of that.
Sometimes there is a _DSM (device specific method) used to power things up
- this stuff is completely non standard unfortunately so we have to base
any support on table dumps from the particular devices.

Thanks,

Jonathan


> The Chuwi tablets are:
> - UBook X Pro 2023
> - UBook X 2023
>=20
> This does not appear to be distro specific, as I am seeing the same behav=
ior
> on
> both:
> - Linux Mint 21.3, with kernel 5.15.0-91-generic
> - Fedora 39 Workstation, with kernel 6.5.6-300.fc39.x86_64
>=20
> I came across this thread indicating that support was added for this in 2=
020
> via the MXC4005 driver: https://www.spinics.net/lists/linux-iio/msg53171.=
html
>=20
> This seems to be double confirmed by another issue I found here on this b=
ug
> tracker: https://bugzilla.kernel.org/show_bug.cgi?id=3D206703
>=20
> Unfortunately in my case, I see the MXC4005 driver is in fact loaded and
> running, however it appears the raw data is not changing.  When looking at
> the
> output from iio-sensor-proxy with "monitor-sensor", the orientation always
> reports "left-up".
>=20
> I tried a test where I watched a cat of all of the files in
> /sys/bus/iio/devices/iio:device0/, and I never see the raw data changing =
when
> the tablet is rotated.  I'm attaching the values I see from the raw data =
in
> the
> text file.  Interestingly, Fedora reports different raw values, but
> iio-sensor-proxy still says orientation is left-up with these values.  In
> both
> cases, the values don't change when the tablet is rotated.
>=20
> The output of "udevadm info -n /dev/iio\:device0" is attached too.
>=20
> lsmod reports that the mxc4005 driver is loaded, along with industrialio =
and
> industrialio_triggered_buffer.  Unloading the mxc4005 module with rmmod
> causes
> it to disappear from iio-sensor-proxy as expected, but otherwise unloading
> and
> reloading the driver seems to have no effect on the symptoms.
>=20
> If there is any further information I can gather which will be helpful, or
> any
> testing I can help with, please let me know.=20
>=20
> Thanks!
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

