Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689D6133C91
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2020 09:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAHID6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jan 2020 03:03:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52660 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHID6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jan 2020 03:03:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00883lPd117939;
        Wed, 8 Jan 2020 02:03:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578470627;
        bh=e7cuocncCbuxjywazcX7HKTb/Mw4T5KMNhkOUHettWc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nu7E+puxSqcLXcZZxc2CNxBQS58QZpLRQGpsElGO+SspowlPonvmYOddgUHYoVo+y
         Bq3ABNJIPEyu6k5jzK+YJL+MC5bk2neg4ERCXDu1OqdndapvLKha4RF2IKj4gY4W8J
         +vVEQRS7VIdllGZsU13DRAuLCMmQj7hHHp1Ocskw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00883lBA104600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 02:03:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 02:03:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 02:03:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00883i5s040553;
        Wed, 8 Jan 2020 02:03:44 -0600
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <20200107114125.6095-1-peter.ujfalusi@ti.com>
 <5146b085-d92d-7230-9a05-87926711dafa@st.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8e706545-958d-1c34-9d6d-addd4cb6af25@ti.com>
Date:   Wed, 8 Jan 2020 10:04:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5146b085-d92d-7230-9a05-87926711dafa@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabrice,

On 07/01/2020 19.15, Fabrice Gasnier wrote:
> On 1/7/20 12:41 PM, Peter Ujfalusi wrote:
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since v1:
>> - Fall back to IRQ mode only in case of ENODEV
>>
>> Regards,
>> Peter
> 
> Hi Peter,
> 
> Thanks for the patch,
> 
> In case you send another version... I've just a minor suggestion
> regarding the comment (see after). Apart from that, you can add my:

Thanks, I'll take your suggested update and send v3.

> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Best Regards,
> Fabrice
> 
>>
>>  drivers/iio/adc/stm32-adc.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index 3b291d72701c..df5f5d61f9f9 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -1746,9 +1746,21 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>>  	struct dma_slave_config config;
>>  	int ret;
>>  
>> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>> -	if (!adc->dma_chan)
>> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
>> +	if (IS_ERR(adc->dma_chan)) {
>> +		ret = PTR_ERR(adc->dma_chan);
>> +		if (ret != -ENODEV) {
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(&indio_dev->dev,
>> +					"DMA channel request failed with %d\n",
>> +					ret);
>> +			return ret;
>> +		}
>> +
>> +		/* Ignore errors to fall back to IRQ mode */
> 		               ^
> 		          error
> alternate suggestion:
> 		/* DMA is optional: fall back to IRQ mode */

Makes more sense in the context.

> 
>> +		adc->dma_chan = NULL;
>>  		return 0;
>> +	}
>>  
>>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>>  					 STM32_DMA_BUFFER_SIZE,
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
