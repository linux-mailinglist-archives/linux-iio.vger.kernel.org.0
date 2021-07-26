Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596CF3D5363
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhGZGNj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 02:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhGZGNi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 02:13:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B5C061757;
        Sun, 25 Jul 2021 23:54:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so4855916plh.7;
        Sun, 25 Jul 2021 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wrKkarAxPgicdMg8pWDMZVq/GcN/0pbj4p14cbyKHl4=;
        b=ipHTd2oRmwgiNw8LOXIWjLvpCA1VZ/Qj584ZqE077xzNArJ7k4WUxYxOMy9IHitlke
         5LGCMqoeFJmUUbvOXVZUoPJlEjGpn93dLsVY8qC/WPI+mDWQf/cUy8c0a7HToyGA2XLc
         I44rm5W543LPAJBe1uhAeym+Lr9vkAMEuMtSfFOFp+KrsJ35z625nbop4chwCijJ91TP
         xsm+Agg2OD2UYgF8MNFvhKZNwoEJGdjNnI5xySBkCyKwzHyxx5NhPmfNd3rEvtQdgool
         CmRI/1+htI6qoMOq5YKLWKgAeBaOyT2s2k/KyYaVsCJakwLs0UK0YYQe/08W7eH8qZ4P
         W4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wrKkarAxPgicdMg8pWDMZVq/GcN/0pbj4p14cbyKHl4=;
        b=MdjDiNXQVfdextavRLKwvtw3QVVc8camjKAis/16k6sjafyomhmIb6DOuP2UOcnd0S
         qVM0W2k3MRwRCbjy1GgS8DeslH4wf618E6vu5V3THaOZJMTr3QQDRna6oHNxncXK3UIR
         ArEnKNpB9byLleaPXh0YFTjuni+2pKo1f+gMuCXPUWslxlDkkgv04gzwZszqWi8rmM6J
         u0niX4ehIxDKpTiUWsAigyvFFK4QRbv5i8JUG82l26gRk3XSK/O7sJ1eBRr2CfMaImZR
         pdsdd3NDynstmPcvBddKLanH7wbYnNXNYmo0cvXvD7orD34Wi05eu7E/cjCKikfvoJ6P
         rnZA==
X-Gm-Message-State: AOAM532kY3KkRGOkDNXJC+0FNNdnklwB7haf8sqVFtT/HDh2fcmjEX3s
        Q5WujVusDlAMVhR5G3DW+vVuAGeH9RsDi+qys18=
X-Google-Smtp-Source: ABdhPJwfLDxaZ1R0KcDhmVR4yeCx3fZz7FIe79nDVVLMBmn9+BRwAy1tj/GQqs1heJcOklgbh2srAooyKTrYnTTEgSw=
X-Received: by 2002:a17:902:8ec9:b029:12b:a69d:4146 with SMTP id
 x9-20020a1709028ec9b029012ba69d4146mr13332899plo.32.1627282446573; Sun, 25
 Jul 2021 23:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210724220159.11998-1-theobf@usp.br>
In-Reply-To: <20210724220159.11998-1-theobf@usp.br>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 26 Jul 2021 09:53:54 +0300
Message-ID: <CA+U=DsrQyDsGHDZvnfyE0n8=gdgM4ivTuFFhtw1FO_oqNW+grg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dac: max5821: convert device register to device
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

On Sun, Jul 25, 2021 at 1:06 AM Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>=
 wrote:
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
> Remove regulator_disable() calls from the probe function.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Th=C3=A9o Bor=C3=A9m Fabris <theobf@usp.br>
> ---
> Changelog:
> V1 -> V2: Removed regulator_disable() calls and goto statements
>
>  drivers/iio/dac/max5821.c | 41 ++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index bd6e75699a63..bd0b7f361154 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -294,6 +294,11 @@ static const struct iio_info max5821_info =3D {
>         .write_raw =3D max5821_write_raw,
>  };
>
> +static void max5821_regulator_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int max5821_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
> @@ -306,7 +311,6 @@ static int max5821_probe(struct i2c_client *client,
>         if (!indio_dev)
>                 return -ENOMEM;
>         data =3D iio_priv(indio_dev);
> -       i2c_set_clientdata(client, indio_dev);
>         data->client =3D client;
>         mutex_init(&data->lock);
>
> @@ -321,21 +325,29 @@ static int max5821_probe(struct i2c_client *client,
>                 ret =3D PTR_ERR(data->vref_reg);
>                 dev_err(&client->dev,
>                         "Failed to get vref regulator: %d\n", ret);
> -               goto error_free_reg;
> +               return ret;
>         }
>
>         ret =3D regulator_enable(data->vref_reg);
>         if (ret) {
>                 dev_err(&client->dev,
>                         "Failed to enable vref regulator: %d\n", ret);
> -               goto error_free_reg;
> +               return ret;
> +       }
> +
> +       ret =3D devm_add_action_or_reset(&client->dev, max5821_regulator_=
disable,
> +                                      data->vref_reg);
> +       if (ret) {
> +               dev_err(&client->dev,
> +                       "Failed to add action to managed regulator: %d\n"=
, ret);
> +               return ret;
>         }
>
>         ret =3D regulator_get_voltage(data->vref_reg);
>         if (ret < 0) {
>                 dev_err(&client->dev,
>                         "Failed to get voltage on regulator: %d\n", ret);
> -               goto error_disable_reg;
> +               return ret;
>         }
>
>         data->vref_mv =3D ret / 1000;
> @@ -346,25 +358,7 @@ static int max5821_probe(struct i2c_client *client,
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>         indio_dev->info =3D &max5821_info;
>
> -       return iio_device_register(indio_dev);
> -
> -error_disable_reg:
> -       regulator_disable(data->vref_reg);
> -
> -error_free_reg:
> -
> -       return ret;
> -}
> -
> -static int max5821_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> -       struct max5821_data *data =3D iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       regulator_disable(data->vref_reg);
> -
> -       return 0;
> +       return devm_iio_device_register(&client->dev, indio_dev);
>  }
>
>  static const struct i2c_device_id max5821_id[] =3D {
> @@ -386,7 +380,6 @@ static struct i2c_driver max5821_driver =3D {
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
