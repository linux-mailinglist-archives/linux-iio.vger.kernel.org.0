Return-Path: <linux-iio+bounces-26907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BFCAB81A
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9308A30050B4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60694246BD5;
	Sun,  7 Dec 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpz/UF4f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9861E4AB;
	Sun,  7 Dec 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765127059; cv=none; b=HkRzq53lAJi7pBuQHJjpM2Lm9R5VULutTJs1ToKeXy0teY1sAEfUz/iSeH8yn6K3UrlGtZSP9Y05fffcEYVF5lwdjRfEDP3Nw+me9rCdT4ppuor+nnAZp1v05FgqO4XASyH8lNsi3KKic71YoQJcsMvCSrtITnV2Xv/PQEs3HdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765127059; c=relaxed/simple;
	bh=KJLtZJF4YlnNvE54Gufo9xlhia0LAFoIMWhVglcOiak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fde5pjf+7X/6yPHv588nikokpLny8n0e+I2AIoy7poucIN4MiQDqiZZUHqw+wf6l040UNnrABKtba3f691FUlOtwAWU+wCb1ZBi/OqO1ax52usDWvrOOefOwXOBBTovnBhFU6sW4oO198xFwX1HE5vG+liG5VioK0qpDU7iVRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpz/UF4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A0C4CEFB;
	Sun,  7 Dec 2025 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765127057;
	bh=KJLtZJF4YlnNvE54Gufo9xlhia0LAFoIMWhVglcOiak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jpz/UF4fr3CqD7xB+e2krzMjA5K2DkOqc2f9RZdQCbnCNZD3/ftGAM0OCluKKwFKl
	 m0wqlhHR3eibzE2v2tVFxRjDb7cMBGmfICvGrqGVXkIIg9hSGu9YZNZZ1i9oHEes3P
	 NuKpaAbrhn3tQ+bzYwOAywxa5LjOWo+anrGDf83XVmDHsaxEOH+2kNeplvz1xTfU/J
	 e+ohqWlhI2MoE7nPRhh9rYa12/MNqyvTVsOr6SEwM9V1jMZb11cXpeFm/nRCp64yJK
	 wUaotIrnUJX8qlEjI4OeNKY8Fa87ekpTxVBAxjfAg0BvdQv6jJxP3ASITBRSVFVMRM
	 632uz4P0erL7w==
Date: Sun, 7 Dec 2025 17:04:01 +0000
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
Subject: Re: [PATCH V8 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20251207170401.1143fc22@jic23-huawei>
In-Reply-To: <20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
References: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
	<20251127134036.209905-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 19:10:36 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> drivers, used to support thermal trip points.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
Hi Jishnu

Fresh read threw up a few more comments from me.

See inline

Thanks,

Jonathan

> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> new file mode 100644
> index 000000000000..c6cc8ef76f7e
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

> +
> +static void tm_handler_work(struct work_struct *work)
> +{
> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
> +							 tm_handler_work);
> +	struct adc_tm5_gen3_channel_props *chan_prop;

Why not declare in the reduced scope below?  Then could probably combine
declaration and assignment for this, and offset.


> +	u8 tm_status[2] = { };
> +	u8 buf[16] = { };
> +	int sdam_index = -1;
> +	int i, ret;
> +
> +	for (i = 0; i < adc_tm5->nchannels; i++) {
It's considered fine in new kernel code to declare the loop variable
as
	for (int i = 0;

> +		bool upper_set, lower_set;
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

If you had the guard() below, could perhaps use scoped_guard() here
to avoid need for unlocking in error paths.
That would be at the cost of increased indent however, so may not be worth it
or that may suggest factoring out some of this code as a helper.

> +				break;
> +			}
> +		}
> +
> +		upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
> +		lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
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

> +static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
> +				      int low_temp, int high_temp)
> +{
> +	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
> +	struct adc_tm5_gen3_chip *adc_tm5;
> +	int ret;
> +
> +	if (!prop || !prop->chip)
> +		return -EINVAL;
> +
> +	adc_tm5 = prop->chip;
> +
> +	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +		prop->common_props.label, low_temp, high_temp);
> +
> +	adc5_gen3_mutex_lock(adc_tm5->dev);
> +	if (high_temp == INT_MAX && low_temp <= -INT_MAX)

How is low temp lower than the min value that fits in an integer?

> +		ret = adc_tm5_gen3_disable_channel(prop);
> +	else
> +		ret = adc_tm5_gen3_configure(prop, low_temp, high_temp);
> +	adc5_gen3_mutex_unlock(adc_tm5->dev);
Might be worth a DEFINE_GUARD() so you can do
	guard(adc5_gen3)(adc_tm5->dev);
	if (high_temp = INT_MAX && low_temp <= -INT_MAX)
		return adc_tm5_gen3_disable_channel(prop);
	
	return adc_tm5...

I haven't looked to see if this is useful elsewhere in these drivers.

> +
> +	return ret;
> +}

