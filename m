Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A9202F92
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 07:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgFVFmW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgFVFmW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 01:42:22 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45383C061794
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 22:42:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u23so12101104otq.10
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nvZHBN0GyVoXTZhPFMvFOJhlATT1RIALLvxmxhflmDg=;
        b=jwur25wPrPnS7js1gINPT1QC8hV3sQQOTcNsW3pctKJZJkTLOE1BsCsjQUi+ylhZKi
         DFdRdVDqH0P1w1zW3mIdmqSNn7+X1l2pMvuHcnXwdpxmL/4KkN7d1zBE6nhUCSeo3c+h
         vUD/zUi0/PG3UrwOY7gAQ8dMprklyR3ebuaTmoaNWSFSjOIZWlCW8P0iFRt/nRYep7+t
         /dl6QaiqMYwpyDroY+7vE4JWxOacIDzAr6aozm3nyNsPvlyBA3ZZbS9/ZJW3Z35+YK5T
         MEzwBTx6WOHlaS0UQrEI/hyNEpYpeHopuWoI84jQMQnSqXOFIIACUOtdoQp0QqaB26yg
         GPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nvZHBN0GyVoXTZhPFMvFOJhlATT1RIALLvxmxhflmDg=;
        b=NbPrxYcyqlZlg7SRGsQhTZ2LktfqoQNFR/ppSEXHLeHPVBYmW6Kv0QqbwOYPH2ixtD
         roD1TZpzEA47Bhpj5lVyl1wlpi3XK6cCXwV3jCipqAS561bDGr8vrAdVZNKYUVjQtBSQ
         JghwJSppjpddAxcnBVgYToH+Ccf3TQllwBLy6qRdKNAJmFRyqs8sqoMyDcVHqQWg55g6
         RORhu2/tX43TRy2QvevU84afqSGY0QKv/pfkMl79q+1yIQcRq4wmXm53dVDGKER08bDh
         qb0DLa2DJfKiZ7WE6AY/LCR9YmYsJfD5KyfxVwhDizkGUYeELcWUDtsoUSKi79ojDpFr
         kCFw==
X-Gm-Message-State: AOAM530Y5cDCdem9sCflCtUnBE+7YNpPMsgwBz6mZkFeZAFTMldLVdM0
        9LLJie/pZnO9bj88bISTnEEzZg==
X-Google-Smtp-Source: ABdhPJxagcZIgSO65H1gS1cvsMaNRqI4pos/fZXVCXsaNcQuxHXvRrgU0tcmP0a0ivJ9XDmur9I/Aw==
X-Received: by 2002:a05:6830:141:: with SMTP id j1mr13147275otp.318.1592804540292;
        Sun, 21 Jun 2020 22:42:20 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r13sm3211037oop.33.2020.06.21.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 22:42:19 -0700 (PDT)
Date:   Sun, 21 Jun 2020 22:39:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/5] thermal: qcom: add support for adc-tm5 PMIC thermal
 monitor
Message-ID: <20200622053933.GP128451@builder.lan>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
 <20200621193549.2070434-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621193549.2070434-4-dmitry.baryshkov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun 21 Jun 12:35 PDT 2020, Dmitry Baryshkov wrote:
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index ffa578ce76db..e470beb8c6f9 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -176,6 +176,47 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>  	return 0;
>  }
>  
> +static s32 qcom_vadc_map_temp_voltage(const struct vadc_map_pt *pts,
> +				      u32 tablesize, int input)
> +{
> +	bool descending = 1;
> +	u32 i = 0;
> +
> +	/* Check if table is descending or ascending */
> +	if (tablesize > 1) {
> +		if (pts[0].y < pts[1].y)
> +			descending = 0;
> +	}
> +
> +	while (i < tablesize) {
> +		if ((descending) && (pts[i].y < input)) {
> +			/* table entry is less than measured*/
> +			 /* value and table is descending, stop */
> +			break;
> +		} else if ((!descending) &&
> +				(pts[i].y > input)) {
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
> +	return (((s32)((pts[i].x - pts[i - 1].x) *
> +		(input - pts[i - 1].y)) /
> +		(pts[i].y - pts[i - 1].y)) +
> +		pts[i - 1].x);

I was convinced that we had a function to do this, but it seems like it
was never merged. So how about doing the community a favor by adding and
using Craig's patch from:

https://lore.kernel.org/linux-arm-msm/20180607181306.9766-1-ctatlor97@gmail.com/

> +
> +	return 0;
> +}
[..]
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index aa9c1d80fae4..c61df55760e9 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -20,3 +20,14 @@ config QCOM_SPMI_TEMP_ALARM
>  	  trip points. The temperature reported by the thermal sensor reflects the
>  	  real time die temperature if an ADC is present or an estimate of the
>  	  temperature based upon the over temperature stage value.
> +
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
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index ec86eef7f6a6..5b9445a3fd26 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
>  qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>  				   tsens-8960.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
> +obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o

Please sort Kconfig and Makefile entries alphabetically whenever
possible.

> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
[..]
> +static const struct of_device_id adc_tm5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc-tm5",
> +		.data = &adc_tm5_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc_tm5_match_table);

Please move the match table next to the platform_driver definition and
use of_device_get_match_data() to get the data without having to
reference this array directly.

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
> +	unsigned long flags;
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, 1);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "read status low failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, 1);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "read status high failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		bool upper_set = false, lower_set = false;
> +		unsigned int ch = chip->channels[i].channel;
> +
> +		if (!chip->channels[i].tzd) {
> +			dev_err(chip->dev, "thermal device not found\n");

Afaict this would happen only if devm_thermal_zone_of_sensor_register()
failed for the particular channel, in which case you already have an
error print and probably don't want a dev_err() for every isr.

So I think you should drop this print.

> +			continue;
> +		}
> +
> +		spin_lock_irqsave(&chip->reg_lock, flags);

Why is this read done under a spinlock?

> +		ret = adc_tm5_read(chip, ADC_TM5_Mn_EN(ch), &ctl, 1);
> +		spin_unlock_irqrestore(&chip->reg_lock, flags);
> +
> +		if (ret) {
> +			dev_err(chip->dev, "ctl read failed with %d\n", ret);
> +			goto fail;

Your goto fail will arrive with both upper_set and lower_set false, and
hence this is simply a "continue".

> +		}
> +
> +		if ((status_low & BIT(ch)) && (ctl & ADC_TM5_Mn_MEAS_EN)
> +				&& (ctl & ADC_TM5_Mn_LOW_THR_INT_EN))
> +			lower_set = true;
> +
> +		if ((status_high & BIT(ch)) && (ctl & ADC_TM5_Mn_MEAS_EN) &&
> +					(ctl & ADC_TM5_Mn_HIGH_THR_INT_EN))
> +			upper_set = true;
> +fail:
> +
> +		if (upper_set || lower_set)
> +			thermal_zone_device_update(chip->channels[i].tzd,
> +					THERMAL_EVENT_UNSPECIFIED);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[..]
> +static int adc_tm5_set_trip_temp(void *data,
> +		int low_temp, int high_temp)
> +{
> +	struct adc_tm5_channel *channel = data;
> +	struct adc_tm5_chip *chip;
> +	u8 trip_high_thr[2], trip_low_thr[2];
> +	u8 *trip_high_ptr = NULL, *trip_low_ptr = NULL;
> +	int ret;
> +	unsigned long flags;
> +
> +	if (!channel)
> +		return -EINVAL;
> +
> +	dev_info(channel->chip->dev, "%d:low_temp(mdegC):%d, high_temp(mdegC):%d\n",
> +			channel->channel, low_temp, high_temp);
> +	chip = channel->chip;
> +
> +	/* Warm temperature corresponds to low voltage threshold */
> +	if (high_temp != INT_MAX) {
> +		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
> +				chip->data->full_scale_code_volt, high_temp);
> +
> +		trip_low_thr[0] = adc_code & 0xff;
> +		trip_low_thr[1] = adc_code >> 8;
> +		trip_low_ptr = trip_low_thr;
> +	}
> +
> +	/* Cool temperature corresponds to high voltage threshold */
> +	if (low_temp != -INT_MAX) {
> +		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
> +				chip->data->full_scale_code_volt, low_temp);
> +
> +		trip_high_thr[0] = adc_code & 0xff;
> +		trip_high_thr[1] = adc_code >> 8;
> +		trip_high_ptr = trip_high_thr;
> +	}
> +
> +	spin_lock_irqsave(&chip->reg_lock, flags);

Afaict set_trips() is called only under the tz's mutex and as such
there's no race between multiple calls to this function. And the
operations below both serialized in the regmap.

So do you really need this lock?

> +	if (high_temp == INT_MAX && low_temp == INT_MIN)
> +		ret = adc_tm5_disable_channel(channel);
> +	else
> +		ret = adc_tm5_configure(channel, trip_low_ptr, trip_high_ptr);
> +
> +	spin_unlock_irqrestore(&chip->reg_lock, flags);
> +
> +	return ret;
> +}
> +
> +
> +static struct thermal_zone_of_device_ops adc_tm5_ops = {
> +	.get_temp = adc_tm5_get_temp,
> +	.set_trips = adc_tm5_set_trip_temp,
> +};
[..]
> +static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
> +{
> +	struct adc_tm5_channel *channels;
> +	struct device_node *child;
> +	unsigned int index = 0;
> +	const struct of_device_id *id;
> +	const struct adc_tm5_data *data;
> +	u32 value;
> +	int ret;
> +	struct device *dev = adc_tm->dev;

Pass the platform_device instead of the node to this function and you
can acquire this from it's obvious origin (&pdev->dev) instead and you
can use of_device_get_match_data() below.

> +
> +	adc_tm->nchannels = of_get_available_child_count(node);
> +	if (!adc_tm->nchannels)
> +		return -EINVAL;
> +
> +	adc_tm->channels = devm_kcalloc(adc_tm->dev, adc_tm->nchannels,
> +					sizeof(*adc_tm->channels), GFP_KERNEL);
> +	if (!adc_tm->channels)
> +		return -ENOMEM;
> +
> +	channels = adc_tm->channels;
> +
> +	id = of_match_node(adc_tm5_match_table, node);
> +	if (id)
> +		data = id->data;
> +	else
> +		data = &adc_tm5_data_pmic;

Although this seems to fall back to the same value as the single entry
in the of_match_table, so perhaps you should just omit this part for
now.

> +	adc_tm->data = data;
> +
> +	ret = of_property_read_u32(node, "qcom,decimation", &value);
> +	if (!ret) {
> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +		if (ret < 0) {
> +			dev_err(dev, "invalid decimation %d\n",
> +				value);

Afaict you don't need to line break this.

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
> +			dev_err(dev, "invalid avg-samples %d\n",
> +				value);

Ditto

> +			return ret;
> +		}
> +		adc_tm->avg_samples = ret;
> +	} else {
> +		adc_tm->avg_samples = VADC_DEF_AVG_SAMPLES;
> +	}
> +
> +	adc_tm->timer1 = ADC_TM5_TIMER1;
> +	adc_tm->timer2 = ADC_TM5_TIMER2;
> +	adc_tm->timer3 = ADC_TM5_TIMER3;
> +
> +	for_each_available_child_of_node(node, child) {
> +		ret = adc_tm5_get_dt_channel_data(adc_tm, channels, child, data);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +
> +		channels++;
> +		index++;
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
> +	if (ret < 0)
> +		return ret;
> +
> +	adc_tm = devm_kzalloc(&pdev->dev, sizeof(*adc_tm), GFP_KERNEL);
> +	if (!adc_tm)
> +		return -ENOMEM;
> +
> +	adc_tm->regmap = regmap;
> +	adc_tm->dev = dev;
> +	adc_tm->base = reg;
> +	spin_lock_init(&adc_tm->reg_lock);
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
> +
> +	ret = devm_request_irq(dev, irq, adc_tm5_isr, 0,
> +			       "pm-adc-tm5", adc_tm);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, adc_tm);

I don't see a get of the drvdata, you should be able to omit this.

> +
> +	return 0;
> +}
> +
> +static int adc_tm5_remove(struct platform_device *pdev)

Seems like you can omit this function.

> +{
> +	return 0;
> +}
> +
> +static struct platform_driver adc_tm5_driver = {
> +	.driver = {
> +		.name = "spmi-adc-tm5",
> +		.of_match_table = adc_tm5_match_table,
> +	},
> +	.probe = adc_tm5_probe,
> +	.remove = adc_tm5_remove,
> +};
> +module_platform_driver(adc_tm5_driver);
> +
> +MODULE_ALIAS("platform:spmi-adc-tm5");

No code will attempt to load the module by this alias, so please drop
it.

Regards,
Bjorn
