Return-Path: <linux-iio+bounces-17036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A40A67B4E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0027319C67AD
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C427E211711;
	Tue, 18 Mar 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8ThmQKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA67212B1F
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320022; cv=none; b=p4RLJTH6D8q+8pKajlGJKV/Fn894ZKSyKknaTEOkxBTUFDAWzX0le9CLGa4bYGj6iCv3DyO34C1zh11fNpRcAOUPsy0h9t3rTbzAyCit6S0wuUSgfTXzD7zKTpw1uw8UDbemEY5D/BCtJZB6Tdz0z2P+DJu+aZ6zXHVNaAmN0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320022; c=relaxed/simple;
	bh=03FmUIAB2RhbkyM6dZOPxDVGGmLhGOq+XQKId7RpmKM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aegZBPN/bn7hJW0ZVyxeegOzOlxfjMZZnTRuQAs7bk+4l+izrQCAApogjrnIw5s2QfQHhyZGC6x+GLHHLtiXCtiM8hvJjam0oSCQol7BSUg5QofRyDSKYWK26+tSNuU3qEaBT967ts+L3YaFYKXF8CdTL/5118jaazISPPGRIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8ThmQKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 085C0C4CEE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 17:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320022;
	bh=03FmUIAB2RhbkyM6dZOPxDVGGmLhGOq+XQKId7RpmKM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o8ThmQKWuzzm+qxCvmnIFb4Bw1cnppIYPBmf6TeGt0hc9FvUcZJwRnepNKkZby/Su
	 E0Juu3npVsAQ3rrqxOZjiEdl8qKfWobX4tY0zOm8YmXErlSFSiuH3Zx3YyB3r4y5lv
	 u2lDy526CxSHIAm4dI6fxAPGb+FSbIeL2fVVbuy6/OGKK3UxGRzIUpb0HG3yvQlCp3
	 viPANMSu79evC6BFhVHJN19FW25yelW+rZUTFSFI9sbShBGq63YY4kwZB9ZZ/RsyxJ
	 cBmDUIw3v5mFoMKakvXEaTt2GZkPRTgc9BKdfKxZ6MyTC/1D6d8GAfSWH27ZivHdst
	 3oXZiwL/rSsWw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA7A4C433E1; Tue, 18 Mar 2025 17:47:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 17:47:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-Nxbd18fG2C@https.bugzilla.kernel.org/>
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

--- Comment #10 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
I think you have multiple als sensors on the systems.
You can also give a run with for device 0, which is the sensor you are read=
ing
in your description. This is USB hub.

sudo ./iio_generic_buffer -N 0 -a -c 1000



Those column headers are

Intensity, illumination, color temp, chromocity X, chromocity Y, timestamp

What you are reading from first 2, which are same here.

There is no 0 here, as sensor is ON always.

But when you read a raw value=20

/sys/bus/iio/devices/iio:device0/in_illuminance_raw

The sensor is turned ON and kept ON for 3 seconds. I think when sensor is
turned on the first sample is always 0. Using your description of device 0
"../../../devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:17EF:F006.0=
00E/HID-SENSOR-200041.6.auto/iio:device0
"


cd /sys/bus/platform/devices/HID-SENSOR-200041.6.auto/power
echo on > control

And try to cat the /sys/bus/iio/devices/iio:device0/in_illuminance_raw
in a loop.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

