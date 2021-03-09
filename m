Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECA3325F8
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCINBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCINBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:01:35 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8F3C06174A;
        Tue,  9 Mar 2021 05:01:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b23so779142pfo.8;
        Tue, 09 Mar 2021 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f/geEHBBoAiW3Dly8EhvHyKwAgyyNs5zfv7AhNLqas=;
        b=ee+L/zVFUbhe5H6FYGxObrtNU5tclDl/tmicT5iTDWZKVhXLZEZjz7TUWWrq6zVQKJ
         r9scT0mt9kq2RUGAwe78xP8sz4x+vYVbnaKeiH2lmuIifhwQDC3fYJf776slcHi0mgli
         rSTm2lGC7xh+hhKAf3I0A5XSXIc+2VNIwFc3qe9Kj1RbVgU63/Xze5B5J/7ag+LWuF5M
         Rni+4OG7CwrMdvfnCGR3tZY60YigwNT61vX/j0cKzWseY947IeBywLc/QfaWcjVFTu5o
         m87/OnVvgpVwbglCLGH3d5eVu/jsFMNCJEk29F5Tb8KXLB8FKLpc7UJgVOGK3nwZh7oH
         TjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f/geEHBBoAiW3Dly8EhvHyKwAgyyNs5zfv7AhNLqas=;
        b=Tk6hqbkHZYTix6FD1w8wYMEtEyX+NFnPWGQDQQwsr/a04ElYZEM7cAgkyyeGGj+8y8
         BmYSCdIHj9OALR7G+bTvOQxYsrm3ojuFZxef3MONu7Xaf9yZqpDm/haPXgOFlTGr6I7w
         T7tl9F165YqNBpo30ka0rR99ffguARtA6BkB/+1y2/hpvLFf/lLamrhyx45w37AU7mp/
         S54mnTeUKuwO2gHQOhCqfBZLQR2vDi9K3aMtYkfiS7RtuKGCaaCoArywSB6SrAOWVGhh
         ImF50SnglYiY+rMSx5IqabHw2Vs5PkgFc/yMHsmXxnZ55Jz9QT0X9HeIlqLyDbCy+aNg
         7TBw==
X-Gm-Message-State: AOAM532bcAkk6OBPa12PUM0EzSZ5iDFYtycjKVGclz9UTpREv73xYIZk
        sZ56BFC/RpIsNe4eoXKvArhYbv+oqosnUbrzcss=
X-Google-Smtp-Source: ABdhPJwUdLIn6fUePh1YnhFyazORKQ38hwQLk+4nhXCtPMBll890NtWx0HgKE2NQ1RRXHV7H+tMQik/DmJ3BSdLtSGM=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr25235351pgf.4.1615294894854;
 Tue, 09 Mar 2021 05:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de> <20210305190239.000075fe@Huawei.com>
 <CAHp75Veu-G41mDUZubCgHD_V+_znd0HJoO03ZL7JpgwtjMYLCQ@mail.gmail.com>
 <20210309114150.lubvvtqblw2y5zlk@pengutronix.de> <CAHp75VfR2_N=krD8Rady77ST19o5vL7zChLnJ32wmx-+M1N3pg@mail.gmail.com>
 <20210309121819.yzvta7tyrslnepts@pengutronix.de>
In-Reply-To: <20210309121819.yzvta7tyrslnepts@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 15:01:18 +0200
Message-ID: <CAHp75Ve-Y1XMN1bwn4oQ5b09RVYT-9hurrcGBazdj3R-A0k-CA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046 controller
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Robin van der Gracht <robin@protonic.nl>,
        David Jander <david@protonic.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 2:18 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> On Tue, Mar 09, 2021 at 01:46:55PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 9, 2021 at 1:42 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > On Tue, Mar 09, 2021 at 01:05:27PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Mar 5, 2021 at 9:05 PM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Fri, 5 Mar 2021 14:38:13 +0100
> > > > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > > >
> > > > > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > > > > the touchscreen use case. By implementing it as IIO ADC device, we can
> > > > > > make use of resistive-adc-touch and iio-hwmon drivers.
> > > > > >
> > > > > > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > > > > > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > > > > > are working without additional changes.
> > > > > >
> > > > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > >
> > > > > Hi Oleksij,
> > > > >
> > > > > To consider this as a possible long term route instead of just making this
> > > > > a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> > > > > Of course that doesn't stop review of this in the meantime.
> > > > >
> > > > > There are quite a few things in here that feel pretty specific to the touchscreen
> > > > > usecase. That makes me wonder if this is a sensible approach or not.
> > > >
> > > > I'm wondering if this has any similarities with existing drivers under
> > > > drivers/input/touchscreen.
> > >
> > > Yes, for example: drivers/input/touchscreen/ads7846.c
> >
> > Then I have a few questions here:
> > 1/ why the above mentioned driver can't be extended to cover this?
>
> It is not possible to keep old device tree binding compatible with the
> new driver at least not for currently existing abstraction: ADC +
> touchscreen node.
>
> It is too expensive to overwrite the old driver, we do not have enough time and
> resource to do it. I lardy spend some weeks to do it and I would need a
> many more weeks to make it by tiny slices without solving actual
> problem. Many resistive touchscreen driver should share a lot of code.
>
> Since there is already existing IIO based components, it seems to me
> better to spend available resource and making it properly in a way,
> which reflect modern best practices.
>
> > 2/ or why is the proposed driver named after the touchscreen instead
> > of the real AD/C chip behind it?
>
> I do not understand this question. The proposed driver is named after
> the chip which provides ADC functionality, In this case, it is TSC2046.
> The touchscreen is a separate physical module.
>
> The idea of this proposition is to keep physically separate components
> separately on the kernel side.
>
> > 3/ maybe we can introduce a simple AD/C driver under IIO for that?
>
> There are already simple ADC drivers for that:
> iio-hwmon: drivers/hwmon/iio_hwmon.c
> resistive-adc-touch: drivers/input/touchscreen/resistive-adc-touch.c
>
> This two driver + the proposed one, will replace functionality of ads7846.c

Okay, then maybe you can elaborate all this in the cover letter to
make sure that maintainers will know why the new driver appeared
instead of modifications to the old one.

-- 
With Best Regards,
Andy Shevchenko
