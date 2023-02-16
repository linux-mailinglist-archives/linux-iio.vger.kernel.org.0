Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224C4699D95
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBPUXE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPUXC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 15:23:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063F4B53E
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 12:23:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v11so4973689edx.12
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2023 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzidyQ3wZuBv1iud8tGZi56YC5GTsOk6wvRWopBnqsg=;
        b=pr2iOsPlhabVqkuailc8QYuZdoNOlCHe8vG+DaXCLrUZXjgkZ9CoCo55dBPN0Lx1J2
         wuwhs7B5ZbX7wQSyRH1MMB1OkwJqCgY9FokwOBXlo8Mz5oThqDOX1kwUZiGMg2/MHmzy
         kt2g3VrRGXpH6glZtClY96CJP5mLBUAL0SfODF/xW9RYs5WzNlaD4ofkVdClcL1k3KGA
         67HYPoeNSSfmthuiJTco4U7iB+G9OggvRVLexXtSXbnrXhhvoiKdez8nfxxEb4hVxUHa
         +L5+WGwWam4NxW7Oh2raldRh6Apb+qkKBZXaIksKORFAk1ZCP/K1hLAyQiRBpDFrg5F7
         OI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzidyQ3wZuBv1iud8tGZi56YC5GTsOk6wvRWopBnqsg=;
        b=S6hkAwWA4V+V8Jq7Uvt3Grygv4B9ni9U6rB7K5FGoShFK66NklwsA3tG6Kv3yizvLS
         2zXEE8YtZC/ASx+m6mB5ZzN3SWiAeAIRa94VOj2nLMxQG/qBMKFLVegzmw0hNOLzdqvQ
         n64DaH/S4ll7FxEWuTypGSlEhbxt6UgCv7wtPY6g1ezbM9t8lX7vJgldVOtcADoCZm/z
         i54YxysmKUt6LGULW7NJ8OoT/F7FyTtBzGCS0mA6YuIPUdNEMAiKPQnjw+RmnLo03A04
         N0FuEpEGIzJWkyrQXzXGz9gLViYDi6HSDmBWk/2+DNDT0zR/84PZbqEjXdk12tVyMKX+
         NQ3A==
X-Gm-Message-State: AO0yUKWGh+LO9CEkQR0I5z58HqLJwJJqb8/6xf7+SPWErv8tng0kWSj8
        Hnec3hwuNkK2YMunpvDDymE=
X-Google-Smtp-Source: AK7set8SPNqDcy7k41SJYRF4yb0H9TVuxadjDEg9PWy1yQpihm7OMMj8/R+fsY/Aem1RQ6AeYQkMrQ==
X-Received: by 2002:aa7:c04d:0:b0:4ac:bdeb:6dce with SMTP id k13-20020aa7c04d000000b004acbdeb6dcemr6115333edo.39.1676578979672;
        Thu, 16 Feb 2023 12:22:59 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::af9d])
        by smtp.gmail.com with ESMTPSA id k20-20020a170906a39400b008b14c5a82e7sm1188215ejz.127.2023.02.16.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:22:59 -0800 (PST)
Date:   Thu, 16 Feb 2023 21:22:56 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     mazziesaccount@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, mehdi.djait.k@gmail.com
Subject: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Message-ID: <Y+6QoBLh1k82cJVN@carbian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

DISCLAIMER: I'm new to kernel development.

I'm currently working on extending the kionix-kx022a driver to support
kionix-kx132. My question is about the timestamp pushed in the trigger
handler. The kionix-kx022a supports both FIFO and triggered buffer
mode, for my questions the triggered buffer mode is used.

Before asking the question: I tried to read every documentation
available, the kernel code and I found the Threads [1] [2] [3]

To better explain my question here are the two relevant setup functions:
A.  devm_iio_triggered_buffer_setup_ext(dev, idev,
                                        &iio_pollfunc_store_time, 
                                        kx022a_trigger_handler,
                                        IIO_BUFFER_DIRECTION_IN,
                                        &kx022a_buffer_ops,
                                        kx022a_fifo_attributes)

B. devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
                             &kx022a_irq_thread_handler,
                             IRQF_ONESHOT, name, idev);


And here are the relevant steps after an IRQ occurs :
1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
with "data->timestamp = iio_get_time_ns(idev);" and returns
IRQ_WAKE_THREAD

2. kx022a_irq_thread_handler() -> checks that the trigger is enabled
--> iio_trigger_poll_chained() --> handle_nested_irq(): which will only
call the bottom half of the pollfuncs

3. kx022a_trigger_handler() --> iio_push_to_buffers_with_timestamp(idev,
data->buffer, pf->timestamp)


My questions are:
Question 1: Is iio_push_to_buffers_with_timestamp(idev, data->buffer,
data->timestamp) instead of "pf->timestamp" better in the 
trigger_handler ? I was first concerned that it would be racy with the 
irq_handler, but the IRQF_ONESHOT flag is used, which means that the irq 
line is disabled until the threaded handler has been run, i.e. until
kx022a_trigger_handler runs and retruns IRQ_HANDLED (right?).

Question 2: If the change proposed in question 1 is wrong, would this
one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
iio_get_time_ns(idev)). There is some delay between the IRQ occuring
and trigger_handler being called but that is better than getting all 0
timestamps like suggested in [2]

I hope that I'm understating this correctly or at least not totally
off :) If yes, I will send a patch.

[1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
[2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
[3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/

--
Kind Regards
Mehdi Djait



