Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC0300142
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 12:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhAVLMM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 06:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbhAVLD1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 06:03:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F64C061788
        for <linux-iio@vger.kernel.org>; Fri, 22 Jan 2021 03:02:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l2uDA-00066G-SP; Fri, 22 Jan 2021 12:02:40 +0100
Subject: Re: [Linux-stm32] [PATCH] iio: adc: stm32-adc: enable timestamping
 for non-DMA usage
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Holger Assmann <has@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20210121180228.30621-1-a.fatoum@pengutronix.de>
 <52a8a7db-72ee-a00f-7ef5-ada85cfe4774@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <b9e39aa7-35a2-598a-770b-3ae336c15cf3@pengutronix.de>
Date:   Fri, 22 Jan 2021 12:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <52a8a7db-72ee-a00f-7ef5-ada85cfe4774@foss.st.com>
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

Hi,

On 22.01.21 11:23, Fabrice Gasnier wrote:
> On 1/21/21 7:02 PM, Ahmad Fatoum wrote:
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
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>  drivers/iio/adc/stm32-adc.c | 31 +++++++++++++++++++++++++------
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index c067c994dae2..91d9483e1f5f 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -1718,7 +1718,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>>  	}
>>  }
>>  
>> -static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>> +static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>>  {
>>  	struct device_node *node = indio_dev->dev.of_node;
>>  	struct stm32_adc *adc = iio_priv(indio_dev);
>> @@ -1766,6 +1766,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (timestamping)
>> +		num_channels++;
>> +
>>  	channels = devm_kcalloc(&indio_dev->dev, num_channels,
>>  				sizeof(struct iio_chan_spec), GFP_KERNEL);
>>  	if (!channels)
>> @@ -1816,6 +1819,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>>  		stm32_adc_smpr_init(adc, channels[i].channel, smp);
>>  	}
>>  
>> +	if (timestamping) {
>> +		struct iio_chan_spec *timestamp = &channels[scan_index];
>> +
>> +		timestamp->type = IIO_TIMESTAMP;
>> +		timestamp->channel = -1;
>> +		timestamp->scan_index = scan_index;
>> +		timestamp->scan_type.sign = 's';
>> +		timestamp->scan_type.realbits = 64;
>> +		timestamp->scan_type.storagebits = 64;
>> +
>> +		scan_index++;
>> +	}
>> +
>>  	indio_dev->num_channels = scan_index;
>>  	indio_dev->channels = channels;
>>  
>> @@ -1875,6 +1891,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>  	struct device *dev = &pdev->dev;
>>  	irqreturn_t (*handler)(int irq, void *p) = NULL;
>>  	struct stm32_adc *adc;
>> +	bool timestamping = false;
>>  	int ret;
>>  
>>  	if (!pdev->dev.of_node)
>> @@ -1931,16 +1948,18 @@ static int stm32_adc_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	ret = stm32_adc_chan_of_init(indio_dev);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>  	ret = stm32_adc_dma_request(dev, indio_dev);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	if (!adc->dma_chan)
>> +	if (!adc->dma_chan) {
>>  		handler = &stm32_adc_trigger_handler;
> 
> Hi Ahmad,
> 
> Just suggesting: maybe add a quick comment to indicate that timestamping
> is supported in PIO mode (only), as DMA doesn't fill it into the buffer
> (well described in the commit message).

Will do.

> 
>> +		timestamping = true;
>> +	}
>> +
>> +	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
>> +	if (ret < 0)
>> +		return ret;
> 
> 
> DMA resources need to be freed, instead of returning directly here, in
> case of error:
> 
>      goto err_dma_disable;

Ouch, thanks for spotting. Will respin.

> 
> With that fixed, you can add my :
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Ahmad

> 
> Thanks,
> 
> Fabrice
> 
> 
>>  
>>  	ret = iio_triggered_buffer_setup(indio_dev,
>>  					 &iio_pollfunc_store_time, handler,
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
