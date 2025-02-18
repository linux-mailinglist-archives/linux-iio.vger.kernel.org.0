Return-Path: <linux-iio+bounces-15732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D68AA3A17E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA30174273
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786826D5B2;
	Tue, 18 Feb 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kOAbmaC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616EC269AF4
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893124; cv=none; b=lH7X5LRPFZMST41s+bYIiXOhjB0nNyfaGguDnd82shbLQe/NZ9Kd7T2/2uxsNmgAauQ85+7WnX8H2XcOQqmeRMQDISesjkydRinQouCMTVQwTLAGgIqAx0ZnSLmLcSohlMVDVEZNsH4jDu7IhZuaFoE43JM2qs/JlqegTzmYlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893124; c=relaxed/simple;
	bh=EunZvWuPE+i0uUdbG0C/zQeE9+dEcF+gq8VNQvIRzzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u7i/gJk0TpDZFGBDGJ48ITmC3T76ywlN5oYICnTJw1sVmtMK+h2S0V/NdrokSwHIsDVmxpr2M3TJY1xProZbJ7K2eaH0o12bgx6cipRijLkOQD2cbryBQfh8H/ctaS6fXKfIwSU7paXZ6Rx7Y6ipiSjxtJ86mWnDEzaHMgjS6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kOAbmaC6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFTNLd007133;
	Tue, 18 Feb 2025 16:38:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OmisL5CsudBoD4cXCVo+/62yuc+c+5/VsHy6LVxkuDk=; b=kOAbmaC6x+BYStkR
	PfQI1JFUrTLw36Zh/IQCA3EBVLJONR1QmbjiKpAnBR4pn+viA9jRlVG5Pf+ZTUP1
	s/eRbz+HDrNfMs26K9GRtl8StytENyNuIHSMAFnCec9ErrY/6P9CAsH5SK5vCs4k
	1fVXpKlrtM9Lf0BF1V1KTeEpqhACPfzpDvyXAfREJT9+EGdQwnIzfuRQlQgxSfPR
	qSzELHXbdqPAHAbuCg5NC2zSlmJ3lQx9jLgRSXLlO9PrwP09PVMrYRX3fCYrGVSJ
	SeWwj9pdyC81che1M1xDYZ8LSEdQfJPyLj0JUlKOdQPwVt8hPJBRwMYkPZM8QCd5
	TZW+vA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44tkutvjpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:38:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC49B40048;
	Tue, 18 Feb 2025 16:36:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7CFA434A6C;
	Tue, 18 Feb 2025 16:32:50 +0100 (CET)
Received: from [10.252.27.157] (10.252.27.157) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 16:32:49 +0100
Message-ID: <5617a92f-8c15-421d-93c4-424e6de3b863@foss.st.com>
Date: Tue, 18 Feb 2025 16:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/29] iio: adc: stm32-dfsdm: Factor out core of reading
 INFO_RAW
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
	<noname.nuno@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Phil Reid
	<preid@electromag.com.au>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea
	<claudiu.beznea@tuxon.dev>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Alisa-Dariana Roman <alisa.roman@analog.com>,
        Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
References: <20250217141630.897334-1-jic23@kernel.org>
 <20250217141630.897334-8-jic23@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20250217141630.897334-8-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01

Hi Jonathan,

Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Thanks

On 2/17/25 15:16, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This allows the claim on direct mode to be release in one place
> rather than a lot of error paths, simplifying code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   drivers/iio/adc/stm32-dfsdm-adc.c | 59 +++++++++++++++++++------------
>   1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index fe11b0d8eab3..1cf2594d6872 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1306,6 +1306,38 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>   	return -EINVAL;
>   }
>   
> +static int __stm32_dfsdm_read_info_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int *val)
> +{
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (adc->hwc)
> +		ret = iio_hw_consumer_enable(adc->hwc);
> +	if (adc->backend)
> +		ret = iio_backend_enable(adc->backend[chan->scan_index]);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			"%s: IIO enable failed (channel %d)\n",
> +			__func__, chan->channel);
> +		return ret;
> +	}
> +	ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
> +	if (adc->hwc)
> +		iio_hw_consumer_disable(adc->hwc);
> +	if (adc->backend)
> +		iio_backend_disable(adc->backend[chan->scan_index]);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			"%s: Conversion failed (channel %d)\n",
> +			__func__, chan->channel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>   				struct iio_chan_spec const *chan, int *val,
>   				int *val2, long mask)
> @@ -1326,30 +1358,11 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>   		ret = iio_device_claim_direct_mode(indio_dev);
>   		if (ret)
>   			return ret;
> -		if (adc->hwc)
> -			ret = iio_hw_consumer_enable(adc->hwc);
> -		if (adc->backend)
> -			ret = iio_backend_enable(adc->backend[idx]);
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev,
> -				"%s: IIO enable failed (channel %d)\n",
> -				__func__, chan->channel);
> -			iio_device_release_direct_mode(indio_dev);
> -			return ret;
> -		}
> -		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
> -		if (adc->hwc)
> -			iio_hw_consumer_disable(adc->hwc);
> -		if (adc->backend)
> -			iio_backend_disable(adc->backend[idx]);
> -		if (ret < 0) {
> -			dev_err(&indio_dev->dev,
> -				"%s: Conversion failed (channel %d)\n",
> -				__func__, chan->channel);
> -			iio_device_release_direct_mode(indio_dev);
> -			return ret;
> -		}
> +
> +		ret = __stm32_dfsdm_read_info_raw(indio_dev, chan, val);
>   		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>   		return IIO_VAL_INT;
>   
>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

