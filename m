Return-Path: <linux-iio+bounces-16995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67538A65D61
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B85F172462
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3E1E51EF;
	Mon, 17 Mar 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5sn9JSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BEC1E1E08
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237845; cv=none; b=N0nfq9gkajtfiJUXFj+x/RKDE7KxTtHq/HsZVfMBg821LxGeI9GnWC2WQN9J1x5j5mUSAkXxjtxQEYiiyCaUjWruigpjPmTl3TiOiMmkwgFa8aayq3UKxuWeR50IRe+TBK49/Xhn1rk5HJgsfTyKDiiPGGJKuuw9X9DCWFK6M0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237845; c=relaxed/simple;
	bh=SodsKJP4OHDr9GiMu8g+NfMXNf+2xAo/g2bHNW6CyBU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHG4rW0IHEky8EL63OSV1YYT5+RqmshB1HhPUv8PBbiaQ49oV7qcdZfo5ckC0XDJGBs2HANN8F0Nh0AkGCAJZpeJB4gZziVoI9oUOroAhZuxFUFlKHZf21gh4Einfx4mgz2LHnTvmKhsmU2J67+uYQUIB/6svwbFM+olJRyZIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5sn9JSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0C1C4CEE3
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237845;
	bh=SodsKJP4OHDr9GiMu8g+NfMXNf+2xAo/g2bHNW6CyBU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a5sn9JSnGxYCKE/7icNWtFTvw8Cl039gdB3klRhowSLsPJhEPKFrIImEQ3nk5/4xO
	 Em03+wsOyjOETvNoho/ckkNulTCS3L+LBKRO+6kG4LLKGKFVPYHRssjL6YF7OqiDqA
	 d2pjL0CTASsiWEFyFocVbuudhohFtxGtWYsJrVRWjW7BXSc2tfd1nl/o0Izq8QLYfJ
	 og7JKjzTrYdF/stJ1pG8Ko6Ze/SGGxXioE5RLRiUUAgOoEvwdtAaltrTcjwXvywQfa
	 /oKexvlJeG6bCwSu0E8gyx54LmqTLBN9EHfAUYRxyWV6nRpVB/23rFbtUoM3xpHXBw
	 nGMht+8YtCPKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3160EC53BBF; Mon, 17 Mar 2025 18:57:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Mon, 17 Mar 2025 18:57:25 +0000
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
Message-ID: <bug-219890-217253-rJnq3XbWLK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #4 from Jonathan Cameron (jic23@kernel.org) ---
On Mon, 17 Mar 2025 13:02:24 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
>=20
> --- Comment #2 from wysiwyg81@rbox.co ---
> Hello, Did you mean in /sys/bus/iio/devices/ instead of=20
> /sys/iio/devices/ if so: /sys/bus/iio/devices =E2=9D=AF ls -lh Permission=
s Size=20
> User Date Modified Name lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF iio:dev=
ice0 ->=20
>
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.6.auto/iio:device0=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF iio:device1 ->=20
>
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.7.auto/iio:device1=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger0 ->=20
>
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.6.auto/trigger0=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger1 ->=20
>
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.7.auto/trigger1
>=20
> (bugzilla seems down currently, so I try direct email answer, hope it=20
> works, I will check once bugzilla is back).
Perfect.  So it is definitely a hid sensor.
Srinivas any idea?
>=20
> Best regards,
>=20
> On 17/03/2025 13:15, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
> >
> > --- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
> > On Mon, 17 Mar 2025 09:38:50 +0000
> > bugzilla-daemon@kernel.org wrote:
> >=20=20
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D219890
> >>
> >>              Bug ID: 219890
> >>             Summary: illuminance sensor is jittering between correct v=
alue
> >>                      and 0.03lux
> >>             Product: Drivers
> >>             Version: 2.5
> >>            Hardware: All
> >>                  OS: Linux
> >>              Status: NEW
> >>            Severity: normal
> >>            Priority: P3
> >>           Component: IIO
> >>            Assignee: drivers_iio@kernel-bugs.kernel.org
> >>            Reporter: wysiwyg81@rbox.co
> >>          Regression: No
> >>
> >> Hello,
> >>
> >> I have a Lenovo thinkbook 13x gen4.
> >> Automatic brightness control is flickering in Gnome, so I checked sens=
or
> >> with
> >> monitor-sensor command (iio-sensor-proxy).
> >>
> >> it shows following behavior:
> >> monitor-sensor  --light
> >>      Waiting for iio-sensor-proxy to appear
> >> +++ iio-sensor-proxy appeared
> >> =3D=3D=3D Has ambient light sensor (value: 316,000000, unit: lux)
> >>      Light changed: 299,000000 (lux)
> >>      Light changed: 0,030000 (lux)
> >>      Light changed: 299,000000 (lux)
> >>      Light changed: 0,030000 (lux)
> >>      Light changed: 299,000000 (lux)
> >>      Light changed: 0,030000 (lux)
> >>      Light changed: 305,000000 (lux)
> >>
> >>
> >> the 0.03 is unexpected has it has never been that dark.
> >> it seems it's not a iio-sensor-proxy bug as I can see similar behavior=
 by
> >> checking directly content of here :
> >> /sys/bus/iio/devices/iio:device0/in_illuminance_raw
> >>
> >>
> >> I checked the behavior on windows to make sure it's not an hardware
> failure
> >> from my sensor.
> >> While I cannot have direct access to raw sensor data on windows, the
> >> automatic
> >> brightness is perfectly smooth: no flickering of any kind.
> >>
> >> I didn't found sensor name:
> >> =E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
> >> als=20=20
> > Two possibles types. It's either a hid sensor or an ACPI class interface
> > with a sensor wrapped up in firmware.
> >
> > My guess is hid-sensor.  Can you do an
> > ls -lh in /sys/iio/devices/
> > so we can see what the parent is.
> > +CC Srinivas based on playing guess the sensor.
> >
> > Jonathan
> >
> >
> >
> >
> >=20=20
> >> But if there is other place I could look, let me know.
> >>=20=20
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

