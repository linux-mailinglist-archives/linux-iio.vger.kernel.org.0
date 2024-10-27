Return-Path: <linux-iio+bounces-11408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1569B1FE5
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 20:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB51281532
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 19:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDE617B402;
	Sun, 27 Oct 2024 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9IuK0Xu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3761F957
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058209; cv=none; b=RYAc26U8lqGrqabeXwHasvlETPG1nCKbS3Az0E8D5wpj0fgAMWRvircX7B2sFh7f8NkAsun+8E4RIdJXnzJ49RTP/50y2KvFt7ZXeXxKNC8X8SSLFThUE/kxo3BzL1Q5MK5g3EMdWYRfi6TauZPKnBsHha9o8GHgd7Ti8spbVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058209; c=relaxed/simple;
	bh=GdvJxGVyXoRfka4O2q2M1zEId8CKyntJhUb7BVob4Q8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r4XHnhSq40mjxNhHOPug8GGcYDlIripLx9dvZs1Lit1w+3EvQqaCRmtpb1arZWj2c5Il7C9ERzD9+3lVY8fj7bPINiIne+JWWZqiwjrwqJNVHR8G1Ea7z53L3Hcn1kUY0FW1GHMk6XFhuINiXwux/PO6XS3LZwE5zvKvdXimZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9IuK0Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C015C4CEC3
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730058205;
	bh=GdvJxGVyXoRfka4O2q2M1zEId8CKyntJhUb7BVob4Q8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=S9IuK0XutCiD9OlRLs3fmrXLNLOPYD6mvWF+S7aI+IiJ96vb5F3jDTC64uNUjKoL7
	 GKFvO7BAx3C+Ih6lbXCBRrOVF0mGSAspF/ujSZZMbGqlxsts37DQaIhtk+7OnBKx/G
	 ECmOvnmTd8a5yRdaIdt7+d/YGy9YsMf/Qq35Vdsf/gbggZ6NYOUuL2f4TNUvV3phLo
	 R9hNXzsDKqSuGWC/XcsxRXWrevuUTAGqGIGHxOpFXOv+g3FlEyzsmOLrGdiwA7gP5r
	 htAHeEEMORdLK5iCjr+fv/gyjEt+lZrVpIdXdwMS0mFFtKXteul3aRVE3uY2vEhvif
	 YnA/AroHKjxyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 752FAC53BC2; Sun, 27 Oct 2024 19:43:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219418] BOSC0200 Accelerometer Invalid chip 12 initialization
 error
Date: Sun, 27 Oct 2024 19:43:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cameraphone77@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219418-217253-tGfKE3wATs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219418-217253@https.bugzilla.kernel.org/>
References: <bug-219418-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219418

--- Comment #6 from Camera Phone (cameraphone77@gmail.com) ---
(In reply to Jonathan Cameron from comment #5)
> On Sat, 26 Oct 2024 17:06:36 +0000
> bugzilla-daemon@kernel.org wrote:
>=20
> Without a datasheet this is hard, but you 'could' try just hacking in the
> ID in the driver and see what works?  Particularly if scales match up with
> the
> stuff on the flyer that is available for the BMA422.
>=20
> Jonathan

I did try hard-coding each of the 5 chip_ids from bmc150_accel_chip_info_tb=
l in
bmc150-accel-core.c, unfortunately none of them worked.  monitor-sensor wou=
ld
not register any changes when moving the display panel.

I did find this which does confirm it is a BMA422 chip based on the 0x12
chip_id:

https://git.15h.org/mrothfuss/chrome-ec/src/commit/003ec08f8c67845ae8481d3f=
b4124555213b04c4/driver/accel_bma422.h

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

