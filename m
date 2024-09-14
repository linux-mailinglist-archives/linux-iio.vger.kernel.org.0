Return-Path: <linux-iio+bounces-9542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2597908F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DF7283082
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBE1CF2A3;
	Sat, 14 Sep 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv836G4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D01CEE91
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313850; cv=none; b=Hvmpd5B62Jd2uZCTeML8LsF4ZiPSvC47JpzFQW8eoHpvLfYHS4p66uXuULVr9ruD40lO4wgYqfsUH5LirTuv8ipSoqhdYfC3vA574NvcELt+bwpRgLzrWx2WmdPmeB40kBYtGpd0Y3AQJ815ckKEN7MXaA7IXgKQGUl+MSuiDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313850; c=relaxed/simple;
	bh=kXI9kAe14ch5mz8azuuabk2/8p5/sG1xczKFf+cA3PU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+8WLHibnMXCKrYOxxaDRAq+kojz2LDLa+bz9HQkcyxrAMdrujRqPEjoBh9rO5nJWahCv5vf0oQ2fV/4XUOzXOYEXmjJ3bcu/yw038zTo7Wth6h1fBxr5C6cJQAeZDPz2y1+qmbgjiOx3ykqmFGYVtf+rloZuh9Ql6qdh5YB+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv836G4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26B57C4CEC0
	for <linux-iio@vger.kernel.org>; Sat, 14 Sep 2024 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313850;
	bh=kXI9kAe14ch5mz8azuuabk2/8p5/sG1xczKFf+cA3PU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Uv836G4Khwm4p9R+FkObo1VIMngR7b6VXZUBQixTg/eSX4sDkOTL+xmKcsnVvDCPP
	 YNw7Eh5cqv8dQwLyH57jU3grOmWE0bP9E3cRLWA8LoAqZnMUzvmx2iQ/YVbbt6emD8
	 ly5W2+pYTRIGFtKj0cfji6WmtO3L7Wv2kB5QUPBNHAUV5wb3PEZ/fgrdWl+oo1QB3M
	 VwNiKRPpyZd3gkUwrRy/kr4yOsmp4ZKw3qDnkv+G+nABTD8wrpUDDPStmVTjt4u1ks
	 xruAnP8IM0iQU3v6HmBXlotG2CU9FB7hbCHCip10LAUoaIICxVwQKTuC4raFhCuNfL
	 uAuJh+yCch5oA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0D357C53BC5; Sat, 14 Sep 2024 11:37:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sat, 14 Sep 2024 11:37:29 +0000
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
Message-ID: <bug-219192-217253-CQhxB1j2ts@https.bugzilla.kernel.org/>
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

--- Comment #5 from Jonathan Cameron (jic23@kernel.org) ---
On Tue, 10 Sep 2024 05:42:56 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> --- Comment #4 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> ...with the difference that here it's GCC...

Good point!

So might be something completely different :(

Jonathan

>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

