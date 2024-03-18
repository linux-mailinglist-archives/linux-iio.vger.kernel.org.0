Return-Path: <linux-iio+bounces-3584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0987E792
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7177F1C20DE1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AB2D610;
	Mon, 18 Mar 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO6u6ASh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E92206B
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758602; cv=none; b=qadjQJ3atp2s2CjtdkW24ywa5dkRruh4qUN3B2g2iq45M15w2Hk+NyD2MXdr9GONU1h/LQeimP3rmGgLJBrq7ThJuvsAvtNEFCgd+arjwohKYAVe8ru/pBUgjty9gifAs4Z2eVEzRdfAWBlRnY1X3m89CbcUigBujsO1lWONnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758602; c=relaxed/simple;
	bh=hGWMuTu/xHvhXQucwDW6anfkQo3Du+ViKgz9PBTe2CM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oaHtF5xonglvTdQz0A75po+R5oTK2ZgyBKPAE7vjATJxrfmH5tS5Eln3IrimiJKLPnPiBbEVS5tAzuy3hr4EnLt3O0RfBe2qfqFkWgCi0KmJ5XiPt6CqCj2obwBq8kRLC6WT/51EhA8NweQeyBneoIwpckXvzyax6dUev3SCKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO6u6ASh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5AD7C433F1
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710758601;
	bh=hGWMuTu/xHvhXQucwDW6anfkQo3Du+ViKgz9PBTe2CM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dO6u6ASh4VIZokOgTecsNQqCREhNpE80OSF9+K3exy3Wam/kEAJdWgP7dULQL/Dd4
	 VgNqW7TvqGhgaf9BZ14SVRK+2Hpte61nmvdOo83NmIPwJduGfxzV5bq7I4mnSI5lyh
	 c9YBd6qYV3JManiGOwB7ENliZzdOS671CTpFb4TjNu45XQpSKlF8rQ2gBjgvvq/TFn
	 87OGuZzFXzcwSGpxjJbPR6sM74xW6NmirKZv+Ys53kSfDvAL+Qqd7JDmmjs5PjUZrX
	 glWvuNI31+tpDlgU3JYiZYZmnU6CK9i5/4pxRRk964k8T7iuOhKDG7EIRs7iZJL0FF
	 veABbsND9lubQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D2A72C53BD0; Mon, 18 Mar 2024 10:43:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218578] MXC6655 accelerometer not working with MXC4005 driver
Date: Mon, 18 Mar 2024 10:43:21 +0000
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
Message-ID: <bug-218578-217253-5XgfUn25UH@https.bugzilla.kernel.org/>
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

--- Comment #17 from Hans de Goede (jwrdegoede@fedoraproject.org) ---
(In reply to Kirk Schnable from comment #16)
> Thanks for the continued support Hans!  I have actually never compiled my
> own kernel before, but there's a first time for everything.  I'm down to
> give it a go.

I see in your attached dmesg that you are actually running Fedora, in that =
case
I can actually provide pre-build kernel rpms with the patch for you.

I'll try to make some time to write a patch for this and provide rpms somet=
ime
this week.

> Also FWIW, my further testing has indicated that there are also problems
> when coming out of a sleep state.  Will your proposed fix also be likely =
to
> correct that behavior too?

That is good to know, that means that the driver also needs to reset the ch=
ip
on resume (and restore any non default settings). I'll add this to the patc=
h.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

