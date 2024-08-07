Return-Path: <linux-iio+bounces-8303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E394A283
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 10:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DF61F20F93
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4A1C8242;
	Wed,  7 Aug 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0/n2miuX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A41422D6;
	Wed,  7 Aug 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018593; cv=none; b=eyrRi9qIEhojl8auopavCOjogErwoW0hW2uc5NmSqpdxv3q5yMUL8+2xaZXmWC9AATNk6DSlPizIn62QFZYPPghnG3ST8FoRzLSKw5QE2hyfIN+MpA8loZCVGhrgR/FvK3CMJbSxDMuMLx5256uZx8SMXCGXPzUR5rfc4ROZsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018593; c=relaxed/simple;
	bh=25w59Rt5BTELj9IC5xUKHVYO4WwvnwMypFP5D5jJq2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jMJOC3tdUBB/1phMrWREbyak78kRSrJunsvxBw9rNWKjiamjNUQGRLCu8DtIg2a6aO/GMyZri6G9eHJvadDen4nowM+eGMDz/jyUmTta4f9NTqzhiBMY5l2D3RaoJ71j6sJzeCPHZ3w6FjfHQB0y3zy1XfXfgp3hqdRC05/P0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0/n2miuX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477509Dx006872;
	Wed, 7 Aug 2024 09:41:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hIDSWg+YoC7FJuVuv17qP2JIw07+enJVD1nEaVne5Oc=; b=0/n2miuXulb9zyGV
	sOjbKx85gD5mRPLmT37CZFwmr6qxCQpGT9nk8kuXMD+OrwFq/wD9e45VGmHYWwzM
	328g09heL4y0lbNJc7s8aa1dF3NKUp1XFXlJIpI3H/JHIrOr/byUA3LsvjgVbO/U
	YwYubyT5DkZQcl4KrINPQNUncp26+yAAFUW4PkQWsZB/dr12mwKstzLd89YlXwKf
	Bjr36zQd9R5mFdzTVcJYDuFojFmNZQHrekwnbq0JMfSvjA3ayQ9u1hjJpIv3dSlk
	INyh9bwKWHWdGS2aUtGhCYRkQzoyugDTeUVoBlKVOuqTZSPS8zyc/0WwKROeRd3b
	/4j0OA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40tu6rhhu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 09:41:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B5B734002D;
	Wed,  7 Aug 2024 09:41:18 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8EB122F7C4;
	Wed,  7 Aug 2024 09:40:52 +0200 (CEST)
Received: from [10.252.10.189] (10.252.10.189) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 7 Aug
 2024 09:40:52 +0200
Message-ID: <99b1155f-9c3f-4249-8f6c-f369decc2727@foss.st.com>
Date: Wed, 7 Aug 2024 09:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] iio: add iio backend support to sd modulator
To: Jonathan Cameron <jic23@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
 <20240730084640.1307938-9-olivier.moysan@foss.st.com>
 <20240806175106.09a53784@jic23-huawei>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240806175106.09a53784@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_04,2024-08-06_01,2024-05-17_01

Hi Jonathan,

On 8/6/24 18:51, Jonathan Cameron wrote:
> On Tue, 30 Jul 2024 10:46:38 +0200
> Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> 
>> The legacy sd modulator driver registers the sigma delta modulator as
>> an IIO channel provider. This implementation is not convenient when the
>> SD modulator has to be cascaded with another IIO device. The scaling
>> information is distributed across devices, which makes it difficult to
>> report consistent scaling data on IIO devices.
>>
>> The solution is to expose these cascaded IIO devices as an aggregate
>> device, which report global scaling information.
>> Add IIO backend support to SD modulator to allow scaling information
>> management.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> I've applied this fixup given changes in the backend code that crossed
> with this.
> 
> diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
> index 06f9c5cacd53..654b6a38b650 100644
> --- a/drivers/iio/adc/sd_adc_modulator.c
> +++ b/drivers/iio/adc/sd_adc_modulator.c
> @@ -74,6 +74,11 @@ static const struct iio_backend_ops sd_backend_ops = {
>          .read_raw = iio_sd_mod_read,
>   };
>   
> +static const struct iio_backend_info sd_backend_info = {
> +       .name = "sd-modulator",
> +       .ops = &sd_backend_ops,
> +};
> +
>   static int iio_sd_mod_register(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
> @@ -131,7 +136,7 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
>                  priv->vref_mv = ret / 1000;
>          }
>   
> -       return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
> +       return devm_iio_backend_register(&pdev->dev, &sd_backend_info, priv);
>   };
> 
> Please give it a quick spin. Hopefully I didn't break anything.
> 
> Jonathan

I did a quick check. All looks fine to me.
Thanks for the fixup and the merge.

Regards
Olivier

> 
>> ---
>>   drivers/iio/adc/Kconfig            |  1 +
>>   drivers/iio/adc/sd_adc_modulator.c | 92 +++++++++++++++++++++++++++++-
>>   2 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index bd028d59db63..43ff8182b2ea 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -1195,6 +1195,7 @@ config SD_ADC_MODULATOR
>>   	tristate "Generic sigma delta modulator"
>>   	select IIO_BUFFER
>>   	select IIO_TRIGGERED_BUFFER
>> +	select IIO_BACKEND
>>   	help
>>   	  Select this option to enables sigma delta modulator. This driver can
>>   	  support generic sigma delta modulators.
>> diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
>> index 327cc2097f6c..06f9c5cacd53 100644
>> --- a/drivers/iio/adc/sd_adc_modulator.c
>> +++ b/drivers/iio/adc/sd_adc_modulator.c
>> @@ -6,11 +6,14 @@
>>    * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
>>    */
>>   
>> +#include <linux/iio/backend.h>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/triggered_buffer.h>
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/regulator/consumer.h>
>>   
>>   static const struct iio_info iio_sd_mod_iio_info;
>>   
>> @@ -24,7 +27,54 @@ static const struct iio_chan_spec iio_sd_mod_ch = {
>>   	},
>>   };
>>   
>> -static int iio_sd_mod_probe(struct platform_device *pdev)
>> +struct iio_sd_backend_priv {
>> +	struct regulator *vref;
>> +	int vref_mv;
>> +};
>> +
>> +static int iio_sd_mod_enable(struct iio_backend *backend)
>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	if (priv->vref)diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
> index 06f9c5cacd53..654b6a38b650 100644
> --- a/drivers/iio/adc/sd_adc_modulator.c
> +++ b/drivers/iio/adc/sd_adc_modulator.c
> @@ -74,6 +74,11 @@ static const struct iio_backend_ops sd_backend_ops = {
>          .read_raw = iio_sd_mod_read,
>   };
>   
> +static const struct iio_backend_info sd_backend_info = {
> +       .name = "sd-modulator",
> +       .ops = &sd_backend_ops,
> +};
> +
>   static int iio_sd_mod_register(struct platform_device *pdev)
>   {
>          struct device *dev = &pdev->dev;
> @@ -131,7 +136,7 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
>                  priv->vref_mv = ret / 1000;
>          }
>   
> -       return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
> +       return devm_iio_backend_register(&pdev->dev, &sd_backend_info, priv);
>   };
>> +		return regulator_enable(priv->vref);
>> +
>> +	return 0;
>> +};
>> +
>> +static void iio_sd_mod_disable(struct iio_backend *backend)
>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	if (priv->vref)
>> +		regulator_disable(priv->vref);
>> +};
>> +
>> +static int iio_sd_mod_read(struct iio_backend *backend, struct iio_chan_spec const *chan, int *val,
>> +			   int *val2, long mask)
>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = priv->vref_mv;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		*val = 0;
>> +		return IIO_VAL_INT;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +};
>> +
>> +static const struct iio_backend_ops sd_backend_ops = {
>> +	.enable = iio_sd_mod_enable,
>> +	.disable = iio_sd_mod_disable,
>> +	.read_raw = iio_sd_mod_read,
>> +};
>> +
>> +static int iio_sd_mod_register(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct iio_dev *iio;
>> @@ -45,6 +95,45 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
>>   	return devm_iio_device_register(&pdev->dev, iio);
>>   }
>>   
>> +static int iio_sd_mod_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regulator *vref;
>> +	struct iio_sd_backend_priv *priv;
>> +	int ret;
>> +
>> +	/* If sd modulator is not defined as an IIO backend device, fallback to legacy */
>> +	if (!device_property_present(dev, "#io-backend-cells"))
>> +		return iio_sd_mod_register(pdev);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Get regulator reference if any, but don't enable regulator right now.
>> +	 * Rely on enable and disable callbacks to manage regulator power.
>> +	 */
>> +	vref = devm_regulator_get_optional(dev, "vref");
>> +	if (IS_ERR(vref)) {
>> +		if (PTR_ERR(vref) != -ENODEV)
>> +			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
>> +	} else {
>> +		/*
>> +		 * Retrieve voltage right now, as regulator_get_voltage() provides it whatever
>> +		 * the state of the regulator.
>> +		 */
>> +		ret = regulator_get_voltage(vref);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		priv->vref = vref;
>> +		priv->vref_mv = ret / 1000;
>> +	}
>> +
>> +	return devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
>> +};
>> +
>>   static const struct of_device_id sd_adc_of_match[] = {
>>   	{ .compatible = "sd-modulator" },
>>   	{ .compatible = "ads1201" },
>> @@ -65,3 +154,4 @@ module_platform_driver(iio_sd_mod_adc);
>>   MODULE_DESCRIPTION("Basic sigma delta modulator");
>>   MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
>>   MODULE_LICENSE("GPL v2");
>> +MODULE_IMPORT_NS(IIO_BACKEND);
> 

