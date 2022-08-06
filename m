Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1464458B87D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 23:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiHFVt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 17:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHFVt0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 17:49:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A69EBF4B;
        Sat,  6 Aug 2022 14:49:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e23so4298047qts.1;
        Sat, 06 Aug 2022 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TkLGeri0ieIB81mb5Sc2qpMW0NKUVK6/24BuiQ47HQk=;
        b=fid4xgPfRWxBELPa06Kw5m1dknzjDOd2w0mqZfLBK3fhtkyIhKOYLE/EV04mUjmMEt
         Fxwg2OLH7rGhE06dZeqU09/LY3kUA5+oGtclweIyrQTbcpJqjU7d3eBiW5vidF/v+GhX
         KBhl2yaXG7CGUxNQ5NelBVRQBg/CkyBxIlp/LKuwMkLCYrxgf+iNoY0+iptAVMeFIcH8
         F2g+/AaWtn+wGAMEJML4wH+q9DTHCIGRujdmang+eIianl7RAp+TMU8ouU2lPZr7iKz6
         8TIcBdKM+c55cZet4OIBdEUGGkKC76pNEQfkiIPFyU1P/GCjV8RPoDgA8eu6P97/WaQg
         AjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TkLGeri0ieIB81mb5Sc2qpMW0NKUVK6/24BuiQ47HQk=;
        b=Yl8eTptPItlCMF4Hm32LHZeQdErf3AsQHQySgLHdbZs/+yKVE8P0a/oJagyUdwCdom
         Fx0MR3heN9beR5iM6BkgRsXeqVBmSeeSpE5AzYpqBAt9Euj2DZPwE9RAVLpVtdpqCFKy
         TZjk2lA9WuF99UMSLnx5UjlkhryegaO+p0+tvH+WBxtPJZbW9oiwA2keeSwjZwGnNGgP
         9rMUYcaHlkfE02sGpLRCWi7OXxKO4uG8/kZ5OizYvtvTR4F6Im8fSvGVDr36UMm0IdoL
         fgL8YX7Yd6i9lIsyLUpn2cp2HDx/Zo3Uqwj+afJmL+2+BqzciQTbJ+QD+u7ma6xgDEH/
         Ru5w==
X-Gm-Message-State: ACgBeo2njGrdHkB/fmPYPtV1UKXL3d4JG+hp/c2xwZaTOwo1LuurYmMc
        A7OoY6aoUQQOqdXJB6KXd0D9gHabYNgswc5Q6/7aofL/4Kk=
X-Google-Smtp-Source: AA6agR7gJvZyYhNgYU9h5hi3Vq7jB5EvadUY1y5zCO7XDsqnbG7WKdlYbOH7fX5UbduXq2MOwqcn5O14FJNQkWB56+o=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr10990232qta.429.1659822564527; Sat, 06
 Aug 2022 14:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154723.99947-1-matt.ranostay@konsulko.com>
 <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com>
 <CAJCx=gnxV7-oQCNE1LvpcFGhPCQ86rRbn_2NMh4MWpvmQ9WAYw@mail.gmail.com>
 <CAHp75VfmdZQF7Kyu5ZsNpVfOoD3Dd2ShWOuuoauyJnV4t0w=XQ@mail.gmail.com> <20220806172905.3755bdc0@jic23-huawei>
In-Reply-To: <20220806172905.3755bdc0@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 23:48:47 +0200
Message-ID: <CAHp75VdgHAjDSnx+nHG6uJMz76wx0Vzu+fQPiauG0YoqCvLimQ@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 6, 2022 at 6:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 1 Aug 2022 11:08:39 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 1, 2022 at 6:19 AM Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> > > On Mon, Aug 1, 2022 at 3:11 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Jul 29, 2022 at 5:49 PM Matt Ranostay
> > > > <matt.ranostay@konsulko.com> wrote:

...

> > > > > +       if (mcp->indio_dev)
> > > >
> > > > Do you need this check?
> > >
> > > Yes basically if no ADC or DAC channel is enabled then no iio_device
> > > get allocated or registered.
> >
> > > > > +               iio_device_unregister(mcp->indio_dev);
> >
> > So, we have an inconvenience in the iio_device_unregister(), i.e. it
> > doesn't perform the NULL-check by itself. I recommend fixing it there
> > and dropping this check in the caller. This is standard practice in
> > the Linux kernel for resource deallocator APIs.
>
> ah. Now the other patch makes more sense.   Make sure to pull this
> driver an that one together in a series if we are taking that forwards.
>
> I agree for allocator APIs but not so much for registration APIs.
> I checked a few similar ones.
>
> input_unregister_device() doesn't
> hwmon_device_unregister() doesn't.
>
> Got bored at that point :)

Good point. I think that check is simply not needed then. We should
never come to _unregister() with a NULL pointer, right?

> Would be relatively easy to take this driver fully devm_ I think
> then you can just use devm_iio_device_register() if you have a device
> to register.

-- 
With Best Regards,
Andy Shevchenko
