Return-Path: <linux-iio+bounces-7862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E693B4AF
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D0B281BCC
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECDB15E5CE;
	Wed, 24 Jul 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzYZj7xP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF715DBD8;
	Wed, 24 Jul 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837701; cv=none; b=mQ90oTGSHCubdqS5JA/XA33sb+Inqf1FLe1p41LeXW28PVnVUkv3WkTPj1POqRr+b7Gwl+HhT7+vfkx+EZC9+Bp8hR0452O6mES/UdJxF4h2m5M2sMPHm1m4JJpO0mfYkodctZXKd/Nuk3DiG2ss9gBti5i7YaCwNfbuUJncW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837701; c=relaxed/simple;
	bh=mIAFeE22s1wAZ4s4OOp4YVKgQBAjBdOfdqtr1K3K/bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwfpFQ3Lq4U8oFVwE15+hvzz1gkZoxWIChUPAnQHYvc7YfbK/V5JaGxKFkIQ3pj8DH954t8nSRw0DzNndIsliykS1MpyYYQkhR7wmm7uUO6SOhH4KK1gwjZW10kqUKX+DRQYjOJsFvons/yJNPxOMwCfD77YokNllWNPB9miK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzYZj7xP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C66C32781;
	Wed, 24 Jul 2024 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721837701;
	bh=mIAFeE22s1wAZ4s4OOp4YVKgQBAjBdOfdqtr1K3K/bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IzYZj7xPFk/UIbRnOG94c10juzEns/eJDp9JEmE5j2TuzxaXFyi/Vp52/AZ8AgGF4
	 1+VX6AhIETDvAxvXEKPUP+mkMOYSg8JjfeowuU0wx342oLKHiwzQaRppKiOjuKq3R+
	 ZH2BmiKzDgxJj/PvNmBfkSber401AqouwNNozwcf8fEWs39HGu7x6/AsuRxCRkCzye
	 Sk8DwTYN6p+ibKmedRRjaSwZDiFs1gYYxQ1Avq/SAp7OK9xuN/u3AUp1D7o1qyVrj0
	 7y091T3PY9BG3ldzbVHfA2vizOU97hgd2z1tYYGAxs5+EecMCWHsWPUSOerPdIb28+
	 xK3R61Lt86Yxw==
Message-ID: <7d474c3d-22ed-45d5-8224-caaf124b72a0@kernel.org>
Date: Wed, 24 Jul 2024 18:14:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drivers: iio: adc: add support for ad777x family
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nuno Sa <nuno.sa@analog.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240724155517.12470-1-ramona.nechita@analog.com>
 <20240724155517.12470-5-ramona.nechita@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240724155517.12470-5-ramona.nechita@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2024 17:54, Ramona Alexandra Nechita wrote:
> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only theSDO data streaming mode. SPI
> communication is used alternatively foraccessingregisters and streaming

Typo, please run spell check.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

There is no "drivers".

> data. Register access are protected by crc8.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |  11 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7779.c | 952 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 964 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7779.c
> 

The driver has several trivial style issues. Please be sure such
trivialities are fixed. Get internal review on this. You do need to ask
community to tell you that you must run checkpatch. Or to tell them that
indentation/alignment is entirely broken. Grab some colleague of yours
and perform internal review first. This applies to entire Analog,
because there is increased amount of contributions from Analog and not
all of them look like passing basic sanity checks.

By sending code full of silly trivialities, community reviewers might
feel overwhelmed and quite grumpy.

> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +										  &iio_pollfunc_store_time,
> +										  &ad7779_trigger_handler,
> +										  &ad7779_buffer_setup_ops);

Sorry, tha's not a Linux coding style. Checkpatch will tell you that.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int __maybe_unused ad7779_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_LOW_POWER));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD7779_LOW_POWER;
> +	return 0;
> +}
> +
> +static int __maybe_unused ad7779_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_HIGH_POWER));
> +	if (ret)
> +		return ret;
> +
> +	st->power_mode = AD7779_HIGH_POWER;
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(ad7779_pm_ops, ad7779_suspend, ad7779_resume);
> +
> +static const struct ad7779_chip_info ad7770_chip_info = {
> +	.name = "ad7770",
> +	.channels = ad7779_channels,
> +};
> +
> +static const struct ad7779_chip_info ad7771_chip_info = {
> +	.name = "ad7771",
> +	.channels = ad7779_channels_filter,
> +};
> +
> +static const struct ad7779_chip_info AD7779_chip_info = {
> +	.name = "AD7779",

Hm...

> +	.channels = ad7779_channels,
> +};
> +
> +static const struct spi_device_id ad7779_id[] = {
> +	{
> +		.name = "ad7770",
> +		.driver_data = (kernel_ulong_t)&ad7770_chip_info
> +	},
> +	{
> +		.name = "ad7771",
> +		.driver_data = (kernel_ulong_t)&ad7771_chip_info
> +	},
> +	{
> +		.name = "AD7779",

Eh...

> +		.driver_data = (kernel_ulong_t)&AD7779_chip_info
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7779_id);
> +
> +static const struct of_device_id ad7779_of_table[] = {
> +	{
> +		.compatible = "adi,ad7770",
> +		.data = &ad7770_chip_info,
> +	},
> +	{
> +		.compatible = "adi,ad7771",
> +		.data = &ad7771_chip_info,
> +	},
> +	{
> +		.compatible = "adi,AD7779",

That's not a valid compatible. Only lower-case are allowed.

> +		.data = &AD7779_chip_info,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7779_of_table);
> +

Best regards,
Krzysztof


