Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35D2879E0
	for <lists+linux-iio@lfdr.de>; Thu,  8 Oct 2020 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgJHQWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Oct 2020 12:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHQWf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Oct 2020 12:22:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC50AC0613D2
        for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2020 09:22:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j136so7127553wmj.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2020 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SKUQEG77tLu/FcBREyxs8/i/I0c07XpqLijNhDKPkB4=;
        b=SNlUDjtvoEakd9ACg+hFSmG+L6kGpxQDAm2m8OIqeT3CyDHlB6WJOp34sbEw+OQJ69
         9XAxOcturXeH3Evmdq2nn4/sNlLLXr4NOE4CiZfX+YLXCOdulPzuXsvnrdDAJcX1gUtF
         8RWGlQqNt/cpndKUm/JjVS6UueW2fgVwhxPK2kKtGNpDyKypybef2c+KQ4XeT/eqZd44
         4NmwraN6Jnm56QHCCPKSgc0tnIRA++qhdi03WKogTBa3U0tnib6d7yrbIOzIgmTo8yxw
         Ai77AwImuJOIF9hV2VFKxen4prBIjuD7RgLN2kU+GYJGLRQ10tp3HLqxzmPohTifwXS9
         XiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SKUQEG77tLu/FcBREyxs8/i/I0c07XpqLijNhDKPkB4=;
        b=fX1ov33fcUTIwnm7tOPpLMhjRAxJ+mJv5OTo++3CqJ9aCSozx5BaMNrfpC7TLRUxKa
         uSLv2vYCrQjCSisQWR2WJh55m0EYKwlBQF0RCd+t9XwR5CiJoxM4isQWBgGTv96CsDPn
         mP5tosa4e/mE3fT7qFhIM7Msi/K0QeUWggtyQAlJAIMSx0JiTJQPJSNTGFPgCBsNEz6V
         1ZvfpvRzfLX6934e2RS8dH6NOwLqvzdv5LiLegZcTQGYD9WtbcDgmOT6Sw7BLvtGe1+r
         AygCorVl75zT5k9CcX94FGYwmmtGbQ+Mb2zw6oa3CSZ0wY0+Ncwo8oyuFBs2/tmM3WD3
         W1VA==
X-Gm-Message-State: AOAM530EnPhIEia5MpUav9kjPP3IYtEZ61QVwBEmmQovYEvmUVSQDU0i
        FSF4gjT/U6k7bTBCQ6SdHXHzEA==
X-Google-Smtp-Source: ABdhPJzlBsFh7FWZNxZu9MzIVhBWcv9Z73bZ+9rgEVlgDz6vS8CQCkBab4Wq5mUC5SoI3oGatinduA==
X-Received: by 2002:a1c:3283:: with SMTP id y125mr9885470wmy.61.1602174153033;
        Thu, 08 Oct 2020 09:22:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:bcbd:c839:6352:ebcd? ([2a01:e34:ed2f:f020:bcbd:c839:6352:ebcd])
        by smtp.googlemail.com with ESMTPSA id v17sm8275815wrc.23.2020.10.08.09.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 09:22:32 -0700 (PDT)
Subject: Re: [PATCH v7 07/10] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
 <20201007135433.1041979-8-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3d6bd019-1516-5307-ef49-b6279fbfbe82@linaro.org>
Date:   Thu, 8 Oct 2020 18:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007135433.1041979-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/10/2020 15:54, Dmitry Baryshkov wrote:
> Add support for Thermal Monitoring part of PMIC5. This part is closely
> coupled with ADC, using it's channels directly. ADC-TM support
> generating interrupts on ADC value crossing low or high voltage bounds,
> which is used to support thermal trip points.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iio/adc/qcom-vadc-common.c       |  62 +++
>  drivers/iio/adc/qcom-vadc-common.h       |   3 +
>  drivers/thermal/qcom/Kconfig             |  11 +
>  drivers/thermal/qcom/Makefile            |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 622 +++++++++++++++++++++++
>  5 files changed, 699 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 40d77b3af1bb..e58e393b8713 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -377,6 +377,42 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>  	return 0;
>  }
>  
> +static s32 qcom_vadc_map_temp_voltage(const struct vadc_map_pt *pts,
> +				      u32 tablesize, int input)
> +{
> +	bool descending = 1;
> +	u32 i = 0;
> +

The code seems like a bit

> +	/* Check if table is descending or ascending */
> +	if (tablesize > 1) {
> +		if (pts[0].y < pts[1].y)
> +			descending = 0;
> +	}
> +
> +	while (i < tablesize) {
> +		if (descending && pts[i].y < input) {
> +			/* table entry is less than measured*/
> +			 /* value and table is descending, stop */
> +			break;
> +		} else if ((!descending) && pts[i].y > input) {
> +			/* table entry is greater than measured*/
> +			/*value and table is ascending, stop */
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	if (i == 0)
> +		return pts[0].x;
> +	if (i == tablesize)
> +		return pts[tablesize - 1].x;
> +
> +	/* result is between search_index and search_index-1 */
> +	/* interpolate linearly */
> +	return fixp_linear_interpolate(pts[i - 1].y, pts[i - 1].x,
> +			pts[i].y, pts[i].x, input);
> +}
> +
>  static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
>  				  u16 adc_code,
>  				  bool absolute,
> @@ -474,6 +510,19 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
>  	return 0;
>  }
>  
> +static u16 qcom_vadc_scale_voltage_code(int voltage,
> +					const struct vadc_prescale_ratio *prescale,
> +					const u32 full_scale_code_volt,
> +					unsigned int factor)
> +{
> +	s64 volt = voltage, adc_vdd_ref_mv = 1875;
> +
> +	volt *= prescale->num * factor * full_scale_code_volt;
> +	volt = div64_s64(volt, (s64)prescale->den * adc_vdd_ref_mv * 1000);
> +
> +	return volt;
> +}
> +
>  static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>  				const struct vadc_prescale_ratio *prescale,
>  				const struct adc5_data *data,
> @@ -658,6 +707,19 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>  }
>  EXPORT_SYMBOL(qcom_vadc_scale);
>  
> +u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
> +				 u32 full_scale_code_volt, int temp)
> +{
> +	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
> +	s32 voltage;
> +
> +	voltage = qcom_vadc_map_temp_voltage(adcmap_100k_104ef_104fb_1875_vref,
> +					     ARRAY_SIZE(adcmap_100k_104ef_104fb_1875_vref),
> +					     temp);
> +	return qcom_vadc_scale_voltage_code(voltage, prescale, full_scale_code_volt, 1000);
> +}
> +EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
> +
>  int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  		    unsigned int prescale_ratio,
>  		    const struct adc5_data *data,
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index 7e5f6428e311..9af41201ad77 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -172,6 +172,9 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  		    const struct adc5_data *data,
>  		    u16 adc_code, int *result_mdec);
>  
> +u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
> +				 u32 full_scale_code_volt, int temp);
> +
>  int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
>  
>  int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index aa9c1d80fae4..8d5ac2df26dc 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -10,6 +10,17 @@ config QCOM_TSENS
>  	  Also able to set threshold temperature for both hot and cold and update
>  	  when a threshold is reached.
>  
> +config QCOM_SPMI_ADC_TM5
> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5"
> +	depends on OF && SPMI && IIO
> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	help
> +	  This enables the thermal driver for the ADC thermal monitoring
> +	  device. It shows up as a thermal zone with multiple trip points.
> +	  Thermal client sets threshold temperature for both warm and cool and
> +	  gets updated when a threshold is reached.
> +
>  config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index ec86eef7f6a6..252ea7d9da0b 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>  
>  qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>  				   tsens-8960.o
> +obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> new file mode 100644
> index 000000000000..c09a50f59053
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Limited
> + */

If it is possible, please give a description of this sensor, the
different register mapping, etc ... So it will be easier to review and
debug in the future.


> +#include <linux/bitfield.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
> +#include "../../iio/adc/qcom-vadc-common.h"

Do not use this form of inclusion.

> +#define ADC5_MAX_CHANNEL                        0xc0
> +#define ADC_TM5_NUM_CHANNELS		8
> +
> +#define ADC_TM5_STATUS_LOW			0x0a
> +
> +#define ADC_TM5_STATUS_HIGH			0x0b
> +
> +#define ADC_TM5_NUM_BTM				0x0f
> +
> +#define ADC_TM5_ADC_DIG_PARAM			0x42
> +
> +#define ADC_TM5_FAST_AVG_CTL			(ADC_TM5_ADC_DIG_PARAM + 1)
> +#define ADC_TM5_FAST_AVG_EN				BIT(7)
> +
> +#define ADC_TM5_MEAS_INTERVAL_CTL		(ADC_TM5_ADC_DIG_PARAM + 2)
> +#define ADC_TM5_TIMER1					3 /* 3.9ms */
> +
> +#define ADC_TM5_MEAS_INTERVAL_CTL2		(ADC_TM5_ADC_DIG_PARAM + 3)
> +#define ADC_TM5_MEAS_INTERVAL_CTL2_MASK			0xf0
> +#define ADC_TM5_TIMER2					10 /* 1 second */
> +#define ADC_TM5_MEAS_INTERVAL_CTL3_MASK			0xf
> +#define ADC_TM5_TIMER3					4 /* 4 second */
> +
> +#define ADC_TM_EN_CTL1				0x46
> +#define ADC_TM_EN					BIT(7)
> +#define ADC_TM_CONV_REQ				0x47
> +#define ADC_TM_CONV_REQ_EN				BIT(7)
> +
> +#define ADC_TM5_M_CHAN_BASE			0x60
> +
> +#define ADC_TM5_M_ADC_CH_SEL_CTL(n)		(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 0)
> +#define ADC_TM5_M_LOW_THR0(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 1)
> +#define ADC_TM5_M_LOW_THR1(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 2)
> +#define ADC_TM5_M_HIGH_THR0(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 3)
> +#define ADC_TM5_M_HIGH_THR1(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 4)
> +#define ADC_TM5_M_MEAS_INTERVAL_CTL(n)		(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 5)
> +#define ADC_TM5_M_CTL(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 6)
> +#define ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK		0xf
> +#define ADC_TM5_M_CTL_CAL_SEL_MASK			0x30
> +#define ADC_TM5_M_CTL_CAL_VAL				0x40
> +#define ADC_TM5_M_EN(n)				(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 7)
> +#define ADC_TM5_M_MEAS_EN				BIT(7)
> +#define ADC_TM5_M_HIGH_THR_INT_EN			BIT(1)
> +#define ADC_TM5_M_LOW_THR_INT_EN			BIT(0)
> +
> +enum adc5_timer_select {
> +	ADC5_TIMER_SEL_1 = 0,
> +	ADC5_TIMER_SEL_2,
> +	ADC5_TIMER_SEL_3,
> +	ADC5_TIMER_SEL_NONE,
> +};
> +
> +struct adc_tm5_data {
> +	const u32	full_scale_code_volt;
> +	unsigned int	*decimation;
> +	unsigned int	*hw_settle;
> +};
> +
> +enum adc_tm5_cal_method {
> +	ADC_TM5_NO_CAL = 0,
> +	ADC_TM5_RATIOMETRIC_CAL,
> +	ADC_TM5_ABSOLUTE_CAL
> +};
> +
> +struct adc_tm5_chip;
> +
> +/**
> + * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
> + * @channel: channel number.
> + * @adc_channel: corresponding ADC channel number.
> + * @cal_method: calibration method.
> + * @prescale: channel scaling performed on the input signal.
> + * @hw_settle_time: the time between AMUX being configured and the
> + *	start of conversion.
> + * @iio: IIO channel instance used by this channel.
> + * @chip: ADC TM chip instance.
> + * @tzd: thermal zone device used by this channel.
> + */
> +struct adc_tm5_channel {
> +	unsigned int		channel;
> +	unsigned int		adc_channel;
> +	enum adc_tm5_cal_method	cal_method;
> +	unsigned int		prescale;
> +	unsigned int		hw_settle_time;
> +	struct iio_channel	*iio;
> +	struct adc_tm5_chip	*chip;
> +	struct thermal_zone_device *tzd;
> +};
> +
> +/**
> + * struct adc_tm5_chip - ADC Thermal Monitoring properties
> + * @regmap: SPMI ADC5 Thermal Monitoring  peripheral register map field.
> + * @dev: SPMI ADC5 device.
> + * @data: software configuration data.
> + * @channels: array of ADC TM channel data.
> + * @nchannels: amount of channels defined/allocated
> + * @decimation: sampling rate supported for the channel.
> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @base: base address of TM registers.
> + */
> +struct adc_tm5_chip {
> +	struct regmap		*regmap;
> +	struct device		*dev;
> +	const struct adc_tm5_data	*data;
> +	struct adc_tm5_channel	*channels;
> +	unsigned int		nchannels;
> +	unsigned int		decimation;
> +	unsigned int		avg_samples;
> +	u16			base;
> +};
> +
> +static const struct adc_tm5_data adc_tm5_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) {250, 420, 840},
> +	.hw_settle = (unsigned int []) {15, 100, 200, 300, 400, 500, 600, 700,
> +					1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000},

Fixup format please, { 15, ... 128000 },
less than 80 chars.

> +};
> +
> +static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
> +}
> +
> +static int adc_tm5_write(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc_tm->regmap, adc_tm->base + offset, data, len);
> +}
> +
> +static int adc_tm5_reg_update(struct adc_tm5_chip *adc_tm, u16 offset, u8 mask, u8 val)
> +{
> +	return regmap_write_bits(adc_tm->regmap, adc_tm->base + offset, mask, val);
> +}
> +
> +static irqreturn_t adc_tm5_isr(int irq, void *data)
> +{
> +	struct adc_tm5_chip *chip = data;
> +	u8 status_low, status_high, ctl;
> +	int ret = 0, i = 0;
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, 1);

Replace '1' by sizeof(status_low), that will prevent errors if the type
changes in the future or if there is a copy/paste.

> +	if (ret) {
> +		dev_err(chip->dev, "read status low failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}

Can you identify the reasons those reads can fail? If it is not supposed
to happen it is fine but otherwise we don't want to be flooded with
error messages on the console.

> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, 1);
> +	if (ret) {
> +		dev_err(chip->dev, "read status high failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}

Ditto.

> +	for (i = 0; i < chip->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		unsigned int ch = chip->channels[i].channel;
> +
> +		if (!chip->channels[i].tzd) {
> +			dev_err_once(chip->dev, "thermal device not found\n");
> +			continue;
> +		}
> +
> +		ret = adc_tm5_read(chip, ADC_TM5_M_EN(ch), &ctl, 1);

sizeof(ctl)

> +
> +		if (ret) {
> +			dev_err(chip->dev, "ctl read failed with %d\n", ret);
> +			continue;
> +		}

Same comment here regarding the error.

> +		lower_set = (status_low & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_MEAS_EN) &&
> +			(ctl & ADC_TM5_M_LOW_THR_INT_EN);
> +
> +		upper_set = (status_high & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_MEAS_EN) &&
> +			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);

Is the check (ctl & ADC_TM5_M_[HIGH|LOW]_THR_INT_EN) necessary if
status_high or status_low is true ?

Isn't possible to simplify that with:

eg.

		if (!(ctl & ADC_TM5_M_MEAS_EN)
			continue;

		if (!(status_high & BIT(ch)) && !(status_low & BIT(ch))
			continue;

		thermal_zone_device_update(chip->channels[i].tzd,
					THERMAL_EVENT_UNSPECIFIED);

??

> +		if (upper_set || lower_set)
> +			thermal_zone_device_update(chip->channels[i].tzd,
> +						   THERMAL_EVENT_UNSPECIFIED);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc_tm5_get_temp(void *data, int *temp)
> +{
> +	struct adc_tm5_channel *channel = data;
> +	int ret, milli_celsius;
> +
> +	if (!channel || !channel->iio)
> +		return -EINVAL;
> +
> +	ret = iio_read_channel_processed(channel->iio, &milli_celsius);

just pass temp, one variable saved from the stack that simplifies to:

	return iio_read_channel_processed(channel->iio, temp);

> +	if (ret < 0)
> +		return ret;
> +
> +	*temp = milli_celsius;
> +
> +	return 0;
> +}
> +
> +static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
> +{
> +	struct adc_tm5_chip *chip = channel->chip;
> +	unsigned int reg = ADC_TM5_M_EN(channel->channel);
> +
> +	return adc_tm5_reg_update(chip, reg,
> +			ADC_TM5_M_MEAS_EN | ADC_TM5_M_HIGH_THR_INT_EN | ADC_TM5_M_LOW_THR_INT_EN,
> +			0);

Format 80 cols.

May be worth to create a ADC_TM5_M_THR_INT_EN macro:

#define ADC_TM5_M_THR_INT_EN (ADC_TM5_M_HIGH_THR_INT_EN | \
				 ADC_TM5_M_LOW_THR_INT_EN)

> +}
> +
> +static int adc_tm5_enable(struct adc_tm5_chip *chip)
> +{
> +	int rc = 0;

Please be consistent with the variable names. s/rc/ret/

> +	u8 data = 0;
> +
> +	data = ADC_TM_EN;
> +	rc = adc_tm5_write(chip, ADC_TM_EN_CTL1, &data, 1);

sizeof

> +	if (rc < 0) {
> +		pr_err("adc-tm enable failed\n");
> +		return rc;
> +	}
> +
> +	data = ADC_TM_CONV_REQ_EN;
> +	rc = adc_tm5_write(chip, ADC_TM_CONV_REQ, &data, 1);

sizeof

> +	if (rc < 0) {
> +		pr_err("adc-tm request conversion failed\n");
> +		return rc;
> +	}
> +
> +	return rc;
> +}
> +
> +static int adc_tm5_configure(struct adc_tm5_channel *channel, int low_temp, int high_temp)
> +{
> +	struct adc_tm5_chip *chip = channel->chip;
> +	u8 buf[8];
> +	u16 reg = ADC_TM5_M_ADC_CH_SEL_CTL(channel->channel);
> +	int ret = 0;
> +
> +	ret = adc_tm5_read(chip, reg, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(chip->dev, "block read failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Update ADC channel select */
> +	buf[0] = channel->adc_channel;
> +
> +	/* Warm temperature corresponds to low voltage threshold */
> +	if (high_temp != INT_MAX) {
> +		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
> +				chip->data->full_scale_code_volt, high_temp);
> +
> +		buf[1] = adc_code & 0xff;
> +		buf[2] = adc_code >> 8;
> +		buf[7] |= ADC_TM5_M_LOW_THR_INT_EN;
> +	} else {
> +		buf[7] &= ~ADC_TM5_M_LOW_THR_INT_EN;
> +	}
> +
> +	/* Cool temperature corresponds to high voltage threshold */
> +	if (low_temp != -INT_MAX) {

Is it really -INT_MAX ? or INT_MIN

-2147483647 vs -2147483648 ?

> +		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
> +				chip->data->full_scale_code_volt, low_temp);
> +
> +		buf[3] = adc_code & 0xff;
> +		buf[4] = adc_code >> 8;
> +		buf[7] |= ADC_TM5_M_HIGH_THR_INT_EN;
> +	} else {
> +		buf[7] &= ~ADC_TM5_M_HIGH_THR_INT_EN;
> +	}
> +
> +	/* Update timer select */
> +	buf[5] = ADC5_TIMER_SEL_2;
> +
> +	/* Set calibration select, hw_settle delay */
> +	buf[6] &= ~ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK;
> +	buf[6] |= FIELD_PREP(ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK, channel->hw_settle_time);
> +	buf[6] &= ~ADC_TM5_M_CTL_CAL_SEL_MASK;
> +	buf[6] |= FIELD_PREP(ADC_TM5_M_CTL_CAL_SEL_MASK, channel->cal_method);
> +
> +	buf[7] |= ADC_TM5_M_MEAS_EN;
> +
> +	ret = adc_tm5_write(chip, reg, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(chip->dev, "buf write failed\n");
> +		return ret;
> +	}
> +
> +	return adc_tm5_enable(chip);
> +}
> +
> +static int adc_tm5_set_trips(void *data, int low_temp, int high_temp)
> +{
> +	struct adc_tm5_channel *channel = data;
> +	struct adc_tm5_chip *chip;
> +	int ret;
> +
> +	if (!channel)
> +		return -EINVAL;
> +
> +	chip = channel->chip;
> +	dev_dbg(chip->dev, "%d:low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +		channel->channel, low_temp, high_temp);
> +
> +	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
> +		ret = adc_tm5_disable_channel(channel);
> +	else
> +		ret = adc_tm5_configure(channel, low_temp, high_temp);
> +
> +	return ret;
> +}
> +
> +static struct thermal_zone_of_device_ops adc_tm5_ops = {
> +	.get_temp = adc_tm5_get_temp,
> +	.set_trips = adc_tm5_set_trips,
> +};
> +
> +static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
> +{
> +	unsigned int i;
> +	struct thermal_zone_device *tzd;
> +
> +	for (i = 0; i < adc_tm->nchannels; i++) {
> +		adc_tm->channels[i].chip = adc_tm;
> +
> +		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
> +							   adc_tm->channels[i].channel,
> +							   &adc_tm->channels[i],
> +							   &adc_tm5_ops);
> +		if (IS_ERR(tzd)) {
> +			dev_err(adc_tm->dev, "Error registering TZ zone:%ld for channel:%d\n",
> +				PTR_ERR(tzd), adc_tm->channels[i].channel);
> +			continue;
> +		}
> +		adc_tm->channels[i].tzd = tzd;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc_tm5_init(struct adc_tm5_chip *chip)
> +{
> +	u8 buf[4], channels_available;
> +	int ret;
> +	unsigned int i;
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM, &channels_available, 1);

sizeof

> +	if (ret) {
> +		dev_err(chip->dev, "read failed for BTM channels\n");
> +		return ret;
> +	}
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(chip->dev, "block read failed with %d\n", ret);
> +		return ret;
> +	}

What is the point of reading the 'buf' and right after overwrite the
content ?

> +	/* Select decimation */
> +	buf[0] = chip->decimation;
> +
> +	/* Select number of samples in fast average mode */
> +	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
> +
> +	/* Select timer1 */
> +	buf[2] = ADC_TM5_TIMER1;
> +
> +	/* Select timer2 and timer3 */
> +	buf[3] = FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL2_MASK, ADC_TM5_TIMER2) |
> +		 FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL3_MASK, ADC_TM5_TIMER3);
> +
> +	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
> +	if (ret)
> +		dev_err(chip->dev, "block write failed with %d\n", ret);
> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		if (chip->channels[i].channel >= channels_available) {
> +			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
> +			return -EINVAL;
> +		}

Is it a sanity check to make sure the hardware and the DT are compatible ?

> +	}
> +
> +	return ret;
> +}
> +

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
