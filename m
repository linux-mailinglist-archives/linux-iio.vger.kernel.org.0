Return-Path: <linux-iio+bounces-8774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0395E2DF
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 11:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1F4B217AD
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E82774E26;
	Sun, 25 Aug 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2CKkfzA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004C2207A
	for <linux-iio@vger.kernel.org>; Sun, 25 Aug 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724578551; cv=none; b=XqYb90P5qjc/xQ/OcRRw01AWdov4MFbz/4Ic4hhXBuLmIWZ8v+Kua4RAuMXdrxy75xuBnyjz4Zp2a6GFiF6QH5g3USm+YnmyPV7OgfpomRsGd61adcXZzyeRORM56Y1rLlae/ewMbZAVS2mtJ0K+9qiS3dxBYQfaYTnXe7Wo7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724578551; c=relaxed/simple;
	bh=RMIB8JD16xcUGZjnE4lHVbPrsQDZUId3lKcxy+HN9Ws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mBuAd0WPZtSgIZ3KC/q/l+Tkp4bbmTWOcrnJm3WtLp2mc0UaNAt7gDsKhQrwFhMD8CsGDTg0kGROrU5nLSJOvfw9Fh+CZBnA/tmlHSLj5as22Z4EjAFnxXVrDfTjW4ie64eetYDPToYI741642PHKpxMbMlANDg9AeSnphJTAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2CKkfzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50967C32782
	for <linux-iio@vger.kernel.org>; Sun, 25 Aug 2024 09:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724578551;
	bh=RMIB8JD16xcUGZjnE4lHVbPrsQDZUId3lKcxy+HN9Ws=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l2CKkfzAjYYI9p7BVyBnXgddBthuEB350/tTQyjMLzolqoaASr4ZZ0X8dqgBq36Ct
	 eB+vHbWtJx7wUNsj2VFvwZBit8WsQW7rSHYgngfuDtQIfQxh0Or51/p9cqMFkQTZUP
	 WUmuOwS8nZk7J3Y9fQeJc/pDyMfG5A2JyBMh0kyCZ24D2zq4YEtlY1I9aBkY17Gy+d
	 s6WSaYcjMiR6BhEOJe8VQUNxJUw1dZ/wtISt3pvR+EcWH9zmErIOiNzkH3QOwSA+cA
	 K3eVM5ntBougXsfdAtjpELI/duXKw+wZrH4Sf/Hayh5TkXZ/xp1M/SMRP8HaxYnkKJ
	 Q4bjw8jPNnFtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 47F09C53B7E; Sun, 25 Aug 2024 09:35:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Sun, 25 Aug 2024 09:35:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-219192-217253-y0moMNszWc@https.bugzilla.kernel.org/>
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

sander44 (ionut_n2001@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.11.0-rc5

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

