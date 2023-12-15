Return-Path: <linux-iio+bounces-962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2BA814DA3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113281F24EC2
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F373EA6D;
	Fri, 15 Dec 2023 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVMCCjng"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D23E49F
	for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 16:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DA86C433C8
	for <linux-iio@vger.kernel.org>; Fri, 15 Dec 2023 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659255;
	bh=qorUAmjTZdFMMvGDXO5fnnVaNjAcnUZJXfSLZlBZ0uQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DVMCCjnglKLb9lEOMgu7zqC/m0reLlzsLDnKadHcT+Pi0wv0dK3qf0LqB04Jik/wE
	 FonwLIIvmiYp1BzgefLGsWsW8qY9G3wprd+r19G4onGEKWI6TKM/zNCjC9+iPJ0XkP
	 ZWqS4IdhchlFZQKV0cA80VQydJYxuiVZwCBmARTkONoLez+hxiZCh85DfzdPmujr4i
	 kgV7LvFmPA24rQWZhMhjCCbqbjQKVc7msU8u/2A5bnpVnD/V6COAvsWvyBwb+WjuuV
	 jicOYfZvlFYUbhaM11NrHlpeM2r+iawaCqYov/XPL2hS5Rv2Rxcr31E560cuwfTgYu
	 LWT82d6ZiOTuA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 48D30C53BD1; Fri, 15 Dec 2023 16:54:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Fri, 15 Dec 2023 16:54:15 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218223-217253-sQ6p4shjiU@https.bugzilla.kernel.org/>
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

--- Comment #4 from Michael Marley (michael@michaelmarley.com) ---
With the patch, the light sensor is working again.  Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

