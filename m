Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770C63CCE8B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhGSHgH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 03:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhGSHgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 03:36:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC3C061762;
        Mon, 19 Jul 2021 00:33:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bu12so27158754ejb.0;
        Mon, 19 Jul 2021 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TIm1TRm27OD8u584vFf5/FAIcFfcqCrDwZRKQMrp8+E=;
        b=fcr3a2cvoZtesTmKOlpDO6qVC1rsr6D7gyDChuhqKjxKhzleCd2RwmD2uEOmKsaUk7
         QergnofOQVv2TIIezGqEFtI93NU7BXxTIYlv5P50wesLHbQKR3Z9TCTGdqlwdL8Hc/Qc
         c+QsRB8RKn0es6Tv1ss15vufchonedlFJC6kub6RjJVwqp6l/7WhSs+xV/Vle51mqiy4
         fdlhfkYtEqEAlskJhZAFWXrpHQuxQmPfmRpj47b5on5tHREVbIsniPrtiYsUHhBpA0z2
         keMnbgItkqxB/H8rxkhpvVHg/fw9CBQfohf4sMSfsc5Ix3ldQpkXJVoJfBo+QnB56TzA
         EC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TIm1TRm27OD8u584vFf5/FAIcFfcqCrDwZRKQMrp8+E=;
        b=aQO/0bJw6t931K/Ks+kITSuXk0GcuU5UJR9V54xi8TrXkAxnoGx7C/+VRXTs8mf/0b
         KRrZbvJJkMY/fHub/u3DqEWGGueV4rynuHMbIe9BsjCcdzJcOP8QgfBvBlVHPVrIQB17
         0ryJinzSVnXlFJ9VmaKsiZI3nMBRe3//KCQSKDecaQdJz+qo4MvIZSCtOcmuniUIzpEm
         q0s+QQydPyBU2K0mVsvrJP1jGy65dz5VoiPLRDQoC3WHfg3L3Pscyq6Vlm4XgyOaK6JA
         JBcegCJ7wI/dVIn39XtfAvhZHrNWNQhJKgDJWntLBnKX+M3o4OiYFm8RPEaeDBTZ6HWg
         nGZA==
X-Gm-Message-State: AOAM533tsDy7jgjIvgDR3J1I9xyKq6tOPKdjTgMzT/9rMK7dX03g0PrT
        kOuTvxRyYwd1yRbAIGJ8Q6PiJip0qWwvU8wl7S8=
X-Google-Smtp-Source: ABdhPJwmTXjcuWz6XUSS0BDPVjIeCIAdcRFPcTqpRK8pezxFp1u2ZfSu+Yx2jZYHYe2UFOKq+wgv7dSkezK9726LGKk=
X-Received: by 2002:a17:906:a202:: with SMTP id r2mr25521827ejy.398.1626679986549;
 Mon, 19 Jul 2021 00:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210718203746.7159-1-theobf@usp.br>
In-Reply-To: <20210718203746.7159-1-theobf@usp.br>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 19 Jul 2021 10:32:54 +0300
Message-ID: <CA+U=DspWmrWWsQDFPLycS2y-=8Q7TSn5NYMVgbQ42FccAy0=pw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: max5821: convert device register to device
 managed function
To:     =?UTF-8?Q?Th=C3=A9o_Bor=C3=A9m_Fabris?= <theobf@usp.br>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 18, 2021 at 11:42 PM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br=
> wrote:
>
> Add a device managed hook, via devm_add_action_or_reset() and
> max5821_regulator_disable(), to disable voltage regulator on device
> detach.
> Replace iio_device_register() by devm_iio_device_register() and remove
> the max5821_remove() function used to unregister the device and disable t=
he
> voltage regulator.
> Remove i2c_set_clientdata() from the probe function, since
> i2c_get_clientdata() is not used anymore.

Looks good overall.
A few comments inline.

>
> Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> ---
>  drivers/iio/dac/max5821.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index bd6e75699a63..44c04ae70b32 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -294,6 +294,13 @@ static const struct iio_info max5821_info =3D {
>         .write_raw =3D max5821_write_raw,
>  };
>
> +static void max5821_regulator_disable(void *data)
> +{
> +       struct regulator *rdata =3D data;
> +
> +       regulator_disable(rdata);

This can be simplified a bit:

static void max5821_regulator_disable(void *reg)
{
      regulator_disable(reg);
}

I used to do explicit casting, but then I also figured that it's not necess=
ary.

> +}
> +
>  static int max5821_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
> @@ -306,7 +313,6 @@ static int max5821_probe(struct i2c_client *client,
>         if (!indio_dev)
>                 return -ENOMEM;
>         data =3D iio_priv(indio_dev);
> -       i2c_set_clientdata(client, indio_dev);
>         data->client =3D client;
>         mutex_init(&data->lock);
>
> @@ -331,6 +337,14 @@ static int max5821_probe(struct i2c_client *client,
>                 goto error_free_reg;
>         }
>
> +       ret =3D devm_add_action_or_reset(&client->dev, max5821_regulator_=
disable,
> +                                      data->vref_reg);
> +       if (ret) {
> +               dev_err(&client->dev,
> +                       "Failed to add action to managed regulator: %d\n"=
, ret);
> +               goto error_disable_reg;

return ret;

devm_add_action_or_reset() should call max5821_regulator_disable() in
case of error

> +       }
> +
>         ret =3D regulator_get_voltage(data->vref_reg);
>         if (ret < 0) {
>                 dev_err(&client->dev,
> @@ -346,7 +360,7 @@ static int max5821_probe(struct i2c_client *client,
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>         indio_dev->info =3D &max5821_info;
>
> -       return iio_device_register(indio_dev);
> +       return devm_iio_device_register(&client->dev, indio_dev);
>
>  error_disable_reg:

This entire goto block should be removed.
The idea of using only devm_ functions is to not have these goto statements=
.

>         regulator_disable(data->vref_reg);
> @@ -356,17 +370,6 @@ static int max5821_probe(struct i2c_client *client,
>         return ret;
>  }
>
> -static int max5821_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -       struct max5821_data *data =3D iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       regulator_disable(data->vref_reg);
> -
> -       return 0;
> -}
> -
>  static const struct i2c_device_id max5821_id[] =3D {
>         { "max5821", ID_MAX5821 },
>         { }
> @@ -386,7 +389,6 @@ static struct i2c_driver max5821_driver =3D {
>                 .pm     =3D &max5821_pm_ops,
>         },
>         .probe          =3D max5821_probe,
> -       .remove         =3D max5821_remove,
>         .id_table       =3D max5821_id,
>  };
>  module_i2c_driver(max5821_driver);
> --
> 2.20.1
>
