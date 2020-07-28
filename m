Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA2F2311C7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgG1Sck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgG1Scj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:32:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE826C061794;
        Tue, 28 Jul 2020 11:32:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so12460916pgc.5;
        Tue, 28 Jul 2020 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CJZdiTv9YjW5gmkn7MZ3onrZp2HvYjHfrFhdh1hacc=;
        b=GXR+wOlgxjJHTTlAsjSNyBWwI67JSO5Goy9s9gzQSRj3GA55xgDpw0wTHqk6fQRShk
         rs4oprTE6N6/KGedLmiXuv0tdepVZqEQGj7P4HIwYZSk5toaK3CfQH78TAgqSh19ghse
         DmhLzczBwCOqwmN7ZPNYRfyis2wWM78LZfWZUxug2zVsYgdK3I7U40bsJDgegQA9K/uA
         G3Xhlm7YyOqUwYEhWDTCcqIHPWzcRfhsPN6BgoDmdh5B3FGnOLPOHXITxo8PxfQQaSrP
         rk5VQxbyui4QJPC9ZyFwAFnirjidLNDn010PCIQYLOIwMoLshmsvEvqgtdRfcfnrbJ1n
         WyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CJZdiTv9YjW5gmkn7MZ3onrZp2HvYjHfrFhdh1hacc=;
        b=qD0Rja0S8eRFn/oT8fdz3pskCuWlYIhx2l5C42sIEKA6RqkJS+wpqTZInwDd+GmK8C
         U5GMey7B1tYZFJmcyqUR2AT3BW+enJdjiKapuHeIzglr8XLOHwPFBxFyponajo/kphIZ
         aSDgl+yrODaThM50cLjVD8GuO+GvHsIuwxX0BYV/tb8pP6k+OylljozC4Gt1W/sNeFt4
         FZTQKzNUXA/a8r1qH4occuAWMbwl3x9uLUWDXvdj6dpJsuUkAnZZf+GHvpGgD6ayCJsE
         l8KefM/bKTXQWWqSkQ6utMOsIaf+wU0YaaNTG16LFxl4ftT/P4I8d3Zv44rib74bofch
         8qrQ==
X-Gm-Message-State: AOAM532MIg+95qf2EaWDa915h9j8+V8QbKlzRmkQobAsNOC6T9soDsqZ
        5genwhU04g8ICpRLIeHpK517k/ltDtzjUoFX0vwadTDl3Zo=
X-Google-Smtp-Source: ABdhPJyzqp0OZvelN5rU3slTQ04M1PavIytmSAd91VE5xBLhL5DeXjaBZbXWcCxv7h9tvhtgI4kMhPhqJJHuzlBotzg=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr26272462pgi.203.1595961158424;
 Tue, 28 Jul 2020 11:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.13.I14600506d0f725bf800c8da4ef89fdb3c3fb45cd@changeid>
 <CAHp75VdSxkgd-+CBTNUJD+WUdOX3e1x3Ysap=D9+33Yo1Kk+yA@mail.gmail.com> <855ea08a4c41bc107f88699230309675bd9075b0.camel@perches.com>
In-Reply-To: <855ea08a4c41bc107f88699230309675bd9075b0.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:32:22 +0300
Message-ID: <CAHp75VcyZohv3SoGZ5OoMafzVuRDL7ih85zXBZwHPMsXwoaxJg@mail.gmail.com>
Subject: Re: [PATCH 13/15] iio: sx9310: Add newlines to printks
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 9:24 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2020-07-28 at 21:19 +0300, Andy Shevchenko wrote:
> > On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
> > > From: Stephen Boyd <swboyd@chromium.org>
> > >
> > > Printks in the kernel have newlines at the end. Add them to the few
> >
> > Printk()s
> >
> > > printks in this driver.
> >
> > printk()s
>
> Random kernel pedantry.
> This patch should not need to be respun for any of these.

If for above I can agree with you, below is definitely subject to improvement.

>
> > > Reviewed-by: Daniel Campello <campello@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > Signed-off-by: Daniel Campello <campello@chromium.org>
> >
> > It has ordering issues
> > Should be
> >
> > Fixes:
> > SoB: Stephen
> > Rb: Douglas
> > Rb: Daniel
> > SoB: Daniel
> >
> >
> > > ---
> > >
> > >  drivers/iio/proximity/sx9310.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > > index 3f981d28ee4056..4553ee83a016a3 100644
> > > --- a/drivers/iio/proximity/sx9310.c
> > > +++ b/drivers/iio/proximity/sx9310.c
> > > @@ -809,7 +809,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
> > >         if (ret) {
> > >                 if (ret == -ETIMEDOUT)
> > >                         dev_err(&data->client->dev,
> > > -                               "0x02 << 3l compensation timed out: 0x%02x",
> > > +                               "0x02 << 3l compensation timed out: 0x%02x\n",
> >
> > Looks like ping-pong style in the series, i.e. you may fix this when
> > you introduced this line.
> >
> > Check the rest (and not only printk()s) for the similar style and
> > avoid the latter.
> >
> > >                                 val);
> > >                 return ret;
> > >         }
> > > @@ -855,7 +855,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
> > >
> > >         ddata = (uintptr_t)device_get_match_data(dev);
> > >         if (ddata != whoami) {
> > > -               dev_err(dev, "WHOAMI does not match device data: %u", whoami);
> > > +               dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
> > >                 return -ENODEV;
> > >         }
> > >
> > > @@ -867,7 +867,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
> > >                 indio_dev->name = "sx9311";
> > >                 break;
> > >         default:
> > > -               dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> > > +               dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
> > >                 return -ENODEV;
> > >         }
> > >
> > > @@ -896,7 +896,7 @@ static int sx9310_probe(struct i2c_client *client)
> > >
> > >         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
> > >         if (ret) {
> > > -               dev_err(dev, "error in reading WHOAMI register: %d", ret);
> > > +               dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
> > >                 return ret;
> > >         }
> > >
> > > --
> > > 2.28.0.rc0.142.g3c755180ce-goog
> > >
> >
> >
>


-- 
With Best Regards,
Andy Shevchenko
