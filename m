Return-Path: <linux-iio+bounces-3415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F151E877338
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 19:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E171C2159E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240E47F72;
	Sat,  9 Mar 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnds2ibO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B024A12
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008274; cv=none; b=miDaOF19gzsUYRFUcCR8PNhyaZxUYUsIITJ0DNsESenxQgU2aSdqkc023t8JfiJe/mMB5poSTFFbNSBthaOWCwauEFhDMYo05KxCUCI4Ywh61hb7WlF8T8+H5R1nxabeRbo8Lx+EMr4bj52QX802jrzcOEnjWHxxDe4cs4h4vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008274; c=relaxed/simple;
	bh=FWjbwxeRzk7Ugw1FkTp2S50dvJJcbaSbEcpbc12T2zw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lWzQRJnOrPfngbNQlcIBSFN/MTNMMNOI2jEpIEdINVKsFAJl8iN26E1kWff1+xoG+rpRLyOPdKFnieLfCct5CaGPrq08RbwNRnV1gS2sezp7FcpkIwy0PWMN93ykJ9rd2Y7pYZ4WX1YJYjWQ9iOnoQB5LEjw/w8WP0jqGNqJkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnds2ibO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6ABAC433F1
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008273;
	bh=FWjbwxeRzk7Ugw1FkTp2S50dvJJcbaSbEcpbc12T2zw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pnds2ibOyFMj57Be+VWa+aRbRTCdATrlDnM777rGbjbrO1rPlf9dsADXQtD/FBFyZ
	 AW0yPjZj1g9qeZRPv9IN9hsPueAtMPVIEct2K+FowKbX+lyGLqJoL0FumsDqXnNhqZ
	 NmZT+s8uF11UMHSYSKoAFZisUZRRpfEASp1l0Iuws/jCuT/LX9VGJNjS6bWfdkT6ZZ
	 o31Hyekbh0Rmkoh7VstB0BsBPtyCTm2YiSb/ciRn0wLM/beZcatgPeLFcSHFpFPmcb
	 aYkRkLQ9p5t8fA9sboV9XgwlFRcgK+o0NePvo0smnaRSQ5glrBLcWw6dFDCb5oqNgc
	 QP0FdmkcEXCsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BA243C4332E; Sat,  9 Mar 2024 18:17:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Sat, 09 Mar 2024 18:17:53 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218578-217253-Z9ZSAeC5WM@https.bugzilla.kernel.org/>
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

Kirk Schnable (kernelbugzilla@kirkschnable.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|6.5.6                       |5.15.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

