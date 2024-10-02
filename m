Return-Path: <linux-iio+bounces-10000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470698CEAA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 10:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574951C2119A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E9194A75;
	Wed,  2 Oct 2024 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FCRT7u+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E961946B8;
	Wed,  2 Oct 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727857410; cv=none; b=fghMJY7hj++DIZ8f5Xw5BGrx94Fy86T05XtgxS2MpMrnVJB8vF346GMncA9g5sU6RV84ax5BYVCQ7voSbGHTtMWVFzHWnoErRgNgLspyUTviNLjUh/nd5DLFOOs5vXzNF+b7GDmUD3EQiGp4JtyWgv4hU0vQPiSP2h7w+QhJXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727857410; c=relaxed/simple;
	bh=QJnTndPiVOFy3IZ8X34lqJl/ovRk+qC0huwOteEXs/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcVm81gP/JsWQ0q+pBjdCScHQ55tDA0ZUATghQuDROlk+9khJ+UqXojzqYfz2dmRn2Y/pdmsJP+dy80FSYAo9bZ3IzYKKgZc5CbIUdHVWhmCGR28quqZFW37GeEyXu/ZBRZBFavYr/DzFUSoYNNw0P+odVpuZZLRIKh3hOyCdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FCRT7u+E; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E01682000D;
	Wed,  2 Oct 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727857406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KO6hb+UIivQkdsF/5XV6JgWPFFYayRTFiZ3i8R7KmHQ=;
	b=FCRT7u+E0D+Y+FY2vLL8DS2bhGNdKwgmvj5Y+e21LCgbhEKREgFEwKx/LeYFq4drcq57hM
	uXKrHsActLgsGqlmnYyakxp0+P3iZ+R3j3uRJdEaHMRe3vyGobXZNMmCpTsxNbkyoF6oEY
	kpD6F8qIM8s3eDEL6P7GWnh5moTgFMgaIMvcpmqLQ12ghPfxNy+wHIqyLOs0ZJ37BePtdr
	Vx9shY0VA4iYT6xdwtITwqkcoYz4vuhH9NbAPZQnI/VZ7ihYrnHyDTA5E6XDZSfg/+ZS7f
	LDn4vkNU5loIBQt9MmOUK4QaD0pmgwcwT1wGxbMM2L4cKUfgBc6qKGliR8X+mA==
Date: Wed, 2 Oct 2024 10:23:24 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Ian Ray <ian.ray@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] iio: adc: Add support for the GE HealthCare PMC ADC
Message-ID: <20241002102324.2e3600ca@bootlin.com>
In-Reply-To: <20241001202430.19bfc666@jic23-huawei>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-4-herve.codina@bootlin.com>
	<20241001202430.19bfc666@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: herve.codina@bootlin.com

Hi Jonathan,

On Tue, 1 Oct 2024 20:24:30 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  1 Oct 2024 09:46:17 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
>=20
> > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> > (voltage and current), 16-Bit ADC with an I2C Interface.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Just one thing to add to David's review.
>=20
> I'm going to guess this isn't a general purpose ADC? Can you share any in=
fo
> on what sort of device it is used in?
>=20
> No problem if not - I'm just curious as I've not seen GE HealthCare I2C p=
arts
> before!

I cannot tell about the product it is used in :(
One sure thing I can say is that the component itself is not available off
the shelf, and is fully designed to be used in a specific product.

>=20
> > diff --git a/drivers/iio/adc/gehc-pmc-adc.c b/drivers/iio/adc/gehc-pmc-=
adc.c
> > new file mode 100644
> > index 000000000000..c46c2fb84d35
> > --- /dev/null
> > +++ b/drivers/iio/adc/gehc-pmc-adc.c
> > @@ -0,0 +1,233 @@ =20
>=20
>=20
> > +
> > +static int pmc_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan=
_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct pmc_adc *pmc_adc =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D pmc_adc_read_raw_ch(pmc_adc, chan->address, val);
> > +		if (ret)
> > +			return ret;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D 1; /* Raw values are directly read in mV or mA */ =20
>=20
> Drop this scale and make the channels processed. That saves userspace eve=
n applying

I thought that scale was mandatory.

=46rom the userspace, offset is clearly optional
  https://elixir.bootlin.com/linux/v6.11/source/Documentation/ABI/testing/s=
ysfs-bus-iio#L458
But nothing about a default value is mentioned in the scale description
  https://elixir.bootlin.com/linux/v6.11/source/Documentation/ABI/testing/s=
ysfs-bus-iio#L515

> the *1 this indicates.  Rare to find a device that outputs in our base un=
its
> but might as well take advantage of one that does :)

Yes, the device is a custom designed device and it has a fully knowledge (by
design) of the board it is soldered on. As I was involved in the communicat=
ion
protocol definition, units were chosen to fit well with IIO.

>=20
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +} =20

Best regards,
Herv=C3=A9

