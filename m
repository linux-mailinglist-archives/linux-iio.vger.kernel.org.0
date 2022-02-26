Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DDF4C571E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 18:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiBZR3O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 12:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBZR3O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 12:29:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC21D6F62;
        Sat, 26 Feb 2022 09:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2ED160DB6;
        Sat, 26 Feb 2022 17:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F0C340E8;
        Sat, 26 Feb 2022 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645896517;
        bh=hY7bEZyYMR2Ug9qjQSHJfsMY8JmzV826SRZRNb4Idws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZadyCV3v0YkbYAJDdbOSjgJMd5LzdmITJhtdSMwA7FbSvASzzxY8w/A5xqQBQK4VJ
         X+/6QuddjoEackiHlHrGV6ey98PGrMiZclPDwl+6tQW5lgbzXn9mjcMTAAZwWgJY3G
         d66NVroyarMz0o7sgROEace/uZGKqZ/hHBBtEdLSW+GY3q4fspd4T7XasC3rtrJD96
         FXOm/KvT5+1nI6r+6aMdA8+5rRpVWCZ/TU6GRcTjwx7szJEjd8uQzm+Y7VxUF8Q/Tw
         dZJJVQl2QM5qQkjMNGaGLBJpsKAJMB/4tjtBjzUUJ3LBiaR8tEGZs5hcKLmRhjAjJ5
         73SrjYAx5n8pw==
Date:   Sat, 26 Feb 2022 17:35:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: Re: [PATCH v8 5/9] iio: adc: qcom-spmi-rradc: introduce round robin
 adc
Message-ID: <20220226173535.5b31da09@jic23-huawei>
In-Reply-To: <20220221220743.541704-6-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
        <20220221220743.541704-6-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Feb 2022 22:07:39 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The Round Robin ADC is responsible for reading data about the rate of
> charge from the USB or DC input ports, it can also read the battery
> ID (resistence), skin temperature and the die temperature of the pmic.
> It is found on the PMI8998 and PM660 Qualcomm PMICs.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Hi Calib,

Unfortunately this fell for the normal rule that everytime someone
rereads some code they'll find something new :(

All minor stuff though so fingers crossed for v9.
The endian stuff isn't strictly necessary but it is always better to use explicit
endian types where possible as it hardens the code against forgetting to convert
them etc.

Jonathan

> ---


> diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
> new file mode 100644
> index 000000000000..f69d95103c82
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-rradc.c
> @@ -0,0 +1,1011 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Linaro Limited.
> + *  Author: Caleb Connolly <caleb.connolly@linaro.org>
> + *
> + * This driver is for the Round Robin ADC found in the pmi8998 and pm660 PMICs.
> + */

...

> +static const int batt_id_delays[] = { 0, 1, 4, 12, 20, 40, 60, 80 };
> +static const struct rradc_channel rradc_chans[RR_ADC_CHAN_MAX];
> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX];
> +
> +static int rradc_read(struct rradc_chip *chip, u16 addr, u8 *data, int len)

This function is only ever called in paths which then convert *data to le16.
As such, pass in __le16 *buf
regmap_bulk_read() takes a void * so that will work fine without casting.
The size should still be bytes to reflect that we are reading multiple 8 bit
registers.

> +{
> +	int ret, retry_cnt = 0;
> +	u8 data_check[RR_ADC_CHAN_MAX_CONTINUOUS_BUFFER_LEN];
elegance would make this __le16 as well but that probably doesn't matter.

Possibly you'll have to do something a bit clever at the memcmp to force
dropping of the endian markings - build with C=1, W=1 and see if it complains.

> +
> +	if (len > RR_ADC_CHAN_MAX_CONTINUOUS_BUFFER_LEN) {
> +		dev_err(chip->dev,
> +			"Can't read more than %d bytes, but asked to read %d bytes.\n",
> +			RR_ADC_CHAN_MAX_CONTINUOUS_BUFFER_LEN, len);
> +		return -EINVAL;
> +	}
> +
> +	while (retry_cnt < RR_ADC_COHERENT_CHECK_RETRY) {
> +		ret = regmap_bulk_read(chip->regmap, chip->base + addr, data,
> +				       len);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "rr_adc reg 0x%x failed :%d\n", addr,
> +				ret);
> +			return ret;
> +		}
> +
> +		ret = regmap_bulk_read(chip->regmap, chip->base + addr,
> +				       data_check, len);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "rr_adc reg 0x%x failed :%d\n", addr,
> +				ret);
> +			return ret;
> +		}
> +
> +		if (memcmp(data, data_check, len) != 0) {
> +			retry_cnt++;
> +			dev_dbg(chip->dev,
> +				"coherent read error, retry_cnt:%d\n",
> +				retry_cnt);
> +			continue;
> +		}
> +
> +		break;
> +	}
> +
> +	if (retry_cnt == RR_ADC_COHERENT_CHECK_RETRY)
> +		dev_err(chip->dev, "Retry exceeded for coherrency check\n");
> +
> +	return ret;
> +}
> +

> +static int rradc_do_conversion(struct rradc_chip *chip,
> +			       enum rradc_channel_id chan_address, u16 *data)
> +{
> +	const struct rradc_channel *chan = &rradc_chans[chan_address];
> +	const struct iio_chan_spec *iio_chan = &rradc_iio_chans[chan_address];
> +	int ret;
> +	u8 buf[6];

I missed this until now, but buf is only ever used as __le16 buf[3]
so give it that type and you can use
le16_to_cpu() as it will be aligned.

 
> +
> +	mutex_lock(&chip->conversion_lock);
> +
> +	switch (chan_address) {
> +	case RR_ADC_BATT_ID:
> +		ret = rradc_prepare_batt_id_conversion(chip, chan_address, data);
> +		if (ret < 0) {
> +			dev_err(chip->dev, "Battery ID conversion failed:%d\n",
> +				ret);
> +			goto unlock_out;
> +		}
> +		break;
> +
> +	case RR_ADC_USBIN_V:
> +	case RR_ADC_DIE_TEMP:
> +		ret = rradc_read_status_in_cont_mode(chip, chan_address);
> +		if (ret < 0) {
> +			dev_err(chip->dev,
> +				"Error reading in continuous mode:%d\n", ret);
> +			goto unlock_out;
> +		}
> +		break;
> +	default:
> +		if (!rradc_is_ready(chip, chan_address)) {
> +			/*
> +			 * Usually this means the channel isn't attached, for example
> +			 * the in_voltage_usbin_v_input channel will not be ready if
> +			 * no USB cable is attached
> +			 */
> +			dev_dbg(chip->dev, "channel '%s' is not ready\n",
> +				iio_chan->extend_name);
> +			ret = -ENODATA;
> +			goto unlock_out;
> +		}
> +		break;
> +	}
> +
> +	ret = rradc_read(chip, chan->lsb, buf, chan->size);
> +	if (ret) {
> +		dev_err(chip->dev, "read data failed\n");
> +		goto unlock_out;
> +	}
> +
> +	/*
> +	 * For the battery ID we read the register for every ID ADC and then
> +	 * see which one is actually connected.
> +	 */
> +	if (chan_address == RR_ADC_BATT_ID) {
> +		u16 batt_id_150 = get_unaligned_le16(buf + 4);
> +		u16 batt_id_15 = get_unaligned_le16(buf + 2);
> +		u16 batt_id_5 = get_unaligned_le16(buf);
> +
> +		if (!batt_id_150 && !batt_id_15 && !batt_id_5) {
> +			dev_err(chip->dev,
> +				"Invalid batt_id values with all zeros\n");
> +			ret = -EINVAL;
> +			goto unlock_out;
> +		}
> +
> +		if (batt_id_150 <= RR_ADC_BATT_ID_RANGE) {
> +			*data = batt_id_150;
> +			chip->batt_id_data = 150;
> +		} else if (batt_id_15 <= RR_ADC_BATT_ID_RANGE) {
> +			*data = batt_id_15;
> +			chip->batt_id_data = 15;
> +		} else {
> +			*data = batt_id_5;
> +			chip->batt_id_data = 5;
> +		}
> +	} else {
> +		/*
> +		 * All of the other channels are either 1 or 2 bytes.
> +		 * We can rely on the second byte being 0 for 1-byte channels.
> +		 */
> +		*data = get_unaligned_le16(buf);
> +	}
> +
> +unlock_out:
> +	mutex_unlock(&chip->conversion_lock);
> +
> +	return ret;
> +}
> +

...


> +
> +static int rradc_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan_spec, int *val,
> +			  int *val2, long mask)
> +{
> +	struct rradc_chip *chip = iio_priv(indio_dev);
> +	const struct rradc_channel *chan;
> +	int ret;
> +	u16 adc_code;
> +
> +	if (chan_spec->address >= RR_ADC_CHAN_MAX) {
> +		dev_err(chip->dev, "Invalid channel index:%lu\n",
> +			chan_spec->address);
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return rradc_read_scale(chip, chan_spec->address, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return rradc_read_offset(chip, chan_spec->address, val);
> +	case IIO_CHAN_INFO_RAW:
> +		chan = &rradc_chans[chan_spec->address];

chan unused in this case statement.

> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = adc_code;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		chan = &rradc_chans[chan_spec->address];
> +		if (!chan->scale_fn)
> +			return -EINVAL;
> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = chan->scale_fn(chip, adc_code, val);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.address = RR_ADC_BATT_ID,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.address = RR_ADC_BATT_THERM,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.address = RR_ADC_SKIN_TEMP,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_USBIN_I,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),

Inconsistent indenting vs the other similar cases.

> +		.address = RR_ADC_USBIN_V,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_DCIN_I,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_DCIN_V,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.address = RR_ADC_DIE_TEMP,
> +		.channel = 2,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_CHG_TEMP,
> +		.channel = 3,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_GPIO,
> +		.channel = 2,
> +		.indexed = 1,
> +	},
> +};
> +
> +static int rradc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rradc_chip *chip;
> +	int ret, i, batt_id_delay;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chip->regmap) {
> +		dev_err(dev, "Couldn't get parent's regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	chip->dev = dev;
> +	mutex_init(&chip->conversion_lock);
> +
> +	ret = device_property_read_u32(dev, "reg", &chip->base);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Couldn't find reg address, ret = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	batt_id_delay = -1;
> +	ret = device_property_read_u32(dev, "qcom,batt-id-delay-ms",
> +				       &batt_id_delay);
> +	if (!ret) {
> +		for (i = 0; i < RRADC_BATT_ID_DELAY_MAX; i++) {
> +			if (batt_id_delay == batt_id_delays[i])
> +				break;
> +		}
> +		if (i == RRADC_BATT_ID_DELAY_MAX)
> +			batt_id_delay = -1;
> +	}
> +
> +	if (batt_id_delay >= 0) {
> +		batt_id_delay = FIELD_PREP(BATT_ID_SETTLE_MASK, batt_id_delay);
> +		ret = regmap_update_bits(chip->regmap,
> +					 chip->base + RR_ADC_BATT_ID_CFG,
> +					 batt_id_delay, batt_id_delay);
> +		if (ret < 0) {
> +			dev_err(chip->dev,
> +				"BATT_ID settling time config failed:%d\n",
> +				ret);
> +		}
> +	}
> +
> +	/* Get the PMIC revision ID, we need to handle some varying coefficients */
> +	chip->pmic = qcom_pmic_get(chip->dev);
> +	if (IS_ERR(chip->pmic)) {
> +		dev_err(chip->dev, "Unable to get reference to PMIC device\n");
> +		return PTR_ERR(chip->pmic);
> +	}
> +
> +	indio_dev->name = DRIVER_NAME;

I missed this in earlier versions, but this should be the specific
part number if possible, so probably
pm660-rradc / pmi8998-rradc as appropriate.
You can set it based on chip->pmic->sub_type I think


> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &rradc_info;
> +	indio_dev->channels = rradc_iio_chans;
> +	indio_dev->num_channels = ARRAY_SIZE(rradc_iio_chans);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id rradc_match_table[] = {
> +	{ .compatible = "qcom,pm660-rradc" },
> +	{ .compatible = "qcom,pmi8998-rradc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rradc_match_table);
> +
> +static struct platform_driver rradc_driver = {
> +	.driver		= {
> +		.name		= DRIVER_NAME,
> +		.of_match_table	= rradc_match_table,
> +	},
> +	.probe = rradc_probe,
> +};
> +module_platform_driver(rradc_driver);
> +
> +MODULE_DESCRIPTION("QCOM SPMI PMIC RR ADC driver");
> +MODULE_AUTHOR("Caleb Connolly <caleb.connolly@linaro.org>");
> +MODULE_LICENSE("GPL v2");

