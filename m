Return-Path: <linux-iio+bounces-22040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0FB12F7F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3527E189932D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FA20E715;
	Sun, 27 Jul 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLlAODLZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D311185;
	Sun, 27 Jul 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619941; cv=none; b=o4KBinVbEwB1LEEC9rbdpmYYgMQluvi2oMjASJGGFUCKEKywY9DOUGIU1ZxUFJvXzd9vNBsmQbsuwieIl9zQhy4SvpTbIkXnnuPABDgpIH9TiYDsvrtIUETJaTXLAhdKltxU1JcaqQ7+pmunEB2nItnib1cspm7rJ2ipXzRQLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619941; c=relaxed/simple;
	bh=MPSvtbN2ilbvB5I0EgZ3fLGSEXKs2+UCHriQ9BvyDws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWqerGpEYJQ5x4kvVJnQ2xZi6ZwxPw0kch4162bKQPwuYYaRXXF/mH7pNWj0P2mOBOLFHWXP2jAQgH72SYnJ1XMv3WDb+K39YZ1af0rpayCfX9sDyybWByyalgfiL/coQvtEVrGZBRBTc9CLQu9hBRb+enu/NhcpCGr/0OAgXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLlAODLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78AAC4CEEB;
	Sun, 27 Jul 2025 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619940;
	bh=MPSvtbN2ilbvB5I0EgZ3fLGSEXKs2+UCHriQ9BvyDws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uLlAODLZ8pZ5JsUpEq6gFUcTlOAwDtwesnCcXkUFon/IKNHIASAwKuPY9uigzBNX1
	 Gh057OXyraP0PAOMrtTGDUh940Az+rSCovz+4SQ+DN13kXDgnhNFK3kjZcHzItD3g4
	 aynjbgFhVpSTEc0EvnhD07m+IWH6NZTyVnQQ1mYMMbCR4zvPecq6khkAVkfRtWlYvz
	 U9TFo/Bid/vewm0Z3w0OeVLBqPA8IXZLcSoNsjVa5Mc/i8+DPa/s89I+qUkl+IYDaZ
	 rXvQeTAre115ToPzFZ6bUcGf8Smkhl1a+xf9eayKQe4OMtsA6CyOl4YkVg3KHTvGEW
	 laUQmT9RnWPQg==
Date: Sun, 27 Jul 2025 13:38:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <20250727133852.371111bc@jic23-huawei>
In-Reply-To: <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
	<20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
	<141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Jul 2025 15:44:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/26/25 4:37 AM, Dixit Parmar wrote:
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> >=20
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measuremen=
t.
> >=20
> > The driver supports raw value read and buffered input via external trig=
ger
> > to allow streaming values with the same sensing timestamp.
> >=20
> > The device can be configured in to different operating modes by optional
> > device-tree "mode" property. Also, the temperature sensing part requires
> > raw offset captured at 25=C2=B0C and that can be specified by "temp-off=
set"
> > optional device-tree property.
> >=20
> > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> > configurations interrupt(INT) is not recommended, unless timing constra=
ints
> > between I2C data transfers and interrupt pulses are monitored and align=
ed.
> >=20
> > The Sensor's I2C register map and mode information is described in prod=
uct
> > User Manual[1].
> >=20
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/i=
nfineon-tlv493d-a1b6-datasheet-en.pdf
> > [1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-Use=
rManual-v01_03-EN.pdf
> >=20
> > Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

> > +static const struct regmap_config tlv493d_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D TLV493D_RD_REG_RES3,
> > +	.volatile_table =3D &tlv493d_volatile_regs,
> > +};
> > +
> > +static int tlv493d_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct tlv493d_data *data;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data =3D iio_priv(indio_dev);
> > +	data->dev =3D dev;
> > +	data->client =3D client;
> > +	i2c_set_clientdata(client, indio_dev); =20
>=20
> There is not i2c_get_clientdata(), so I don't think we need this.
There's a dev_get_drvdata() that pairs with this in suspend and resume.

I kind of wish the bus specific accessor would go away but there
is too much history behind them :(

> > +static int tlv493d_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct tlv493d_data *data =3D iio_priv(indio_dev);
> > +
> > +	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
> > +}
> > +
> > +static int tlv493d_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct tlv493d_data *data =3D iio_priv(indio_dev);
> > +
> > +	return tlv493d_set_operating_mode(data, data->mode);
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > +		tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
> > +
> > +static const struct i2c_device_id tlv493d_id[] =3D {
> > +	{ "tlv493d" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tlv493d_id);
> > +
> > +static const struct of_device_id tlv493d_of_match[] =3D {
> > +	{ .compatible =3D "infineon,tlv493d-a1b6", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, tlv493d_of_match);
> > +
> > +static struct i2c_driver tlv493d_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "tlv493d",
> > +		.of_match_table =3D tlv493d_of_match,
> > +		.pm =3D pm_ptr(&tlv493d_pm_ops),
> > +	},
> > +	.probe =3D tlv493d_probe,
> > +	.id_table =3D tlv493d_id,
> > +};
> > +
> > +module_i2c_driver(tlv493d_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("Infineon TLV493D Low-Power 3D Magnetic Sensor");
> > +MODULE_AUTHOR("Dixit Parmar <dixitparmar19@gmail.com>");
> >  =20
>=20


