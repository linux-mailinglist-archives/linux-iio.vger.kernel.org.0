Return-Path: <linux-iio+bounces-9389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26289971C3A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D202845D9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CB1DA5F;
	Mon,  9 Sep 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjnr8j6+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B8811712
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891356; cv=none; b=LIbnvbQ5XT7NpNuvpkgJVnV/6X5JG8LT145F1gmEwj3vCBriaQy/YyQvoZVF2iu9awK50BybfBEIfw1SQmSE/ndcSVNTSyeprki2ZfVjOncCxz8m8bUDgWE4gm5WHTAIftj5EJ+8zxKjOwpyAUpnH7vsictsDAgZMoXtaBUAXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891356; c=relaxed/simple;
	bh=DUiIlipR+B/BVIn1HLqDHRPL86JiHrfZ0l2A1QZv2Es=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SV38cdUQGOm/fbm8nlS//2OBNEsxYYUAGjelL2GpVCEgrIsVVrJNN6tw94er8MWViHl147QeR/GN6B+7+8x+ffACdN+e5X+gwzGnHGpvVwtI0AgfD0+J+KryJjjlp0yzbNNXSuE/NE/yu8MN1YadAQVnjJZJfMOhJwHlbplFBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjnr8j6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9A10C4CECC
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891355;
	bh=DUiIlipR+B/BVIn1HLqDHRPL86JiHrfZ0l2A1QZv2Es=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zjnr8j6+fcsNLEAtr+fmJ/pWHDa1yh9G8DjK0yoolS2DwJ19YeWL3Jocmd7Uqgv0C
	 OPdkWe9V4hnxDVjkupXDQhLx9Ji1zrJkAOmNViRzr7VzMI1NI/dsRF63brya8AjAiI
	 CV2UODT9XP/Q38swwDAClK2+vlY/scQ5kh+PTXk1S4onnafIQonqPVIzjWIiheOV1z
	 mqT7PYvxeuOkFzS3aekqjqlWY60liKk+SPHUFQ/2XRtDbKiJwcNiWMw7KFsZ63iM23
	 XeC+3Wb2CafX/Z6p082M/dcWFUNISL5n42I8a/pSotwY0G3n+JaS39vcoN5s30aYGX
	 LZiw/RHKH6Row==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9523C53BC8; Mon,  9 Sep 2024 14:15:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 216678] iio: light: rpr0521: build error when
 IIO_TRIGGERED_BUFFER is disabled
Date: Mon, 09 Sep 2024 14:15:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to product
Message-ID: <bug-216678-217253-DpJQYsk3a7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216678-217253@https.bugzilla.kernel.org/>
References: <bug-216678-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D216678

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Other                       |IIO
           Assignee|other_other@kernel-bugs.osd |drivers_iio@kernel-bugs.ker
                   |l.org                       |nel.org
            Product|Other                       |Drivers

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

