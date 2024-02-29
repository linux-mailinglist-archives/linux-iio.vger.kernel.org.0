Return-Path: <linux-iio+bounces-3212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB8586C826
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0081F21C42
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431257B3F6;
	Thu, 29 Feb 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="g2iLc6R4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9247AE52
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206598; cv=none; b=FeUPp93zi5/1WJsHdGSfRhUqJDhu32x5HJFOT1RdNY+dQZ6t6ucksKLu3LODJzX8ZbGIKzRdlTNRVpV77Ep2laC+HjzoWKzVPxjWFUCDcXEyOC0pGp7yudF66bI9YI0YZOkobJjy+pUQ5qvIOjbrCT7Gyu9gWgZF3b0V/YK+uV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206598; c=relaxed/simple;
	bh=WCWwpAbeCI4tq+W6sny6F7ur5jeb3b7022oL6wr6tkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjneRKS/J8p1fOsYRhYi1qUMQr7nd5co7pOfXYTZKVVKsjLDgrlbwMC4qOBYrvDqlBwhHDg6tQ8DmyaEKZOkww9oc5Gy6YoMF8U5ld8bLUAjNrWOhkBN5co9Cz0MtWbWzIK/95YaxotMChkH9bMKco4S+VqMmBOGSx1uXa53uCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=g2iLc6R4; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41TA4f3D014605;
	Thu, 29 Feb 2024 12:35:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=uT3idpwNCEozgBvE4HnRIc1KURPAttyOb5l6pT6o6T4=; b=g2
	iLc6R4xN1ekJGn2kkjTYYsn+FNoB7e7BRGj5dJFxauRnR3oo26xGFj+TDSk6LTor
	GIkZ1PCo0OAHgPf6t3uQFenWZT2k4owBkgKxtMu1w40X8N3HXzIhpIWjOHBptvD9
	N0mJiOCdR1tk3TrIgQBdJPItknGQ5fiSHv9qe6ldEu4wwyQ0bFodUK8/GyQTAZhC
	UxpiBPLglI2gkAMI5J2zUKDskp6DsOUJ2b5EJSBT+3NbUiqvD5H47lI0or5zuZdd
	GLpMotQ0yy32BtVzvSV2zgxJxAzFEcqWynygKb9//PHPZRFfnHjtXlwR9jermJip
	609jScBmzHLjLPwIsUuw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4bj4pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 12:35:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 337714004C;
	Thu, 29 Feb 2024 12:35:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20A3B26306F;
	Thu, 29 Feb 2024 12:34:29 +0100 (CET)
Received: from [10.201.22.191] (10.201.22.191) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 12:34:28 +0100
Message-ID: <68381afc-9cdf-4163-9232-eb3cbc996d87@foss.st.com>
Date: Thu, 29 Feb 2024 12:34:26 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] iio: adc: stm32: Use
 device_for_each_child_node_scoped()
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Mihail Chindris
	<mihail.chindris@analog.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240224123215.161469-1-jic23@kernel.org>
 <20240224123215.161469-6-jic23@kernel.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20240224123215.161469-6-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02

On 2/24/24 13:32, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> Note this includes a probable fix as in one path an error message was
> printed with ret == 0.

Hi Jonathan,

Indeed, please find later question, inline.

> 
> Took advantage of dev_err_probe() to futher simplify things given no
> longer a need for the goto err.
> 
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v5: Use a local struct device pointer.
>     Add brackets back I shouldn't have dropped.
> 
> Andy had a number of other comments but they would be unrelated changes
> so I'm leaving them for a future patch set.
> ---
>  drivers/iio/adc/stm32-adc.c | 61 +++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index b5d3c9cea5c4..36add95212c3 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2187,58 +2187,52 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				       struct iio_chan_spec *channels)
>  {
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
> -	struct fwnode_handle *child;
> +	struct device *dev = &indio_dev->dev;
>  	const char *name;
>  	int val, scan_index = 0, ret;
>  	bool differential;
>  	u32 vin[2];
>  
> -	device_for_each_child_node(&indio_dev->dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		ret = fwnode_property_read_u32(child, "reg", &val);
> -		if (ret) {
> -			dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
> -			goto err;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel index\n");
>  
>  		ret = fwnode_property_read_string(child, "label", &name);
>  		/* label is optional */
>  		if (!ret) {
> -			if (strlen(name) >= STM32_ADC_CH_SZ) {
> -				dev_err(&indio_dev->dev, "Label %s exceeds %d characters\n",
> -					name, STM32_ADC_CH_SZ);
> -				ret = -EINVAL;
> -				goto err;
> -			}
> +			if (strlen(name) >= STM32_ADC_CH_SZ)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "Label %s exceeds %d characters\n",
> +						     name, STM32_ADC_CH_SZ);
> +
>  			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
>  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
>  			if (ret == -ENOENT)
>  				continue;
>  			else if (ret)
> -				goto err;
> +				return ret;
>  		} else if (ret != -EINVAL) {
> -			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
> -			goto err;
> +			return dev_err_probe(dev, ret, "Invalid label\n");
>  		}
>  
> -		if (val >= adc_info->max_channels) {
> -			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
> -			ret = -EINVAL;
> -			goto err;
> -		}
> +		if (val >= adc_info->max_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid channel %d\n", val);
>  
>  		differential = false;
>  		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
>  		/* diff-channels is optional */
>  		if (!ret) {
>  			differential = true;
> -			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
> -				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
> -					vin[0], vin[1]);

Good catch! I think you're talking about a missing "ret = -EINVAL;" here.

Do you think this should be split as a precursor fix patch, so it can be
picked into stable release ?

Please let me know. Appart from that, you can add my:

Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Best Regards,
Fabrice

> -				goto err;
> -			}
> +			if (vin[0] != val || vin[1] >= adc_info->max_channels)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "Invalid channel in%d-in%d\n",
> +						     vin[0], vin[1]);
>  		} else if (ret != -EINVAL) {
> -			dev_err(&indio_dev->dev, "Invalid diff-channels property %d\n", ret);
> -			goto err;
> +			return dev_err_probe(dev, ret,
> +					     "Invalid diff-channels property\n");
>  		}
>  
>  		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
> @@ -2247,11 +2241,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  		val = 0;
>  		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
>  		/* st,min-sample-time-ns is optional */
> -		if (ret && ret != -EINVAL) {
> -			dev_err(&indio_dev->dev, "Invalid st,min-sample-time-ns property %d\n",
> -				ret);
> -			goto err;
> -		}
> +		if (ret && ret != -EINVAL)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid st,min-sample-time-ns property\n");
>  
>  		stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
>  		if (differential)
> @@ -2261,11 +2253,6 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  	}
>  
>  	return scan_index;
> -
> -err:
> -	fwnode_handle_put(child);
> -
> -	return ret;
>  }
>  
>  static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)

