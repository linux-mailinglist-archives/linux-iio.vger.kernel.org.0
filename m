Return-Path: <linux-iio+bounces-10737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B59A4523
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B59B2820D9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649E204021;
	Fri, 18 Oct 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkqqebYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4020513B
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273199; cv=none; b=fZeo3sjdIP+LsIS4i6EQ65UpQ7emgjIFsWQ6TFa/AJet8oE0OXXKHlrrX/kaum4SBW3obt70oy8SGBrKJDUXvDEEfnEWlFBlgAAMAHlukhW6EQxbLAf/w9QSZAM/F8wfaRwDddvwmxyQPCxtWXl3wE3RMh/Lcj0CygpM91xKaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273199; c=relaxed/simple;
	bh=ULmTe9oT5zv7qqW1RD4RCShULoAISyjbuF+adyt0yKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeHo9z2qfUvZKOgljNxYSFrWz1ntQgvtG4LYLwlhBUzIuwZCdgjX6cvLxJ0tAi6vlvNLTVwGEDr0eJXV6nzHBmSOoZP9PFEA7J0m64LZVipk3Zzg2KgAx88lWz66HZbqeDrnzzxbakXz60D70d0Q1LdqXbz9Z8UL174wUGKQ88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkqqebYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 343C4C4CED0
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273199;
	bh=ULmTe9oT5zv7qqW1RD4RCShULoAISyjbuF+adyt0yKs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OkqqebYVg4kSALQTLmAxNbSxPTHCqgiThYuXTmHqO1/XGv24kx30RQY2sEjVwwNxA
	 Y0/fHtTn8qonb2n0Eo0uKCHd9Qpssqsn/nfOHzfroooBMrcvsE76V1b4aktI7Wi/06
	 kJryE5O+1APBZdoGQ5N4mCaoZFswkdUxtYq0c9B7MD81lOr7bC9JWDjLSpPpIW8JB0
	 ByJ/NT4rhR4F+781BNFWJ2Ph7pIuKmzU2yi8XFhYYarqAoZ+qD6I1Zxrpg5a6w25bS
	 AW4nnLXF04hsB8jouYt83QfNUtsoHv20a3ct/ZyxX34nshRSs2j+jvHRFMO3usBqYz
	 Oe9hSqABPRcbA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 26FCCC53BCE; Fri, 18 Oct 2024 17:39:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Fri, 18 Oct 2024 17:39:58 +0000
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
Message-ID: <bug-219192-217253-MkuhDJiuvs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

--- Comment #10 from Jonathan Cameron (jic23@kernel.org) ---
On Fri, 18 Oct 2024 11:02:41 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> --- Comment #9 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> This
>
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Df=
or-6.13/core&id=3Db2b8a75e1d88c551a0b30d44d0be552210219eea
> one is related and may be used as an example how to fix that.
>=20

Maybe.  Though not quite the same as in this case the code
really is unreachable. The compiler is simply failing to discover it.
We could but BUG() in all these places but that is nasty.

The series:
https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-0-7753810=
b0f7a@baylibre.com/

gives code the compiler should never fail to figure out, so
using that instead is a better approach in my opinion and
Peter Z just applied the infrastructure to his tree today.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

