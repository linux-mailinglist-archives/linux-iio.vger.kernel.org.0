Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D012FA30F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jan 2021 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404913AbhAROb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jan 2021 09:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390813AbhARLnB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jan 2021 06:43:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C645C0613C1
        for <linux-iio@vger.kernel.org>; Mon, 18 Jan 2021 03:42:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l1SvI-0002pS-Fy; Mon, 18 Jan 2021 12:42:16 +0100
Subject: Re: [PATCH] iio: adc: stm32-adc: fix erroneous handling of spurious
 IRQs
To:     Jonathan Cameron <jic23@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Holger Assmann <has@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210112152441.20665-1-a.fatoum@pengutronix.de>
 <20210116175333.4d8684c5@archlinux>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <47b0905a-4496-2f21-3b17-91988aa88e91@pengutronix.de>
Date:   Mon, 18 Jan 2021 12:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210116175333.4d8684c5@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

On 16.01.21 18:53, Jonathan Cameron wrote:
> On Tue, 12 Jan 2021 16:24:42 +0100
> Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> 
>> 1c6c69525b40 ("genirq: Reject bogus threaded irq requests") makes sure
>> that threaded IRQs either
>>   - have IRQF_ONESHOT set
>>   - don't have the default just return IRQ_WAKE_THREAD primary handler
>>
>> This is necessary because level-triggered interrupts need to be masked,
>> either at device or irqchip, to avoid an interrupt storm.
>>
>> For spurious interrupts, the STM32 ADC driver still does this bogus
>> request though:
>>   - It doesn't set IRQF_ONESHOT
>>   - Its primary handler just returns IRQ_WAKE_THREAD if the interrupt
>>     is unexpected, i.e. !(status & enabled_mask)
> 
> This seems 'unusual'.  If this is a spurious interrupt we should be
> returning IRQ_NONE and letting the spurious interrupt protection
> stuff kick in.
> 
> The only reason I can see that it does this is print an error message.
> I'm not sure why we need to go into the thread to do that given
> it's not supposed to happen. If we need that message at all, I'd
> suggest doing it in the interrupt handler then return IRQ_NONE;

As described, I run into the spurious IRQ case, so I think the message is
still useful (until that's properly fixed), but yes, it should've returned
IRQ_NONE in that case.

With these changes, IRQF_ONESHOT shouldn't be necessary, but in practice
the driver doesn't function correctly with the primary IRQ handler threaded.

Olivier, Fabrice: Are you aware of this problem?

Cheers,
Ahmad

> 
>>   - stm32mp151.dtsi describes the ADC interrupt as level-triggered
>>
>> Fix this by setting IRQF_ONESHOT to have the irqchip mask the IRQ
>> until the IRQ thread has finished.
>>
>> IRQF_ONESHOT also has the effect that the primary handler is no longer
>> forced into a thread. This makes the issue with spurious interrupts
>> interrupts disappear when reading the ADC on a threadirqs=1 kernel.
>> This used to result in following kernel error message:
>>
>> 	iio iio:device1: Unexpected IRQ: IER=0x00000000, ISR=0x0000100e
>> or
>> 	iio iio:device1: Unexpected IRQ: IER=0x00000004, ISR=0x0000100a
>>
>> But with this patch applied (or threaded IRQs disabled), this no longer
>> occurs.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Reported-by: Holger Assmann <has@pengutronix.de>
>> Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>  drivers/iio/adc/stm32-adc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index c067c994dae2..7e0e21c79ac8 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -1910,7 +1910,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>  
>>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>>  					stm32_adc_threaded_isr,
>> -					0, pdev->name, indio_dev);
>> +					IRQF_ONESHOT, pdev->name, indio_dev);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>>  		return ret;
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
