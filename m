Return-Path: <linux-iio+bounces-10258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C189920EB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 21:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6481F212F4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1F18A6D7;
	Sun,  6 Oct 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4AU9E2U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE68155336
	for <linux-iio@vger.kernel.org>; Sun,  6 Oct 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244286; cv=none; b=CL/fqLoR5CEhPS+6TqDM3ZAqPzpAWXIqTDed8BoaITbNjQqdn1Kw97Zn2PeWLYuDhE2tcLmH+BKGyQHQPzrmAqELsPkApnv9CkzwuJxq3WO6NxE7yQZxxrMsKaTA6POjD5qCLVaXuU1tUb1IXAwsKm8sOFHYRdGrZJdzWQDHhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244286; c=relaxed/simple;
	bh=WukbyZDqUmqm/LlDNcNVg8lCJeszolsm5w9gCkhm+p0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPoqpKV2BcoBZnVML31ofsXx13ZCyEljTSIZ48TliXRxojOexbH2vNxdTPhq//7ZJbXFHyJ7oj8aj692vo0t5KOW3TvHM2r4xYwD3arIDfJVkG3NLbTw87EcdpP/JC0V6fmmH2DjK+bEcKmZPgn6u5MzR3IxE/p46FQGXV3t830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4AU9E2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 742D4C4CECF
	for <linux-iio@vger.kernel.org>; Sun,  6 Oct 2024 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728244286;
	bh=WukbyZDqUmqm/LlDNcNVg8lCJeszolsm5w9gCkhm+p0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h4AU9E2Ukpt4MBSfryTHT2IgMLHv7I0myHZuOFHmoFLIH8hW48jpAWAc+Ndgg6RDv
	 gHPAqVxk6JNkUNbnxYFdMnIo2oYLozYBfJ3PygGkOQE3iOTeIuxw1B7CFFy3Xc2QY1
	 ECgLlXNXIWwdICAdJTBgUZErktdDNOrQ20I9W+8T8EBQG3l/kwORzeTuWg5IQCgaks
	 C8k+gG4cMBN5QHwqr3vMKb9Lp282+OHJkXxNCzqtkRhYRjd4ja791xzd0QdLb/+g/R
	 fPBT5NoyeKeUq4HMK8fA4pPADEzKaLREg58t9MLrzt8bFyw0EqBnm5AghE9axkJxSR
	 6usmsIm43WEMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6864EC53BCA; Sun,  6 Oct 2024 19:51:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sun, 06 Oct 2024 19:51:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-dr3tSMZ9VE@https.bugzilla.kernel.org/>
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

--- Comment #8 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
(In reply to Tudor Gheorghiu from comment #6)
> I saw this bugreport and I must say I encountered a somewhat similar but
> not quite the same warning message from objtool when compiling with
> clang.
>=20
> This is my environment:
> Linux version 6.12.0-rc1+ (Ubuntu clang version 18.1.3 (1ubuntu1), Ubuntu
> LLD 18.1.3)
>=20
> This is the objtool warning:
> > drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw+0x89:
> > can't find jump dest instruction at .text+0x8be
>=20
> I dissasembled the binary and this is what I found at that offset:
> >    0x0000000000000781 <+113>: jmp    0x8a4 <adis16400_write_raw+404>
> >    0x0000000000000786 <+118>: mov    %rdi,%r12
> >    0x0000000000000789 <+121>: lea    0x30(%r14),%rdi
> >    0x000000000000078d <+125>: call   0x792 <adis16400_write_raw+130>
> >    0x0000000000000792 <+130>: mov    %r14,%rbx
> >    0x0000000000000795 <+133>: add    $0x30,%rbx
> >    0x0000000000000799 <+137>: je     0x8be
>=20
> Looking at .text+0x8be:
> > (gdb) x/4i 0x00000000000008be+0x8be
> >    0x117c <adis16300_channels+1180>:  add    %al,(%rax)

How did you get 0x117c? It can't be correct offset AFAIU all this.

> >    0x117e <adis16300_channels+1182>:  add    %al,(%rax)
> >    0x1180 <adis16300_channels+1184>:  add    $0x0,%al
> >    0x1182 <adis16300_channels+1186>:  add    %al,(%rax)

The above looks to me like a data or so. But I don't remember by heart the
actual binary codes for these assembly to be sure.

> I cannot tell if this is an actual issue, or just a false positive,
> but I decided to post my findings here nevertheless.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

