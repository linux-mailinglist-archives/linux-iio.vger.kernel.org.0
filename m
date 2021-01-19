Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A775A2FBE67
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jan 2021 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388288AbhASR65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jan 2021 12:58:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55840 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391650AbhASR6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jan 2021 12:58:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JHm10P016045;
        Tue, 19 Jan 2021 18:56:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5WYFGtdY+KCjXDAhcbztWKsr83wJ4tyifcNDQMaEHjk=;
 b=jpOQy+1g4mLwJN4aLOIXIg0FOR0UTggpirNgSbWbLGg+F0kMNkqb90wQIOQpn/uWdaxJ
 k0PtDvfzly8rLeknLJIdcKbDQT9hp8HXdp2SRoN38lOtfelmTRmloqtbQLAiPLI7S0+H
 XyrBoZ7f2QPbw2whmOYxp6X4DWEUTJHkuvi/0IvZ6uHvkLYLxa/guPQbSlbBhRXuDLQp
 CLarBPgMFsm3FfEzAEtbq8TkeoxiP4sDjnc3zWC7VbA7P2YTdJT+LEDgSJcpIvO14GQY
 wmTTuA4+8f0AHq7A+UruFbn7dE0ZCTxBxPCmPyk8pRGqnwoqFLUjEGVwo4UviU/Zz3vQ Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 363qwnj2eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jan 2021 18:56:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E83CF10002A;
        Tue, 19 Jan 2021 18:56:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D059D25D01B;
        Tue, 19 Jan 2021 18:56:57 +0100 (CET)
Received: from [10.211.11.124] (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 18:56:56 +0100
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
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <7668b126-d77c-7339-029f-50333d03fbd9@foss.st.com>
Date:   Tue, 19 Jan 2021 18:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <47b0905a-4496-2f21-3b17-91988aa88e91@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_07:2021-01-18,2021-01-19 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/18/21 12:42 PM, Ahmad Fatoum wrote:
> Hello Jonathan,
>
> On 16.01.21 18:53, Jonathan Cameron wrote:
>> On Tue, 12 Jan 2021 16:24:42 +0100
>> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>>> 1c6c69525b40 ("genirq: Reject bogus threaded irq requests") makes sure
>>> that threaded IRQs either
>>>   - have IRQF_ONESHOT set
>>>   - don't have the default just return IRQ_WAKE_THREAD primary handler
>>>
>>> This is necessary because level-triggered interrupts need to be masked,
>>> either at device or irqchip, to avoid an interrupt storm.
>>>
>>> For spurious interrupts, the STM32 ADC driver still does this bogus
>>> request though:
>>>   - It doesn't set IRQF_ONESHOT
>>>   - Its primary handler just returns IRQ_WAKE_THREAD if the interrupt
>>>     is unexpected, i.e. !(status & enabled_mask)
>> This seems 'unusual'.  If this is a spurious interrupt we should be
>> returning IRQ_NONE and letting the spurious interrupt protection
>> stuff kick in.
>>
>> The only reason I can see that it does this is print an error message.
>> I'm not sure why we need to go into the thread to do that given
>> it's not supposed to happen. If we need that message at all, I'd
>> suggest doing it in the interrupt handler then return IRQ_NONE;
> As described, I run into the spurious IRQ case, so I think the message is
> still useful (until that's properly fixed), but yes, it should've returned
> IRQ_NONE in that case.
>
> With these changes, IRQF_ONESHOT shouldn't be necessary, but in practice
> the driver doesn't function correctly with the primary IRQ handler threaded.
>
> Olivier, Fabrice: Are you aware of this problem?


Hi Ahmad, Jonathan,

I wasn't aware of this up to now. I confirm we've the same behavior at
our end with threadirqs=1.

Olivier and I started to look at this. Indeed, the IRQF_ONESHOT makes
the issue to disappear.
I'm not sure 100% that's for the above reasons. Please let me share some
piece of logs, analysis and thoughts.


I may miss it but, the patch "genirq: Reject bogus threaded irq
requests" seems to handle the case where no HW handler is provided, but
only the threaded part?

In the stm32-adc both are provided. Also the IRQ domain in
stm32-adc-core maybe a key here ?


We did some testing, ftrace and observed following behavior for one
capture (a single cat in_voltage..._raw) :

in stm32-adc-core, as IRQ source is still active until the IRQ thread
can execute:
- stm32_adc_irq_handler <-- generic_handle_irq
- stm32_adc_irq_handler <-- generic_handle_irq
- stm32_adc_irq_handler <-- generic_handle_irq
...

- sched_switch to the 1st IRQ thread
- stm32_adc_irq_handler <-- generic_handle_irq (again until DR get read)

- stm32_adc_isr <-- irq_forced_thread_fn (from stm32-adc)
  DR read, clears the active flag
- stm32_adc_isr <-- irq_forced_thread_fn
  wakes the 2nd IRQ thread to print an error (unexpected...)

sched_switch to the 2nd IRQ thread that prints the message.

- stm32_adc_threaded_isr <-- irq_thread_fn


So my understanding is: the cause seems to be the concurrency between

- stm32_adc_irq_handler() storm calls in stm32-adc-core
- stm32_adc_isr() call to clear the cause (forced into a thread with
threadirqs=1).

To properly work, the stm32_adc_irq_handler() should be masked in between.

As you explain, this works in this case: the call to stm32_adc_isr (in
stm32-adc) isn't longer forced threaded with IRQF_ONESHOT.

It looks like IRQF_NO_THREAD for forced threading would have similar
effect? Maybe the same would be applicable here ? (I haven't tested...)


Hopefully this helps and is similar to what you observed.

Thanks and best regards,
Fabrice

>
> Cheers,
> Ahmad
>
>>>   - stm32mp151.dtsi describes the ADC interrupt as level-triggered
>>>
>>> Fix this by setting IRQF_ONESHOT to have the irqchip mask the IRQ
>>> until the IRQ thread has finished.
>>>
>>> IRQF_ONESHOT also has the effect that the primary handler is no longer
>>> forced into a thread. This makes the issue with spurious interrupts
>>> interrupts disappear when reading the ADC on a threadirqs=1 kernel.
>>> This used to result in following kernel error message:
>>>
>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000000, ISR=0x0000100e
>>> or
>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000004, ISR=0x0000100a
>>>
>>> But with this patch applied (or threaded IRQs disabled), this no longer
>>> occurs.
>>>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Reported-by: Holger Assmann <has@pengutronix.de>
>>> Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> ---
>>>  drivers/iio/adc/stm32-adc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>>> index c067c994dae2..7e0e21c79ac8 100644
>>> --- a/drivers/iio/adc/stm32-adc.c
>>> +++ b/drivers/iio/adc/stm32-adc.c
>>> @@ -1910,7 +1910,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>>  
>>>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>>>  					stm32_adc_threaded_isr,
>>> -					0, pdev->name, indio_dev);
>>> +					IRQF_ONESHOT, pdev->name, indio_dev);
>>>  	if (ret) {
>>>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>>>  		return ret;
>>
