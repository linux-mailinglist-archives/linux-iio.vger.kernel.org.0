Return-Path: <linux-iio+bounces-17157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B8A6ACE2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092BB7B2AF9
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DD226173;
	Thu, 20 Mar 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ5aGzBz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD61EB184
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494138; cv=none; b=kguadmGgcS+GeBtMePoeue7LVZYJGwLetQ5iOX7kTALlYN+zybUcjP8YN94pnmy9lBKQKdQP7Jn6iXj+RoB4mO3HhPP97jArB+iV1tsFrd4xQIXetvO+1hGQGS/9ujFitwYhMrprZDFD1+RgRKTvmLMsKAsjN8Yyt2HAcXu8dUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494138; c=relaxed/simple;
	bh=gvWJzuhqE+CfWQYxq3gtCxXTcdXk08v2ZL+nX6W4y20=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mHwem+34c2StQlIFNY/QC0z73qY0Z+GczqmMJeXgea8JPHva7b2eASkwIqNdF5oHI+zJxvj+wxMSnNuMgxHp3e8DwKhYzuLSwBCYDGOJfPb/LuuJq5aFJL5iNuN0D+j5sDXQzZpYmEr9dBbsOhemtxCH4+v8Lyh+dSDTLy/Hhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ5aGzBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845DBC4CEDD
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 18:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742494137;
	bh=gvWJzuhqE+CfWQYxq3gtCxXTcdXk08v2ZL+nX6W4y20=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HJ5aGzBzZVsFloSrpomRxtkYWSUN3TatG8hLOHOt25gVEg1e17Kx7jDxdcDSXLAP5
	 f6tCvjuP/SYeD46nxUhAFFP6XvU0QKOhiVLV+/RXxTwHZM+L3W1nfWRTfhxZsb57W3
	 j4qgn8gNfNd8FFFApdNnRBKKeZdKuC4DjbBHjrbgTg88TQbmCq2cLwCpFdkzZSfiaF
	 eTDDfR5VXesfzqEbjMWGHBvGOrSM7QNlffO0BplRiFbPSg5x2TMAOZ+ol6o0UCSUce
	 kwrxYjRePwijfsMBp25kh0IHhdX1veXa0AqpuvMSdTCeC1NFogVGU6ilAuFUnP2e2F
	 A330T48XQYzkA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 71F66C3279F; Thu, 20 Mar 2025 18:08:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Thu, 20 Mar 2025 18:08:57 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-N2xoXrlaNv@https.bugzilla.kernel.org/>
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

--- Comment #27 from Fred (wysiwyg81@rbox.co) ---
Hello Srinivas,
I re-open the bug on iio-sensor-proxy and asked to have a look to last mess=
age
here.
to be honest, I don't know what to do right now.=20
I will try to search if I can find anything with iio-poll-als or
iio-buffer-als.

suggestions are welcome :)

here is the link on iio-sensor-proxy side:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/issues/407

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

