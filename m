Return-Path: <linux-iio+bounces-3633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A87880D33
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5672852EF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8C364C4;
	Wed, 20 Mar 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClPW8GSB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB8282F7
	for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923921; cv=none; b=lDy1Mm0HupgdHxUt7a87r8N9zXUaWFeoqb4Rha5SA/abyO78RDFa35DLR5zeZugQvqjIb+bDfS6YBxi2Unv0OddsMC+53OX58ubn3aWhNy7BEOQ31czAJfUwVbhJBHZnbSFb/G7waZZEo2+m+UiZNKk/b0KjxcOodIbDn8J8t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923921; c=relaxed/simple;
	bh=kJlPBNm1Wxh4Mh/73ZqXgrCfu9H2T7/HSoIAQEF7hYc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCfO5JASXPCGFDMlvLoOL3XDqrfk+/MYkqxJ/BgE2SMivRrc03E1mdvMb2nxSzGzxzSijFBLJ6VlkNQDrk+jAl1l3ckhyZ2qaIhuojHbKDFIy8qEErCXVUeJF0Aq9/0sr7KY/2PA7CRyHwy3CssvktVMYujC7iJ6QRoLZjoJ2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClPW8GSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EE66C433C7
	for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 08:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710923920;
	bh=kJlPBNm1Wxh4Mh/73ZqXgrCfu9H2T7/HSoIAQEF7hYc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ClPW8GSB62RfBYq5TALfjxN0iTowp6YwjdUeIuRiJadxLSRpu0CbHzfwjzewrAVef
	 3JQDeDd8IOwj5GN68umBS6huS8qvoL5rVvMah0vNmqNUqNhVBkj9sJwNwb8Rp1S8d3
	 H6dLsCCmv5QVLLZowjbmoobLEVyVZDBHo22UNULf3N0DPQhpmpZbvBfBWblrM/SEKG
	 RsdxR5mXgCvYFWOlyLGDn8Sh0FwvBIgs8Q2X61tEWLefGpVuh2BU3m3F0KJ2zUoCFX
	 o3/IjovR58Dw7iNvUprKfbB7ClkNgtFTHPTP7abkWyW9+w+KYg1kzodArgbgeMxIgs
	 ZdhBZGK6U80DA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 880CCC53BCD; Wed, 20 Mar 2024 08:38:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Wed, 20 Mar 2024 08:38:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jwrdegoede@fedoraproject.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218578-217253-eahenOxern@https.bugzilla.kernel.org/>
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

--- Comment #18 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
> I'll try to make some time to write a patch for this and provide rpms
> sometime this week.

Quick update: I don't expect to get around to this this week. I should be a=
ble
to write the patch + prep a test kernel next week.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

