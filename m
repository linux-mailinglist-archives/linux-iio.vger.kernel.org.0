Return-Path: <linux-iio+bounces-4074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329F899159
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C721F23B10
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505B253381;
	Thu,  4 Apr 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDdTTOaX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B551033
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 22:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270014; cv=none; b=L2pKAOj2ciAE0eHLvmR3YsNPyTYP/rxXeBEMYDBR4+geloF+N4+MjQNC/ZjaZElllRR85FWTy8DxVommK8c/l7NQiZ/S01vZyAV0MOdSS3zYrgw558tdsaVu4oTq9yMmEuLZm9no1bGZzQlKC8ak0m9+gevQOwkIjYfuI1H19uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270014; c=relaxed/simple;
	bh=ib4cEoNYmHUtnVFuoYu6UvbbmkZMyyPJKkx4+oQDd58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILxb76lEyfVWWwnvp2moGF5x8KdtbRJh9wU1/WN4JT3miQJS2jbqmUZs6gENn2WAVlED8uPU7gN4GmpZRwaNfTnSVUIyqYs/du/Zq0bjnZ5sWK47l994SrZnh+dJbqLkwjZyWxLDbgsqIO2qBQWgkKDKljpmqPzu3hYuWJ9n0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDdTTOaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 928B4C433C7
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712270013;
	bh=ib4cEoNYmHUtnVFuoYu6UvbbmkZMyyPJKkx4+oQDd58=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gDdTTOaXZgp1W2zXA0EjrF2m5gRNyC+96ofK9JXloDgixFin+0/ocJ4QhD8gLHLvF
	 6ss7gg7+isEH9GSsla1NUaiMWZBqJP8J7Mr+gXSaO3jcEWdqQLPW9il1PXZAvwreTI
	 SPf9y3SPKJ/fqJHXb/A/QiB5nJE4hcTgUcEd4KkCH7I4pyd0sfumcZdCq+IqRcfgW+
	 Kaj8OERy0aCzdgZm1OlVfLabNK+RrjYlpeYT6FhwhKx05XmAr4IB+Jea5oUgtxOswk
	 WcyQM3soCAZ8RYB3LhkNCa05IPlGdsNMnK99iRDe4uu792DlH7to+YBTmZAjWV/6sM
	 mSJmhhFyV10vQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 84B7CC53BD2; Thu,  4 Apr 2024 22:33:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Thu, 04 Apr 2024 22:33:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-v4Wc8wrdao@https.bugzilla.kernel.org/>
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

--- Comment #24 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Hello Hans,

Thanks again for the guidance, and my apologies for my brief absence.=20=20

I actually checked and they had a trivially different ACCELT_MOUNT_MATRIX
already.  I think the problem was that they were missing a colon, LOL.  I
tested their sensor line and their matrix and it works fine as long as the
colon is properly present.

I have submitted my pull request:
https://github.com/systemd/systemd/pull/32108

Here's the actual change:
https://github.com/systemd/systemd/pull/32108/commits/dc133ca33821e3d559835=
1b973bc91ede5144c92

That should work correctly as I've tested it in my hwdb override file and i=
t's
working fine there.

It looks like your request is making some progress toward getting the patch
into a kernel release too. :)=20

Thanks!
Kirk

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

