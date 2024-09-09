Return-Path: <linux-iio+bounces-9400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA53971DE6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A01C23302
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FA219F3;
	Mon,  9 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0xsCyeD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB91CD15
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895187; cv=none; b=jUyjC50GuEASRNTH/POVqX+IC+c55q2Ed+HNvCEm96bKlvn9qrgc3E1q43uNw8q6bRSmwhkJNB3Fu0iy3mkhH5AAzNIM9eYKoeOBni76L9xknPUZwKQMStRYYjFu6CknUHQgk0ZdPRw93pDThAr6dX+CdkQGeEm7jZkzh1GKKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895187; c=relaxed/simple;
	bh=pPQ0Gk9neZ458Ugg0oyBfPHtG1NBGEHxftfnn7L922U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilGQ8XpNZ3FJsBiGqnheH9MG7OS+wxcFvtyAETa1sX+3fRkgy2GEf6bbUwmy9w4h1CIveltXmnSMLYky0sfQl1K2CYIiVe5gE9MxTqF9JM18qUjTkKmC5AqZp0iowT/tkYQevt0Ss5aP2zrxhCuZsBVjxgtdGBQC/X8aTBz+dUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0xsCyeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0555C4CECC
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895187;
	bh=pPQ0Gk9neZ458Ugg0oyBfPHtG1NBGEHxftfnn7L922U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f0xsCyeDfgRrm45PlyU+3KANrGFwKlWZu+iPAL7zNOfOui3Zt/DqvPT2oM09kVPiE
	 eA+twufncIki9Y2crejOoL7KlvcMECkwNZJy/BQG9e+u+HN43aNbAFKFvkeuUNEX8w
	 jBkcCYt3vpe95Vpq1oDFlUFV5s2nXHV+rHPWf2wp6buta+0+3/zzWWYHGV5w4S8c+9
	 CmpIGXK1SaB8KD5z/cVrgncFxhW4oqEscUITJ9QcfSNQJTlLx0RS7tyIJBzpm8/gGO
	 MlOXKgkN199JQs6qkwheJ506RCFbUQ8am4mkUGWOotz9kIbQpeF029bOyYswnYkb7I
	 TeMzzTNYVWDkQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E3E94C53BC9; Mon,  9 Sep 2024 15:19:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Mon, 09 Sep 2024 15:19:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218223-217253-Vc9wUNjT15@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218223-217253@https.bugzilla.kernel.org/>
References: <bug-218223-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218223

--- Comment #6 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
That is correct. This issue should be closed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

