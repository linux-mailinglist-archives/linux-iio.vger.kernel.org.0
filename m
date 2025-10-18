Return-Path: <linux-iio+bounces-25216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6EBEC3E6
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 03:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A511A66D42
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 01:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AED14B06C;
	Sat, 18 Oct 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMK1xZmq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02ACCA6F
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751537; cv=none; b=JAlN93bqbULKnDz54ERV3+xU0bXizUauIpVonrHxndwNWlYap+iaVXJ6nQLBAf6vvr5O2vwqM77BxA3zDW6TM+jCin4DTfGoquRyrezo8j7qzXT9kuejj9xU1cGWpVnrJDIq2sCSh6R5qHO0iF6u0eXonpmu/Q1ifLeG5NdvUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751537; c=relaxed/simple;
	bh=T1cRn7KVF/YvMmm/3MsaT2wp2r/URpKc2vSEePh5xYM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UMmKVFyTk/t33j5O632h+eWfBWQDGCnW+ZgislpeWvNNm3G6BYh0PxBzoIwdaPAKSG2Ri5qF1Kgz8nVfD4F4Ol90e7RLv5M2BgVo13ZhwPBu+lOIssCveo5XLtCBXmp1t2JUfLHnwdVqKdzMNEslk34ufQybPuLdkanydktenDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMK1xZmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BCD9C4CEE7
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 01:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760751537;
	bh=T1cRn7KVF/YvMmm/3MsaT2wp2r/URpKc2vSEePh5xYM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SMK1xZmqkwH20Lz7/f0VHp/TXb+vqGyXvFoOaCuKE6W2+OdIbWBVSKgLLKN2Mhn0C
	 M2quUGm3iH27tZXmsmTIZHbgBoeqM0HWbCHeWD1/SfNPzY+MDfzLS5zH290Dt6O5WO
	 Nma9pgClXqt9UVu5RxdsZCooE0kTbhbZGGBdr2jBEUbbGFqByr7nbyv48/+qTfrQQe
	 9L31IID4wTEItSocTxk6igngq9KKQgQw1+VrTLwwcjLu6BMcgSuo5af3aUcsICvL12
	 Bytmv1cPGbBRWm6Ie1wpZsXpLuKm1gfdQgBOxeIl4PG4Pv5wwkn8ymw98XMSCjRg2k
	 eda1EfbFAKDLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 829A6C41612; Sat, 18 Oct 2025 01:38:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220678] XPS 9440 ALS value spikes
Date: Sat, 18 Oct 2025 01:38:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: boliverworK@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220678-217253-4z1p5QVm9G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220678-217253@https.bugzilla.kernel.org/>
References: <bug-220678-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220678

Brooks Oliver (boliverworK@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.16.11-200.fc42.x86_64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

