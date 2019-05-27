Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996082AF7C
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfE0Hla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 03:41:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39046 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Hla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 03:41:30 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so7620026iod.6
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2019 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXCI7qVG9C9kwLZRGqNJqPjHu6+D1+Js4ZWUuzK/T7k=;
        b=fP/5kKi4WQjbRGU60zbVd7JngI/wL5ji3MP/Fg8jgj0IEXlSv/GdzM4eccBv+szNYs
         RVwh0aVXmwgz+Rg0eDM7nfpP0IEa1xB6VUP6y1g9Ahj4dUf5Tq7rOutjVGM9v3ZknfuW
         NC3S1VWSK+rpqZPEiNy7KYIFm0yHJ5PNpg1Si5q9mIFVjflFqllrEOcuR+hpcijH/EI/
         28cuVN2GsnRkc2nIY/KXpcb1T1RSodu10+ediIwdh9hrw19V0gi2WXK/ba3XZSlI6t4c
         NnBOL9DDE3rRvhMC9XFO0S/sTauaAm+CJeflzRPGCx4V7rYXEHFSVVCuwV9qZr5G3vLT
         eXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXCI7qVG9C9kwLZRGqNJqPjHu6+D1+Js4ZWUuzK/T7k=;
        b=cuMjT0Z4IG6+od7R1Q0PX7BgVZRxmT6DdLpzWByPlEd7Yn690XEoW1Aw3XJx8dz82r
         UAAGaEZ84m8xHNbGe7/QcIUOe00e8OUEhciOrRqHHNikOjSUsCD7BZqzWv2xSATPvjGd
         woA4BagvdM/vIe56J3iC+91lLBanHMDzEoiVNr5DArKaBtwGOLcdylB1yYgqQMYOBtw+
         QLqpgS+nx5Q8pO9jMkJRcp6bFxPFUqgNtHA2Pk/ubF485cahwDtFXMHIDYK4oJtEgH7+
         2X11naC8MWejf5juc2TQ+OYINY5EQKDhszML7o6wpSeCuPRyAwKzlNf5jp283fflI9tq
         1mCg==
X-Gm-Message-State: APjAAAUL7FjcgXvpThhWCVYNkP6Cc40F2A0mnhfawnUWB3cLnLqIuM0I
        1ESdlUHIpqstyLbLYsAZgrzIMKerdpciqb9h5XiqDA==
X-Google-Smtp-Source: APXvYqz/AzCkFf8Sxwx5wO6q1WsBgMC9lYCv6DdPC5VQ03JQ1I93iZ1E7wxVg9i9aYvqU3v5k+ZURJFCk4n+OtdNm5E=
X-Received: by 2002:a6b:5812:: with SMTP id m18mr1083331iob.13.1558942889514;
 Mon, 27 May 2019 00:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190523120722.25848-1-cmo@melexis.com> <20190526174817.6d59b9f6@archlinux>
In-Reply-To: <20190526174817.6d59b9f6@archlinux>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 27 May 2019 09:40:53 +0200
Message-ID: <CAKv63usGXfJYF9SXn6MaDuh1LphHUVcRcYUKhta8rqqmksaRtg@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90632 Relax the compatibility check
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 May 2019 at 18:48, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 23 May 2019 14:07:22 +0200
> Crt Mori <cmo@melexis.com> wrote:
>
> > Register EE_VERSION contains mixture of calibration information and DSP
> > version. So far, because calibrations were definite, the driver
> > compatibility depended on whole contents, but in the newer production
> > process the calibration part changes. Because of that, value in EE_VERSION
> > will be changed and to avoid that calibration value is same as DSP version
> > the MSB in calibration part was fixed to 1.
> > That means existing calibrations (medical and consumer) will now have
> > hex values (bits 8 to 15) of 83 and 84 respectively. Driver compatibility
> > should be based only on DSP version part of the EE_VERSION (bits 0 to 7)
> > register.
> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> Hi.
>
> I'm going to take this via the slow path as you haven't called it out that
> you want it applied as a fix (so for stable kernels).  Let me know if these
> parts are in the wild and hence we should send it earlier.   We can do that
> after it is in mainline anyway as a specific request to the stable maintainers.
Hi,
Since this is our change I did not think it warrants a fix label, but
if we could, we would be very happy, if this could go in for all
stable kernels. It is designed to be backwards compatible, so it
should not cause new problems.

> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
>
> Umm. This didn't actually apply to the current tree, so I did what I think
> was intended by hand. Please take a look at the testing branch of iio.git
> and check it is correct.
Sorry, but togreg branch does not even have temperature subdirectory
inside. Can you push testing to remote as well? Summary (git kernel
org) still has last update 8 days ago, or are you pushing somewhere
else?

>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/temperature/mlx90632.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 2243e8057ffc..2d54d9cac61d 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -81,6 +81,8 @@
> >  /* Magic constants */
> >  #define MLX90632_ID_MEDICAL  0x0105 /* EEPROM DSPv5 Medical device id */
> >  #define MLX90632_ID_CONSUMER 0x0205 /* EEPROM DSPv5 Consumer device id */
> > +#define MLX90632_DSP_VERSION 5 /* DSP version */
> > +#define MLX90632_DSP_MASK    GENMASK(7, 0) /* DSP version in EE_VERSION */
> >  #define MLX90632_RESET_CMD   0x0006 /* Reset sensor (address or global) */
> >  #define MLX90632_REF_12              12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> >  #define MLX90632_REF_3               12LL /**< ResCtrlRef value of Channel 3 */
> > @@ -666,10 +668,13 @@ static int mlx90632_probe(struct i2c_client *client,
> >       } else if (read == MLX90632_ID_CONSUMER) {
> >               dev_dbg(&client->dev,
> >                       "Detected Consumer EEPROM calibration %x\n", read);
> > +     } else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
> > +             dev_dbg(&client->dev,
> > +                     "Detected Unknown EEPROM calibration %x\n", read);
> >       } else {
> >               dev_err(&client->dev,
> > -                     "Wrong DSP version %x (expected %x or %x)\n",
> > -                     read, MLX90632_DSPv5);
> > +                     "Wrong DSP version %x (expected %x)\n",
> > +                     read, MLX90632_DSP_VERSION);
> >               return -EPROTONOSUPPORT;
> >       }
> >
>
