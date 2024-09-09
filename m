Return-Path: <linux-iio+bounces-9407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC06972227
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 20:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BEB23581
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031FA1898F7;
	Mon,  9 Sep 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHu94af7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8D14B06C
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908205; cv=none; b=rlxh1CA2p3fCClqc7ff80EZkxs3ffcbC3GN0bnFnSdi+BX3R6jOmw+ggRM5x/sOX81N1fnzERYvEKpr5m4efIsdSL6ImuTeEM8ELks4r6JBM9Y/8y1Psxh/L3lZXyma7CfgdRQY85voMct2TQ4FFM9mAoc/B0Mmj4RVFupGnK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908205; c=relaxed/simple;
	bh=pgVKGCcYF3zdOnglpMy6wqFzBE/myHCcqpKxtcRHo4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+0Nul3K6lhV4kZIhhBs+bVp9iOWICpo9znPTi1MupybNO017dAzuVUWnOn+n+tAf+d6US2D5CbOTy2w3V+hmpbh2fqONcXlaR61HJo3i1VC5gO9hgwwYimYjnesox0BpLCTrRIEnICOGqDD5ZZV7YvTTgHaQbINC3Ff5Jr1Fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHu94af7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CDA6C4CECA
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 18:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908205;
	bh=pgVKGCcYF3zdOnglpMy6wqFzBE/myHCcqpKxtcRHo4g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JHu94af7P9lQtC+dDF3PM68w5FcGyBZXq7asSi7KKAq8pYa85A/qbHcNs4OM8bTMx
	 gbIOwXw6FggQQqLHf0iZ3KxOYVvF+sxDUIOaY3F6DyzVGYYG3Xun3Q/hn7NMCxjekl
	 Dgp+da5bNzguqGegMCKi4j9rePNOLyisg+VDefrc+MekoxDQtwqq7YrZKtBnGt5bOx
	 y1RV+nCZBQXVtpdvCykrLLJgCAt8SwPJc/hTkeZfyxVjcBn8BjG1ZdLLniVsOCudAt
	 yiUPnVxx7DLZz9IHigRfZbbFOaclOU1Zmte6SCQsek7xfwdx2/jYneL9r1ZhrK9c0z
	 3yHnWjgWAgglg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80D6CC53BC5; Mon,  9 Sep 2024 18:56:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Mon, 09 Sep 2024 18:56:45 +0000
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
Message-ID: <bug-219192-217253-8tnBTzy5wr@https.bugzilla.kernel.org/>
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

--- Comment #3 from Jonathan Cameron (jic23@kernel.org) ---
On Mon, 09 Sep 2024 14:31:02 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D219192
>=20
> Andy Shevchenko (andy.shevchenko@gmail.com) changed:
>=20
>            What    |Removed                     |Added
> -------------------------------------------------------------------------=
---
>                  CC|                            |andy.shevchenko@gmail.com
>=20
> --- Comment #2 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> Might be related (read discussion in full):
>
> https://lore.kernel.org/platform-driver-x86/Ztlto06GyFxLXz1y@smile.fi.int=
el.com/.
>=20
Thanks.
https://lore.kernel.org/platform-driver-x86/20240906031601.4yodvhurcyi26qb2=
@treble/
Looks like the relevant info.  So current view from Josh seems to be that
it's a clang bug.  Interesting to see if that holds up if reported to clang
folk (or if there is undefined behaviour none of us are seeing!)

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

