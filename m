Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD349460027
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhK0QYC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhK0QWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BABC06173E;
        Sat, 27 Nov 2021 08:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BEC60EC0;
        Sat, 27 Nov 2021 16:18:47 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 20B5EC53FAD;
        Sat, 27 Nov 2021 16:18:43 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:23:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio:amplifiers:ad7293: add support for AD7293
Message-ID: <20211127162345.66f5526f@jic23-huawei>
In-Reply-To: <20211122133639.132972-1-antoniu.miclaus@analog.com>
References: <20211122133639.132972-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 15:36:38 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD7293 is a Power Amplifier drain current controller
> containing functionality for general-purpose monitoring
> and control of current, voltage, and temperature, integrated
> into a single chip solution with an SPI-compatible interface.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - move driver to DAC directory, as suggested
>  - use local variable `length` where FIELD_GET is used multiple times
>  - return `IIO_AVAIL_LIST` directly, instead of break
>  - reduce number of lines in the channel definitions section
>  drivers/iio/dac/Kconfig  |  11 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad7293.c | 892 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 904 insertions(+)
>  create mode 100644 drivers/iio/dac/ad7293.c
> 
New day, new things spotted, but they are all very minor so assuming
the dt patch gets a tag from Rob and no one else raises any concerns
I can tidy these up whilst applying.

Obviously if you do happen to do a v5 then handle these as well.


...

> +
> +static int ad7293_set_offset(struct ad7293_state *st, unsigned int ch, u16 offset)
> +{
> +	if (ch < AD7293_TSENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_VIN0_OFFSET + ch, offset);
> +	else if (ch < AD7293_ISENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_TSENSE_INT_OFFSET + (ch - AD7293_TSENSE_MIN_OFFSET_CH), offset);

These are 'very' long lines. I'll tweak this whilst applying if you don't end up doing a v5 for any other reason.


> +	else if (ch < AD7293_VOUT_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_ISENSE0_OFFSET + (ch - AD7293_ISENSE_MIN_OFFSET_CH), offset);
> +	else if (ch <= AD7293_VOUT_MAX_OFFSET_CH)
> +		return ad7293_spi_update_bits(st, AD7293_REG_UNI_VOUT0_OFFSET + (ch - AD7293_VOUT_MIN_OFFSET_CH),
> +						AD7293_REG_VOUT_OFFSET_MSK,
> +						FIELD_PREP(AD7293_REG_VOUT_OFFSET_MSK, offset));
> +
> +	return -EINVAL;
> +}
> +

...

> +
> +static int ad7293_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7293_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (!chan->output)
> +				return -EINVAL;
> +
> +			return ad7293_dac_write_raw(st, chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->output)
> +				return ad7293_set_offset(st, chan->channel + AD7293_VOUT_MIN_OFFSET_CH, val);

More long lines. I'll add some line breaks if I end up tidying this up whilst applying.
Ideally we should still stay under 80 chars where it doesn't hurt readability and under
100 in any case other than possibly a very long string that we don't want to break 
because it will make it hard to grep for.


> +			else
> +				return ad7293_set_offset(st, chan->channel, val);
> +		case IIO_CURRENT:
> +			return ad7293_set_offset(st, chan->channel + AD7293_ISENSE_MIN_OFFSET_CH, val);
> +		case IIO_TEMP:
> +			return ad7293_set_offset(st, chan->channel + AD7293_TSENSE_MIN_OFFSET_CH, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return ad7293_adc_set_scale(st, chan->channel, val);
> +		case IIO_CURRENT:
> +			return ad7293_isense_set_scale(st, chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +
> +static int ad7293_init(struct ad7293_state *st)
> +{
> +	int ret;
> +	u16 chip_id;
> +	struct spi_device *spi = st->spi;
> +	unsigned int supply;
> +
> +	ret = ad7293_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7293_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(st->reg_avdd);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified AVDD Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> +				       st->reg_avdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(st->reg_vdrive);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified VDRIVE Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> +				       st->reg_vdrive);
> +	if (ret)
> +		return ret;
> +
> +	supply = regulator_get_voltage(st->reg_avdd);

Missed this before, but regulator_get_voltage() returns a signed int
and it can be an error code.  If that happens we should return that error
rather than replacing it with -EINVAL.


> +	if (supply > 5500000 || supply < 4500000)
> +		return -EINVAL;
> +
> +	supply = regulator_get_voltage(st->reg_vdrive);
> +	if (supply > 5500000 || supply < 1700000)
> +		return -EINVAL;
> +
> +	/* Check Chip ID */
> +	ret = __ad7293_spi_read(st, AD7293_REG_DEVICE_ID, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	if (chip_id != AD7293_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
