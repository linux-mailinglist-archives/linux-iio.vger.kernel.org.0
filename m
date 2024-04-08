Return-Path: <linux-iio+bounces-4154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFB89C71B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587B21F22CE8
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D4813B5A0;
	Mon,  8 Apr 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz0sIFq7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BC13C82D
	for <linux-iio@vger.kernel.org>; Mon,  8 Apr 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586674; cv=none; b=piqLlGUOnxwED2I5Av4TrC0HM8bSu+BTyTjbk4WS8VWq2OLj71KE+Xn3f3++Ok3f9U3yjNtZbE0pNkF4rH9KJ4nHG/EgWcqFSWmN9BMXhfNVzMc73+ZRHoMdBcK3mv2ovdpaGwt8c0D9nr6R2aYG6Pc6j824LPX/59Csft3IUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586674; c=relaxed/simple;
	bh=Rw+EECN5k8LMgfNVXIWEUVnTERbqqd3omGKcYRnWtlo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iP+rRxOPG5ACNxnt1ANZR1NFU4mtNPds+C91lRMZYXlJgTYG5ZI9EKkjk78Fm1dz7MdqG8tkfPaQ+DJY8GAtXD6cgPBH55uj1DWeiLJF5D1MziXhmFHvCsxwvJJ8MpGgvB2vjS7jkHiaZe0N0iSdFJTfE4UwWzOLUEjLjdtVA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz0sIFq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3CBBC433F1
	for <linux-iio@vger.kernel.org>; Mon,  8 Apr 2024 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712586673;
	bh=Rw+EECN5k8LMgfNVXIWEUVnTERbqqd3omGKcYRnWtlo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wz0sIFq7gZV0i8zeTt08F0GlWvQoEy/RtxvR88moHuYjW4MA1CNeYEOrGPZdLQqTR
	 RmsD4TXXkPBDxyFCQ2lo83FjIIje/8jjPe1BKHaVNrqtBvzenynPv6iSXDKbwDdw5n
	 rhcAWUyoLKqhcW0/gut+gdQZCqPx+bsOJDdU9GtHF4D6EmlQ8OpBMWTcHS0jSCeT2y
	 X2tye6KLvQmu8djfEm834wEjIvLtX8c6lcsgKRtH+GckLTyV+07iC0r4wvzVop8HKK
	 y/aEUwk7KOxjmvd0bquMdEo9QXpqrEAib+K7bLz40XwpcEJv9TvJgJdzp3unQu5LjR
	 Zdwg87sJI1d3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9944DC53BD9; Mon,  8 Apr 2024 14:31:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Mon, 08 Apr 2024 14:31:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-ecLBaHfY4E@https.bugzilla.kernel.org/>
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

--- Comment #25 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
Kirk, I just noticed in the DSDT of another tablet with a MXC6655 accel that
there is a ROTM method in the ACC0 device with BOSC0200 ACPI nodes this
describes the orientation matrix.

So maybe we can just get the matrix from the ACPI tables and don't need a h=
wdb
entry at all. Can you do:

sudo dnf install acpica-tools
sudo acpidump -o acpidump.txt=20

And then attach acpidump.txt here ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

