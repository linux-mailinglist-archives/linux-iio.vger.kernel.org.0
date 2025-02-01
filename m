Return-Path: <linux-iio+bounces-14804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFEA248E1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B923A769C
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2469199932;
	Sat,  1 Feb 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsFMixwr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08E84A30;
	Sat,  1 Feb 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738411908; cv=none; b=SR2lfZdOfkpjijBXql4lIiUHGVCqIEAlX1aE9aaHXz8Wnj1ikvLrc+5ByVk/nCA2UU7L0AvFkDCdgw6yP8zcNxf/ffLgA/t6GAylCkP8DlWxe3fURRH9XuMeK9iiRl/WhQbweAm2W/G4W2WafZS27zfvRaefXqJTvmnLK8auDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738411908; c=relaxed/simple;
	bh=ehwDDXHoAz8f/AVmdl/QehcDzJf88ZByr8VYfsanKZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek+IOYcimpc0lQ2LbUCv+Ex1QartBJysTd517QSXMaGpIvvHlprOsU3GCAinch+SKkl+aNpjXEfP20+5D+YUuIhTeiRYAJ97z24SNZCz9wq88KA2CmE61JkUR8vLVJQZ14gq4qzWHa/EXti2rOxbD5hpkNqXhZPed2CS4tK99hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsFMixwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B01C4CED3;
	Sat,  1 Feb 2025 12:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738411908;
	bh=ehwDDXHoAz8f/AVmdl/QehcDzJf88ZByr8VYfsanKZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PsFMixwrXXvgaT9E0/HOqrtJwBWNhcgpDL3xA3H8G5m/PLSl9BlodCN8TyFconC3S
	 Gg6C3s4w8NAqmOGMhzfp8Vl6mMG1jH6mJ+OO8Mw3Blahes+6C8SGmUG25IiZVVrnHj
	 CBFRNv5P4+y0KdL7yfo3OGqcH13Jy3k9pQ2zmp5z9FIkcK6fzG0nNRtIA+upBxzz96
	 BfkdvSS+OCYUd/yPwU1yo8FhU1ry/cgYushw5X5N7WzcnkUYQUABgaG0/HhyZ+ZdFL
	 ep0sv68wSg3LdN29mlMch/ko4wUxz4ebHJ0Mw1D3GPE9+SiYVB+009+nPhAskgqAk2
	 O4vdfbuKGyqMw==
Date: Sat, 1 Feb 2025 12:11:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 lars@metafoo.de, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20250201121134.53040aae@jic23-huawei>
In-Reply-To: <20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Feb 2025 00:02:41 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi,

A few minor things inline.  One general one is keep to under 80 chars
for line wrap unless going over that makes a significant improvement
to readability.

Jonathan

> ---
> Changes since v4:
> - Moved out common funtions from newly added .h file into a separate .c
>   file to avoid duplicating them. Updated interrupt name as suggested
>   by reviewer. Updated namespace export symbol statement to have a string
>   as second argument to follow framework change.
> 
> Changes since v3:
> - Split out TM functionality into auxiliary driver in separate patch and
>   added required changes in main driver.
> - Addressed other reviewer comments in main driver patch. 
> 
> Changes since v1:
> - Removed datashet_name usage and implemented read_label() function
> - In probe, updated channel property in iio_chan_spec from individual
>   channel to virtual channel and set indexed property to 1, due to the
>   above change.
> - Updated order of checks in ISR
> - Removed the driver remove callback and replaced with callbacks in a
>   devm_add_action call in probe.
> - Addressed other comments from reviewers.
> 
>  drivers/iio/adc/Kconfig                       |  30 +
>  drivers/iio/adc/Makefile                      |   2 +
>  drivers/iio/adc/qcom-adc5-gen3-common.c       |  99 +++
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 724 ++++++++++++++++++
>  include/linux/iio/adc/qcom-adc5-gen3-common.h | 164 ++++
>  5 files changed, 1019 insertions(+)
>  create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
>  create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>  create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..d0cedb9262ab 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1165,6 +1165,36 @@ config QCOM_SPMI_ADC5
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called qcom-spmi-adc5.
>  
> +config QCOM_ADC5_GEN3_COMMON
> +	tristate
> +
> +config QCOM_SPMI_ADC5_GEN3
> +	tristate "Qualcomm Technologies Inc. SPMI PMIC5 GEN3 ADC"
> +	depends on SPMI && THERMAL
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	select QCOM_ADC5_GEN3_COMMON
> +	select AUXILIARY_BUS
> +	help
> +	  This is the IIO Voltage PMIC5 Gen3 ADC driver for Qualcomm Technologies Inc. PMICs.
#
As with the code, keep the wrap to sub 80 chars.

> +
> +	  The driver supports reading multiple channels. The ADC is a 16-bit
> +	  sigma-delta ADC. The hardware supports calibrated results for
> +	  conversion requests and clients include reading phone power supply
> +	  voltage, on board system thermistors connected to the PMIC ADC,
> +	  PMIC die temperature, charger temperature, battery current, USB voltage
> +	  input and voltage signals connected to supported PMIC GPIO pins. The
> +	  hardware supports internal pull-up for thermistors and can choose between
> +	  a 30k, 100k or 400k ohm pull up using the ADC channels.
> +
> +	  In addition, the same driver supports ADC thermal monitoring devices too.
> +	  They appear as thermal zones with multiple trip points. A thermal client sets
> +	  threshold temperature for both warm and cool trips and gets updated when a
> +	  threshold is reached.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called qcom-spmi-adc5-gen3.
> +

> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> new file mode 100644
> index 000000000000..df1084a690fc
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> @@ -0,0 +1,99 @@
...

> +
> +/*
> + * Worst case delay from PBS in readying handshake bit
> + * can be up to 15ms, when PBS is busy running other
> + * simultaneous transactions, while in the best case, it is
> + * already ready at this point. Assigning polling delay and
> + * retry count accordingly.
> + */
> +
> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
> +#define ADC5_GEN3_HS_RETRY_COUNT		150
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc,
> +			   unsigned int sdam_index)
> +{
> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	int ret, count;
> +	u8 status = 0;
> +
> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (status == ADC5_GEN3_HS_READY) {
> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
> +					     &conv_req, 1);
> +			if (ret)
> +				return ret;
> +
> +			if (!conv_req)
> +				return 0;
> +		}
> +
> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US, ADC5_GEN3_HS_DELAY_MAX_US);
fsleep() perhaps as I doubt the extra tolerance that will give will matter
much.
> +	}
> +
> +	pr_err("Setting HS ready bit timed out, sdam_index:%d, status:%#x\n", sdam_index, status);
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL(adc5_gen3_poll_wait_hs);

At some point may be worth namespacing all these exports.
Probably not in this series though!

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..9cdc2d5d2671
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,724 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +#include <linux/thermal.h>
> +#include <linux/unaligned.h>
> +
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
> +
> +#define ADC5_GEN3_VADC_SDAM			0x0
> +
> +struct adc5_chip;
> +
> +/*
> + * @adc_tm: indicates TM type if the channel is used for TM measurements.

Add docs for common_props as well and might as well make this
full kernel-doc.

> + * @chip: pointer to top-level ADC device structure.
> + */
> +
> +struct adc5_channel_prop {
> +	struct adc5_channel_common_prop common_props;
> +	int				adc_tm;
> +	struct adc5_chip		*chip;
> +};


> +
> +static int adc5_gen3_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int *val, int *val2,
> +			      long mask)
> +{
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	struct adc5_channel_common_prop *prop;
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	prop = &adc->chan_props[chan->address].common_props;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
> +		if (ret)
> +			return ret;
> +
> +		ret = qcom_adc5_hw_scale(prop->scale_fn_type, prop->prescale,
> +					 adc->data, adc_code_volt, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adc5_gen3_do_conversion(adc, prop, &adc_code_volt);
> +		if (ret)
> +			return ret;
> +		*val = (int)adc_code_volt;

Why is the cast needed?

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static const struct adc5_data adc5_gen3_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen3_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +				{85, 340, 1360},
> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +				{15, 100, 200, 300, 400, 500, 600, 700,
> +				1000, 2000, 4000, 8000, 16000, 32000,
> +				64000, 128000},

Trivial but I'm trying to slowly standardize formatting of this stuff
in IIO.  So please add space after { and before }
Also align the the first digit of first number in each row.


> +};


> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +{
> +	struct tm5_aux_dev_wrapper *aux_device;
> +	int i, ret, i_tm = 0;
> +
> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);
> +	if (!aux_device)
> +		return -ENOMEM;
> +
> +	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.dev.parent = adc->dev;
> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
> +
> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
> +					    sizeof(*aux_device->tm_props), GFP_KERNEL);
> +	if (!aux_device->tm_props)
> +		return -ENOMEM;
> +
> +	aux_device->dev_data = &adc->dev_data;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
> +		i_tm++;
> +	}
> +
> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
> +
> +	aux_device->n_tm_channels = adc->n_tm_channels;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret) {
> +		kfree(&aux_device->aux_dev);
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux, &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(&aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux, &aux_device->aux_dev);
> +	if (!ret)
> +		adc->tm_aux = &aux_device->aux_dev;
Keep to errors out of line, even if it costs a line or two exta
	if (ret)
		return ret;

	adc->tm_aux = &aux_device->aux_dev;

r	return 0;
> +
> +	return ret;
> +}
> +
> +void adc5_take_mutex_lock(struct device *dev, bool lock)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	if (lock)
> +		mutex_lock(&adc->lock);
> +	else
> +		mutex_unlock(&adc->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_take_mutex_lock, "QCOM_SPMI_ADC5_GEN3");

This is potentially going to make a mess for sparse.  Might be better to split
it in two so you can had __acquires and __releases markings.

If you don't get any warnings with sparse then I guess we are fine.

> +
> +int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,
> +				 int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +	u16 adc_code_volt;
> +	int ret;
> +
> +	ret = adc5_gen3_do_conversion(adc, common_props, &adc_code_volt);
> +	if (ret)
> +		return ret;
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
> +		adc->data, adc_code_volt, val);

Whilst it feels like this could all have been done with generic in kernel consumer
interfaces, I suppose that in this case the coupling is tight enough between
the devices that there is no real purpose in doing so.

> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_get_scaled_reading, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
> +	struct adc5_chip *adc = iio_priv(indio_dev);
> +
> +	return qcom_adc5_hw_scale(common_props->scale_fn_type, common_props->prescale,
> +		adc->data, code, val);

Where it doesn't make much difference to readablity wrap to 80 chars and align parameters after (

> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
> +
> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct adc5_chip *adc;
> +	struct regmap *regmap;
> +	int ret, i;
> +	u32 *reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev_data.regmap = regmap;
> +	adc->dev = dev;
> +
> +	ret = device_property_count_u32(dev, "reg");
> +	if (ret < 0)
> +		return ret;
> +
> +	adc->num_sdams = ret;
> +	adc->dev_data.num_sdams = adc->num_sdams;

why do we need two copies?

> +
> +	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
> +	if (!reg)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read reg property, ret = %d\n", ret);

Look at how dev_err_probe works. You should not be explicitly printing ret.
Fix all instances of this (and if copied from another driver, feel free to fix that too!)

> +
> +	adc->dev_data.base = devm_kcalloc(dev, adc->num_sdams, sizeof(*adc->dev_data.base),
> +					  GFP_KERNEL);
> +	if (!adc->dev_data.base)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
> +
> +	for (i = 0; i < adc->num_sdams; i++) {
> +		adc->dev_data.base[i].base_addr = reg[i];
> +
> +		adc->dev_data.base[i].irq_name = devm_kasprintf(dev, GFP_KERNEL, "sdam%d", i);
> +		if (!adc->dev_data.base[i].irq_name)
> +			return -ENOMEM;
> +
> +		ret = platform_get_irq_byname(pdev, adc->dev_data.base[i].irq_name);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Getting IRQ %d by name failed, ret = %d\n",
> +					adc->dev_data.base[i].irq, ret);
> +		adc->dev_data.base[i].irq = ret;
> +	}
> +
> +	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq, adc5_gen3_isr,
> +			       0, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name, adc);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to request SDAM%d irq, ret = %d\n",
> +				ADC5_GEN3_VADC_SDAM, ret);
> +
> +	ret = adc5_get_fw_data(adc);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (adc->n_tm_channels > 0)
> +		adc5_gen3_add_aux_tm_device(adc);
> +
> +	indio_dev->name = pdev->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> new file mode 100644
> index 000000000000..66edbf0ae137
> --- /dev/null
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -0,0 +1,164 @@
...


> +#define ADC5_GEN3_VIRTUAL_SID_MASK			GENMASK(15, 8)
> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
> +#define V_CHAN(x)		\
> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)	\

That trailing \ makes little sense and will be fragile to white space
changes.

> +
> +enum adc5_cal_method {
> +	ADC5_NO_CAL = 0,
> +	ADC5_RATIOMETRIC_CAL,
> +	ADC5_ABSOLUTE_CAL

Add a comma on trailing item.  Not immediately obvious we will never
get anything after this so convention is to have that comma.
That doesn't apply for terminating entries that we must not add
antyhing after.

> +};
...
> +/*

Looks like valid kernel doc, so /** and check it builds fine
with the kernel-doc script.

> + * struct adc5_channel_prop - ADC channel property.
> + * @channel: channel number, refer to the channel list.
> + * @cal_method: calibration method.
> + * @decimation: sampling rate supported for the channel.
> + * @sid: slave id of PMIC owning the channel.

In common with most of the kernel, if there is another name that
can be used, I'd prefer avoiding that term.
ID probably fine for example or leave it ambiguous as SID

> + * @label: Channel name used in device tree.
> + * @prescale: channel scaling performed on the input signal.
> + * @hw_settle_time: the time between AMUX being configured and the
> + *	start of conversion.

Good to include units in the docs and maybe the field name.

> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @scale_fn_type: Represents the scaling function to convert voltage
> + *	physical units desired by the client for the channel.
> + */
> +struct adc5_channel_common_prop {
> +	unsigned int			channel;
> +	enum adc5_cal_method		cal_method;
> +	unsigned int			decimation;
> +	unsigned int			sid;
> +	const char			*label;
> +	unsigned int			prescale;
> +	unsigned int			hw_settle_time;
> +	unsigned int			avg_samples;
> +	enum vadc_scale_fn_type		scale_fn_type;
> +};
> +
> +struct tm5_aux_dev_wrapper {
> +	struct auxiliary_device aux_dev;
> +	struct adc5_device_data *dev_data;
> +	struct adc5_channel_common_prop *tm_props;
> +	unsigned int			n_tm_channels;

Odd indent on that last item.  Just stick to one space.
I'd do that for all structures as trying to align has a nasty habit of
needing noisy changes as a driver evolves in a desperate attempt to keep
things looking pretty.

> +};
> +
> +struct adc_tm5_auxiliary_drv {
> +	struct auxiliary_driver adrv;
> +	void (*tm_event_notify)(struct auxiliary_device *adev);
> +};
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len);
> +
> +int adc5_gen3_poll_wait_hs(struct adc5_device_data *adc, unsigned int sdam_index);
> +
> +void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data);
> +
> +int adc5_gen3_status_clear(struct adc5_device_data *adc,
> +			   int sdam_index, u16 offset, u8 *val, int len);
> +
> +void adc5_take_mutex_lock(struct device *dev, bool lock);
> +int adc5_gen3_get_scaled_reading(struct device *dev, struct adc5_channel_common_prop *common_props,

Very long lines. Please add a break after dev,

Generally I prefer that we still aim for 80 chars in IIO, but a bit
over is fine if useful for readability.

> +				 int *val);
> +int adc5_gen3_therm_code_to_temp(struct device *dev, struct adc5_channel_common_prop *common_props,
> +				 u16 code, int *val);
> +
> +#endif /* QCOM_ADC5_GEN3_COMMON_H */


