Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36728135993
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgAIM43 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 07:56:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727701AbgAIM43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 07:56:29 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Cr4dT031277;
        Thu, 9 Jan 2020 13:56:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=2y1+dv3nA3YET9zOXNr+lo/MYiTPIWq79tj8sKOA3F8=;
 b=sbIXe/5jUi27CnIYRMXm6JcfW3/WQkj8DcllHwy+LR+c3b8zV3LVq3LiYZrVJyMPFCj3
 DUhW51atwpcQmQWIaS+64nhhztJehmjuMFsZVDmQKKabEhVq2yVh7N3RU+9G6zLhMwZu
 rv4fUOrpzUSr56B6r4tNuUg5xlttT2mxC38v827WTNAnM8nfVDZRO24jdAB4A61OpPTZ
 RVCd7WhUzPtTlbttM1PbyAD2/KP8xZkfZDkFJKEUj41MzsWi+oKNHcUdaCViYCtFpher
 YHp2ojOTg+176+I/GtlRckbcTBNKG7M+Z83EFG6Uqfv/O+N7fDlDsNg8vdSujmCuexo+ Fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2xdw8b2dya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 13:56:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB47A10002A;
        Thu,  9 Jan 2020 13:56:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA77F2B3836;
        Thu,  9 Jan 2020 13:56:15 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 13:56:15 +0100
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <jic23@kernel.org>,
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
 <45195b31-70fa-39c9-e109-eeb33d6a2663@ti.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5328b668-2522-5d8d-83bb-f99bfe3086ed@st.com>
Date:   Thu, 9 Jan 2020 13:56:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <45195b31-70fa-39c9-e109-eeb33d6a2663@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/9/20 12:40 PM, Peter Ujfalusi wrote:
> 
> 
> On 09/01/2020 13.29, Fabrice Gasnier wrote:
>> On 1/9/20 11:32 AM, Peter Ujfalusi wrote:
>>>
>>>
>>> On 09/01/2020 11.13, Fabrice Gasnier wrote:
>>>> On 1/7/20 12:45 PM, Peter Ujfalusi wrote:
>>>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>>>>> eating up the error code.
>>>>>
>>>>> By using dma_request_chan() directly the driver can support deferred
>>>>> probing against DMA.
>>>>>
>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>>> ---
>>>>> Hi,
>>>>>
>>>>> Changes since v1:
>>>>> - Fall back to IRQ mode for ADC only in case of ENODEV
>>>>
>>>> Hi Peter,
>>>>
>>>> Thanks for the patch,
>>>>
>>>> Please find a minor comment here after. Apart from that, you can add my:
>>>>
>>>> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>> Peter
>>>>>
>>>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++++++++----
>>>>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> index e493242c266e..74a2211bdff4 100644
>>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> @@ -1383,9 +1383,13 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>>>>>  {
>>>>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>>>>  
>>>>> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>>>>> -	if (!adc->dma_chan)
>>>>> -		return -EINVAL;
>>>>> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
>>>>> +	if (IS_ERR(adc->dma_chan)) {
>>>>> +		int ret = PTR_ERR(adc->dma_chan);
>>>>> +
>>>>> +		adc->dma_chan = NULL;
>>>>> +		return ret;
>>>>
>>>> You may "return PTR_ERR(adc->dma_chan);" directly here.
>>>
>>> I don't make decision here on behalf of the adc path on to go forward w/
>>> or w/o DMA support and if we go ahead the stm32_dfsdm_dma_release()
>>> needs the dma_chan to be NULL in case we don't use DMA.
>>>
>>> It is much cleaner to set dma_chan to NULL here than doing it in other
>>> paths.
>>
>> Hi Peter,
> 
> Hi Fabrice,
> 
>> Sorry I wasn't clear enough. I agree with you. I was suggesting only,
>> talking about the 'ret' variable. It may be removed to spare a few lines
>> :-).
>> 	if (IS_ERR(adc->dma_chan)) {
>> 		adc->dma_chan = NULL;
>> 		return PTR_ERR(adc->dma_chan);
>> 	}
>> I'm okay both ways.
> 
> PTR_ERR(NULL); will return 0
> I need to retrieve the actual error code before NULLing dma_chan.

Oh yes, so please forget this.
Thanks,
Fabrice

> 
>>
>>>
>>>>
>>>> Best Regards,
>>>> Fabrice
>>>>
>>>>> +	}
>>>>>  
>>>>>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>>>>>  					 DFSDM_DMA_BUFFER_SIZE,
>>>>> @@ -1509,7 +1513,16 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>>>>  	init_completion(&adc->completion);
>>>>>  
>>>>>  	/* Optionally request DMA */
>>>>> -	if (stm32_dfsdm_dma_request(indio_dev)) {
>>>>> +	ret = stm32_dfsdm_dma_request(indio_dev);
>>>>> +	if (ret) {
>>>>> +		if (ret != -ENODEV) {
>>>>> +			if (ret != -EPROBE_DEFER)
>>>>> +				dev_err(&indio_dev->dev,
>>>>> +					"DMA channel request failed with %d\n",
>>>>> +					ret);
>>>>> +			return ret;
>>>>> +		}
>>>>> +
>>>>>  		dev_dbg(&indio_dev->dev, "No DMA support\n");
>>>>>  		return 0;
>>>>>  	}
>>>>>
>>>
>>> - Péter
>>>
>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
