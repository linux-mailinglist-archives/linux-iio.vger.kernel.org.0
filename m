Return-Path: <linux-iio+bounces-3537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3787C785
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 03:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80871C20EBE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Mar 2024 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034763B1;
	Fri, 15 Mar 2024 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUpXSZWc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E21D502
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469874; cv=none; b=aDbMHb/eeuqrgbAd5wXzMLJxI+NjTzeHhxSrbH3z571iXJXEWdaW2UDqZrz/KogSvKL6m9McrknhQfFUzcwhQ0g/i0O5Qu+0N7NXk8ImBcxOhCCvObkZQ+lXiYyKXbC4j7Dq2TCg/ziea3/UKNirIRvP+zugOiDYnGQ3u1yEbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469874; c=relaxed/simple;
	bh=YvN6aXYjsdPW1jUoeQOSBkSD+ulvrkMEwqy1Au1jYAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlY2FMGw1tFucitYngC8fNEsiK0lFXymmt0AA/pNnf9mSh2wYXH8Pcztf4x4A/e0Dcp+RFN5GRojaxwybXX1TjfxR3C/mnIEDDCKZ0u/etdZLCGpcx6UlBmb19bR2j87Py+Deq21vesgt2Sg52Bwgz0R2JOqLPxziHVUdfSejHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUpXSZWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C68AAC433C7
	for <linux-iio@vger.kernel.org>; Fri, 15 Mar 2024 02:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710469873;
	bh=YvN6aXYjsdPW1jUoeQOSBkSD+ulvrkMEwqy1Au1jYAk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dUpXSZWcQ0Nu9IaQPvhEtZ0f4TeU9g+ImQ56kbx2NFDbMJV0Ng1NyGJU+7edKGxIJ
	 DpcGa794jS0YWTyK/VQ1j6VYZzEEe91wVfM/XS8Vw2NEf+uY5TLZ0lAg67XHqBxq2q
	 1ILu604lISKyDEBsJ2vPTCaDEPZdLnnsIdP941Ede9bunrDT8lpRyXcnbsPsYTn1mA
	 /pBokB45FKNOgfgU+1p/d8vqqDzSBVFKxnl7uiKFkbbRjx3596HBJz+qrEuIYjoTzF
	 3iZLTpCeX531SfPjmXkfOtVALl8+73dEuzt7PGzC0xhEeXQJtTH6Gt6Ot3GbY7bvMp
	 LPbCuW+nD1D4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C0995C4332E; Fri, 15 Mar 2024 02:31:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Fri, 15 Mar 2024 02:31:13 +0000
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
Message-ID: <bug-218578-217253-XceT5yuy90@https.bugzilla.kernel.org/>
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

--- Comment #12 from Kirk Schnable (kernelbugzilla@kirkschnable.com) ---
Created attachment 305993
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305993&action=3Dedit
i2cdump bad, reboot, accelerometer not updating

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

