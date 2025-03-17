Return-Path: <linux-iio+bounces-16994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB32A65D62
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C1D7AF691
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BC1E7C12;
	Mon, 17 Mar 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riYcWsMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FF1E1E08
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237844; cv=none; b=KmXRq1peUO02myT/Ji2f+WDwujQEiowGgbboIG/EmeeVucvgo6ckhf2BF/GQDexfAzKR16DHkmLU89Za874nmoDYNkmJ/Jxy3ZjH1qWLbqfmBTKjy975UC0kZlUaBCjhtVSMeimymrXBinBvtXfWDbV9VezrnafrOnYDPgzI0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237844; c=relaxed/simple;
	bh=7k7TMtRoFg3Za1lsj9YJBAtM0Y6onkF9UBnHuFDW8NY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLW1rkRRdFiWchggg+2sgVb43tSguH0CBwe5SYMVVDgBil2zh0VJgn0kL4aJNBAmsES7GwHBnRR3Yl0c5dGiWv6z/5gpTPnQydx8id3tkk4AVW45GAP8MI+3oSNk7nNH9iUo7X8/fphc94Fzkp/JOJJprcSRR94iiHB5MqhDDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riYcWsMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D46C4CEE3;
	Mon, 17 Mar 2025 18:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237844;
	bh=7k7TMtRoFg3Za1lsj9YJBAtM0Y6onkF9UBnHuFDW8NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riYcWsMqYTUgO5xuJCvohvetUqTKrcDTKEt36qkoKS3lCiHXRg4ZKThfnsonrgLQA
	 J+2793ZF3b1J9sFe8kXXLvKrvnan3ZPAD3zizjSe6IXKvaIW52jD016e5LI1CJvuyg
	 ZGCNoVO+T42Ib6liqkwnvA3aq1Jvlw/kP9NFinRd7Er1vkTrtX0jsQ1OyHZo6XH52L
	 DmCBmfLzvzg3eoJ9k59Hr5z+bEu6jEUrgUAmxm+DKI4+t0uhJc9wbF8/sX1jB3+aHq
	 rjJbI8NW32N6aaSi3VHVsDvYudhDbBI2gaTAgyvAGtY1ZJXp/OOzQ4cjUXwL/8g9vY
	 siA8UXp6KvhLQ==
Date: Mon, 17 Mar 2025 18:57:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org, Srinivas Pandruvada 
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Bug 219890] illuminance sensor is jittering between correct
 value and 0.03lux
Message-ID: <20250317185718.6055357f@jic23-huawei>
In-Reply-To: <bug-219890-217253-UhojLJ6ONz@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
	<bug-219890-217253-UhojLJ6ONz@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.6.auto/iio:device0=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF iio:device1 ->=20
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.7.auto/iio:device1=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger0 ->=20
> ../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.=
000E/HID-SENSOR-200041.6.auto/trigger0=20
> lrwxrwxrwx - root 17 mars 13:43 =EE=97=BF trigger1 ->=20
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
> > =20
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
> >> I checked the behavior on windows to make sure it's not an hardware fa=
ilure
> >> from my sensor.
> >> While I cannot have direct access to raw sensor data on windows, the
> >> automatic
> >> brightness is perfectly smooth: no flickering of any kind.
> >>
> >> I didn't found sensor name:
> >> =E2=9D=AF cat  /sys/bus/iio/devices/iio:device0/name
> >> als =20
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
> > =20
> >> But if there is other place I could look, let me know.
> >> =20
>=20


