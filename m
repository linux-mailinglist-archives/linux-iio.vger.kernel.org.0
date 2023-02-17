Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796CF69AAE8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBQL70 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 06:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBQL7Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 06:59:25 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9F66CF3
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 03:59:19 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u22so1454338lfu.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 03:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXGkAREaXgevxi9CrYKAKiP1fHncmM/rpoZVkhn4M4s=;
        b=q6r2mvjyzvAOrrL1XIlXawg7stG771YkJO3Gi61YoUAXBb8TVl1vN5aNxsCzoKR1l/
         Q4o0/j0dW8ARLELQomfBGxRxF80YyFfJmnNv5buI4bbInRisGI52T3I2+T0Uoob2C9S6
         n6PE6aev21QAyLx9imcXE3HciECRnTPyK81CyT06Wde+PARRROZ2lgKJOajv2bY6Yg7G
         S29iNRTHZnNcGWiY+eohPZRHIDfuk3mL25D89oFFY2dVCIZ0oiBo1UmCFxTOS+hjkDQO
         FIWsirorIr6ZJsvgSK/UsxKHCcCzRGLFlulJIu7gjzrwtLyi2nMv3EPDyEUr0UvVvFv8
         Yd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXGkAREaXgevxi9CrYKAKiP1fHncmM/rpoZVkhn4M4s=;
        b=JPD+tJgDuCu1zNeS2ZHOCZelddNRVJhdNfRtHE24w2GmMRMEDtxuoEDfaylCO7HUti
         ien4MjzUJrh5GVZE6cPcDxDVhiOCWM64v4xpkqqB8NYhz2Ye3jc7+kWb+XH5Y8wt66WM
         GsXy+K4klFqTbgzxxugr2CgxSjlM93Unif+sdVRGdIFLFC3cQFVlgPy34lmH2EZGvBDs
         9ge2iLWzdrGK2T/5ipLWyReucct/HlafdFc6H6nbp3HHfgA8zry1dQ2fROwf2w5lwP8U
         09J0Iwmvqc/PsZV7Y4/ycGXffeLIQ67wNVkDwuW/pps7LJP18gs/Nfvxcyn0PaZ1p58e
         jXmw==
X-Gm-Message-State: AO0yUKUQPxm3tU1oWUXFwetelKUGGo+9k+0cgOpumCCtpCWDw8vzzgX5
        YsqqbJTmttBAdaBwjgxuxSg=
X-Google-Smtp-Source: AK7set80J3PwEj9kixe29JoMn1LVDN0m3+oWumJeihyJC9fjBrcErdbNnmC5ImbuvOYnD0Q5XsnrmQ==
X-Received: by 2002:ac2:5545:0:b0:4d5:970e:a98a with SMTP id l5-20020ac25545000000b004d5970ea98amr2383342lfk.28.1676635157956;
        Fri, 17 Feb 2023 03:59:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u15-20020ac251cf000000b004b5789ecdd7sm656197lfm.274.2023.02.17.03.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:59:17 -0800 (PST)
Message-ID: <a4e69c59-d5c5-be8e-da7c-1955cc8b0ad7@gmail.com>
Date:   Fri, 17 Feb 2023 13:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, en-GB
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org
References: <Y+6QoBLh1k82cJVN@carbian>
 <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
 <20230217114308.00004a31@Huawei.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
In-Reply-To: <20230217114308.00004a31@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/17/23 13:43, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 07:56:22 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Mehdi,
>>
>> On 2/16/23 22:22, Mehdi Djait wrote: >>> And here are the relevant steps after an IRQ occurs :
>>> 1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
>>> with "data->timestamp = iio_get_time_ns(idev);" and returns
>>> IRQ_WAKE_THREAD
>>>
>>> 2. kx022a_irq_thread_handler() -> checks that the trigger is enabled
>>> --> iio_trigger_poll_chained() --> handle_nested_irq(): which will only
>>> call the bottom half of the pollfuncs
>>
>> I don't get the kx022a at my hands until next week to test this, but it
>> seems to me your reasoning is right. iio_pollfunc_store_time() is
>> probably not called. I just wonder why I didn't see zero timestamps when
>> testing this. (OTOH, I had somewhat peculiar IRQ handling at first -
>> maybe I broke this along the way).
> 
> This is a common problem.  So far we've always solved it in the driver
> by using the pf->timestamp only if it's been set - otherwise fallback
> to grabbing a new one to pass into iio_push_to_buffer_with_timestamp()
> in the threaded handler.
> 
> It might be possible to solve in a generic fashion but it's a bit
> fiddly so I don't think anyone has ever looked at it.

I agree it's "fiddly" :) I played with a though of conditionally adding 
the timestamp in the iio_trigger_poll_chained() if the timestamp is zero 
there. This, however, would require clearing the timestamp when it is 
read - which gets "fiddly" soon. Hence I just suggested adding a note in 
kerneldoc.

>>
>>> Question 2: If the change proposed in question 1 is wrong, would this
>>> one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
>>> iio_get_time_ns(idev)). There is some delay between the IRQ occuring
>>> and trigger_handler being called but that is better than getting all 0
>>> timestamps like suggested in [2]
>>
>> Please, use the data->timestamp as you suggested.
> 
> I'd suggest a bit of both.  If you have a timestamp from the irq handler
> use it. If it's not available then grab one locally in the threaded handler.

Hm. I don't think we will end up in the kx022a threaded handler so that 
the data->timestamp is not populated in the IRQ handler. I am _far_ from 
an IIO expert - but I guess the only way would be that some other 
trigger invoked the threaded handler(?) Shouldn't the 
kx022a_validate_trigger() prevent this?

Please, follow Jonathan's guidance if he does not tell othervice. You 
clearly should not trust a random guy who obviously does not know how to 
write these drivers in the first place XD

>>
>>> I hope that I'm understating this correctly or at least not totally
>>> off :) If yes, I will send a patch.
>>
>> Thanks Mehdi! I think this was a great catch! Maybe - while at it - you
>> could also send a patch adding a small kerneldoc to the
>> iio_trigger_poll_chained() mentioning this particular issue. Yes, I
>> guess it should be obvious just by reading the function name *_chained()
>> - but I did fall on this trap (and according to your reference [2] so
>> has someone else).
>>
>>> [1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
>>> [2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
>>> [3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/
>>
>> Yours,
>> 	-- Matti
>>
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

