Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986A5866B8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Aug 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHAJJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Aug 2022 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHAJJS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2022 05:09:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EDA2A942;
        Mon,  1 Aug 2022 02:09:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so5170549edi.8;
        Mon, 01 Aug 2022 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T8Dx1LB9nhk4V6gwNnrIDAbF7gw5C16RB9z39eBzzFQ=;
        b=Xo6pOWUIV20zMi9pQiC0Iw3nM6uMtgVz1u65uQjxaYfL7JoNrYRBr9hymGxTBJpwcc
         VO94cK7OifIKmeiHk06KBFa96UHeqYulBxY2BcwZOj2Dd2/boNoLyUg7xqI6OAXOZ6Kq
         FH+cxNCIXBswsaFPzyWygxY2+dx3AU+d34kzpFFAHm0OYwNirnrAcdJFqlOeW6P80NFv
         gw0QojPd0jIobAS4KkpCDX9lu+oO/lqWx4i7CqE4/jyE1LMkxahiXMvw8F6FbEFUOkgc
         COwGJo6tpgptWuz/e/C5wPYC7wOq7ZpLIHe9PIgcD6hllPlJ2VYzS55Ljen6YJGkpgpr
         TO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T8Dx1LB9nhk4V6gwNnrIDAbF7gw5C16RB9z39eBzzFQ=;
        b=DC9qms8axe9EvuJpteSbsJXXkCHHA2XQzNyOikjYMsPOPjiYnObiz002ze2UEbreJp
         bXG5uxQzFeUNAIvYZlct3t2qFVYMKx+m3kxBov7fS05jMWyOF1OE6jVycCObnOIXU8Mf
         hfjWrwHe0R/E/yU/P82bTHRe0Vm8WOnqJa0wBJHdq9CpXB5TL6SAGqiwTxYBxJk8h6Tr
         3Mu+E/y0TF3JmtKon1sJoUCTMCrUijcYRpyzsuB5j3/TrKIASS8U8avZulivVOrd5ioK
         tLbPMxRRdEjNiTd065qyjalJCxVTL9nTzyQDrp/s9uK11uzhDxDb7nLblZMk31S3son8
         HLBQ==
X-Gm-Message-State: AJIora/OSBCfIPJ7LkXXKx3xSX+3A0uVif9CrV3ts2iDCWVWyuKiAZfF
        q7yjcDS3BP/XHYIpz9O/Kf4guhmhPyg4PKL/3Hg=
X-Google-Smtp-Source: AGRyM1sCm2pwABAlv0cffLgHfmFtk4QVghaduQ8LEgkETjyxcra3eI6nckHfO20ctWM3XF9LKP6GNLKmhQ0zAysfxFo=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr15224541edb.380.1659344956035; Mon, 01
 Aug 2022 02:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154723.99947-1-matt.ranostay@konsulko.com>
 <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com> <CAJCx=gnxV7-oQCNE1LvpcFGhPCQ86rRbn_2NMh4MWpvmQ9WAYw@mail.gmail.com>
In-Reply-To: <CAJCx=gnxV7-oQCNE1LvpcFGhPCQ86rRbn_2NMh4MWpvmQ9WAYw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 11:08:39 +0200
Message-ID: <CAHp75VfmdZQF7Kyu5ZsNpVfOoD3Dd2ShWOuuoauyJnV4t0w=XQ@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 1, 2022 at 6:19 AM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> On Mon, Aug 1, 2022 at 3:11 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jul 29, 2022 at 5:49 PM Matt Ranostay
> > <matt.ranostay@konsulko.com> wrote:

First of all, please, remove unneeded context when replying!
(And I believe that non-commented stuff will be addressed as suggested)

...

> > > -       depends on GPIOLIB
> > > +       select GPIOLIB
> >
> > I'm not sure why.
>
> Changed to select from 'depends on' to avoid this circular dependency

Was it before your patch? If so, it should be addressed separately as a fix.

>   SYNC    include/config/auto.conf.cmd
> drivers/gpio/Kconfig:14:error: recursive dependency detected!

> drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by I2C_MUX_LTC4306

Isn't it the real problem here?

> drivers/i2c/muxes/Kconfig:47:   symbol I2C_MUX_LTC4306 depends on I2C_MUX
> drivers/i2c/Kconfig:62: symbol I2C_MUX is selected by MPU3050_I2C
> drivers/iio/gyro/Kconfig:127:   symbol MPU3050_I2C depends on IIO
> drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
> drivers/hid/Kconfig:1298:       symbol HID_MCP2221 depends on GPIOLIB

...

> > > +                       if (mcp->indio_dev)
> > > +                               memcpy(&mcp->adc_values, &data[50], 6);
> >
> > sizeof()
>
> sizeof(mcp->adc_values) would work here if needed.

You need to write code to be more robust, using hardcoded magics when
it's easy to derive is not good practice.

...

> > > +       memset(mcp->txbuf, 0, 12);
> >
> > sizeof() ?
>
> txbuf isn't 12 bytes long but 64 since that is the full max size a HID
> transaction could
> have. So sizeof() won't work in these cases..

I see, what about a specific definition with a self-explanatory name?

...

> > > +       ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);
> >
> > Ditto,
>
> See above.

See above.

...

> > > +       if (mcp->indio_dev)
> >
> > Do you need this check?
>
> Yes basically if no ADC or DAC channel is enabled then no iio_device
> get allocated or registered.

> > > +               iio_device_unregister(mcp->indio_dev);

So, we have an inconvenience in the iio_device_unregister(), i.e. it
doesn't perform the NULL-check by itself. I recommend fixing it there
and dropping this check in the caller. This is standard practice in
the Linux kernel for resource deallocator APIs.

...

> > Overall what I really do not like is that ugly ifdeffery. Can we avoid
> > adding it?
>
> Could make CONFIG_IIO required for building but not sure we really
> want to add as an additional dependency.
> Which is way the imply is set for CONFIG_IIO

The code looks ugly with this kind of ifdeffery. But okay, I leave it
up to maintainers, just my 2cents.

-- 
With Best Regards,
Andy Shevchenko
