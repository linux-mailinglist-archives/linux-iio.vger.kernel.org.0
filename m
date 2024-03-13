Return-Path: <linux-iio+bounces-3500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E187B445
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5FD1F22970
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994F59B42;
	Wed, 13 Mar 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBga1ATl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2359B4A
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368047; cv=none; b=B/1EB5kX7SyNZNZZ9BY4FwfEgy3vbvW3IJT+Q1DDtq1oCVQKJOgHstTNK3M6RHJNSFzCiiqRsJp7HIGavatKTFix4mdDXV1Eq8P6wH8yGqjNZyrY0r/u0glniRk3hC4Dpn5iBD/fh1o4LDIKIdfOqGTUcAbVaJyguTeDaOPUy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368047; c=relaxed/simple;
	bh=bgS49rGYlBCaFzAPXZKCQ+YarFiG0lEtzLYrVk/9/DY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJ8JyMvCAG3/3SGko+/M/t9QzGoHVYdCaeAOT47/gLPa1XIDYLYv7EfFUqL9+lSuD4XhtzmDEg33kNiC5GoMqUFb5LOqSsJY+rbUqeMmMdR8fbk0SMR45EfyslbWuqnmGMiSnhYgSxUlQgwQdeqUfCM8wGAc+HEMuu8n4E0c6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBga1ATl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45757C433F1
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 22:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710368047;
	bh=bgS49rGYlBCaFzAPXZKCQ+YarFiG0lEtzLYrVk/9/DY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jBga1ATlKFUp4wdRF1kp/YTmvQz1KOsR5bJEWI4mq5s69pg/ZTzBJuX1UNAqi7mXb
	 phjNBZuzOF2HTK/NZzip26Nl1tidBCiIyw0wpu4ntR+Xc2WM9lvp34HTkym0Wc7BrN
	 rC2koY1oUOLR8XM3wjODO1brP3Zn7zGWrMg503g8u9MHIw48Y+1cnCGCAcvEEdCoBn
	 k7pH6elgB2+pvWLm3jQ4vKnPeuONUqncbXlBJ1lVctASsVban/XTqhalXibZKLmEVP
	 hmScdYqt4Glfix6Tno72xmFx8FSilP7Kef+ZO3YvdpuCWN5jV+Q69bELeP/FkdMeyX
	 wCfVJlQbMdh2A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 205C8C4332E; Wed, 13 Mar 2024 22:14:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 13 Mar 2024 22:14:05 +0000
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
Message-ID: <bug-218578-217253-Ti42NrJCML@https.bugzilla.kernel.org/>
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

--- Comment #6 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305988
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305988&action=3Dedit
acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

