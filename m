Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7769A564
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 06:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjBQF42 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 00:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQF41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 00:56:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A8AE
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 21:56:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so5829ljq.10
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 21:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlP5p8fHpwKYBipI5+tkTEH45tKbGnNGJwA3ezZ1NO8=;
        b=nL6l+HyR2OydzvgVg2LWaTzXcUhxMoxqEJm+brOHHc6nEHof21SEW5/qh3NTPuPqks
         w03XeC8EFBujghlZtZw0MzDAuMwaCtb4LeGB/JhH3LxjxreLVyZNfYDga+2BjrHUpZb2
         be5dAHSAJzhfPOT3wB4RGeFDhldEo/nsUwPxeJOx3z570fL4pHhiOn/Y8mT85QLLQCCb
         o1jVRfgrdokPiU/7dpX+dBoBHP3Fj4B7c+FlnWcO96/s7BBRrhdMQgzBeuzwD0d8HAni
         FUy0bEsbBWLQBeYYNeEpY7XvgSgOnAJa09md5Q2vz4t4OhDTBVgzbUIRdCKUchlRZ9NO
         YUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlP5p8fHpwKYBipI5+tkTEH45tKbGnNGJwA3ezZ1NO8=;
        b=UZ4GQfKbIXjgH1BZjLPYhLj+quahLiag7GSa+SuNgI35EJjdfbz6UjDL3LRHfaW5Ae
         Iqtp2UdtmZ9JJGPry3nQAPYoUftzS5J+ua1KAfuO+5ljM+Ajy63Jkx7ZMibSIWR1zv2Y
         2IxVLi4X/Z+KHm9osN87cebMRAKcRWTONKEdcmzz9h1caipV/F3fqKR88c6PvC5s7wb6
         e9LpqVsmSv5d/b8aw0au/i9MeIp6FeI2mGcJAeNj8LhGjx6pReGI8oTSThhv0gyRyHXw
         mpSmBkJK/jAWAYqJ2IdevCca1BRJN/Tiz5QRtLBeTCD4+Z0mM5VF5so6zXnWQV4uhilT
         p+qQ==
X-Gm-Message-State: AO0yUKWJhlSoum/gm23WVbQmtQ4wIrEJJQDfsEUQcWJg9m6fjqfHnHGV
        eeXECIurPHcih5aaHf/cKN0=
X-Google-Smtp-Source: AK7set96+EX5PTadb+eWrlB3pwRAoXTptRm0AV1nOwJ9AT76B9ifpP/C29EIBlhK8O3K5SKUS1p3BQ==
X-Received: by 2002:a2e:9cd0:0:b0:28f:ae45:2021 with SMTP id g16-20020a2e9cd0000000b0028fae452021mr3224644ljj.42.1676613384321;
        Thu, 16 Feb 2023 21:56:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w12-20020a19c50c000000b004db297957e8sm567045lfe.305.2023.02.16.21.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 21:56:23 -0800 (PST)
Message-ID: <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
Date:   Fri, 17 Feb 2023 07:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-iio@vger.kernel.org
References: <Y+6QoBLh1k82cJVN@carbian>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
In-Reply-To: <Y+6QoBLh1k82cJVN@carbian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Mehdi,

On 2/16/23 22:22, Mehdi Djait wrote:
> Hi all,
> 
> DISCLAIMER: I'm new to kernel development.
> 
> I'm currently working on extending the kionix-kx022a driver to support
> kionix-kx132.

Thanks for working with this :) Support for the kx132, kx122 etc. is 
very welcome!

> My question is about the timestamp pushed in the trigger
> handler. The kionix-kx022a supports both FIFO and triggered buffer
> mode, for my questions the triggered buffer mode is used.
> 
> Before asking the question: I tried to read every documentation
> available, the kernel code and I found the Threads [1] [2] [3]
> 
> To better explain my question here are the two relevant setup functions:
> A.  devm_iio_triggered_buffer_setup_ext(dev, idev,
>                                          &iio_pollfunc_store_time,
>                                          kx022a_trigger_handler,
>                                          IIO_BUFFER_DIRECTION_IN,
>                                          &kx022a_buffer_ops,
>                                          kx022a_fifo_attributes)
> 
> B. devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
>                               &kx022a_irq_thread_handler,
>                               IRQF_ONESHOT, name, idev);
> 
> 
> And here are the relevant steps after an IRQ occurs :
> 1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
> with "data->timestamp = iio_get_time_ns(idev);" and returns
> IRQ_WAKE_THREAD
> 
> 2. kx022a_irq_thread_handler() -> checks that the trigger is enabled
> --> iio_trigger_poll_chained() --> handle_nested_irq(): which will only
> call the bottom half of the pollfuncs

I don't get the kx022a at my hands until next week to test this, but it 
seems to me your reasoning is right. iio_pollfunc_store_time() is 
probably not called. I just wonder why I didn't see zero timestamps when 
testing this. (OTOH, I had somewhat peculiar IRQ handling at first - 
maybe I broke this along the way).

> 3. kx022a_trigger_handler() --> iio_push_to_buffers_with_timestamp(idev,
> data->buffer, pf->timestamp)
> 
> 
> My questions are:
> Question 1: Is iio_push_to_buffers_with_timestamp(idev, data->buffer,
> data->timestamp) instead of "pf->timestamp" better in the
> trigger_handler ?

I don't see any "technical reasons" why it would be better. I think it 
is more standard looking though - but seems like it is plain wrong here 
as you pointed out.

> I was first concerned that it would be racy with the
> irq_handler, but the IRQF_ONESHOT flag is used, which means that the irq
> line is disabled until the threaded handler has been run, i.e. until
> kx022a_trigger_handler runs and retruns IRQ_HANDLED (right?).

Yes. This is the purpose of IRQF_ONESHOT. (Well, AFAICS the IRQs are 
re-enabled even if some other value is returned unless the IRQ_NONE is 
returned repeatedly).

> Question 2: If the change proposed in question 1 is wrong, would this
> one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
> iio_get_time_ns(idev)). There is some delay between the IRQ occuring
> and trigger_handler being called but that is better than getting all 0
> timestamps like suggested in [2]

Please, use the data->timestamp as you suggested.

> I hope that I'm understating this correctly or at least not totally
> off :) If yes, I will send a patch.

Thanks Mehdi! I think this was a great catch! Maybe - while at it - you 
could also send a patch adding a small kerneldoc to the 
iio_trigger_poll_chained() mentioning this particular issue. Yes, I 
guess it should be obvious just by reading the function name *_chained() 
- but I did fall on this trap (and according to your reference [2] so 
has someone else).

> [1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
> [2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
> [3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

