Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1341F78B34
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfG2L7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 07:59:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40546 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbfG2L7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 07:59:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so59051377eds.7;
        Mon, 29 Jul 2019 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+j8e4FiBq8A+WwerxJEg1O8cQawHRJHAffY4JApYJs=;
        b=ssAOtI1oSF4NHJ8FBiNRD034cVzgTiXWds9mOJRICUSf+Yv7y1oaxiKJ1RSYnp1Y8E
         B9VZtIqrAW5KuYb+xDuTYHhBwwIyMG91HbtAXIB+yC/9yLuTxLbhTFPumd6XRdmRJfx2
         Ge0qqOqDdcy/UhKCxFY+9rMoNAKVlhmmvoS1Hqndfd1jbRI+vwCm50V0dSFzh0f5daTY
         sA1JeYZvcTnAdN998XGkejZOq9/ur1FBt/kGLsQQgSWMvmXUQJ7AWIHQuc6IydtM9feB
         08QGct4B8ZjbDQ/1VhhwPBeoE5QoTUI/EuIcNRXAUe40pmMAm/ThFxTZOkiUlT8gTWyu
         bCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+j8e4FiBq8A+WwerxJEg1O8cQawHRJHAffY4JApYJs=;
        b=NNHWU11hLHZ8iAiTraZ0SVqv/JJZYx0HWSIx+sjwMZPnHne3WVg4RaOTOPe/D4DZI7
         r/QpjuqgpS+Di+v5p8fOdz13XPL4I2akfHurmGex380weD7fhwmXWiP7HhJR4lULm10C
         PU78aL8ziW5om9m+aJ77aAl24rs7vqWuRgVBI4fBkLc27k6HO2aeSUK+/BcLDiS+rFqC
         fbSDw/C/U22rmY93gwp659Ly5ztgnyGDuyKpAPeCfEB5taNuSHcK97bugMbc/2XE2Ie3
         qjf2SpqMBHv5o5DhDGqkgtnpgaiYf+AGd8OqwaD75dGvkA9hF8MwMi4C3NqK8IK0y6oZ
         tedA==
X-Gm-Message-State: APjAAAX3K/RVxlNDrwCTkcCuTrQzq6BH07Ap/NWo2wUMRw2ldDv0Eux0
        +h8nvpI9pFPf469utiHjg22xaM/KwPows8zB3cE=
X-Google-Smtp-Source: APXvYqwuQpIqyU9E7Ij8iYlcP1MtoLnE0apg/j3+/JhDkM68JbIZ5ExouYR6qwDlHsbHpJw8z25UMxSr9d332cmLS/U=
X-Received: by 2002:aa7:d781:: with SMTP id s1mr50459048edq.20.1564401586367;
 Mon, 29 Jul 2019 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190729100339.24054-1-hslester96@gmail.com> <20190729105912.GA2302@onstation.org>
In-Reply-To: <20190729105912.GA2302@onstation.org>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 29 Jul 2019 19:59:33 +0800
Message-ID: <CANhBUQ35QVNeROS3iBNqi3axY+xGgM=1bgJjZd_2m3yt7jH18g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: tsl2772: Use device-managed API
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Brian Masney <masneyb@onstation.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Chuhong,
>
> On Mon, Jul 29, 2019 at 06:03:39PM +0800, Chuhong Yuan wrote:
> > Use devm_iio_device_register to simplify
> > the code.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> Thank you for the patch. The patch description doesn't match what all is
> done below. This should also be broken up into multiple patches since a
> patch should only do one thing. The regulator changes should be in their
> own patch, and some of the devm changes may require multiple patches.
> When writing your changelog, if your patch description has the word
> 'and', then that may be a hint that you need to break up your patch a
> little bit. That's not always the case, but something to keep in mind.
>

Thanks for your advice.
I will split it into two patches in next version.
One is to use devm to simpliy the code.
The other is to use regulator_bulk_() to shrink driver size.

> A few minor comments below.
>
> > ---
> > Changes in v2:
> >   - Use regulator_bulk_() to shrink driver
> >     size.
> >   - Utilize more devm functions to simplify
> >     the code.
> >   - Remove several redundant functions.
> >
> >  drivers/iio/light/tsl2772.c | 116 +++++++++++-------------------------
> >  1 file changed, 34 insertions(+), 82 deletions(-)
> >
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index 83cece921843..946537c8586f 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -131,7 +131,10 @@ enum {
> >  enum {
> >       TSL2772_CHIP_UNKNOWN =3D 0,
> >       TSL2772_CHIP_WORKING =3D 1,
> > -     TSL2772_CHIP_SUSPENDED =3D 2
> > +     TSL2772_CHIP_SUSPENDED =3D 2,
> > +     TSL2772_SUPPLY_VDD =3D 0,
> > +     TSL2772_SUPPLY_VDDIO =3D 1,
> > +     TSL2772_NUM_SUPPLIES =3D 2
> >  };
>
> This is a really minor nitpick but can these either use a #define or be
> placed in its own enum block?
>

I refer to drivers/iio/adc/ad7766.c when I use regulator_bulk_().
This file puts them in the enum block.
There are also files using #define, like drivers/iio/dac/ad5064.c and
ad5449.c.
I think both of them are okay.

> >
> >  /* Per-device data */
> > @@ -161,8 +164,7 @@ struct tsl2772_chip {
> >       struct mutex prox_mutex;
> >       struct mutex als_mutex;
> >       struct i2c_client *client;
> > -     struct regulator *vdd_supply;
> > -     struct regulator *vddio_supply;
> > +     struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];
>
> Since there's other changes, maybe name this 'supplies'? I think of
> 'reg' as an address.
>

Indeed there are files choosing supplies as the name.
But in iio, all regulator_bulk_data use reg (or regs, vref_reg) as the name=
.
So I also use reg as the name to keep consistency with others.

> >       u16 prox_data;
> >       struct tsl2772_als_info als_cur_info;
> >       struct tsl2772_settings settings;
> > @@ -697,46 +699,7 @@ static void tsl2772_disable_regulators_action(void=
 *_data)
> >  {
> >       struct tsl2772_chip *chip =3D _data;
> >
> > -     regulator_disable(chip->vdd_supply);
> > -     regulator_disable(chip->vddio_supply);
> > -}
> > -
> > -static int tsl2772_enable_regulator(struct tsl2772_chip *chip,
> > -                                 struct regulator *regulator)
> > -{
> > -     int ret;
> > -
> > -     ret =3D regulator_enable(regulator);
> > -     if (ret < 0) {
> > -             dev_err(&chip->client->dev, "Failed to enable regulator: =
%d\n",
> > -                     ret);
> > -             return ret;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static struct regulator *tsl2772_get_regulator(struct tsl2772_chip *ch=
ip,
> > -                                            char *name)
> > -{
> > -     struct regulator *regulator;
> > -     int ret;
> > -
> > -     regulator =3D devm_regulator_get(&chip->client->dev, name);
> > -     if (IS_ERR(regulator)) {
> > -             if (PTR_ERR(regulator) !=3D -EPROBE_DEFER)
> > -                     dev_err(&chip->client->dev,
> > -                             "Failed to get %s regulator %d\n",
> > -                             name, (int)PTR_ERR(regulator));
> > -
> > -             return regulator;
> > -     }
> > -
> > -     ret =3D tsl2772_enable_regulator(chip, regulator);
> > -     if (ret < 0)
> > -             return ERR_PTR(ret);
> > -
> > -     return regulator;
> > +     regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
> >  }
> >
> >  static int tsl2772_chip_on(struct iio_dev *indio_dev)
> > @@ -860,6 +823,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_=
dev)
> >       return tsl2772_write_control_reg(chip, 0x00);
> >  }
> >
> > +static void tsl2772_chip_off_action(void *data)
> > +{
> > +     struct iio_dev *indio_dev =3D data;
> > +
> > +     tsl2772_chip_off(indio_dev);
> > +}
> > +
> >  /**
> >   * tsl2772_invoke_change - power cycle the device to implement the use=
r
> >   *                         parameters
> > @@ -1797,20 +1767,22 @@ static int tsl2772_probe(struct i2c_client *cli=
entp,
> >       chip->client =3D clientp;
> >       i2c_set_clientdata(clientp, indio_dev);
> >
> > -     chip->vddio_supply =3D tsl2772_get_regulator(chip, "vddio");
> > -     if (IS_ERR(chip->vddio_supply))
> > -             return PTR_ERR(chip->vddio_supply);
> > +     chip->reg[TSL2772_SUPPLY_VDD].supply =3D "vdd";
> > +     chip->reg[TSL2772_SUPPLY_VDDIO].supply =3D "vddio";
> >
> > -     chip->vdd_supply =3D tsl2772_get_regulator(chip, "vdd");
> > -     if (IS_ERR(chip->vdd_supply)) {
> > -             regulator_disable(chip->vddio_supply);
> > -             return PTR_ERR(chip->vdd_supply);
> > -     }
> > +     ret =3D devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->r=
eg),
> > +             chip->reg);
> > +     if (ret < 0)
> > +             return ret;
>
> Add a dev_err like the other error paths in probe function. Users can
> use the tracing subsystem to see why this failed but an error message
> in dmesg is much easier for users to find. Also be sure to check for the
> EPROBE_DEFER case.
>

I will do this in next version.

Regards,
Chuhong

> Brian
