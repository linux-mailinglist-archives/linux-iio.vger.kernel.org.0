Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF218661E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 09:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgCPIIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 04:08:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43183 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgCPIIc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 04:08:32 -0400
Received: by mail-io1-f65.google.com with SMTP id n21so16114324ioo.10
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2020 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4C2QkAKPFn1QPCfwIwQSCmTCJeHSpIXw2b0k4lFrSqw=;
        b=fm03qKP6u2MIv0CLrzY6ofU6yjZHgvQe+TbeLEntGXpI0hO9eXYatpS9h57CEiZIr6
         1ySpUt7WdvD5OnUwPShXMoisuWsd4epIw+0qkyDd/uc0RF8KmlYU3tI8eFCcexvH4rAA
         Eqizgf7FiaTXaWdZ50zDduVks6W5BQE7rxDRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4C2QkAKPFn1QPCfwIwQSCmTCJeHSpIXw2b0k4lFrSqw=;
        b=NnXwaCZYYZS59NpWZA1q2RfhUio408/51McKSGgGiT+PyW2hVHn+NGersO7Oc2jIpu
         SiekL2H93RotWL3zE23SXfxnuh7rkxXH8huWTTA3gAsfR2aUTcgdwJjAhRPOatloKxIZ
         9JX1pd7w+/5c1YTnxJoqp4l4+0+MsEBcIQg9eLs3Czy8QaKUt2U93qLEASG7NlwUOVX1
         aycBLkEm35gafvukpN9t8GTCXPddufS2lQI6MGbKJKkBufTOHaY7m1wuq2Zt5RrY3bsT
         DIzPagcs5Caluf1n16BU7E8mbAcR4LSDhMmVdiC215ulg5Q0k8eNBlgf0aWak+OR8JYr
         xsyA==
X-Gm-Message-State: ANhLgQ2Mo/4eZY770znhyLZkGvckjRdFNKMQwxQi5My+65+YVW7b86GJ
        Ivw08OPf94fo6QAsJB/jGcIyG44X+bGJ/H9q6sB4PQ==
X-Google-Smtp-Source: ADFU+vvUoUlnuc+QBhJPp+Zphd2rGyw07LcSM/dHzCQLm0j6Q1O+0HputdWdJU3Z6rEnbvLjs0RfwrkIUSOkBCmF23M=
X-Received: by 2002:a02:3b4a:: with SMTP id i10mr25473277jaf.131.1584346111516;
 Mon, 16 Mar 2020 01:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com> <20200315124955.207d515c@archlinux>
In-Reply-To: <20200315124955.207d515c@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 16 Mar 2020 01:08:20 -0700
Message-ID: <CAJCx=gk-oycno_NPtNFAvuX8ibsLEGLq0FrLvfXeaJwuvuTjcg@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: use generic property handler
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 5:50 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 13 Mar 2020 08:59:13 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> > Instead of of_property_read_xxx use device_property_read_xxx as it is
> > compatible with ACPI too as opposed to only device tree.
> >
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
>
> Look at how this driver is probing from DT.  There is another thing you need
> to do to make it possible to use PRP001 ACPI based bindings.
>
> (check what Andy Shevchenko did in a similar patch)
>
> I'm being deliberately vague as useful for you to understand what is going
> on here for yourself :)
>
> Also, make sure to check you have cc'd everyone relevant.  Here you are missing
> the driver author. +cc Matt
> Jonathan
>

Highly doubt anyone is using this in an ACPI setting. Am I missing
something though?

- Matt

> > ---
> >  drivers/iio/health/max30100.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > index 84010501762d..8249c6b36818 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mutex.h>
> > -#include <linux/of.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> > @@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
> >  static int max30100_led_init(struct max30100_data *data)
> >  {
> >       struct device *dev = &data->client->dev;
> > -     struct device_node *np = dev->of_node;
> >       unsigned int val[2];
> >       int reg, ret;
> >
> > -     ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
> > +     ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> >                                       (unsigned int *) &val, 2);
> >       if (ret) {
> >               /* Default to 24 mA RED LED, 50 mA IR LED */
>
