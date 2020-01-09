Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855551356E3
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 11:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgAIKbp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 05:31:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35114 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAIKbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 05:31:45 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 009AVYNC091024;
        Thu, 9 Jan 2020 04:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578565894;
        bh=vRdA7ZpngQM+5zB53J/t9D79iFD6d3CN4ckUSA2NKZU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kqfAtqYyVFSJwV7sAQM96ZsH51Cc8Qfcgjh49mQJZW+5wcv9MqpoyEgdaP2YFpDcb
         +2PxadaY9hVlfjIC/8oPqSWQkfi/UFY2Ko2xjxTcHFUwar0CUx/N7aNr3jborunuex
         KcLERc0GHTymkwpkF6fTlikayArqWYj+LJOBXOeg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 009AVYmK079645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 04:31:34 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 04:31:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 04:31:32 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 009AVU9e033718;
        Thu, 9 Jan 2020 04:31:30 -0600
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <20200107114532.6697-1-peter.ujfalusi@ti.com>
 <eade6657-8470-0d70-b3c1-fcdddf891c6c@st.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4c0b7e3e-cd98-860a-e931-c216f1bc6e7a@ti.com>
Date:   Thu, 9 Jan 2020 12:32:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eade6657-8470-0d70-b3c1-fcdddf891c6c@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/01/2020 11.13, Fabrice Gasnier wrote:
> On 1/7/20 12:45 PM, Peter Ujfalusi wrote:
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
>> - Fall back to IRQ mode for ADC only in case of ENODEV
> 
> Hi Peter,
> 
> Thanks for the patch,
> 
> Please find a minor comment here after. Apart from that, you can add my:
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> 
>>
>> Regards,
>> Peter
>>
>>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>> index e493242c266e..74a2211bdff4 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>> @@ -1383,9 +1383,13 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>>  {
>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>  
>> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>> -	if (!adc->dma_chan)
>> -		return -EINVAL;
>> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
>> +	if (IS_ERR(adc->dma_chan)) {
>> +		int ret = PTR_ERR(adc->dma_chan);
>> +
>> +		adc->dma_chan = NULL;
>> +		return ret;
> 
> You may "return PTR_ERR(adc->dma_chan);" directly here.

I don't make decision here on behalf of the adc path on to go forward w/
or w/o DMA support and if we go ahead the stm32_dfsdm_dma_release()
needs the dma_chan to be NULL in case we don't use DMA.

It is much cleaner to set dma_chan to NULL here than doing it in other
paths.

> 
> Best Regards,
> Fabrice
> 
>> +	}
>>  
>>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>>  					 DFSDM_DMA_BUFFER_SIZE,
>> @@ -1509,7 +1513,16 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>  	init_completion(&adc->completion);
>>  
>>  	/* Optionally request DMA */
>> -	if (stm32_dfsdm_dma_request(indio_dev)) {
>> +	ret = stm32_dfsdm_dma_request(indio_dev);
>> +	if (ret) {
>> +		if (ret != -ENODEV) {
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(&indio_dev->dev,
>> +					"DMA channel request failed with %d\n",
>> +					ret);
>> +			return ret;
>> +		}
>> +
>>  		dev_dbg(&indio_dev->dev, "No DMA support\n");
>>  		return 0;
>>  	}
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
