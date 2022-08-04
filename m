Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2C58A08D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiHDSaw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiHDSav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:30:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A020BD1;
        Thu,  4 Aug 2022 11:30:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so700469edd.9;
        Thu, 04 Aug 2022 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LLZraREUyJDjKKH1ZAbZl4aViUMskkpVlY1tgmbuzBQ=;
        b=A82RRj4j5eIvBqjSKhVn9bseSl/A/rKVdZ0C9m/3KEnl5rl/JLMG4t0huZuBjD0lLl
         XoIkgJgjLIM9abrA2Dpx2l4verQ5BGWbrxmeJFlI2wnrdxL2YxSwA/GUMQp0KH+72u/2
         wfA/hgrh0zzZbyLJlHbB6Aymvt88PP0iwQ+kp/MwsjRSfdlMpzx63GV9dScK3WYvFCx/
         OlCJVFplMj5+6sZv1w0cq0qZDEwToKd09dNDqsKVjK8FS0ZqMxat6XAPQwa8nz+RPJLX
         IsBw3p5Ua7F40iFrX1s6euUDZg5cFVScn92L1HcV6vpHxQYk52rOQkeuj28hX10Ince5
         trdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LLZraREUyJDjKKH1ZAbZl4aViUMskkpVlY1tgmbuzBQ=;
        b=RLrINb+T6GDovwqyI84zs55K+mcyGtlYVRbHeJHW074XcdZZFBp8jVkSGugRIJxGYr
         +sD3ovCEER4aifhrN8vijEkPK7RWSBTadKezxTAciuJRY6rHPVddx+h6xxmHJ1rLWz4D
         KA/DScuN/xGfikFjkfyBRY+iMkuhmrwhImVAf3qm3xhJmBnuBnxLDeo7GKQ+KU2Gggnx
         ix3dvUxuVh3TT5PDh0q2kMvvMEIo5kRH7JMaajsgoNS6X2eFAvpz/QZ3Dxl3sxGS4vG/
         cs0TzWQX88Z2Koxjhwm0XowPuEKFq18n8SUb+Chu0tFesZYJAaK+5mQeKW/9TlEsbdbb
         zbEw==
X-Gm-Message-State: ACgBeo2jTBSANcgADt+D0pPaA4vAPcPRoGQZpeb1Riy49FnViV15ME3k
        /y0O+1o6RkI3EZ1J6jon5Nv1PthOhqKtYvgJzBo=
X-Google-Smtp-Source: AA6agR4TTHPhRcnwzcotFB2sZSdavSTj78/7Wo1rRxafVgWreln/iVUhj2wzQ7WLrzcXy7Jx9TOnHhbAdbV+35jOnBc=
X-Received: by 2002:a05:6402:f22:b0:43e:8623:d32c with SMTP id
 i34-20020a0564020f2200b0043e8623d32cmr3362050eda.265.1659637849133; Thu, 04
 Aug 2022 11:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru> <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru> <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220804181723.4bljpxcwkj6cnn2f@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Aug 2022 20:30:12 +0200
Message-ID: <CAHp75Vcn6JCDDvugop2Ho1cayLi1CX78O42v3GifvnuSY5fvPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Aug 4, 2022 at 8:17 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Wed, Aug 03, 2022 at 07:16:13PM +0000, Dmitry Rokosov wrote:
> > On Wed, Aug 03, 2022 at 07:49:33PM +0200, Andy Shevchenko wrote:
> > > On Wed, Aug 3, 2022 at 3:11 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

Please, remove unneeded context when replying!

...

> > > > +               dev_err(dev, "cannot %s register %u from debugfs (%d)\n",
> > > > +                       readval ? "read" : "write", reg, err);
> > >
> > > You may consider taking [1] as a precursor here and use str_read_write().
> > >
> > > [1]: https://lore.kernel.org/linux-i2c/20220703154232.55549-1-andriy.shevchenko@linux.intel.com/
> >
> > Oh, really... Thank you for suggestion!
>
> I have taken it closer, and it's really helpful and nice, but looks like
> it's not merged to linux-next.
> Please advise how I can use it in the driver. Should I provide
> "Depends-On:" tag as I did for my HZ units patchset?

No, just take that patch into your series.

-- 
With Best Regards,
Andy Shevchenko
