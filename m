Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBA630C3E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Nov 2022 06:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiKSFrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Nov 2022 00:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKSFrb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2022 00:47:31 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845286FF8
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 21:47:29 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id x21so4906985qkj.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 21:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZOXhgkj3BopNzHd9HsbJwnz5C6DaHXuD1+BUUU30d0=;
        b=VyQfX5pAcud5ba/28F0SzDxhF7cb02KWv+OU80Mj5NQyQRhPMOTEYkjas2OtlFXlSW
         IjkptHLmG7RwqyX06+OmZ5G2a/B3Mz156vrmXlwPFVfT6lSjgDybR/T8V5YGt2DAa0T+
         xzGvOLMHPjXU1C3JdSOWs0Lvytm9RJDPtDWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZOXhgkj3BopNzHd9HsbJwnz5C6DaHXuD1+BUUU30d0=;
        b=jfJaRjRuWdHl+zcL1YYniQ9/H9etcHjKrFBjOHHAmYAlZlE6X+fGpW4Trttntw4w/r
         dpy0pgufve531Sg/OUp0Ey6hcubXft25LM4fjDgjRscKQZjAf0Xhjt8IRdu22Z4MJBYm
         2/4L4jvKva2hkHZ6GQdJ7QfIpTwBDStVnn5uyVfcJvq2VUwIe+JJ4iQ4sGsqFxHnfjrl
         oJLdreW68fD6+IDAAeu2HMu/TfaBndqzZn6xl1KLmKI3YKb4m52bKk3ggfP97T+Avror
         E6TivVtZYfBFseTU5GQwSOcqUAD6qSs+zy0oDOu/5oyDBVQyrDYBUaDco0WR/BE5wLEd
         xrRA==
X-Gm-Message-State: ANoB5pmL22piqeVRRuiV2Zqwj+5IgnRh1feMNYdl85UlxcAAXwmBglgV
        +iEhty3ctAeWNw2I7n/+gLcHWQjwc34RZjeiVtl8OQ==
X-Google-Smtp-Source: AA0mqf61Jw3oVURSobA8PIqKUHyViovO3OTBuBgHFmFoKe8IEwgWeJJXCRhckxcj91YaBcoDZc6THxy9ow+YD5jQwyg=
X-Received: by 2002:a05:620a:3d9:b0:6fa:5091:7ac8 with SMTP id
 r25-20020a05620a03d900b006fa50917ac8mr8592215qkm.372.1668836848820; Fri, 18
 Nov 2022 21:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org> <20221118224540.619276-118-uwe@kleine-koenig.org>
In-Reply-To: <20221118224540.619276-118-uwe@kleine-koenig.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 19 Nov 2022 13:47:17 +0800
Message-ID: <CAJCx=g=WS=GeEMZ6U_Yk+JAnjYQ95mYk3rk9tB_dskoPxGNq0A@mail.gmail.com>
Subject: Re: [PATCH 117/606] iio: light: apds9960: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?Q?Alejandro_Concepci=C3=B3n_Rodr=C3=ADguez?= 
        <asconcepcion@acoro.eu>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 19, 2022 at 6:46 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so i=
t
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Looks good to me.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/light/apds9960.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a585ce0c122f..cc5974a95bd3 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -988,8 +988,7 @@ static int apds9960_chip_init(struct apds9960_data *d=
ata)
>         return apds9960_set_powermode(data, 1);
>  }
>
> -static int apds9960_probe(struct i2c_client *client,
> -                         const struct i2c_device_id *id)
> +static int apds9960_probe(struct i2c_client *client)
>  {
>         struct apds9960_data *data;
>         struct iio_dev *indio_dev;
> @@ -1132,7 +1131,7 @@ static struct i2c_driver apds9960_driver =3D {
>                 .pm     =3D &apds9960_pm_ops,
>                 .acpi_match_table =3D apds9960_acpi_match,
>         },
> -       .probe          =3D apds9960_probe,
> +       .probe_new      =3D apds9960_probe,
>         .remove         =3D apds9960_remove,
>         .id_table       =3D apds9960_id,
>  };
> --
> 2.38.1
>
