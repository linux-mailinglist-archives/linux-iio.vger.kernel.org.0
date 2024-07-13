Return-Path: <linux-iio+bounces-7594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998F930579
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBF1C21117
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7612FF8B;
	Sat, 13 Jul 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLPw2HaO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1194655D;
	Sat, 13 Jul 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720871997; cv=none; b=JtKydY+CHPzsKKovLmo2IZw+apKYpxuUUeEd/itmTW1pEQdEZ4+fO+JQMLQxk1tqAatxsSMEuxggqs0x99m2tq+FFRx4WaxLjGKLh78dH3EAYpZr5m3RWi1TXwVC5+nNZIiHyHaq9+vzc93iCVQlWDBTue2/9enIrwkQywLrIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720871997; c=relaxed/simple;
	bh=Yq6fJg/h8DFIIoU0ctZsTTxF8liT3kvtTHSTd25fz5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meqavSaBy33tvs+yJSdOljrGLC1eJ9ucttYFU8VNd70vo8Hzh2xfL9ypp3NuYuYRniec/fP7wSMvmn3QjHpx+0EfpvDpsicUqfHLVgiuN0QydipvAyjSv7f0NImxOiLdiWSNgOQGSJJKt37ES1fyKF62FmlwmJ7++i/W1jS0H2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLPw2HaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AEFC32781;
	Sat, 13 Jul 2024 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720871996;
	bh=Yq6fJg/h8DFIIoU0ctZsTTxF8liT3kvtTHSTd25fz5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLPw2HaOW5AuBBpS7V486IFERxPgRSbWJOzfZh9t83A92SPQxbmhjzGs4YVf74Yyb
	 EP9hKwwUjN/7a8ywbiBpXPLHWrCss2Wqam5V0ri7PUzxVH390DgNHgIqn3aqeOfO+5
	 kOs98+4MaNjQ9uTaw4ZxOK6NQjNGvKhromoo89bqoTehoSODD/FyLPaO9G0U0Avxp0
	 vDvGAXD/q5CcfseKgmdDogmVlvLXIiOK5IWB04X4StbxgkMoN6ANOWFFa0ZTTp4tmK
	 T1AVl7NNLE3f3NjUcKn/6FrClvRRMM4FzZSndv4zY5r8zrqZGeoNPHaA3YO9AgRKNs
	 LkxyFe2n1YGww==
Date: Sat, 13 Jul 2024 12:59:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, "Thara
 Gopinath" <thara.gopinath@gmail.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Kamal
 Wadhwa <quic_kamalw@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Jishnu Prakash <quic_jprakash@quicinc.com>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>, Ajit Pandey
 <quic_ajipan@quicinc.com>, "Imran Shaik" <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH 3/5] thermal: qcom: Add support for MBG Temp monitor
Message-ID: <20240713125945.2acac680@jic23-huawei>
In-Reply-To: <20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
	<20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 18:13:30 +0530
Satya Priya Kakitapalli <quic_skakitap@quicinc.com> wrote:

> Add driver for the MBG thermal monitoring device. It monitors
> the die temperature, and when there is a level 1 upper threshold
> violation, it receives an interrupt over spmi. The driver reads
> the fault status register and notifies thermal accordingly.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

Hi Satya,

Some comments inline.

Jonathan

> diff --git a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> new file mode 100644
> index 000000000000..70964ea5a48d
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +#include <linux/iio/consumer.h>
> +
> +#include "../thermal_core.h"
> +
> +#define MBG_TEMP_MON_MM_MON2_FAULT_STATUS	0x50
> +
> +#define MON_FAULT_STATUS_MASK			GENMASK(7, 6)
> +#define MON_FAULT_STATUS_SHIFT			6
Use FIELD_GET() and FIELD_PREP() then no need to have shift defined.

> +#define MON2_LVL1_ERR				0x1
> +
> +#define MON2_LVL1_UP_THRESH			0x59
> +
> +#define MBG_TEMP_MON_MM_MON2_MISC_CFG		0x5f
> +#define UP_THRESH_EN				BIT(1)
> +
> +#define STEP_MV					8
> +#define MBG_DEFAULT_TEMP_MV			600
> +#define MBG_TEMP_CONSTANT			1000
> +#define MIN_TRIP_TEMP				25000
> +#define MAX_SUPPORTED_TEMP			160000
these are all device specific but don't sound it. I'd prefix them with MBG_TEMP


> +
> +static int mbg_tm_set_trip_temp(struct thermal_zone_device *tz, int low_temp,
> +						int temp)
> +{
> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret = 0, vtemp = 0;
> +
> +	mutex_lock(&chip->lock);

	guard(mutex)(&chip->lock);


As then you don't need to carefully unlock as it will be done at exit of scope.

> +
> +	/* The HW has a limitation that the trip set must be above 25C */
> +	if (temp > MIN_TRIP_TEMP && temp < INT_MAX) {
		int vtemp;

reduce the scope and it becomes clear no need to init.

> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
> +					 UP_THRESH_EN, UP_THRESH_EN);
> +		vtemp = temp_to_vtemp(temp);
> +		ret = mbg_tm_write(chip, MON2_LVL1_UP_THRESH, vtemp);
> +		if (ret < 0) {
> +			mutex_unlock(&chip->lock);
> +			return ret;
> +		}
> +	} else {
> +		dev_dbg(chip->dev, "Setting %d failed, set trip between 25C and INT_MAX\n", temp);
> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
> +					UP_THRESH_EN, 0);
> +	}
> +
> +	mutex_unlock(&chip->lock);
> +
> +	/*
> +	 * Configure the last_temp one degree higher, to ensure the
> +	 * violated temp is returned to thermal framework when it reads
> +	 * temperature for the first time after the violation happens.
> +	 * This is needed to account for the inaccuracy in the conversion
> +	 * formula used which leads to the thermal framework setting back
> +	 * the same thresholds in case the temperature it reads does not
> +	 * show violation.
> +	 */
> +	chip->last_temp = temp + MBG_TEMP_CONSTANT;
> +
> +	return ret;
> +}
> +
> +static const struct thermal_zone_device_ops mbg_tm_ops = {
> +	.get_temp = mbg_tm_get_temp,
> +	.set_trips = mbg_tm_set_trip_temp,
> +};
> +
> +static irqreturn_t mbg_tm_isr(int irq, void *data)
> +{
> +	struct mbg_tm_chip *chip = data;
> +	int ret;
> +	int val = 0;
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = mbg_tm_read(chip, MBG_TEMP_MON_MM_MON2_FAULT_STATUS, &val);
> +
> +	mutex_unlock(&chip->lock);
	scoped_guard(mutex, &chip->lock) {
		ret = mbg...
		if (ret < 0)
			return IRQ_HANDLED;
	}
avoids need to unlock before return and to me at least gives slightly more
readable code.

> +
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	val &= MON_FAULT_STATUS_MASK;
> +	if ((val >> MON_FAULT_STATUS_SHIFT) & MON2_LVL1_ERR) {

as above use FIELD_GET() with the mask - it is more readable and
does the mask and shift in one call.



> +		chip->last_temp_set = true;
> +		thermal_zone_device_update(chip->tz_dev,
> +					THERMAL_TRIP_VIOLATED);

I think the above is 80 chars on one line so no need to wrap.

> +		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
> +	} else {
> +		dev_dbg(chip->dev, "Lvl 1 upper threshold not violated, ignoring interrupt\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mbg_tm_probe(struct platform_device *pdev)
> +{
> +	struct mbg_tm_chip *chip;
> +	struct device_node *node = pdev->dev.of_node;
> +	u32 res;
> +	int ret = 0;
It's always set, so don't intiialize here.

> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +
> +	mutex_init(&chip->lock);
> +
> +	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chip->map)
> +		return -ENXIO;
> +
> +	ret = of_property_read_u32(node, "reg", &res);

I'm not sure on thermal subsystem opinion on this but I'd use
the property.h generic firmware property reading stuff rather than of
specific.  
device_property_read_u32()

> +	if (ret < 0)
> +		return ret;
> +
> +	chip->base = res;
> +
> +	chip->irq = platform_get_irq(pdev, 0);
> +	if (chip->irq < 0)
> +		return chip->irq;
> +
> +	chip->adc = devm_iio_channel_get(&pdev->dev, "thermal");
> +	if (IS_ERR(chip->adc))
> +		return PTR_ERR(chip->adc);
> +
> +	chip->tz_dev = devm_thermal_of_zone_register(&pdev->dev,
> +				 0, chip, &mbg_tm_ops);
> +	if (IS_ERR(chip->tz_dev)) {
> +		dev_err(&pdev->dev, "failed to register sensor\n");
> +		return PTR_ERR(chip->tz_dev);

		return dev_err_probe(...)

> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, NULL,
> +			mbg_tm_isr, IRQF_ONESHOT, node->name, chip);
> +
> +	return ret;

	return devm_request...

> +}

