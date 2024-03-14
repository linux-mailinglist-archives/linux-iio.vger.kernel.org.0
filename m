Return-Path: <linux-iio+bounces-3505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A179E87BA8A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E2D283CCF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Mar 2024 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539086D1A9;
	Thu, 14 Mar 2024 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN0Skx3Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132856D1A0
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408955; cv=none; b=SkkKA9oH3TpG5orEdUlFmWNWaF42eRGEjYLMm9ldmCG849Ot4iDLBkKhE+a4mxBhY5/3rJV6xIj8GIXxp3PrT5W+Gvz1EUbkm3enNEXHYQPFwAZb0Gl+FVPRPSQ0aCNxwYz6HDU1DCEAP/fgc3Ck7QFgRQXq/b9WCNF0c9sHuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408955; c=relaxed/simple;
	bh=/c6lqdsb+r8VGjsyD++Pr89jC0Gxi6nqoGINgdi75io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CHCLWw6X1y5chVlb2cOPiOKTzKSisxWI0YfHZkS7gsXSzC54F/NS2ms1SbH44blX3fEOXMZF27+Nt0XQt/06DyXGC0T3bQqPIr9f0Ul5ddLNZXCzXirjBE5byqdXhnO3XiyEBCRBxVhTB4TQRyWDAdkUWnYkagTKD97BVwJymUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN0Skx3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94000C433C7
	for <linux-iio@vger.kernel.org>; Thu, 14 Mar 2024 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710408954;
	bh=/c6lqdsb+r8VGjsyD++Pr89jC0Gxi6nqoGINgdi75io=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gN0Skx3ZPWZG0QeYYDrBvJ/1c2uNsDDQhjY9fHM8C2/ozTof7wr6piPPpK/yyI3DK
	 pewaTC1nQX+nob3S35Yz8mkFKEwXeWCUM77qhzLPssOq6hprAT2X/fRYJhD7bGBV/x
	 zwm3xK1bhgekEpa2txU26eLwjy6WISUjCeOh5crR/pvYlWHpvkkmY53qqH73aC9yty
	 tQ2Wvcmdc3/0XUl6uepnUF2J/uAZn1NTbpvQLxkfPdPPjxvXSGHUQG62rG3C4V0/+e
	 fjLKA2oTQcuv6EA1+2HgstntaIiQi1PMI9aT84MeIglj8EoCsAzcLWPGZTRlpQXsUA
	 vQDBAWLnx7vCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 803D7C53BD0; Thu, 14 Mar 2024 09:35:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Thu, 14 Mar 2024 09:35:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-TzlONxVF79@https.bugzilla.kernel.org/>
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

--- Comment #8 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Thanks.

So I've taken a look at the driver and I noticed that it does not reset the
chip on probe. So maybe sometimes the chip comes up in a weird state and we
need to modify the driver to reset it on probe.

Can you try the following:

First install i2c-tools:

sudo dnf install i2c-tools

Then do a cold boot, check the accelerometer works and then do:

sudo i2cdump -y -f -r 0-15 0 0x15

And copy and paste the output to a "i2cdump-good.txt" .

Then reboot until the accelerometer stops working, then do:

sudo i2cdump -y -f -r 0-15 0 0x15

And copy and paste the output to a "i2cdump-bad.txt" .

Now on this broken setup lets try to reset the accelerometer:

sudo i2cset -y -f 0 0x15 0x01 0x10

This writes 0x10 to register 0x01 which sets the SW_RST bit

And then check if the accelerometer now has started working.

Also please make another dump after the reset (from bad state):

sudo i2cdump -y -f -r 0-15 0 0x15

And copy and paste the output to a "i2cdump-after-reset.txt" .

Hopefully these dumps will help us figure out what is going on.

If you are interested in poking more at this yourself, there is a datasheet
available here:
https://media.digikey.com/pdf/Data%20Sheets/MEMSIC%20PDFs/MXC6655XA_Rev_A_1=
-22-20.pdf

This should allow you to interpret the contents of the dumps.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

