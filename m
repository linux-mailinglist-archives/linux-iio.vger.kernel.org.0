Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1C64F5B8
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFVMXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 08:23:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46878 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVMXX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2019 08:23:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id z197so3876387ywd.13
        for <linux-iio@vger.kernel.org>; Sat, 22 Jun 2019 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T9L9ixhOyb1JJm5y6IcoxX4+XTrjiWSI5rJmn9mvaXM=;
        b=ibflR9p+KaXz5eBpH6I1b7tNRbUzVtKj01mpF/zF18CHt8YkCSFQYA8+wrJOTN52yJ
         vt/SbNM+BRFI5NzDWmlJyIvwfcrh5n2zLJflzxRJjGs2AeJIzGPAwgU/8PGJ7iVQjUvK
         Weftb74sB7XYS1GB8W/wsKO9B2MiqXRmpQ7xu9QReoaL7jnTme0K2TjYQJ84oGzV/qJ4
         pVQ7FllujR9MkDOHznPBOM9HDrjwPRJan03oT57ljLYHWdQGOd122WCPDS4ofF7PjguK
         wn50T5h8H3R85vgMWDuxpnirdOGNhPyFETpdGcgGTasR6BVPyI6TjCDGEoF2h+Ot1hCX
         R3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T9L9ixhOyb1JJm5y6IcoxX4+XTrjiWSI5rJmn9mvaXM=;
        b=uX3yb+KD2oGmcOEQyvEJmyK9r2/qlINDtlK+vpydo0GGEchCo8mWTvyrBiXL5MnWnc
         55tuE9oW2n8Hf89uqJInjvI9olp3Ry6iBGd6XgClZrAg1lzgbpRzXPHs0Amw8KEJyimR
         OqV2f9u1XfZDuZ6GLXkrPCQmlLGLoQFyvdCJ1bhpQkBg3V5MMm3ivZmYQUhI2TP5Vtrb
         bk4AgQlqCeKZMP76z8fQo4EI1Cmw5XJbcANUHqLguEfkP2E6dBs5HF6OcnLhgdzDEn4U
         +gPnjQiuQHUwmLvCrxsrPvYVg+T49/Y+EGiXDHRAQxRtmpLkOzPt3OZ/mzSy4jVa0BZ8
         gLSQ==
X-Gm-Message-State: APjAAAXPn5gxFe8vIJt4jn1Una1Y/5sQLVnlfV4LOUtgG7oOXrDMBZDo
        D/hnt3Xj0cSpBsLVKyit3RO+KQR7Sm6QOrYcniQ=
X-Google-Smtp-Source: APXvYqwTgQJMGY1Gbia/1zxXZr3QqCqbSmLcE83IIkv3wjbjea3ivmZFNdXTBYcp6LSJ5Q0uQ7yv6KnFRL6i809hla8=
X-Received: by 2002:a81:195:: with SMTP id 143mr65624217ywb.147.1561206202268;
 Sat, 22 Jun 2019 05:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190618125939.105903-1-sean@geanix.com> <20190618125939.105903-5-sean@geanix.com>
 <20190618155527.GD20044@localhost.localdomain> <3c1f1f3c-7de8-160a-a5bf-b9abfca78d50@geanix.com>
 <20190618202413.GB930@localhost.localdomain> <20190622105527.6ed23da3@archlinux>
In-Reply-To: <20190622105527.6ed23da3@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Sat, 22 Jun 2019 14:23:11 +0200
Message-ID: <CAA2SeN+ctjsxh4kshKGGpGCqu8yf7Ou78CTz0X-iMnXhuFvzzg@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        martin@geanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Tue, 18 Jun 2019 22:24:14 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On Jun 18, Sean Nyekjaer wrote:
> > >
> > >
> > > On 18/06/2019 17.55, Lorenzo Bianconi wrote:
> > > > > The interrupt source can come from multiple sources, fifo and wak=
e interrupts.
> > > > > Enter interrupt thread to check which interrupt that has fired.
> > > > >
> > > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > > > ---
> > > > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++=
++-----
> > > > >   1 file changed, 23 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > index 59a34894e495..76aec5024d83 100644
> > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > @@ -78,6 +78,12 @@
> > > > >   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR      0x24
> > > > >   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR      0x26
> > > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR                0x1B
> > > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK   BIT(0)
> > > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK   BIT(1)
> > > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK   BIT(2)
> > > > > +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK     BIT(4)
> > > > > +
> > > > >   #define ST_LSM6DSX_REG_TAP_CFG_ADDR           0x58
> > > > >   #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK    BIT(7)
> > > > >   #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK  GENMASK(6, 5)
> > > > > @@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6ds=
x_hw *hw)
> > > > >   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *privat=
e)
> > > > >   {
> > > > > -       struct st_lsm6dsx_hw *hw =3D private;
> > > > > -
> > > > > -       return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> > > > > +       return IRQ_WAKE_THREAD;
> > > >
> > > > I guess this will break shared interrupt, isn't it?
> > >
> > > When you write shared interrupt you mean: the drdy-int-pin stuff?
> > > I need to add so we can use all this functionality with the INT2 as w=
ell...
> >
> > nope, shared IRQ line with other devices (when you set drive-open-drain=
 dts
> > property)
>
> It's been a while since I looked at this, but...
>
> It shouldn't be broken.  When using shared interrupts, all interrupt hand=
lers
> tend to get run, whether or not a given one return IRQ_NONE.
>
> Nothing stops multiple devices setting their interrupt lines at the same
> time.
>
> See __handle_irq_event_percpu in kernel/irq/handle.c which is probably
> the right code. No return values are taken notice of until all registered
> handlers have run.

Ops, right. I do not know why I was thinking returning IRQ_NONE stops
the iteration over action list.
Thanks for pointing it out :)

Regards,
Lorenzo

>
> Jonathan
>
> >
> > >
> > > >
> > > > >   }
> > > > >   static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *pri=
vate)
> > > > >   {
> > > > >         struct st_lsm6dsx_hw *hw =3D private;
> > > > > -       int count;
> > > > > +       int count =3D 0;
> > > > > +       int data, err;
> > > > > +
> > > > > +       if (hw->enable_event) {
> > > > > +               err =3D regmap_read(hw->regmap,
> > > > > +                                 ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR=
, &data);
> > > > > +               if (err < 0)
> > > > > +                       goto try_fifo;
> > > >
> > > > You can simplify this just doing something like:
> > > >
> > > >           if (err < 0 && !hw->sip)
> > > >                   return IRQ_NONE;
> > > >
> > > Will apply :-)
> > >
> > > Thanks for the review Lorenzo...
> >
> > Thanks for working on this :)
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > --
> > > Best regards,
> > > Sean Nyekj=C3=A6r
> > > Embedded Linux Consultant
> > >
> > > +45 42427326
> > > sean@geanix.com
> > >
> > > Geanix ApS
> > > https://geanix.com
> > > DK39600706
>


--=20
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
