Return-Path: <linux-iio+bounces-12890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121749DF2F3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A957B20DE8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C21AA1DD;
	Sat, 30 Nov 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlenVg1h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9A2F2A;
	Sat, 30 Nov 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997842; cv=none; b=OldgzTAhLL3dgl4GzEDSiZX2da7wg0GB48ffjG4kv7zaqGcAIsMKt3c7JcUHn62yl0D66do8cfC7QPSuIelvEaDFXKFycmzfjS2Crs8ifu2OuYc7+OasNrKTKT3tSOKjLdvbjacGPWLoIiG9NtkAQmlOe0+BZNvJjVzug6J/K6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997842; c=relaxed/simple;
	bh=WmG4sD1AshVvDkT+kDzHXRFkL2znAxOK1jriKyrFc5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQZZwCiOz9AGW4PJzU5g7ge/LajCDrLoyQE2mt4LHbulhQDoiERKO4w6A4owLtFciOsxUCRHlTHx+GidBehoEV2pMN0JotSfCZM3wqQSqZBgg4e7eaM/9KXamFoI4G55V9t04h4VKv5AUzI7OFALFyGR0zlXnHWt/qQbCUHwIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlenVg1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F76C4CECC;
	Sat, 30 Nov 2024 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732997842;
	bh=WmG4sD1AshVvDkT+kDzHXRFkL2znAxOK1jriKyrFc5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlenVg1h6BZAFQ8lVG1C+IC68ELwnbfGKkS2jjpWi2M4RkL9acojeOp7Hko53JUBp
	 ZyWepIsUEbvoN01FEq/bPTx/RII7g1msZXlTBgWyrjcsSTMRrtdzrhYlJ5/l8mWQqs
	 X1//ap2sO32vPY+rP5FNGE/XSPjvYCayp9rVxCe0sz9fkTN0D5HiaIzEKoJO0ynMDe
	 hOE7wvdEDkcW5b+8Wh3wNwHI1a1bZ08G8+yauKAEA8X8+Meid8luOhDNkMeOjE4mv3
	 lXMyixPdS4FxaQwtHpdJiUTlESmLZIlE9Ni0JPbfo6iG63+6ZhAdQS8YckMTPgviDi
	 0SyL2AcbiOUug==
Date: Sat, 30 Nov 2024 20:17:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
Message-ID: <20241130201714.73d54a5b@jic23-huawei>
In-Reply-To: <20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>
References: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
	<20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 22:51:55 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Various comments below, but in general looks pretty good to me.

Jonathan

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..fd4c111db13f
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c
> @@ -0,0 +1,1129 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VEML6031X00 Ambient Light Sensor
> + *
> + * Copyright (c) 2024, Javier Carrasco <javier.carrasco.cruz@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +/* Device registers */
> +#define VEML6031X00_REG_CONF0       0x00
> +#define VEML6031X00_REG_CONF1       0x01
> +#define VEML6031X00_REG_WH_L        0x04
> +#define VEML6031X00_REG_WH_H        0x05
> +#define VEML6031X00_REG_WL_L        0x06
> +#define VEML6031X00_REG_WL_H        0x07
> +#define VEML6031X00_REG_ALS_L       0x10
> +#define VEML6031X00_REG_ALS_H       0x11
> +#define VEML6031X00_REG_IR_L        0x12
> +#define VEML6031X00_REG_IR_H        0x13
> +#define VEML6031X00_REG_ID_L        0x14
> +#define VEML6031X00_REG_ID_H        0x15
> +#define VEML6031X00_REG_INT         0x17
> +#define VEML6031X00_REG_DATA(ch)    (VEML6031X00_REG_ALS_L + (ch))
> +
> +/* Bit masks for specific functionality */
> +#define VEML6031X00_ALL_CH_MASK     GENMASK(1, 0)
> +#define VEML6031X00_CONF0_SD        BIT(0)
> +#define VEML6031X00_CONF0_AF_TRIG   BIT(2)
> +#define VEML6031X00_CONF0_AF        BIT(3)
> +#define VEML6031X00_CONF1_GAIN      GENMASK(4, 3)
> +#define VEML6031X00_CONF1_PD_D4     BIT(6)
> +#define VEML6031X00_CONF1_IR_SD     BIT(7)
> +#define VEML6031X00_INT_MASK        GENMASK(3, 1)

As these next lot are bits in the INT MASK, I'd prefer you build it
as VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L | VEML6031X00_INT_DRDY

> +#define VEML6031X00_INT_TH_H        BIT(1)
> +#define VEML6031X00_INT_TH_L        BIT(2)
> +#define VEML6031X00_INT_DRDY        BIT(3)

> +
> +static const int veml6031x00_it[][2] = {
> +	{0, 3125},
> +	{0, 6250},
> +	{0, 12500},
> +	{0, 25000},
> +	{0, 50000},
> +	{0, 100000},
> +	{0, 200000},
> +	{0, 400000},
> +};
> +
> +static const int veml6031x00_gains[][2] = {
> +	{0, 125000},
> +	{0, 165000},
> +	{0, 250000},
> +	{0, 500000},
> +	{0, 660000},
> +	{1, 0},
> +	{2, 0},
	{ 2, 0 },

for formatting these arrays.  I'm slowly standardising on this in IIO in the interests
of picking on consistent choice.
> +};
> +
> +/*
> + * Persistence = 1/2/4/8 x integration time
> + * Minimum time for which light readings must stay above configured
> + * threshold to assert the interrupt.
> + */
> +static const char * const period_values[] = {
> +		"0.003125 0.00625 0.0125 0.025",
> +		"0.00625 0.0125 0.025 0.05",
> +		"0.0125 0.025 0.05 0.1",
> +		"0.025 0.050 0.1 0.2",
> +		"0.05 0.1 0.2 0.4",
> +		"0.1 0.2 0.4 0.8",
> +		"0.2 0.4 0.8 1.6",
> +		"0.4 0.8 1.6 3.2"
> +};
> +
> +/*
> + * Return list of valid period values in seconds corresponding to
> + * the currently active integration time.
> + */
> +static ssize_t in_illuminance_period_available_show(struct device *dev,
> +						    struct device_attribute *attr,
> +						    char *buf)
> +{
> +	struct veml6031x00_data *data = iio_priv(dev_to_iio_dev(dev));
> +	int ret, reg;
> +
> +	ret = regmap_field_read(data->rf.it, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg < 0 || reg >= ARRAY_SIZE(period_values))
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%s\n", period_values[reg]);

I'd rather this was done with read_avail if possible.
It can be a little fiddly but in a case where is a selection like this
rather than computed values, it shouldn't be too bad.

> +}
> +
> +static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
> +
> +static struct attribute *veml6031x00_event_attributes[] = {
> +	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group veml6031x00_event_attr_group = {
> +	.attrs = veml6031x00_event_attributes,
> +};
> +
> +/*
> + * Two shutdown bits (SD and ALS_IR_SD) must be cleared to power on
> + * the device.
> + */
> +static int veml6031x00_als_power_on(struct veml6031x00_data *data)
> +{
> +	int ret;
> +
> +	ret =  regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				 VEML6031X00_CONF0_SD);
> +	if (ret)
> +		return ret;
> +
> +	ret =  regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF1,
> +				 VEML6031X00_CONF1_IR_SD);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
return regmap_clear.

Also, check for extra spaces like in the ret =__ above and clean them up.

> +}


> +static int veml6031x00_get_it_usec(struct veml6031x00_data *data, int *it_usec)
> +{
> +	int ret, reg;
> +
> +	ret = regmap_field_read(data->rf.it, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg) {
> +	case 0:

Maybe a lookup in a table?  Up to you.

> +		*it_usec = 3125;
> +		break;
> +	case 1:
> +		*it_usec = 6250;
> +		break;
> +	case 2:
> +		*it_usec = 12500;
> +		break;
> +	case 3:
> +		*it_usec = 25000;
> +		break;
> +	case 4:
> +		*it_usec = 50000;
> +		break;
> +	case 5:
> +		*it_usec = 100000;
> +		break;
> +	case 6:
> +		*it_usec = 200000;
> +		break;
> +	case 7:
> +		*it_usec = 400000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, new_it;
> +
> +	if (val)
> +		return -EINVAL;
> +
> +	switch (val2) {
> +	case 3125:
> +		new_it = 0x00;
> +		break;
> +	case 6250:
> +		new_it = 0x01;
> +		break;
> +	case 12500:
> +		new_it = 0x02;
> +		break;
> +	case 25000:
> +		new_it = 0x03;
> +		break;
> +	case 50000:
> +		new_it = 0x04;
> +		break;
> +	case 100000:
> +		new_it = 0x05;
> +		break;
> +	case 200000:
> +		new_it = 0x06;
> +		break;
> +	case 400000:
> +		new_it = 0x07;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_field_write(data->rf.it, new_it);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
return regmap_field_write()

> +}

> +
> +static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
> +				   int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int addr, it_usec, ret;
> +	__le16 reg;
> +
> +	switch (type) {
> +	case IIO_LIGHT:
> +		addr = VEML6031X00_REG_ALS_L;
> +	break;
> +	case IIO_INTENSITY:
> +		addr = VEML6031X00_REG_IR_L;
> +	break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it_usec(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	iio_device_claim_direct_scoped(return -EBUSY, iio) {
There is some debate about conditional guards ongoing.  We may well end up
ripping them out.  Here there is relatively little benefit anyway
so I'd prefer we don't add another one.
	ret = iio_device_claim_direct_mode();
	if (ret)
		return ret;
	ret = regmap_...
	iio_device_release_direct_mode()
	if (ret)
		return ret;

etc.

> +		ret = regmap_bulk_read(data->regmap, addr, &reg, 2);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
> +
> +	*val = le16_to_cpu(reg);
> +
> +	return IIO_VAL_INT;
> +}


> +static const struct iio_info veml6031x00_info = {
> +	.read_raw  = veml6031x00_read_raw,
> +	.read_avail  = veml6031x00_read_avail,
> +	.write_raw = veml6031x00_write_raw,
> +	.read_event_value = veml6031x00_read_event_val,
> +	.write_event_value	= veml6031x00_write_event_val,
> +	.read_event_config = veml6031x00_read_event_config,
> +	.write_event_config	= veml6031x00_write_event_config,

Some odd spacing here. Just use a single space rather than trying to align with tabs etc.

> +	.event_attrs = &veml6031x00_event_attr_group,
> +};
>

> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ch, ret, i = 0;
> +	__le16 reg;
> +	struct {
> +		__le16 chans[2];
> +		aligned_s64 timestamp;
> +	} scan;
> +
> +	memset(&scan, 0, sizeof(scan));
> +
> +	if (*iio->active_scan_mask == VEML6031X00_ALL_CH_MASK) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       VEML6031X00_REG_ALS_L,
> +				       &reg, sizeof(scan.chans));
> +		if (ret)
> +			goto done;
> +	} else {

Is this optimization worthwhile? People tend to want all or most of their
channels. You could just set available_scan_masks and let the IIO core
deal with providing only the channels requested.

> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(data->regmap,
> +					       VEML6031X00_REG_DATA(ch),
> +					       &scan.chans[i++], 2);
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg, 2);

sizeof(reg)

> +	if (ret) {
> +		dev_info(data->dev, "Failed to read ID\n");
I'd like an error return on this. Failure to read the register would definitely
make it an incompatible part.

> +		return;
> +	}
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != data->chip->part_id)
> +		dev_info(data->dev, "Unknown ID %#02x\n", part_id);
but return success either way here.
> +}
> +
> +static int veml6031x00_hw_init(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret, val;
> +	__le16 reg;
> +
> +	reg = cpu_to_le16(0);
> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg, 2);
sizeof(reg)
Same in all these.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	reg = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &reg, 2);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_field_write(data->rf.int_en, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &val);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}
> +
> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
> +					    iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &veml6031x00_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, iio);
> +
> +	ret = devm_iio_trigger_register(dev, data->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio->trig = iio_trigger_get(data->trig);
> +	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> +					veml6031x00_interrupt,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Direction should come from firmware, not be controlled by the driver
(there might be an inverter in the path for example that the driver cannot
know about - often done as a cheap level converter)

> +					iio->name, iio);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
> +				     i2c->irq);
> +
> +	iio->info = &veml6031x00_info;
I'd put this at caller so it is obviously 'matched' with the other set of info.
It's also not as such anything to do with seting up the irq.

> +
> +	return 0;
> +}
> +
> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6031x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	mutex_init(&data->lock);
For new code prefer
	ret = devm_mutex_init(&data->lock)
	if (ret)
		return ret;

It won't fail unless out of memory so no need to print anything on error.

> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_sd_action, data);
when registering a cleanup action that isn't obvious matched with a setup
one I'd like to see a comment on why.  Here I guess the device comes up not
in shutdown mode?

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, VEML6031X00_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	veml6031x00_validate_part_id(data);
As above - this can fail in a fashion we should handle (read didn't work)

> +
> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	if (i2c->irq) {
> +		ret = veml6031x00_setup_irq(i2c, iio);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		iio->info = &veml6031x00_info_no_irq;
> +	}
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6031x00_trig_handler,
> +					      &veml6031x00_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer");
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device");
> +
> +	return 0;
> +}
> +
> +static int veml6031x00_runtime_suspend(struct device *dev)
> +{
> +	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return veml6031x00_als_sd(data);

Maybe spell out sd / shutdown.  I briefly wondered what it was!

> +}
> +
> +static int veml6031x00_runtime_resume(struct device *dev)
> +{
> +	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return veml6031x00_als_power_on(data);
> +}

