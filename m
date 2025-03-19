Return-Path: <linux-iio+bounces-17068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D96A681B0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 01:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E48D3B86EA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09F22F11;
	Wed, 19 Mar 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5aPanJA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EB18C31
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345467; cv=none; b=UqEAhli7fbII6wp11ddpmON40WN04rkgRopgF1Rg9yHRvjFQQ61j1EBGJU5BFDW6f3QTW+Opu33DxG+SIyLNtQFTMzMOj62Or/5sw8QZGexTltZEFLkQDfoG3fYDMj0GITtPZ3NZdfDokwpZc1PcRXpta3vpcMcW/kg9n0eX1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345467; c=relaxed/simple;
	bh=dfpXv08NPxZ5/+dR7Qt71PYebOi84rTAhIQoW4nGNuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/VboxBLGJrnXiWWAxBdD2VU4W4jz0cuZ+FXRq8k7UTa1X18UhJEYM4mWgkxxJlZELfyHHAoIZnt5qvzxUiaR7k+aRstzKRdbcdrUjoSASJ3Kn/8aR6XULPAS/kYOUZ2iXy3aL7X6DldqT+SjPrzc+qIYqEnBxW+zwRvFfoTvIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5aPanJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 698B9C4CEDD
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742345466;
	bh=dfpXv08NPxZ5/+dR7Qt71PYebOi84rTAhIQoW4nGNuA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t5aPanJAMQuPJEmWq519ckcAmaKn1IhLv2SXjWsm7PPbN2J1sg5xwCLZlGIBShBAE
	 ul4/W8wBsSVw5+xXE7JTyapf4D2H4lNv/ciDU+yudF1HLSIgnKtOHi9Wrq2dBIS7GZ
	 PFrPt+ItoqOE34Cg2bQGkRnx/U7V1qt2h4BQw0kMUwmtiDfjYd2S2NmOwyG0T19Hbj
	 gKuFil2psFxKqmGtXxIbIzi+U7QeDbPiLZ8L9BzmW58TfN31qPkMaOoCjVafu4fM0T
	 aqFbQTe9vNA1GL+ZoLmI0gP6eMvpqsEDeFmnmZR1Z+/06swuqxA105nyQXbZyvZxOJ
	 e/UCMMOAfrG0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 581D2C3279F; Wed, 19 Mar 2025 00:51:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 00:51:06 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219890-217253-BK0oejwfS8@https.bugzilla.kernel.org/>
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

--- Comment #15 from Srinivas Pandruvada (srinivas.pandruvada@linux.intel.c=
om) ---
Created attachment 307854
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307854&action=3Dedit
patch to dump raw data from sensor hub

A patch to dump raw data from notifications.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

