Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB014BC9F6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Feb 2022 19:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiBSSi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Feb 2022 13:38:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiBSSi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Feb 2022 13:38:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE746147;
        Sat, 19 Feb 2022 10:38:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFBABB80C92;
        Sat, 19 Feb 2022 18:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC064C004E1;
        Sat, 19 Feb 2022 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645295885;
        bh=VPI6ajWz1PgN1c/Y6y0pzLJTSgIVaN2b02mqhKzG/fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJu0uN7Y30swfeWv3Vmfww7H6oMNdEERPtnAzgiAsVcVVkBINvKc3dG1gAdNQ1p6+
         YYJ5Ybs8anIClmcJNNC6v04iBAObU4pcECdZVOrv1856kBrNbu/2GlLsgCj18HaAno
         5tRQJZHOhBQJ4xCS/WYJpDoiOe8oFDGUeJFDSu2fwsdWEJvQZxJqkA+w3cWXxCJwAZ
         pRRhMXuwT7OcxvNGVoV97eZP+W5LmhzEYd9NJ8tSA9earGNwfJ3Xt7zTIG5Qddq5yx
         d4kzki5dGLr2HNfuqm+DYD6L4FpelHMazDhVLo41/IFH2QRRZGGCgFIiA6uezAGB1v
         ijwznCpC7z8Ig==
Date:   Sat, 19 Feb 2022 18:44:51 +0000
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
Subject: Re: [PATCH v7 5/9] iio: adc: qcom-spmi-rradc: introduce round robin
 adc
Message-ID: <20220219184451.58873b9f@jic23-huawei>
In-Reply-To: <20220216134920.239989-6-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
        <20220216134920.239989-6-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Feb 2022 13:49:16 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The Round Robin ADC is responsible for reading data about the rate of
> charge from the USB or DC input ports, it can also read the battery
> ID (resistence), skin temperature and the die temperature of the pmic.
> It is found on the PMI8998 and PM660 Qualcomm PMICs.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Hi Caleb,

A few really trivial things noticed on a fresh read through. Given you
are spinning again might as well tidy them up.

Thanks,

Jonathan

...

> diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
> new file mode 100644
> index 000000000000..8d5675f625dc
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-rradc.c
> @@ -0,0 +1,1016 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Linaro Limited.
> + *  Author: Caleb Connolly <caleb.connolly@linaro.org>
> + *
> + * This driver is for the Round Robin ADC found in the pmi8998 and pm660 PMICs.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spmi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#include <soc/qcom/qcom-spmi-pmic.h>
> +
> +#define DRIVER_NAME "qcom-spmi-rradc"
> +

> +
> +#define RR_ADC_STS_CHANNEL_READING_MASK GENMASK(1, 0) // 0x03

Drop the // 0x03 as I'd hope that's obvious! :) 

...

> +
> +struct rradc_chip {
> +	struct device *dev;
> +	const struct qcom_spmi_pmic *pmic;
> +	/* Lock held while doing channel conversion
	/*
	 * Lock ...

> +	 * involving multiple register read/writes
> +	 */
> +	struct mutex conversion_lock;
> +	struct regmap *regmap;
> +	u32 base;
> +	int batt_id_delay;
> +	u16 batt_id_data;
> +};
> +
> +static const int batt_id_delays[] = { 0, 1, 4, 12, 20, 40, 60, 80 };
> +static const struct rradc_channel rradc_chans[RR_ADC_CHAN_MAX];
> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX];
> +
> +static int rradc_read(struct rradc_chip *chip, u16 addr, u8 *data, int len)
> +{
> +	int ret, retry_cnt = 0;
> +	u8 data_check[RR_ADC_CHAN_MAX_CONTINUOUS_BUFFER_LEN];
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
> +static int rradc_get_fab_coeff(struct rradc_chip *chip, int64_t *offset,
> +			       int64_t *slope)
> +{
> +	if (chip->pmic->subtype == PM660_SUBTYPE) {
> +		switch (chip->pmic->fab_id) {
> +		case PM660_FAB_ID_GF:
> +			*offset = RR_ADC_CHG_TEMP_660_GF_OFFSET_UV;
> +			*slope = RR_ADC_CHG_TEMP_660_GF_SLOPE_UV_PER_C;
> +			break;
			return 0;

> +		case PM660_FAB_ID_TSMC:
> +			*offset = RR_ADC_CHG_TEMP_660_SMIC_OFFSET_UV;
> +			*slope = RR_ADC_CHG_TEMP_660_SMIC_SLOPE_UV_PER_C;
> +			break;
			return 0;
> +		default:
> +			*offset = RR_ADC_CHG_TEMP_660_MGNA_OFFSET_UV;
> +			*slope = RR_ADC_CHG_TEMP_660_MGNA_SLOPE_UV_PER_C;
			return 0;
> +		}
> +	} else if (chip->pmic->subtype == PMI8998_SUBTYPE) {
> +		switch (chip->pmic->fab_id) {
> +		case PMI8998_FAB_ID_GF:
> +			*offset = RR_ADC_CHG_TEMP_GF_OFFSET_UV;
> +			*slope = RR_ADC_CHG_TEMP_GF_SLOPE_UV_PER_C;
> +			break;
			return 0;
> +		case PMI8998_FAB_ID_SMIC:
> +			*offset = RR_ADC_CHG_TEMP_SMIC_OFFSET_UV;
> +			*slope = RR_ADC_CHG_TEMP_SMIC_SLOPE_UV_PER_C;
> +			break;
			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Can only get here via a few paths adn in all of those returning early
makes just as much sense.

> +}
> +

...

> +static int rradc_read_status_in_cont_mode(struct rradc_chip *chip,
> +					  enum rradc_channel_id chan_address)
> +{
> +	const struct rradc_channel *chan = &rradc_chans[chan_address];
> +	const struct iio_chan_spec *iio_chan = &rradc_iio_chans[chan_address];
> +	int ret, i;
> +
> +	if (chan->trigger_mask == 0) {
> +		dev_err(chip->dev, "Channel doesn't have a trigger mask\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(chip->regmap, chip->base + chan->trigger_addr,
> +				 chan->trigger_mask, chan->trigger_mask);
> +	if (ret < 0) {
> +		dev_err(chip->dev,
> +			"Failed to apply trigger for channel '%s' ret=%d\n",
> +			iio_chan->extend_name, ret);
> +		return ret;
> +	}
> +
> +	ret = rradc_enable_continuous_mode(chip);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to switch to continuous mode\n");
> +		goto disable_trigger;
> +	}
> +
> +	/*
> +	 * The wait/sleep values were found through trial and error,
> +	 * this is mostly for the battery ID channel which takes some
> +	 * time to settle.
> +	 */
> +	for (i = 0; i < 5; i++) {
> +		if (rradc_is_ready(chip, chan_address))
> +			break;
> +		usleep_range(50000, 50000 + 500);
> +	}
> +
> +	if (i == 5) {
> +		dev_err(chip->dev, "Channel '%s' is not ready\n",
> +			iio_chan->extend_name);
> +		ret = -EINVAL;

Perhaps indicate a timeout rather than invalid?

> +	}
> +
> +	rradc_disable_continuous_mode(chip);
> +
> +disable_trigger:
> +	regmap_update_bits(chip->regmap, chip->base + chan->trigger_addr,
> +			   chan->trigger_mask, 0);
> +
> +	return ret;
> +}
> +
> +static int rradc_prepare_batt_id_conversion(struct rradc_chip *chip,
> +					    enum rradc_channel_id chan_address,
> +					    u16 *data)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
> +				 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV,
> +				 RR_ADC_BATT_ID_CTRL_CHANNEL_CONV);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Enabling BATT ID channel failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(chip->regmap,
> +				 chip->base + RR_ADC_BATT_ID_TRIGGER,
> +				 RR_ADC_TRIGGER_CTL, RR_ADC_TRIGGER_CTL);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "BATT_ID trigger set failed:%d\n", ret);
> +		goto out_disable_batt_id;
> +	}
> +
> +	ret = rradc_read_status_in_cont_mode(chip, chan_address);
> +
> +	/*
> +	 * Reset registers back to default values

Might as well do this as a single line comment.

> +	 */
> +	regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_TRIGGER,
> +			   RR_ADC_TRIGGER_CTL, 0);
> +
> +out_disable_batt_id:
> +	regmap_update_bits(chip->regmap, chip->base + RR_ADC_BATT_ID_CTRL,
> +			   RR_ADC_BATT_ID_CTRL_CHANNEL_CONV, 0);
> +
> +	return ret;
> +}
> +


...

> +static int rradc_read_scale(struct rradc_chip *chip, int chan_address, int *val,
> +			    int *val2)
> +{
> +	int64_t fab_offset, fab_slope;
> +	int ret;
> +
> +	ret = rradc_get_fab_coeff(chip, &fab_offset, &fab_slope);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Unable to get fab id coefficients\n");
> +		return -EINVAL;
> +	}
> +
> +	switch (chan_address) {
> +	case RR_ADC_SKIN_TEMP:
> +		*val = MILLI;
> +		*val2 = RR_ADC_BATT_THERM_LSB_K;
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_USBIN_I:
> +		*val = RR_ADC_CURR_USBIN_INPUT_FACTOR_MIL *
> +		       RR_ADC_FS_VOLTAGE_MV;
> +		*val2 = RR_ADC_CHAN_MSB;
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_DCIN_I:
> +		*val = RR_ADC_CURR_INPUT_FACTOR * RR_ADC_FS_VOLTAGE_MV;
> +		*val2 = RR_ADC_CHAN_MSB;
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_USBIN_V:
> +	case RR_ADC_DCIN_V:
> +		*val = RR_ADC_VOLT_INPUT_FACTOR * RR_ADC_FS_VOLTAGE_MV * MILLI;
> +		*val2 = RR_ADC_CHAN_MSB;
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_GPIO:
> +		*val = RR_ADC_GPIO_FS_RANGE;
> +		*val2 = RR_ADC_CHAN_MSB;
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_CHG_TEMP:
> +		/*
> +		 * We divide val2 by MILLI instead of multiplying val
> +		 * to avoid an integer overflow.
> +		 */
> +		*val = -RR_ADC_TEMP_FS_VOLTAGE_NUM;
> +		*val2 = div64_s64(RR_ADC_TEMP_FS_VOLTAGE_DEN * RR_ADC_CHAN_MSB *
> +					  fab_slope,
> +				  MILLI);
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case RR_ADC_DIE_TEMP:
> +		*val = RR_ADC_TEMP_FS_VOLTAGE_NUM;
> +		*val2 = RR_ADC_TEMP_FS_VOLTAGE_DEN * RR_ADC_CHAN_MSB *
> +			RR_ADC_DIE_TEMP_SLOPE;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		break;

		return -EINVAL; and drop the one below.

> +	}
> +
> +	return -EINVAL;
> +}
> +


...

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
> +	if (IS_ERR_VALUE(chip->pmic)) {

Isn't IS_ERR() more appropriate?

> +		dev_err(chip->dev, "Unable to get reference to PMIC device\n");
> +		return PTR_ERR(chip->pmic);
> +	}

