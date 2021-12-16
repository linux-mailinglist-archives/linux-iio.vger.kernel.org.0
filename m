Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470E4777E3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhLPQQe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 11:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbhLPQQa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 11:16:30 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59587C061756;
        Thu, 16 Dec 2021 08:16:29 -0800 (PST)
Received: from [81.101.6.87] (port=52580 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxtQb-0002Qk-Sm; Thu, 16 Dec 2021 16:16:22 +0000
Date:   Thu, 16 Dec 2021 16:21:46 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, swboyd@chromium.org,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: proximity: Add sx9360 support
Message-ID: <20211216162139.6008820e@jic23-huawei>
In-Reply-To: <20211213024057.3824985-3-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org>
        <20211213024057.3824985-3-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Dec 2021 18:40:55 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> A simplified version of SX9324, it only have one pin and
> 2 phases (aka channels).
> Only one event is presented.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

You don't use the modifier defined in the previous
patch...

> ---
> Changes since v2:
> - Fix issues reported during sx9324 driver review:
>   - fix include with iwyu
>   - Remove call to ACPI_PTR to prevent unused variable warning.
> - Fix panic when setting frequency to 0.
> - Add offset to decipher interrupt register
> - Fix default register value.
> 
> Changes since v1:
> - Remove SX9360_DRIVER_NAME
> - Simplify whoami function
> - Define WHOAMI register value internally.
> - Handle negative values when setting sysfs parameters.
> 
>  drivers/iio/proximity/Kconfig  |  14 +
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/sx9360.c | 807 +++++++++++++++++++++++++++++++++
>  3 files changed, 822 insertions(+)
>  create mode 100644 drivers/iio/proximity/sx9360.c
> 
....


> +static const struct iio_chan_spec sx9360_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.extend_name = "reference",

You defined the modifier for this and then didn't use it?  
I've suggested in review of patch 1 you might want to use label though
via the read_label() callback.


> +		.address = SX9360_REG_USEFUL_PHR_MSB,
> +		.channel = 0,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.address = SX9360_REG_USEFUL_PHM_MSB,
> +		.event_spec = sx_common_events,
> +		.num_event_specs = ARRAY_SIZE(sx_common_events),
> +		.channel = 1,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +

...

> +
> +static int sx9360_read_samp_freq(struct sx_common_data *data,
> +				 int *val, int *val2)
> +{
> +	int ret, divisor;
> +	__be16 buf;
> +
> +	ret = regmap_bulk_read(data->regmap, SX9360_REG_GNRL_CTRL1,
> +			       &buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	divisor = be16_to_cpu(buf);
> +	if (divisor == 0) {
> +		*val = 0;
> +		return IIO_VAL_INT;
> +	}
> +
> +	*val = SX9360_FOSC_HZ;
> +	*val2 = be16_to_cpu(buf) * 8192;

*val2 = divisor * 8192;?

> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +

...

> +static int sx9360_write_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return sx9360_set_samp_freq(data, val, val2);
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return sx9360_write_gain(data, chan, val);
> +	}
> +

Slight preference for this as a default in the switch.

> +	return -EINVAL;
> +}

...


> +static int sx9360_check_whoami(struct device *dev,
> + 				struct iio_dev *indio_dev)

Will fit on one line under 80 chars I think..

> +{
> +	/*
> +	 * Only one sensor for this driver. Assuming the device tree
> +	 * is correct, just set the sensor name.
> +	 */
> +	indio_dev->name = "sx9360";
> +	return 0;
> +}
> +

> +
> +static int __maybe_unused sx9360_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

I don't feel particularly strongly about this, as there are arguments
either way but this is the same as

	struct iio_dev *indio_dev = dev_get_drvdata(dev);

> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	disable_irq_nosync(data->client->irq);
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
> +
> +	data->suspend_ctrl =
> +		FIELD_GET(SX9360_REG_GNRL_CTRL0_PHEN_MASK, regval);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Disable all phases, send the device to sleep. */
> +	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +

