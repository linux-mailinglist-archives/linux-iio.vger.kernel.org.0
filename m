Return-Path: <linux-iio+bounces-17011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40941A66D5D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 09:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29D1167968
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231531EF385;
	Tue, 18 Mar 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN3IQbKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B91EF373
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285124; cv=none; b=OPB1Y5i8XkDqEyk7KUrJKy8Tt61W1AUgU3bC5WRRaqVdLaRAfufDDnBZv3BeCXTfmTz130svQUdRKjO1wmGcMrsSnREqGr2/JqCmBCgdI3W79A7FLuj1B3xc3ttUxcl/x3a775JVrliDrpmUANOrwVyk32K03RstkCyc5SuRBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285124; c=relaxed/simple;
	bh=URIyTEcpvU2zS3VPKenPGzISNUjsxtC4uLiiBh3ebFE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjIwYbasvvjhHsKrKxWhcRbfsx7/WTAbirnCdNhIWfc9ilecvcYvxum+/nuKN7BvH4mvwIah56qyiR5ox43pT8+sBctNPaaLSV7cIz4GxcTno+VmL/EJvKfjccGEmOJoyCqlKTz/ffFR+TT5uA2BGQEIe2cmRjKMHi+1P2+xWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN3IQbKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E715C4CEE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285124;
	bh=URIyTEcpvU2zS3VPKenPGzISNUjsxtC4uLiiBh3ebFE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YN3IQbKJqp3u85vpjZDXRp7C281oaIqBpoW90EyEUIH/fBh9rPOUcZngaHCSlnJ3X
	 E6bUkqQDMbEP3sNQB+kJu5B4EnLOpgooqBYZ/mVmMW2hPYgsAQU6foEpZUJeEb5ehs
	 zCo9iLKofLR0rEp63eNONvnhJPtuTh1tQEBxt3Faa3P+JlQTvkkUO8rYd1YQb6ZuF2
	 7GiXwmTSBPIm1Hj1WxKZxq9eN1+m9BcJsx1NQEUvtt8OkDazgOoCV3KsqXoa0FlKzZ
	 CfQ3NBEZnyKCz1XJUtz4S+XKRZUZvjtu+ZT1cVVQEc/WF/TAY6/pWDw84GB39udmuP
	 DnA3Xd8M/wWpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 094C0C41612; Tue, 18 Mar 2025 08:05:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 08:05:16 +0000
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
Message-ID: <bug-219890-217253-FzlI2w7R4z@https.bugzilla.kernel.org/>
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

--- Comment #6 from Fred (wysiwyg81@rbox.co) ---
Hello!
woo, compiling my own kernel tool? sounds like some stunts, but challenge
accepted :).

Here how I did (just in case) and results so far:

- backup /usr/lib/iio-sensor-proxy to /usr/lib/iio-sensor-proxy-back

- reboot, try "monitor-sensor --light" =3D> stuck on  "Waiting for
iio-sensor-proxy to appear" so iio-sensor-proxy is disabled

- I downloaded kernel source from here:
https://github.com/CachyOS/linux/tree/6.13/cachy
Which seems to be the closest version of my current kernel (6.13 <=3D>
6.13.7-2-cachyos)

- get in /tools/iio and type make.

here is the result so far:

> sudo ./iio_generic_buffer -n als -a -c 1000
iio device number being used is 1
iio trigger number being used is 1
Enabling all channels
Enabling: in_chromaticity_y_en
Enabling: in_colortemp_en
Enabling: in_intensity_both_en
Enabling: in_illuminance_en
Enabling: in_timestamp_en
Enabling: in_chromaticity_x_en
/sys/bus/iio/devices/iio:device1 als-dev1
107.000000 107.000000 37.149998 39.379997 38.459999 1742281868794404097=20
107.000000 107.000000 37.149998 39.379997 38.459999 1742281868795405367=20
144.000000 144.000000 37.399998 39.250000 38.389999 1742283688135649249=20
116.000000 116.000000 37.149998 39.379997 38.459999 1742284362250389865=20
131.000000 131.000000 37.860001 39.020000 38.259998 1742284362493385633=20
212.000000 212.000000 37.360001 39.270000 38.399998 1742284386577247020=20
416.000000 416.000000 37.250000 39.329998 38.430000 1742284387069388487=20
358.000000 358.000000 37.209999 39.349998 38.450001 1742284388291391492=20
317.000000 317.000000 37.309998 39.299999 38.419998 1742284388536376237=20
282.000000 282.000000 37.450001 39.230000 38.379997 1742284388781420189=20
248.000000 248.000000 37.469997 39.219997 38.369999 1742284399552421827=20
163.000000 163.000000 37.380001 39.259998 38.399998 1742284402488374365=20
124.000000 124.000000 67.629997 30.769999 31.840000 1742284422066296843=20
181.000000 181.000000 37.669998 39.119999 38.320000 1742284435348409111=20
153.000000 153.000000 37.570000 39.169998 38.340000 1742284435643379865=20
165.000000 165.000000 36.849998 39.529999 38.549999 1742284564197069737=20
185.000000 185.000000 36.059998 39.950001 38.770000 1742284564442060549=20
166.000000 166.000000 36.889999 39.509998 38.540001 1742284566154115050=20
184.000000 184.000000 36.160000 39.899998 38.739998 1742284567377313995=20
166.000000 166.000000 36.889999 39.509998 38.540001 1742284568357307927=20
187.000000 187.000000 36.059998 39.950001 38.770000 1742284573251081541=20
210.000000 210.000000 35.410000 40.299999 38.950001 1742284573741120550=20


not finished yet, it's seems to take some time (roughly 40min running now).
I will update once finished.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

