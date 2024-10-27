Return-Path: <linux-iio+bounces-11393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E0F9B1D42
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE511F2151B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6B13C3F6;
	Sun, 27 Oct 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t06kT7v3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF6126C0F
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730025272; cv=none; b=cL/QAx3tZ1hTJarQ3oKFDC6YiCsVHdJ0Yw1pIVwZHG73RCH8l6uXDAENwX/zXpK65KguQxMqIJKjCkvKAnTQ8/es92ANl5bzK1r4PhOHSDfHSBRL9hvHlOlKmmkvBrFFR701XvQJntdkzuwKHgxGyqVEPwMfSP7AFi1JuPogx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730025272; c=relaxed/simple;
	bh=4Ws693RAEsYLAhK3zDFv/Fz3qkTWAI8CnYSz9f7Xm7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhNKx3AA4yLvnATsERL4z1dhEbtO9VDZb0GNCNud+FCL9XTt3kQOTuQeKLZOsjG4TOVYohXXJKTi9fY1qJ0+A3SN2rSfFoBeDhH/+uloJ8cwzyXLMO8ZapK0flnBRZ/a6y3XneMvy1xKeRleI4kIDb0HbOWgyI9N9IaBsU4MkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t06kT7v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9ED9C4CEC3
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730025271;
	bh=4Ws693RAEsYLAhK3zDFv/Fz3qkTWAI8CnYSz9f7Xm7E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t06kT7v3pvYc9lJW51VIfw6dLOibO7ypcYaJ+zRV6MBdgBGG3w0zqGa4pf0menXFY
	 Fthnx/1ZGWQnrk+T+mLR571bEjhv3Uy20LLg0YPcI7TpohAdc5VImdYpuzZMmSgBEv
	 LUcS+o27h9ZOh+xGMrpAp/+Wx4oE793dgfaR5UH+stMSmWrPle1EiyoQ6ZenNhWQub
	 WTJraoKLVtCTG+tO/Vm63/N6o4J7WAHbPjl8DWYc0mLJB24PEjF56rJ7BmG3M5ol/L
	 AuOqm+u1SZAbug1rRGBbKGe1XW5uUsgGDzZkwojACiGDmPzohcNIlMBfRgwD+ieC4l
	 jyLRhtvuZ6Y9A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D4E2FC53BC5; Sun, 27 Oct 2024 10:34:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Sun, 27 Oct 2024 10:34:30 +0000
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
Message-ID: <bug-219418-217253-iRj9vKjg2d@https.bugzilla.kernel.org/>
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

--- Comment #5 from Jonathan Cameron (jic23@kernel.org) ---
On Sat, 26 Oct 2024 17:06:36 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219418
>=20
> --- Comment #4 from Camera Phone (cameraphone77@gmail.com) ---
> (In reply to Jonathan Cameron from comment #3)
> > On Tue, 22 Oct 2024 13:17:20 +0000
> > bugzilla-daemon@kernel.org wrote:
> >=20=20=20
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219418
> > >=20
> > >             Bug ID: 219418
> > >            Summary: BOSC0200 Accelerometer Invalid chip 12 initializa=
tion
> > >                     error
> > >            Product: Drivers
> > >            Version: 2.5
> > >           Hardware: All
> > >                 OS: Linux
> > >             Status: NEW
> > >           Severity: normal
> > >           Priority: P3
> > >          Component: IIO
> > >           Assignee: drivers_iio@kernel-bugs.kernel.org
> > >           Reporter: cameraphone77@gmail.com
> > >         Regression: No
> > >=20
> > > Created attachment 307035 [details]=20=20
> > >   --> https://bugzilla.kernel.org/attachment.cgi?id=3D307035&action=
=3Dedit=20=20=20=20
> > > lspci output
> > >=20
> > > Hardware: Acer aspire spin 3 A3SP14-31PT-38YA
> > >=20
> > > One line summary of the problem:
> > > BOSC0200 Accelerometer Invalid chip 12 initialization error=20=20
> >=20
> > Unfortunately that ID is used by the windows Bosch drivers for numerous
> > completely incompatible devices.  So we can't do soft matching on this =
one.
> > We need to know what the device actually is and add explicit support for
> > it.
> >=20
> > So it's going to take some detective work to find a device with ID 12.
> >=20
> > Any other information on what device this might be?
> >=20
> > Jonathan=20=20
>=20
> I looked through all the bosch accelerator datasheets I could find and the
> closest i could get was:
>=20
> CHIP     chip_id
> BMA423 - 0x13
> BMA456 - 0x16
>=20
> I'm thinking it may be the BMA422 but that datasheet isn't available for =
some
> reason.   I did also ask in their forums but no responses.  Unfortunately=
, I
> don't think it's an easy task to disassemble the screen.
>=20
Without a datasheet this is hard, but you 'could' try just hacking in the
ID in the driver and see what works?  Particularly if scales match up with =
the
stuff on the flyer that is available for the BMA422.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

