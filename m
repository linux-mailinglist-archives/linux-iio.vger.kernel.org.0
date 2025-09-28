Return-Path: <linux-iio+bounces-24531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9CBA6F7A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5865D189927C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F192D8375;
	Sun, 28 Sep 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac+/bukR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E619C560
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057183; cv=none; b=qLTqvuHC7ajH+fAnMp8Zj6Dep7pSa/T9P/JjaRD+s4Reqt/cLl71eCKqVqdEMWwhFLeqcw0y5elzHY34tCmfWWsJomgK5LNNBKRkhEzarooeDFKdSd5nL6RyabHojY2tGM7GxWh/Y6NiGrTzeg35zySBB2latG4HMpxdj9SMnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057183; c=relaxed/simple;
	bh=GDKFsybwD+pZ6FN+TSqOEdVfNWcD36CPhAp+I2giqqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B93j5TlwvCx+6IkRwbG/SN/kl/S4vodCAESqHyXcCiCtaJYPhxWyp3z6/AP+7c6e2Dxy0oCYBepPezuxBLtsn6afdIl/p5brKgobM4eAEB9G0S2p4hdlt7zmTnCFX0vsT+x8ko6brTfOjxksj2KXI9KE93pfceVdNBF7UX5w7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac+/bukR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAB30C4CEF0
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057182;
	bh=GDKFsybwD+pZ6FN+TSqOEdVfNWcD36CPhAp+I2giqqI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ac+/bukR1W0C+MR//Qkc8xsVWgEa1EK3z1HLtRJ3LCe8CJjnXQdl8hBLH7tp214/O
	 PG43nYtLeObAJIIcbfKFxRAbnV1Np7640TOmjn1GQog2LCOCGHHHtzyxJFO/dF0ogy
	 GrzDEIVjwmABgglnWJFYk3g6vCAaJdVK16LXyLAeOCIe+HluCSc45sCudXRtBCfPM/
	 90Chg6pDC5nFYZdQTGXzZE6h4OW6Yl86VipaqF2F/3SeTjL0EfAtrF4wG0pv6ZfJCw
	 r9iHkH8VirR7oryqbztcHpZg2mIwizBjPLfgFozfL79SyT+C1I+DUfLr6LoQ05FspI
	 fQgHkiT5GUzZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CDA5EC4160E; Sun, 28 Sep 2025 10:59:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 220543] MCP3428 scaling values are incorrect, three orders of
 magnitude low
Date: Sun, 28 Sep 2025 10:59:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jic23@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220543-217253-oOEqOx899T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220543-217253@https.bugzilla.kernel.org/>
References: <bug-220543-217253@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220543

--- Comment #1 from Jonathan Cameron (jic23@kernel.org) ---
On Sat, 06 Sep 2025 23:42:16 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D220543
>=20
>             Bug ID: 220543
>            Summary: MCP3428 scaling values are incorrect, three orders of
>                     magnitude low
>            Product: Drivers
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: IIO
>           Assignee: drivers_iio@kernel-bugs.kernel.org
>           Reporter: phil@munts.net
>         Regression: No
>=20
> The values for in_voltageY_scale that the 6.12 kernel generates for the
> MCP3428
> ADC are too low by a factor of 1000.
>=20
> The ADS1115 and the MCP3204 get in_voltageY_scale values around 1.0 (impl=
ying
> millivolts per ADC step) while the MCP3428 gets values around 0.001 and l=
ower
> (implying microvolts per ADC step).
>=20
> See also: https://forums.raspberrypi.com/viewtopic.php?t=3D391674
>=20
Optimistic +CC of Angelo (it's been a few years!)

As a sanity check, if you can rebuild your driver, could you try;
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 50834fdcf738..2bdf14f337ec 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -178,7 +178,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,

                *val1 =3D 0;
                *val2 =3D mcp3422_scales[sample_rate][pga];
-               return IIO_VAL_INT_PLUS_NANO;
+               return IIO_VAL_INT_PLUS_MICRO;

        case IIO_CHAN_INFO_SAMP_FREQ:
                *val1 =3D mcp3422_sample_rates[MCP3422_SAMPLE_RATE(adc->con=
fig)];

It's a bit of a hack for the largest scale as we should really represent th=
at
as *val1 =3D 1, *val2 =3D 0 rather than *val2 =3D 1000000 but meh - I'll sp=
in a nicer
fix if this works.

Working through the scaling. It's a mix of resolution, 12->18, vref =3D +-2=
.048V,
and PGA, 1->8x

The docs rather confusingly give LSB values for 12 bits of 1mV etc but those
are post PGA.   PGA increasing is equivalent of reducing the vref, so resul=
ts
in lower values.

So agreed with your discovery - this seems to be out by a factor of 1000.

Thanks for the report.  Hopefully Angelo can take a look, but if not I'll t=
ry
and spin a fix. If you can test the above that would be a great start.

Thanks,

Jonathan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

