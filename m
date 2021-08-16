Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED83ED44D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 14:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhHPMtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhHPMtk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 08:49:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8909AC061764;
        Mon, 16 Aug 2021 05:49:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso27455064pjb.1;
        Mon, 16 Aug 2021 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fy2isYPKNPiV5shXC0pHBU+VcJN04Q1fGssTZF6jyrk=;
        b=dbgyiLbUICxgXBHTpnPAt/qsKESjlH/GBJ5TU7nhRGV6hU3DTxWOTZYXjVLe6V0LOw
         Dy5an50QuHgAsakguL9U4ZBtazFIOR++CnKTFqv4riOyEDkF9ulw4+gyQSQC2VKERLTL
         pY7zB8ORh5dlqbAOIym3VEBlvcua2JM0gIUmuyxst6vgBfbDaQESHW6DNjybfifgsXf5
         lDXOZD7hV6xVp4uZod0U+x4SRKyNDnumXP7YuRH3pPBF5WUYsw+oX8jD3xMRRdkUh3xq
         wuXCGi1NAz8Q2egjbTe1ppJ4daHst0QJjkwiyLAKGPXSH+3Latwvcs25zzB7dzjdypEE
         KELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fy2isYPKNPiV5shXC0pHBU+VcJN04Q1fGssTZF6jyrk=;
        b=B8BkGsQzmhDbELiYJO0GPW2Vy2o/eCmYHYGkRRI9VK+b1lz8alK4J3zBW3h9RAmxEF
         zjvLmntlBpqLT6RmX/ez7GrkzfeodfBhl/JDTiWXit6fUppek0SCaVyU+AHb3QwVLUXP
         7FmwkftYxnkOKQBsNj8HkXPiltEy7419qfyXkvUZgu79U8Rr5ALwf1Ss61+/6aySwRC0
         3dBHfYKIaTqjklc5SjMKoPlkvlbbIQIJ2kR2j5a2Cj883jCxEdRAL7f8IQPzndV0Bsb9
         8sh5jm3gFRTcZlbNqjJdOyAFWZIDq2BnTpAT2zIZEZaSm5lnz7wJTd19wsTHyxmAda+d
         9o7g==
X-Gm-Message-State: AOAM530vlzj9VyV2t+yoa4YW8mGbGp7L/rNqzuJ5tjplxLpwc8Ba8qUM
        FfSNjvsRdWXsyv3tD7TO4mjSv+hqxARq+AH7Kag=
X-Google-Smtp-Source: ABdhPJxw1y148kB9C6s1stB/oyZ5CgbZ7lwNMKRJajO3KET6bGTP3m7dnAH7DpztooEiwAxSMphInYVT5VYiQ08bv94=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr13247410plb.21.1629118148043; Mon, 16
 Aug 2021 05:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-4-liambeguin@gmail.com> <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
 <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
In-Reply-To: <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Aug 2021 15:48:28 +0300
Message-ID: <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Mon, Aug 16, 2021 at 3:39 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:
> > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > wrote:

...

> > > +       tmp = 4096000;
> > > +       ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
> >
> > > +       if (ret < 0 && ret != -EINVAL) {
>
> Hi Andy,
>
> >
> > What does this check (second part) is supposed to mean?
> > The first part will make it mandatory, is it the goal?
> >
>
> device_property_read_u32() will return -EINVAL if the property isn't
> found in the devicetree.
>
> This checks for errors when the property is defined while keeping it
> optional.

Don't assign and don't check the error code of the API. As simply as that.

> > > +               dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
> > > +               return ret;
> > > +       }


-- 
With Best Regards,
Andy Shevchenko
