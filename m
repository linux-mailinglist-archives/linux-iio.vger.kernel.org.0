Return-Path: <linux-iio+bounces-19946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2BAC4297
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF6617918E
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8662101B7;
	Mon, 26 May 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7KAOfWuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93F1EEA47;
	Mon, 26 May 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274733; cv=none; b=n1OmWhPHwokQKQIRXbuB4orODHFXPzqjx4b6XhsvNtt1N9xHHjaO0E9ebcas5mqN18C4zOPjowlxOvcRnjK4zrZJYZ+u8un5Pg5NERVi7bKk/rgN4G7eCnXW4StdHPI/O9lqiSfG6diM6h2mislJv+DhWAjoYsPmjwQ/dQIcuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274733; c=relaxed/simple;
	bh=za6bVeF1c6KeXsHnOuzuJWYKeSGH1gVcfLmfUUP+kaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tF49SjQetrinvezoPxe8yi71tg1oXPL7ANkbDftU8fjPGTxy8Xgw8d3KHrfEbcSBSTjtzzNhPe4Ysh1plnzghqZ0y1W7ZXcgXmj+zk6Vf2hBaGhfXVIKMQWwn90Zu2ZE/TYUM3aiG31OHrmi/kFhWUcirF5QkO9bJ95pVF+kP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7KAOfWuS; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QB4fPp012749;
	Mon, 26 May 2025 17:51:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rW5ZHuaPdfqfwDvrnkrsezcElkYLPA1vqOkoWGgulJw=; b=7KAOfWuSkxrfv3ap
	O/Sd902RG47wwlINI4gwwK7ogvvAsXgo4HKT2hcSwYMLVZjKAzZBh4Jqlzi3/DC5
	UB6qLfo2/9JVQ+w+LizQVutPccWnKsLldljzQ69yzezypqQbxJyyr8hVJzYHeatI
	oQsACu+tzGfsUuiODQFi8BxsiPO4RYcdPpA1/vVxdUGm0ctQj9dTvy0LQmJEi8C5
	1/Fh3z+pnmZpvX0jnyBWOQQpF2tGmN+Wr4rIn0Hz2Vlx6tQG4JnxtZVUoxjI70Tl
	PHa0sdv/yDXDIkr54h9okZ7Vov/saSr6jtTloRwKPzoo1SmxwjC7DfxqsfyozAlU
	tNr7oQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46uqp4dnhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 May 2025 17:51:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E564F40056;
	Mon, 26 May 2025 17:50:19 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BE99ACB869;
	Mon, 26 May 2025 17:48:33 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 17:48:33 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 17:48:32 +0200
Message-ID: <ab75c390-b172-4dbb-b46b-8cbf64d4600a@foss.st.com>
Date: Mon, 26 May 2025 17:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Fix race in installing chained
 IRQ handler
To: Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
	<noname.nuno@gmail.com>
CC: Chen Ni <nichen@iscas.ac.cn>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <u.kleine-koenig@baylibre.com>,
        <tglx@linutronix.de>, <robh@kernel.org>, <jirislaby@kernel.org>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
References: <20250515083101.3811350-1-nichen@iscas.ac.cn>
 <229cf78caaa7e9f2bb4cfa62c019acd51a1cd684.camel@gmail.com>
 <20250525120703.5dd89fc2@jic23-huawei>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250525120703.5dd89fc2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01


On 5/25/25 13:07, Jonathan Cameron wrote:
> On Thu, 15 May 2025 11:26:56 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
>> On Thu, 2025-05-15 at 16:31 +0800, Chen Ni wrote:
>>> Fix a race where a pending interrupt could be received and the handler
>>> called before the handler's data has been setup, by converting to
>>> irq_set_chained_handler_and_data().
>>>
>>> Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
>>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>>> ---  
>>
>> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Looks good to me and I've queued it up for after rc1.  If any
> ST folk have time to take a look that would be great.

Hi Jonathan,

One minor comment at my end, not sure if that changes a lot...
This could be a fix for the older commit:
1add69880240 ("iio: adc: Add support for STM32 ADC core")

Apart from that, you can add my:
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

BR,
Fabrice

> 
> Jonathan
> 
>>
>>> Changelog:
>>>
>>> v1 -> v2:
>>>
>>> 1. Add Fixes tag.
>>> ---
>>>  drivers/iio/adc/stm32-adc-core.c | 7 +++----
>>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-
>>> core.c
>>> index bd3458965bff..21c04a98b3b6 100644
>>> --- a/drivers/iio/adc/stm32-adc-core.c
>>> +++ b/drivers/iio/adc/stm32-adc-core.c
>>> @@ -430,10 +430,9 @@ static int stm32_adc_irq_probe(struct platform_device
>>> *pdev,
>>>  		return -ENOMEM;
>>>  	}
>>>  
>>> -	for (i = 0; i < priv->cfg->num_irqs; i++) {
>>> -		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
>>> -		irq_set_handler_data(priv->irq[i], priv);
>>> -	}
>>> +	for (i = 0; i < priv->cfg->num_irqs; i++)
>>> +		irq_set_chained_handler_and_data(priv->irq[i],
>>> +						 stm32_adc_irq_handler,
>>> priv);
>>>  
>>>  	return 0;
>>>  }  
> 

