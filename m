Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDC4583D2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 14:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhKUNhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 08:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238025AbhKUNhP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 08:37:15 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AE260D42;
        Sun, 21 Nov 2021 13:34:09 +0000 (UTC)
Date:   Sun, 21 Nov 2021 13:39:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio:amplifiers:ad7293: add support for AD7293
Message-ID: <20211121132828.7a266dbc@jic23-huawei>
In-Reply-To: <20211115102340.164547-1-antoniu.miclaus@analog.com>
References: <20211115102340.164547-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Nov 2021 12:23:39 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD7293 is a Power Amplifier drain current controller
> containing functionality for general-purpose monitoring
> and control of current, voltage, and temperature, integrated
> into a single chip solution with an SPI-compatible interface.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7293.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

A few minor / trivial things noticed whilst having a read through.

They are all things I'd have either ignored or fixed up if you weren't likely to be
doing a v4 anyway because of the dt-bindings...  Seeing as you probably will be, please
tidy these up as well.

This is looking like a nice driver to me.

I'm a bit unsure if we should have this in a directory called amplifiers though.
The description is (I think) referring to closed loop control of current as
shown in figure 46.  The circuit with external transistor + sense resistor operates
as a current DAC.  As such I'd move this to the DAC directory as I think that's
the primary purpose intended for this device.

I guess a follow up set would supply explicit support for closed loop operation?
That can be enabled when someone has a use case for it.

Thanks,


Jonathan

> ---


...

> +
> +static int __ad7293_spi_read(struct ad7293_state *st, unsigned int reg,
> +			     u16 *val)
> +{
> +	int ret;
> +	struct spi_transfer t = {0};
> +
> +	ret = ad7293_page_select(st, reg);
> +	if (ret)
> +		return ret;
> +
> +	st->data[0] = AD7293_READ | FIELD_GET(AD7293_REG_ADDR_MSK, reg);
> +	st->data[1] = 0x0;
> +	st->data[2] = 0x0;
> +
> +	t.tx_buf = &st->data[0];
> +	t.rx_buf = &st->data[0];
> +	t.len = 1 + FIELD_GET(AD7293_TRANSF_LEN_MSK, reg);

Given you are going to use this field multiple times, I would use a local variable.

> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(AD7293_TRANSF_LEN_MSK, reg) == 1)
> +		*val = st->data[1];
> +	else
> +		*val = get_unaligned_be16(&st->data[1]);
> +
> +	return 0;
> +}

...

> +
> +static int __ad7293_spi_write(struct ad7293_state *st, unsigned int reg,
> +			      u16 val)
> +{
> +	int ret;
> +	unsigned int length = 1 + FIELD_GET(AD7293_TRANSF_LEN_MSK, reg);

I suggest not having the 1 + here
> +
> +	ret = ad7293_page_select(st, reg);
> +	if (ret)
> +		return ret;
> +
> +	st->data[0] = FIELD_GET(AD7293_REG_ADDR_MSK, reg);
> +
> +	if (FIELD_GET(AD7293_TRANSF_LEN_MSK, reg) == 1)

then this becomes if (length == 1)

> +		st->data[1] = val;
> +	else
> +		put_unaligned_be16(val, &st->data[1]);
> +
> +	return spi_write(st->spi, &st->data[0], length);

and you can use length + 1 here.  I think that ends up a little bit clearer.

> +}
> +

...

> +
> +static int ad7293_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		*vals = dac_offset_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(dac_offset_table);
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_INT;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*vals = adc_range_table;
> +			*length = ARRAY_SIZE(adc_range_table);
> +			break;
> +		case IIO_CURRENT:
> +			*vals = isense_gain_table;
> +			*length = ARRAY_SIZE(isense_gain_table);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return IIO_AVAIL_LIST;

Trivial: I'd prefer to see this return where the breaks are above.
Nice to pair the values and type in a couple of lines rather than having
to look down here.

> +	default:
> +		return -EINVAL;
> +	}
> +}
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

Trivial, but I think you could sensibly reduce how many lines these are
spread over without loss of readability.

#define AD7293_CHAN_ADC(_channel) {					\
	.type = IIO_VOLTAGE,						\
	.output = 0,							\
	.indexed = 1,							\
	.channel = _channel,						\
	.info_mask_separate =						\
		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |	\
		BIT(IIO_CHAN_INFO_OFFSET),				\
	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE)	\
}

etc

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
> +
