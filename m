Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07B4828E3
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiABBOu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Jan 2022 20:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiABBOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Jan 2022 20:14:50 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375EC061574
        for <linux-iio@vger.kernel.org>; Sat,  1 Jan 2022 17:14:49 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e128so36570722iof.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Jan 2022 17:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcXyh7XmBRx3yvGMyxEOjGfzWyKBmIbtugkjX8jJClE=;
        b=Y8jVuUCFoUO7bKV6czxt+/BMI0lKgmeTfm029/sZeu6s5HEzWnYahNZuX8FZD0j6lM
         2r/D0Xdsc/c0zevcCiKqlIfuLN0b98ZsSx4eZSUU1nK0+ztSE/l7DUJVeiKxNWoR1WNF
         F+tTF61Vea0LwR1m6A3jQQQWFPzpLWM9lXz/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcXyh7XmBRx3yvGMyxEOjGfzWyKBmIbtugkjX8jJClE=;
        b=QGfULMlYyz3gv23QiOrRNUx977jjO4SIO1shSWJ0AfC5vCFu4TdD+HIIlLxVC2Y0Yz
         bDxYb6Qi4lYTv5Ps3S4HEo3UyzPgAV12ggO2rdr11vZWHAp4WoCo/sodNZKsTNiGTyH6
         1edxY83YYqm9c49Mg/PwRvwMWzOjKASC7j7+gPAHTO7bswMd0KE0eOzFFsXh6vhRnEvD
         q5FTPVfWG+cpGWnInPtBcEaecOo8/synPh0ZVOH9EB2ZpxP5vn9ZPCZ/ceCuG4DZDICY
         XWzCT+2yZm63d1DfhAtmpmS8O4nTk+475l+cyTgBYUd07CvdgGGadHQ1O+5DTXVK/85r
         Flmg==
X-Gm-Message-State: AOAM532HRxSMO1+SUtwEo1InulOIEoKRNJJHQxxcBhWJVbA8/VXSwCmQ
        Osi9veSMfBrMcePBTGDE8vfhEWDmqCphfmoQsCgcqBh74ME=
X-Google-Smtp-Source: ABdhPJze1UZhSiPJ1R2NmjamOOtpKUSK3HEJtBS63Uyr378Eow/hAnGltL1hcfQNT+7c7cQPVFJiS429xVOqyTjgDJE=
X-Received: by 2002:a05:6638:23a:: with SMTP id f26mr18590239jaq.222.1641086088283;
 Sat, 01 Jan 2022 17:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20211218001755.3096807-1-gwendal@chromium.org>
 <20211218001755.3096807-3-gwendal@chromium.org> <CAHp75Vf_4nRXZ66_EwLU+wrK278Hb+z3ZOtRnQ_1PqCQ_Mcceg@mail.gmail.com>
 <20211221124536.5250d5a3@jic23-huawei>
In-Reply-To: <20211221124536.5250d5a3@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 1 Jan 2022 17:14:37 -0800
Message-ID: <CAPUE2utK7=iryp94_ZFfZtaqQGqzs7x_Vj1xJ4OZVLBcPkL7Pg@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 21, 2021 at 4:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 Dec 2021 15:54:05 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
I am sorry, I forgot your comments. I submitted a v10.
>
> > On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> > >
> > > Before adding new Semtech sensors, move common logic to all Semtech SAR
> > > sensor in its own file:
> > > - interface with IIO subsystem,
> > > - interrupt management,
> > > - channel access conrol,
> > > - event processing.
> > >
> > > The change adds a bidirectional interface between sx93xx and sx_common.
> >
> > ...
> >
> > > +/* All Semtech SAR sensor have IRQ bit in same order. */
> >
> > sensors
> > in the same
done
> >
> > ...
> >
> > > +EXPORT_SYMBOL_GPL(sx_common_events);
> >
> > Here and in other places, can we switch to NS variants of the
> > EXPORT_SYMBOL_GPL()?
done
>
> We haven't yet done this for similar cases, but I agree it is
> definitely a nice to have when we have a helper / core module
> like this.  Given the editorial stuff in here means Gwendal
> is going to be rolling a v9 this seems a good time to start.
>
> As time allows we'll look to convert over similar modules in the
> general interests of reducing namespace pollution.
>
> Ultimately I'd like to move the IIO core to a namespace as well
> but that is a messy job and there are several things ahead of
> if that will cause mass driver churn.
>
> Jonathan
>
>
> >
> > ...
> >
> > > +/**
> > > + * sx_common_probe() - Common setup for Semtech SAR sensor
> >
> > > + *
> >
> > Here and in all similar cases, remove this redundant blank line.
Done.
> >
> > > + * @client:            I2C client object
> > > + * @chip_info:         Semtech sensor chip information.
> > > + * @regmap_config:     Sensor registers map configuration.
> > > + */
> >
> > ...
> >
> > > +#include <linux/types.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/types.h>
> > > +#include <linux/regulator/consumer.h>
> >
> > Perhaps grouped and ordered?
> >
> > + blank line.
Done
> >
> > > +struct device;
> > > +struct i2c_client;
> > > +struct regmap_config;
> > > +struct sx_common_data;
> >
> > ...
> >
> > > + * @num_channels:      Number of channel/phase.
> >
> > channels or phases
In IIO architecture, the sensor presents X channels. Buf in Semtech
datasheet, they are named phases. Settle on channel, with an
explanation at the first occurence.
> >
> > ...
> >
> > > + * @buffer:            Bufffer to store raw samples.
> >
> > Buffer
Done
> >
> >
>
