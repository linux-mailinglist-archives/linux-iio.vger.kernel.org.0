Return-Path: <linux-iio+bounces-17132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30CA69CA5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E701F42119F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA67221F3A;
	Wed, 19 Mar 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO4UzEP9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77A1CEADB
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426359; cv=none; b=MVnU6VMQz0pJtxnO3Z9BcANpPBeDUvsx0VLgvuo5vBRIr/pIG7fxpNO0quP2kbCeA4ZitiiKUXBcPGeUYwsNsS1sF58pAv6oAC0yiYShwfU5sbUw6KAPzTT6VKPnrXpiTF5lViIk5oDC+yTQ7VRrlKAxDywhuJZwLirxJ1F4/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426359; c=relaxed/simple;
	bh=W6Pdfup5w2vIPxCkadGDO51pLAtgbg0wKEYtEWLN//Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmSitSXWgBNjetUZNAcHsZ1qpjBDzf1cN4XIAHsvEWDtJDaJjcAnTvs099AFP8sP1OWVQ13h2qkUrzSPrBRzPSjKhFecEyzc6Itnm9d4mubM1AB2aYhmn9ckibCiig2aolfAfWxlIbRzhY4r+rt7cyx26vobIgVUgsojvJk/CT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO4UzEP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AD4CC4CEEA
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742426359;
	bh=W6Pdfup5w2vIPxCkadGDO51pLAtgbg0wKEYtEWLN//Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cO4UzEP9KHjo2MyTqkChhWkAb9Qo5uxzOVX8xdeCcy8akUI28Ejgha7DWJWsZjVPV
	 7QVUMgK4TZcZpDCJooxLWGnPmQdDtuaFKbXRxd8b3mLy4cC6CuWeMDRLXgNH41HX9/
	 XG2kDwXb3rC9xu6At7OMzmQdBIDxAP+4JyE3Jrp5yok5XVBGGFx8Cr+zI7W+rrJdaX
	 NS0Tu5o8HWqcypO83OLlJULI4e/VgD2IrbMcu97atrc1GZ/ZMMYf3spM4W4XukjRMW
	 r0t/asvQFL1lc2lqT621mj7qZ8iU45m8zrcmmlkzlJPwfgFtulEoYgc0/EN+V/Rfp/
	 GcZ5TM/Sggpdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F4122C41612; Wed, 19 Mar 2025 23:19:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 23:19:18 +0000
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
Message-ID: <bug-219890-217253-Ts5h2kif7y@https.bugzilla.kernel.org/>
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

--- Comment #24 from Fred (wysiwyg81@rbox.co) ---
If it were me, I would just filter the "3" if that even possible? Anyway ju=
st
general though, I cannot say at all that I know what I'm talking about :).=
=20


But what do you mean by a quirk in sensor proxy? Shall it be managed by
iio-sensor-proxy?

I ask because I opened a bug report there before here..

https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/407

And conclusion was that it should be solved in driver before iio-sensor-pro=
xy.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

