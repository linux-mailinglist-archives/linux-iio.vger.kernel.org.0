Return-Path: <linux-iio+bounces-14805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0EA248FE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DB33A44A2
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053D1A3AB9;
	Sat,  1 Feb 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVWTgqMS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC220318;
	Sat,  1 Feb 2025 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738412865; cv=none; b=h/5zUY7GZ/w8q4/B6HbLWmwUoEQD8O2SS0K5zA8YEMncBELkWueI6y+u2Mt8/HcruSjqCc28vs6suYRKbpfSCMpQIrDMq6lDC88K8DE5Yqy5JSXufgEElmsUTKoNIk6ui9uYHMKoA1LeV08KoTLoByXXixnTe0pNJ+q+ttSvz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738412865; c=relaxed/simple;
	bh=d2gitCcfXyVjh/Va1xgB9YHhFmFeYjmw6K+s66qxC0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgJuBNodZ0owiRWA51RT6YE1J/JyE+DK3Ln9W5dx0juRM4ouJ3rGsQ0WV+U3Y5n5gdGQh5EINjf0BkOnaoRBO6KwoMqrNyDowAzlwPwKrhJvR90HPPg03tnQt+8l9hD7XWw/aLPSO7+UnEtUUfBdUIJQ2Gv4uIPi3E+4LiUs1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVWTgqMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE79C4CED3;
	Sat,  1 Feb 2025 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738412865;
	bh=d2gitCcfXyVjh/Va1xgB9YHhFmFeYjmw6K+s66qxC0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gVWTgqMSgiDYD7dnYligksY2KpM+YbWeOm2AH9FKhZ+jIbzMYsY8ndmsq/EEfwbCr
	 v28IUMuQq4Z9upLtJjpQjZYzqsZDc4Yi0j/KCyKxPvLE/edOagXcsco///zPAjjgua
	 QObpJoLXxlzL76d6GAeoptvACc96Sar7+tIZOFKvvO4x6d0CrFeTdVXrM4a+lk1cWO
	 0mhSGPaN+3VT5cnoLZpPqkwAjidregwMrnEEJgG/Aw8fLsqwH3vZuyqfEf7B0yBpiw
	 tHeb5fQU0hJR7d1KeVo6t0wtbcp3zBMfpzgs3vVugS0UB8seTMr3OpXnNiveTJBdcw
	 +ioOx8gIhyy8Q==
Date: Sat, 1 Feb 2025 12:27:31 +0000
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
Subject: Re: [PATCH V5 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20250201122731.2762b1f8@jic23-huawei>
In-Reply-To: <20250131183242.3653595-6-jishnu.prakash@oss.qualcomm.com>
References: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
	<20250131183242.3653595-6-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Feb 2025 00:02:42 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which
> implements the threshold setting and interrupt generating
> functionalities of QCOM ADC_TM drivers, used to support thermal
> trip points.

Very short wrap. For commit descriptions 75 chars is fine.

> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Various minor comments inline.

Jonathan

> ---
> Changes since v4:
> - Fixed a compilation error and updated dependencies in config as suggested
>   by reviewer.
> 
>  drivers/thermal/qcom/Kconfig                  |   9 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 489 ++++++++++++++++++
>  3 files changed, 499 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 

> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..d384d7ae2617
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,489 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +#include <linux/unaligned.h>
> +
> +#include "../thermal_hwmon.h"
> +
> +struct adc_tm5_gen3_chip;
> +
> +/*
> + * @adc_tm: indicates if the channel is used for TM measurements.

Doesn't match the parts of the structure.
Make this full kernel-doc and then you can rely on automation to spot that.

> + * @tm_chan_index: TM channel number used (ranging from 1-7).
> + * @timer: time period of recurring TM measurement.
> + * @tzd: pointer to thermal device corresponding to TM channel.
> + * @high_thr_en: TM high threshold crossing detection enabled.
> + * @low_thr_en: TM low threshold crossing detection enabled.
> + * @last_temp: last temperature that caused threshold violation,
> + *	or a thermal TM channel.
> + * @last_temp_set: indicates if last_temp is stored.
> + */
> +
> +struct adc_tm5_gen3_channel_props {
> +	struct device			*dev;
> +	unsigned int			timer;
> +	unsigned int			tm_chan_index;
> +	unsigned int			sdam_index;
> +	struct adc5_channel_common_prop common_props;
> +	bool			high_thr_en;
> +	bool			low_thr_en;
> +	bool			meas_en;
> +	struct adc_tm5_gen3_chip	*chip;
> +	struct thermal_zone_device *tzd;
> +	int				last_temp;
> +	bool				last_temp_set;
> +};
> +
> +struct adc_tm5_gen3_chip {
> +	struct adc5_device_data	*dev_data;
> +	struct adc_tm5_gen3_channel_props	*chan_props;
> +	unsigned int		nchannels;
> +	struct device		*dev;
> +	struct work_struct		tm_handler_work;
> +};

This sort of aligning for pretty printing goes wrong too often. I'd just not do it
and use a single space only before field names.

Note it's already looking odd and will only get worse if future changes need
more space.


> +
> +static int _adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	int ret;
> +	u8 val;
> +
> +	prop->high_thr_en = false;
> +	prop->low_thr_en = false;
> +
> +	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(prop->tm_chan_index);
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
> +			      &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = MEAS_INT_DISABLE;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_TIMER_SEL, &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* To indicate there is an actual conversion request */
> +	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);

sizeof(val) for those 1s
Same applies in previous patch.  This acts as documentation and makes it hard to get the sizing
wrong.


> +}


> +static void adctm_event_handler(struct auxiliary_device *adev)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = auxiliary_get_drvdata(adev);
> +
> +	schedule_work(&adc_tm5->tm_handler_work);
> +}
> +
> +static int adc_tm5_probe(struct auxiliary_device *aux_dev, const struct auxiliary_device_id *id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
> +	struct device *dev = &aux_dev->dev;
> +	int i, ret;
> +
> +	adc_tm5 = devm_kzalloc(&aux_dev->dev, sizeof(*adc_tm5), GFP_KERNEL);
> +	if (!adc_tm5)
> +		return -ENOMEM;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper, aux_dev);
> +
> +	adc_tm5->dev = dev;
> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
> +	adc_tm5->chan_props = devm_kcalloc(adc_tm5->dev, aux_dev_wrapper->n_tm_channels,
> +					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
> +	if (!adc_tm5->chan_props)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
> +		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
> +		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
> +		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
> +		adc_tm5->chan_props[i].chip = adc_tm5;
> +	}
> +
> +	ret = devm_add_action_or_reset(adc_tm5->dev, adc5_gen3_disable, adc_tm5);
> +	if (ret)
> +		return ret;
> +

Maybe a comment on why you skip first sdam here.

> +	for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
> +		ret = devm_request_threaded_irq(adc_tm5->dev, adc_tm5->dev_data->base[i].irq, NULL,
> +						adctm5_gen3_isr, IRQF_ONESHOT,
> +						adc_tm5->dev_data->base[i].irq_name, adc_tm5);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);

I'd move this before the irq request.  Normally aim to have everything that might
use ready before we even request it. That avoids any issue with spurious irqs or
weird device state etc.

> +	ret = devm_add_action(adc_tm5->dev, adc5_gen3_clear_work, adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	ret = adc_tm5_register_tzd(adc_tm5);
> +	if (ret)
> +		return ret;
> +
> +	auxiliary_set_drvdata(aux_dev, adc_tm5);
Maybe add a comment that this is only in the notifier called from outside this
driver.  Otherwise it looks odd to register eveything and only then set
drvdata.  I went looking for what smelled like a bug.

> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
> +	{},

No trailing comma on a terminating entry like this.

> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
> +
> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
> +	.adrv = {
> +		.id_table = adctm5_auxiliary_id_table,
> +		.probe = adc_tm5_probe,
> +	},
> +	.tm_event_notify = adctm_event_handler,
> +};
> +
> +static int __init adctm5_init_module(void)
> +{
> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +static void __exit adctm5_exit_module(void)
> +{
> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +module_init(adctm5_init_module);
> +module_exit(adctm5_exit_module);

Can use module_auxiliary_driver() to replace this boilerplate.
The embedded adrv shouldn't stop that working that I can see.


> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");


