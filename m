Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046C4115EE1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 23:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLGWFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 17:05:39 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44980 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfLGWFj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Dec 2019 17:05:39 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so9391134iln.11
        for <linux-iio@vger.kernel.org>; Sat, 07 Dec 2019 14:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ha1rPLXByHjbI/Rdv0mMvBd3I0OoxBgZeMc8cwP1z58=;
        b=UpxQvWlXUxNkhbbJheb3kG2NEZ8BPS2ACPvEs56e8KwY1WUkgIVGwavLJPXSKgWf7p
         NrC0LS/lbEKA5PKLTZkoVTe3FoUhS8KRXHikVt2yAVt9+HE9GYjlIGi/MfGXUfziMyb+
         me3TtasKUFXER5XH97mO4KA9ZMRHzZx1YYUZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ha1rPLXByHjbI/Rdv0mMvBd3I0OoxBgZeMc8cwP1z58=;
        b=nWYFdQkm5QZjK58lKmvjQPvHFcyAJv88w8Cwihb+Be9stZrax9TqN+3SSKdFz4cC+/
         pL+SGCF2p6SAULw6SEA8msEuhByR9yLbWC+cAoZTX4OwuyM4w41QfAPw2n8UFCPTBXmw
         jd6NlfLD+HZHf+p1BumPhBDxHGnTV8uQ2+f9+CBVJ2PLJdmVBK23tPPak9wIF9wLASsF
         DFt+BaNk92SCvKyXGswPTB76NWISYUhfiqIheyKUgxDU4qfxDiOb8+oWIGr4SAnFs6Bv
         jAZ2bpmC+hfX/GzmJFErpJ96udl8tM/d1gd5ZKJFBrYgcH9F4GuyQnMt0CLqbHgplYyL
         BWhA==
X-Gm-Message-State: APjAAAWHjnG08qJ0TkhXgR7/rCV0iwzVT/zcq36SX7B/FRYPMZdLLULQ
        dbMvCfRF7N8VMq7OteEukOKi9WAEBTiRsGnjGDeT7w==
X-Google-Smtp-Source: APXvYqxrdiX1mc5vjyeJIkpnBUbJJue/nlHm8xiM7aEzDyndQzG4xO7clLvalAWpF921eoiwPdixDPJ2or1Cj2JFy/g=
X-Received: by 2002:a92:bf10:: with SMTP id z16mr2269459ilh.87.1575756337693;
 Sat, 07 Dec 2019 14:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20191202091837.82150-1-linus.walleij@linaro.org> <20191207101654.66c807cf@archlinux>
In-Reply-To: <20191207101654.66c807cf@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 7 Dec 2019 14:05:26 -0800
Message-ID: <CAJCx=gm-tYWVyudUjhY6eqJnCf9XPmv22MGuDMk=_ct-6nhu6w@mail.gmail.com>
Subject: Re: [PATCH] iio: atlas-ph-sensor: Drop GPIO include
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 7, 2019 at 2:16 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon,  2 Dec 2019 10:18:37 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > The driver includes <linux/gpio.h> yet fails to use symbols
> > from any the header so drop the include.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> +CC Matt
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to do something or other.
>

Looks good to me. Probably too late for a Reviewed-by, but here it is anyway

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> > index 6c175eb1c7a7..b7c20c74239b 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -14,7 +14,6 @@
> >  #include <linux/err.h>
> >  #include <linux/irq.h>
> >  #include <linux/irq_work.h>
> > -#include <linux/gpio.h>
> >  #include <linux/i2c.h>
> >  #include <linux/of_device.h>
> >  #include <linux/regmap.h>
>
