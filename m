Return-Path: <linux-iio+bounces-17155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D60A6ABF0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 18:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641673ADE49
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFD2248BE;
	Thu, 20 Mar 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDtHi9uP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F222424F
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491635; cv=none; b=pwawQejGYJ69SezFF/DYaimqdHz4u54h7whV2so0KlTIl0xB/ev6KtOnXASrp/3XoTvnvFJPr2iiINQNQcFkC5MMFbRbOzBddx0jEn8h1Lt+pkK0YrclLWQjVvkFpslenBk/q6TPIvQe+7ZFxJU8MplHEdcXXTu38/OCXN2okr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491635; c=relaxed/simple;
	bh=8MsbUNqfaitQFiTpgjDFYqAPuDX2OaGC46eMwqfsIHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jp9JpgNNFuI/suh6QGWOHwNetkMOtRsvbfAtNNeKn6exRLwwPZUM5MZAfKuFTCJ2/8eOGuZhuBo/HBYTsY2YBukmp1yRTecThcJDiwlvsEiS1ryb3oCYyqt8l4tLQnomfyYRgfw5O1pfBafnrL9971fXx0VyVb9yKkfklum/LpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDtHi9uP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 352DBC4CEDD
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742491634;
	bh=8MsbUNqfaitQFiTpgjDFYqAPuDX2OaGC46eMwqfsIHs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JDtHi9uPeB0gT/yVaAXWigNCTAcwt9mWSvJwtiOP701Y8aOHmmpYKje3L+6t6AkU9
	 UXfP+DS8+X+wcMM/vAnQ3sGF6B79ClBLU6NTdpqX5V14qcFNHgTTGtLxr42qhvK617
	 do9g7cW4mGLpvXhLNcDYQGaXXXis3PfTliQQTkkt2izVEZvoJQzE7f9FsfU1/KiXGV
	 e6CEMVmRCFYLs2qNnGa7YPLv+RwuVY0xnRf4Vf06xdl8kRh56EIVmw4S5kIxt+FLbQ
	 8moA7wRNkVjFA3eFtqI2HIU3OzV/qNUi9jXqP+mw/DVczqKmnHc1rsmrQkubYucSzQ
	 DjgMFv4cucS2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18F09C3279F; Thu, 20 Mar 2025 17:27:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Thu, 20 Mar 2025 17:27:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: srinivas.pandruvada@linux.intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-qqBZW7BR7K@https.bugzilla.kernel.org/>
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

--- Comment #25 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
Data is sent by the sensor hub. We can't filter out 3 as this still more th=
an
0. The logical min/max is not properly added also to filter out

This data is sent by the sensor hub firmware. We can just add this to banned
list for HID sensor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

