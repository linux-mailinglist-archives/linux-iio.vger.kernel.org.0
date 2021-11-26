Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDD45F4B9
	for <lists+linux-iio@lfdr.de>; Fri, 26 Nov 2021 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbhKZSjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Nov 2021 13:39:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4177 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbhKZSha (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2021 13:37:30 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J13KZ6Rnmz67msd;
        Sat, 27 Nov 2021 02:33:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 19:34:15 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 18:34:14 +0000
Date:   Fri, 26 Nov 2021 18:34:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V3 3/4] thermal: qcom: Add support for multiple
 generations of devices
Message-ID: <20211126183412.00007d78@Huawei.com>
In-Reply-To: <1637647025-20409-4-git-send-email-quic_jprakash@quicinc.com>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
        <1637647025-20409-4-git-send-email-quic_jprakash@quicinc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 11:27:03 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Refactor code to support multiple generations of ADC_TM devices
> by defining gen number, irq name and disable, configure and isr
> APIs in the individual data structs.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 76 ++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 824671c..fc8cd45 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -78,11 +78,10 @@ enum adc5_timer_select {
>  	ADC5_TIMER_SEL_NONE,
>  };
>  
> -struct adc_tm5_data {
> -	const u32	full_scale_code_volt;
> -	unsigned int	*decimation;
> -	unsigned int	*hw_settle;
> -	bool		is_hc;
> +enum adc5_gen {
> +	ADC_TM5,
> +	ADC_TM_HC,
> +	ADC_TM5_MAX
>  };
>  
>  enum adc_tm5_cal_method {
> @@ -92,6 +91,18 @@ enum adc_tm5_cal_method {
>  };
>  
>  struct adc_tm5_chip;
> +struct adc_tm5_channel;
> +
> +struct adc_tm5_data {
> +	const u32 full_scale_code_volt;
> +	unsigned int *decimation;
> +	unsigned int *hw_settle;
> +	int (*disable_channel)(struct adc_tm5_channel *channel);
> +	int (*configure)(struct adc_tm5_channel *channel, int low, int high);
> +	irqreturn_t (*isr)(int irq, void *data);
> +	char *irq_name;
> +	int gen;
> +};
>  
>  /**
>   * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
> @@ -139,22 +150,6 @@ struct adc_tm5_chip {
>  	u16			base;
>  };
>  
> -static const struct adc_tm5_data adc_tm5_data_pmic = {
> -	.full_scale_code_volt = 0x70e4,
> -	.decimation = (unsigned int []) { 250, 420, 840 },
> -	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
> -					 1000, 2000, 4000, 8000, 16000, 32000,
> -					 64000, 128000 },
> -};
> -
> -static const struct adc_tm5_data adc_tm_hc_data_pmic = {
> -	.full_scale_code_volt = 0x70e4,
> -	.decimation = (unsigned int []) { 256, 512, 1024 },
> -	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
> -					 1000, 2000, 4000, 6000, 8000, 10000 },
> -	.is_hc = true,
> -};
> -
>  static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
>  {
>  	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
> @@ -343,14 +338,14 @@ static int adc_tm5_set_trips(void *data, int low, int high)
>  		channel->channel, low, high);
>  
>  	if (high == INT_MAX && low <= -INT_MAX)
> -		ret = adc_tm5_disable_channel(channel);
> +		ret = chip->data->disable_channel(channel);
>  	else
> -		ret = adc_tm5_configure(channel, low, high);
> +		ret = chip->data->configure(channel, low, high);
>  
>  	return ret;
>  }
>  
> -static struct thermal_zone_of_device_ops adc_tm5_ops = {
> +static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
>  	.get_temp = adc_tm5_get_temp,
>  	.set_trips = adc_tm5_set_trips,
>  };
> @@ -366,7 +361,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
>  		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
>  							   adc_tm->channels[i].channel,
>  							   &adc_tm->channels[i],
> -							   &adc_tm5_ops);
> +							   &adc_tm5_thermal_ops);
>  		if (IS_ERR(tzd)) {
>  			if (PTR_ERR(tzd) == -ENODEV) {
>  				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
> @@ -526,6 +521,31 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>  	return 0;
>  }
>  
> +static const struct adc_tm5_data adc_tm5_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) { 250, 420, 840 },
> +	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 8000, 16000, 32000,
> +					 64000, 128000 },
> +	.disable_channel = adc_tm5_disable_channel,
> +	.configure = adc_tm5_configure,
> +	.isr = adc_tm5_isr,
> +	.irq_name = "pm-adc-tm5",
> +	.gen = ADC_TM5,
> +};
> +
> +static const struct adc_tm5_data adc_tm_hc_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) { 256, 512, 1024 },
> +	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 6000, 8000, 10000 },
> +	.disable_channel = adc_tm5_disable_channel,
> +	.configure = adc_tm5_configure,
> +	.isr = adc_tm5_isr,
> +	.irq_name = "pm-adc-tm5",
> +	.gen = ADC_TM_HC,
> +};
> +
>  static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
>  {
>  	struct adc_tm5_channel *channels;
> @@ -623,7 +643,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (adc_tm->data->is_hc)
> +	if (adc_tm->data->gen == ADC_TM_HC)
>  		ret = adc_tm_hc_init(adc_tm);
>  	else
>  		ret = adc_tm5_init(adc_tm);
> @@ -638,8 +658,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
> -					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
> +	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
> +			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
>  }
>  
>  static const struct of_device_id adc_tm5_match_table[] = {

