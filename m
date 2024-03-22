Return-Path: <linux-iio+bounces-3688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529418874B9
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 23:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A5B1F221CB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 22:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFF81207;
	Fri, 22 Mar 2024 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsHaTCCA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F080059
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145396; cv=none; b=C3L06QnP5tSJUaP8vuaR5X9rjaeiUESbg3hFRmlGNux8Ct8+Zko8usRRlwFOOq7iOpaVm0yFSRZw7cKqxulsnO0mFyUwqkQ9KjwfPpDnMohzi3qRA8rW4RXDPs+FD7Fp64t976qvXFzvO4v/VC363WLQcuUw7cNs/P8qpSRJmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145396; c=relaxed/simple;
	bh=yOTalFP3b2VVMhQ2BtXzP5nWi+bZwIuRXgW0vBUtsZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fVIhBNDxKfsvO792nYijNeTZzObasKrX87VfRYbtBRLKJjhO5kMBeqgrnFIfFRhoqb4mlRLYHRiggNMUA9WJ1qD6LDBamrvhGlATgJiuVj7WooEkPixW83f4eMJ9nP7rlKoTzybDEP/cfOsrorkfsYK4/pEUWeecNiFWPOvVYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsHaTCCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CC61C433F1
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 22:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711145395;
	bh=yOTalFP3b2VVMhQ2BtXzP5nWi+bZwIuRXgW0vBUtsZQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hsHaTCCAqYvYzQFTWD0fN/fLv32qdOpgeXd27DFWXQEfnEf4DuMZvbbrVpv3q1vG7
	 OZfkcT+RUks0oA3Tt1OgVrfCp21CEfbFi22klVEH+F0gmvqvveBHdGLjoW+1VvFBEb
	 DSbG0lZmxKqxyanLHM9ttNipsiFzwSDaWI6KdQyElrm1J+dCzJFvJcGALvW3y1LNqW
	 EnSp1Etkm1RaDs9rVhyMC2xG8xk8V7CjDkQYlthNkSkFA9D0PnSF4gjYjwZRIC8GH7
	 rAzkUMVREBrQly23mudDxAJXuQkEP5bd3MVOEcTkbdolMiptYjpkRF4giHHDAwCRAJ
	 U0Qzf4P/bZPiw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 56BC0C53BD0; Fri, 22 Mar 2024 22:09:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 22 Mar 2024 22:09:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-0lhsOG68qE@https.bugzilla.kernel.org/>
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

--- Comment #19 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
No worries Hans, it's been a busy week over here as well.  Thanks for the
continued support! :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

