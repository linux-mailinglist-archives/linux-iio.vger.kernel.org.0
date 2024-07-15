Return-Path: <linux-iio+bounces-7618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC9930FB1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 10:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4E61F21D9F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEF1849EB;
	Mon, 15 Jul 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhDCmiEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934991849C1
	for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031988; cv=none; b=V5txD/FFzncr2xtMBFXNnCXm/7viPpL44sO8oYUZk0sVGs5sb4PvubQHVYxnakT1DNt8hmJORVDaGldt4kjJn26IydGi05aciPBv16ea661qin3PXyLhLjX7Cr/im8XI3AvktCxrXj4CKcR1zXBUvAtzH5stDQZT3nRiNDsMNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031988; c=relaxed/simple;
	bh=4rv3ZaLzrCHj+vNPIJxdJ/7xjDGvjfI2TuhuAc/Fqsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUL/UHaWhXgAGIHeM6KnkOJ0AWP/7KXm+Dji+sRResP3SSCxigD65MYhicQ2C9ZY0QUquWZ9ZiIQFmnAKAEOmmQlinOoZlj5wXZ5htuqW9REFfhnvRgYWpvyCxWgsNAdys/B19Tpq+/yyFraerd+13PKcIjl8wGRYQWgeNCHTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mhDCmiEb; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so8623631a12.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2024 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721031985; x=1721636785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=izpUMq/N+icXqDvhWPk5JDHQzyB9a4mErF4XUK7MXok=;
        b=mhDCmiEb+ZuKue99KGk7ASIVQ1ok18zN0TMToACMGNFBZrFwW/79i1YkSQrG9ge8Vg
         9YU6GODJk83kW5UmRVXUKPidEpxEVJRbIUCY5Yhvx/rWzGvznsk4F5kr2qeJCvuY0/CL
         AbZUaOh6hjP9v55jcDYKJ1Dkegw5sZ5BlxUUA99mLXax6BONavNdCC7xF53xszNpK7DJ
         SNVg/YU7C9mFX/WaYVO+jOHDq+Iar1eNJUW/79OI7eY/AzftoLtmyi01Cx9+fbqxsyuZ
         GE2imd1X6a38nI5vhLAdV+rMrk7jQ2US3q32sULVM94BK9mOLLJlBzkq27haxGCLVfZx
         B0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031985; x=1721636785;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izpUMq/N+icXqDvhWPk5JDHQzyB9a4mErF4XUK7MXok=;
        b=HVHAXh62KnpunRsak4f+9/ClTrcwzrbIL/vDp/6lOl5FITAfe8ifA3Vq12ORR9IySa
         vhbJNb1NJXZq8tJXKs+mSCRwakzwCSravjfqZ/KVt+jMuIGOqD2zmcagQDunuA5RIQ91
         5PoLoTLioK0ZEF3XKmqoHaks5szSYd6YQNsL9OUWOJdoYczogEYU5Z6LSIDfmuAN+UR4
         C3OV8dgVcd/7IlZB93+ljfe5HsQ/8h3VmlLm4TYDqaeDF56oDpwxsYIthZUZfMV6yk1o
         2q4Ihxjz+QQAy9V82Rh8E/tAqQnSNgT8YC7tb6cODi16TtfmG1urd/YCUfEPTzTYWLWe
         LoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMMAr5fJp5i2FgAAuxdKMWZg94EKF94u6KOSJ3n1NziU9iqILglcfBV/HuHWRA456HEFVo0MUihs+cKLJHYvt2+xVwdYi53w1H
X-Gm-Message-State: AOJu0YwtMvCKMooDxO/vu//pB2Cv5/O7OrjVEwMCDmddQS3px0h1zE5U
	vwLTUmcciJVhy40cfwvp0Lw3KoMStA0WWFda88KsAsBzP4BLKINv1qXFiUnSxHo=
X-Google-Smtp-Source: AGHT+IHIsOArQak5PBruo5Gqh0M5LnWwb41hKRlcAptSfghWsy8ckC66GZbFeNGGR0GbsfD7A43EBQ==
X-Received: by 2002:a17:906:689b:b0:a72:83ad:f087 with SMTP id a640c23a62f3a-a799cc4f083mr645967966b.10.1721031984494;
        Mon, 15 Jul 2024 01:26:24 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3ab9sm191062366b.1.2024.07.15.01.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:26:24 -0700 (PDT)
Message-ID: <76ac592a-c2a9-413e-848e-a15a36173cf5@linaro.org>
Date: Mon, 15 Jul 2024 10:26:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] thermal: qcom: Add support for MBG Temp monitor
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Kamal Wadhwa <quic_kamalw@quicinc.com>, Taniya Das
 <quic_tdas@quicinc.com>, Jishnu Prakash <quic_jprakash@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240712-mbg-tm-support-v1-3-7d78bec920ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.07.2024 2:43 PM, Satya Priya Kakitapalli wrote:
> Add driver for the MBG thermal monitoring device. It monitors
> the die temperature, and when there is a level 1 upper threshold
> violation, it receives an interrupt over spmi. The driver reads
> the fault status register and notifies thermal accordingly.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---

[...]

>  drivers/thermal/qcom/Kconfig            |  11 ++
>  drivers/thermal/qcom/Makefile           |   1 +
>  drivers/thermal/qcom/qcom-spmi-mbg-tm.c | 269 ++++++++++++++++++++++++++++++++
>  3 files changed, 281 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..46045094020c 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
>  	  Thermal client sets threshold temperature for both warm and cool and
>  	  gets updated when a threshold is reached.
>  
> +config QCOM_SPMI_MBG_TM
> +	tristate "Qualcomm Technologies, Inc. SPMI PMIC MBG Temperature monitor"
> +	depends on OF && SPMI && IIO
> +	select REGMAP_SPMI
> +	help
> +	 This enables a thermal driver for the MBG thermal monitoring device.
> +	 It shows up in sysfs as a thermal sensor with two trip points.
> +	 It notifies the thermal framework when level 1 high threshold is
> +	 violated. The temperature reported by the thermal sensor reflects
> +	 the real time die temperature through ADC channel.
> +
>  config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 0fa2512042e7..bc18e08ee3e2 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>  qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>  				   tsens-8960.o
>  obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
> +obj-$(CONFIG_QCOM_SPMI_MBG_TM)	+= qcom-spmi-mbg-tm.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>  obj-$(CONFIG_QCOM_LMH)		+= lmh.o
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
> +
> +struct mbg_tm_chip {
> +	struct regmap			*map;
> +	struct device			*dev;
> +	struct thermal_zone_device	*tz_dev;
> +	struct mutex                    lock;
> +	unsigned int			base;
> +	int				irq;
> +	int				last_temp;
> +	bool				last_temp_set;
> +	struct iio_channel		*adc;
> +};
> +
> +struct mbg_map_table {
> +	int min_temp;
> +	int vtemp0;
> +	int tc;
> +};
> +
> +static const struct mbg_map_table map_table[] = {
> +	/* minT	vtemp0	tc */
> +	{ -60000, 4337, 1967 },
> +	{ -40000, 4731, 1964 },
> +	{ -20000, 5124, 1957  },
> +	{ 0,      5515, 1949 },
> +	{ 20000,  5905, 1940 },
> +	{ 40000,  6293, 1930 },
> +	{ 60000,  6679, 1921 },
> +	{ 80000,  7064, 1910 },
> +	{ 100000, 7446, 1896 },
> +	{ 120000, 7825, 1878 },
> +	{ 140000, 8201, 1859 },
> +};
> +
> +static int mbg_tm_read(struct mbg_tm_chip *chip, u16 addr, int *data)
> +{
> +	return regmap_read(chip->map, chip->base + addr, data);
> +}
> +
> +static int mbg_tm_write(struct mbg_tm_chip *chip, u16 addr, int data)
> +{
> +	return regmap_write(chip->map, chip->base + addr, data);
> +}
> +
> +static int mbg_tm_reg_update(struct mbg_tm_chip *chip, u16 addr, u8 mask, u8 val)
> +{
> +	return regmap_write_bits(chip->map, chip->base + addr, mask, val);
> +}

You're not saving much on code amount, or readability by adding these
accessors, r/w are used once and update is used twice.

> +
> +static int mbg_tm_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct mbg_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret, milli_celsius;
> +
> +	if (!temp)
> +		return -EINVAL;
> +
> +	if (chip->last_temp_set) {
> +		pr_debug("last_temp: %d\n", chip->last_temp);
> +		chip->last_temp_set = false;

last_temp_set -> last_thres_crossed?

> +		*temp = chip->last_temp;
> +		return 0;
> +	}

[...]

> +
> +	/* The HW has a limitation that the trip set must be above 25C */
> +	if (temp > MIN_TRIP_TEMP && temp < INT_MAX) {

INT_MAX -> MAX_SUPPORTED_TEMP?

> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
> +					 UP_THRESH_EN, UP_THRESH_EN);

regmap_set_bits

> +		vtemp = temp_to_vtemp(temp);
> +		ret = mbg_tm_write(chip, MON2_LVL1_UP_THRESH, vtemp);

regmap_write(...., temp_to_vtemp(temp))

> +		if (ret < 0) {
> +			mutex_unlock(&chip->lock);
> +			return ret;
> +		}
> +	} else {
> +		dev_dbg(chip->dev, "Setting %d failed, set trip between 25C and INT_MAX\n", temp);
> +		mbg_tm_reg_update(chip, MBG_TEMP_MON_MM_MON2_MISC_CFG,
> +					UP_THRESH_EN, 0);

regmap_clear_bits

[...]

> +	val &= MON_FAULT_STATUS_MASK;
> +	if ((val >> MON_FAULT_STATUS_SHIFT) & MON2_LVL1_ERR) {

FIELD_GET

> +		chip->last_temp_set = true;
> +		thermal_zone_device_update(chip->tz_dev,
> +					THERMAL_TRIP_VIOLATED);
> +		dev_dbg(chip->dev, "Notifying Thermal, fault status=%d\n", val);
> +	} else {
> +		dev_dbg(chip->dev, "Lvl 1 upper threshold not violated, ignoring interrupt\n");

Would such spurious IRQs carry any meaning at all?

[...]

> +static struct platform_driver mbg_tm_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-mbg-tm",
> +		.of_match_table = mbg_tm_match_table,
> +	},
> +	.probe  = mbg_tm_probe,

Double space

Konrad

