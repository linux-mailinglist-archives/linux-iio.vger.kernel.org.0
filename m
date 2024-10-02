Return-Path: <linux-iio+bounces-10011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF298E4DA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 23:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019BE1C21ADC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD4216A3D;
	Wed,  2 Oct 2024 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRgDmIPY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8511D1316
	for <linux-iio@vger.kernel.org>; Wed,  2 Oct 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904297; cv=none; b=HdwNZgI8QQ7UwC8WXWYYWen0Wk+ZODhUygwJ1elPvY158lX94R19BqGCSKHurUwIWPfQiBG+XnyrfkSvqE9PudvXlrNwWyryhO2frzxF2O4IiVsbCX7+j7vg+Qeox0pa36+hfV7a0wdeFKiqs60hVJcGOhedk3HIg+/sAFKb+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904297; c=relaxed/simple;
	bh=Aw77APlnH+yDg42+s0HVX8UgxRMvSO6hfy2XOayYMts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XbbdUwDWKcfU794Ko4eDMHlqDKC/MXlzgixrqvcN46nQozb4gv+T1wp5DcN2N9SbIQ+ZYHHQnz59bBQyS1IbldrWlx6nJw0yPyU8xY/9/tvXRv5GG47GALJE3fB2OxAMcoQeH0/v8RiwUQkazF+0ejrfc8nzg4uFuYFiFqq7vvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRgDmIPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76793C4CEC5
	for <linux-iio@vger.kernel.org>; Wed,  2 Oct 2024 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904296;
	bh=Aw77APlnH+yDg42+s0HVX8UgxRMvSO6hfy2XOayYMts=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lRgDmIPYN74gZOn4ByfIRPy9thmdRox7BoWQCZrIySJPEDn0quFONKXWpffUE7CSC
	 NwoSVSFDQ3NBgQ5++2o+yjB5UL/aWx7b1SWOYKHLy07chLa3efDN6R9xmlQDLGIed7
	 5ZQt7I1asN4RaK+YUrmUfQ5K/jG2q5M92OM1mkDsuWOT9hBofoW8S03PNXlfZH7HGP
	 VrHfu59RmCnNRnKF4Ns6BKPefdl/jL2f7UgnCssNzbVLq62eFoJw9afjAPV1s95Bz4
	 VoZFwf6lww/HHASuv/aTYTSitJH+UJuNI7bG92D8SPmT6S31sy93tdjTZqzx84ikr5
	 K2Q4zt7Oz/UBA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6A123C53BC9; Wed,  2 Oct 2024 21:24:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Wed, 02 Oct 2024 21:24:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tudor.reda@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-hHOd4hSpUz@https.bugzilla.kernel.org/>
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

--- Comment #6 from Tudor Gheorghiu (tudor.reda@gmail.com) ---
I saw this bugreport and I must say I encountered a somewhat similar but
not quite the same warning message from objtool when compiling with
clang.

This is my environment:
Linux version 6.12.0-rc1+ (Ubuntu clang version 18.1.3 (1ubuntu1), Ubuntu L=
LD
18.1.3)

This is the objtool warning:
> drivers/iio/imu/adis16400.o: warning: objtool: adis16400_write_raw+0x89:
> can't find jump dest instruction at .text+0x8be

I dissasembled the binary and this is what I found at that offset:
>    0x0000000000000781 <+113>: jmp    0x8a4 <adis16400_write_raw+404>
>    0x0000000000000786 <+118>: mov    %rdi,%r12
>    0x0000000000000789 <+121>: lea    0x30(%r14),%rdi
>    0x000000000000078d <+125>: call   0x792 <adis16400_write_raw+130>
>    0x0000000000000792 <+130>: mov    %r14,%rbx
>    0x0000000000000795 <+133>: add    $0x30,%rbx
>    0x0000000000000799 <+137>: je     0x8be

Looking at .text+0x8be:
> (gdb) x/4i 0x00000000000008be+0x8be
>    0x117c <adis16300_channels+1180>:  add    %al,(%rax)
>    0x117e <adis16300_channels+1182>:  add    %al,(%rax)
>    0x1180 <adis16300_channels+1184>:  add    $0x0,%al
>    0x1182 <adis16300_channels+1186>:  add    %al,(%rax)

I cannot tell if this is an actual issue, or just a false positive,
but I decided to post my findings here nevertheless.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

