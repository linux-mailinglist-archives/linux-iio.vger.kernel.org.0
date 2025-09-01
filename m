Return-Path: <linux-iio+bounces-23596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6DB3ECAE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D3D480B16
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF9306488;
	Mon,  1 Sep 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="OnS2C3Km"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13CD2E03F2;
	Mon,  1 Sep 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745505; cv=none; b=tAcytLOhNPedWQGHXxxF8ko+gpW9xs/HNSSOfTmIVLET1CHb1rVkj35unoe0G+UquBWOYED1qHab96q7OjAZVUwM6AGJTKXKhhs/HmgQxCtqscjLXyfE2y6diUUN5LnLVdni4anBI2DZpyXQ2qlNqyfpx0Ze63KecJO7XMS9/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745505; c=relaxed/simple;
	bh=hnTOWpGvLfZLVV3CYuJL3VZOJGTbmj8kq1PdABYR5vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWczRaXp09iW5IIaTkFq92eqNN+eR6FuTB/ex+0pSg9hZrz6RvL9r0oheYtd7gWv03GakCUTkjBkJI8l83Rp7Fy8P60pNgkkInfdxGimfcvRYSfKGQlLapEXIkbG/d82gqi4WNezBqr1Zw4c2qGo1J56Ajfy+AZJboNt1Kru1R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=OnS2C3Km; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=hSLtiTIiCNJTyr3xi8Yb+ruteNAhZ9d/QH5koXbDAj8=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756745480; v=1; x=1757177480;
 b=OnS2C3KmkfoSYj+OhilW+A5Gqp/Rv6a9/KMmyt2D0o6uz+DCyEStf8R4sbhvF3I3jpg2gYML
 J+v/GFM1eCyCAeFZiYm2qgrBcTM0AvucIncF12kXgtUQ9UMfeVHvTzWuYc/BJUiR/3xD+xiriIN
 vcJYbZ6H6EdG6lMjN0gTyTm2kHHfwsUztAm80aKzsUdZg0kULB4fxqA//pgjaXkqBYP15kZ8x1H
 9Fk+pmLd+Mocx02p2jt5Ea2EHppZNQZXW0HovsB6cWZdT4d6GnJJw6xGdQtIcJBWFmxZqXmwTVD
 U6dY2VdAytiEccUifZPpqaXYqlUENxExN8AEUfkL9uJ9Q==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id f57fd90c; Mon, 01 Sep 2025 18:51:20 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Mon, 01 Sep 2025 18:51:19 +0200
Message-ID: <3031049.e9J7NaK4W3@radijator>
In-Reply-To: <aLW9O1rnhUqqh02r@smile.fi.intel.com>
References:
 <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
 <aLW9O1rnhUqqh02r@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 1 September 2025 17:35:23 Central European Summer Time Andy Shev=
chenko wrote:
> On Sun, Aug 31, 2025 at 12:33:05PM +0200, Duje Mihanovi=C4=87 wrote:
> > +static const struct regmap_config pm886_gpadc_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D PM886_REG_GPADC_VBAT_SLP + 1,
>=20
> What is this + 1 register? Why is it not defined / documented?

It is the second field of the vbat_slp channel.

> > +static int
> > +gpadc_get_resistance_ohm(struct iio_dev *iio, struct iio_chan_spec con=
st
> > *chan) +{
> > +	struct pm886_gpadc *gpadc =3D iio_priv(iio);
> > +	unsigned int raw_uv, raw_ua;
> > +	int ret;
> > +
> > +	ret =3D gpadc_set_bias(gpadc, chan->channel, true);
> > +	if (ret)
> > +		goto err;
> > +
> > +	ret =3D gpadc_find_bias_current(iio, chan, &raw_uv, &raw_ua);
> > +	if (ret)
> > +		goto err;
> > +
> > +	ret =3D gpadc_set_bias(gpadc, chan->channel, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return DIV_ROUND_CLOSEST(raw_uv, raw_ua);
> > +err:
> > +	gpadc_set_bias(gpadc, chan->channel, false);
>=20
> You do the same in the other branch and checking there for an error. Why =
this
> one is so special?

My rationale here was to not override the error from either the first
gpadc_set_bias() call or the subsequent gpadc_find_bias_current() call.

> > +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
>=20
> How is this useful? The userspace gets the same value. Do you expect prob=
lems
> on its way to the user space?

That's a leftover from debugging v1, will drop.

> > +	iio->dev.of_node =3D dev->parent->of_node;
>=20
> No, use device_set_node() with the respective parameters.
>=20
> But rather debug why firmware node (or OF in your case) is not propagated=
 from
> the parent device.

I guess it is because the IIO device is registered as a child of the
GPADC platform device, which does not have a node unlike the PMIC
device (GPADC pdev's parent). It seems that the regulator cell
registers its regulators directly under the PMIC dev, so maybe I should
do the same here with the IIO dev?

Regards,
=2D-
Duje



