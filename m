Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63F28E485
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgJNQcf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgJNQcf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2020 12:32:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF96C061755
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2020 09:32:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a1so17137pjd.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2020 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TLDShnbNRZKrtt2JT+186sCc5mPlnY2RuM9M1vslivc=;
        b=fu3+OdQ1TX+V0KxPkkFVvN2fPULBKsDitwpWbAvKmMldumheC5+BXRMlUowYJBLpPE
         D3aC4VpLXuRpuQAX7iGbyz7JmeDnufBnxWKxTZNjd7IaDNC1Fkfv8qSZSLV+ElK0kRiV
         LDfOtba0gmp0RLk2QxKGotxlnCO/KAaF5wNJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TLDShnbNRZKrtt2JT+186sCc5mPlnY2RuM9M1vslivc=;
        b=d4fkCEXmWsx1luP3NlLXDCqztgR8TJQ3iEm7VOZHkcKVHU2yX6NeZWGJ41nwJxcOwy
         uP7paMZfrchPwgzG5ECIdTVnnK9V7uNauqOjGggRSEYdjNv/d+ahjSeIpQL6Z3wKV4/l
         pubgsAAIrCVhReO9gpORU8V5xSaThQZSBi3HV0ES59IlM3KkTXQhSMdJ5x/hjcx+QrXo
         jgG8VxmZhnLIeR1rIjcyj1YH88or/FvEenpXKORvypJB6KrEsMlY6mOys527iSk0Pfya
         pmRh0mNqBcXVLxugtnuCkJbJ1OJlqEUAEM3hD63rrj7bMaikOSeiwldAKHeIgw3mnr2o
         DMsQ==
X-Gm-Message-State: AOAM532EgiH11vZmbb4DxfQ7yAlYtMGZh5josvpWJA/OPihGaBO0bPA4
        IbU8j+EEDSQQBF+o1hk8VCUYPw==
X-Google-Smtp-Source: ABdhPJz3gzDzE4yhgG6ByV5fNncoXfDk4Gt94aKGXCCc85WCV/JQaNVAjGj7Lz2n9h2yvwqO0eLgSA==
X-Received: by 2002:a17:902:b70d:b029:d2:6277:385f with SMTP id d13-20020a170902b70db02900d26277385fmr234138pls.25.1602693154605;
        Wed, 14 Oct 2020 09:32:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id j20sm110623pfd.40.2020.10.14.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 09:32:34 -0700 (PDT)
Date:   Wed, 14 Oct 2020 09:32:31 -0700
From:   mka@chromium.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: Re: [PATCH v8 08/11] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
Message-ID: <20201014163231.GA662649@google.com>
References: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
 <20201009154459.106189-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009154459.106189-9-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

only a shallow review, I'm not an expert in the area and didn't look into all
aspects of this patch.

On Fri, Oct 09, 2020 at 06:44:56PM +0300, Dmitry Baryshkov wrote:
> Add support for Thermal Monitoring part of PMIC5. This part is closely
> coupled with ADC, using it's channels directly. ADC-TM support
> generating interrupts on ADC value crossing low or high voltage bounds,
> which is used to support thermal trip points.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iio/adc/qcom-vadc-common.c       |  62 +++
>  drivers/thermal/qcom/Kconfig             |  11 +
>  drivers/thermal/qcom/Makefile            |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 619 +++++++++++++++++++++++
>  include/linux/iio/adc/qcom-vadc-common.h |   3 +
>  5 files changed, 696 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index ee94774b72e6..8ceefb079712 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -376,6 +376,42 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>  	return 0;
>  }
>  
> +static s32 qcom_vadc_map_temp_voltage(const struct vadc_map_pt *pts,
> +				      u32 tablesize, int input)
> +{
> +	bool descending = 1;

s/1/true

Consider changing to 'ascending' which probably is the more common case, at
least for folks reading the code it's more straightforward to first handle
the 'normal' case and then the odd one.


> +	u32 i = 0;
> +
> +	/* Check if table is descending or ascending */

Comment doesn't add much value, it's evident from the code/assignment of
'descending'

> +	if (tablesize > 1) {
> +		if (pts[0].y < pts[1].y)
> +			descending = 0;

s/0/false/

> +	}
> +
> +	while (i < tablesize) {
> +		if (descending && pts[i].y < input) {
> +			/* table entry is less than measured*/
> +			 /* value and table is descending, stop */

Multiline comment format (https://www.kernel.org/doc/html/v5.9/process/coding-style.html#commenting)

Besides that, the comment is a literal translation of the condition to English,
which isn't useful. 

> +			break;
> +		} else if ((!descending) && pts[i].y > input) {

no need for parentheses around '!descending'

> +			/* table entry is greater than measured*/
> +			/*value and table is ascending, stop */

ditto

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

Comment doesn't add any value, the name of the function makes it clear that
a linear interpolation is done.

> +	return fixp_linear_interpolate(pts[i - 1].y, pts[i - 1].x,
> +			pts[i].y, pts[i].x, input);
> +}
> +
>  static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
>  				  u16 adc_code,
>  				  bool absolute,
> @@ -473,6 +509,19 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
>  	return 0;
>  }
>  
> +static u16 qcom_vadc_scale_voltage_code(int voltage,
> +					const struct vadc_prescale_ratio *prescale,
> +					const u32 full_scale_code_volt,
> +					unsigned int factor)
> +{
> +	s64 volt = voltage, adc_vdd_ref_mv = 1875;

This is hard to read, I'd suggest to declare 'volt' and 'adc_vdd_ref_mv'
in separate lines. Actually there is no need for 'adc_vdd_ref_mv', just define
a constant for it.

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
> @@ -657,6 +706,19 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
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
> index 000000000000..9e4d5ae5fe33
> --- /dev/null
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Limited
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/adc/qcom-vadc-common.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
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
> +	.decimation = (unsigned int []) { 250, 420, 840 },
> +	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 8000, 16000, 32000,
> +					 64000, 128000 },
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

no need for initialization

> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, sizeof(status_low));
> +	if (unlikely(ret)) {
> +		dev_err(chip->dev, "read status low failed with %d\n", ret);

s/ with %d/: %d/
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, sizeof(status_high));
> +	if (unlikely(ret)) {
> +		dev_err(chip->dev, "read status high failed with %d\n", ret);

s/ with %d/: %d/

> +		return IRQ_HANDLED;
> +	}
> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		unsigned int ch = chip->channels[i].channel;
> +
> +		if (!chip->channels[i].tzd) {
> +			dev_err_once(chip->dev, "thermal device not found\n");

Add channel number?

I understand that you use 'dev_err_once' to avoid spamming the log. Note that
this creates a single log entry, even when different channels don't have a tzd.

> +			continue;
> +		}
> +
> +		ret = adc_tm5_read(chip, ADC_TM5_M_EN(ch), &ctl, sizeof(ctl));
> +		if (unlikely(ret)) {
> +			dev_err(chip->dev, "ctl read failed with %d\n", ret);

s/ with %d/: %d/

Add channel number?

> +			continue;
> +		}
> +
> +		if (!(ctl & ADC_TM5_M_MEAS_EN))
> +			continue;
> +
> +		lower_set = (status_low & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_LOW_THR_INT_EN);
> +
> +		upper_set = (status_high & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);
> +
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
> +	int ret;
> +
> +	if (!channel || !channel->iio)
> +		return -EINVAL;
> +
> +	ret = iio_read_channel_processed(channel->iio, temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;


	return iio_read_channel_processed(channel->iio, temp);

> +}
> +
> +static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
> +{
> +	struct adc_tm5_chip *chip = channel->chip;
> +	unsigned int reg = ADC_TM5_M_EN(channel->channel);
> +
> +	return adc_tm5_reg_update(chip, reg,
> +				  ADC_TM5_M_MEAS_EN |
> +				  ADC_TM5_M_HIGH_THR_INT_EN |
> +				  ADC_TM5_M_LOW_THR_INT_EN,
> +				  0);
> +}
> +
> +static int adc_tm5_enable(struct adc_tm5_chip *chip)
> +{
> +	int ret = 0;
> +	u8 data = 0;

no need for initializations

> +
> +	data = ADC_TM_EN;
> +	ret = adc_tm5_write(chip, ADC_TM_EN_CTL1, &data, sizeof(data));
> +	if (ret < 0) {
> +		pr_err("adc-tm enable failed\n");

		dev_err(chip->dev, "adc-tm enable failed: %d\n", ret);

> +		return ret;
> +	}
> +
> +	data = ADC_TM_CONV_REQ_EN;
> +	ret = adc_tm5_write(chip, ADC_TM_CONV_REQ, &data, sizeof(data));
> +	if (ret < 0) {
> +		pr_err("adc-tm request conversion failed\n");

		dev_err(chip->dev, "adc-tm request conversion failed: %d\n", ret);

> +		return ret;
> +	}
> +
> +	return ret;

	return 0;
> +}
> +
> +static int adc_tm5_configure(struct adc_tm5_channel *channel, int low_temp, int high_temp)
> +{
> +	struct adc_tm5_chip *chip = channel->chip;
> +	u8 buf[8];
> +	u16 reg = ADC_TM5_M_ADC_CH_SEL_CTL(channel->channel);
> +	int ret = 0;

initialization not needed

> +
> +	ret = adc_tm5_read(chip, reg, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(chip->dev, "block read failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Update ADC channel select */

Comment does not add any value

> +	buf[0] = channel->adc_channel;
> +
> +	/* Warm temperature corresponds to low voltage threshold */

Not sure if the comment is useful. In any case use a consistent terminology, the
parameters are called 'low_temp' and 'high_temp', but the comments talk about
warm and cool.

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

Comment not useful

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

'buf write' isn't very useful information. This writes ADC_TM5_M_ADC_CH_SEL_CTL
for 'channel->channel', right? The message should convey that. Also include the
error in the log.

> +		return ret;
> +	}
> +
> +	return adc_tm5_enable(chip);
> +}
> +
> +static int adc_tm5_set_trips(void *data, int low_temp, int high_temp)

nit: consider naming the parameters 'high'/'low' (like other drivers do),
from the function name it's evident that these are trip point temperatures.


> +{
> +	struct adc_tm5_channel *channel = data;
> +	struct adc_tm5_chip *chip;
> +	int ret;
> +
> +	if (!channel)
> +		return -EINVAL;

Judging from other drivers it doesn't seem this check is needed.

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
> +	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM,
> +			   &channels_available, sizeof(channels_available));
> +	if (ret) {
> +		dev_err(chip->dev, "read failed for BTM channels\n");
> +		return ret;
> +	}
> +
> +	/* Select decimation */

Comment does not add any value

> +	buf[0] = chip->decimation;
> +
> +	/* Select number of samples in fast average mode */

ditto

> +	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
> +
> +	/* Select timer1 */

ditto

> +	buf[2] = ADC_TM5_TIMER1;
> +
> +	/* Select timer2 and timer3 */

ditto

> +	buf[3] = FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL2_MASK, ADC_TM5_TIMER2) |
> +		 FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL3_MASK, ADC_TM5_TIMER3);
> +
> +	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
> +	if (ret)
> +		dev_err(chip->dev, "block write failed with %d\n", ret);

Does it make sense to continue after this?

> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		if (chip->channels[i].channel >= channels_available) {
> +			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
> +			return -EINVAL;
> +		}
> +	}

Shouldn't this be done directly after reading the channel info above, before
writing ADC_TM5_ADC_DIG_PARAM?

> +
> +	return ret;
> +}
> +
> +static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
> +				       struct adc_tm5_channel *channel,
> +				       struct device_node *node)
> +{
> +	const char *name = node->name;
> +	u32 chan, value, varr[2];
> +	int ret;
> +	struct device *dev = adc_tm->dev;
> +	struct of_phandle_args args;
> +
> +	ret = of_property_read_u32(node, "reg", &chan);
> +	if (ret) {
> +		dev_err(dev, "%s: invalid channel number (%d)\n", name, ret);
> +		return ret;
> +	}
> +
> +	if (chan >= ADC_TM5_NUM_CHANNELS) {
> +		dev_err(dev, "%s: invalid channel number %d\n", name, chan);
> +		return -EINVAL;
> +	}

Use a consistent log format for invalid channel numbers ('channel number (%d)'
vs 'channel number %d').

> +
> +	/* the channel has DT description */

Comment it useless

> +	channel->channel = chan;
> +
> +	/*
> +	 * We are tied to PMIC's ADC controller, which always use single
> +	 * argument for channel number.  So don't bother parsing
> +	 * #io-channel-cells, just enforce cell_count = 1.
> +	 */
> +	ret = of_parse_phandle_with_fixed_args(node, "io-channels", 1, 0, &args);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: invalid ADC channel number %d: %d\n", name, chan, ret);

Is the problem really an invalid channel number or to parse 'io-channels'?

> +		return ret;
> +	}
> +	of_node_put(args.np);
> +
> +	if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
> +		dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
> +		return ret;
> +	}
> +	channel->adc_channel = args.args[0];
> +
> +	channel->iio = devm_of_iio_channel_get_by_name(adc_tm->dev, node, NULL);
> +	if (IS_ERR(channel->iio)) {
> +		ret = PTR_ERR(channel->iio);
> +		channel->iio = NULL;

Is this assignement to NULL really necessary? probe() is aborted when
adc_tm5_get_dt_data() fails

> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "%s: error getting channel: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0) {
> +			dev_err(dev, "%s: invalid pre-scaling <%d %d>\n",
> +				name, varr[0], varr[1]);
> +			return ret;
> +		}
> +		channel->prescale = ret;
> +	} else {
> +		/* 1:1 prescale is index 0 */
> +		channel->prescale = 0;
> +	}
> +
> +	ret = of_property_read_u32(node, "qcom,hw-settle-time-us", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_hw_settle_time_from_dt(value, adc_tm->data->hw_settle);
> +		if (ret < 0) {
> +			dev_err(dev, "%s invalid hw-settle-time-us %d us\n",
> +				name, value);
> +			return ret;
> +		}
> +		channel->hw_settle_time = ret;
> +	} else {
> +		channel->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
> +	}
> +
> +	if (of_property_read_bool(node, "qcom,ratiometric"))
> +		channel->cal_method = ADC_TM5_RATIOMETRIC_CAL;
> +	else
> +		channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
> +
> +	return 0;
> +}
> +
> +static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
> +{
> +	struct adc_tm5_channel *channels;
> +	struct device_node *child;
> +	u32 value;
> +	int ret;
> +	struct device *dev = adc_tm->dev;
> +
> +	adc_tm->nchannels = of_get_available_child_count(node);
> +	if (!adc_tm->nchannels)
> +		return -EINVAL;
> +
> +	adc_tm->channels = devm_kcalloc(dev, adc_tm->nchannels,
> +					sizeof(*adc_tm->channels), GFP_KERNEL);
> +	if (!adc_tm->channels)
> +		return -ENOMEM;
> +
> +	channels = adc_tm->channels;

Most of the above could be moved before the loop that reads
adc_tm5_get_dt_channel_data(). This would skip the allocation in case of DT
errors and move the variables closer to the context where they are used.

> +
> +	adc_tm->data = of_device_get_match_data(dev);
> +	if (!adc_tm->data)
> +		adc_tm->data = &adc_tm5_data_pmic;
> +
> +	ret = of_property_read_u32(node, "qcom,decimation", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_decimation_from_dt(value, adc_tm->data->decimation);
> +		if (ret < 0) {
> +			dev_err(dev, "invalid decimation %d\n", value);
> +			return ret;
> +		}
> +		adc_tm->decimation = ret;
> +	} else {
> +		adc_tm->decimation = ADC5_DECIMATION_DEFAULT;
> +	}
> +
> +	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_avg_samples_from_dt(value);
> +		if (ret < 0) {
> +			dev_err(dev, "invalid avg-samples %d\n", value);
> +			return ret;
> +		}
> +		adc_tm->avg_samples = ret;
> +	} else {
> +		adc_tm->avg_samples = VADC_DEF_AVG_SAMPLES;
> +	}
> +
> +	for_each_available_child_of_node(node, child) {
> +		ret = adc_tm5_get_dt_channel_data(adc_tm, channels, child);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		channels++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adc_tm5_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct adc_tm5_chip *adc_tm;
> +	struct regmap *regmap;
> +	int ret, irq;
> +	u32 reg;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	ret = of_property_read_u32(node, "reg", &reg);
> +	if (ret)
> +		return ret;
> +
> +	adc_tm = devm_kzalloc(&pdev->dev, sizeof(*adc_tm), GFP_KERNEL);
> +	if (!adc_tm)
> +		return -ENOMEM;
> +
> +	adc_tm->regmap = regmap;
> +	adc_tm->dev = dev;
> +	adc_tm->base = reg;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "get_irq failed: %d\n", irq);
> +		return irq;
> +	}
> +
> +	ret = adc_tm5_get_dt_data(adc_tm, node);
> +	if (ret) {
> +		dev_err(dev, "get dt data failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = adc_tm5_init(adc_tm);
> +	if (ret) {
> +		dev_err(dev, "adc-tm init failed\n");
> +		return ret;
> +	}
> +
> +	ret = adc_tm5_register_tzd(adc_tm);
> +	if (ret) {
> +		dev_err(dev, "tzd register failed\n");

Is there anything from adc_tm5_init() that needs to be undone?

> +		return ret;
> +	}
> +
> +	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
> +					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
> +}
> +
> +static const struct of_device_id adc_tm5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc-tm5",
> +		.data = &adc_tm5_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
> +
> +static struct platform_driver adc_tm5_driver = {
> +	.driver = {
> +		.name = "qcom-spmi-adc-tm5",
> +		.of_match_table = adc_tm5_match_table,
> +	},
> +	.probe = adc_tm5_probe,
> +};
> +module_platform_driver(adc_tm5_driver);
> +
> +MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
> index 03a9119edc71..041d1397995e 100644
> --- a/include/linux/iio/adc/qcom-vadc-common.h
> +++ b/include/linux/iio/adc/qcom-vadc-common.h
> @@ -174,6 +174,9 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  		    const struct adc5_data *data,
>  		    u16 adc_code, int *result_mdec);
>  
> +u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
> +				 u32 full_scale_code_volt, int temp);
> +
>  int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
>  
>  int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
> -- 
> 2.28.0
> 
