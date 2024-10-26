Return-Path: <linux-iio+bounces-11357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBF9B19F6
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AF6B21783
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864291632D7;
	Sat, 26 Oct 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl+sNkEe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457692F36
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962397; cv=none; b=P0WVTeTcM1TsonhhsfATJ/7IgsW2n3DgKTYG2cwyVqWAC8DcauJ5ts46nFf3siTSuHvDqsWE2MT2+KdWqctVFk0f/4jyOXpqxwfsashsqLVsoi5OtSdaaN89ydRbHETaF/fmMv8MVskqdE5wdh1SFFk0IFm3U/GWX30GhpYGnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962397; c=relaxed/simple;
	bh=bW35Ufj4VHv9Ur2kJubCnwKFFOwiKnwdMXhb9R6xe7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gp/sB7uZZ9YHlQfJ3QLPa73jwHwG94nf4cX9ZDcRyTE9fqxtoXz8TQBoAtPprHisfdwrnx7tqBfPRn23ShOHOLxnZBVrBcMoFIVXvGf8GCBWptWzLCySbWMy1Q1Ntfik4YusgEAv8irMao5uTHN1jw2gGzqijx0WJFduLt73eVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl+sNkEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D773EC4CEC6
	for <linux-iio@vger.kernel.org>; Sat, 26 Oct 2024 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729962396;
	bh=bW35Ufj4VHv9Ur2kJubCnwKFFOwiKnwdMXhb9R6xe7M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cl+sNkEetU4iFjrlgJNXKw+ZT9wgo6IdMoP4hz8BBhxnjA70jGPzRRoL/0mAx33Zd
	 dHeYosgX3z81oPzWbiZI0yptFqjV0FWgfsHEeiK4uwhyqqDIgviUpFyJBulzlF3rdM
	 CaciqZHYuOcY6i2NpnJDclAiKaUHv6Q9L5lHSo4SS2diaDfXzct+ujyPVsGrdzrnWK
	 1c7CQThiDcR/RAAwdIYL4EZ2EI+KEVPHNTfxnLe5HKPR4XI5LWgBfv42tlsNk/uwXk
	 k9LTxpf1DvZdgkb4iOJLBVwbrc9AiPgDER8WSQN1bTfnJ4h98vtkkBOcErDbOFRiDV
	 WIPkDttkqUDOg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9C68C53BC2; Sat, 26 Oct 2024 17:06:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Sat, 26 Oct 2024 17:06:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219418-217253-VYnzz91hlr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

--- Comment #4 from Camera Phone (cameraphone77@gmail.com) ---
(In reply to Jonathan Cameron from comment #3)
> On Tue, 22 Oct 2024 13:17:20 +0000
> bugzilla-daemon@kernel.org wrote:
>=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219418
> >=20
> >             Bug ID: 219418
> >            Summary: BOSC0200 Accelerometer Invalid chip 12 initializati=
on
> >                     error
> >            Product: Drivers
> >            Version: 2.5
> >           Hardware: All
> >                 OS: Linux
> >             Status: NEW
> >           Severity: normal
> >           Priority: P3
> >          Component: IIO
> >           Assignee: drivers_iio@kernel-bugs.kernel.org
> >           Reporter: cameraphone77@gmail.com
> >         Regression: No
> >=20
> > Created attachment 307035 [details]
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=3D307035&action=3De=
dit=20=20
> > lspci output
> >=20
> > Hardware: Acer aspire spin 3 A3SP14-31PT-38YA
> >=20
> > One line summary of the problem:
> > BOSC0200 Accelerometer Invalid chip 12 initialization error
>=20
> Unfortunately that ID is used by the windows Bosch drivers for numerous
> completely incompatible devices.  So we can't do soft matching on this on=
e.
> We need to know what the device actually is and add explicit support for
> it.
>=20
> So it's going to take some detective work to find a device with ID 12.
>=20
> Any other information on what device this might be?
>=20
> Jonathan

I looked through all the bosch accelerator datasheets I could find and the
closest i could get was:

CHIP     chip_id
BMA423 - 0x13
BMA456 - 0x16

I'm thinking it may be the BMA422 but that datasheet isn't available for so=
me
reason.   I did also ask in their forums but no responses.  Unfortunately, I
don't think it's an easy task to disassemble the screen.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

