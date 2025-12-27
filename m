Return-Path: <linux-iio+bounces-27378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E9ACE0012
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D472430024BE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DE3176F2;
	Sat, 27 Dec 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCaKuqA1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90DA8834;
	Sat, 27 Dec 2025 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766855177; cv=none; b=FnKYUQ9R/6CHTJAOLZLWClzJktynToFyQ7/w7CRE3w5VSOBFt4ls5zn2cz17ZDUvyodqiOD4gQHbeekOqQbUrz1GneG+LVUYRqoL6LmoYwCqS6lNvijzovEljyaGVBkc27z0cB7UzJXRcCB5VC6TBS4nsDSvlEJZYlea+ESyyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766855177; c=relaxed/simple;
	bh=NTpVw1MWKdQD5XzNEpyiLS5xNVoZRVpbvXKO2AcrC6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGYBM2491EEaPmN1Ua/Bj2ZzWQ7hffS4pbc9MYbEzL2GO5zbRTtfyPLO5auqputBGXS2CA/qh8I05Z0hHy33aI4f4myg5JSOu1IusDNDevVP90RzLVNa5ek0GbXhToLc7j06t5YrcGdQVHu8aUwVPRU0Gn1icGU80aheUB5ii/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCaKuqA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBE1C4CEF1;
	Sat, 27 Dec 2025 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766855176;
	bh=NTpVw1MWKdQD5XzNEpyiLS5xNVoZRVpbvXKO2AcrC6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nCaKuqA1cPzRNBaAz01qgKAnOtSoAwic5A4Y9zWaSOe17DBRUXXst8EprgLXvB6UT
	 dR8TDyKi4rkYOnFj4chSZEW+BNzcbuPUgXFYAjnXwwmDlE2Qlgt2PDOElekoT8CxqO
	 s9v6+slFiK+R7O8hNXexU2cEsc1z+7WINvU3rj9kj4jVzb3+zBHi96icbifD+3tHrK
	 46kMNg4VuzHG0xvDQY+W6+mXmI+QX5cZ55wdjQj00abHxQQ3mpAhN4CSzHLU9/EGee
	 Y1ylrw/CoWPlEHgN64sAwHxsBm7wt60w7hRH39ktw2CjyM5exV4dYFT7f3nAz4GgzK
	 EPfwIzPf8nBFg==
Date: Sat, 27 Dec 2025 17:06:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 5/6] docs: iio: add documentation for adf41513 driver
Message-ID: <20251227170453.66752435@jic23-huawei>
In-Reply-To: <73sjjxkltm7a5ylpwv7jyiha3rsgmiwrjc4gwkva5u2vc36trk@sn4ctgr7v7ek>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-5-be29a83d5793@analog.com>
	<20251221180018.488cbac5@jic23-huawei>
	<73sjjxkltm7a5ylpwv7jyiha3rsgmiwrjc4gwkva5u2vc36trk@sn4ctgr7v7ek>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



> > > +2.3 Reference Input Control
> > > +---------------------------
> > > +
> > > +The ``refin_frequency`` attribute allows control of the reference in=
put
> > > +frequency when using a programmable reference clock. The supported r=
ange is
> > > +10 MHz to 800 MHz. =20
> >
> > I'm not really sure why need this as opposed to having a standard clock
> > provide it. =C2=A0What's the use case? =20
>=20
> I was thinking about, and for the application I am currently evaluating t=
he part
> the reference signal comes from a DDS, and that signal is not a clock it =
is a
> series of chirp patterns. The important thing about this property is to s=
et
> a center frequency for the DDS to work on. In that scenario the PLL will =
not
> really work as a frequency sythentizer, but as a frequency tracker of the
> varying reference. Problem is that I've realized that recently after putt=
ing
> together a device driver for the DDS. Therefore this property is still im=
portant,
> and I need to make the reference clock input as an optional property.
> I thought of making the DDS as a clock provider, but that center frequency
> would have a "virtual" meaning, not attached to the hardware configs.

Interesting use case!  I'm not really sure how we support it. I can think o=
f a
a few approaches that might work. In some way it's a bit similar to an ampl=
ifier
in front of an ADC or other analog front end, just working in the frequency=
 domain.
I've never been entirely happy with how we support those either though!

>=20

> > > +2.5 Phase adjustment
> > > +--------------------
> > > +
> > > +The ``phase`` attribute allows adjustment of the output phase in deg=
rees. =20
> >
> > As per driver feedback, I don't think this is compliant with existing A=
BI. =20
>=20
> ABI is not in degrees? the attribute is named out_altvoltage0_phase

All angle things (including phase) in IIO are in Radians (we try to stick t=
o SI
units). Check these in
Documentation/ABI/testing/sysfs-bus-iio*

Note that is not always as complete as it should be so if anything is missi=
ng
and in use we should add it.  We don't blanket add stuff the ABI constructi=
on
code allows as some cases will never occur in reality.

Jonathan


