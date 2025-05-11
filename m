Return-Path: <linux-iio+bounces-19429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C3AB2853
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174673ADBBC
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB22571A7;
	Sun, 11 May 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiiZ4j+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A986344;
	Sun, 11 May 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969093; cv=none; b=TLN5d2ojHs8bJjP+7dcb37Azsv3KkXnY3svAY2MpBW+RqYuEgfo6JyFXvw6M8Ce09v0hfqIBLpMQMH9Xa5LJ1MvM+FMqwJQy99kdSL2RFQUnt4M+HexZIPvI3e4zZ7aqukSIheHxytI1x35Yew3Dvx+UWv8He3zKL9gX5zfCnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969093; c=relaxed/simple;
	bh=M9OR5ZiUK3Fib7rUpLHTME7xYEsacjwm0GZp+YtVLFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPcdSa1pY3m7+3JUOQcLshsbulgIaRhun5nNq+6d82cLUXcPJlYJZpIvyOOBwBaSWBqRS/8otkB6+SpOLb+bSabubCfCGXdKu86ao3qp6HH/FDlIEXqoevpOnVh+JmWLvyClad8tf6wd2ezDHJ9l1ZQRlrbIpSB/bLmvAIuO4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiiZ4j+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF56C4CEE4;
	Sun, 11 May 2025 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746969093;
	bh=M9OR5ZiUK3Fib7rUpLHTME7xYEsacjwm0GZp+YtVLFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiiZ4j+Pm5nln0qCzGDKhaytmCTZsXccEXxLEmQEKPpDb7xSQ8F+W5QpWsLJDFCUz
	 lq7o4AorDi/Mu3qRKT3oQkdZQQM+XVlvu78hc6WZ4b1+TDGmSpwln2wjb+jlfPNweR
	 rlV4CkZEdi+8u4Elxyt8q+A94qH/Fbzw16egmX/qdFzSdiHP42RXG3foA38j06JdyM
	 72qsM9KSkadcy/mcehhofSi4Pao7Ha2+epeeGFX7c57ulv5zfMam4T+Q+BnLmE/AZl
	 YlxeY9FI5ko2c975zIa6diCTE7+OT7g154ppt+orpKddY8yc+AEtUgs1NKNH09toGA
	 RNcJeFbhjMluA==
Date: Sun, 11 May 2025 14:11:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V6 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20250511141120.58941a45@jic23-huawei>
In-Reply-To: <20250509110959.3384306-6-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-6-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:39:59 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu,

A few minor things inline.

Jonathan

> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..c63822635f10
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

> +static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
> +{
> +	unsigned int i, channel;
> +	struct thermal_zone_device *tzd;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		channel = V_CHAN(adc_tm5->chan_props[i].common_props);
> +		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
> +						    &adc_tm5->chan_props[i],
> +						    &adc_tm_ops);
> +
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) == -ENODEV) {
> +				dev_warn(adc_tm5->dev,
> +					 "thermal sensor on channel %d is not used\n",
> +					 channel);
> +				continue;
> +			}
> +			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
> +					     "Error registering TZ zone:%ld for channel:%d\n",
> +					     PTR_ERR(tzd), channel);
> +		}
> +		adc_tm5->chan_props[i].tzd = tzd;
> +		devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);

Can fail so unusual not to see an error check.  Add a comment if intended.

> +	}
> +	return 0;
> +}

> +
> +static int adc_tm5_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *id)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
> +	struct device *dev = &aux_dev->dev;
> +	int i, ret;
> +
> +	adc_tm5 = devm_kzalloc(&aux_dev->dev, sizeof(*adc_tm5), GFP_KERNEL);

Use dev

> +	if (!adc_tm5)
> +		return -ENOMEM;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
> +				       aux_dev);
> +
> +	adc_tm5->dev = dev;
> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
> +	adc_tm5->chan_props = devm_kcalloc(adc_tm5->dev, aux_dev_wrapper->n_tm_channels,

Might as well use dev here too.

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
> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
> +
> +	/*
> +	 * Skipping first SDAM IRQ as it is requested in parent driver.
> +	 * If there is a TM violation on that IRQ, the parent driver calls
> +	 * the notifier (tm_event_notify) exposed from this driver to handle it.
> +	 */
> +	for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
> +		ret = devm_request_threaded_irq(adc_tm5->dev,
> +						adc_tm5->dev_data->base[i].irq,
> +						NULL, adctm5_gen3_isr, IRQF_ONESHOT,
> +						adc_tm5->dev_data->base[i].irq_name,
> +						adc_tm5);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/*
> +	 * This drvdata is only used in the function (adctm_event_handler)
> +	 * called by parent ADC driver in case of TM violation on the first SDAM.
> +	 */
> +	auxiliary_set_drvdata(aux_dev, adc_tm5);
> +
> +	ret = devm_add_action(adc_tm5->dev, adc5_gen3_clear_work, adc_tm5);

I'd add a comment on what this is undoing as normally devm clean up matches
something being started and there is no obvious sign of what that is here.

> +	if (ret)
> +		return ret;
> +
> +	ret = adc_tm5_register_tzd(adc_tm5);

return adc_tm5...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

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

module_auxiliary_driver() not work for some reason?

> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");


