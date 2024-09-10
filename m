Return-Path: <linux-iio+bounces-9424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061EE9728F6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A3F1C222E5
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7F175D4A;
	Tue, 10 Sep 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXfRJ7S6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A74F218
	for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2024 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946977; cv=none; b=Kh/TAq3EEkXNFpwKlaKASaWB3QGuzCpp2BNn+FA9CqbZ+C6WA3bQYkMhlqx/90Ha+OkYdAzmwZ6WgZmxTxJeNGKXKMqWyeOfmW+YovmhaRlQ+LYT0g8OHffxO3MCzK4bDmPplJGIMeHDub720q2J2qQAMjiDO90VTBDgUc3pQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946977; c=relaxed/simple;
	bh=vi1FS+RSwgBJeloRV5fchCUVcy7qY/FMdhpmXM1/aHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C4MMSrW0gL/7k+gVzkOKUsdu0cAmz/DaTbcVLf9DK15bcfRVETLQnfjZDMQITwekw8f02cZ2pWhK6BMhF+fQNfICsGsWbFtc6Ssq3/q8qzjSzvT2Z+x4LQPxWijE8+9w3BoxO0ceCqKGdax0k6aQrVfk4oG89n2/fFegRLqtISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXfRJ7S6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 058BAC4CEC3
	for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2024 05:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725946977;
	bh=vi1FS+RSwgBJeloRV5fchCUVcy7qY/FMdhpmXM1/aHI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cXfRJ7S6chE44P5wazhv3VdHxho7OR/hoQPRKDj9NfhjIL0caFaSt7HoY4aXb/HZl
	 Iqn/xdH/mJTpuc58n6Ov4XrU/rtxTTS1se3kGb8XrwXj7E6AgVVvalFE9n0u3GZrpm
	 ilj5Zx3GO5SpatFcgMgCd17FvUDBEnlvKiirnXFTHiCd6cNbfgJxUxoRIiUN0Esk+p
	 0YrdW+ja7nc1opJK7fBIWUR5RkRVA9BEcjY7IqhBr2zy4lUpHTpvGw3GwY1ltP6nY/
	 aoSCArwo2d1TN6fti/1/gZ31MX8Dx4UO5w06r9ph4FJ3LXFtbJhSSMObHj+hhJVeaB
	 I/u48FPjssFAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EDA7EC53BC3; Tue, 10 Sep 2024 05:42:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Date: Tue, 10 Sep 2024 05:42:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andy.shevchenko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219192-217253-CplyWJOX49@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219192-217253@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219192

--- Comment #4 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
...with the difference that here it's GCC...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

