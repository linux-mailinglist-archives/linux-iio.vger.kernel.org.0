Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1A3002F4
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAVM3r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbhAVMTs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 07:19:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE292C061786
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 04:19:07 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l2vP2-00087l-Ob; Fri, 22 Jan 2021 13:19:00 +0100
Subject: Re: [Linux-stm32] [PATCH] iio: adc: stm32-adc: fix erroneous handling
 of spurious IRQs
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Holger Assmann <has@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <20210112152441.20665-1-a.fatoum@pengutronix.de>
 <20210116175333.4d8684c5@archlinux>
 <47b0905a-4496-2f21-3b17-91988aa88e91@pengutronix.de>
 <7668b126-d77c-7339-029f-50333d03fbd9@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <e542035e-d5fe-0680-4780-4554ed165e0e@pengutronix.de>
Date:   Fri, 22 Jan 2021 13:18:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <7668b126-d77c-7339-029f-50333d03fbd9@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Fabrice,

On 19.01.21 18:56, Fabrice Gasnier wrote:
> On 1/18/21 12:42 PM, Ahmad Fatoum wrote:
>> Hello Jonathan,
>>
>> On 16.01.21 18:53, Jonathan Cameron wrote:
>>> On Tue, 12 Jan 2021 16:24:42 +0100
>>> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>
>>>> 1c6c69525b40 ("genirq: Reject bogus threaded irq requests") makes sure
>>>> that threaded IRQs either
>>>>   - have IRQF_ONESHOT set
>>>>   - don't have the default just return IRQ_WAKE_THREAD primary handler
>>>>
>>>> This is necessary because level-triggered interrupts need to be masked,
>>>> either at device or irqchip, to avoid an interrupt storm.
>>>>
>>>> For spurious interrupts, the STM32 ADC driver still does this bogus
>>>> request though:
>>>>   - It doesn't set IRQF_ONESHOT
>>>>   - Its primary handler just returns IRQ_WAKE_THREAD if the interrupt
>>>>     is unexpected, i.e. !(status & enabled_mask)
>>> This seems 'unusual'.  If this is a spurious interrupt we should be
>>> returning IRQ_NONE and letting the spurious interrupt protection
>>> stuff kick in.
>>>
>>> The only reason I can see that it does this is print an error message.
>>> I'm not sure why we need to go into the thread to do that given
>>> it's not supposed to happen. If we need that message at all, I'd
>>> suggest doing it in the interrupt handler then return IRQ_NONE;
>> As described, I run into the spurious IRQ case, so I think the message is
>> still useful (until that's properly fixed), but yes, it should've returned
>> IRQ_NONE in that case.
>>
>> With these changes, IRQF_ONESHOT shouldn't be necessary, but in practice
>> the driver doesn't function correctly with the primary IRQ handler threaded.
>>
>> Olivier, Fabrice: Are you aware of this problem?
> 
> 
> Hi Ahmad, Jonathan,
> 
> I wasn't aware of this up to now. I confirm we've the same behavior at
> our end with threadirqs=1.
> 
> Olivier and I started to look at this. Indeed, the IRQF_ONESHOT makes
> the issue to disappear.
> I'm not sure 100% that's for the above reasons. Please let me share some
> piece of logs, analysis and thoughts.

Thanks for looking at this.

> I may miss it but, the patch "genirq: Reject bogus threaded irq
> requests" seems to handle the case where no HW handler is provided, but
> only the threaded part?

There is still a primary handler, but that one does only do IRQ_WAKE_THREAD,
so I assumed that would be equivalent to what the driver is doing in the
spurious IRQ case.

> In the stm32-adc both are provided. Also the IRQ domain in
> stm32-adc-core maybe a key here ?

Oh, missed completely that the stm32-adc-core does the interrupt routing.

> We did some testing, ftrace and observed following behavior for one
> capture (a single cat in_voltage..._raw) :
> 
> in stm32-adc-core, as IRQ source is still active until the IRQ thread
> can execute:
> - stm32_adc_irq_handler <-- generic_handle_irq
> - stm32_adc_irq_handler <-- generic_handle_irq
> - stm32_adc_irq_handler <-- generic_handle_irq
> ...
> 
> - sched_switch to the 1st IRQ thread
> - stm32_adc_irq_handler <-- generic_handle_irq (again until DR get read)
> 
> - stm32_adc_isr <-- irq_forced_thread_fn (from stm32-adc)
>   DR read, clears the active flag
> - stm32_adc_isr <-- irq_forced_thread_fn
>   wakes the 2nd IRQ thread to print an error (unexpected...)
> 
> sched_switch to the 2nd IRQ thread that prints the message.
> 
> - stm32_adc_threaded_isr <-- irq_thread_fn
> 
> 
> So my understanding is: the cause seems to be the concurrency between
> 
> - stm32_adc_irq_handler() storm calls in stm32-adc-core
> - stm32_adc_isr() call to clear the cause (forced into a thread with
> threadirqs=1).

I can't follow here. Where does stm32_adc_isr() clear the IRQ cause?
I assumed it can't be isr_ovr.mask, because that's checked in the
primary handler.

> To properly work, the stm32_adc_irq_handler() should be masked in between.
> 
> As you explain, this works in this case: the call to stm32_adc_isr (in
> stm32-adc) isn't longer forced threaded with IRQF_ONESHOT.
> 
> It looks like IRQF_NO_THREAD for forced threading would have similar
> effect? Maybe the same would be applicable here ? (I haven't tested...)

I guess IRQF_NO_THREAD is meant for use with request_irq and
IRQF_ONESHOT for request_threaded_irq?
 
> Hopefully this helps and is similar to what you observed.

Cheers,
Ahmad

> 
> Thanks and best regards,
> Fabrice
> 
>>
>> Cheers,
>> Ahmad
>>
>>>>   - stm32mp151.dtsi describes the ADC interrupt as level-triggered
>>>>
>>>> Fix this by setting IRQF_ONESHOT to have the irqchip mask the IRQ
>>>> until the IRQ thread has finished.
>>>>
>>>> IRQF_ONESHOT also has the effect that the primary handler is no longer
>>>> forced into a thread. This makes the issue with spurious interrupts
>>>> interrupts disappear when reading the ADC on a threadirqs=1 kernel.
>>>> This used to result in following kernel error message:
>>>>
>>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000000, ISR=0x0000100e
>>>> or
>>>> 	iio iio:device1: Unexpected IRQ: IER=0x00000004, ISR=0x0000100a
>>>>
>>>> But with this patch applied (or threaded IRQs disabled), this no longer
>>>> occurs.
>>>>
>>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>>> Reported-by: Holger Assmann <has@pengutronix.de>
>>>> Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
>>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>> ---
>>>>  drivers/iio/adc/stm32-adc.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>>>> index c067c994dae2..7e0e21c79ac8 100644
>>>> --- a/drivers/iio/adc/stm32-adc.c
>>>> +++ b/drivers/iio/adc/stm32-adc.c
>>>> @@ -1910,7 +1910,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>>>  
>>>>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>>>>  					stm32_adc_threaded_isr,
>>>> -					0, pdev->name, indio_dev);
>>>> +					IRQF_ONESHOT, pdev->name, indio_dev);
>>>>  	if (ret) {
>>>>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>>>>  		return ret;
>>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
