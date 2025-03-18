Return-Path: <linux-iio+bounces-17021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432BA6733D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 12:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799427A1E96
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCF20B1E6;
	Tue, 18 Mar 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBQ572XR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B3207E12
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299035; cv=none; b=AFH6pWxMtQp/zhcc6dOWxc86Qa4wb263z3qS2AOWZFUowVw9bkMX8iUSJwVgAbgzcI+DsjtJwdOdERf6LvpcRQ4AC/WzRrisRCUjKVN8azFErXJn9J2aMpVi4gJdb2D6XEhTedG12FfdiB8shNPpVIi2vxloqexmRoim1j09RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299035; c=relaxed/simple;
	bh=lUZOnJbLENUgQyTEt9ERw3HmUY9RgoKkO7mh1UhdaaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhr5TOBwTIo+syauOE5gNwda503Qp7msIEJ2JlqwnrB5oK1oRu/4oS6RuLFi9MLKCnOBA9xq2/4DAx2SqJUbroBZOwmxuo9f8/zrYSWeonTSq3oaA/bXXePFEytFbupR175tlMbPx2L8DKWIBE+wI+CwrLvRNg7kDDOeBoAJeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBQ572XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97BEC4CEE3
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742299033;
	bh=lUZOnJbLENUgQyTEt9ERw3HmUY9RgoKkO7mh1UhdaaU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uBQ572XR3RXALH0ymaey5OxYgS2MUDJkDPreiF5Xwj5z/RuyaH0jrpEiYmcJzjGHy
	 aHiV9sv+0mvTGb6hlrc8z6Qba7Pso7oBueaY1oze5SgGaGJ0LwTNTm/7cENs0Jomqt
	 uIdMM1Okgw3mnhihLzfTJQljK4aOBl1jnccBlG0m2xsnzmLBlLtrG8NtU3rM3KqGa+
	 Ajj+Dr9+oPeraHt5Iau4shqN1iFzj/pbbuujMliHSD1CL+uvCjCHZN9FiBcN5DBZgg
	 VmtpJ0+WoafakgYqobI/psCNrszEyB4eJ6Jr6QL1pA3rUXz0Dku8IHTCjnN09FnboC
	 Wpkj4gKm9jtqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B3179C41612; Tue, 18 Mar 2025 11:57:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 11:57:13 +0000
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
Message-ID: <bug-219890-217253-10agZHiap3@https.bugzilla.kernel.org/>
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

--- Comment #9 from Fred (wysiwyg81@rbox.co) ---
Hi Srinivas,

I have the 1000 samples.
My office is well lit, but I moved around my desktop light and hands to make
some light variation (many times) :).
This speed up the sampling, I hope it is ok?
I made sure to have no complete dark and no masking of the sensor.

See in https://bugzilla.kernel.org/show_bug.cgi?id=3D219890#c8=20
I hope it's useful.

May I ask what are the numbers (column hearders) ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

