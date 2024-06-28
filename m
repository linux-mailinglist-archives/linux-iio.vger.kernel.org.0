Return-Path: <linux-iio+bounces-7025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61491C5F1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BACB247C4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C81CE081;
	Fri, 28 Jun 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjpwMZmg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEB1C8FAB;
	Fri, 28 Jun 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600004; cv=none; b=aoIaxmhKRL7C8OQkRd/oo/C8toRedM1tw3ZaOjKnjuuDsCqaZh5q7YfDg2BwOkDdA0KalaVCODoni1Pgw/WV9Df475kdvyVrJpHUipzTffv7gIfJnznsJv/6+z4G/TctdWovpsQ5R8DQog/5CV/n8nUYXSr9orqJk4EshpBc7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600004; c=relaxed/simple;
	bh=lhiXVKbviQVZDcIxC0i6nBahft0To6SW9QRHyVQkt6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgbiekM2fV/xq2tyGg+M8qNWoZQsBpZszal5HKAdpx0DVB8mghpLEEP8u6AOtRPYw1s0ZMMLrmtaFta9HLXVU0TfsYgcxXK03eQfi6gH2KpY1hSRpeETHIxsj1z6WfubnZtQIUX+Xxbpsf3E5CXOjetp4FfHkZX6G5f15haqSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjpwMZmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42F0C2BD10;
	Fri, 28 Jun 2024 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600004;
	bh=lhiXVKbviQVZDcIxC0i6nBahft0To6SW9QRHyVQkt6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CjpwMZmgklwfr1/22p3YPqxaOdvRtEMKw5x7Ogw0I3JWU0gpPq04VqQ52t9veAExu
	 ijmdCcNhb3mWg4uXu6E14qGBx53X074OfBvBKWqu02b9P62wyYjPViOW5g/jK73ZpL
	 o52LoMKKlBrNijB3o5hDdJY8WbYWZTuHRiXIgwqqWP1YfrvQOLZcZ8/IO+NROCb772
	 uJWtz25dSWUxBs+t4qoWcSwH8+TNgnZLQTxNyOSo0zmCXtG26/R+/6DryiuV2M/Z1q
	 h+uQAbjNzWyQCwPdQnQZwcsMWClFKdzQb2HvYrQWrIqhGGktOx3jNb4/Rv+1ucHdRd
	 y1NgB91bttdAA==
Date: Fri, 28 Jun 2024 19:39:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] add AD8460 DAC driver
Message-ID: <20240628193954.2f3dfc55@jic23-huawei>
In-Reply-To: <SJ0PR03MB62242BD5117C5B2026CCC5D191D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	<CAMknhBHd2XCJH4rgYDq=vbCL5E_tM3FxFPWbNy9PvxLCJL4tcA@mail.gmail.com>
	<20240511172155.08bc0987@jic23-huawei>
	<SJ0PR03MB62242BD5117C5B2026CCC5D191D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> >  =20
> > > >   * Programmable quiescent current (optional) =20
> > Could probably figure out a suitable control for this, but I'm not enti=
rely sure
> > what it is :) =20
>=20
> Thinking about it, wouldn't the raw attribute be a suitable control for t=
his? This=20
> Value is relative to nominal supply current and acts as a "monotonic but =
nonlinear"
> multiplier.=20
> A register value maps to a current level from 0 to 2 times the nominal
> current supplied. I also thought that it could be hardware gain but the g=
ain
> computation wasn't explicitly indicated in the datasheet and there is not=
 yet
> "current_hardwaregain" attribute available in the ABI. So I settled with =
raw.=20

I don't entirely understand what is actually for, but a raw current output
might be appropriate.

>I
> Think there would only be an issue of we expose the "processed" attribute
> Because it has a particular computation. But I'm not planning to expose t=
he=20
> Processed attribute

Is there any reason someone might in future though?

>=20
> > > >   * Thermal monitoring is done by measuring voltage on TMP pin
> > > > (unlikely to be included) =20
> >
> > If you did want to, the usual trick for these is to include an optional=
 use as a
> > consumer of an IIO provider which would be a separate ADC. =20
>=20
> I included this in my current revision, thanks for the idea. Although the=
 optional use
> Isn=E2=80=99t yet available in the consumer API. My question is, in case =
the ADC channel to read
> The TMP pin is not available, should I still make the temp raw value avai=
lable and
> Set to 0? Or should the temp raw attribute be unavailable or unlisted com=
pletely from
> IIO Info.
If no ADC channel then remove it from the chan_spec.  That probably means y=
ou
need separate arrays of struct iio_chan_spec for the two case.

Jonathan

> > > > =20
> > >
> > > Adding myself to the cc: here since I'm interested to see what
> > > Jonathan (or anyone else) has to say about the fault monitoring. =20
> >=20
> > Jonathan =20


