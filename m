Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAF7BE9D
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 12:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbfGaKtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 06:49:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34316 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbfGaKtK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 06:49:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id s49so30444752edb.1;
        Wed, 31 Jul 2019 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tUnV833Lm6/1yn2OaK84vuhlz85401lYVu2Fonrmp+0=;
        b=jKz1ttiMgDzl6FxSvVGtfIdxCCH2qspfRsJFlBX0ZZs3ckLFc+ieYLIWACoAM/8QxG
         gwZfGVGlX9EA0zUf4olMgId3qXrFsvlrFxWXKHvTJ1HNwO2vOf/EkBdpNtICt4jxxKo8
         0KLSTD4wjyLxj2dUQ2hSpRc3LRgLW9xeX9SOqSylyrs+F4vHzqLwSo6j4m8KoqiEYLn0
         +HQQHjZ4bBPEbI9CKAVx9NIiwYznFlJHxkceJFt6iw9eSut65by5PYSbrQTXYpBKggoE
         di8GWKUxnE41EgDnwPLA4bLqY4JXEFXOzIEnUd8shggT9IuORkT1TWl4bqkVnQ8Thqlm
         cIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tUnV833Lm6/1yn2OaK84vuhlz85401lYVu2Fonrmp+0=;
        b=Hcfdw7bLyBEstMX4Cfm25KENBHkODnwom/cFlZZz05R/GyyUInTRN5jkWwKCtgGGTK
         kwSQCtVMqM1pEe7VfT49KYkSzS7LGt9K3pWKdqyU6ffNc1wj18TjdAxVVoTgEdg4KTBB
         zOlActy23B+eN450G3GogxPjaCe4gmmLj4wYq76SIyUthFCA6GYvPIenWxZD/pUv/FWc
         hMLIv7gP1MYnaQGO6Zs7kdQ55p2ZUdoBsSQcm1Z8AU60i5/7/namGYaYKVwLntW+yOMG
         OdPaTetx4nDI191r6L5ZaaKg7gJPtQy7iM0f7l0JVVsLC9IcXJMyDT24RHMLdjKsSvLd
         27yQ==
X-Gm-Message-State: APjAAAVRcejfo6UPMQgpM2prKTPQyORoomxYJUNHyAfgWb5Qd8DMYbqu
        oTMgt/VVFNGTZPIkd0aWmaOygBtpE5pbzJ5efN0=
X-Google-Smtp-Source: APXvYqwV4srv3tqBx2s+pM8zlAsAnc5Q8QO6pEIQqv+zVbNn0leIoEcrj303xJ9kGD4a1SZfWRYQotfHlUBpidhCy2c=
X-Received: by 2002:a17:906:8317:: with SMTP id j23mr80702999ejx.51.1564570148094;
 Wed, 31 Jul 2019 03:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190731030423.8116-1-hslester96@gmail.com> <20190731094016.GB19501@onstation.org>
In-Reply-To: <20190731094016.GB19501@onstation.org>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Wed, 31 Jul 2019 18:48:57 +0800
Message-ID: <CANhBUQ2OtXPnhG+b4JY+jAdMW4+yarNxm5hvhWF-Fk5kpR4rBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: tsl2772: Use regulator_bulk_() APIs
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Brian Masney <masneyb@onstation.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Chuhong,
>
> On Wed, Jul 31, 2019 at 11:04:23AM +0800, Chuhong Yuan wrote:
> > Use regulator_bulk_() APIs to shrink driver size.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> Just a few minor nitpicks below. Overall, this is looking nice.
>
> > ---
> > Changes in v3:
> >   - Split v2 into two patches.
> >   - Add dev_err to log error messages.
> >   - Add a check for EPROBE_DEFER.
> >
> >  drivers/iio/light/tsl2772.c | 82 +++++++++++--------------------------
> >  1 file changed, 24 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> > index f1134f183be7..fd6d44297dba 100644
> > --- a/drivers/iio/light/tsl2772.c
> > +++ b/drivers/iio/light/tsl2772.c
> > @@ -134,6 +134,12 @@ enum {
> >       TSL2772_CHIP_SUSPENDED =3D 2
> >  };
> >
> > +enum {
> > +     TSL2772_SUPPLY_VDD =3D 0,
> > +     TSL2772_SUPPLY_VDDIO =3D 1,
> > +     TSL2772_NUM_SUPPLIES =3D 2
> > +};
> > +
> >  /* Per-device data */
> >  struct tsl2772_als_info {
> >       u16 als_ch0;
> > @@ -161,8 +167,7 @@ struct tsl2772_chip {
> >       struct mutex prox_mutex;
> >       struct mutex als_mutex;
> >       struct i2c_client *client;
> > -     struct regulator *vdd_supply;
> > -     struct regulator *vddio_supply;
> > +     struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];
>
> I prefer that this was named something other than 'reg'. Maybe
> 'supplies'? I know that there are a few other drivers in IIO that use
> this name.
>

I have used grep "regulator_bulk_data" in drivers/iio but find no variable
is named "supplies"...

> >       u16 prox_data;
> >       struct tsl2772_als_info als_cur_info;
> >       struct tsl2772_settings settings;
> > @@ -697,46 +702,7 @@ static void tsl2772_disable_regulators_action(void=
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
> > @@ -1804,14 +1770,21 @@ static int tsl2772_probe(struct i2c_client *cli=
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
> > +     ret =3D devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->r=
eg),
> > +                                                             chip->reg=
);
>
> This needs to be aligned with devm_regulator_bulk_get, not ARRAY_SIZE.
>
> > +     if (ret < 0) {
> > +             if (ret !=3D -EPROBE_DEFER)
> > +                     dev_err(&clientp->dev, "Failed to get regulators:=
 %d\n", ret);
>
> Add newline.
>
> Brian
