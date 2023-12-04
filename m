Return-Path: <linux-iio+bounces-616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297708042F5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 00:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCEC1F21354
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2CC3A28B;
	Mon,  4 Dec 2023 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMfW68yU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF7393
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 23:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C724C433C7
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701734234;
	bh=M768lHMuPxYfT3pOfR9GQdgn5uwpXf8Mdtcp8i649eE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JMfW68yUBskxypUXo+8phPKo1NM2vmMeAqbniaReeal0+Vm0jE3gE3vWjL86A1jJo
	 n/+M6z8cngbkoekNgjWLaQRQCVutvSwUQ1LfAaGS8URDIQjt/3OZeKCElpFZsRzv1Q
	 zifjMsKfl+YqFhhgVW+OldE1y9cKsTfFFi0fHJRdfo1JC7reQ/V7omD9CG9/hXiy8B
	 ba0DGhsLqVQiSwKyOnUoXKVxKUXzNrNdABw/5x1UC+R4gjWkLgWWGVB6mTVLhmxu35
	 oajxoBDEjWtYmYoX4emWCTh1DXE9+ZeWuhupacUckiqa7szVXPz1ib/fUIYj25e9Rk
	 IpgOH5M5L4lyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EE2D7C4332E; Mon,  4 Dec 2023 23:57:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Mon, 04 Dec 2023 23:57:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michael@michaelmarley.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cc cf_kernel_version
 cf_regression
Message-ID: <bug-218223-217253-wPuv6nLkGu@https.bugzilla.kernel.org/>
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

Michael Marley (michael@michaelmarley.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |286d528bf0fae9f334fba857825
                   |                            |b9701df1675b2
                 CC|                            |michael@michaelmarley.com
     Kernel Version|                            |6.7-rc4
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

