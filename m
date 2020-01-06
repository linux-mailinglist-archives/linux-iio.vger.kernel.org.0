Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EAD131087
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAFKZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 05:25:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61083 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAFKZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 05:25:30 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006AHKbC028995;
        Mon, 6 Jan 2020 11:25:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=csKu8+UMH7YN+nRTevbWnuk0toNCOh+W9ovVroJG4Gs=;
 b=FC3Br8HlV5BIIQm0VeJ7roajgAUqSoCVTK35cV4/OxzRJ8jBa3EImWslq3jusdv/IP0q
 0wQQW5tUfoEu6NU/kjF63OabrvuDcdz3Ej5qRIO+hfNCC6Eg5G3z1M5mxo3qxmCRsElD
 irbTBS3HtyRpvonV+JnmDisXOWCbdnpQEE2oTk9AUYCvhldCI//iqPh8RfXTgsoWR+oq
 GwBqTXj9ErFNmrVqEehsAu98A7yto+aGeU71hYdgWEWcvr7MYr53viCmf6gbO3d/3J9D
 itdevHZiOMndqK++SW/QI1XKm1loG8SGq0iJyxAf6xLTa1LcieR8JLo5/4mkYVwKcxZy Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakuqfaab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 11:25:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 36A9210002A;
        Mon,  6 Jan 2020 11:25:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 27F172B088F;
        Mon,  6 Jan 2020 11:25:14 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jan
 2020 11:25:12 +0100
Subject: Re: [PATCH] iio: adc: stm32-adc: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <20191217075153.23766-1-peter.ujfalusi@ti.com>
 <20191223154230.7fb2a988@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <9f190583-824c-01a6-7da3-43065fde49c7@st.com>
Date:   Mon, 6 Jan 2020 11:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191223154230.7fb2a988@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_03:2020-01-06,2020-01-06 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/23/19 4:42 PM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2019 09:51:53 +0200
> Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Hi Peter,
> 
> Change looks sensible to me, but I'd like to leave a little longer
> for others to look at this.
> 
> Give me a poke if I seem to have lost it by the end of the first
> week in Jan.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/stm32-adc.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index 3b291d72701c..5dab23f1fdee 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -1746,9 +1746,15 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>>  	struct dma_slave_config config;
>>  	int ret;
>>  
>> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
>> -	if (!adc->dma_chan)
>> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
>> +	if (IS_ERR(adc->dma_chan)) {
>> +		if (PTR_ERR(adc->dma_chan) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;

Hi Peter,

Thanks for the patch and sorry for the late reply.

I'd rather prefer to check explicitly for -ENODEV (as the DMA is
optional) to use the IRQ mode and treat all other codes (including
EPROBE_DEFER) as errors.

Rationale is: This can hide other errors e.g. like all DMA channels are
busy/reserved for other usage. So the user may wrongly think it's
probing the driver, with DMA. This may be a corner case, but still...
DMA channels are assigned via device tree. I'd rather prefer to avoid
depending of runtime (probe ordering) in such a case.

Can you update the patch considering this ?

Please find here an alternate proposal:

	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
	if (IS_ERR(adc->dma_chan)) {
		if (PTR_ERR(adc->dma_chan) != -ENODEV)
			return PTR_ERR(adc->dma_chan);

		/* DMA is optional: fall back to IRQ mode */
		adc->dma_chan = NULL;
		return 0;
	}

Best regards,
Fabrice

>> +
>> +		/* Ignore errors to fall back to IRQ mode */
>> +		adc->dma_chan = NULL;
>>  		return 0;
>> +	}
>>  
>>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>>  					 STM32_DMA_BUFFER_SIZE,
> 
