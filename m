Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40269AE42
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 15:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBQOnc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 09:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQOnb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 09:43:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7265C68E54
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 06:43:30 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cz7so1704784edb.12
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 06:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZARXrwrnBWvfhD56Pw1eg9WA6+UPMj/k4LGpPl70puE=;
        b=J8Qba8G8AAvn3tMwgqXs1mTuR7g9Jre+O6aUhfqddfbkgizGSsT1rJksbxuO+1+Pna
         jqFziSqef9MCW7g099X0enTRHqDn2h2wv1jOiPv0g18wv2v2qWKIkV1oJPYQikQosEZp
         Ah/RYBwX94gH+AKmN11OUbtcw0Ae3EKbbx3WOaD3lQuZR8b+z6EswdfsTs05hf3eMqgP
         uJ0Zp8wwrPHrlgsg7wtU1akCuwTQRrCtEWgmDi4sahSLqfV5fvJGCWs60i9p6sgvAn3L
         nPMRu3jLqAKRTUeJn6zR7pJhzfzwqw0IPT5wnKjLfpLn8Eyec/BQDurVV6CGT1TyttY3
         PLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZARXrwrnBWvfhD56Pw1eg9WA6+UPMj/k4LGpPl70puE=;
        b=gLnbI1iorOYg4zfdCl5oul1kloFpDB+cI7W+KMDdQnjYxkBeUBHGeI9TY09VBHmste
         qn4SnbcD705le1LBztz0tAXFAu8U4oEAh16heh1+IGlpWoDlAq+kPgP4J2iupDOg+lBJ
         ncuwkpBlzemiU5MQJGCCRxaubTHI6furSbmwKNHOCS0YO9Ye4t2UspDVX/oHdc3rGtTc
         8Tf27JQCV8+1t3WWjCR6zsD8ODUyxgWkHNQhgZm9ZNM38yXfJsfhMfxUv0M/9558FT1D
         uOBunwGv9O8/A8o/7jzkQGuvsGCy/a16VaRIaa6hg0NsbGGJtThXlifIPciHVw7dh5Eu
         hCSg==
X-Gm-Message-State: AO0yUKXxCb4xJfYB9w9Gxe95O8U3T5/lfIrymAXRDzzh0ysbv4hwkGJn
        YFTihD7pRyfbugtReTNTd3qKwVbEEAY=
X-Google-Smtp-Source: AK7set+iO2QOmFQuJQsVqngSYJCuvaccDXKo9s8HrhYtDiKqKzSMXtJ20XBljQuVrXsJnYeQL+dAwg==
X-Received: by 2002:a17:907:76f1:b0:881:23a:aba5 with SMTP id kg17-20020a17090776f100b00881023aaba5mr9549861ejc.11.1676645008865;
        Fri, 17 Feb 2023 06:43:28 -0800 (PST)
Received: from carbian ([2a02:8109:aa3f:ead8::af9d])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b0088cd8f7255fsm2200703ejb.48.2023.02.17.06.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:43:28 -0800 (PST)
Date:   Fri, 17 Feb 2023 15:43:26 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     mazziesaccount@gmail.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: Questions: iio: accel: kionix-kx022a: timestamp when using the
 data-rdy trigger?
Message-ID: <Y++Sju++GBxLAoCH@carbian>
References: <Y+6QoBLh1k82cJVN@carbian>
 <de389f14-0c63-86ae-6718-e91fc9818fc6@gmail.com>
 <20230217114308.00004a31@Huawei.com>
 <a4e69c59-d5c5-be8e-da7c-1955cc8b0ad7@gmail.com>
 <20230217142828.00007ed8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217142828.00007ed8@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 17, 2023 at 02:28:28PM +0000, Jonathan Cameron wrote:
> On Fri, 17 Feb 2023 13:59:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > On 2/17/23 13:43, Jonathan Cameron wrote:
> > > On Fri, 17 Feb 2023 07:56:22 +0200
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > >   
> > >> Hi Mehdi,
> > >>
> > >> On 2/16/23 22:22, Mehdi Djait wrote: >>> And here are the relevant steps after an IRQ occurs :  
> > >>> 1. IRQ context --> kx022a_irq_handler() --> gets the current timestamp
> > >>> with "data->timestamp = iio_get_time_ns(idev);" and returns
> > >>> IRQ_WAKE_THREAD
> > >>>
> > >>> 2. kx022a_irq_thread_handler() -> checks that the trigger is enabled  
> > >>> --> iio_trigger_poll_chained() --> handle_nested_irq(): which will only  
> > >>> call the bottom half of the pollfuncs  
> > >>
> > >> I don't get the kx022a at my hands until next week to test this, but it
> > >> seems to me your reasoning is right. iio_pollfunc_store_time() is
> > >> probably not called. I just wonder why I didn't see zero timestamps when
> > >> testing this. (OTOH, I had somewhat peculiar IRQ handling at first -
> > >> maybe I broke this along the way).  
> > > 
> > > This is a common problem.  So far we've always solved it in the driver
> > > by using the pf->timestamp only if it's been set - otherwise fallback
> > > to grabbing a new one to pass into iio_push_to_buffer_with_timestamp()
> > > in the threaded handler.
> > > 
> > > It might be possible to solve in a generic fashion but it's a bit
> > > fiddly so I don't think anyone has ever looked at it.  
> > 
> > I agree it's "fiddly" :) I played with a though of conditionally adding 
> > the timestamp in the iio_trigger_poll_chained() if the timestamp is zero 
> > there. This, however, would require clearing the timestamp when it is 
> > read - which gets "fiddly" soon. Hence I just suggested adding a note in 
> > kerneldoc.
> > 
> > >>  
> > >>> Question 2: If the change proposed in question 1 is wrong, would this
> > >>> one be better iio_push_to_buffers_with_timestamp(idev, data->buffer,
> > >>> iio_get_time_ns(idev)). There is some delay between the IRQ occuring
> > >>> and trigger_handler being called but that is better than getting all 0
> > >>> timestamps like suggested in [2]  
> > >>
> > >> Please, use the data->timestamp as you suggested.  
> > > 
> > > I'd suggest a bit of both.  If you have a timestamp from the irq handler
> > > use it. If it's not available then grab one locally in the threaded handler.  
> > 
> > Hm. I don't think we will end up in the kx022a threaded handler so that 
> > the data->timestamp is not populated in the IRQ handler. I am _far_ from 
> > an IIO expert - but I guess the only way would be that some other 
> > trigger invoked the threaded handler(?) Shouldn't the 
> > kx022a_validate_trigger() prevent this?
> Ah.  I'd missed this one restricted what triggers could be used.
> We'll have to pay attention to this if that particular condition is ever
> relaxed.
> > 
> > Please, follow Jonathan's guidance if he does not tell othervice. You 
> > clearly should not trust a random guy who obviously does not know how to 
> > write these drivers in the first place XD
> 
> You were right here :)

So should I send a patch with data->timestamp as I suggested ? 

And should I write some documentaion to highlight the
difference between iio_trigger_poll and iio_trigger_poll_chained, i.e.,
where the functions expect to be called ?
Something similar to the /kernel/irq/irqdesc.c

> 
> > 
> > >>  
> > >>> I hope that I'm understating this correctly or at least not totally
> > >>> off :) If yes, I will send a patch.  
> > >>
> > >> Thanks Mehdi! I think this was a great catch! Maybe - while at it - you
> > >> could also send a patch adding a small kerneldoc to the
> > >> iio_trigger_poll_chained() mentioning this particular issue. Yes, I
> > >> guess it should be obvious just by reading the function name *_chained()
> > >> - but I did fall on this trap (and according to your reference [2] so
> > >> has someone else).
> > >>  
> > >>> [1] https://lore.kernel.org/linux-iio/4FDB33CD.2090805@metafoo.de/
> > >>> [2] https://lore.kernel.org/linux-iio/20201205182659.7cd23d5b@archlinux/
> > >>> [3] https://lore.kernel.org/linux-iio/20220126191606.00003f37@Huawei.com/  
> > >>
> > >> Yours,
> > >> 	-- Matti
> > >>  
> > >   
> > 
> 
