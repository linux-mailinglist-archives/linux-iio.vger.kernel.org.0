Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C314430431A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbhAZPy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 10:54:28 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:47090 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391059AbhAZPyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 10:54:04 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10QFjfeu011160;
        Tue, 26 Jan 2021 16:52:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=4Vb5rqnrO2PgksdFNRtF+lNbyFxGVH9rfRXPC86NAn8=;
 b=Co+8QNeEZEoeS7/GHDNWRp6oOHQbZdOxu9qQJ24PjDIsWtKMqld3vU8Jw3fnXfOAcX3i
 HKHvtd16BnzETYwoK7x/Uw+C9EqaRyFDKniNyS+W6kmQ1OMOtf++D4FMDeKAyLnwxUQE
 VBSGOu98TFxNmAEzpO5ZohTzry9fbWhBY+wEeW9uknXp11D2o2ydrqa+MAhFoDCAbs0Z
 sdaCQYOvINOw1nkYknznZDpaebw5poe5sqgo/JeA9l00ZTS/n450vBeBXYk8iizjeLAo
 vkfTmEEQOYaOnYGixGlAGn7afMVUtDamI+k9VfZQ8UCZgpHjSRorSRJH0/neQKKYpY8M 4Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 368c15sqs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 16:52:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5721D10002A;
        Tue, 26 Jan 2021 16:52:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 384FC256B9C;
        Tue, 26 Jan 2021 16:52:40 +0100 (CET)
Received: from [10.211.3.83] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 16:52:38 +0100
Subject: Re: [Linux-stm32] [PATCH] iio: adc: stm32-adc: fix erroneous handling
 of spurious IRQs
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Holger Assmann <has@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <20210112152441.20665-1-a.fatoum@pengutronix.de>
 <20210116175333.4d8684c5@archlinux>
 <47b0905a-4496-2f21-3b17-91988aa88e91@pengutronix.de>
 <7668b126-d77c-7339-029f-50333d03fbd9@foss.st.com>
 <e542035e-d5fe-0680-4780-4554ed165e0e@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <156c5b73-2f66-653f-4512-e271a10ddd5e@foss.st.com>
Date:   Tue, 26 Jan 2021 16:52:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e542035e-d5fe-0680-4780-4554ed165e0e@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_08:2021-01-26,2021-01-26 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 1/22/21 1:18 PM, Ahmad Fatoum wrote:
> Hello Fabrice,
> 
> On 19.01.21 18:56, Fabrice Gasnier wrote:
>> On 1/18/21 12:42 PM, Ahmad Fatoum wrote:
>>> Hello Jonathan,
>>>
>>> On 16.01.21 18:53, Jonathan Cameron wrote:
>>>> On Tue, 12 Jan 2021 16:24:42 +0100
>>>> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>
>>>>> 1c6c69525b40 ("genirq: Reject bogus threaded irq requests") makes sure
>>>>> that threaded IRQs either
>>>>>   - have IRQF_ONESHOT set
>>>>>   - don't have the default just return IRQ_WAKE_THREAD primary handler
>>>>>
>>>>> This is necessary because level-triggered interrupts need to be masked,
>>>>> either at device or irqchip, to avoid an interrupt storm.
>>>>>
>>>>> For spurious interrupts, the STM32 ADC driver still does this bogus
>>>>> request though:
>>>>>   - It doesn't set IRQF_ONESHOT
>>>>>   - Its primary handler just returns IRQ_WAKE_THREAD if the interrupt
>>>>>     is unexpected, i.e. !(status & enabled_mask)
>>>> This seems 'unusual'.  If this is a spurious interrupt we should be
>>>> returning IRQ_NONE and letting the spurious interrupt protection
>>>> stuff kick in.
>>>>
>>>> The only reason I can see that it does this is print an error message.
>>>> I'm not sure why we need to go into the thread to do that given
>>>> it's not supposed to happen. If we need that message at all, I'd
>>>> suggest doing it in the interrupt handler then return IRQ_NONE;
>>> As described, I run into the spurious IRQ case, so I think the message is
>>> still useful (until that's properly fixed), but yes, it should've returned
>>> IRQ_NONE in that case.
>>>
>>> With these changes, IRQF_ONESHOT shouldn't be necessary, but in practice
>>> the driver doesn't function correctly with the primary IRQ handler threaded.
>>>
>>> Olivier, Fabrice: Are you aware of this problem?
>>
>>
>> Hi Ahmad, Jonathan,
>>
>> I wasn't aware of this up to now. I confirm we've the same behavior at
>> our end with threadirqs=1.
>>
>> Olivier and I started to look at this. Indeed, the IRQF_ONESHOT makes
>> the issue to disappear.
>> I'm not sure 100% that's for the above reasons. Please let me share some
>> piece of logs, analysis and thoughts.
> 
> Thanks for looking at this.
> 
>> I may miss it but, the patch "genirq: Reject bogus threaded irq
>> requests" seems to handle the case where no HW handler is provided, but
>> only the threaded part?
> 
> There is still a primary handler, but that one does only do IRQ_WAKE_THREAD,
> so I assumed that would be equivalent to what the driver is doing in the
> spurious IRQ case.
> 
>> In the stm32-adc both are provided. Also the IRQ domain in
>> stm32-adc-core maybe a key here ?
> 
> Oh, missed completely that the stm32-adc-core does the interrupt routing.

Hi Ahmad, Jonathan,

The interrupt routing is done in the core by using "dummy_irq_chip".

Currently (with threadirqs=1), irq_mask and irq_unmask callbacks are
called, but this makes a "noop":
struct irq_chip dummy_irq_chip = {
...
    .irq_mask    = noop,
    .irq_unmask    = noop,
...

That's the reason for the hw irq storm until the primary threaded
handler can run.

I see no easy way to mask the irq from the core driver. e.g. enable bits
are in "child" registers.
The child adc driver already clear/set them at will (in IER: EOC/OVR bits).

Please find other considerations here after

> 
>> We did some testing, ftrace and observed following behavior for one
>> capture (a single cat in_voltage..._raw) :
>>
>> in stm32-adc-core, as IRQ source is still active until the IRQ thread
>> can execute:
>> - stm32_adc_irq_handler <-- generic_handle_irq
>> - stm32_adc_irq_handler <-- generic_handle_irq
>> - stm32_adc_irq_handler <-- generic_handle_irq
>> ...
>>
>> - sched_switch to the 1st IRQ thread
>> - stm32_adc_irq_handler <-- generic_handle_irq (again until DR get read)
>>
>> - stm32_adc_isr <-- irq_forced_thread_fn (from stm32-adc)
>>   DR read, clears the active flag
>> - stm32_adc_isr <-- irq_forced_thread_fn
>>   wakes the 2nd IRQ thread to print an error (unexpected...)
>>
>> sched_switch to the 2nd IRQ thread that prints the message.
>>
>> - stm32_adc_threaded_isr <-- irq_thread_fn
>>
>>
>> So my understanding is: the cause seems to be the concurrency between
>>
>> - stm32_adc_irq_handler() storm calls in stm32-adc-core
>> - stm32_adc_isr() call to clear the cause (forced into a thread with
>> threadirqs=1).
> 
> I can't follow here. Where does stm32_adc_isr() clear the IRQ cause?

The 'eoc' end of conversion flag is cleared by reading data register.

> I assumed it can't be isr_ovr.mask, because that's checked in the
> primary handler.
> 
>> To properly work, the stm32_adc_irq_handler() should be masked in between.
>>
>> As you explain, this works in this case: the call to stm32_adc_isr (in
>> stm32-adc) isn't longer forced threaded with IRQF_ONESHOT.
>>
>> It looks like IRQF_NO_THREAD for forced threading would have similar
>> effect? Maybe the same would be applicable here ? (I haven't tested...)
> 
> I guess IRQF_NO_THREAD is meant for use with request_irq and
> IRQF_ONESHOT for request_threaded_irq?

Thanks for pointing this. So I guess IRQF_ONESHOT can be used here, so
we don't hit the "noop" irq_mask/unmask.

Some other considerations are: some stm32 ADC have a single IRQ line
(stm32f4/stm32h7) but stm32mp1 have one irq line per "child" adc.
So I'd prefer to keep this approach, to prevent using a threaded primary
handler. Also, there's not always a fifo in stm32 adc (so tight timing
to read data in PIO mode).

Ahmad, Jonathan,

Is it reasonable to improve the commit message to summarize the root
cause, explain the rationale, and keep IRQF_ONESHOT (e.g. current patch ?) ?

Best Regards,
Fabrice

>  
>> Hopefully this helps and is similar to what you observed.
> 
> Cheers,
> Ahmad
> 
>>
>> Thanks and best regards,
>> Fabrice
>>
>>>
>>> Cheers,
>>> Ahmad
>>>
>>>>>   - stm32mp151.dtsi describes the ADC interrupt as level-triggered
>>>>>
>>>>> Fix this by setting IRQF_ONESHOT to have the irqchip mask the IRQ
>>>>> until the IRQ thread has finished.
>>>>>
>>>>> IRQF_ONESHOT also has the effect that the primary handler is no longer
>>>>> forced into a thread. This makes the issue with spurious interrupts
>>>>> interrupts disappear when reading the ADC on a threadirqs=1 kernel.
>>>>> This used to result in following kernel error message:
>>>>>
>>>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000000, ISR=0x0000100e
>>>>> or
>>>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000004, ISR=0x0000100a
>>>>>
>>>>> But with this patch applied (or threaded IRQs disabled), this no longer
>>>>> occurs.
>>>>>
>>>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>>>> Reported-by: Holger Assmann <has@pengutronix.de>
>>>>> Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
>>>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>>> ---
>>>>>  drivers/iio/adc/stm32-adc.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>>>>> index c067c994dae2..7e0e21c79ac8 100644
>>>>> --- a/drivers/iio/adc/stm32-adc.c
>>>>> +++ b/drivers/iio/adc/stm32-adc.c
>>>>> @@ -1910,7 +1910,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>>>>>  					stm32_adc_threaded_isr,
>>>>> -					0, pdev->name, indio_dev);
>>>>> +					IRQF_ONESHOT, pdev->name, indio_dev);
>>>>>  	if (ret) {
>>>>>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>>>>>  		return ret;
>>>>
>>
> 
