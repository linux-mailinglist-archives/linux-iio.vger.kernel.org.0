Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E136930359D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 06:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbhAZFr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbhAYMVm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 07:21:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE00C061A30
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 03:57:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l40Uq-0006VJ-Rx; Mon, 25 Jan 2021 12:57:28 +0100
Subject: Re: [PATCH v3] iio: adc: stm32-adc: enable timestamping for non-DMA
 usage
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        kernel@pengutronix.de, Holger Assmann <has@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20210125112127.1583-1-a.fatoum@pengutronix.de>
 <b649a0fd-b229-8a54-b374-72ecedca9e64@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <b6413a27-9cdf-9f60-be49-03398ee3f1f6@pengutronix.de>
Date:   Mon, 25 Jan 2021 12:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b649a0fd-b229-8a54-b374-72ecedca9e64@pengutronix.de>
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



On 25.01.21 12:49, Marc Kleine-Budde wrote:
> On 1/25/21 12:21 PM, Ahmad Fatoum wrote:
>> For non-DMA usage, we have an easy way to associate a timestamp with a
>> sample: iio_pollfunc_store_time stores a timestamp in the primary
>> trigger IRQ handler and stm32_adc_trigger_handler runs in the IRQ thread
>> to push out the buffer along with the timestamp.
>>
>> For this to work, the driver needs to register an IIO_TIMESTAMP channel.
>> Do this.
>>
>> For DMA, it's not as easy, because we don't push the buffers out of
>> stm32_adc_trigger, but out of stm32_adc_dma_buffer_done, which runs in
>> a tasklet scheduled after a DMA completion.
>>
>> Preferably, the DMA controller would copy us the timestamp into that buffer
>> as well. Until this is implemented, restrict timestamping support to
>> only PIO. For low-frequency sampling, PIO is probably good enough.
>>
>> Cc: Holger Assmann <has@pengutronix.de>
>> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>> v2 -> v3:
>>   - explicitly specify alignment (Jonathan)
>>   - increase buffer size to hold additional timestamp
>> v1 -> v2:
>>   - Added comment about timestamping being PIO only (Fabrice)
>>   - Added missing DMA resource clean up in error path (Fabrice)
>>   - Added Fabrice's Acked-by
>> ---
>>  drivers/iio/adc/stm32-adc.c | 39 +++++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index c067c994dae2..ab2f440d7afb 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -177,7 +177,7 @@ struct stm32_adc_cfg {
>>   * @offset:		ADC instance register offset in ADC block
>>   * @cfg:		compatible configuration data
>>   * @completion:		end of single conversion completion
>> - * @buffer:		data buffer
>> + * @buffer:		data buffer + 8 bytes for timestamp if enabled
>                                       ^
>>   * @clk:		clock for this adc instance
>>   * @irq:		interrupt for this adc instance
>>   * @lock:		spinlock
>> @@ -200,7 +200,7 @@ struct stm32_adc {
>>  	u32			offset;
>>  	const struct stm32_adc_cfg	*cfg;
>>  	struct completion	completion;
>> -	u16			buffer[STM32_ADC_MAX_SQ];
>> +	u16			buffer[STM32_ADC_MAX_SQ + 8] __aligned(8);
>          ^^                                               ^
> 
> How does that fit together?

Ah indeed, that's a little longer than needed.
Thanks for catching.

> 
> Marc
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
