Return-Path: <linux-iio+bounces-17012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F49A66D63
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5192A188675E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005261E3DD7;
	Tue, 18 Mar 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSqdIox6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3217A309
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285230; cv=none; b=HG6b9hnWovynTbCKLvHbjoe8aJ7+clqgJYvjFB3XJndiTVQdlpVuh+ks3HBlze4LOLf9+jbd813OP6l0FU8PI4/UacIy69n4ocXueeXBGra8E7UvVYLU+7UcP0JOVa6XzuO1jwnf9oveQfGpP4L1JfyrcUHNfPceEwMFQZ9bFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285230; c=relaxed/simple;
	bh=e0a0jLA+Tvi+LM4GqRww5aWOAIkKBLAgJBTATVkgM4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LB7DRMLtrWbQ2HNu0GAIyWfIgBSJXfnHcTn79zBQg/07DMfAP6994uVmR71YrPx1cbYrOENDL87LyGQIRkfJ5m2ZJ6YWU9aPs6FF17+mLx1t1k/xige7iT3IKijTWTm47itr8023rNt6T9DFvT9a/nDp7aeXeZ3tNEMmvVcAoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSqdIox6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 339B7C4CEE9
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 08:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742285230;
	bh=e0a0jLA+Tvi+LM4GqRww5aWOAIkKBLAgJBTATVkgM4g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NSqdIox6WtI0O+cvA/kLxfwJtidqBKc9Y/XGfBmuq1m5NWlxLBKfg/RVd4s50lgwq
	 095sv8yG3WikNJmdL20IU0pU1n5+wTNzbgwlr14HGBU4UlbyANTNoziyYKRCMw9QPW
	 ReSf1QOxUuJoNWjH22+yxvoyCL57kJ8b8rb4ItXr88UAWCNO6plHtUgcBy9Ln912GK
	 N8cwsPH0SCGucvdzt8fdzi9UpfZjc+9cJOC5Bb/p+stLg63ayC+bjGzu4Npa55mg1E
	 1KtaqyK61VZM8+WdlI5mHjUdefhYcrbsdKnLoaNFyy+713gntjpZxHa8xKM6o27+Dp
	 FBwU7P+JctaZA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1652AC3279F; Tue, 18 Mar 2025 08:07:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Tue, 18 Mar 2025 08:06:57 +0000
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
Message-ID: <bug-219890-217253-LfDExiUjuF@https.bugzilla.kernel.org/>
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

--- Comment #7 from Fred (wysiwyg81@rbox.co) ---
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

