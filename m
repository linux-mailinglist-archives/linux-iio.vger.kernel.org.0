Return-Path: <linux-iio+bounces-5628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89FA8D759F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E81F226A2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2163B290;
	Sun,  2 Jun 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g24qRkMf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689A10795;
	Sun,  2 Jun 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334030; cv=none; b=D748Fl1sVzohPj0y/Dar8Kt7/KyZCwqee39r0/X5hglT3ncZ8EbKeOyIM5uCdF1pRFng/8TKyAvdD5X2NNuQD9KqFkVPKck7CqLBJ5ZPSDO8cGfo9LDWdYx/x5zJgQQNXQD8Gbp6Dg6+RfQVg7wTmJ2EflXIVGIqzjroXWunG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334030; c=relaxed/simple;
	bh=lZGeyfIPOcjTH+eN+euPWWYIihGXtb+GDNdOkqg2EXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFT7SHDioAnybZkQnu5PtAVHs/BKw61HOnsD5pvf1GVHVyJVKT16vOMBbbzk8gZhBPDuNDBwvrGSA83PQnXn7cokXmf9Ry3qbeyUBUmoNG3tO+qTAzqeUNF+vVQWOLWCkjBDAtBvqCND1FSUy1VuUxTNLtLSGV4zLQhhTCfEXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g24qRkMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45AC2BBFC;
	Sun,  2 Jun 2024 13:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717334030;
	bh=lZGeyfIPOcjTH+eN+euPWWYIihGXtb+GDNdOkqg2EXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g24qRkMfvxfxMbwvpocfJeZJ3m2p22KR4S5JWCRhx54IFZi/YFI5I6nI3wFa6UeyA
	 UY3cX9/dGZ12CP8zfrdIpchQPDnbFvZ6szdmC27seB1daT/iYPFqsA9InEwcazuett
	 WceTjhe7wUMCI3NDOEscBLkmTdRfxf25sL7otMDfrdWbcRkIqHCai85EAtgQYftKjO
	 HECyd+VUhpWf/efcJv+7LY999dJqdPTM/bcjF6su0aii/s3KxGVXLKhtQc0MyfYjXn
	 sIHX5dQxO0XkCW2TiZkpc/bucaTWajsF68/NJmcuKR8lNFhVgUO0XezNkKLIJnuNhB
	 SmMAS2djsvz6A==
Date: Sun, 2 Jun 2024 14:13:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dimitri
 Fedrau <dima.fedrau@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240602141336.202a8194@jic23-huawei>
In-Reply-To: <PH0PR03MB71413F8B4F8CF840E4AA6879F9F12@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
	<20240523031909.19427-6-kimseer.paller@analog.com>
	<20240523180210.00006b84@Huawei.com>
	<PH0PR03MB71413F8B4F8CF840E4AA6879F9F12@PH0PR03MB7141.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 May 2024 05:53:11 +0000
"Paller, Kim Seer" <KimSeer.Paller@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Friday, May 24, 2024 1:02 AM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> > Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v2 5/5] iio: dac: ltc2664: Add driver for LTC2664 a=
nd
> > LTC2672
> >=20
> > [External]
> >=20
> > On Thu, 23 May 2024 11:19:09 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >  =20
> > > LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> > > LTC2672 5 channel, 16 bit Current Output Softspan DAC
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com> =20
> > Hi Kim,
> >=20
> > A few minor things inline,
> >=20
> > Jonathan
> >  =20
> > > diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> > > new file mode 100644
> > > index 000000000000..488b841e6c66
> > > --- /dev/null
> > > +++ b/drivers/iio/dac/ltc2664.c
> > > @@ -0,0 +1,802 @@ =20
> >=20
> >  =20
> > > +static int ltc2664_set_span(const struct ltc2664_state *st, int min,=
 int max,
> > > +			    int chan)
> > > +{
> > > +	const struct ltc2664_chip_info *chip_info =3D st->chip_info;
> > > +	const int (*span_helper)[2] =3D chip_info->span_helper;
> > > +	int span, ret;
> > > +
> > > +	st->iio_channels[chan].type =3D chip_info->measurement_type;
> > > +
> > > +	for (span =3D 0; span < chip_info->num_span; span++) {
> > > +		if (min =3D=3D span_helper[span][0] && max =3D=3D =20
> > span_helper[span][1]) =20
> > > +			break;
> > > +	} =20
> >=20
> > Sanity check for no match?
> >  =20
> > > +
> > > +	ret =3D regmap_write(st->regmap, LTC2664_CMD_SPAN_N(chan),
> > > +			   (chip_info->id =3D=3D LTC2672) ? span + 1 : span);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return span;
> > > +}
> > > +
> > > +static int ltc2664_channel_config(struct ltc2664_state *st)
> > > +{
> > > +	const struct ltc2664_chip_info *chip_info =3D st->chip_info;
> > > +	struct device *dev =3D &st->spi->dev;
> > > +	u32 reg, tmp[2], mspan;
> > > +	int ret, span;
> > > +
> > > +	mspan =3D LTC2664_MSPAN_SOFTSPAN;
> > > +	ret =3D device_property_read_u32(dev, "adi,manual-span-operation- =
=20
> > config", =20
> > > +				       &mspan);
> > > +	if (!ret) {
> > > +		if (!chip_info->manual_span_support)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +			       "adi,manual-span-operation-config not =20
> > supported\n"); =20
> > > +
> > > +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +			       "adi,manual-span-operation-config not in =20
> > range\n"); =20
> > > +	}
> > > +
> > > +	st->rfsadj =3D 20000;
> > > +	ret =3D device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsad=
j);
> > > +	if (!ret) {
> > > +		if (!chip_info->rfsadj_support)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					     "adi,rfsadj-ohms not supported\n");
> > > +
> > > +		if (st->rfsadj < 19000 || st->rfsadj > 41000)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					     "adi,rfsadj-ohms not in range\n");
> > > +	}
> > > +
> > > +	device_for_each_child_node_scoped(dev, child) {
> > > +		struct ltc2664_chan *chan;
> > > +
> > > +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> > > +		if (ret)
> > > +			return dev_err_probe(dev, ret,
> > > +					     "Failed to get reg property\n");
> > > +
> > > +		if (reg >=3D chip_info->num_channels)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					     "reg bigger than: %d\n",
> > > +					     chip_info->num_channels);
> > > +
> > > +		chan =3D &st->channels[reg];
> > > +
> > > +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> > > +			chan->toggle_chan =3D true;
> > > +			/* assume sw toggle ABI */
> > > +			st->iio_channels[reg].ext_info =3D =20
> > ltc2664_toggle_sym_ext_info;
> >=20
> > chan->ext_info =3D ... =20
>=20
> Hi Jonathan,=20
>=20
> I noticed that the struct ltc2664_chan does not currently have an ext_inf=
o field.
> Based on your comment, I'm considering adding this field to the structure=
 yet=20
> I'd like to understand how this would interact with the iio_chan_spec. I'=
d see this
> by adding 'st->iio_channels[reg].ext_info =3D chan->ext_info' after that.=
 Is that right
> approach? I'd appreciate more details on how you picture this. Thanks
Ah.  Was a misread on my part.  I confused channels and iio_channels.
Ignore that comment.

Sorry for the waste of time!

Jonathan

>=20
> Kim
>=20
>=20
>=20


