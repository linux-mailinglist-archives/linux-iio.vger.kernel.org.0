Return-Path: <linux-iio+bounces-10720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDB9A3CC4
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C671C25AED
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B698202F6C;
	Fri, 18 Oct 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIyIax0P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B119202653
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249362; cv=none; b=n3wPGbhagj4sScAPEH7X7Q2ya1uJ571K8dUshiucZgrSplvRWUiv0l/ZfZZzqhcZbba2PrTX+ZmbndhaeptFMj2kzKSW+7bOpjvb6wTR2ChCthAQPYDAuuYtZ7dMts0GPadb49nAlsiY36C2MrWh5uf9/og7mcejyLxF3FWWZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249362; c=relaxed/simple;
	bh=Rz77x/j/fpVEc+5wXkOncOgSfVnRlFT4OmaNtNSSL1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDIIXapzZy0IzYfcjhk0McQWwAvd5odPE+fVk+LNQLR3kdqIy2ZBuBYo/HHQ6rc5wZC2Ckzgw+MfsH7A8rv4W0B01LFm2uMRMDfl+T5VD8rXXtXBitW98A28WDhTtO4NwZc3wT0rDDCQvgf3pDFLbfUQwfUXfRfTPlh7ZjOnRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIyIax0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B40FC4CEC6
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 11:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729249361;
	bh=Rz77x/j/fpVEc+5wXkOncOgSfVnRlFT4OmaNtNSSL1g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UIyIax0PTtTt2NcVylpX5Ty0K/rJ+H1PTXb2ZdvJsDELs0Rg3LXHTIsUtqkfS7XPh
	 Zs8mxafD9dvvdf6V/YGnDGFxH0mKzwf9wI52hLa56qVT5c1Yfyq0nVLq0QnkXSs4hX
	 ObDLhaI3JKE+B/OtGw8gG9Yvl6z2lwQdJ3aJSWKEcdMg/cVCn5MV7Ysts0T1Tf/OPK
	 LLGKFUUWJ6UsYVx51oAcmnXo23Y5xGbeBOLNSxPcAF3zS3qN5oY8MglguWLNvyFUkF
	 iOLsBs6NAmGd+pwjN8RKJ4C7w7L0GISjNzEkw0Nr78t6+PfPnKTWTPbu0Iw6mGDSys
	 eLIwG9cEar5Ww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8E950C53BC4; Fri, 18 Oct 2024 11:02:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Fri, 18 Oct 2024 11:02:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-rwqWCxPO3c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

--- Comment #9 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
This
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Dfor=
-6.13/core&id=3Db2b8a75e1d88c551a0b30d44d0be552210219eea
one is related and may be used as an example how to fix that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

