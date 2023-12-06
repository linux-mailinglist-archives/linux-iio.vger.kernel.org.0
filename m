Return-Path: <linux-iio+bounces-657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABE806F61
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 13:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32DF281CAF
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A8358B7;
	Wed,  6 Dec 2023 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3uL9brN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE62D043
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 12:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3392FC433CA
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701864137;
	bh=IdiLllMqRzSZjTa/4ywBwa0u4XlLNZKRzVSx594uodE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p3uL9brNFi5woFLa/HjjZVIYrowbw+z8gSSPqysAmwbEKEGku3UIWFVWL/YiZtX1e
	 cUM+GuMydPsVzB9jGSv9cYAgJgbgcVBKcyAQXgzqwgvWsTScbcOkKJVGKovTfMDBFS
	 KCSM4zLnkvLEvKHZA7wkivNNWhx4zooJpR1vj2D4986WjhBlLjdty3xvHrLlXt2qb3
	 nc0uCEaAtGhcav7WFPp/QB5gtPNQL8ogqBxmO0fi4IuzUMaO20pv5oKSQPz4Klwd6q
	 THNxj8dQpBP9zuLWAY4ors3nqdv3B4L0XL/K9RWxfrNnwq5qynaCMghzzg/kyYZcyB
	 JdCwRKE33Eocg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 18C6BC4332E; Wed,  6 Dec 2023 12:02:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 218223] Ambient light sensor on Framework 13 AMD laptop stops
 working in Linux 6.7
Date: Wed, 06 Dec 2023 12:02:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218223-217253-G5281gV7wc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218223-217253@https.bugzilla.kernel.org/>
References: <bug-218223-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218223

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #1 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to Michael Marley from comment #0)
> The ambient light sensor on the Framework 13 worked properly with Linux 6=
.6.
> With 6.7 (currently tested with -rc4), the driver fails to load with:
>=20
> hid_sensor_als HID-SENSOR-200041.1.auto: failed to setup attributes
> hid_sensor_als: probe of HID-SENSOR-200041.1.auto failed with error -1
>=20
> If I revert 286d528bf0fae9f334fba857825b9701df1675b2,
> 5f05285df691b1e82108eead7165feae238c95ef, and
> ee3710f39f9d0ae5137a866138d005fe1ad18132, it starts working again.
>=20
> This has also been reported in the Framework forums at
> https://community.frame.work/t/tracking-auto-brightness-aka-ambient-light-
> sensor-in-linux-details/16746.

What is full dmesg log?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

