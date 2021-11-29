Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C73460CA7
	for <lists+linux-iio@lfdr.de>; Mon, 29 Nov 2021 03:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhK2CaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 21:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbhK2C2X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 21:28:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF4AC061757
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 18:25:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k23so31579177lje.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 18:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFDHshpl2dqAGPF3MoHGk3Vso6gtNhODB+79/AogQ9g=;
        b=XBoonPe1eIrnsHDCUwya0qnIP3hjiEyRPURX47zbUH0f58LGJuVJETenDe+4PXJ14k
         /bHpX3L8SJgD3IMgcd6mup+YgygXHlovZL2F1iQB8y5+Jq4d3Fe8jAPXcvB00GaGGJRT
         z2B0nnFYKIjih7idRXWK9YCOmAZv7ewoOG6E1Ez+FMEfDI9c9aTrdWwppa/zRR0yfUme
         RupkhNrKMioJ0mkKSswG+1Z1IDuL3QqtcJNGep+8MgwGTEXGDy9prqlZyG4bfLYKcqjI
         JSNg4Me74hl4btPVwq77eBXGI4p+Q5itN5Mjo6LOAxPcxQit4MdY+y9wOGLDoZRyADFR
         b5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFDHshpl2dqAGPF3MoHGk3Vso6gtNhODB+79/AogQ9g=;
        b=gZhj6AetITLaPc/j9xxABMGencn4ByRJW62UBZ4Q1vrM63+PDt+QKtD6QdASL4zQo/
         OZ+Bq57mT+dJeO91rOJG1lm6kbO0Jf0i3Cof4aEa0ZHRFsTEahx/JDAH9rNrbgkgw1Dr
         vHaFKGhv19WLqQIZauxMcxlvwceBV5VURDmcPrulZwdIxNGLjNnSNwDy+tbgVYTcp2YO
         2qdzETqE4FF0d0a+4TmFF0fndfcxuwZTLn4bO8PLBpFlb4DwM6Gjlg3ksYghzNMpbNAz
         +nr7+wqnC0eqJ4Va6MSQ9roz6c+K5/yvfZZuHut6LX6yN+MYBqzJ1cl36GFo78B4PfVZ
         ke0g==
X-Gm-Message-State: AOAM531QHVTjnmPrf3CUaflJiQx9THFYmdjuWUNZ7GyOOX5c28CoBvuj
        6sXSA1i4/6RkgvgAfslN6WduUf0lMb3U6A==
X-Google-Smtp-Source: ABdhPJyNWsMZuDlI5sEJ6vas937eCxVotkiqOCL8L/+b7scSUgcDIF51Tfu40fRc9OcwqKFhApin4g==
X-Received: by 2002:a2e:9197:: with SMTP id f23mr45782387ljg.235.1638152704037;
        Sun, 28 Nov 2021 18:25:04 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m20sm1173100lfu.241.2021.11.28.18.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 18:25:03 -0800 (PST)
Subject: Re: [PATCH V3 3/4] thermal: qcom: Add support for multiple
 generations of devices
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mka@chromium.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        quic_kgunda@quicinc.com, quic_aghayal@quicinc.com,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        quic_subbaram@quicinc.com, jic23@kernel.org, amitk@kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org, linux-iio@vger.kernel.org
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
 <1637647025-20409-4-git-send-email-quic_jprakash@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <47228209-552e-b148-c93a-4fbb5a36583e@linaro.org>
Date:   Mon, 29 Nov 2021 05:25:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637647025-20409-4-git-send-email-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/11/2021 08:57, Jishnu Prakash wrote:
> Refactor code to support multiple generations of ADC_TM devices
> by defining gen number, irq name and disable, configure and isr
> APIs in the individual data structs.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor question below.

> ---
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 76 ++++++++++++++++++++------------
>   1 file changed, 48 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 824671c..fc8cd45 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -78,11 +78,10 @@ enum adc5_timer_select {
>   	ADC5_TIMER_SEL_NONE,
>   };
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
>   };
>   
>   enum adc_tm5_cal_method {
> @@ -92,6 +91,18 @@ enum adc_tm5_cal_method {
>   };
>   
>   struct adc_tm5_chip;
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

Any reason for moving the adc_tm5_data definition? It is still prefix 
with the adc_tmp5_channel declaration.

>   
>   /**
>    * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
> @@ -139,22 +150,6 @@ struct adc_tm5_chip {
>   	u16			base;
>   };
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
>   static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
>   {
>   	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
> @@ -343,14 +338,14 @@ static int adc_tm5_set_trips(void *data, int low, int high)
>   		channel->channel, low, high);
>   
>   	if (high == INT_MAX && low <= -INT_MAX)
> -		ret = adc_tm5_disable_channel(channel);
> +		ret = chip->data->disable_channel(channel);
>   	else
> -		ret = adc_tm5_configure(channel, low, high);
> +		ret = chip->data->configure(channel, low, high);
>   
>   	return ret;
>   }
>   
> -static struct thermal_zone_of_device_ops adc_tm5_ops = {
> +static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
>   	.get_temp = adc_tm5_get_temp,
>   	.set_trips = adc_tm5_set_trips,
>   };
> @@ -366,7 +361,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
>   		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
>   							   adc_tm->channels[i].channel,
>   							   &adc_tm->channels[i],
> -							   &adc_tm5_ops);
> +							   &adc_tm5_thermal_ops);
>   		if (IS_ERR(tzd)) {
>   			if (PTR_ERR(tzd) == -ENODEV) {
>   				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
> @@ -526,6 +521,31 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>   	return 0;
>   }
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
>   static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
>   {
>   	struct adc_tm5_channel *channels;
> @@ -623,7 +643,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	if (adc_tm->data->is_hc)
> +	if (adc_tm->data->gen == ADC_TM_HC)
>   		ret = adc_tm_hc_init(adc_tm);
>   	else
>   		ret = adc_tm5_init(adc_tm);
> @@ -638,8 +658,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
> -					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
> +	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
> +			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
>   }
>   
>   static const struct of_device_id adc_tm5_match_table[] = {
> 


-- 
With best wishes
Dmitry
