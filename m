Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5919EB40
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDEMfS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:35:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbgDEMfS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 08:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586090116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ms9eBwpZszQ+U+GO/Eq3IZyA2dKsvgtIcxMRi/936Jc=;
        b=UiEP83/1IX54CCYuE2EdxHgfmj6kpWjFPCFNjhS8hEtH6mn/TNePCg4VqLiiAjCV3I83+W
        yukH7Te+xkZN2D6QWNbv6b2olHpVHb8v8ff3nM4Pq4QXdfNE1a/PKi5lrT1VLaUJyj/hrd
        FMZ2bxrztpQqyZXxWJB/nd2Hi7Jil5c=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-fAb2uRQKMpK05JmKiNFCDA-1; Sun, 05 Apr 2020 08:35:13 -0400
X-MC-Unique: fAb2uRQKMpK05JmKiNFCDA-1
Received: by mail-vk1-f197.google.com with SMTP id r141so4518786vke.10
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2020 05:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms9eBwpZszQ+U+GO/Eq3IZyA2dKsvgtIcxMRi/936Jc=;
        b=n/jLmQEHZaLc8tWCm+WvlrsxOrxeiuNOHUZp4eZWigJc2w04Ix7MDcVe84qG6S+LMi
         u0bxPQIu1NLllz2QPXzOtrq3mIX1m84iKqr7urmaT0kC1YdDvmxnZzSIUARGEPPCNWMN
         7S13/hCi8doe+aql/WdjwG/Jt7rDi3mFdd6gepGhlZ9h4JsLvCXdiYB2qcC5CDm25NeX
         mITRkyS6VdZMF5NJ9DMQnMJLQiu4jZRKWvClgOx5kYVvUxzxFHzwF9Jw2WUeSHkDLEfZ
         bQGQXyWiq5VlGvISZQL1Tkc1Q7kp/zzrSFfayGOa5zNgyhs4cs/8PQI0J4jOnaCWeS4O
         epvw==
X-Gm-Message-State: AGi0PuZ75/jOsPZ3+GMo0Syft7Npfl+5Yvy5sRzeELCCUvyohRNYC6WV
        LW3hCikAGpN6zMJP2Iyd9JYv2mGmWz0qVmiLeGvolFA+uGejdwk+zXfMaFS/Fj3YDGtKbJKj9la
        c6NCi3PopVuiK4sQXCjgI1Ak4R1h+MCwa56T0
X-Received: by 2002:a67:2fd8:: with SMTP id v207mr12205228vsv.233.1586090112835;
        Sun, 05 Apr 2020 05:35:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5fkhyJ8x950xPcLHKkSKWSzN2tXd5UUzRzNZ4z7Jbbl926qwwx+VtE42Qa8PALP9pw4bXHNSWnidrYR89VLU=
X-Received: by 2002:a67:2fd8:: with SMTP id v207mr12205219vsv.233.1586090112549;
 Sun, 05 Apr 2020 05:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <f7c16e9f25debe726645f25df6c9c18aa44f0a1f.1586082819.git.lorenzo@kernel.org>
 <20200405130724.70094f1c@archlinux> <20200405130912.5929ee08@archlinux>
In-Reply-To: <20200405130912.5929ee08@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 5 Apr 2020 14:35:51 +0200
Message-ID: <CAJ0CqmU8XFmbtbExFPMGG4BxH+gMQUG+PaVbr4-8j4vB44uJHw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: remove duplicated macro
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Sun, 5 Apr 2020 13:07:24 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sun,  5 Apr 2020 12:36:26 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > > Remove ST_LSM6DSX_REG_WHOAMI_ADDR duplicated macro and rely on ST sensor
> > > common definitions
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Applied.
>
> Actually no.  I'd rather duplicate the value than have this
> largerly unconnected driver include that header with lots of other
> stuff in it.
>
> So dropped.

actually I was thinking about it too but I guess we have the same
issue in shub for LIS3MDL so I just aligned to it:
https://github.com/LorenzoBianconi/linux-iio/blob/st_lsm6dsx_default_wai/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c#L96

Regards,
Lorenzo

>
> Thanks,
>
> Jonathan
>
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 84d219ae6aee..f3cf13b29d18 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -58,12 +58,11 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/bitfield.h>
> > >
> > > +#include <linux/iio/common/st_sensors.h>
> > >  #include <linux/platform_data/st_sensors_pdata.h>
> > >
> > >  #include "st_lsm6dsx.h"
> > >
> > > -#define ST_LSM6DSX_REG_WHOAMI_ADDR         0x0f
> > > -
> > >  #define ST_LSM6DSX_TS_SENSITIVITY          25000UL /* 25us */
> > >
> > >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> > > @@ -1364,7 +1363,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > >             return -ENODEV;
> > >     }
> > >
> > > -   err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> > > +   err = regmap_read(hw->regmap, ST_SENSORS_DEFAULT_WAI_ADDRESS, &data);
> > >     if (err < 0) {
> > >             dev_err(hw->dev, "failed to read whoami register\n");
> > >             return err;
> >
>

