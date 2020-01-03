Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC26D12F8EE
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2020 14:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgACNqd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jan 2020 08:46:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59224 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACNqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jan 2020 08:46:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 003DkDMK058189;
        Fri, 3 Jan 2020 07:46:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578059173;
        bh=ClgGUH1+3hEjo5ulcbAOGMo1JbFi4QSWWNq06kwudPg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Gf/sZtHhAPLAhlRNVDNpM5qX9MAv4bJ+eevFg2oEJmN6ujkpU5LSVII1HrV1B/0w2
         wXhp3HeubnOJs7WnvVOweNFTxmWOoB9CQAYowkAF+tnH1g+pbcMMlcGGQNuMA/KqIg
         ixLm6s7jZ8XbkxOC/Hq3VMaNc0Leby8KXzFmgxFo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 003DkD3o113850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jan 2020 07:46:13 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Jan
 2020 07:46:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Jan 2020 07:46:13 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 003DkCZA044776;
        Fri, 3 Jan 2020 07:46:13 -0600
Subject: Re: [PATCH 2/2] iio: dac: Introduce the TI DAC8771 DAC driver
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>
References: <20191217140731.30504-1-dmurphy@ti.com>
 <20191217140731.30504-3-dmurphy@ti.com> <20191223151355.2222311c@archlinux>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7072c78d-f8e3-6ded-fbf3-7bc3d23f9003@ti.com>
Date:   Fri, 3 Jan 2020 07:43:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223151355.2222311c@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan

On 12/23/19 9:13 AM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2019 08:07:31 -0600
> Dan Murphy <dmurphy@ti.com> wrote:
>
>> Adding the Texas Instruments single channel 16 bit DAC driver.
>> This device has configurable voltage and current output with 16 bit
>> resolution for offset and gain.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Various small things inline.
>
> Thanks,
>
> Jonathan
>
>> ---
>>   drivers/iio/dac/Kconfig      |   7 +
>>   drivers/iio/dac/Makefile     |   1 +
>>   drivers/iio/dac/ti-dac8771.c | 499 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 507 insertions(+)
>>   create mode 100644 drivers/iio/dac/ti-dac8771.c
>>
>> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
>> index 979070196da9..df7793113415 100644
>> --- a/drivers/iio/dac/Kconfig
>> +++ b/drivers/iio/dac/Kconfig
>> @@ -386,6 +386,13 @@ config TI_DAC7612
>>   
>>   	  If compiled as a module, it will be called ti-dac7612.
>>   
>> +config TI_DAC8771
>> +	tristate "Texas Instruments 16-bit single channel DAC driver"
>> +	depends on SPI_MASTER && GPIOLIB
>> +	help
>> +	  Driver for the Texas Instruments DAC8771.
>> +	  If compiled as a module, it will be called ti-dac8771.
>> +
>>   config VF610_DAC
>>   	tristate "Vybrid vf610 DAC driver"
>>   	depends on OF
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index 1369fa1d2f0e..4aa6e35348cf 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -42,4 +42,5 @@ obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
>>   obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
>>   obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
>>   obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
>> +obj-$(CONFIG_TI_DAC8771) += ti-dac8771.o
>>   obj-$(CONFIG_VF610_DAC) += vf610_dac.o
>> diff --git a/drivers/iio/dac/ti-dac8771.c b/drivers/iio/dac/ti-dac8771.c
>> new file mode 100644
>> index 000000000000..309728212a07
>> --- /dev/null
>> +++ b/drivers/iio/dac/ti-dac8771.c
>> @@ -0,0 +1,499 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// DAC8771 DAC
>> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/of_gpio.h>
> What is using of_gpio.h in here?

Ack that can be removed.


>> +#include <linux/regulator/consumer.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/events.h>
>> +
>> +#define DAC8771_RESET		0x01
>> +#define DAC8771_RESET_CFG	0x02
>> +#define DAC8771_DAC_SELECT	0x03
>> +#define DAC8771_DAC_CFG		0x04
>> +#define DAC8771_DAC_DATA	0x05
>> +#define DAC8771_BUCK_BOOST_SEL	0x06
>> +#define DAC8771_BUCK_BOOST_CFG	0x07
>> +#define DAC8771_CH_CAL_EN	0x08
>> +#define DAC8771_CH_GAIN_CAL	0x09
>> +#define DAC8771_CH_OFF_CAL	0x0a
>> +#define DAC8771_STATUS		0x0b
>> +#define DAC8771_STATUS_MSK	0x0c
>> +#define DAC8771_ALARM_ACTION	0x0d
>> +#define DAC8771_ALARM_CODE	0x0e
>> +#define DAC8771_WDOG_RESET	0x10
>> +#define DAC8771_DEV_ID		0x11
>> +
>> +#define DAC8771_RESOLUTION	16
>> +
>> +/* Status register */
>> +#define DAC8771_OVERTEMP	BIT(4)
>> +#define DAC8771_DAC_FAULT	BIT(0)
>> +#define DAC8771_STATUS_MASK	(DAC8771_OVERTEMP | DAC8771_DAC_FAULT)
>> +
>> +#define DAC8771_READ_EN		BIT(7)
>> +
>> +#define DAC8771_SW_RESET	BIT(0)
>> +#define DAC8771_SPI_ENABLE	0
>> +#define DAC8771_SPI_DISABLE	1
>> +
>> +#define DAC8771_CHA_SEL		BIT(5)
>> +#define DAC8771_OUT_RANGE_MSK	GENMASK(3, 0)
>> +#define DAC8771_MAX_GAIN_OFF	65535
>> +
>> +#define DAC8771_OUT_RANGE_DEF	0x0
>> +#define DAC8771_OUT_RANGE_CURR_LOW	4
>> +#define DAC8771_OUT_RANGE_CURR_HIGH	7
>> +#define DAC8771_OUT_RANGE_MAX	12
>> +
>> +#define DAC8771_SELECT_A	BIT(0)
>> +
>> +/**
>> + * struct dac8771_chip - TI DAC chip
>> + * @lock: protects write sequences
>> + * @vref: regulator generating Vref
>> + * @spi: SPI device to send data to the device
>> + * @ldac: load DAC GPIO
>> + * @reset: reset GPIO
>> + * @chan_type: Type of IIO channel either VOLTAGE or CURRENT
>> + * @output_range: output range of the device
>> + * @val: cached value
>> + * @buf: buffer for transfer data
>> + */
>> +struct dac8771_chip {
>> +	struct mutex lock;
>> +	struct regulator *vref;
>> +	struct spi_device *spi;
>> +	struct gpio_desc *ldac;
>> +	struct gpio_desc *reset;
>> +	enum iio_chan_type chan_type;
>> +	u8 output_range;
>> +	u16 val;
>> +	union {
>> +		__be32 d32;
>> +		__be16 d16;
> Why?  Only d8 seems to be used.

It was a development artifact it can be removed


>
>> +		u8 d8[3];
>> +	} data[3] ____cacheline_aligned;
>> +};
>> +
>> +static int dac8771_write(struct dac8771_chip *dac8771,
>> +			 unsigned int reg, int val)
>> +{
>> +	u8 data[3];
> Spi buffers need to be dma safe.  Can't be on the stack because
> you can't force stack variables to be in a cacheline without anything
> else that might cause problems during dma transfers.

ok.  I will need to fix the write


>> +
>> +	data[0] = reg;
>> +	data[1] = val >> 8;
>> +	data[2] = val & 0xff;
>> +
>> +	return spi_write(dac8771->spi, &data, sizeof(data));
>> +}
>> +
>> +static int dac8771_read(struct dac8771_chip *dac8771, unsigned int reg)
>> +{
>> +	int ret;
>> +	struct spi_transfer t[] = {
>> +		{
>> +			.tx_buf = &dac8771->data[0].d8[0],
>> +			.len = 3,
>> +			.cs_change = 1,
>> +		}, {
>> +			.tx_buf = &dac8771->data[1].d8[0],
> I can't immediately see where anything is put into this buffer to transmit..
>
I will have to look into this.

The device requires some clocking NOOPs to shift the data into the buffers.

>> +			.rx_buf = &dac8771->data[2].d8[0],
>> +			.len = 3,
>> +		},
>> +	};
>> +
>> +	dac8771->data[0].d8[0] = (DAC8771_READ_EN | reg);
>> +
>> +	ret = spi_sync_transfer(dac8771->spi, t, ARRAY_SIZE(t));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return (dac8771->data[2].d8[1] << 8 | dac8771->data[2].d8[2]);
>> +}
>> +
>> +static int dac8771_sync_write(struct dac8771_chip *dac8771,
>> +			      unsigned int reg, int val)
>> +{
>> +	int ret;
>> +
>> +	ret = dac8771_write(dac8771, reg, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (dac8771->ldac) {
>> +		gpiod_set_value(dac8771->ldac, 1);
>> +		gpiod_set_value(dac8771->ldac, 0);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int dac8771_reset(struct dac8771_chip *dac8771)
>> +{
>> +	if (dac8771->reset) {
>> +		gpiod_set_value(dac8771->reset, 0);
>> +		gpiod_set_value(dac8771->reset, 1);
>> +	} else {
>> +		return dac8771_sync_write(dac8771, DAC8771_RESET,
>> +					  DAC8771_SW_RESET);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dac8771_update_bits(struct dac8771_chip *dac8771, unsigned int reg,
>> +			       int mask, int val)
>> +{
>> +	int write_val;
>> +	int tmp;
>> +
>> +	tmp = dac8771_read(dac8771, reg);
>> +	if (tmp < 0)
>> +		return tmp;
>> +
>> +	write_val = (tmp & ~mask);
>> +	write_val |= val & mask;
>> +
>> +	return dac8771_write(dac8771, reg, write_val);
>> +}
>> +
>> +static int dac8771_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct dac8771_chip *dac8771 = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		*val = dac8771->val;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret = regulator_get_voltage(dac8771->vref);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = ret / 1000;
>> +		*val2 = DAC8771_RESOLUTION;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		mutex_lock(&dac8771->lock);
>> +		ret = dac8771_read(dac8771, DAC8771_CH_OFF_CAL);
>> +		mutex_unlock(&dac8771->lock);
>> +
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = ret;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>> +		mutex_lock(&dac8771->lock);
>> +		ret = dac8771_read(dac8771, DAC8771_CH_GAIN_CAL);
>> +		mutex_unlock(&dac8771->lock);
>> +
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = ret;
>> +		return IIO_VAL_INT;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int dac8771_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct dac8771_chip *dac8771 = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&dac8771->lock);
>> +		ret = dac8771_sync_write(dac8771, DAC8771_DAC_DATA, val);
>> +		if (!ret)
>> +			dac8771->val = val;
>> +		break;
>> +	case IIO_CHAN_INFO_ENABLE:
>> +		if (val)
>> +			val = DAC8771_CHA_SEL;
>> +		else
>> +			val = 0;
>> +
>> +		mutex_lock(&dac8771->lock);
>> +
>> +		ret = dac8771_update_bits(dac8771, DAC8771_DAC_SELECT,
>> +					  DAC8771_CHA_SEL, val);
>> +		if (ret)
>> +			goto io_err;
>> +
>> +		ret = dac8771_update_bits(dac8771, DAC8771_DAC_CFG,
>> +				   DAC8771_OUT_RANGE_MSK,
>> +				   dac8771->output_range);
>> +		break;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		if (val > DAC8771_MAX_GAIN_OFF)
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&dac8771->lock);
>> +		ret = dac8771_sync_write(dac8771, DAC8771_CH_OFF_CAL, val);
>> +		break;
>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> Hmm. I wouldn't expect to see hardware gain on a DAC.  It has some very
> specific usecases, normally focused around device where the thing being
> measured or generated is not an amplitude (time of flight sensors for example).
>
> For a dac, we would normally have IIO_CHAN_INFO_SCALE controlling user
> visible 'gain' by specifying the value of 1LSB.  We might also have
> IIO_CHAN_INFO_CALIBSCALE to reflect small correction controls, usually used
> to compensate for manufacturing variability.  So whilst they do move the
> output value on a DAC, the intent is this is not a general user control
> but more of a 'trimming control'.  Given the register name of _CAL
> I'm guessing this one should be IIO_CHAN_INFO_CALIBSCALE.

ACK.  I originally had scale declared but thought HARDWARE_GAIN made 
more sense.

I have no issue changing it to INFO_SCALE.

>
>
>> +		if (val > DAC8771_MAX_GAIN_OFF)
>> +			return -EINVAL;
>> +
>> +		mutex_lock(&dac8771->lock);
>> +		ret = dac8771_sync_write(dac8771, DAC8771_CH_GAIN_CAL, val);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +io_err:
>> +	mutex_unlock(&dac8771->lock);
>> +	return ret;
>> +}
>> +
>> +static int dac8771_write_raw_get_fmt(struct iio_dev *indio_dev,
>> +				    struct iio_chan_spec const *chan, long mask)
>> +{
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static irqreturn_t dac8771_event_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct dac8771_chip *dac8771 = iio_priv(indio_dev);
>> +	int clear_bits = 0;
>> +	int ret;
>> +
>> +	ret = dac8771_read(dac8771, DAC8771_STATUS);
>> +
>> +	if (ret & DAC8771_OVERTEMP) {
>> +		iio_push_event(private,
> Given you have a local indio_dev variable, nicer to use that than private.
ACK
>
>> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
>> +			       0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
>> +			       iio_get_time_ns(private));
>> +		clear_bits = DAC8771_OVERTEMP;
>> +	}
>> +
>> +	if (ret & DAC8771_DAC_FAULT) {
>> +		iio_push_event(private,
>> +			       IIO_UNMOD_EVENT_CODE(dac8771->chan_type,
>> +			       0, IIO_EV_TYPE_CHANGE, IIO_EV_DIR_NONE),
>> +			       iio_get_time_ns(private));
> We need some more discussion on why this event is done like this.
> What does it signify?  Would userspace expect to get it this way?

Unfortunately this is how the data sheet declares this fault just as DAC 
Fault.

It is a generic fault condition unlike the TMP fault above.


> In general, provision for fault cases is poor, at least partly because,
> every now and then there is discussion on how to report hardware errors
> like this in general across the kernel, but no good answer has ever
> being figured out.
>
>> +
>> +		clear_bits |= DAC8771_DAC_FAULT;
>> +	}
>> +
>> +	ret = dac8771_update_bits(dac8771, DAC8771_STATUS, DAC8771_STATUS_MASK,
>> +				  clear_bits);
>> +	if (ret)
>> +		dev_err(&dac8771->spi->dev,
>> +			"Failed to clear status register\n");
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static const struct iio_info dac8771_info = {
>> +	.read_raw	   = dac8771_read_raw,
>> +	.write_raw	   = dac8771_write_raw,
>> +	.write_raw_get_fmt = dac8771_write_raw_get_fmt,
>> +};
>> +
>> +static int dac8771_probe_dt(struct dac8771_chip *dac8771)
>> +{
>> +	u32 range;
>> +	int ret;
>> +
>> +	dac8771->ldac = devm_gpiod_get_optional(&dac8771->spi->dev, "loaddacs",
>> +						 GPIOD_OUT_HIGH);
>> +	if (IS_ERR(dac8771->ldac)) {
>> +		ret = PTR_ERR(dac8771->ldac);
>> +		if (ret != -ENODEV) {
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(&dac8771->spi->dev,
>> +					"Failed to get loaddacs gpio: %d\n",
>> +					ret);
>> +			return ret;
>> +		}
>> +		dac8771->ldac = NULL;
>> +	}
>> +
>> +	dac8771->reset = devm_gpiod_get_optional(&dac8771->spi->dev, "reset",
>> +						 GPIOD_OUT_HIGH);
>> +	if (IS_ERR(dac8771->reset)) {
>> +		ret = PTR_ERR(dac8771->reset);
>> +		if (ret != -ENODEV) {
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(&dac8771->spi->dev,
>> +					"Failed to get reset gpio: %d\n",
>> +					ret);
>> +			return ret;
>> +		}
>> +		dac8771->reset = NULL;
>> +	}
>> +
>> +	ret = device_property_read_u32(&dac8771->spi->dev, "ti,output-range",
>> +				      &range);
>> +	if (ret) {
>> +		dev_err(&dac8771->spi->dev,
>> +			"Output range is not set using default\n");
>> +		range = DAC8771_OUT_RANGE_DEF;
>> +	} else {
>> +		if (dac8771->output_range < DAC8771_OUT_RANGE_DEF ||
>> +		    dac8771->output_range > DAC8771_OUT_RANGE_MAX) {
>> +			dev_err(&dac8771->spi->dev,
>> +				"Output range is invalid\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	dac8771->output_range = range;
>> +	if ((dac8771->output_range >= DAC8771_OUT_RANGE_CURR_LOW &&
>> +	    dac8771->output_range <= DAC8771_OUT_RANGE_CURR_HIGH) ||
>> +	    dac8771->output_range == DAC8771_OUT_RANGE_MAX)
>> +		dac8771->chan_type = IIO_CURRENT;
>> +	else
>> +		dac8771->chan_type = IIO_VOLTAGE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int dac8771_init(struct dac8771_chip *dac8771)
>> +{
>> +	int ret;
>> +
>> +	ret = dac8771_reset(dac8771);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return dac8771_write(dac8771, DAC8771_BUCK_BOOST_SEL, DAC8771_SELECT_A);
>> +}
>> +
>> +static int dac8771_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct dac8771_chip *dac8771;
>> +	struct iio_dev *indio_dev;
>> +	struct iio_chan_spec *chan;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*dac8771));
>> +	if (!indio_dev) {
>> +		dev_err(dev, "can not allocate iio device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	spi->mode = SPI_MODE_2;
>> +	spi_setup(spi);
>> +	spi_set_drvdata(spi, indio_dev);
>> +
>> +	dac8771 = iio_priv(indio_dev);
>> +	dac8771->spi = spi;
>> +
>> +	ret = dac8771_probe_dt(dac8771);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->dev.of_node = spi->dev.of_node;
>> +	indio_dev->info = &dac8771_info;
>> +	indio_dev->name = spi_get_device_id(spi)->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->num_channels = 1;
>> +
>> +	chan = devm_kzalloc(&indio_dev->dev, sizeof(struct iio_chan_spec),
>> +			    GFP_KERNEL);
> If it's always the same size, why not embed it in the dac8711 structure?
> Will avoid the need for an extra allocation.
>
>> +
>> +	chan->type = dac8771->chan_type;
> As there are only two types (I think!) I'd prefer to see this done
> as a pick between two static const structures rather than via
> dynamic setup.

There are only two types VOLTAGE and CURRENT which is determined by the 
DAC configuration register.

This is passed in via the binding to control what type of channel it is 
and setup the appropriate RANGE of the output.

So I can do a static const structure that passes in the chan_type to 
setup the correct channel type since the other values are constant.

>
>> +	chan->channel = 0;
>> +	chan->output = true;
>> +	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
>> +	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +			      BIT(IIO_CHAN_INFO_OFFSET) |
>> +			      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>> +			      BIT(IIO_CHAN_INFO_ENABLE) |
>> +			      BIT(IIO_CHAN_INFO_SCALE);
>> +
>> +	indio_dev->channels = chan;
>> +
>> +	dac8771->vref = devm_regulator_get(&dac8771->spi->dev, "vref");
> A quick glance at the datasheet suggests this device can be used with
> an internal reference?  Ideally we'd support that by making the provision
> of a vref regulator optional.
Ack.  Missed that.
>
> It also seems that there are a number of other power supplies that should
> be in the dt bindings even if not yet supported by the driver

This is true.  I did not have the current need to manage those 
additional supplies.

I think you are referring to AVDD, DVDD and PVDD.

> .
>
>> +	if (IS_ERR(dac8771->vref)) {
>> +		dev_err(&dac8771->spi->dev, "error to get regulator\n");
>> +		return PTR_ERR(dac8771->vref);
>> +	}
>> +
>> +	ret = regulator_enable(dac8771->vref);
>> +	if (ret < 0) {
>> +		dev_err(dev, "can not enable regulator\n");
>> +		return ret;
>> +	}
>> +
>> +	mutex_init(&dac8771->lock);
>> +
>> +	if (spi->irq) {
>> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
>> +						&dac8771_event_handler,
>> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +					  spi_get_device_id(dac8771->spi)->name,
>> +						indio_dev);
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	ret = dac8771_init(dac8771);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return devm_iio_device_register(&spi->dev, indio_dev);
> You can't safely mix managed and unmanaged code like this.
>
> By the time the userspace interfacs are removed as a result
> of the equivalent of iio_device_unregister being called as the device
> managed code unwinds, we will have turned the reference voltage off.
> Any readings that happen to occur in that narrow window will get
> unpredictable results.
>
> One option for that is to use devm_add_action_or_reset to register
> an additional unwind function to deal with the regulator disable
> in the remove path.  The argument for not having a devm_regulator_enable
> has been that it is almost always desirable to turn regulators off in
> other paths (suspend or runtime suspend) so normally it doesn't
> make that much sense to have a general always approach.
>
> Note we hardly ever bother with mutex_destroy as it is only for
> debug purposes and usually only relevant if complex handling is going
> on within the driver. For that reason I guess, no one has ever
> bothered with a devm_mutex_init().

Ack

Dan

