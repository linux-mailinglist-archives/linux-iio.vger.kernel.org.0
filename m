Return-Path: <linux-iio+bounces-955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89B814C84
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16791C23AAF
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6754A3BB36;
	Fri, 15 Dec 2023 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd4lvGHb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309003BB35
	for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 16:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFD6AC433C7
	for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656563;
	bh=S9ECmfK9HCqMC4itmhPQuL4vsADbm+mJ0MDegrim8FA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rd4lvGHbAVVa9tJJBMTZyhek9cKRjpR1D+KhBRQ7TdpIEmPD1s5Ygj+P4dUKdV9mT
	 FNYS3lICqLCszPBXFsx2+fvnXHXDqdQL1uN8gmxx6gHlU+DsEksfTBH7g+VXum4+V0
	 oNvefGShM+Ukq1BHCBT+u+RVcnbmaOUO3x5JN1lwAUZsK/Bb+y2rwQq07VBm7Yt14O
	 3qSX8C6y1GPYPN/+v4XC3+h3B29IEvc6/YR5Ewx/Kqrg9P+KV3jiXCGNMxm/fWEl4J
	 gjxNZWW7l8Lsi9qF/OInYes1WWzsA2TGShYWwANBAo/WXaDzNxuH3erWICSDaMs9wQ
	 TCb8VQOyfrQBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 905DDC53BC6; Fri, 15 Dec 2023 16:09:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Fri, 15 Dec 2023 16:09:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-218223-217253-FDhLmDAJ5C@https.bugzilla.kernel.org/>
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

Srinivas Pandruvada (srinivas.pandruvada@linux.intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |srinivas.pandruvada@linux.i
                   |                            |ntel.com

--- Comment #3 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.co=
m) ---
Created attachment 305607
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305607&action=3Dedit
Patch to fix this issue

Please try the attached patch. I also posted upstream. This issue broke ALS=
 on
almost all Intel systems.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

