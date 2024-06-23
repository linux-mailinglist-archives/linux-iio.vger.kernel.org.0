Return-Path: <linux-iio+bounces-6760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC7913BF2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B721F227FE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED4181CE2;
	Sun, 23 Jun 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM8RZV7L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD190146D43;
	Sun, 23 Jun 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155517; cv=none; b=lWtu5JKBJSCqEqvYyuhTs7vV2VXRK1f/t8I7uN6XOQ6riXM9AWUwSKChf5vvy7YZmbL/kvRgwBlvkHg+DB05xZdOHOA4D35icawNPt1VR2+V48lH3p5uwHFmCf4sYVVNFKJd9h5BIFz/PiXLQJoY4xVPfiXwLESBR3SFzkj4D/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155517; c=relaxed/simple;
	bh=vxBw92hdsdjcJ6MIC4h3wkF8DlA3K4aQX5p8h7JW5wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWOkxIwpEZo3IYuhzKVAdOcCzqjhh05K48xjjw0dmgu362rWm0Kq89q4YlKKHqIHFnsYlMKO73r22wohuwzDJtlDT0zZr2W8src6sVe4zg8Ub/9Uu2Hyhd8DnpE5M08BoTTwxOysyU5yyYBh0EOu/pu/w3mvzcue8ZwrS7p5KgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM8RZV7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4035C2BD10;
	Sun, 23 Jun 2024 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719155517;
	bh=vxBw92hdsdjcJ6MIC4h3wkF8DlA3K4aQX5p8h7JW5wg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SM8RZV7LC4myoJWnqgrixRsjAZg+EemdVy/Oe2CCjtVEYim61SbwTKwILfuGEmboR
	 Y0R6D4mOpJKQzQ/zR7bP1Ncab4dslJjYRIOnJmfdWKaXaCf2Ws2cPnOBPo23UHQAcK
	 RVanFuFZ/iwRdul9Uy3WQqmuyUYxkfx98glpMHvDM2wMrTWOOGi2jt6RPikLMz5wi5
	 gw8Q5iJp1fDnJEcBoe75J78kmP5hvtvUpSubpSnZobMAtdIW0iWegHfsGrLeFRnJDP
	 J85/b80OQ79q2cKCnx6POQl/sYdT4G0h1oV+jTwMiV3XAGgMKFHuKUFXcortltbREK
	 2YiLsu0m1v3Kw==
Date: Sun, 23 Jun 2024 16:11:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
Message-ID: <20240623161150.358f95bf@jic23-huawei>
In-Reply-To: <20240618160836.945242-8-olivier.moysan@foss.st.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-8-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 18:08:33 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add a generic driver to support sigma delta modulators.
> Typically, this device is a hardware connected to an IIO device
> in charge of the conversion. The device is exposed as an IIO backend
> device. This backend device and the associated conversion device
> can be seen as an aggregate device from IIO framework.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Trivial comments inline.

> diff --git a/drivers/iio/adc/sd_adc_backend.c b/drivers/iio/adc/sd_adc_backend.c
> new file mode 100644
> index 000000000000..556a49dc537b
> --- /dev/null
> +++ b/drivers/iio/adc/sd_adc_backend.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generic sigma delta modulator IIO backend
> + *
> + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
> + */
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +struct iio_sd_backend_priv {
> +	struct regulator *vref;
> +	int vref_mv;
> +};
> +
> +static int sd_backend_enable(struct iio_backend *backend)
> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	return regulator_enable(priv->vref);
> +};
> +
> +static void sd_backend_disable(struct iio_backend *backend)
> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	regulator_disable(priv->vref);
> +};
> +
> +static int sd_backend_read(struct iio_backend *backend, int *val, int *val2, long mask)
Nothing to do with this patch as such:

One day I'm going to bit the bullet and fix that naming.
Long long ago when the Earth was young it actually was a bitmap which
I miscalled a mask - it only had one bit ever set, which was a dumb
bit of API.  It's not been true for a long time.
Anyhow, one more instances isn't too much of a problem I guess.

> +{
> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = priv->vref_mv;

This doesn't really feel right as what are we calling to?  Using it to pass the
reference voltage doesn't make sense under normal handling of these.  So at very
least needs a comment.


> +		*val2 = 0;
No need to set val2.
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;
> +		*val2 = 0;
> +		return IIO_VAL_INT;
Normally we just don't provide this but I guess you are requiring all of these?
Long term that won't scale, so you need your caller to handle a suitable
error return, -EINVAL will work to say not supported.

> +	}
> +
> +	return -EINVAL;
> +};
> +
> +static const struct iio_backend_ops sd_backend_ops = {
> +	.enable = sd_backend_enable,
> +	.disable = sd_backend_disable,
> +	.read_raw = sd_backend_read,
> +};
> +
> +static int iio_sd_backend_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regulator *vref;
> +	struct iio_sd_backend_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	vref = devm_regulator_get_optional(dev, "vref");

New devm_regulator_get_enable_read_voltage() slightly simplifies this
and means you don't need to keep vref around.

> +	if (IS_ERR(vref)) {
> +		if (PTR_ERR(vref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
> +	} else {
> +		ret = regulator_get_voltage(vref);
You haven't turned it on so it's not guaranteed to give you a useful
answer.

Use the enable_read_voltage variant and that will handle this for you.

> +		if (ret < 0)
> +			return ret;
> +
> +		priv->vref = vref;
> +		priv->vref_mv = ret / 1000;
> +	}
> +
> +	ret = devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return devm_iio_....

> +};
> +
> +static const struct of_device_id sd_backend_of_match[] = {
> +	{ .compatible = "sd-backend" },
> +	{ .compatible = "ads1201" },

Conor pointed out ti,ads1201
At least I assume ti?

> +	{ }
> +};


