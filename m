Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE90C2291B5
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgGVHIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 03:08:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA83C061794;
        Wed, 22 Jul 2020 00:08:23 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n24so1021701otr.13;
        Wed, 22 Jul 2020 00:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vv6mjOP8SpjjnDhw8GwlKnMXEsutI46n6lzkUQF8tkw=;
        b=UFU9MpvRS/y+TNwXyc45b4mqyFH6w3m8D1C0tN60EEcFpYc4bRF19z5MXiYySiz6ZU
         g9Xcv0K8DSPsnfbg+f21mbWDNiUf/+Rt4DuVbSH7PNWJowvBUun2h3tWPv/ESqnDc/OH
         +h/+8mPMzS/ebXWyEN2F2zlfl47YeglMj3ncgarka8towJP5EBlpJqX/c01gKOJYcplj
         L6M+RDEO7fzgEPbVsl4QLRzk7WE1iyf11lYrIYeZIFAmNKKdEk9KZtE0BxkeyIepwVIs
         ZfaNrFXA20q+TsUG4lU0kg7hiHY5uuQMWJfeAghj7oWi7k4s4VUn8/ks2BWGnX6fEia1
         iA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv6mjOP8SpjjnDhw8GwlKnMXEsutI46n6lzkUQF8tkw=;
        b=VCq5qX6VTcENaSnNMCqwu5oAL9C2cGcjRfSrRnfa73YqFIdbCJVcIiD31lGPimLiCn
         HGSGlnLGfBZxe5kg+hCNIB3J4scQe28YRGsh12Mi8asxQjBvs9zhI6RM70xAnePv5G7Z
         hbRczZOdUskJcL6pe8Q9RNgnVeCP4VsamBC53S7yB4il8taJxFSR04+AQ8tTsRKkLUH4
         KqTqPUgMJaIFoCmyNoXTDRo3aJiBQzcWRGFit824NPH0cCFT0El/hm7SXqGidhE33C0A
         419aSUCW3SPSPeJls8u3GKjR2MjRrl+wFfSXP3WnsBOxG6K/IptkGrukhCvZw33D9jQ5
         l5zQ==
X-Gm-Message-State: AOAM531eYs4hnF6dw/b/ospomoy5VcdabQq6dlhTRn0RJK5E0I2S6Qyn
        egG77DXbp5IrMO3yeAZo8niZOBJcMvTgZEHB/gHAdr7u
X-Google-Smtp-Source: ABdhPJxo9vG64VfOkf3OIlEGKsqkTeBufeBPKshJUoFIMN/OBuB2EImQdg9wl4uRrJgeDDdFvHP5z9eJ1uBW0/3RAS8=
X-Received: by 2002:a05:6830:19eb:: with SMTP id t11mr26935831ott.207.1595401703383;
 Wed, 22 Jul 2020 00:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200720134931.71537-1-alexandru.ardelean@analog.com> <CAHp75VfmvGgCK3Cg1nxPtYeF1Y9oQAKST1bAnKXxB2hpd8=feg@mail.gmail.com>
In-Reply-To: <CAHp75VfmvGgCK3Cg1nxPtYeF1Y9oQAKST1bAnKXxB2hpd8=feg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 22 Jul 2020 10:08:12 +0300
Message-ID: <CA+U=DsrqGkhpbu32b0F8uzihtwbJVSbPQ7xOtHq8UgmM7-2peA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adxl372: Add OF device ID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 9:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 20, 2020 at 4:48 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Stefan Popa <stefan.popa@analog.com>
> >
> > The driver does not have a struct of_device_id table, but supported
> > devices are registered via Device Trees. This patch adds OF device ID
> > table.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/accel/adxl372_i2c.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
> > index e1affe480c77..5197d1eb6803 100644
> > --- a/drivers/iio/accel/adxl372_i2c.c
> > +++ b/drivers/iio/accel/adxl372_i2c.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
>
>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
>
> With the huge patch series from Jonathan I think you may learn that
> proper header here is
>
> mod_devicetable.h.

yep;
thanks for pointing that out;

>
>
> >
> >  #include "adxl372.h"
> >
> > @@ -46,9 +48,16 @@ static const struct i2c_device_id adxl372_i2c_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
> >
> > +static const struct of_device_id adxl372_of_match[] = {
> > +       { .compatible = "adi,adxl372" },
>
> > +       { },
>
> No comma, please!
>
> > +};
> > +MODULE_DEVICE_TABLE(of, adxl372_of_match);
> > +
> >  static struct i2c_driver adxl372_i2c_driver = {
> >         .driver = {
> >                 .name = "adxl372_i2c",
> > +               .of_match_table = adxl372_of_match,
> >         },
> >         .probe = adxl372_i2c_probe,
> >         .id_table = adxl372_i2c_id,
> > --
> > 2.17.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
