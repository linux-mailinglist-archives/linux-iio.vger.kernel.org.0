Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD9129B55
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 23:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWWAx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 17:00:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51934 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWWAx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 17:00:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBNM0jjW087485;
        Mon, 23 Dec 2019 16:00:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577138445;
        bh=w7aPOs42Swzrz+lvTvKsdRSio+cXajK+pj+QxGcZEvk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tt9GcZnae883S9o242HcAwe1PmEivctbuoFAK8dxgrLMPe5P5FjzD/q+CbqYfk5EY
         HBixkahpgVgTIJE5Am7lE0jiAuSEyp5QqnD+S+kCY2FW2AoEXuY/CrR85vm/XwAqFi
         J8tUzE3jXUaWxgDn4KI4r534iXJtBMDT3dE15yUs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNM0jT0098889;
        Mon, 23 Dec 2019 16:00:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 16:00:43 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 16:00:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBNM0fme062348;
        Mon, 23 Dec 2019 16:00:42 -0600
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: Use dma_request_chan()
 instead dma_request_slave_channel()
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191217103100.21737-1-peter.ujfalusi@ti.com>
 <20191223155001.3c4c7261@archlinux>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4b05c6b4-e70a-67ac-8a7e-d5310c6f8ef0@ti.com>
Date:   Tue, 24 Dec 2019 00:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191223155001.3c4c7261@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 12/23/19 5:50 PM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2019 12:31:00 +0200
> Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
> Unfortunately that doesn't seem to be true.
> The function in question returns void...
> 
> And for that matter is called only from the set_watermark callback which
> doesn't run at probe time.
> 
> So if we were to get a deferred response at runtime there isn't a whole
> lot we could do with it.

With dma_request_chan() drivers can support deferred probing ;)
I forgot to remove the section which does not apply to this driver.

The main reason for this change is to retire the old APIs for requesting
DMA channel and keep one, consistently named set.

I'll send v3 in in about two weeks with updated commit message.

> 
> Jonathan
> 
> 
> 
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since v1:
>> - Subject prefix is corrected to "iio: adc: at91-sama5d2_adc:"
>>
>> Regards,
>> Peter
>>
>>  drivers/iio/adc/at91-sama5d2_adc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index e1850f3d5cf3..a5c7771227d5 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -1444,10 +1444,10 @@ static void at91_adc_dma_init(struct platform_device *pdev)
>>  	if (st->dma_st.dma_chan)
>>  		return;
>>  
>> -	st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
>> -
>> -	if (!st->dma_st.dma_chan)  {
>> +	st->dma_st.dma_chan = dma_request_chan(&pdev->dev, "rx");
>> +	if (IS_ERR(st->dma_st.dma_chan))  {
>>  		dev_info(&pdev->dev, "can't get DMA channel\n");
>> +		st->dma_st.dma_chan = NULL;
>>  		goto dma_exit;
>>  	}
>>  
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
