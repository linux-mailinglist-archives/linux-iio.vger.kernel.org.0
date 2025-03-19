Return-Path: <linux-iio+bounces-17092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC5A68D7E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 14:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE31A1888A4D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4982255222;
	Wed, 19 Mar 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ra+wlUlh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A92116ED
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389891; cv=none; b=Fje2gdKUTQpUZUAx0G2B8F38FnlVLA+ddWwTGQfZnGFomnNQ39SDJJ/C4oULJNouSQGIp+qzz6bDOpj1GSQ/D34q7bXVc1NfBekZV03d03la9cd/15W8YbUVXFYPqYLlQxb4yr3h3HhMP399qug4ncIJ9056+n3OWt8jh+cOqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389891; c=relaxed/simple;
	bh=wGhoyP0hX4yfGZLXw3weOt9dmP7a+FHvYNPQNJUqJDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WQrN1Yih3R2g8ZZ7ofY8F2JlLf1hsRLwN9/Q88IXUXBmAqaEXgOxw51yUaPs5y8J69pIok6eu5K8AbO0/8HGEPHgu21uDofKKlqNzpuuQe46GKSmgsRWNxgHrkWMLqfHIOmH02stpQX5SsiG4utxfRatbc7lUgpgNto1e1tXRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ra+wlUlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F1CDC4CEE9
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389891;
	bh=wGhoyP0hX4yfGZLXw3weOt9dmP7a+FHvYNPQNJUqJDw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ra+wlUlhLSViL8NIV+vIEmNQV5BIw9qJd0QEYHaOUDa7KrZ6par3sdBFHDrhjE7/E
	 bqI73dgBbtuzckenN7m6AUsyrHJdNsQZgxp/BYSEUYTCK8qWgqFk+iPLWS1Wq8yklD
	 2VuPYtCxLtyprL/qZRm9N1Ajwh3Gf9p8bhBrktmsGbUKMi9Q1OYKi7On/Ur1CQEpZc
	 NkuSbki2EHVRkM7JNtfleUYvmoWFX0hr4XyDlpQ7rW3kysxPv+IXkVW72Mi6L5o4z3
	 Ba4Tcwwhb0cDZm8jJvq95Jr21nyTY2EbSPM3GXn7aYzHYX89YFi8hgPxnC0KTsdLZs
	 G/6qMCg04aQ2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0E198C41612; Wed, 19 Mar 2025 13:11:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 13:11:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219890-217253-LvABLjggEt@https.bugzilla.kernel.org/>
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

--- Comment #18 from Fred (wysiwyg81@rbox.co) ---
Created attachment 307859
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307859&action=3Dedit
dmesg output with patched kernel

Hello,

Here are the dmesg logs after patching kernel and execute commands as
requested.

I just had to reword the echo commands this way:

echo 'file hid-sensor-hub.c +p'  | sudo tee
/sys/kernel/debug/dynamic_debug/control
echo 'file hid-sensor-trigger.c +p' | sudo tee
/sys/kernel/debug/dynamic_debug/control

Let me know if longer logs needed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

