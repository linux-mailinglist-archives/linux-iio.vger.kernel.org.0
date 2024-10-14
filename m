Return-Path: <linux-iio+bounces-10577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC899D6B8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BF21F236AA
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87381C831A;
	Mon, 14 Oct 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwPxg0AL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DA4683;
	Mon, 14 Oct 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931575; cv=none; b=OcI0j99eBMBNNyq2omWi7VcA0hr6DpK6FNFZf9uYTDOhaVbnWuD3D7gUYhKN2vhFq6GRVdxD1iOC31Z2kxqb2jgIeKqlIarRJnDb4razjcl/1zb+UXRkwRN7TFi65y7bBBR5szSJS3PYL9PxtDjwpInhF93QgIXU3rSGAky+G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931575; c=relaxed/simple;
	bh=boc15PWERETESJNxCNOMxyRSxtxOGcpQbKMu5NjC1v0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR9+dlr3eUasNTguAC2HXQ9a1mJGJRM/WquMx9tCSFhEQLc2QwvhUi2FLYmco1jU9204s6643KYdMW1Nu+lBUaHPF0V7h0eJrGNAPCQaq70Eiu1k/K34PsgwnM8jI4DUh/Gqr9Nw3qzmpGTX++ngQm7puofc8HdGR4N1cF9bNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwPxg0AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB18C4CEC3;
	Mon, 14 Oct 2024 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728931575;
	bh=boc15PWERETESJNxCNOMxyRSxtxOGcpQbKMu5NjC1v0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwPxg0ALSHU5xWCTpSTs5o13VMJD9nvJz/IIhOA8j413KfzZZeKDZH4yEd9d3G/Fn
	 7WNXl+Be7oOUypeRM2NA22EX7sPZcyyXy9C81sWw1Nf1+jKclJZPLIjUHHoh6EYSYB
	 qUidg/tFLA1iE/MUpfKmJjgwSu+Xt+c3oEaNC070WMTLABZFadR4sIJwbC/aLkGVxx
	 FMUK5j+hFqaLkv6n1PWgs0WtgSLBa29GCjy5PfGCHRPMipBTbbb9/80G2T3vla+cdJ
	 vvwDS8H9GNkGPJUGV8gCc8x1ABAXB7t0/lKzBoqgRY8hKoca6d6dxvToMYfi+F/yTl
	 COI08cSb2CCaQ==
Date: Mon, 14 Oct 2024 19:46:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Victor.Duicu@microchip.com, lars@metafoo.de,
 Marius.Cristea@microchip.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: pac1921: add ACPI support to Microchip
 pac1921.
Message-ID: <20241014194605.285e3909@jic23-huawei>
In-Reply-To: <172892078642.158534.11658754591922958169@njaxe.localdomain>
References: <20241011134454.45283-1-victor.duicu@microchip.com>
	<172872753469.9340.10387646359307852048@njaxe.localdomain>
	<e4cad20ed2f8d31bf71bc595ab54c64d96bfb4b4.camel@microchip.com>
	<172892078642.158534.11658754591922958169@njaxe.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


>=20
> > > > +static int pac1921_parse_of_fw(struct i2c_client *client, struct
> > > > pac1921_priv *priv,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &clien=
t->dev;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 temp;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D device_property_read_=
u64(dev, "shunt-resistor-micro-
> > > > ohms", &temp); =20
> > >=20
> > > Since the driver would discard a value out of INT boundaries, I don't
> > > see the
> > > need to read a value larger than u32 that would be discarded anyway.
> > > To my
> > > understanding, device_property_read_u32() should fail for an
> > > overflowing value
> > > thus I would keep device_property_read_u32() here, and at that point
> > > the temp
> > > var would not be necessary as well. I think it would also help to
> > > keep the patch
> > > diff confined in the ACPI extension context. =20
> >=20
> > If the value in .dtso is greater than 32b, at compilation it will be
> > truncated, and the incorrect value will be accepted by the driver. By
> > adding "/bits/ 64" in the devicetree to shunt resistor the value will
> > not be truncated. This way values on 32b and 64b can be read correctly.
> >  =20
>=20
> I see your point but if I understand this correctly with this change the
> shunt-resistor-micro-ohms field in the DT should always be specified
> with /bits/ 64, even for values in 32bit boundaries. I might be wrong
> but this looks like something that should be documented in
> Documentation/devicetree/bindings, especially since all the other
> shunt-resistor-micro-ohms instances look to be interpreted as u32.
> Also, I think that such change would fit better in a different patch as
> it is not related to the introduction of ACPI support.

I'll ask the silly question. How big a shunt resistor do you have?
If it's necessary to change them over that is fine but if that means
existing dt is wrong, then you'd need to maintain compatibility.
So test with a 32 bit dt value and 64 bit. Probably need to try
64 bit and if it fails try 32 bits.


>=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, ret,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cann=
ot read shunt resistor
> > > > property\n");
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pac1921_shunt_is_valid(te=
mp))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, -EINVAL, "Invalid shunt
> > > > resistor: %u\n",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv-=
>rshunt_uohm); =20
> > >=20
> > > The error should be returned when the shunt is NOT valid.
> > >  =20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->rshunt_uohm =3D (u32)te=
mp; =20
> > >=20
> > > The temp var should not be necessary if switching back to
> > > device_property_read_u32(),
> > > otherwise I would remove the unnecessary explicit cast for the above
> > > reason.
> > >  =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1921_calc_current_scales(p=
riv);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > +}
> > > > + =20
>=20
> Thanks,
> Matteo Martelli


