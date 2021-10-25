Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12C7439086
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJYHpr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 03:45:47 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45476 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231752AbhJYHpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 03:45:46 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P6qN3j012716;
        Mon, 25 Oct 2021 09:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=T1Sv32CW3Suro8RMDqgJ1ZgSp2ac/CNesqXOA22ghSk=;
 b=eaeN8eNN5YkeT7wvNtEghCXL3/f9ZcrP9AbIlXmSDBbVl6L61Z/SZ18gubwOC2CfeHVB
 x/7LYH0oI4z7EBeY2hgM4j6LVJGOdCAaOysyTFMTqJwlLqE/uMoz7dl9KjmUa9m3cFoP
 heWwnKH9DohZYSg/THgyKdd56JkmqBQ1io7qnOSmGATsxVRJ05ZMq0qvNpMwEPP6sdqL
 R2DWeOFI6eoWiv5qL81+Ip5V5j05WOXtcwu0OIhGPX6qkgxN2X058VS+xyjSLr/B9S4M
 amRb7OFVtNv6MnJkcybmTpUwfKMJ89SquctMwftC8FFphh/bHzs6sEJ28Nuerid2jhgP yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwqpsg9mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 09:43:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99E2510002A;
        Mon, 25 Oct 2021 09:43:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 917C5215139;
        Mon, 25 Oct 2021 09:43:12 +0200 (CEST)
Received: from [10.211.0.75] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct
 2021 09:43:11 +0200
Subject: Re: [PATCH] iio: adc: stm32: fix a leak by resetting pcsel before
 disabling vdda
To:     Jonathan Cameron <jic23@kernel.org>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
 <77f3593a-0e94-f5ab-f102-86ba8d0f1a3b@foss.st.com>
 <20211024170749.44c0d81f@jic23-huawei>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <76ac386a-a748-f044-13c5-46b164738338@foss.st.com>
Date:   Mon, 25 Oct 2021 09:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211024170749.44c0d81f@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_02,2021-10-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/24/21 6:07 PM, Jonathan Cameron wrote:
> On Fri, 22 Oct 2021 14:38:52 +0200
> Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:
> 
> I'll probably reword the description here as 'leak' tends to mean memory
> leak rather than current.

Hi Jonathan,

Yes, please fell free to improve this. I had the same concern, but I
haven't found a more suitable description.

> 
>> Hi Fabrice,
>>
>> On 10/22/21 2:19 PM, Fabrice Gasnier wrote:
>>> Some I/Os are connected to ADC input channels, when the corresponding bit
>>> in PCSEL register are set on STM32H7 and STM32MP15. This is done in the
>>> prepare routine of stm32-adc driver.
>>> There are constraints here, as PCSEL shouldn't be set when VDDA supply
>>> is disabled. Enabling/disabling of VDDA supply in done via stm32-adc-core
>>> runtime PM routines (before/after ADC is enabled/disabled).
>>>
>>> Currently, PCSEL remains set when disabling ADC. Later on, PM runtime
>>> can disable the VDDA supply. This creates some conditions on I/Os that
>>> can start to leak current.
>>> So PCSEL needs to be cleared when disabling the ADC.
>>>
>>> Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")
>>>
> 
> No line break here as Fixes forms part of the tag block.
> 

Sorry, will check this next time.

>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Given timing wrt to being too near merge window, I'll let this it on
> list a while longer as it'll be post rc1 material now anyway.
> 
> I can fix the above whilst applying if nothing else comes up.

That's fine for me.

Many thanks,
Fabrice
> 
> Jonathan
> 
>>> ---
>>>   drivers/iio/adc/stm32-adc.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>>> index 5088de8..e3e7541 100644
>>> --- a/drivers/iio/adc/stm32-adc.c
>>> +++ b/drivers/iio/adc/stm32-adc.c
>>> @@ -975,6 +975,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
>>>   {
>>>   	struct stm32_adc *adc = iio_priv(indio_dev);
>>>   
>>> +	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
>>>   	stm32h7_adc_disable(indio_dev);
>>>   	stm32h7_adc_enter_pwr_down(adc);
>>>   }
>>>   
>>
>> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>
>> Thanks
>> Olivier
> 
