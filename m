Return-Path: <linux-iio+bounces-3499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A687B442
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 23:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182E71F227D2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF759B42;
	Wed, 13 Mar 2024 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM8D338D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF15535B7
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368017; cv=none; b=gPxyRqTn4HKifKsB7u6juOpmymUbwcnrCCgkjYE1bW45VQ9fpOt4LFrd8vtcH6iw7yupj3yvflNuYOuWLZE5E2FibEPEsSucGLlpJgymgi1g0HNHKPkgYB9YqDli21AQoWklgaKZEc3QffwV0dPY/bixsF2D5K1xHovQII1ynx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368017; c=relaxed/simple;
	bh=9H7cLOmYehsHhZ1IRdEM8A4UW/Bw6N7/E1W94/mZLsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MljqRUPkdv1xHfSWxABzIs+4SUjB8GRe/VTSptcoiNu5WH1m31LYL9ajTSIszlrt9rC/qSVGx418GGk/f15Yerjr8T1BXwOG0Rf5+CKZkp8v+Ds8/uH7PgnWQtzLFQRt6ljlvdat4Kbb98LFNnMiOGYq73tg3cF+kcxVRFR0nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM8D338D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CEB7C433F1
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710368016;
	bh=9H7cLOmYehsHhZ1IRdEM8A4UW/Bw6N7/E1W94/mZLsc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iM8D338DaDscGNV9K1OIJOZXq7IAKfH1vgGKyBLTdi4vpLKcviRpT8U6wFpBSBHhN
	 bfYU/n+jG9aSW690dL8pApq+d/nMBZ7OmWqwBHugzBAGWnMPaN3a0RhcwdHit6ZARM
	 8doV83DHTiCQRfVHliA2+WBHxwrOaqyOT8NFWafgz/kNz//W8Ktm6ZiDttnsSwkKVf
	 zr0S5qA+h4cPS7ClQq5cX0TkgLrSadLS4Bd9fLnNGaDiW9w+FqWDPemZhBKNwjc9vS
	 IUqT+aom3Sfwi3BCzOJ6lJbGWzQVcr3OZHupmDQZyvP0GqB/sdGYMA5wLfNVRdLwFX
	 o8635BimhGctw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 84558C53BCD; Wed, 13 Mar 2024 22:13:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 13 Mar 2024 22:13:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernelbugzilla@kirkschnable.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218578-217253-p2IxwaJoks@https.bugzilla.kernel.org/>
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

--- Comment #5 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305987
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305987&action=3Dedit
dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

