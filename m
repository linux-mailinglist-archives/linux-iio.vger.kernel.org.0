Return-Path: <linux-iio+bounces-27563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94866D04E25
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0FAF3452714
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5C218EB1;
	Thu,  8 Jan 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR7Vovjt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FF2652B7
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891851; cv=none; b=n1FOYwyM7m9K1nTmZluJgyyYwJ6lOJM1bdRfaj0KUmT0ShO6inEgOd1IR3EVZPGqXPPHggeK6N+l42QbDuTQuug1Um2VPTvoNs+oWOZCZxxnCjrzknWZEnRuWIF3i1z9d1ViOINyulrjFFtM7tlwevtf62IDTIJORsMopK7VZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891851; c=relaxed/simple;
	bh=0unNk+axFDaifirYed/sBzlRqfJ5gvFne17nEFzW3MU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLEhxQ1VpkRqdxcQdYuUdPbxzzkTvnsXeMY8fayEpMa7pXsKmI8B2Qmhim2JASIRVSVjzSvANO00hsuVj0sC2hJpuMErl+rIAxgpgiM3LxcTq1OJy8nPEnxjUZ3+UeUYg5zaXar+oBCzw4lyHOABxDj2KizwslXyccEMcvf3LrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR7Vovjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7F8C116D0
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891851;
	bh=0unNk+axFDaifirYed/sBzlRqfJ5gvFne17nEFzW3MU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QR7VovjtkJvD/oXexjLF41GGS6utEYSKg4xoRMOkGq0lUBfBOtlFqz3Gc0aqYKOw3
	 THTJyjHTEApeQ7Fl8gBbVA6vOzUIN6gQEgd6tohF6SxYi3uMi7jYsMjzp4AOheP6cv
	 +v79M804R9igQepVvYkIhDejVKD4mrj8lMinO06iC2c5AvevRZAs/Z7Gqe6uzmyBPy
	 rwp4iygsCXbFOs1ezEOQYKYO+zjHSaAUtwXSN1D7PO/6XiLkU1E6asjLML1BvARwNM
	 Y04JDS4DaPfOGgKYzTF0VAThHLsHO9wvoVBnAoV2Rk7XBKMu05lHWjw9jNhmFYT8Pl
	 bwuu1W31PaYOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44014C4160E; Thu,  8 Jan 2026 17:04:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220561] IIO: hid-sensor-hub: Fails to enumerate Accelerometer
 on SunplusIT (5986:2177) composite device on Lenovo Yoga 7 Gen 10
Date: Thu, 08 Jan 2026 17:04:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 3879amateur@airsworld.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220561-217253-QAi8ZHFX7o@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220561-217253@https.bugzilla.kernel.org/>
References: <bug-220561-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220561

3879amateur@airsworld.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |3879amateur@airsworld.net

--- Comment #1 from 3879amateur@airsworld.net ---
We are also encountering this issue on Fedora 43 as of kernel
6.18.3-200.fc43.x86_64.

It's not clear from the maintainers list whether they check this bugzilla:
https://docs.kernel.org/process/maintainers.html#hid-sensor-hub-drivers

Perhaps mailing them directly and/or posting this on the linux-input or
linux-iio mailing list would help this along.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

