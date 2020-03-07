Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F59A17CEE7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGPFT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGPFT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:05:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B7520674;
        Sat,  7 Mar 2020 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583593517;
        bh=djr7N1lF/PKKB9fp2i9gvINm+MJ4rxqV23JMIjkYYO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cXxT45a+XI3Vfb7mfPiLj/VSNIUGTATR6o2olTOpEYHMESm+uplmvaD3R9b4Hu014
         zMd2kmTkt0FQ6WlBTv2HZUX5YUnhTvTwx+CnEY9VBgJhCDShl2JqAYFZUeZewlS7Lz
         8xZk7QeEI0HSkcaGmZN3UNPQx7BQ0EB2N/mzKvQE=
Date:   Sat, 7 Mar 2020 15:05:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v8 7/8] iio: adc: ad9467: add support AD9467 ADC
Message-ID: <20200307150513.053b198a@archlinux>
In-Reply-To: <20200306110100.22092-8-alexandru.ardelean@analog.com>
References: <20200306110100.22092-1-alexandru.ardelean@analog.com>
        <20200306110100.22092-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 13:00:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital converter
> (ADC). It is optimized for high performanceover wide bandwidths and ease of
> use. The product operates at a 250 MSPS conversion rate and is designed for
> wireless receivers, instrumentation, and test equipment that require a high
> dynamic range. The ADC requires 1.8 V and 3.3 V power supplies and a low
> voltage differential input clock for full performance operation. No
> external reference or driver components are required for many applications.
> Data outputs are LVDS compatible (ANSI-644 compatible) and include the
> means to reduce the overall current needed for short trace distances.
> 
> Since the chip can operate at such high sample-rates (much higher than
> classical interfaces), it requires that a DMA controller be used to
> interface directly to the chip and push data into memory.
> Typically, the AXI ADC IP core is used to interface with it.
> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

A few minor things but otherwise looks good to me..

> ---
>  drivers/iio/adc/Kconfig  |  15 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad9467.c | 432 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
>  create mode 100644 drivers/iio/adc/ad9467.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 445070abf376..a0796510f9d4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -246,6 +246,21 @@ config AD799X
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad799x.
>  
...
> +static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> +{
> +	unsigned char buf[3];
> +	int ret;
> +
> +	buf[0] = 0x80 | (reg >> 8);
> +	buf[1] = reg & 0xFF;
> +
> +	ret = spi_write_then_read(spi, &buf[0], 2, &buf[2], 1);

Why not split buf into send part and receive?  Might make it slightly
more readable for no actual cost..

> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return buf[2];
> +}
...

> +static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	const struct adi_axi_adc_chip_info *info = conv->chip_info;
> +	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
> +	unsigned long r_clk;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad9467_set_scale(conv, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!st->clk)
> +			return -ENODEV;
> +
> +		if (chan->extend_name)

This is a very 'odd' test.  Why?

> +			return -ENODEV;
> +
> +		r_clk = clk_round_rate(st->clk, val);
> +		if (r_clk < 0 || r_clk > info->max_rate) {
> +			dev_warn(&st->spi->dev,
> +				 "Error setting ADC sample rate %ld", r_clk);
> +			return -EINVAL;
> +		}
> +
> +		return clk_set_rate(st->clk, r_clk);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
...
> +static int ad9467_probe(struct spi_device *spi)
> +{
> +	const struct of_device_id *oid;
> +	struct adi_axi_adc_conv *conv;
> +	struct ad9467_state *st;
> +	unsigned int id;
> +	int ret;
> +
> +	if (!spi->dev.of_node) {
> +		dev_err(&spi->dev, "DT node is null\n");
> +		return -ENODEV;

Silly question for you.  Can this happen?  We can only probe this
if it is in DT and hence there must be a node to get here I think.

> +	}
> +
> +	oid = of_match_node(ad9467_of_match, spi->dev.of_node);
> +	if (!oid)
> +		return -ENODEV;

You only ever want the data field so you can get that directly.
of_device_get_match_data

> +
> +	conv = devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
> +	if (IS_ERR(conv))
> +		return PTR_ERR(conv);
> +
> +	st = adi_axi_adc_conv_priv(conv);
> +	st->spi = spi;
> +
> +	st->clk = devm_clk_get(&spi->dev, "adc-clk");
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +
> +	ret = clk_prepare_enable(st->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pwrdown_gpio))
> +		return PTR_ERR(st->pwrdown_gpio);
> +
> +	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return PTR_ERR(st->reset_gpio);
> +
> +	if (st->reset_gpio) {
> +		udelay(1);
> +		ret = gpiod_direction_output(st->reset_gpio, 1);
> +		mdelay(10);
> +	}
> +
> +	spi_set_drvdata(spi, st);
> +
> +	id = (unsigned int)oid->data;
> +	conv->chip_info = &ad9467_chip_info_tbl[id];
> +
> +	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
> +	if (id != conv->chip_info->id) {
> +		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +		return -ENODEV;
> +	}
> +
> +	conv->reg_access = ad9467_reg_access;
> +	conv->write_raw = ad9467_write_raw;
> +	conv->read_raw = ad9467_read_raw;
> +	conv->preenable_setup = ad9467_preenable_setup;
> +
> +	return ad9467_setup(st, id);
> +}
> +
> +static struct spi_driver ad9467_driver = {
> +	.driver = {
> +		.name = "ad9467",
> +		.of_match_table = ad9467_of_match,
> +	},
> +	.probe = ad9467_probe,
> +};
> +module_spi_driver(ad9467_driver);
> +
> +MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
> +MODULE_LICENSE("GPL v2");

