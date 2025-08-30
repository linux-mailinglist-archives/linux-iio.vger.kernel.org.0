Return-Path: <linux-iio+bounces-23484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E846B3CE76
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908181B23481
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60112D8372;
	Sat, 30 Aug 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpOHG9Z0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90255214A9B;
	Sat, 30 Aug 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756576706; cv=none; b=ODJVnPn2hzbJA0/S9CaEneRCgBXI2NBkBxbkfGrU9xdnupCIIhcRwbJ/s36fXSIGxcnL7CNHM1a9ufIU3Od4+9cooseQxiaNc3dhIQfnk/xJjEGfwqmYeqN1ZGdTxHqpUqMmiV/9Ao2rUnzC/ej+yCyUYuVfXG9qmYKYS86W6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756576706; c=relaxed/simple;
	bh=gLEo2uJLmeD2rR9NOYEoCgLlxswyya3IZn7gOnZtxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRw/oqjmKFRpn+NpvyiNQtgVa9z36J0c5ZeLHKTRpbIZeK+UXdBPpQgBQ4qt7wfqld9cJGoI8V04sUz8CeXaP9Dt/pOYqdS183orDePfsz/Sv3BYpPKKsWhkr21T75IyuEbEd0q0nmmXdyel8xeWaJLC7mBa41ukmqomuH+TFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpOHG9Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98409C4CEEB;
	Sat, 30 Aug 2025 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756576706;
	bh=gLEo2uJLmeD2rR9NOYEoCgLlxswyya3IZn7gOnZtxFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpOHG9Z0DYuWh8xIkWjRHdBtNFjJj/psL6PFm0jZXSPaYqOcl/AXbIBmDcX2hD9YY
	 8hqmvUXWIV/Dlu3PwzLO32cecNlaiqLGkI01yDFerWB/YxVgQvW4SU5/5Ln0iTuUrH
	 Wf4sqaFG9npL4Jk5DlAN/UIj2lgCuc2ICc3uHsE9UIDYkc2C9V46embsFkYdO0Nymp
	 HbRHSjKj7SVMR1/VHT4R1kQ87fuH8PHNjxongb+aFjm2eiucDO6KCmUqVzSM4mF2Sh
	 wMmiSTN0M+SXl/yqkOiFN694gPvF3RFsg7hc+FN2vATTpXyP1qnh+h4otBQ2k2Llha
	 OuX3pFTa8QG4A==
Date: Sat, 30 Aug 2025 18:58:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 5/5] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20250830185809.5bc010cb@jic23-huawei>
In-Reply-To: <20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
	<20250826083657.4005727-6-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 14:06:57 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu,

A few comment inline from a fresh read

Jonathan


> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..9ec0d4e058b8
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> @@ -0,0 +1,535 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */


> +
> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
> +							 tm_handler_work);
> +	struct adc_tm5_gen3_channel_props *chan_prop;
> +	u8 tm_status[2] = {0};
> +	u8 buf[16] = {0};

Small preference for { };
which is effectively the same but for structures (so not relevant here) that is
also defined by newer c specs to initialize holes which the {0}; version is not
(but actually does in compilers with the settings the kernel uses).

> +	int i, ret = 0, sdam_index = -1;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		int temp, offset;
> +		u16 code = 0;
> +
> +		chan_prop = &adc_tm5->chan_props[i];
> +		offset = chan_prop->tm_chan_index;
> +
> +		adc5_gen3_mutex_lock(adc_tm5->dev);
> +		if (chan_prop->sdam_index != sdam_index) {
> +			sdam_index = chan_prop->sdam_index;
> +			ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
> +							tm_status, buf);
> +			if (ret) {
> +				adc5_gen3_mutex_unlock(adc_tm5->dev);
> +				break;
> +			}
> +		}
> +
> +		if ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en)
> +			upper_set = true;
		upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en;

seems as clear to me and avoid need to initialize above.

The
	for (i...) {
		if (x)
			b = true;
	}

pattern made me thing this was a check that built up over iterations, but it's
not so avoiding that is probably a good thing as well!

> +
> +		if ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en)
> +			lower_set = true;
> +		adc5_gen3_mutex_unlock(adc_tm5->dev);
> +
> +		if (!(upper_set || lower_set))
> +			continue;
> +
> +		code = get_unaligned_le16(&buf[2 * offset]);
> +		pr_debug("ADC_TM threshold code:%#x\n", code);
> +
> +		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
> +						   &chan_prop->common_props,
> +						   code, &temp);
> +		if (ret) {
> +			dev_err(adc_tm5->dev,
> +				"Invalid temperature reading, ret = %d, code=%#x\n",
> +				ret, code);
> +			continue;
> +		}
> +
> +		chan_prop->last_temp = temp;
> +		chan_prop->last_temp_set = true;
> +		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
> +	}
> +}


> +
> +static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
> +				  int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
> +	u8 conv_req = 0, buf[ADC_TM5_GEN3_CONFIG_REGS];
Spit these sort of complex mix of types of declaration up.
	u8 buf[*];
	u8 conv_reg = 0;

etc as it helps readability.  Generally I wouldn't mix assignment and
non assignment and also not arrays or pointers and non pointers etc.

> +	u16 adc_code;
> +	int ret;

> +
> +	/* Select HW settle delay for channel */
> +	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
> +			    prop->common_props.hw_settle_time_us);
> +
> +	/* High temperature corresponds to low voltage threshold */
> +	if (high_temp != INT_MAX) {
> +		prop->low_thr_en = true;
Perhaps neater as a assignment then use of the bool

	prop->low_thr_en = (hightemp != INT_MAX);
	if (prp->low_thr_en) {
		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
		put_unaligned_le16(adc_code, &buf[8]);
	}

Applies to below similar case as well.

	
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
> +		put_unaligned_le16(adc_code, &buf[8]);
> +	} else {
> +		prop->low_thr_en = false;
> +	}
> +
> +	/* Low temperature corresponds to high voltage threshold */
> +	if (low_temp != -INT_MAX) {
> +		prop->high_thr_en = true;
> +		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
> +		put_unaligned_le16(adc_code, &buf[10]);
> +	} else {
> +		prop->high_thr_en = false;
> +	}
> +
> +	buf[7] = 0;
> +	if (prop->high_thr_en)
> +		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
> +	if (prop->low_thr_en)
> +		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
> +
> +	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_SID,
> +			      buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +
> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
> +	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
> +			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
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
> +	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
> +	if (!adc_tm5)
> +		return -ENOMEM;
> +
> +	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
> +				       aux_dev);
> +
> +	adc_tm5->dev = dev;
> +	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
> +	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
> +	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
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
> +	ret = devm_add_action_or_reset(dev, adc5_gen3_disable, adc_tm5);

I'd normally expect a pairing of a devm action with whatever it is undoing.
If not add a comment for why that isn't the case here.

> +	if (ret)
> +		return ret;
> +
> +	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);

> +}
> +
> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
> +	{}

For IIO drivers I'm trying to slowly standardize some formatting choices.
For these I picked (for no particular reason)
	{ }

> +};

