Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B13E8AD0
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhHKHLQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhHKHLP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:11:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780EFC061765;
        Wed, 11 Aug 2021 00:10:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y34so3576733lfa.8;
        Wed, 11 Aug 2021 00:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNOXr6gzd+fqJpCwsyne4QPv5njjHsYeJ33t/NJz//g=;
        b=Iu/qQ7BSrvV6jOV5E/kWloIvWNBX1Dm+1T3YQZaMaUz5xfhQA+JymnLBSikIBlmMl7
         lJOZHQs23oO+mY9DRGT5TskG9k3R7Ltg3Zk+3nSsTzlfBOlHv1uGS6YCjNz+X5JQNyht
         lnI4rZgIe8BUy4S+A/4LIVBwW5viSmdd/hl0cAdAm+OnjHAwS6wpL7o7/EqKQMQRMpkd
         /kzWBcWrtd6pet8RfU2aI2BRRbbhh+M6O9Cuo/Xl2VWRjNx7azbFJ7hRWZ85fZI+pCCu
         7iQ3dEc194Eo9rlrEFndgKGTlPVmh4/HmwtwVt/TCcW0nlQuJj+rLVwFBAy2iqODoTHf
         ZmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNOXr6gzd+fqJpCwsyne4QPv5njjHsYeJ33t/NJz//g=;
        b=hjriDpvUPaKJhPNkfZdf7rCkDTHDJslyRqJgeAjEmrCbgzJzNCqC81GO5iCw2WcBoW
         nMMPXDcY95125IwhRSxbtJif9Ib1IbiMMktomLypTAIf3pWeSq52P3MzXMcsDRV8EWUF
         Tb1hjQLr2j7VFW785LKs8Qla+HpjTmgtcgF17uUB0aP8STPNSGP8o9IMI7LRqdmSznBW
         owec7KNOmmPXuqMABHjWfy8tt2IUjPtuEPjiWdMbciIeGKby7tz2VOkv0aOdgeQ9Eltu
         HEE9Vg56LkyluVcu5vyS3B1nSFZBoCydxoGDwQU46ne7fkFgegyQx+wQkhLCgsAhnsr8
         mgVw==
X-Gm-Message-State: AOAM533hN2vpASk/M+Fms2ED00wTqZ873tC97hRQnf02DZ3BIzL4oj8I
        A5LC6xXsneEffeXdMhDeGnH5mjZn0OvQzgVHWUA=
X-Google-Smtp-Source: ABdhPJwLNEUIEP0BqRl99scaraURy5c+0sWgr6fX5WMrnYlA5rf2EP/d6BREs+ZzGYinthmdFT9DF22pMR5AW9D3T7c=
X-Received: by 2002:ac2:4c13:: with SMTP id t19mr24490681lfq.450.1628665850749;
 Wed, 11 Aug 2021 00:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210811051938.111191-1-puranjay12@gmail.com> <20210811051938.111191-3-puranjay12@gmail.com>
 <CAHp75VeWSwk7g+HUQ21cRKFDBdHKv4M4mTjv6Ng5DnZz-ugj2Q@mail.gmail.com>
In-Reply-To: <CAHp75VeWSwk7g+HUQ21cRKFDBdHKv4M4mTjv6Ng5DnZz-ugj2Q@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 11 Aug 2021 12:40:39 +0530
Message-ID: <CANk7y0i2ki2omXqpwHob4UhjrwYBiTX3z2D_BEDi3pLgCAENPQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] iio: accel: Add driver support for ADXL355
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 12:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 11, 2021 at 8:19 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
> >
> > ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
> > low 0g offset drift, low power with selectable measurement ranges.
> > It also features programmable high-pass and low-pass filters.
>
> Thanks for an update! My comments below.
> After addressing, feel free to add
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> ...
>
> > +#ifndef _ADXL355_H_
> > +#define _ADXL355_H_
> > +
> > +#include <linux/regmap.h>
>
> What I meant here is you need to add a forward declaration, i.e.
>
> struct device;
okay, I will add this.
>
> line.
>
> > +extern const struct regmap_access_table adxl355_readable_regs_tbl;
> > +extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> > +
> > +int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> > +                      const char *name);
> > +
> > +#endif /* _ADXL355_H_ */
>
> ...
>
> > +#define MEGA(x) ((x) * 1000000)
> > +#define TERA(x) ((x) * 1000000000000UL)
>
> What I meant is to define just constants. It will be easier to move
> this to a global space (I have a patch, btw, but it may be applied
> later). So, just
>
> #define MEGA  1000000UL
> #define TERA 1000000000000UUL
will change in v12
>
> And note that the second one should have a ULL suffix.
>
> ...
>
> > +       ret = regmap_bulk_write(data->regmap,
> > +                               adxl355_chans[chan].offset_reg,
> > +                               data->transf_buf, 2);
>
> ARRAY_SIZE() ?
ARRAY SIZE is 3, but here we need to transfer 2 bytes only.
>
> > +       if (ret)
> > +               goto set_opmode_unlock;
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
