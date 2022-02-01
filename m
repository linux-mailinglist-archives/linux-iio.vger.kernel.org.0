Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503104A589D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Feb 2022 09:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiBAIlY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Feb 2022 03:41:24 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231712AbiBAIlY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Feb 2022 03:41:24 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VLKsbY021988;
        Tue, 1 Feb 2022 09:41:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=XEaERfwtCT2DGTRv8UYJNiNlYP21JaC8seiYjTh045k=;
 b=WVMzO1V3n1GUiPOEdUkjtwwZShxr4R8nutuxgHIwlI9Z414CM3Fy90KvKgPagOF13/ON
 X1mWgbK6JjCz6ymw5DNobyMcjsddrmdjKX3s1MntlFnxyb4X6lnWY50xhchxHyBPhz5m
 zPQ8HiUEvDzv3imEaN5cChrotX23l6I7yuR1/isI9cIxYLFeNzN7zqvSOLZscd36YNtP
 FqK6janhreSP9xZKaX2pLHI6GMMSBz7jftTZUSdyaHaYy4L6tkR0UcQvrtH6FoSmZZ4X
 YfWn7LdUdVopN1N8deeLb5OI8cHBa0JgnrR1tPP1a/o5UaH4tFO5+HWToWRxSPpVEVZA xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dxqks9xem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 09:41:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20EA010002A;
        Tue,  1 Feb 2022 09:41:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 111D8210F98;
        Tue,  1 Feb 2022 09:41:06 +0100 (CET)
Received: from [10.211.3.2] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 1 Feb
 2022 09:41:05 +0100
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
 <20211215151344.163036-5-miquel.raynal@bootlin.com>
 <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
 <20211216092235.56e69441@xps13> <20220115160619.746a9246@jic23-huawei>
 <20220128160443.44016830@xps13>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <ff1ddd2b-acbb-3154-5712-87c1d9a7f8b7@foss.st.com>
Date:   Tue, 1 Feb 2022 09:41:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220128160443.44016830@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_03,2022-01-31_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/28/22 4:04 PM, Miquel Raynal wrote:
> Hi Jonathan,
> 
> jic23@kernel.org wrote on Sat, 15 Jan 2022 16:06:19 +0000:
> 
>> On Thu, 16 Dec 2021 09:22:35 +0100
>> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>>> Hi Alexandru,
>>>
>>> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:47:02 +0200:
>>>   
>>>> On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
>>>> <miquel.raynal@bootlin.com> wrote:    
>>>>>
>>>>> This is an internal variable of the core, let's use the
>>>>> iio_buffer_enabled() helper which is exported for the following purpose:
>>>>> telling if the current mode is a buffered mode, which is precisely what
>>>>> this driver looks for.
>>>>>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> ---
>>>>>  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
>>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> index 1cfefb3b5e56..a3b8827d3bbf 100644
>>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>> @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
>>>>>          * In continuous mode, use fast mode configuration,
>>>>>          * if it provides a better resolution.
>>>>>          */
>>>>> -       if (adc->nconv == 1 && !trig &&
>>>>> -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
>>>>> +       if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {      
>>>>
>>>> This may become tricky if other modes get added later.
>>>> STM does a relatively good job in updating and re-using their drivers
>>>> (even if some of them do look quirky sometimes).  
>>
>> Their hardware is crazy/complicated so tends to push the limits!
>>
>>>>
>>>> So, the question here would be: is "iio_buffer_enabled(indio_dev)"
>>>> going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
>>>> INDIO_BUFFER_HARDWARE get added?    
>>>
>>> I would argue, is this a real problem? Today iio_buffer_enabled() seem
>>> to handle well what this driver is expecting. If tomorrow someone adds
>>> another mode, that is his/her responsibility to state "okay, this
>>> section is not common to all buffer styles *anymore*, so we need to do
>>> a more fine grained check against ->currentmodes than
>>> iio_buffer_enabled() does". In that case using the ->currentmodes
>>> getter would be the right way to go, but only at that particular
>>> moment, not today.  
>>
>> It should be isolated to this driver, so I think it is fine to use
>> the broader check today, but I'll leave this to the st folks as
>> it's their driver and I don't feel that strongly about it.

Hi Miquel, Alexandru, Jonathan, all,

First, sorry for the delay.

Indeed, I don't expect any functional changes here by using
iio_buffer_enabled(indio_dev).
So it should be fine to use it. You're right, the driver looks for
buffer mode in both places where this gets used.

Just an additional statement is: the driver also checks for no trigger,
and single channel in both places (to select desired mode in the dfsdm).
As I see, only INDIO_BUFFER_SOFTWARE is expected then.

For my own understanding (I'm just asking), why not using the
currentmodes getter routine ?

I've had a look at the whole series [1], It seems used elsewhere. I may
miss something... It would be 100% equivalent to current code to use:
iio_get_internal_mode(indio_dev) & INDIO_BUFFER_SOFTWARE ?

This would be safe in case new modes gets introduced later ?
(another note: unless these new modes gets set by default in the 'modes'
field, this should have no impact here as well anyway ?)

[1]
https://lore.kernel.org/linux-iio/CA+U=DsoMLD1EpK7yDXaQ_HwTQgm_TeZvM_eykE6jWYgg6P3Y7w@mail.gmail.com/T/


>>
>>>   
>>>>
>>>> I'd also ping some STM people for some feedback, acks or testing.  
>>
>> Definitely on this - they are an active bunch who do a great job of looking
>> after these drivers.  I've cc'd Fabrice. Make sure he (and possibly some
>> others are on v2 cc list).
>>
> 
> I'll add Olivier Moysan as well in the next version who has been quite
> active on this driver as well according to git log.

Indeed, please add both Olivier and I next time.

Best Regards,
Thanks,
Fabrice

> 
>>
>>>>     
>>>>>                 if (fl->flo[1].res >= fl->flo[0].res) {
>>>>>                         fl->fast = 1;
>>>>>                         flo = &fl->flo[1];
>>>>> @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
>>>>>                 cr1 = DFSDM_CR1_RCH(chan->channel);
>>>>>
>>>>>                 /* Continuous conversions triggered by SPI clk in buffer mode */
>>>>> -               if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
>>>>> +               if (iio_buffer_enabled(indio_dev))
>>>>>                         cr1 |= DFSDM_CR1_RCONT(1);
>>>>>
>>>>>                 cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
>>>>> --
>>>>> 2.27.0
>>>>>      
>>>
>>>
>>> Thanks,
>>> Miquèl  
>>
> 
> 
> Thanks,
> Miquèl
> 
