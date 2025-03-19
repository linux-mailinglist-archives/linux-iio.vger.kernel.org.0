Return-Path: <linux-iio+bounces-17093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A2A68D94
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F62189328B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C70255236;
	Wed, 19 Mar 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWiJxJuI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1217BA6
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390242; cv=none; b=PyeZ3kW1K2yZaDiu/v1m8cbC3YIJMaWqNotT1JYwnXjVXWzw4EdLHYfTZqPJsmMBFVXTc2HZdVjGocfbTUJtrqxIC4VSDM3PgfOuSQF5SVb3bW6BVuPINIDbHnBbNaR/HwELU3AipHOAeVKIvfpWD5iwpJFfY90zq0S7ctzjaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390242; c=relaxed/simple;
	bh=U5/nmA2vb3U1bBdlN+JCHFxQlvdqD+aToyfSkSHuSE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDhWKfKSy1ZtP5+KBmEZc4EmzlgbC4ry/3QHM4yOjGLqiYtDVqDJzofFt9RzBAdHHzXkw3Liy3DFRgixee/KRxybLD2x0tiUTKXwgyOaibz3q3EuLmbD/fK9DKXFQpvVwknvPj7bMb7fUBwpvM+jW/Z+M/Se25aCFgGemkbmIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWiJxJuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F303FC4CEEC
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742390242;
	bh=U5/nmA2vb3U1bBdlN+JCHFxQlvdqD+aToyfSkSHuSE0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uWiJxJuIm8Pkx/AvfKeYt2a8Di8WnXw59LbMxgHafqnS/DHVnJVDsMnbqE0dSz1wT
	 vDPUsE+VJdADmJSPhNV4rrGsEF52CzHRFLg+4NrlHtkdsy8F+Un71WE6lwRN8lb2oS
	 /DLLEvr3nmP5vQZ/PHupoG5GRgfs896Q64eKEUGflNgfy2ap6gdtS+OaXSJGZteOsd
	 OfhQonD6YzxF+pqzCaueHliWZOwvlR9KLnadiSrI0GYUk2jKurbr3+wSdY3Y3Ld46t
	 1vLUJKSI9l+L0OJFvfqokn1yMUc74v3p9CLlWmRgzBDcf8GxcEMNTzqF+OzOSjqlIn
	 a98laF86m30UA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DC238C41612; Wed, 19 Mar 2025 13:17:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 13:17:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-wt9tgHCF4Z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #19 from Fred (wysiwyg81@rbox.co) ---
Wrong the data I see in dmesg and watch commands, my understanding is that:

Raw data: 00000000: 08 cf 00 00   =3D> mean cf08 as illuminance measurement=
 =3D
53000 in decimal (53000 is what I can see on watch command).

if I correctly understood the format, then I can see a few lines with "3"
measurement again:

Raw data: 00000000: 03 00 00 00

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

