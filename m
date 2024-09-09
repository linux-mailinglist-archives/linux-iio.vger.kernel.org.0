Return-Path: <linux-iio+bounces-9396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80A971CC5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF42283EBB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6331BAECF;
	Mon,  9 Sep 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWaLTeAl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857F1BA29B
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892669; cv=none; b=mpNt/TRWFG3QN8hO3mNnLOVMk4UJ+bmSf9toweTbPrvEWUGAQaRUQyP+YSNBph7lSYs9lphMf6LJesTqZzHo5EUFQO0ViUSHFl9oqRoVAWoEvJYjchtv2bfcN0wqwwl7WsivDLwGDuMMgD8l9t3NKk7vW8hpH0pZ6c8d0Fgy41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892669; c=relaxed/simple;
	bh=mlNFuHnn70dl4OVnjwrJB6vSmo9VUfr/KzMYUHD2tug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqNE3Zkxt4hV9Xe+vByjE4Nt1ZLVSspLWJAt/ZMJ8IH+qF+B8ixyYneR/YYdzb24ARjQ7ubKbQ57S8S3YOjgG9XPH7FNNTWfPRTdJLSbD/CDe2lvAGKzgV2vuDgueGdFqYMLgPFp+partJqpUl6PmDomaD8b8GezkcDcBvbOQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWaLTeAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0306C4CECE
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892668;
	bh=mlNFuHnn70dl4OVnjwrJB6vSmo9VUfr/KzMYUHD2tug=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PWaLTeAlZHl8yGar4TnlUAQigjQLNuye/pI5l+qB9m48cgr4IaWxuHzRXh+DOu+iH
	 BE8cOZZ9pVjbat6edLNB40is67UQ5nB/6bRWEVGg6REC/MyC1kSTavWTbX/vu/dwEe
	 DOlUm/DIXXbgoL+PS6uiyIEEW8iXgbYRNK870H/svNAFnnrRAjzwt5uvqDzUcaUg9w
	 Klin4mD4MBxJ2sbLrIJr95sDlHA8IA0cxecdwxfsLWAbZ7FSiYunoDcBuNzbpwDvZb
	 hO8aLnXQn0nvpEDvdf9ugf8eILkasOM58FS8umN0z/hw+J/aBaZrcm5Quntan8qI0c
	 I0pSQCv/Vs30g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C704AC53BC7; Mon,  9 Sep 2024 14:37:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Mon, 09 Sep 2024 14:37:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-218223-217253-h08G3W66ZG@https.bugzilla.kernel.org/>
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

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |andy.shevchenko@gmail.com
         Resolution|---                         |CODE_FIX

--- Comment #5 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
AFAIU the commit f2a71ebdf231 ("iio: hid-sensor-als: Assign channels
dynamically") has to fix this. Correct me, if I'm wrong.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

