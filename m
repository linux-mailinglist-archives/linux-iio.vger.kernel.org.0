Return-Path: <linux-iio+bounces-24164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA740B59A51
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6431B22500
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450C324B1E;
	Tue, 16 Sep 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VMcZpzKY"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BC286890;
	Tue, 16 Sep 2025 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032856; cv=none; b=LJZbui2mANKFouq6fBZhB8W7OoP6D8/nnGjiJ4POMLUJkauP4/rPTKMHwmDtFfZFXkmm2Bz8tWiL2+rc0Mkr/kisF9oLnfHS4lza3NVnxFlPWVMEJE9XPgM7hBv4EmWmXQfkIMq4B7y4FZP03DdHr1zZ6a60/No0yPgx9C2BOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032856; c=relaxed/simple;
	bh=f8t73w3AtLY7hnhFS/dR1I/Uz6Yqv3oI3PWml5zdfPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LW+AaafmgsdNjPSPp1LU28ukcY2R28c5P5Ns+pwDIJ6WKVbrzd7wotADj6pffi8cy6Wb+v1+FaXkznCNfWZ5kQliWu1iKZE6kiGEaTHu7bxhVg83E4aY9olv/Rl+PDjPVNanDkCQReHG6VGoNJjOgMtkyIKRMndsVIp+deGMrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VMcZpzKY; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0112443B69;
	Tue, 16 Sep 2025 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758032846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATSeLNX+owPZ3aCBXlyQeAZTuD9FLYcDCEAlmuoDnYg=;
	b=VMcZpzKYgJxyHzS9TlLOGlGOWZAuukPoVdElAz/IsHnkD28ri0z6Dl26f6yEcm03LoIXmc
	0zQC8uhQcQaI/cV7DPVFX/wurMAqa84y+MWubHU1UbGR1oB+/hT/cMQQjXkdvBLtqLC7kK
	SSiaJdrmQpgtN7fUNoDNzUDZEXV/VaXPktqIgDUlRv4pK8DMqxLpeQ/Y8QuiBsI93dvvs2
	ZUf05fY1fUQFq/egHXBWK/ZT7InJ8j4Xl3ahtL7wgr17rmFCulWfvB3ULz3FWNUNtWVEpF
	3R3BK3IxOzRI4i+J06yX0dBF4HYjUWwDBnidKqAorSphdBrqwgy7tQo0AH80Ig==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject:
 Re: [PATCH 4/4] regulator: ltm8054: Support output current limit control
Date: Tue, 16 Sep 2025 16:27:25 +0200
Message-ID: <8772650.T7Z3S40VBb@fw-rgant>
In-Reply-To: <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
 <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10916593.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhri
 ihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart10916593.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Tue, 16 Sep 2025 16:27:25 +0200
Message-ID: <8772650.T7Z3S40VBb@fw-rgant>
In-Reply-To: <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
MIME-Version: 1.0

On Tuesday, 16 September 2025 15:19:16 CEST Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:
> > The LTM8054 supports setting a fixed output current limit using a sense
> > resistor connected to a dedicated pin. This limit can then be lowered
> > dynamically by varying the voltage level of the CTL pin.
> > 
> > Support controlling the LTM8054's output current limit.
> 
> ...
> 
> > in microvolts
> 
> Yeah, using _mV postfix will make it visible that those are in micro-Volts.
> 
> ...
> 
> > +static int ltm8054_set_current_limit(struct regulator_dev *rdev, int
> > min_uA, int max_uA) +{
> > +	struct ltm8054_priv *priv = rdev_get_drvdata(rdev);
> > +	u64 vdac_uV;
> > +
> > +	min_uA = clamp_t(int, min_uA, priv->min_uA, priv->max_uA);
> > +
> > +	/* adjusted current limit = Rsense current limit * CTL pin voltage / 
max
> > CTL pin voltage */ +	vdac_uV = (u64)min_uA * LTM8054_MAX_CTL_V;
> > +	do_div(vdac_uV, priv->max_uA);
> > +
> > +	dev_dbg(&rdev->dev,
> > +		"Setting current limit to %duA, CTL pin to %duV\n", min_uA,
> > (int)vdac_uV);
> Why casting?
> 

This one is indeed unnecessary.

> > +	/* Standard IIO voltage unit is mV, scale accordingly. */
> > +	return iio_write_channel_processed_scale(priv->ctl_dac, vdac_uV, 
1000);
> > +}
> 
> ...
> 
> > +	ret = of_property_read_u32(np, "lltc,iout-rsense-micro-ohms", 
&rsense);
> 
> device_property_read_u32()
> 
> > +	if (ret < 0) {
> 
> Be consistent with a style, in the previous patch it was 'if (ret)'.
> 
> > +		dev_err(dev, "failed to get sense resistor value\n");
> > +		return ret;
> > +	}
> > +
> > +	if (rsense == 0) {
> > +		dev_err(dev, "invalid value zero for sense resistor\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* The maximum output current limit is the one set by the Rsense
> > resistor */ +	tmp = 1000000 * (u64)LTM8054_VOUT_IOUT_MAX;
> 
> Yo may use MICRO and drop the casting.
> 
> > +	do_div(tmp, rsense);
> > +	priv->max_uA = tmp;
> > +
> > +	/* Applying a voltage below LTM8054_MAX_CTL_V on the CTL pin reduces
> > +	 * the output current limit. If this level drops below
> > +	 * LTM8054_MIN_CTL_V the regulator stops switching
> > +	 */
> 
> /*
>  * Besides missing period at the end this is not correct multi-line style of
> * the comments. Use this example.
>  */
> 
> > +	tmp = LTM8054_MIN_CTL_V * (u64)priv->max_uA;

This cast avoids an overflow of the multiplication, since the result may 
easily exceed 32 bytes in size.

> > +	do_div(tmp, (u32)LTM8054_MAX_CTL_V);
> 
> Why casting?

Since do_div() is a macro, I casted the second argument just to be safe, but 
it seems that do_div() already does this internally, so I'll just drop the 
cast.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart10916593.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjJc80ACgkQKCYAIARz
eA61ExAAm6vav4r+FXBHUpKS9vLntfh3NIx00BPF8pPYQM4zEuaYCvc4VPq36Tja
07CMt07iGbiwm1UwYvq2hh6CBsihK8ZhvmbfxPNx9ZnnFSPHFXOjctiYSIOg5uXK
gStU0vgpTaxafCo6lL0fAJs0wy2655wECGHinA8wTRW5pfjv/JIy4DL8+8MVSjjF
k4XLlJ37mlN9EF62UneaP9mifiwYS82nZa8odsz4H36nker8tUGWD+981hs0SvzV
e/HKkETrnf7Zm+CPnNcQYMbxn9jRn0nAk+35IS0EBuIiS1ddqmp4EU9MFpBRCrQ5
MPYX9ymanXy5TgoJxz0nA/f2V1vyd09+UPZ8nhGbrsWrkxwpc+5mhhrbPdBMoy6E
YGMNnU1zdHnDCGYGQSb4ck+4Bv/isJxOfW07MrBGohlQNIF7JS6Nz4rlRQlF7LAi
oBqZXHkoR4J46QTxguF2NEYe7BKiUyFaIzUjh6+LS2zw09ExCcHbCAhArrZ5FXx7
XWXD9N18QFSB+67dl70HaLrjKQ4EYtL1iT5NYR2mrBal08g3ycFtVkn9o+TfvHjT
gtIZzktI0gG1BK4+oyOFggIpXg3CgDgNvEgDDliyMnP1OLE5m7EMPs3Wyqknn1uQ
Apw1euRSOig2b/kWCCaoBnIfDOrku1U9WjkNBHxy9nEhEJSziF8=
=HfwT
-----END PGP SIGNATURE-----

--nextPart10916593.nUPlyArG6x--




