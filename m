Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B566713582E
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 12:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgAILkV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 06:40:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32846 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAILkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 06:40:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 009BeADg130591;
        Thu, 9 Jan 2020 05:40:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578570010;
        bh=Cu4eyh0A9jxWfcjHOeLDmeCMBzCRubt5Z+/kuTU79Ps=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OUi6OecaQFvcx95eewNrsUrydDelMSKwWkYa9Wro3ArlLEG+THkF5kHvNkgK9Kz3q
         BjX3yWzjPydHC7L4DG+dqWXW5szKEuLWh35Vhp/PzKvgRlEVFe5fuOSEZ9M6T7Rmwm
         blwlgEgJ6st6E07eiC6qv8oFvrgia0j789jB+nQE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 009BeAlk120926;
        Thu, 9 Jan 2020 05:40:10 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 05:40:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 05:40:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 009Be6Kp019653;
        Thu, 9 Jan 2020 05:40:06 -0600
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
 <4c0b7e3e-cd98-860a-e931-c216f1bc6e7a@ti.com>
 <698d9dec-4486-f70a-b8e0-dfd6b4bb907f@st.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <45195b31-70fa-39c9-e109-eeb33d6a2663@ti.com>
Date:   Thu, 9 Jan 2020 13:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <698d9dec-4486-f70a-b8e0-dfd6b4bb907f@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/01/2020 13.29, Fabrice Gasnier wrote:
> On 1/9/20 11:32 AM, Peter Ujfalusi wrote:
>>
>>
>> On 09/01/2020 11.13, Fabrice Gasnier wrote:
>>> On 1/7/20 12:45 PM, Peter Ujfalusi wrote:
>>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>>>> eating up the error code.
>>>>
>>>> By using dma_request_chan() directly the driver can support deferred
>>>> probing against DMA.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>> Hi,
>>>>
>>>> Changes since v1:
>>>> - Fall back to IRQ mode for ADC only in case of ENODEV
>>>
>>> Hi Peter,
>>>
>>> Thanks for the patch,
>>>
>>> Please find a minor comment here after. Apart from that, you can add my:
>>>
>>> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>
>>>
>>>>
>>>> Regards,
>>>> Peter
>>>>
>>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++++++++----
>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>> index e493242c266e..74a2211bdff4 100644
>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>> @@ -1383,9 +1383,13 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>>>>  {
>>>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>>>  
>>>> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>>>> -	if (!adc->dma_chan)
>>>> -		return -EINVAL;
>>>> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
>>>> +	if (IS_ERR(adc->dma_chan)) {
>>>> +		int ret = PTR_ERR(adc->dma_chan);
>>>> +
>>>> +		adc->dma_chan = NULL;
>>>> +		return ret;
>>>
>>> You may "return PTR_ERR(adc->dma_chan);" directly here.
>>
>> I don't make decision here on behalf of the adc path on to go forward w/
>> or w/o DMA support and if we go ahead the stm32_dfsdm_dma_release()
>> needs the dma_chan to be NULL in case we don't use DMA.
>>
>> It is much cleaner to set dma_chan to NULL here than doing it in other
>> paths.
> 
> Hi Peter,

Hi Fabrice,

> Sorry I wasn't clear enough. I agree with you. I was suggesting only,
> talking about the 'ret' variable. It may be removed to spare a few lines
> :-).
> 	if (IS_ERR(adc->dma_chan)) {
> 		adc->dma_chan = NULL;
> 		return PTR_ERR(adc->dma_chan);
> 	}
> I'm okay both ways.

PTR_ERR(NULL); will return 0
I need to retrieve the actual error code before NULLing dma_chan.

> 
>>
>>>
>>> Best Regards,
>>> Fabrice
>>>
>>>> +	}
>>>>  
>>>>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>>>>  					 DFSDM_DMA_BUFFER_SIZE,
>>>> @@ -1509,7 +1513,16 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>>>  	init_completion(&adc->completion);
>>>>  
>>>>  	/* Optionally request DMA */
>>>> -	if (stm32_dfsdm_dma_request(indio_dev)) {
>>>> +	ret = stm32_dfsdm_dma_request(indio_dev);
>>>> +	if (ret) {
>>>> +		if (ret != -ENODEV) {
>>>> +			if (ret != -EPROBE_DEFER)
>>>> +				dev_err(&indio_dev->dev,
>>>> +					"DMA channel request failed with %d\n",
>>>> +					ret);
>>>> +			return ret;
>>>> +		}
>>>> +
>>>>  		dev_dbg(&indio_dev->dev, "No DMA support\n");
>>>>  		return 0;
>>>>  	}
>>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
