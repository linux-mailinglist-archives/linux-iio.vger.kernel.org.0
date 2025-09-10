Return-Path: <linux-iio+bounces-23949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317DBB51E88
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E693F5E3DF3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489462C21F6;
	Wed, 10 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYG6RUGd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8F2BE7D7
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523935; cv=none; b=eg9tLkvM7FYuDS7rsRHY+rVHNCLuP7cg+nVsvIV0Onm7Mxu9s1sI+mt3m7Co4ETorKfYJSbXafTMkHthdNpp8V9l3VHMPMcUnufkQGcFz4Zwpk68ouQ1zT3KF4HVYzYcRgD7djrC4D0H5OI0CO2yMPqNp3BhCYVSK+jm84Wq3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523935; c=relaxed/simple;
	bh=4ArKSc4vd4M2AZHBnVXVSj4xz7s2ACcluAk/Qn3hhUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUZ4Sl5RQocdZwpHC3enHidPE3Cv9CHiAzbQro676H7I3RnCyhw/X+XWltOo/Y6qyPh62xrjc4SZt2rlYfgkBUXL3yRLNt3BVJhfYtSrcbtRymNGL5nqODN3vJIYj+WI9Sipx6nNug+6mXwODatiB4Ye72WcEOzEct3dC52z0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYG6RUGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89EC6C4CEEB
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523934;
	bh=4ArKSc4vd4M2AZHBnVXVSj4xz7s2ACcluAk/Qn3hhUM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oYG6RUGdF0Z8eBCr51ZW2oRDQaGtOZDvtOMe6wAg7+U3yvd6qX1gnDSDt3IKHeh+h
	 yAnzS8E4DMpj0r5JuvWY874O1qe/zLM36Rk9ZNJ7xwCWovLuvxjaTONahpsMp+xX62
	 I/IVJ5QCYeRVJPo6vZnIX9A2a7ecqi2yawYRyClEfrFRwHOfKkPwOjm5X2+ZeIOAx5
	 70XYczzvYURJVPHKUaxmkSUaZu1Vy8sVBawXJEBb8itaDGAXgkKH4TyVGwSg36hAKZ
	 SDlif3aUYAWgCKxNusXoOkl7HJUBsHMkjQHiRfmo6+35lBdC+uOCnayiy6IS+k+WLU
	 FbTLTzlh8oNfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80E9AC3279F; Wed, 10 Sep 2025 17:05:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220561] IIO: hid-sensor-hub: Fails to enumerate Accelerometer
 on SunplusIT (5986:2177) composite device on Lenovo Yoga 7 Gen 10
Date: Wed, 10 Sep 2025 17:05:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shyamdhokia123@hotmail.co.uk
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-220561-217253-thCfgrS9ym@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220561-217253@https.bugzilla.kernel.org/>
References: <bug-220561-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220561

shyamdhokia123@hotmail.co.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.17.0-061700rc5-generic

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

