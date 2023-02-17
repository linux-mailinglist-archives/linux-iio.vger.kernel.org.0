Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A297369AA9E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBQLnT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 06:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBQLnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 06:43:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AF5BDBD
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 03:43:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJ8vq36HBz67NMW;
        Fri, 17 Feb 2023 19:38:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 11:43:09 +0000
Date:   Fri, 17 Feb 2023 11:43:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Mehdi Djait <mehdi.djait.k@gmail.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Message-ID: <20230217114308.00004a31@Huawei.com>
In-Reply-To: <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
References: <Y+6QoBLh1k82cJVN@carbian>
        <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Feb 2023 07:56:22 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Mehdi,
> 
> On 2/16/23 22:22, Mehdi Djait wrote:
> > Hi all,
> > 
> > DISCLAIMER: I'm new to kernel development.
> > 
> > I'm currently working on extending the kionix-kx022a driver to support
> > kionix-kx132.  
> 
> Thanks for working with this :) Support for the kx132, kx122 etc. is 
> very welcome!
> 
> > My question is about the timestamp pushed in the trigger
> > handler. The kionix-kx022a supports both FIFO and triggered buffer
> > mode, for my questions the triggered buffer mode is used.
> > 
> > Before asking the question: I tried to read every documentation
> > available, the kernel code and I found the Threads [1] [2] [3]
> > 
> > To better explain my question here are the two relevant setup functions:
> > A.  devm_iio_triggered_buffer_setup_ext(dev, idev,
> >                                          &iio_pollfunc_store_time,
> >                                          kx022a_trigger_handler,
> >                                          IIO_BUFFER_DIRECTION_IN,
> >                                          &kx022a_buffer_ops,
> >                                          kx022a_fifo_attributes)
> > 
> > B. devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
> >                               &kx022a_irq_thread_handler,
> >                               IRQF_ONESHOT, name, idev);
> > 
> > 
> > And here are the relevant steps after an IRQ occurs :
> > 1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
> > with "data->timestamp = iio_get_time_ns(idev);" and returns
> > IRQ_WAKE_THREAD
> > 
> > 2. kx022a_irq_thread_handler() -> checks that the trigger is enabled  
> > --> iio_trigger_poll_chained() --> handle_nested_irq(): which will only  
> > call the bottom half of the pollfuncs  
> 
> I don't get the kx022a at my hands until next week to test this, but it 
> seems to me your reasoning is right. iio_pollfunc_store_time() is 
> probably not called. I just wonder why I didn't see zero timestamps when 
> testing this. (OTOH, I had somewhat peculiar IRQ handling at first - 
> maybe I broke this along the way).

This is a common problem.  So far we've always solved it in the driver
by using the pf->timestamp only if it's been set - otherwise fallback
to grabbing a new one to pass into iio_push_to_buffer_with_timestamp()
in the threaded handler.

It might be possible to solve in a generic fashion but it's a bit
fiddly so I don't think anyone has ever looked at it.

> 
> > 3. kx022a_trigger_handler() --> iio_push_to_buffers_with_timestamp(idev,
> > data->buffer, pf->timestamp)
> > 
> > 
> > My questions are:
> > Question 1: Is iio_push_to_buffers_with_timestamp(idev, data->buffer,
> > data->timestamp) instead of "pf->timestamp" better in the
> > trigger_handler ?  
> 
> I don't see any "technical reasons" why it would be better. I think it 
> is more standard looking though - but seems like it is plain wrong here 
> as you pointed out.

Agreed. That looks like a bug.

> 
> > I was first concerned that it would be racy with the
> > irq_handler, but the IRQF_ONESHOT flag is used, which means that the irq
> > line is disabled until the threaded handler has been run, i.e. until
> > kx022a_trigger_handler runs and retruns IRQ_HANDLED (right?).  
> 
> Yes. This is the purpose of IRQF_ONESHOT. (Well, AFAICS the IRQs are 
> re-enabled even if some other value is returned unless the IRQ_NONE is 
> returned repeatedly).
> 
> > Question 2: If the change proposed in question 1 is wrong, would this
> > one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
> > iio_get_time_ns(idev)). There is some delay between the IRQ occuring
> > and trigger_handler being called but that is better than getting all 0
> > timestamps like suggested in [2]  
> 
> Please, use the data->timestamp as you suggested.

I'd suggest a bit of both.  If you have a timestamp from the irq handler
use it. If it's not available then grab one locally in the threaded handler.

> 
> > I hope that I'm understating this correctly or at least not totally
> > off :) If yes, I will send a patch.  
> 
> Thanks Mehdi! I think this was a great catch! Maybe - while at it - you 
> could also send a patch adding a small kerneldoc to the 
> iio_trigger_poll_chained() mentioning this particular issue. Yes, I 
> guess it should be obvious just by reading the function name *_chained() 
> - but I did fall on this trap (and according to your reference [2] so 
> has someone else).
> 
> > [1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
> > [2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
> > [3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/  
> 
> Yours,
> 	-- Matti
> 

