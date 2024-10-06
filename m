Return-Path: <linux-iio+bounces-10224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C2991DF2
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EC0284240
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AE17278D;
	Sun,  6 Oct 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP2lKNXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C42F2E
	for <linux-iio@vger.kernel.org>; Sun,  6 Oct 2024 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211764; cv=none; b=cuzkAI75C8x8rpPHiR1zLxafH2uQwRSZejwYcIgGgRwZKY3j7LKmjgfMNzWEISViQhC97Xiq05w2gK1/eTVycIRLwVCJwBNaLKOUg+519S9WkSZGlKSl3ak8meXNJ9He9ZgFIW94bBLmldetzpu4xkuuF8WeP5V5D54l6DMO7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211764; c=relaxed/simple;
	bh=2YlgPsgtMvlgxx2GZ9YaHdpobKKcCgd3iug5aiKjGGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7cZsww4rChs2+ZScpCkwAPIRe9x9Ldo8PpUT6rFt6POv1Wd1yzyNoAhAZIHlNQgjLh6EuUPAIfSk0IRbrbLZtEEENz9+dqgSybshNmGwKK6MjUJ+1LAcEaXCWnydcUhDx2MH617GWy7DgoMNtSMFlnB0WGjmhh+t5o8fKzxkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP2lKNXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEBBDC4CECF
	for <linux-iio@vger.kernel.org>; Sun,  6 Oct 2024 10:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728211763;
	bh=2YlgPsgtMvlgxx2GZ9YaHdpobKKcCgd3iug5aiKjGGI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PP2lKNXNAL/0xMUahZD595NXHhGZCqgUep33+K9rPyfd+4/otaUlPBW1Po8UTiVOh
	 FBYTdoJE+4ejP9oa9bjuYPOJfXtCgL1+yYcfiR8yzM36Ga9236sywngSZyVvSB2C17
	 6V8ddsZq5XJoDeLKmuzsIERpUcIDv/91fSSt/lexiZ2xY5F2GtQp8C+NLfMkaWHEZp
	 MjEkG8CKxdzm8JJ9xpw4kDRs+VO+8VM9PVpNqKDpexZa7ji31R0v8HuA14A6CdfG/L
	 nJ1DfSrHQ6sEwD+TCecyFPz/aJpsDpFLofdWxkHcHQB/s/+Jzw17mlkcjSdMtVt9Nu
	 KBrU+TKesuJuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3738C53BCB; Sun,  6 Oct 2024 10:49:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sun, 06 Oct 2024 10:49:23 +0000
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
Message-ID: <bug-219192-217253-2Y9jJRmKo4@https.bugzilla.kernel.org/>
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

--- Comment #7 from Jonathan Cameron (jic23@kernel.org) ---
On Wed, 02 Oct 2024 21:24:56 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> --- Comment #6 from Tudor Gheorghiu (tudor.reda@gmail.com) ---
> I saw this bugreport and I must say I encountered a somewhat similar but
> not quite the same warning message from objtool when compiling with
> clang.
>=20
> This is my environment:
> Linux version 6.12.0-rc1+ (Ubuntu clang version 18.1.3 (1ubuntu1), Ubuntu=
 LLD
> 18.1.3)
>=20
> This is the objtool warning:
> > drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw+0x89:
> > can't find jump dest instruction at .text+0x8be=20=20
>=20
> I dissasembled the binary and this is what I found at that offset:
> >    0x0000000000000781 <+113>: jmp    0x8a4 <adis16400_write_raw+404>
> >    0x0000000000000786 <+118>: mov    %rdi,%r12
> >    0x0000000000000789 <+121>: lea    0x30(%r14),%rdi
> >    0x000000000000078d <+125>: call   0x792 <adis16400_write_raw+130>
> >    0x0000000000000792 <+130>: mov    %r14,%rbx
> >    0x0000000000000795 <+133>: add    $0x30,%rbx
> >    0x0000000000000799 <+137>: je     0x8be=20=20
>=20
> Looking at .text+0x8be:
> > (gdb) x/4i 0x00000000000008be+0x8be
> >    0x117c <adis16300_channels+1180>:  add    %al,(%rax)
> >    0x117e <adis16300_channels+1182>:  add    %al,(%rax)
> >    0x1180 <adis16300_channels+1184>:  add    $0x0,%al
> >    0x1182 <adis16300_channels+1186>:  add    %al,(%rax)=20=20
>=20
> I cannot tell if this is an actual issue, or just a false positive,
> but I decided to post my findings here nevertheless.
>=20

So far no one has been able to identify an actual problem, so I'm=20
treating this a false positive that will eventually get fixed from
the compiler side. Or someone will explain what the issue in the
code is.

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

