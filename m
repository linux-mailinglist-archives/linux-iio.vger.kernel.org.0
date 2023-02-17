Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2F69AF7A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBQP1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBQP1T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 10:27:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636496EF38
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 07:27:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJFtN1858z67ZcT;
        Fri, 17 Feb 2023 23:22:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 15:27:14 +0000
Date:   Fri, 17 Feb 2023 15:27:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
CC:     <mazziesaccount@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Message-ID: <20230217152713.000007ee@Huawei.com>
In-Reply-To: <Y++Sju++GBxLAoCH@carbian>
References: <Y+6QoBLh1k82cJVN@carbian>
        <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
        <20230217114308.00004a31@Huawei.com>
        <a4e69c59-d5c5-be8e-da7c-1955cc8b0ad7@gmail.com>
        <20230217142828.00007ed8@Huawei.com>
        <Y++Sju++GBxLAoCH@carbian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 17 Feb 2023 15:43:26 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> On Fri, Feb 17, 2023 at 02:28:28PM +0000, Jonathan Cameron wrote:
> > On Fri, 17 Feb 2023 13:59:16 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> > > On 2/17/23 13:43, Jonathan Cameron wrote:  
> > > > On Fri, 17 Feb 2023 07:56:22 +0200
> > > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > >     
> > > >> Hi Mehdi,
> > > >>
> > > >> On 2/16/23 22:22, Mehdi Djait wrote: >>> And here are the relevant steps after an IRQ occurs :    
> > > >>> 1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
> > > >>> with "data->timestamp = iio_get_time_ns(idev);" and returns
> > > >>> IRQ_WAKE_THREAD
> > > >>>
> > > >>> 2. kx022a_irq_thread_handler() -> checks that the trigger is enabled    
> > > >>> --> iio_trigger_poll_chained() --> handle_nested_irq(): which will only    
> > > >>> call the bottom half of the pollfuncs    
> > > >>
> > > >> I don't get the kx022a at my hands until next week to test this, but it
> > > >> seems to me your reasoning is right. iio_pollfunc_store_time() is
> > > >> probably not called. I just wonder why I didn't see zero timestamps when
> > > >> testing this. (OTOH, I had somewhat peculiar IRQ handling at first -
> > > >> maybe I broke this along the way).    
> > > > 
> > > > This is a common problem.  So far we've always solved it in the driver
> > > > by using the pf->timestamp only if it's been set - otherwise fallback
> > > > to grabbing a new one to pass into iio_push_to_buffer_with_timestamp()
> > > > in the threaded handler.
> > > > 
> > > > It might be possible to solve in a generic fashion but it's a bit
> > > > fiddly so I don't think anyone has ever looked at it.    
> > > 
> > > I agree it's "fiddly" :) I played with a though of conditionally adding 
> > > the timestamp in the iio_trigger_poll_chained() if the timestamp is zero 
> > > there. This, however, would require clearing the timestamp when it is 
> > > read - which gets "fiddly" soon. Hence I just suggested adding a note in 
> > > kerneldoc.
> > >   
> > > >>    
> > > >>> Question 2: If the change proposed in question 1 is wrong, would this
> > > >>> one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
> > > >>> iio_get_time_ns(idev)). There is some delay between the IRQ occuring
> > > >>> and trigger_handler being called but that is better than getting all 0
> > > >>> timestamps like suggested in [2]    
> > > >>
> > > >> Please, use the data->timestamp as you suggested.    
> > > > 
> > > > I'd suggest a bit of both.  If you have a timestamp from the irq handler
> > > > use it. If it's not available then grab one locally in the threaded handler.    
> > > 
> > > Hm. I don't think we will end up in the kx022a threaded handler so that 
> > > the data->timestamp is not populated in the IRQ handler. I am _far_ from 
> > > an IIO expert - but I guess the only way would be that some other 
> > > trigger invoked the threaded handler(?) Shouldn't the 
> > > kx022a_validate_trigger() prevent this?  
> > Ah.  I'd missed this one restricted what triggers could be used.
> > We'll have to pay attention to this if that particular condition is ever
> > relaxed.  
> > > 
> > > Please, follow Jonathan's guidance if he does not tell othervice. You 
> > > clearly should not trust a random guy who obviously does not know how to 
> > > write these drivers in the first place XD  
> > 
> > You were right here :)  
> 
> So should I send a patch with data->timestamp as I suggested ? 

I think so.

> 
> And should I write some documentaion to highlight the
> difference between iio_trigger_poll and iio_trigger_poll_chained, i.e.,
> where the functions expect to be called ?
> Something similar to the /kernel/irq/irqdesc.c

Sure.  The chained naming is inconsistent, but I never got around to fixing it.
Probably should be something like iio_trigger_poll_nested()

Comment on expectations is good.

> 
> >   
> > >   
> > > >>    
> > > >>> I hope that I'm understating this correctly or at least not totally
> > > >>> off :) If yes, I will send a patch.    
> > > >>
> > > >> Thanks Mehdi! I think this was a great catch! Maybe - while at it - you
> > > >> could also send a patch adding a small kerneldoc to the
> > > >> iio_trigger_poll_chained() mentioning this particular issue. Yes, I
> > > >> guess it should be obvious just by reading the function name *_chained()
> > > >> - but I did fall on this trap (and according to your reference [2] so
> > > >> has someone else).
> > > >>    
> > > >>> [1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
> > > >>> [2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
> > > >>> [3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/    
> > > >>
> > > >> Yours,
> > > >> 	-- Matti
> > > >>    
> > > >     
> > >   
> >   

