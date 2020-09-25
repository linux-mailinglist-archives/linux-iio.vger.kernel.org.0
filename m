Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFCA278629
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgIYLm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 07:42:29 -0400
Received: from z5.mailgun.us ([104.130.96.5]:42647 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgIYLm3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 07:42:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601034148; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=9tEzE1V0mHPa1EiuwWlCtSVX3/hfU2/0ETy9LFMC3eI=; b=CAIh6v4vhK4VobJZtz6DsJl/MJF++5MudOsDFugYYMUVYaQU0kqp+lMOHGNH2et6Jyc2B41M
 0a0xPwXkmwREdh+ERzdksDiMSlOKNpTTJvm1CBDSxX+8c8hjWKd2qE2l7870u3/zAle2E4wP
 14Af+sMHVIJXgJr0d0qEzsG3vCU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f6dd7a099ecd993e1b56365 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Sep 2020 11:42:24
 GMT
Sender: jprakash=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D801CC433F1; Fri, 25 Sep 2020 11:42:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.101] (unknown [157.48.192.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C315C433CA;
        Fri, 25 Sep 2020 11:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C315C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH v5 7/9] thermal: qcom: add support for adc-tm5 PMIC
 thermal monitor
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
 <20200914154809.192174-8-dmitry.baryshkov@linaro.org>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <fe3fc299-5f1d-5318-49f6-b8d42d0615da@codeaurora.org>
Date:   Fri, 25 Sep 2020 17:12:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914154809.192174-8-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dmitry,

Recently I was testing the ADC_TM driver added with these changes on 
SC7180 and I could see that this patch needs a few changes, which I'll 
mention below.

On 9/14/2020 9:18 PM, Dmitry Baryshkov wrote:
> Add support for Thermal Monitoring part of PMIC5. This part is closely
> coupled with ADC, using it's channels directly. ADC-TM support
> generating interrupts on ADC value crossing low or high voltage bounds,
> which is used to support thermal trip points.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/adc/qcom-vadc-common.c       |  62 +++
>   drivers/iio/adc/qcom-vadc-common.h       |   3 +
>   drivers/thermal/qcom/Kconfig             |  11 +
>   drivers/thermal/qcom/Makefile            |   1 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 583 +++++++++++++++++++++++
>   5 files changed, 660 insertions(+)
>   create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c
>
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 40d77b3af1bb..e58e393b8713 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -377,6 +377,42 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
>   	return 0;
>   }
>   


> +static irqreturn_t adc_tm5_isr(int irq, void *data)
> +{
> +	struct adc_tm5_chip *chip = data;
> +	u8 status_low, status_high, ctl;
> +	int ret = 0, i = 0;
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, 1);
> +	if (ret) {
> +		dev_err(chip->dev, "read status low failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, 1);
> +	if (ret) {
> +		dev_err(chip->dev, "read status high failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
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
> +
> +		if (ret) {
> +			dev_err(chip->dev, "ctl read failed with %d\n", ret);
> +			continue;
> +		}
> +
> +		lower_set = (status_low & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_MEAS_EN) &&
> +			(ctl & ADC_TM5_M_LOW_THR_INT_EN);
> +
> +		upper_set = (status_high & BIT(ch)) &&
> +			(ctl & ADC_TM5_M_MEAS_EN) &&
> +			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);
> +
> +		if (upper_set || lower_set)
> +			thermal_zone_device_update(chip->channels[i].tzd,
> +						   THERMAL_EVENT_UNSPECIFIED);

When using thermal_zone_device_update here, it internally calls 
tz->ops->get_temp, which maps to adc_tm5_get_temp defined just below. 
This in turn calls iio_read_channel_processed, which internally calls a 
mutex and this results in a mutex being called from atomic context.

To avoid this, the interrupt should be requested as a threaded IRQ.

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
> +	if (ret)
> +		dev_err(chip->dev, "buf write failed\n");
> +
> +	return ret;
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
In addition to the configurations done in adc_tm5_configure, you also 
need to write to the registers at 0x3546 (write 0x80 to enable the 
ADC_TM peripheral overall) and 0x3547 (this is the conversion request 
strobe, you need to write to bit 7 here too, to initiate the recurring 
measurements).
> +
> +	return ret;
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
> +		return ret;
> +	}
> +
> +	return devm_request_irq(dev, irq, adc_tm5_isr, 0, "pm-adc-tm5", adc_tm);
The interrupt should be requested with devm_request_threaded_irq, with 
the existing interrupt handler being given as the threaded function, for 
the reason mentioned above earlier.
> +}
> +
>
