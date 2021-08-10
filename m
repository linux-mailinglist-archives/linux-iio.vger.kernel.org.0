Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B734C3E83FB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhHJT4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHJT4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 15:56:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D29C0613C1;
        Tue, 10 Aug 2021 12:56:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l11so11155821plk.6;
        Tue, 10 Aug 2021 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/j6nJ0B+kt+FPNV9uDLOFseO7eqExy2LCXzZeR9upk=;
        b=ogUh0JUyREhosEeVYeXwQDP707P1FsYPiK+cJyGzmmFluA+i8uiJiJ/PnVkavM2Q8B
         aeNegKcPTRHzYRlhMALFCtDTtI6tICFYLx9x7aPWT3/pRBR0zp2NY6wR6AmzWL0WnvGp
         KrULQMvqwgJcLWYJkKrqJY793KSthEDkD842ItyXZTEcfxsenwZOpx2+s+fCZH1DaeWB
         UzHBMFXulbVj/XWUB4dfUUyopGwKvjyygdNQJuxVEReQ7pX2xS2GdlUOH1gRo/ghafXm
         bH5m6rjIWqWyuuiNIKUeBEDTdz0fl+bHedmjiad77RSuRsa/pSk7eIwUDo8sd8BEsnzb
         lm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/j6nJ0B+kt+FPNV9uDLOFseO7eqExy2LCXzZeR9upk=;
        b=irTNJZEyynsOVVix1G3uDBNFy6MLVT06RwNEIMuVNmtQPk70/AlsNgOvYn1VOoz7AS
         QjNM0ONK0X711q3SqDZczjM4MNN44KQeDpMq6BZ2uxy3xuCtLTIm0w3RZRHIuCE0dyj1
         RVVawddnvx+65lAZEh8caSsDNuldV/NS7JrQmft6alMwd7E12PMt0Wqu7bdH3HJifW9K
         fkogk/CIYdbzdjv2q5HCCyj7MyBFLcwcKQcCl2S03SWte0pHFYbF/+53AF00fFEjR03a
         CrCfWjaMDNp2uqOqfkb2G0oLLpsIdjlnYOtF2cP+28Ix7+mUrugSlMBq9PThwm76LT6w
         WOkQ==
X-Gm-Message-State: AOAM5320G1I0ET/tpoQiXjstO5f2cRVG6Q1tU/JK4aXN99OgWB1BdqdU
        MrdVApumReVlPvNn/T6s3IogjkzYeZ85mtv4Mm8=
X-Google-Smtp-Source: ABdhPJzivJY4JlUn+1BeeSlPgwz/WrMUsywF5eaw6NopOPVjc2meRLGoyXcG6YH7XsURzoWNY38O0M6FOcFz4Ke9GM4=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr1147639plb.21.1628625378803; Tue, 10
 Aug 2021 12:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com> <20210808173630.5c384a4b@jic23-huawei>
 <CDEHT583QT0A.2QAXX9AC2FMLO@shaak> <CAHp75Vc3o-RrHD_wt_CfJY3P8hoRhJkdiRRySFS_O_7VdtJTQA@mail.gmail.com>
 <CDG3ATRV00VV.57ZPL3OPU5N4@shaak>
In-Reply-To: <CDG3ATRV00VV.57ZPL3OPU5N4@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 22:55:42 +0300
Message-ID: <CAHp75Ve6Csjeeh7+ti6UE0-YPRHHFHXFA3jQwp+bqTAfL50_ig@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 10, 2021 at 10:46 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Tue Aug 10, 2021 at 8:15 AM EDT, Andy Shevchenko wrote:
> > On Mon, Aug 9, 2021 at 1:50 AM Liam Beguin <liambeguin@gmail.com> wrote:
> > > On Sun Aug 8, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> > > > On Sat, 7 Aug 2021 21:56:57 -0400
> > >         ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
> > >         if (ret == -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> > >                 continue;
> >
> > >         } else if (ret < 0) {

> > Side note, redundant 'else'
>
> Are you asking to add an 'else' statement?
>
> because, unless I'm mistaken, in this case ret can have other negative values
> that we want to catch with this 'else if'.

You lost me, I have no idea what "to add" and "other" mean here. No, I
asked to remove it. It's redundant.

> > >                 dev_err(dev, "invalid voltage reference in %pfw\n", child);
> > >                 fwnode_handle_put(child);
> > >                 return ret;
> > >         }

-- 
With Best Regards,
Andy Shevchenko
