Return-Path: <linux-iio+bounces-17114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626DA69A61
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854BD1897332
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99620C486;
	Wed, 19 Mar 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZBXlFia"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AF10E0
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417956; cv=none; b=DvbG2hJkRlDc3jWLnuasuEpV/RBCwjUreWk+MEaq8uKbqN+H3Y4QdKRGQgDf45kshTxh+hLVHnTbRfgFYsQzNyd3uTO7j3KjG9n5JqcwdM0Jf9SiUt3+3E+aA/mkAcvPhdNZPmAfK1t51u+59gx/P9DVTdImUXFQiouBVRCMLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417956; c=relaxed/simple;
	bh=RIew+8YEfZMvw1R1DGO3WicUdkA4GYnZNIp0yb9Od5M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8PHN/8qCiWio+AVyeZiCYIc3c/SHOcDD9VJTGongVpdK9MYC1UYKBK6Ls8feybiempWWvccXwY/EgsjyHTY3iSJCbFgV+PJ2p/dbxZUBVsIprLcgsOgh8FvMhEm6n2LFy4+g1ln7+gfNNivKXoEaXsluhFRgdKI1c77OKxSyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZBXlFia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E89BC4CEE7
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 20:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417955;
	bh=RIew+8YEfZMvw1R1DGO3WicUdkA4GYnZNIp0yb9Od5M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IZBXlFiaAlsVzBxXFJIU7DxqAhuEn6b1rDILhUYXxlBN8CSIOhve5FxHY7h4damp7
	 9V4QiXpvt2qNzldDIK7+5e1Yu6uQM4blNcQSI+mPj8OGAShrYW1n4P/5JBOq2TZ5FQ
	 bP4qeoIBRPQk0CDaoa2emzymW6wdX8tShpIZ7zXeDXt92yshkqkZi+xh8fpVkHlUQl
	 /TyFHeL9ldf73PAdQcdFXCGPUZ0TyznwdOo5lpy9pl8PeZKerFZUdXG3e/9tSJr4+k
	 LHc4Mzz30epATH+QI7Q4wxRCcOGvNFJ/ihBbUL89pm8sobM3r3YfHE23ckDFX6QoPv
	 qSmHTkMU2FYTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82513C433E1; Wed, 19 Mar 2025 20:59:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 20:59:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-SWFtiHGGAb@https.bugzilla.kernel.org/>
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

--- Comment #23 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
So the logical min and max are not useful here to clamp the result.
I think this needs a quirk in sensor proxy to filter by reading two consecu=
tive
result and discard the bad value.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

