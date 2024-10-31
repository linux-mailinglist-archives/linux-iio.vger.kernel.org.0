Return-Path: <linux-iio+bounces-11688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8C9B793C
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA181F25954
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC174199FC1;
	Thu, 31 Oct 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYY8gZLs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575071465A5
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730372447; cv=none; b=IQYTlcFxMZiErnzQaniV+pq/sdR73xANrupHvORscBPg7DmIAvbrrLFYduwby6oLLlTuB6goaVxsESe2GMuRBlvn38vqW/KZrajp6/5xVGgYVSghqc8XcgGbFO8iDg3YFIgsxvYz7N86a901bn48mua58MNCeVdOKgvgGvZ1Nqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730372447; c=relaxed/simple;
	bh=znI1vLHdg694qB8laV1SorOSj4KUX3ztgE1UtmuEJsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1gRrD4u0VYs8x6ScU98AjUSCgrdTmNhK7kHVgKQBm588Wj04tMJUB7Nt5t6mcAoZ3lE6EpaVZ7yOw5DzzLuqwI/kGCcPrw4xXf/G26qD5w2W1bsp9Fx0PEnDnemO2K2KAjo2xRHdqQSIQZfQAKyKUDBQRQ+MsCmzLkHs5wO+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYY8gZLs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so908125e9.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730372444; x=1730977244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uqnuHXpehAaCSgUNGFqejz7JGIz1jRi00c1HK4MJ/D4=;
        b=fYY8gZLsZMdArjs65zPUpJA4YddYUKDVD1glIVsEvq8mLipGe/n4j6UAn2vfBTQ3hh
         m8+bP9ZAh3Bij9XjOZ6P9+KzQPmDp4cDQ8Hm2lhtZaEpKoBLN+NP7p044+GmASC/HK79
         MoJnrEVfybqSCRHpNiiLbO4MN9MxsPW6dcdpxqcNR1yLW1uKjHo/8mkQNJyk77J+/zyt
         lFUurSorEDOtW1n+NV9SqqUoj4OXNfY32Q4eb/Jql/0Pr6j8IDM0cEx69dWIH6ydFfWZ
         XLMREvACSzbRr1gxlVjgqtK95UT0FwKHIcy/dK3iJs8LqmVOPID1fjbETfoj12x80JIh
         nT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730372444; x=1730977244;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqnuHXpehAaCSgUNGFqejz7JGIz1jRi00c1HK4MJ/D4=;
        b=r9v2C5ovBGaCVa1v5wK8j2kUjHwI6uNraQhj193/ZJJ5HzFOf0fEIQtAqxfbq+uWHl
         7fXg1hxoR68TRvG03nN9opjOA3BHe+DtFLBwV7WktGCN4flAE3G9MNwAfANmod2hggVp
         9gUpbqyCmqaH3pyO5RNQ1CpUzshSixExjlReUfx/BwmaItf4qBBvJ95LJvqVVrBi+5M6
         XQjMtepyPnB2Vn3lTR88UN6wWjE9VnrQzZnzwGBHCjg3f+ZkFTafDRoaLWiadpjbJWEc
         v8ApvOOAUYH12nW9YoCpsIZaVw5SBUYv0XCG7hiN7hDtDuFZpHYDM0U1+X1OrI3YC4nZ
         62Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUn2qjCDdN0xMHysBhhY1+AfiDQg8F/8ermlNA/vCL1lp69pRtsZ+X4B22e69YwpgGd/cWBvjlwpaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLkbVOD0qrAR1Mz1T5KhSOZoIvheI4XmvRGsRuISyt6H6lp62
	e6vMngINW5Zg9Y1G/Z9w20np1Cp8BzrLoh2+iqjhhizzWklV+eZDoWNp1rBRC8s=
X-Google-Smtp-Source: AGHT+IG0KFcN9hdgvm8g/CsXnz19OMrqMBupD0bXUqxM/Gnjtl1mLZA2FWFgQxYEZFoGMEs6Y1XxNQ==
X-Received: by 2002:a05:600c:4f10:b0:42c:ba6c:d9b1 with SMTP id 5b1f17b1804b1-4319ad236dcmr73681605e9.4.1730372443738;
        Thu, 31 Oct 2024 04:00:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910357sm54052595e9.11.2024.10.31.04.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:00:43 -0700 (PDT)
Message-ID: <8556e116-a8ac-404e-b0ba-2f35dd081dfe@linaro.org>
Date: Thu, 31 Oct 2024 12:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
 konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
 quic_amelende@quicinc.com, quic_kamalw@quicinc.com, amitk@kernel.org
Cc: lee@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-5-quic_jprakash@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241030185854.4015348-5-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 19:58, Jishnu Prakash wrote:
> Add support for ADC_TM part of PMIC5 Gen3.
> 
> This is an auxiliary driver under the Gen3 ADC driver, which
> implements the threshold setting and interrupt generating
> functionalities of QCOM ADC_TM drivers, used to support thermal
> trip points.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  drivers/thermal/qcom/Kconfig                  |  11 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 489 ++++++++++++++++++
>  3 files changed, 501 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 2c7f3f9a26eb..f9876fb8606d 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -21,6 +21,17 @@ config QCOM_SPMI_ADC_TM5
>  	  Thermal client sets threshold temperature for both warm and cool and
>  	  gets updated when a threshold is reached.
>  
> +config QCOM_SPMI_ADC_TM5_GEN3
> +	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
> +	depends on OF && SPMI && IIO && QCOM_SPMI_ADC5_GEN3

|| COMPILE_TEST won't work?

> +	select REGMAP_SPMI
> +	select QCOM_VADC_COMMON
> +	help
> +	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
> +	  monitoring device. It shows up as a thermal zone with multiple trip points.
> +	  Thermal client sets threshold temperature for both warm and cool and
> +	  gets updated when a threshold is reached.
> +


...

> +
> +static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
> +	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
> +
> +static struct adc_tm5_auxiliary_drv adctm5gen3_auxiliary_drv = {
> +	.adrv = {
> +		.id_table = adctm5_auxiliary_id_table,
> +		.probe = adc_tm5_probe,
> +	},
> +	.tm_event_notify = adctm_event_handler,
> +};
> +
> +static int __init adctm5_init_module(void)
> +{
> +	return auxiliary_driver_register(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +static void __exit adctm5_exit_module(void)
> +{
> +	auxiliary_driver_unregister(&adctm5gen3_auxiliary_drv.adrv);
> +}
> +
> +module_init(adctm5_init_module);
> +module_exit(adctm5_exit_module);

Why not module_auxiliary_driver?


Best regards,
Krzysztof


