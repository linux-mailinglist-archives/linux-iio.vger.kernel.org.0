Return-Path: <linux-iio+bounces-15977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55CA40AA2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4003B3395
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FFF201025;
	Sat, 22 Feb 2025 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYhhby/4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E541F1506;
	Sat, 22 Feb 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245249; cv=none; b=SmUgj9SThSG6rTDDj4OpCqJgHXhF3qufkYU4XDyLAW5cr4vCghf8ORYYP/bzd+fU4rplVQ+0kxLcYBqOtqlsLJfXOvYagjDege4Wdsuvp3zfc0ARs+oScCN72hJONG1WyixiQ+7f403XIGwQwjtH5VeF938K9glvDq20ocWl5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245249; c=relaxed/simple;
	bh=CL61gAUqhb0sQMX+rTET5exH4siStwJSEMSACoiFGKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O99vNH2YpNeN5i3dDXGpQ0mC8i07nQMHfCznwaavMRsJkiIFE/fUHFmiqvujZWIb0blSUYfaHicxr6rRlcs9Ho9xpNJnxaWWUtJjxH/ZQQG7nV6+MSrTJZUSO2xXnRZbscVrjYDHmNyhSFS2w+UFcWP6C61zIQLEDfLVDMqGjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYhhby/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A99C4CED1;
	Sat, 22 Feb 2025 17:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740245249;
	bh=CL61gAUqhb0sQMX+rTET5exH4siStwJSEMSACoiFGKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYhhby/4+5agcCxUg89X9BuGaSUpK2vX48Zi2ELbrOmDCXhqRz09VtRY7G2+DiDBC
	 Nc9lbo+FGDeBIfbYuE4iQKcOtg1B5iZ9uvMNDs4sdnzT+W43hfNxDfbJpIqcofEVqQ
	 b3gi6tutBAyvMNwU9ZPH6ffIrDXE8DcmqqI9H0FwBJOH7FIOCbcfTfB9WCEl30Tcq3
	 AANt0zcPRNgdWbJ8jFXyNxGHUohg4UNbEPUSeVZliARRtCNLa/+VkRfKGqHT9LFSfK
	 72Oqf1cPmMpqz8lMLmD236A5/2ixgYB68+DB3PY++FgwOlHsTP3R50yITxKlOJqW3b
	 VW71TkE0WbNaA==
Date: Sat, 22 Feb 2025 17:27:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Message-ID: <20250222172717.72b665fd@jic23-huawei>
In-Reply-To: <CAPVz0n0up=vkVzryYLauNCM2=hnz-o_ECm+ooXC8y=C2q+T_WQ@mail.gmail.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
	<20250218132702.114669-2-clamor95@gmail.com>
	<20250222142910.4e6b706d@jic23-huawei>
	<CAPVz0n0up=vkVzryYLauNCM2=hnz-o_ECm+ooXC8y=C2q+T_WQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Feb 2025 16:39:31 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:29 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, 18 Feb 2025 15:26:59 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > Add bindings for the LM3533 - a complete power source for
> > > backlight, keypad, and indicator LEDs in smartphone handsets.
> > > The high-voltage inductive boost converter provides the
> > > power for two series LED strings display backlight and keypad
> > > functions. =20
> >
> > Wrap patch descriptions to 75 chars as describe in submitting-patches.r=
st
> > =20
>=20
> Alright, though why then checkpatch script has max line length 100 chars?
>=20
> https://github.com/torvalds/linux/commit/bdc48fa11e46f867ea4d75fa59ee87a7=
f48be144

Because that script is intended to catch when things are very wrong not
slightly so.  It provides guidance that you should look at and consider
whether to respond to.  Checking for short wrap is trickier to do as
perhaps the formatting is intended in some cases.


Jonathan

>=20
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com> =20


