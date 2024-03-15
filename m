Return-Path: <linux-iio+bounces-3538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C887C786
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 03:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FED28200D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 02:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3A63B1;
	Fri, 15 Mar 2024 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6FwjhZr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0A79D3
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469934; cv=none; b=BgNJkxcOVAnScngdm4i6HUXUZlBr/xFK8s4Dxnmy1IwDdu6nrV3rVIKqaBWe8VPWtiYgJqhw2QDuzirTjtrhUe3QjzTrOCmxFATJjVz6IsW+lUR+FIxnklLuI1ozgSC2Xrq5ANFp32xi+aoUTed85AA2H2ZJEdRIEsntNfa0+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469934; c=relaxed/simple;
	bh=uRPTMBaxH4+kL+kKXHCKBKhsN2DNvscfaxN/1/twAsg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uchg2tO/VHQW+9Mn2bqIY+/2xsB0eZ9wUZX5u+c29CSgsE5iD0K1hglOj+w4o7ke6wyp3cIcb51dWt3R3FkYFdYI5EyHHPgyZ22Et6170etHE0SjtcXorevhx/wrMp83FDKCZMPwSGzMZVONOgiggXRoHp/L3l75L14P7W3E5YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6FwjhZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58DE1C433F1
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469934;
	bh=uRPTMBaxH4+kL+kKXHCKBKhsN2DNvscfaxN/1/twAsg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R6FwjhZrZxPEvO4+zEoKspqHXkrbkYC2HGJplm0o1BAWAiSSPPp5m7LLMVDJ91k7o
	 tJssvqyDU1KxUQuJlphMfxoBirSgDYDY+AhWKFVE3hqy1CLnlszkXsL/Up93TfWuTg
	 viHw2/efRWCWZJIpXZNlPkHZMq1oskZ1wQbCuabYIxcUh9kb9d7AJel4jYsfOwZSrU
	 PLiOY6zKNtX0seQijb4z1esp9Arp70eHJvP+CBkAQkJSrgerFlr0k+Q0/gBvAE+cKl
	 wdpOpNstS6FUhhTYnxjFiOgAS37HAdwMNQ83iey4IYB8aU34FNMiQbHm4+0DrfRlSE
	 BkrLfZQ0QuTFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 536BDC53BD0; Fri, 15 Mar 2024 02:32:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 15 Mar 2024 02:32:14 +0000
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
Message-ID: <bug-218578-217253-b5biUSsoeC@https.bugzilla.kernel.org/>
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

--- Comment #13 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305994
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305994&action=3Dedit
i2cdump after reset, accelerometer started updating again

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

