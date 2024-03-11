Return-Path: <linux-iio+bounces-3451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29554877A62
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 05:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18F81C20D4D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Mar 2024 04:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914F6AAD;
	Mon, 11 Mar 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMDcybd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0263AE
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131644; cv=none; b=ADlstTevoUqrR0pFlOyU/zNA4GtSXaKW++k0eSasDPRnqjPZLZsHlh5RICXXoeF/w1MSJKttXrcW7U2ZmRHwMGc6G4sB4jIkiHiWZxUhlCwPKIrTATHmICDppkIJq63zp6GKsUVDBJT9LDBBJKEaRUK4gMxhx9dw0n4QZfC+wS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131644; c=relaxed/simple;
	bh=HvO0v4u0VVZ2JJEu7Jm8yjzhwwN9z4m3XKkuU3P4APc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHrAxTiSL2KzMAfyhwrQIGA830fdph8bkGV4C6sjHr5nIW9i6LdXhjm4bz8/I03HegKNdKjJick5haQRzPxXUlqfi7CGp7iz4vkZtFeiLkGTqSd9EOwFR6cDrxGO2FNzty8jEc1oRkx7y1aWyuUEflFi6+JZ1viy/Zr8v+e8Wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMDcybd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAB26C433F1
	for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2024 04:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710131643;
	bh=HvO0v4u0VVZ2JJEu7Jm8yjzhwwN9z4m3XKkuU3P4APc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AqMDcybdqP9ug9a3CHPASPKt+vRWB9TVZgYca+9kkRS7t4/o6YRcvxhRgjjH6Tskp
	 HNFqhsy1sZQok7nttGXpf0aLVQZOMUwWP9/e+FM9LaaZD++ooj0XIbAt28B5q2FavY
	 avoTQs5I7TxX8haCUs706KCrKBWJZGX7WxITwNKUFfGgMt2roced0UMYWx2un8tdY3
	 Z54CEmQXMDqd/dY4Nq4xrFmp8JTZOXa0IzMtO/tXGpQ2DYfBB1xvLJcmiyFykJkObT
	 bBdDdibLrEtmx0znJDZ4h8aB5Q0ulenbb3ZzRnxU3d3TXzeP3EVVzRXVqsD55oP1SH
	 FrXSRRe4Hi+8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B1BF2C4332E; Mon, 11 Mar 2024 04:34:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Mon, 11 Mar 2024 04:34:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-wLlCRzHIcK@https.bugzilla.kernel.org/>
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

--- Comment #3 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Jonathan,

Thanks for your response, and I have done some further testing today which =
has
led me to some interesting conclusions.

I have, as you requested, extracted the DSDT information relevant to the
accelerometer and attached it.  I found 6 devices containing the word
"Accelerometer" so I pulled the details of all of them, but I think the fir=
st
one, ACC0, is the relevant one since it mentions the MXC6655 model number.

My further testing today has led me to conclude that this problem is more
"intermittent" than I'd first believed.  It almost led me to incorrectly
conclude that I'd been mistaken about the whole thing in fact.

I made another post elsewhere and connected with another user of a similar
Chuwi tablet device who says their accelerometer is working reliably on Fed=
ora
39 (after a workaround to correct the fact that the orientation is 90 degre=
es
off).  They encouraged me to try it from the live environment, which I did =
not
expect to make any difference, however it actually worked exactly as he had
described.  For the first time, I saw actual updates to the raw data, and t=
he
screen was actually rotating (albeit, incorrectly).

This prompted me to perform another fresh install of Fedora.  To my shock, =
the
fresh install worked at first boot too, then I started to try to fix the 90
degree orientation issue.  I created a file in /etc/udev/hwdb.d/ with some
suggested settings and rebooted.  After that, the accelerometer no longer
worked.  So, I reverted the change and rebooted again.  Still no accelerome=
ter
readings anymore.

Thinking that maybe I'd broken that install somehow (even though I reverted=
 all
the changes), I did another fresh install.  This fresh install worked too u=
ntil
I rebooted the system.  I did nothing else but reboot the system.  Totally
broken, even several reboots later.

I tried running DNF updates on this install (over 600 packages needing upda=
te),
and rebooted again.  Still no accelerometer.  An update clearly didn't brea=
k it
but an update also didn't fix it.

While attempting to begin a third fresh install to try to reproduce this and
see if this was a pattern, I performed the test again from the live environ=
ment
and got no accelerometer readings.  This is the exact same USB I installed =
from
earlier that worked several times this morning.

Something is very strange.  I would almost believe it was a faulty
accelerometer if it weren't for the fact that I used this tablet for 3 hours
today in Windows 11 and experienced no issues with the screen rotation.

I will say this much, I have yet to see the problem "go away" on an install
once it starts.  The installs that work once and then break never start wor=
king
again.  The live environment has been the most likely to work, but I have n=
ow
seen it not work.  I dumped the ACPI data for you from a live session of Fe=
dora
39 when the accelerometer was not working.

Hopefully this data is helpful.  I am not knowledgeable enough about how th=
ese
ACPI components function under the hood, but it seems like the issue is les=
s an
issue of "the accelerometer never works" and more of an issue of "the
accelerometer only works sometimes".

Thanks!
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

