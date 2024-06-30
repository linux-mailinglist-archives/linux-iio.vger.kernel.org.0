Return-Path: <linux-iio+bounces-7073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081C491D0F3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDC281648
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852112F5A1;
	Sun, 30 Jun 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOHGXY8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4517736;
	Sun, 30 Jun 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741301; cv=none; b=R+RKZZTbHo87hbTBOqzlwdGDWEyPyHLU6IAkAqtGLcNFeCBTK/3CRarg545ruIEcPpafOXXx5khVCpRT/t4D7WGSxYE/bmkrpOcmjs+33JOCgp8GSKSjthVa1flnuCKgQNxjwb4IgeVqPOd3AJ1pqISpUQo87swifxM36IwQu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741301; c=relaxed/simple;
	bh=8I0fB8HDKSv544jKjZ8E6RXOX3Jk5+XFowFSScyCYj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrLqj0af5/w+cMElU9MoomhXkJ1z0KMuNShJtx+pqfCUyQw+2/DpAGKk0zQ6u65zhhD7Oivbc+R/pB588NIdo0zN1NCyoAiVXyb92GcfXC16I/6rBDJUbcvjCJQGMKmK/6bjXl1qGvMGI71AJTdwG/eSBt6KMFVc1hAhUAyKQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOHGXY8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57CC2BD10;
	Sun, 30 Jun 2024 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719741300;
	bh=8I0fB8HDKSv544jKjZ8E6RXOX3Jk5+XFowFSScyCYj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOHGXY8owx6Ta+5g37ueSQHUVvvFV8zFmcKSJUqv49ZW/t0iK/dpbo0Ovc87lHR2D
	 IJxvU842JpmvIRn2acmZC4pigSCkYDmFy3OoMM5XnY0Ebrem44qx5gBywyM5lUuEPF
	 H7qR3h9GruJ9o+GnFaaDGCIqLek/bjKdTAjevxWD4JUUSWpu9ocR+bah+OVlvPkaO3
	 mojCjUZJnKw8hXnADWKNKjIPlJYTp0Es/BaM25QOsLAdzOk8PmmsyiLtUoCcYgPJWp
	 kaq1yWXtkVPBhO7EmsmL+tY5IVdXD1G9+mXFkj9bxgzwkCbP2Ls/hFOfi85UpcQrqF
	 v8KBR3VOVxing==
Date: Sun, 30 Jun 2024 10:54:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman 
 <alisadariana@gmail.com>, Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 5/6] iio: adc: ad7192: Add clock provider
Message-ID: <20240630105448.758dd131@jic23-huawei>
In-Reply-To: <a72569f7c1f5d9a7158fe774179ec8fc76016168.camel@gmail.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
	<20240624124941.113010-6-alisa.roman@analog.com>
	<CA+GgBR8r_W9X0hROUEw-xePyKAhOTBjJtf=cHbfWfvUUfk5j_g@mail.gmail.com>
	<a72569f7c1f5d9a7158fe774179ec8fc76016168.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > +
> > > =C2=A0static int ad7192_clock_setup(struct ad7192_state *st)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &st=
->sd.spi->dev;
> > > @@ -412,6 +496,11 @@ static int ad7192_clock_setup(struct ad7192_stat=
e *st)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 st->clock_sel =3D AD7192_CLK_INT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 st->fclk =3D AD7192_INT_FREQ_MHZ;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D ad7192_register_clk_provider(st);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return d=
ev_err_probe(dev, ret,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to register clock
> > > provider\n"); =20
> >=20
> > A question here: do we want to fail the probe of this driver when it
> > cannot register a clock provider?
> > Or should we ignore it?
> > No preference from my side. =20
>=20
> Sensible question... I would say it depends. On one side this is an optio=
nal
> feature so we should not (arguably) error out. OTOH, someone may really w=
ant
> (and relies on) this feature so failing makes sense.
>=20
> Maybe we should have
>=20
> if (!device_property_present(&spi->dev, "#clock-cells"))
> 	return 0;

I'm not 100% sure from looking at the code, but if the absence of this prop=
erty
(because the DT writer doesn't care about this) is sufficient to make the
calls in ad7192_register_clk_provider() fail then we should check this.
I don't think we need the complexity of get_provider_clk_node() as there is
no reason to look in a parent of this device (it's not an mfd or similar) so
this check should be sufficient.

Does this also mean the binding should not require this?  I suspect it shou=
ldn't.
=20
>=20
> in ad7192_register_clk_provider(). So that if we fail the function, then =
yes, we
> should fail probing as FW wants this to be a provider. Also, not providing
> #clock-cells means we don't register the clock.
>=20
> Having said the above I think that failing devm_clk_hw_register() means t=
hat
> something is already really wrong (or we have a bug in the driver) so lik=
ely we
> should keep it simple and just always provide the clock and return an err=
or if
> we fail to do so.
>=20
> my 2 cents...
>=20
> - Nuno S=C3=A1
>=20
>=20


