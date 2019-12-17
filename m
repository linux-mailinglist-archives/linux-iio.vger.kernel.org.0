Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710941228D9
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLQKcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 05:32:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48144 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLQKcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 05:32:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAWWme076204;
        Tue, 17 Dec 2019 04:32:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576578752;
        bh=5z22DOMxe9ERTYZQN4IPLEVBrsRz70Mah/Vov2vIbjk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Qie8fWb/48AlIMLVc4ts4LqusyY3F1qPGN4b+o4Xz+bvUjmFuqFw87c+FzZvh9Wm2
         DzvpAJhd9MKV/aRrzCMtXmmv6cF2iXKwF53uu8+poYhTX6tpcaMcU6Jbk3D8+Lqwnw
         lk8QhnMz1yOvOLvhm2CrO6PBPB1F4tuJdnzJPqRw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAWV93068770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:32:31 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:32:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:32:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAWSwp012173;
        Tue, 17 Dec 2019 04:32:29 -0600
Subject: Re: [PATCH] iio: adc: at91: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     <Eugen.Hristev@microchip.com>, <jic23@kernel.org>
CC:     <vkoul@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191217075043.23539-1-peter.ujfalusi@ti.com>
 <102e71da-8b9c-8528-3bec-b4a22895fb44@microchip.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d4885bc6-4e3b-42ee-1cf6-c782fa70d3cb@ti.com>
Date:   Tue, 17 Dec 2019 12:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <102e71da-8b9c-8528-3bec-b4a22895fb44@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Eugen,

On 17/12/2019 9.59, Eugen.Hristev@microchip.com wrote:
> 
> 
> On 17.12.2019 09:50, Peter Ujfalusi wrote:
> 
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>   drivers/iio/adc/at91-sama5d2_adc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Hi Peter,
> 
> Thank you for the patch.
> Nitpick : at91 is another driver (old one for different platforms), so 
> can you please change the commit oneline to iio: adc: at91-sama5d2_adc: 
> to not be confused about which driver is affected.

Sorry, just sent v2 with the correct subject prefix.
By mistake I looked at the git log of at91_adc.c and picked the wrong
prefix.

> 
> Thanks !
> Eugen
> 
>>
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index e1850f3d5cf3..a5c7771227d5 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -1444,10 +1444,10 @@ static void at91_adc_dma_init(struct platform_device *pdev)
>>          if (st->dma_st.dma_chan)
>>                  return;
>>
>> -       st->dma_st.dma_chan = dma_request_slave_channel(&pdev->dev, "rx");
>> -
>> -       if (!st->dma_st.dma_chan)  {
>> +       st->dma_st.dma_chan = dma_request_chan(&pdev->dev, "rx");
>> +       if (IS_ERR(st->dma_st.dma_chan))  {
>>                  dev_info(&pdev->dev, "can't get DMA channel\n");
>> +               st->dma_st.dma_chan = NULL;
>>                  goto dma_exit;
>>          }
>>
>> --
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
