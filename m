Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579458B6BA
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiHFQSs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFQSr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 12:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECB659C;
        Sat,  6 Aug 2022 09:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB94260E04;
        Sat,  6 Aug 2022 16:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AFEC433D7;
        Sat,  6 Aug 2022 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659802725;
        bh=GqybX519p1IsieOaAtqe8J7TdeClhx1gw0hFu/BXJ8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZ6P/+DOGMuth/bQCjdVqp3kzAy1ejRgTndNJU7jdzNLJS/c8BN1kmMAOfHvZnhwL
         tCf6cXa3KuIRg6rJb8NHbw/CErP5M1yCNXoX/cuuezVCUTEV1bJ/G0bG2RdLXp+4z+
         4std5m0OGFACaRw5BVRxuzSblpb5iilYUPrLKJtRG+V1wO6gMg4gEzmkxu07J/kpHk
         TAcF7fF1Ud84kJv5hVc6iUUNZL6YO4SmFVE65AIYLf2tflcRBsC5/83LqeFCcXuuPB
         4F2WHCcanBo+ET1v1NWCvWBlq56D7qJ+rhdZYJzhj/hlOiFaSlRbrtN8iLlNH1aG9A
         PTgZrlxntw1zQ==
Date:   Sat, 6 Aug 2022 17:29:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
Message-ID: <20220806172905.3755bdc0@jic23-huawei>
In-Reply-To: <CAHp75VfmdZQF7Kyu5ZsNpVfOoD3Dd2ShWOuuoauyJnV4t0w=XQ@mail.gmail.com>
References: <20220729154723.99947-1-matt.ranostay@konsulko.com>
        <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com>
        <CAJCx=gnxV7-oQCNE1LvpcFGhPCQ86rRbn_2NMh4MWpvmQ9WAYw@mail.gmail.com>
        <CAHp75VfmdZQF7Kyu5ZsNpVfOoD3Dd2ShWOuuoauyJnV4t0w=XQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Aug 2022 11:08:39 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 1, 2022 at 6:19 AM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> > On Mon, Aug 1, 2022 at 3:11 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:  
> > > On Fri, Jul 29, 2022 at 5:49 PM Matt Ranostay
> > > <matt.ranostay@konsulko.com> wrote:  
> 
> First of all, please, remove unneeded context when replying!
> (And I believe that non-commented stuff will be addressed as suggested)
> 
> ...
> 
> > > > -       depends on GPIOLIB
> > > > +       select GPIOLIB  
> > >
> > > I'm not sure why.  
> >
> > Changed to select from 'depends on' to avoid this circular dependency  
> 
> Was it before your patch? If so, it should be addressed separately as a fix.
> 
> >   SYNC    include/config/auto.conf.cmd
> > drivers/gpio/Kconfig:14:error: recursive dependency detected!  
> 
> > drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by I2C_MUX_LTC4306  
> 
> Isn't it the real problem here?
> 
> > drivers/i2c/muxes/Kconfig:47:   symbol I2C_MUX_LTC4306 depends on I2C_MUX
> > drivers/i2c/Kconfig:62: symbol I2C_MUX is selected by MPU3050_I2C
> > drivers/iio/gyro/Kconfig:127:   symbol MPU3050_I2C depends on IIO
> > drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
> > drivers/hid/Kconfig:1298:       symbol HID_MCP2221 depends on GPIOLIB  
> 
> ...
> 
> > > > +                       if (mcp->indio_dev)
> > > > +                               memcpy(&mcp->adc_values, &data[50], 6);  
> > >
> > > sizeof()  
> >
> > sizeof(mcp->adc_values) would work here if needed.  
> 
> You need to write code to be more robust, using hardcoded magics when
> it's easy to derive is not good practice.
> 
> ...
> 
> > > > +       memset(mcp->txbuf, 0, 12);  
> > >
> > > sizeof() ?  
> >
> > txbuf isn't 12 bytes long but 64 since that is the full max size a HID
> > transaction could
> > have. So sizeof() won't work in these cases..  
> 
> I see, what about a specific definition with a self-explanatory name?
> 
> ...
> 
> > > > +       ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);  
> > >
> > > Ditto,  
> >
> > See above.  
> 
> See above.
> 
> ...
> 
> > > > +       if (mcp->indio_dev)  
> > >
> > > Do you need this check?  
> >
> > Yes basically if no ADC or DAC channel is enabled then no iio_device
> > get allocated or registered.  
> 
> > > > +               iio_device_unregister(mcp->indio_dev);  
> 
> So, we have an inconvenience in the iio_device_unregister(), i.e. it
> doesn't perform the NULL-check by itself. I recommend fixing it there
> and dropping this check in the caller. This is standard practice in
> the Linux kernel for resource deallocator APIs.

ah. Now the other patch makes more sense.   Make sure to pull this
driver an that one together in a series if we are taking that forwards.

I agree for allocator APIs but not so much for registration APIs.
I checked a few similar ones.

input_unregister_device() doesn't
hwmon_device_unregister() doesn't.

Got bored at that point :)

Would be relatively easy to take this driver fully devm_ I think
then you can just use devm_iio_device_register() if you have a device
to register.


> 
> ...
> 
> > > Overall what I really do not like is that ugly ifdeffery. Can we avoid
> > > adding it?  
> >
> > Could make CONFIG_IIO required for building but not sure we really
> > want to add as an additional dependency.
> > Which is way the imply is set for CONFIG_IIO  
> 
> The code looks ugly with this kind of ifdeffery. But okay, I leave it
> up to maintainers, just my 2cents.
> 
Agreed.  HID maintainer call to make I think. 

One alternative is the standard approach of spin another file with wrappers around
the IIO registration calls, then stub that out in the header if CONFIG_IIO
not built appropriately.

Jonathan


