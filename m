Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6625A17CE6A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCGNd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:33:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35964 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgCGNd6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 08:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583588037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTmcKME6ATPq4QuasV0jMbDnXvL8wNPLVZNJMoJ6AQw=;
        b=XL27xbqPlF0SZ3shWuSEGUme7zpaqlgmpq8dWE4XBz62Nl5D6/sEi4cFo4vsHlfR6jkJuG
        znggILjYymGxgHkAsNdA7QyrtcRhhqnOPs4pwb7eBP++jFeDU43xyZu3FkaFQUsb35cs5T
        jl4PjqjLnOWZXyHIMWVpkk8oOmFKl40=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-jcSCUIUBMgWVzZcuaIxsCQ-1; Sat, 07 Mar 2020 08:33:55 -0500
X-MC-Unique: jcSCUIUBMgWVzZcuaIxsCQ-1
Received: by mail-vs1-f71.google.com with SMTP id v10so604223vso.12
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2020 05:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTmcKME6ATPq4QuasV0jMbDnXvL8wNPLVZNJMoJ6AQw=;
        b=NVbooTYV0NZg5AK14nyj5ouCoSuGgj94CCsE3ClMNCwD+J+cj3rIDl9gdY56HLWsBy
         dXgFEFw9uGXGKcTSdRWuZu1LTrAZQ/1i/luF3/sK/DWcjy43rrVL/PHHRSLS5IDepfmf
         Wn7LQzD8jfeN8lYFmWy6F15VYwN7/3cYRPiBSmK+GKrNCwhS6rXgRqIkn+tTOqHuHDKl
         xx6+rwIL8S7aL2zLBVSLTDt0H/ha79/LvIJipEPZXr8rON8ZRG2jIN62n6pz0yLoPnfS
         l/Aoz7jFa5Ii4lCU6IYfHNBcs5uaSdoQ7SOGi1MymU8545p974Mv5IKSg+/KuJJUb6p8
         s46A==
X-Gm-Message-State: ANhLgQ1GgIBGYkQhr5Yn9Sydk3WDOHI6UwjSHhFyH94SMG6+gvgwEZgx
        P+HmtSuJpu0ZdlRzoKYtA0nBE7MVpCMSTltmdmMUUKYekbe7A8aH7criUWztkKU90GT5mfr6JBi
        bIFBGIgIoxcRE5h/n6N0XHX3c03VrDjARVbVZ
X-Received: by 2002:a05:6102:7c3:: with SMTP id y3mr668846vsg.233.1583588034781;
        Sat, 07 Mar 2020 05:33:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vswMnl82ysR1sd0Y7jeODDpt2jo/75MzVlEhXDdtBMMb/K6xe2AHcMkH7XuMjyVfDafDbQ8MK6sqQvFBMek4l4=
X-Received: by 2002:a05:6102:7c3:: with SMTP id y3mr668830vsg.233.1583588034460;
 Sat, 07 Mar 2020 05:33:54 -0800 (PST)
MIME-Version: 1.0
References: <7444ee821dd9b1210ce126c317edc3b0c36f9f84.1583090369.git.lorenzo@kernel.org>
 <20200307130232.3baf4c89@archlinux>
In-Reply-To: <20200307130232.3baf4c89@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 7 Mar 2020 14:33:43 +0100
Message-ID: <CAJ0CqmWayoApMahU63UcqO-bEygYiTwzyAyOeaRi_0CRordKig@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: disable I3C support during device reset
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        mario.tesi@st.com, vitor.soares@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Sun,  1 Mar 2020 20:28:03 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Disable MIPI I3C during device reset in order to avoid
> > possible races on interrupt line 1. If the first interrupt
> > line is asserted during hw reset the device will work in
> > I3C-only mode
> >
> > Reported-by: Mario Tesi <mario.tesi@st.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Fixes tag?

Hi Jonathan,

I am not sure since Mario just reported me this issue can occur.
Maybe this one:

2660b0080bb2 ("iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO
and LSM6DSR")

>
> One trivial thing inline.
>

ack, I will fix it (I am use to network comment syntax now :))

> Is this something we should be looking to have applied to stable?
>

Not sure.
@Vitor: have you ever faced the issue?

Regards,
Lorenzo

> Jonathan
>
> > ---
> > I have not been able to test this patch on a I3C device, just SPI/I2C
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 ++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index f2113a63721a..dfcbe7c42493 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -266,6 +266,7 @@ struct st_lsm6dsx_ext_dev_settings {
> >   * @wai: Sensor WhoAmI default value.
> >   * @reset: register address for reset.
> >   * @boot: register address for boot.
> > + * @i3c_disable:  register address for enabling/disabling I3C (addr + mask).
> >   * @bdu: register address for Block Data Update.
> >   * @max_fifo_size: Sensor max fifo length in FIFO words.
> >   * @id: List of hw id/device name supported by the driver configuration.
> > @@ -284,6 +285,7 @@ struct st_lsm6dsx_settings {
> >       u8 wai;
> >       struct st_lsm6dsx_reg reset;
> >       struct st_lsm6dsx_reg boot;
> > +     struct st_lsm6dsx_reg i3c_disable;
> >       struct st_lsm6dsx_reg bdu;
> >       u16 max_fifo_size;
> >       struct {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 84d219ae6aee..b1435c5d2d6d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -751,6 +751,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                       .addr = 0x12,
> >                       .mask = BIT(7),
> >               },
> > +             .i3c_disable = {
> > +                     .addr = 0x18,
> > +                     .mask = BIT(1),
> > +             },
> >               .bdu = {
> >                       .addr = 0x12,
> >                       .mask = BIT(6),
> > @@ -1128,6 +1132,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> >                       .addr = 0x12,
> >                       .mask = BIT(7),
> >               },
> > +             .i3c_disable = {
> > +                     .addr = 0x18,
> > +                     .mask = BIT(1),
> > +             },
> >               .bdu = {
> >                       .addr = 0x12,
> >                       .mask = BIT(6),
> > @@ -2041,6 +2049,19 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >       const struct st_lsm6dsx_reg *reg;
> >       int err;
> >
> > +     /* disable MIPI I3C during device reset in order to avoid
>
> comment syntax
> /*
>  * disable...
>
> > +      * possible races on interrupt line 1. If the first interrupt
> > +      * line is asserted during hw reset the device will work in
> > +      * I3C-only mode
> > +      */
> > +     if (hw->settings->i3c_disable.addr) {
> > +             reg = &hw->settings->i3c_disable;
> > +             err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > +                                      ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> >       /* device sw reset */
> >       reg = &hw->settings->reset;
> >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > @@ -2059,6 +2080,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >
> >       msleep(50);
> >
> > +     /* enable MIPI I3C */
> > +     if (hw->settings->i3c_disable.addr) {
> > +             reg = &hw->settings->i3c_disable;
> > +             err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > +                                      ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > +             if (err < 0)
> > +                     return err;
> > +     }
> > +
> >       /* enable Block Data Update */
> >       reg = &hw->settings->bdu;
> >       err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
>

