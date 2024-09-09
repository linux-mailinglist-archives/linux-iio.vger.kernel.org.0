Return-Path: <linux-iio+bounces-9394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E86971CA5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E0CB20ECC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619F1BB6AC;
	Mon,  9 Sep 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEswiE3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D311BB6A6
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892263; cv=none; b=H8us9sYH/r02ZM0Oiys1qPMZElKHyofBGqfvR4gk7BpzncbllcOgVTQnhwg/BSjtsRwe55Vc9GfexcAFCrXBt+qnUrfcSx8S6RLNzylIoVwXdgPtVy7nkC74E0Wqxn9TabxJBfY6YFMMpCyCJJUhq7r5UsOXJvH9Evnud6wPRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892263; c=relaxed/simple;
	bh=phtYO/pIEE2ylmLhKqlw2YO113sW1yQOIbR2pu1oNjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcaWi/HnSffJ4IR7zDY9OZQ4urytUIXfPhUrYqIfulrBg26b9pIxp4dJoF2nkrIV5vOovhAyRbwpmKrp3lVPrn7oNiNU6VmFRqXKD3OLBitmTNQRBXeW+fddNbL1ip7cej1g1SjxB7g0RBCkx5LnXW8mdYbTgHG0qr/PdtWHuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEswiE3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F9DC4CECD
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725892262;
	bh=phtYO/pIEE2ylmLhKqlw2YO113sW1yQOIbR2pu1oNjM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HEswiE3hkaVsSxDaWQW0TNmT46A3Dkt/Y/cW2DLzfvKWJzTVSJrvBpo/RBOUkGuV8
	 BIgPmrxrjUNxqz/brmoxxZYaMzfcf2Q5/1nNE/7F7NpGWFt3YqcXFy4/ExjYkPZ2t0
	 uAOuo85JAti1VXAXcoD0WikxSDPQ3JEhCJ+op/OryfmVYQw29PclCVHSVoT8Ar6Mf4
	 2wgZr84MvT1USaoxgeHAj1b6Pzr41UZwRrJ/k6pnTLoMmXAUOW/rK6u9OtVI+7CY27
	 abRHvmwxuaKbpw5rL6e4acXYCckVo8gJ/yoOjV1HPWPQlPmN0bzzZAjG4aZE7FXfxo
	 2OmFPZ8UR8nxg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9437EC53BC4; Mon,  9 Sep 2024 14:31:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Mon, 09 Sep 2024 14:31:02 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219192-217253-ClcvKjR0zY@https.bugzilla.kernel.org/>
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

Andy Shevchenko (andy.shevchenko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andy.shevchenko@gmail.com

--- Comment #2 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
Might be related (read discussion in full):
https://lore.kernel.org/platform-driver-x86/Ztlto06GyFxLXz1y@smile.fi.intel=
.com/.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

