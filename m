Return-Path: <linux-iio+bounces-24163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493F7B599CA
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1566E4848B2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73F3451AE;
	Tue, 16 Sep 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CoZRBpV1"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35C32BF49;
	Tue, 16 Sep 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032293; cv=none; b=h5VpEIfTznLILgslURnra10OBcrFGbwugfrONAYwzKJj1inGSWakd+XhuNZL+ainYg91HvUDDfjB3QUhD2dXNZZFvHMahkMYFUu7ww264A6ggbkqkkepApHo0GrUff2X15pjY8BTBo8OVrfsBYPWg1kfI3+4p9LgKNb/Lip0Uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032293; c=relaxed/simple;
	bh=H8Rb98E2rtPtyhu6K4jBPQ4alyqMOlOQbUmmuOscUTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8X6VDxGN6pGsTD/xjrN6NLE+SOrCNXKoEY+Zj4+BHUCtB/rqgC4Sf6cbf3EYHL6xBt0uuAof1cp2wdOqKpr7b1wTgtYJzgO/B4jIm9BqHn4Dfpj2a8R6ehhH97Nk4RDktAPC8K7TnWpz01hwiTikVK31juWnoq8brWyqHXd0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CoZRBpV1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBE2A443A7;
	Tue, 16 Sep 2025 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758032282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2j1hmxIGF4hO9/n/aWGAdFU9mRdFdKJE8K3RYi8PkRw=;
	b=CoZRBpV1lE3fjDQ7wLif08cnDZ8bYy299JVw21zq2MqHR6aMV5RbDRFLiakgXh8QvJjsEy
	1ajXmuoEECHgaLx3yDWBNX5r7rcVNdjMKqbQn6ODPUxaxsY43O89J+pOHBukUbfOkWLl0v
	xJDvZNdj/k8rS7JxiKKVOCUfWR1jUBaU1UCVIzPgYshIyGbQgAj0VyhQzruACzMHj6KRRY
	gzJLaJtvwRaMul1KUJfTvU7eNRDg+QaEGvARJfFl4McU3CCYUxBrvY6wUis3SV/SOcQHQy
	AammSzjTyeHk1NC2O5XRwfX9awGuPPfMu/1T9Afz8ZxqOXRaUbW7NkIC5xPqCQ==
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
Subject: Re: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Date: Tue, 16 Sep 2025 16:17:56 +0200
Message-ID: <5205519.GXAFRqVoOG@fw-rgant>
In-Reply-To: <aMliRTuUDNPkeM8C@smile.fi.intel.com>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-3-fd4e781d33b9@bootlin.com>
 <aMliRTuUDNPkeM8C@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2126663.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhri
 ihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart2126663.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Date: Tue, 16 Sep 2025 16:17:56 +0200
Message-ID: <5205519.GXAFRqVoOG@fw-rgant>
In-Reply-To: <aMliRTuUDNPkeM8C@smile.fi.intel.com>
MIME-Version: 1.0

Hello Andy,

On Tuesday, 16 September 2025 15:12:37 CEST Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:
> > Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
> > regulator. This version only supports enabling/disabling the regulator via
> > a GPIO, and reporting the output voltage level from the resistor divider
> > values given in the device tree.
> 
> ...
> 
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> 
> I think we have already something agnostic in regulator API to get a
> regulator from a firmware node (rather than from specific OF/etc one).
> 

IIRC the "of_match" regulator descriptor property can be used for this, I'll 
have a second look and see if I can use that instead.

> > +#include <linux/mod_devicetable.h>
> > +#include <linux/regulator/driver.h>
> > +#include <linux/regulator/of_regulator.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio/consumer.h>
> 
> Can you keep it ordered? This way it's easy to maintain and avoid potential
> duplication (note, there are also many headers are missing here, but Mark
> usually not insisting in following IWYU principle [1])
> 
> ...

I usually also try to follow IWYU for header inclusions so I'll look for those 
that I missed.

> 
> > +/* The LTM8054 regulates its FB pin to 1.2V */
> > +#define LTM8054_FB_V 1200000
> 
> It's actually _mV
> 
> #define LTM8054_FB_mV	1200000
> 
> ...
> 
> > +static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
> > +{
> > +	u64 tmp;
> > +
> > +	tmp = (u64)uV * r1;
> > +	do_div(tmp, r2);
> > +
> > +	return uV + (unsigned int)tmp;
> 
> Why one needs a casting here?
> 

Both of those are unsigned so the cast here is indeed unnecessary.

> > +}
> 
> ...
> 
> > +static const struct regulator_ops ltm8054_regulator_ops = {
> > +};
> 
> Why it can be simply as
> 
> static const struct regulator_ops ltm8054_regulator_ops;
> 

Yeah, this was mostly to have a clean diff on patch 4/4, I'll see if I can drop 
this struct and introduce it in patch 4/4. I wouldn't want to use it 
uninitialized though.

> ...
> 
> > +static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv
> > *priv,
> > +			    struct regulator_config *config)
> > +{
> > +	struct device_node *np = dev->of_node;
> > +	u32 r[2];
> > +	int ret;
> > +
> > +	config->of_node = np;
> > +
> > +	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);
> 
> device_property_read_u32_array() ?
> 
> ARRAY_SIZE() instead of 2
> 

Yes, indeed.

> > +	if (ret) {
> > +		dev_err(dev, "Failed to parse voltage divider\n");
> > +		return ret;
> > +	}
> > +
> > +	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_V, r[0], r[1]);
> > +	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
> > +	priv->rdesc.n_voltages = 1;
> > +
> > +	config->init_data = of_get_regulator_init_data(dev,
> > +						       np,
> > +						       &priv->rdesc);
> > +	if (!config->init_data) {
> > +		dev_err(dev, "failed to parse init data\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	config->ena_gpiod = devm_gpiod_get_optional(dev, "enable",
> > GPIOD_OUT_LOW); +	if (IS_ERR(config->ena_gpiod)) {
> > +		dev_err(dev, "unable to acquire enable gpio\n");
> > +		return PTR_ERR(config->ena_gpiod);
> 
> All messages in cases of EPROBE_DEFER are problematic (for sure with GPIO),
> as it may well flood the logs.
> Solution: Use
> 
> 		return dev_err_probe(...);
> 
> pattern instead,
> 

Yes, I used that in the caller function but it doesn't solve the flooding 
issue, so I'll move dev_err_probe() to this function instead.

> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ltm8054_probe(struct platform_device *pdev)
> > +{
> > +	struct regulator_config config = { 0 };
> 
> '0' is not required. The { } will have the same effect.
> 
> > +	struct regulator_dev *rdev;
> > +	struct ltm8054_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->rdesc.name = "ltm8054-regulator",
> > +	priv->rdesc.ops = &ltm8054_regulator_ops,
> > +	priv->rdesc.type = REGULATOR_VOLTAGE,
> > +	priv->rdesc.owner = THIS_MODULE,
> > +
> > +	config.dev = &pdev->dev;
> > +	config.driver_data = priv;
> > +
> > +	ret = ltm8054_of_parse(&pdev->dev, priv, &config);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to parse device 
tree\n");
> > +
> > +	rdev = devm_regulator_register(&pdev->dev, &priv->rdesc, &config);
> > +	if (IS_ERR(rdev))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rdev), "failed to 
register
> > regulator\n");
> Using
> 
> 	struct device *dev = &pdev->dev;
> 
> at the top will allow to make a few lines shorter.
> 
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id __maybe_unused ltm8054_of_match[] = {
> > +	{ .compatible = "lltc,ltm8054", },
> 
> Inner comma is not required.
> 
> > +	{},
> 
> Drop the trailing comma here as it's a terminator entry. The absence of it
> will give a hint to the compiler as well.
> 
> > +};
> 
> ...
> 
> > +static struct platform_driver ltm8054_driver = {
> > +	.probe = ltm8054_probe,
> > +	.driver = {
> > +		.name  = "ltm8054",
> > +		.of_match_table = of_match_ptr(ltm8054_of_match),
> 
> Please, do not use of_match_ptr() and/or ACPI_PTR() in a new code.
> 
> > +	},
> > +};
> > 
> > +
> 
> Unneeded blank line.
> 
> > +module_platform_driver(ltm8054_driver);

Thanks for the review,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2126663.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjJcZQACgkQKCYAIARz
eA5Khw//c1k6fB3U502IZwnnjh78xj8uyZ1NRVUsbK+9HRE4tTIjvBb047bojlII
frNF2+b4IBzZZqc5UiB2hT1rcwoyD9kn6K9O1MhyLj4XgL/IXdfpWS2D3H0vaLG0
y1/33JkVf/zClnhQKOZ8et81MfnAhM0UCbDRDYXgS3TkwbBfvQaHWD/Ena+KzZRm
WsNCRYGdRPRTIAheo2uJW8Ix1KzFcFcVxLoJY2gAIknT1JENZk9g8q503zQE9+og
QU0t3wGFtggrG/pD4d9wYsE434dCSWxWfvDZw35590NSN4tCSZxwDeT1CmGnTNDU
oIqPlefXvpTx3Y2oH3bg+fSVju6BFwsJ0jMo2AZR05YuEelPARUcp8EIStkxYKl4
YS8B+hazn/FNb+GL1+CItBw/IHCB5ZHRu35O6315aZolC0kN2xG1w3pPUuGkXRR1
vlHxvLe3dhLe8LoAkNzoBAVlUKyTb8VXeI0xMdCQsg2b+e2gQ/17w8jSjZhXAI9c
tQrvSabh5flz/Rtth7RHxTDtdPvzu9S/+dzEYPzcoWAHpaKbrnF/oFjU5P6oVcxs
OrGviRYz6TTr38lZFABJj25+X+ghsgqJdUThlRQwg7s7fndB2YrHSG2tpkwaYMBf
8gz4F37Tw9ah1J/zELEhvTT+Xnrn3AUbTTjVKPx3MSGs1ZlUATM=
=onhE
-----END PGP SIGNATURE-----

--nextPart2126663.tdWV9SEqCh--




