Return-Path: <linux-iio+bounces-3823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F271188D108
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930691F344C5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Mar 2024 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36E13DDB9;
	Tue, 26 Mar 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMvy+Ksi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8F813DDAA
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492442; cv=none; b=mHMUafaj7tleZtEVk/MT1+LVOsmba3aU2kheKDDWzdOSA+wmU3aC95JEur0A2DVRMeV0eqV7BYiGVlwQZyLm8IvUYOf4qGNRb+x/nVPcWssRz+tuRLuIiTy3GTXwZKiy+TnTlHzDp9msD/w+yQohBXQJATyvmiW2gp3Aj3rAFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492442; c=relaxed/simple;
	bh=qii5FAFXxN23JwbZadnOtkIG2TRz42XwkHv81Veh83k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVzsCTPNnkDr552jgtYxjwWuq0owlpDVf/6+f9rL2vnzYQnd77m7cZU+KHmKOCW0BMLq1UogF5ClQ1n6oBYHpOw+gpxrgYDJhJZXJznd7xFcZTfuwG8BJIM3eZup9obHfTv2UtVP8ALt+wCcG6396xldRYyNO3QTrz+tbDbkewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMvy+Ksi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2B53C433F1
	for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2024 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492441;
	bh=qii5FAFXxN23JwbZadnOtkIG2TRz42XwkHv81Veh83k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WMvy+KsiXub+oPht1nmXtu7RzWnxim00FACNlAT6aSDgTT1BGxCJH2WwJRfBmdVdJ
	 aXCeku1uLvJysPXvOfa86xtb3/AXVcImJB3N+qEy2u7jGxcLNgRv4mDddQjwVJrazD
	 O6xKDaydeyaFKfsdSM9SdzBqjLDC6O8QLW3bk2bRdcgOoAGJW9BnAU8Hh2U0HDAO5n
	 tSBv0XF5Puvpgr3ily+aqHgmzkEMPVGYZbT6QFEnqyJtE7lVthHkB2zEV+IkvoW506
	 gz2RSGBl+X5IF0YcRoDKpdXScLwGIVCmxE4XqXHDaKWKfyYhG+VIUbi1RCY/+OM/m6
	 pbAWb6p776Qsg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B4EB7C53BD7; Tue, 26 Mar 2024 22:34:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Tue, 26 Mar 2024 22:34:01 +0000
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
Message-ID: <bug-218578-217253-tcx6CL6UbY@https.bugzilla.kernel.org/>
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

--- Comment #21 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 306045
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306045&action=3Dedit
/etc/udev/hwdb.d/ubook.hwdb file I created to fix the accelerometer
orientation.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

