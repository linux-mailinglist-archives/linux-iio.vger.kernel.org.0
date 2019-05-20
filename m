Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACB230D8
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2019 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfETKAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 May 2019 06:00:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42344 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfETKAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 May 2019 06:00:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id i2so7052960otr.9;
        Mon, 20 May 2019 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX15Iw5l1LNzMWpN9XQ1qH/8ma8DeddYURAa0CQDGzo=;
        b=OKcoO4cvjF2ftHSC7dsg/Ul+Hi416KyLId41DZpB1ZUVdu5OBRqxiajlaBo1enDJtj
         UtC4m57jqcJbDkWQEZcnRmPSDgl5y4v1mw0XFq0VC30m+cupIlwapNUq2LtPJsWo7Hev
         Yrh7oW2EVmq658mqXpyarKSJIsFjzg0jhEYGFkGLCKV9G2eeUcEI7IjGf4B+fjMHf7W6
         VXxbO1nC+qwNV1zlUkmRjqUGgSJTHusK8ZczWJZea8uBLWT6EDmn00TJGJqSzUwtpmJG
         hUkZNgm5KiY1AND0loMxy9ZK3nvRINSNK6kL4CFa6POjmL4vRU6y+wexjgmN5ak9QtDR
         NFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX15Iw5l1LNzMWpN9XQ1qH/8ma8DeddYURAa0CQDGzo=;
        b=nT9ZRzOxuoLzy6EIXJkRcSEq7tzbG3ozqkzuUD3MDEam3GNMzkPGj6+8cRpOKdQpAq
         eYfnLbWUZiBnwTcUSBSZfy/byaSVZsiVQvHpWo0X0wYToqrS1Roylk9PgPjbt6/JJ4Sd
         t7WXPkJIirEuQDNjNXynx4LykcM8g/XOjeloLWeiw3ty6t+y3M/zhEDa66rFNNuPALk8
         AYuLDrqNdTeOl5P3A6nCVQ5leXINbpK33C/pZ4DC8Kbl1MSgxZZswwMaTVAubzR2Tbwj
         5K/nDhTr3RE5AujuS/rh72eJ1bXmtxnv9dLnIPAIBriadeYhmCexoNOkhtAMpr4nntgg
         Is1g==
X-Gm-Message-State: APjAAAU4fF3lqUgiZ1M9Ur7NoG5RKS2D415j+AAB6MiGIc2FInaK6LCo
        KtXGd9R8yujdCoC4MR+gIgUOTuSWP/g23N9qL4o=
X-Google-Smtp-Source: APXvYqz2N5x3nGkR2hugHQevYNQkesoo8qoFC8kULBF8lc5blI7rZPFKy2YCUQNlROzlASwktnSlN8omgvVzeV7ITb0=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr24555676oto.224.1558346399739;
 Mon, 20 May 2019 02:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190519010456.lwq7n2e6nkqa6niz@smtp.gmail.com> <20190519112952.58142fb0@archlinux>
In-Reply-To: <20190519112952.58142fb0@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 20 May 2019 12:59:47 +0300
Message-ID: <CA+U=DsozL_a+6K-FchwU_Jv_XOP80-hubB4cvDU9N+4LXY4E6g@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:ad7150: fix threshold mode config bit
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 19, 2019 at 8:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 18 May 2019 22:04:56 -0300
> Melissa Wen <melissa.srw@gmail.com> wrote:
>
> > According to the AD7150 configuration register description, bit 7 assumes
> > value 1 when the threshold mode is fixed and 0 when it is adaptive,
> > however, the operation that identifies this mode was considering the
> > opposite values.
> >
> > This patch renames the boolean variable to describe it correctly and
> > properly replaces it in the places where it is used.
> >
> > Fixes: 531efd6aa0991 ("staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop unused poweroff timeout control.")
> > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
>
> Looks good to me.  Applied to the fixes-togreg branch of iio.git pushed out as
> as testing-fixes for the autobuilders to see if they can find anything
> we have missed.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > index dd7fcab8e19e..e075244c602b 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -5,6 +5,7 @@
> >   * Copyright 2010-2011 Analog Devices Inc.
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > @@ -130,7 +131,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
> >  {
> >       int ret;
> >       u8 threshtype;
> > -     bool adaptive;
> > +     bool thrfixed;
> >       struct ad7150_chip_info *chip = iio_priv(indio_dev);
> >
> >       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
> > @@ -138,21 +139,23 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
> >               return ret;
> >
> >       threshtype = (ret >> 5) & 0x03;
> > -     adaptive = !!(ret & 0x80);
> > +
> > +     /*check if threshold mode is fixed or adaptive*/
> > +     thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);

nitpick: i would have kept the original variable name as "adaptive",
mostly for consistency.
"adaptive" is used in other places as well;

as i recall, the fix is just oneliner in this case:

- adaptive = !!(ret & 0x80);
+ adaptive = !(ret & 0x80);


> >
> >       switch (type) {
> >       case IIO_EV_TYPE_MAG_ADAPTIVE:
> >               if (dir == IIO_EV_DIR_RISING)
> > -                     return adaptive && (threshtype == 0x1);
> > -             return adaptive && (threshtype == 0x0);
> > +                     return !thrfixed && (threshtype == 0x1);
> > +             return !thrfixed && (threshtype == 0x0);
> >       case IIO_EV_TYPE_THRESH_ADAPTIVE:
> >               if (dir == IIO_EV_DIR_RISING)
> > -                     return adaptive && (threshtype == 0x3);
> > -             return adaptive && (threshtype == 0x2);
> > +                     return !thrfixed && (threshtype == 0x3);
> > +             return !thrfixed && (threshtype == 0x2);
> >       case IIO_EV_TYPE_THRESH:
> >               if (dir == IIO_EV_DIR_RISING)
> > -                     return !adaptive && (threshtype == 0x1);
> > -             return !adaptive && (threshtype == 0x0);
> > +                     return thrfixed && (threshtype == 0x1);
> > +             return thrfixed && (threshtype == 0x0);
> >       default:
> >               break;
> >       }
>
