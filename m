Return-Path: <linux-iio+bounces-13637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E83A9F7B73
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28761894E91
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993B1225760;
	Thu, 19 Dec 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4REwsah"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272A222562;
	Thu, 19 Dec 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611691; cv=none; b=r+tSCz2aRKthAcUfgVLWRS0pHPqkc7iL+H8jwUN5HASbR6fzWern8Qup+92CM0RJfbyyVQIG7xYBLTLvrtHT7sxp6MrpaEL8WbJj81W28KxSNuiOCK1hmhKA11AXCZVjafoUIP03OCZpOljlnFwn1yXlThgGYJ3pqS8CLTPup0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611691; c=relaxed/simple;
	bh=jYQ9mxzRonfD2c8NKOCJ3WcAriGxXy6nnDjw2LZGfLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENk9iZty6OD8nTL5lIH5557MSJZldhlApnU+/9iP75LV5k/LA5xmEzFy+kn928ey5lLndWeT7Ggi5WDmRMHUMgdX8fDMXoDWtC8dhJZjkDYFLNeEEM6mNukdBerv6+oSMtzv2YWxWX2e7FNfYdrqMDMrfFE8eP+c2h7dzE/2w5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4REwsah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C10C4CECE;
	Thu, 19 Dec 2024 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734611690;
	bh=jYQ9mxzRonfD2c8NKOCJ3WcAriGxXy6nnDjw2LZGfLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4REwsahpLlsqbBKDV3/CR7U5PI6JkHmll0QAr9QOIQKCZZPUkfzkVdfjeIURKBjT
	 M22D7QeJDezbAMnhjhgRt4LQXZnbnfiUldgNLf9OpxY4kpdPzHXEL42LROIocllrzh
	 l622DHs04d9JVsCbL4SLzM3tF56EnA1c/w7IVMMHOwJMdJQitJsH/xA7RQ0DXTGpce
	 S/X6wKmFwMT2n+p4cBYqu4lAyZPT5j3T9ErQJCwWmlXO/l36z90sCDdAlel2KvDcvF
	 IWraGlCt7TzDKCoKfXD4141CZFsvIpEy3zZf3/6IoxtJN5WPBdj78yhU/mRQaAwX/j
	 HGQjMofMjY95g==
Date: Thu, 19 Dec 2024 12:34:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: dac: Support ROHM BD79703 DAC
Message-ID: <20241219123444.19bd1074@jic23-huawei>
In-Reply-To: <bc77d7b979ca28408a216f597082fcd94ec63be7.1734608215.git.mazziesaccount@gmail.com>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
	<bc77d7b979ca28408a216f597082fcd94ec63be7.1734608215.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 13:39:37 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79703 is a 6 channel digital to analog converter.
> 
> Based on the data-sheet examples the hardware would support setting the
> DAC word without changing the actual output. The data-sheet is not too
> specific on how the enabling the output of new voltage set by DAC
> should be done - hence this is not implemented by the driver.

I took a quick look and that does seem rather mysterious!
Normally there is either a 'sync' register or pin for setups like this
but no sign of either.  Maybe it's legacy from some other use of the
same silicon.

> 
> The BD79703 would also support two specific "PULL_DOWN" modes. These
> aren't currently supported by the driver either.
> 
> Add a very basic support for controlling the channel outputs one-by-one.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Short and sweet.  One totally trivial formatting thing I can fix whilst
applying and a passing comment below. will leave this a little while
to see what other feedback it gets and for DT folk to look at the binding.

Jonathan


> diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
> new file mode 100644
> index 000000000000..a3df31d81b7c
> --- /dev/null
> +++ b/drivers/iio/dac/rohm-bd79703.c
> @@ -0,0 +1,162 @@


> +
> +static int bd79703_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct bd79703_data *data;
> +	struct iio_dev *idev;
> +	int ret;
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(idev);
> +
> +	data->regmap = devm_regmap_init_spi(spi, &bd79703_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vfs");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get Vfs\n");
> +
> +	data->vfs = ret;
> +	idev->channels = bd79703_channels;
> +	idev->num_channels = ARRAY_SIZE(bd79703_channels);
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &bd79703_info;
> +	idev->name = "bd79703";
> +
> +	/* Initialize all to output zero */

I can't remember what we tend to do for defaults but I guess this
is safe enough. Alternative would be start the device with HI impedance
(power down state)

> +	ret = regmap_write(data->regmap, BD79703_REG_OUT_ALL, 0);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, idev);
> +}
> +
> +static const struct spi_device_id bd79703_id[] = {
> +	{ "bd79703", },
> +	{}
	{ }

Keep it consistent. This is the style I prefer though not sure I'll do
a full tidy up of this any time soon. 
> +};
> +MODULE_DEVICE_TABLE(spi, bd79703_id);
> +
> +static const struct of_device_id bd79703_of_match[] = {
> +	{ .compatible = "rohm,bd79703", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bd79703_of_match);



