Return-Path: <linux-iio+bounces-15733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BCA3A17F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E123B17444A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891C26E153;
	Tue, 18 Feb 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0qnCO9Vp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835726D5BE
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893124; cv=none; b=a1oGz5kY4TW0/ABopX85kvE1AqP3RQKjRERGdsHExU3lPx+NMBBFPEkS5XRrdvZLCK9IamnTQB4u4v1EqvR6FNZ7B89g3TG4RotXI0tO30qGdCpJhpGqolFlrtfs08fRHFPIZpRIWta7khOHhb6wd0eQhSeLAyj3EmoL7XY2meE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893124; c=relaxed/simple;
	bh=n27rPCOOlEP6UGzmSrRCuH0YzYw4d/jNhfMDGy+QkbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HaAbgNzXc+PAhvRqWL8mMtTmrfXnV/IVSe8c09CmbO9UqcP9SmjQKG26ByicvpC9qktSEDBvjJAjqDSRHcVkAtMqR6z8QKLU2Uv/99FJBVyxibDIgVuem2u0lAVK3uyf11L4bmjnkkH0FqKEtAPc2QZ4iF4/NPZcGZyehZBRJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0qnCO9Vp; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IFTLke011577;
	Tue, 18 Feb 2025 16:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tcI4bKhRQMc6vn/+QK1VIfr/hnLtnBWH8kedwLf0S58=; b=0qnCO9VpbedveJtJ
	k27SY08O+jf1v8blcsyPH1zKq4iApcHO+BvoyNUT1pnhhRmQtqy5BRh4cH+M1uW6
	xhpCRyeKQ+khgdKhigRfsNDU/Goiw4a68NfgpG1/Ig6eXrL7yTbFl0WrSbF+k68v
	pP/AzvcJiJdjeVmfAgfOdqeNsxTWIz5+aApUVY1z5vdpod9cYILElRkz7bx0zYBc
	qjnjrH4f4vFKBP/y6TKanevck1TqwiSZKc0BnXBpyWNO+ezTpZwNh9qxbHaKeBto
	DoRsHKSAvEaVR1c1FXxsUXAKkxjO1yMyNxz5Wflz+RL7QXWpcl7bp5nVCGwDdPTk
	6qxqSg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44u6rn2es3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:38:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ABB884002D;
	Tue, 18 Feb 2025 16:36:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B30D43BE55;
	Tue, 18 Feb 2025 16:34:09 +0100 (CET)
Received: from [10.252.27.157] (10.252.27.157) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 16:34:08 +0100
Message-ID: <34540c7c-dd91-48d5-9995-cb75bc095f32@foss.st.com>
Date: Tue, 18 Feb 2025 16:34:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/29] iio: adc: stm32-dfsdm: Switch to sparse friendly
 iio_device_claim/release_direct()
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
 <20250217141630.897334-9-jic23@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20250217141630.897334-9-jic23@kernel.org>
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
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 1cf2594d6872..726ddafc9f6d 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1275,9 +1275,8 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>   
>   	switch (mask) {
>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>   
>   		ret = stm32_dfsdm_compute_all_osrs(indio_dev, val);
>   		if (!ret) {
> @@ -1287,19 +1286,18 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
>   			adc->oversamp = val;
>   			adc->sample_freq = spi_freq / val;
>   		}
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>   		return ret;
>   
>   	case IIO_CHAN_INFO_SAMP_FREQ:
>   		if (!val)
>   			return -EINVAL;
>   
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>   
>   		ret = dfsdm_adc_set_samp_freq(indio_dev, val, spi_freq);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>   		return ret;
>   	}
>   
> @@ -1355,12 +1353,11 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>   
>   	switch (mask) {
>   	case IIO_CHAN_INFO_RAW:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>   
>   		ret = __stm32_dfsdm_read_info_raw(indio_dev, chan, val);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>   		if (ret)
>   			return ret;
>   		return IIO_VAL_INT;

