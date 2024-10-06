Return-Path: <linux-iio+bounces-10227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59C991E0A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF36B1F2176D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD2175D39;
	Sun,  6 Oct 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMCcJwR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D314170A08;
	Sun,  6 Oct 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213316; cv=none; b=Ar5XPEtqHST9SXV75kKF/ba7vdtYsTatTwRuZhIRADxXPla+SZ7NrsrZEbPNQAm4YkkbAZLY+ukYACJyolQh7IGRYVqgbc73XF/SmEhYKqbq01sYc0a7ZwPrS4jkTZNrXK0/cS4Zs5WQqYHP7gFw1yWjAHlVor2yN6h+KzF/7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213316; c=relaxed/simple;
	bh=ivgSAXjwN2I4F19wez+Mlswpnth2wP0cv0UXGtKwzMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlUQrheU24MswgNd3N+3GEqwkp6/gjvrzOQA7mCmS0KMV/G7LlqdZgwONNoJo8571vp551N5tHKZst+GspXCO/bbPIzYUOBCzg7FMRl9z7PZmFJwemgX4KKoIMhzMFUmFUpEZW38cXf0b4/tLGLtv94fEjqxdyWAGoNW8uY3X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMCcJwR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DFC4CEC5;
	Sun,  6 Oct 2024 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728213315;
	bh=ivgSAXjwN2I4F19wez+Mlswpnth2wP0cv0UXGtKwzMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IMCcJwR+HtKbh8TuxXrntITaFC1A9qn1oRMYWlGHzvV/SQ16DNKClj810cSFQxq3y
	 xCkOtnGNBesEmQg+4MWJEIV1BKXApmXIXm1yY76hDqq2rYpQ7iSTbanLDokU6RdQci
	 9fbTs2drEcSBE/CwLjcZ/s4eWIv4Rb6fQOD+Y81LTlPxxCb3ea66N3MQVkA385RbQp
	 1/fJQpguSm3eDvKgtLIe1BZ1P06UbMlsPAyi2kMWdcf/k4n+E4Pd1BM/0bI1V5Exud
	 LabZPitCAnc0MIkXOgI2Z6BSDuFhLbaAAo5ErdZsUQ0Nxgx2a/rY906UB3B8yZ4dic
	 DJt7H23P0WvOQ==
Date: Sun, 6 Oct 2024 12:15:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Ian Ray <ian.ray@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Message-ID: <20241006121506.3fcfda93@jic23-huawei>
In-Reply-To: <20241002102324.2e3600ca@bootlin.com>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-4-herve.codina@bootlin.com>
	<20241001202430.19bfc666@jic23-huawei>
	<20241002102324.2e3600ca@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2024 10:23:24 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Jonathan,
>=20
> On Tue, 1 Oct 2024 20:24:30 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Tue,  1 Oct 2024 09:46:17 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >  =20
> > > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Chann=
el
> > > (voltage and current), 16-Bit ADC with an I2C Interface.
> > >=20
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>   =20
> >=20
> > Just one thing to add to David's review.
> >=20
> > I'm going to guess this isn't a general purpose ADC? Can you share any =
info
> > on what sort of device it is used in?
> >=20
> > No problem if not - I'm just curious as I've not seen GE HealthCare I2C=
 parts
> > before! =20
>=20
> I cannot tell about the product it is used in :(
> One sure thing I can say is that the component itself is not available off
> the shelf, and is fully designed to be used in a specific product.
>=20
> >  =20
> > > diff --git a/drivers/iio/adc/gehc-pmc-adc.c b/drivers/iio/adc/gehc-pm=
c-adc.c
> > > new file mode 100644
> > > index 000000000000..c46c2fb84d35
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/gehc-pmc-adc.c
> > > @@ -0,0 +1,233 @@   =20
> >=20
> >  =20
> > > +
> > > +static int pmc_adc_read_raw(struct iio_dev *indio_dev, struct iio_ch=
an_spec const *chan,
> > > +			    int *val, int *val2, long mask)
> > > +{
> > > +	struct pmc_adc *pmc_adc =3D iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret =3D pmc_adc_read_raw_ch(pmc_adc, chan->address, val);
> > > +		if (ret)
> > > +			return ret;
> > > +		return IIO_VAL_INT;
> > > +
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		*val =3D 1; /* Raw values are directly read in mV or mA */   =20
> >=20
> > Drop this scale and make the channels processed. That saves userspace e=
ven applying =20
>=20
> I thought that scale was mandatory.
>=20
> From the userspace, offset is clearly optional
>   https://elixir.bootlin.com/linux/v6.11/source/Documentation/ABI/testing=
/sysfs-bus-iio#L458
> But nothing about a default value is mentioned in the scale description
>   https://elixir.bootlin.com/linux/v6.11/source/Documentation/ABI/testing=
/sysfs-bus-iio#L515
It doesn't get applied to _PROCESSED attributes (see ABI for _input attribu=
tes which
simply doesn't say to apply anything.

There is a corner case where _OFFSET is provided but not _SCALE and hence t=
he channel
is _RAW.  In that case I'd say _SCALE is optional, but I'm not sure we've e=
ver seen
it in reality!  The more common case (though still rare) is like this one w=
here=20
the reading is in the base units of the ABI so _input is the away to go.
This is fairly ancient ABI lifted from hwmon.


>=20
> > the *1 this indicates.  Rare to find a device that outputs in our base =
units
> > but might as well take advantage of one that does :) =20
>=20
> Yes, the device is a custom designed device and it has a fully knowledge =
(by
> design) of the board it is soldered on. As I was involved in the communic=
ation
> protocol definition, units were chosen to fit well with IIO.

Nice :)
>=20
> >  =20
> > > +		return IIO_VAL_INT;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}   =20
>=20
> Best regards,
> Herv=C3=A9


