Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2C2B578
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE0MgC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 08:36:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52650 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfE0MgC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 08:36:02 -0400
Received: by mail-it1-f194.google.com with SMTP id t184so9283378itf.2
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2019 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFB9+5CZ80v+V8dz+uZDiruDNN+EqB5wmedpV+g8nZE=;
        b=rCs5XPHNeqXTZbHThi0dPSL28VGVYSX14Zprs5fNOE1DH8R1IxuVykKKBstECaLPU7
         6GOLVrL+NEbMGV978Hk3s/1uasIa9jFajYgK7pumwYWXQSpn/AIhnSbNnWZP93Qfn3jA
         kpowxOsmQQ7sVUcmrReGLHHmw4Nfi8pmMyexyE/nSsT6HAFkAdY1uekdXUYgQFKrrPJL
         zZMkOrxL9MqkOHIQPC0b/GsCQH9Idmr4eE+IXS2r4q/PDxbRMwP0buViBSBzotFGM8Sh
         FEHm8sWj5MwYxWv2Gfqe2Yhgc/rD0/qfhzzqM5MLnEymjxbqLERHRw7UHmQyv9B36MqT
         BCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFB9+5CZ80v+V8dz+uZDiruDNN+EqB5wmedpV+g8nZE=;
        b=sAOnlr6wvyIo7Co4z2r1ky8VYVNMxQ6GGuXglEzZXOG+99E8SdaPwfGs8b6z5IsXmc
         N439/xnJugo5bh21n1goxZp2GVbGRUzztPlvFJqyXiorzQi7lqfLKmJeb57TV2SxuDGW
         tZLpF2NQSxWh47SGjs5TuKJ8nZgRqE9Rf4lD/M3/aYrl8CmWyanO0qAvjlwvVCBy0fz7
         aGtnHyJ0VW1V4UHpKVrQg5v09Ar4WW5QBMqI/VtgNndJxGj9t1op3+ztxPwwOeR+p5ny
         kfPUbQMrnulHBrin/Q/eeAICVgw3nJrr3NwJfP6CR1fDk6oxRp5lOb3np3rgsnHoYeGW
         TaNw==
X-Gm-Message-State: APjAAAXyZd9LMcUFwVbuxKGeAi7LMruPeWZtqEl7WgUx/MlyOWJiZHEn
        HNPFJtLG2qXi0fDke4iJMCkn1EhoQJZRHVhM+di8vg==
X-Google-Smtp-Source: APXvYqxCoEMTOnK0lj+7qfYPYRlXrOR/wrO+8+nRvJqbgunSS50hLrkNsQEp6R/Se1BnluU8Q4FcdqCxqSsrKa9CY7w=
X-Received: by 2002:a02:4049:: with SMTP id n70mr77573070jaa.42.1558960560881;
 Mon, 27 May 2019 05:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523120722.25848-1-cmo@melexis.com> <20190526174817.6d59b9f6@archlinux>
 <CAKv63usGXfJYF9SXn6MaDuh1LphHUVcRcYUKhta8rqqmksaRtg@mail.gmail.com> <20190527105902.03155898@archlinux>
In-Reply-To: <20190527105902.03155898@archlinux>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 27 May 2019 14:35:24 +0200
Message-ID: <CAKv63uu2by1owdGoZkErUUh3X-Z+Rfq+LHyduE8HDhNiRQMJSg@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90632 Relax the compatibility check
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 May 2019 at 12:00, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 27 May 2019 09:40:53 +0200
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Sun, 26 May 2019 at 18:48, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Thu, 23 May 2019 14:07:22 +0200
> > > Crt Mori <cmo@melexis.com> wrote:
> > >
> > > > Register EE_VERSION contains mixture of calibration information and DSP
> > > > version. So far, because calibrations were definite, the driver
> > > > compatibility depended on whole contents, but in the newer production
> > > > process the calibration part changes. Because of that, value in EE_VERSION
> > > > will be changed and to avoid that calibration value is same as DSP version
> > > > the MSB in calibration part was fixed to 1.
> > > > That means existing calibrations (medical and consumer) will now have
> > > > hex values (bits 8 to 15) of 83 and 84 respectively. Driver compatibility
> > > > should be based only on DSP version part of the EE_VERSION (bits 0 to 7)
> > > > register.
> > > >
> > > > Signed-off-by: Crt Mori <cmo@melexis.com>
> > > Hi.
> > >
> > > I'm going to take this via the slow path as you haven't called it out that
> > > you want it applied as a fix (so for stable kernels).  Let me know if these
> > > parts are in the wild and hence we should send it earlier.   We can do that
> > > after it is in mainline anyway as a specific request to the stable maintainers.
> > Hi,
> > Since this is our change I did not think it warrants a fix label, but
> > if we could, we would be very happy, if this could go in for all
> > stable kernels. It is designed to be backwards compatible, so it
> > should not cause new problems.
> Cool. I've moved it across to the fixes-togreg branch and should do a pull
> request for that in a week or two at which point it'll get picked up
> by the stable trees.
OK, thanks.

>
> >
> > > Applied to the togreg branch of iio.git and pushed out as testing for the
> > > autobuilders to play with it.
> > >
> > > Umm. This didn't actually apply to the current tree, so I did what I think
> > > was intended by hand. Please take a look at the testing branch of iio.git
> > > and check it is correct.
> > Sorry, but togreg branch does not even have temperature subdirectory
> > inside. Can you push testing to remote as well? Summary (git kernel
> > org) still has last update 8 days ago, or are you pushing somewhere
> > else?
> Umm. togreg should definitely have a temperature subdirectory.
> I suspect this is the odd nature of the web interface for kernel.org.
> For reasons I've never understood when you browse a 'tree' of a branch
> other than master, it doesn't show the current head of that branch.
> The easiest way to get there is to click on a particular commit and
> then switch to the tree view.

It did seem like a little fishy indeed. Was bugreport for this ever filed?

>
> For the other day it seems I hit an issue with the push and didn't notice.
>
> Should be there now.
OK, checked and it is as expected.

Crt
>
> Jonathan
>
> >
> > >
> > > Applied to the togreg branch of iio.git and pushed out as testing for the
> > > autobuilders to play with it.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  drivers/iio/temperature/mlx90632.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > > > index 2243e8057ffc..2d54d9cac61d 100644
> > > > --- a/drivers/iio/temperature/mlx90632.c
> > > > +++ b/drivers/iio/temperature/mlx90632.c
> > > > @@ -81,6 +81,8 @@
> > > >  /* Magic constants */
> > > >  #define MLX90632_ID_MEDICAL  0x0105 /* EEPROM DSPv5 Medical device id */
> > > >  #define MLX90632_ID_CONSUMER 0x0205 /* EEPROM DSPv5 Consumer device id */
> > > > +#define MLX90632_DSP_VERSION 5 /* DSP version */
> > > > +#define MLX90632_DSP_MASK    GENMASK(7, 0) /* DSP version in EE_VERSION */
> > > >  #define MLX90632_RESET_CMD   0x0006 /* Reset sensor (address or global) */
> > > >  #define MLX90632_REF_12              12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> > > >  #define MLX90632_REF_3               12LL /**< ResCtrlRef value of Channel 3 */
> > > > @@ -666,10 +668,13 @@ static int mlx90632_probe(struct i2c_client *client,
> > > >       } else if (read == MLX90632_ID_CONSUMER) {
> > > >               dev_dbg(&client->dev,
> > > >                       "Detected Consumer EEPROM calibration %x\n", read);
> > > > +     } else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
> > > > +             dev_dbg(&client->dev,
> > > > +                     "Detected Unknown EEPROM calibration %x\n", read);
> > > >       } else {
> > > >               dev_err(&client->dev,
> > > > -                     "Wrong DSP version %x (expected %x or %x)\n",
> > > > -                     read, MLX90632_DSPv5);
> > > > +                     "Wrong DSP version %x (expected %x)\n",
> > > > +                     read, MLX90632_DSP_VERSION);
> > > >               return -EPROTONOSUPPORT;
> > > >       }
> > > >
> > >
>
