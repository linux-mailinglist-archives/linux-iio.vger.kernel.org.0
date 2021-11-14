Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C381A44F805
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 14:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhKNNX1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 08:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235950AbhKNNX1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 08:23:27 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BA960C4D;
        Sun, 14 Nov 2021 13:20:31 +0000 (UTC)
Date:   Sun, 14 Nov 2021 13:25:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio:amplifiers:ad7293: add support for AD7293
Message-ID: <20211114132518.5228c30f@jic23-huawei>
In-Reply-To: <20211108152238.189650-1-antoniu.miclaus@analog.com>
References: <20211108152238.189650-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Nov 2021 17:22:37 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD7293 is a Power Amplifier drain current controller
> containing functionality for general-purpose monitoring
> and control of current, voltage, and temperature, integrated
> into a single chip solution with an SPI-compatible interface.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>


Hi Antoniu,

Looks good to me.  A few really minor editorial type things that I noticed
whilst reading through this version.

All are in the up to you or can be added later categories.  So subject to DT review
and anyone else noticing things they want changing I'm happy to either pick this
version up or a v3 that tidies up minor corners.


> diff --git a/drivers/iio/amplifiers/ad7293.c b/drivers/iio/amplifiers/ad7293.c
> new file mode 100644
> index 000000000000..15aac5ad3407
> --- /dev/null
> +++ b/drivers/iio/amplifiers/ad7293.c


...

> +
> +static int ad7293_get_offset(struct ad7293_state *st, unsigned int ch, u16 *offset)
> +{
> +	if (ch < AD7293_TSENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_read(st, AD7293_REG_VIN0_OFFSET + ch, offset);
> +	else if (ch < AD7293_ISENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_read(st, AD7293_REG_TSENSE_INT_OFFSET + (ch - 4), offset);
> +	else if (ch < AD7293_VOUT_MIN_OFFSET_CH)
> +		return ad7293_spi_read(st, AD7293_REG_ISENSE0_OFFSET + (ch - 7), offset);
> +	else if (ch <= AD7293_VOUT_MAX_OFFSET_CH)
> +		return ad7293_spi_read(st, AD7293_REG_UNI_VOUT0_OFFSET + (ch - 11), offset);
> +	else
> +		return -EINVAL;
> +}
> +
> +static int ad7293_set_offset(struct ad7293_state *st, unsigned int ch, u16 offset)
> +{
> +	if (ch < AD7293_TSENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_VIN0_OFFSET + ch, offset);
> +	else if (ch < AD7293_ISENSE_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_TSENSE_INT_OFFSET + (ch - AD7293_TSENSE_MIN_OFFSET_CH), offset);
> +	else if (ch < AD7293_VOUT_MIN_OFFSET_CH)
> +		return ad7293_spi_write(st, AD7293_REG_ISENSE0_OFFSET + (ch - AD7293_ISENSE_MIN_OFFSET_CH), offset);
> +	else if (ch <= AD7293_VOUT_MAX_OFFSET_CH)
> +		return ad7293_spi_update_bits(st, AD7293_REG_UNI_VOUT0_OFFSET + (ch - AD7293_VOUT_MIN_OFFSET_CH),
> +						AD7293_REG_VOUT_OFFSET_MSK,
> +						FIELD_PREP(AD7293_REG_VOUT_OFFSET_MSK, offset));
> +	else
> +		return -EINVAL;

final else doesn't add much so I'd just have a return -EINVAL; after if the if stack..
i.e.
	return -EINVAL;

> +}
> +

...

> +static int ad7293_dac_write_raw(struct ad7293_state *st, unsigned int ch, u16 raw)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = __ad7293_spi_update_bits(st, AD7293_REG_DAC_EN, 1 << ch, 1 << ch);

You could use BIT(ch) for all these 1 << ch though they are fairly clear as it
stands if you would prefer not to for some reason.

> +	if (ret)
> +		goto exit;
> +
> +	ret =  __ad7293_spi_write(st, AD7293_REG_UNI_VOUT0 + ch,
> +				  FIELD_PREP(AD7293_REG_DATA_RAW_MSK, raw));
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
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
> +			else
> +				return ad7293_set_offset(st, chan->channel, val);

It is common not to provide a full range of avail attributes, but perhaps it makes sense to provide
ranges that are valid for these offsets and possibly the DAC output range above.
Both such things can be useful both to userspace and to in kernel drivers using these channels.

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
> +

...
> +
> +#define AD7293_CHAN_ADC(_channel) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate =					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_SCALE)			\
> +}
> +
> +#define AD7293_CHAN_DAC(_channel) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate =					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +}
> +
> +#define AD7293_CHAN_ISENSE(_channel) {				\
> +	.type = IIO_CURRENT,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate =					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_SCALE)			\
> +}
> +
> +#define AD7293_CHAN_TEMP(_channel) {				\
> +	.type = IIO_TEMP,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate =					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
> +}

...


Thanks,

Jonathan

