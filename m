Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342984449C7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 21:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCUxu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 3 Nov 2021 16:53:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4063 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCUxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Nov 2021 16:53:50 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HkzMh54Pvz67hfx;
        Thu,  4 Nov 2021 04:46:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 21:51:11 +0100
Received: from localhost (10.52.121.67) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 20:51:10 +0000
Date:   Wed, 3 Nov 2021 20:51:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio:amplifiers:ad7293: add support for AD7293
Message-ID: <20211103205107.00002ea7@Huawei.com>
In-Reply-To: <20211102135947.131223-2-antoniu.miclaus@analog.com>
References: <20211102135947.131223-1-antoniu.miclaus@analog.com>
        <20211102135947.131223-2-antoniu.miclaus@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.67]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 15:59:46 +0200
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

Looks pretty good to me, a few questions / comments inline.

Thanks,

Jonathan


...


> diff --git a/drivers/iio/amplifiers/ad7293.c b/drivers/iio/amplifiers/ad7293.c
> new file mode 100644
> index 000000000000..c45b11ec2ce6
> --- /dev/null
> +++ b/drivers/iio/amplifiers/ad7293.c

...

> +/* AD7293 Miscellaneous Definitions */
> +#define AD7293_READ				BIT(7)
> +#define AD7293_R1B				BIT(16)
> +#define AD7293_R2B				BIT(17)
> +#define AD7293_TRANSF_LEN_MSK			GENMASK(17, 16)
> +#define AD7293_PAGE_ADDR_MSK			GENMASK(15, 8)
> +#define AD7293_PAGE(x)				FIELD_PREP(AD7293_PAGE_ADDR_MSK, x)
> +#define AD7293_REG_ADDR_MSK			GENMASK(7, 0)
> +#define AD7293_REG_VOUT_OFFSET_MSK		GENMASK(5, 4)
> +#define AD7293_REG_DATA_RAW_MSK			GENMASK(15, 4)
> +#define AD7293_REG_VINX_RANGE_GET_CH_MSK(x, ch)	(((x) >> (ch)) & 0x1)
> +#define AD7293_REG_VINX_RANGE_SET_CH_MSK(x, ch)	(((x) & 0x1) << (ch))
> +#define AD7293_CHIP_ID				0x18
> +
> +enum ad7293_ch_type {
> +	AD7293_ADC_VINX,
> +	AD7293_ADC_TSENSE,
> +	AD7293_ADC_ISENSE,
> +	AD7293_DAC,
> +};
> +
> +static const int dac_offset_table[] = {0, 1, 2};
> +
> +static const int isense_gain_table[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
> +
> +static const int adc_range_table[] = {0, 1, 2, 3};
> +
> +struct ad7293_state {
> +	struct spi_device *spi;
> +	/* Protect against concurrent accesses to the device */

Make it clear this lock also protects the content of data and I'd guess
page_select.

> +	struct mutex lock;
> +	u8 page_select;
> +	u8 data[3] ____cacheline_aligned;
> +};
> +
> +static int ad7293_page_select(struct ad7293_state *st, unsigned int reg)
> +{
> +	int ret;
> +
> +	if (st->page_select != FIELD_GET(AD7293_PAGE_ADDR_MSK, reg)) {
> +		st->data[0] = FIELD_GET(AD7293_REG_ADDR_MSK, AD7293_REG_PAGE_SELECT);
> +		st->data[1] = FIELD_GET(AD7293_PAGE_ADDR_MSK, reg);
> +
> +		ret = spi_write(st->spi, &st->data[0], 2);
> +		if (ret)
> +			return ret;
> +
> +		st->page_select = FIELD_GET(AD7293_PAGE_ADDR_MSK, reg);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __ad7293_spi_read(struct ad7293_state *st, unsigned int reg,
> +			     unsigned int *val)
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
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = ((st->data[1] << 8) | st->data[2])

This part is a get_unaligned_be16()

> >> (8 * (2 - FIELD_GET(AD7293_TRANSF_LEN_MSK, reg)));

This part is presumably only ever taking the values 8 or 0, so really 
reflects selecting either u8 or u16 data depending on the register.
I'd be tempted to make that explicit, even if it involves picking between
two functions based on the register.

This is reading back a relatively small unsigned int.  I'd suggest either making val a u16 or
possibly just use the return value.  Negative for error and >= 0 when successful read.

> +
> +	return 0;
> +}
> +
> +static int ad7293_spi_read(struct ad7293_state *st, unsigned int reg,
> +			   unsigned int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __ad7293_spi_read(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __ad7293_spi_write(struct ad7293_state *st, unsigned int reg,
> +			      unsigned int val)
> +{
> +	int ret;
> +
> +	ret = ad7293_page_select(st, reg);
> +	if (ret)
> +		return ret;
> +
> +	st->data[0] = FIELD_GET(AD7293_REG_ADDR_MSK, reg);
> +
> +	if (FIELD_GET(AD7293_TRANSF_LEN_MSK, reg) == 1) {
> +		st->data[1] = val;
> +	} else {
> +		st->data[1] = val >> 8;
> +		st->data[2] = val;
> +	}
> +
> +	return spi_write(st->spi, &st->data[0], 1 + FIELD_GET(AD7293_TRANSF_LEN_MSK, reg));

Have a local variable for length.

> +}
> +

...

> +
> +static int ad7293_get_offset(struct ad7293_state *st, unsigned int ch, unsigned int *offset)
> +{
> +	if (ch < 4)

Use an enum for the channel numbers so we know what these are.  
May be clearer as a switch with all the individual elements called out.

> +		return ad7293_spi_read(st, AD7293_REG_VIN0_OFFSET + ch, offset);
> +	else if (ch < 7)
> +		return ad7293_spi_read(st, AD7293_REG_TSENSE_INT_OFFSET + (ch - 4), offset);
> +	else if (ch < 11)
> +		return ad7293_spi_read(st, AD7293_REG_ISENSE0_OFFSET + (ch - 7), offset);
> +	else if (ch < 19)
> +		return ad7293_spi_read(st, AD7293_REG_UNI_VOUT0_OFFSET + (ch - 11), offset);
> +	else
> +		return -EINVAL;
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
> +			if (chan->output)
> +				return ad7293_dac_write_raw(st, chan->channel, val);

Flip conditions like this to, where possible, put the error path as the
out of line one.  Leads to shorter lines and more readable code.

> +
> +			return -EINVAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->output)
> +				return ad7293_set_offset(st, chan->channel + 11, val);
> +			else
> +				return ad7293_set_offset(st, chan->channel, val);
> +		case IIO_CURRENT:
> +			return ad7293_set_offset(st, chan->channel + 7, val);
> +		case IIO_TEMP:
> +			return ad7293_set_offset(st, chan->channel + 4, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return ad7293_adc_set_scale(st, chan->channel, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return ad7293_isense_set_gain(st, chan->channel, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +
> +static int ad7293_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		*vals = (const int *)dac_offset_table;

Do you need the casts here? It's a const int 1D array so from what I
recall it shouldn't need the cast.  We tend to need them because
of a 2D structure which we are flattening but that's not true here.

> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(dac_offset_table);
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*vals = (const int *)isense_gain_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(isense_gain_table);
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)adc_range_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(adc_range_table);
> +
> +		return IIO_AVAIL_LIST;
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
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\

Hardware gain is for cases where we don't directly affect this signal
such as light level on a time of flight sensor where we are measuring time
but adjust the gain of the sensor to make sure we see the event.
In this case looks like this gain has an effect on the scaling of the
read current value?

ISENSE LSB = 2 × (REFADC/(Gain × 4096 × RSENSE))

In which case it should be mapped onto scale.

> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN)			\
> +}
> +

...

