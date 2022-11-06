Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433EE61E066
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 06:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKFFmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 01:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKFFmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 01:42:38 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C556350
        for <linux-iio@vger.kernel.org>; Sat,  5 Nov 2022 22:42:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l2so5402976qtq.11
        for <linux-iio@vger.kernel.org>; Sat, 05 Nov 2022 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XKiNifNWG+wErvX2uuDV6twa3mPicFGi8Hs3Qkm944=;
        b=jl8xJR7hTery/iIZb7aeFZPgCibbkYYkWLiFUxImoFKetBbuvxAU/Zg8MFWn6tEVle
         39Fx9aPhCVJiKmidsCBS3YI0kg3C0SKsikW72hhuwxRSDQGvRQZpSi+YnlwRcsFhmZ94
         fxqw7boDjCvJImFBQeXuiHgJ1RFXpNBKu4Mm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XKiNifNWG+wErvX2uuDV6twa3mPicFGi8Hs3Qkm944=;
        b=MJuo3UJv5NETxDdstV2nlMXpEQt800ih8zAU7/jnHjW3AueUe5X7n00sE47VXjNO4a
         sXKLsXX3YQrSyuSoWV0kOL5tTC7Wa8J9KzLsbCrvEYaM2QD5AxuoL7y4JakUvBFE03Dz
         r7t1uatHepjarhCtpO9IQ+piITYYX9AvtQEqvmJF+aSQhtYjEr6yG7VmdKe3LA0PHH0r
         GpepDeNj1Krr4+Ek2dJmHqaO7+b8jeZJHHO5wkgQ2XKShciVMBbe/tnJPW0fKmU7P5PS
         Pb4P9wVtdQ/MpwlbEl98Dv66Cuk1LI08zSTPJZZDOHX0lx62FjRRWF+i2OHK1UhowfMi
         kiiw==
X-Gm-Message-State: ACrzQf18CUQCTGD/2xvJxJcT8RYoI7c4CVH5au5KD4bDgdPP1/X6ONpM
        W24Pq52oqZMsImrp4zN0F5SkLCeEZ4z2oishLPqy6A==
X-Google-Smtp-Source: AMsMyM60GVcIbrSWQGw8G+ArN5BBJAOrUNhBjgP/HNETYLXvJKb3hOKdcmoKrIJg495KYVkJDPwVyouFaqpaJCZibGs=
X-Received: by 2002:a05:622a:553:b0:3a5:613e:263f with SMTP id
 m19-20020a05622a055300b003a5613e263fmr10443626qtx.453.1667713355762; Sat, 05
 Nov 2022 22:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <EaT-NKC-H4DNX5z4Lg9B6IWPD5TrTrYBr5DYB784wfDKQkTmzPXkoYqyUOrOgJH-xvTsEkFLcVkeAPZRUODEFI5dGziaWXwjpfBNLeNGfNc=@acoro.eu>
In-Reply-To: <EaT-NKC-H4DNX5z4Lg9B6IWPD5TrTrYBr5DYB784wfDKQkTmzPXkoYqyUOrOgJH-xvTsEkFLcVkeAPZRUODEFI5dGziaWXwjpfBNLeNGfNc=@acoro.eu>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 6 Nov 2022 13:42:24 +0800
Message-ID: <CAJCx=gk0j-PT56yea_dEAT3=uBAfMebgvHf8D4yT9f7_4YAQhQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: fix wrong register for gesture gain
To:     =?UTF-8?Q?Alejandro_Concepci=C3=B3n_Rodr=C3=ADguez?= 
        <asconcepcion@acoro.eu>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
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

On Sun, Nov 6, 2022 at 9:56 AM Alejandro Concepci=C3=B3n Rodr=C3=ADguez
<asconcepcion@acoro.eu> wrote:
>
> Gesture Gain Control is in REG_GCONF_2 (0xa3), not in REG_CONFIG_2 (0x90)=
.
>
> Fixes: aff268cd532e ("iio: light: add APDS9960 ALS + promixity driver")
>

Good find. Odd that nobody ran into that issue before :/

NOTE: Sorry for the double emails to some.. seems gmail dropped my
Plain Text default setting and set it to HTML *sigh*

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
> ---
>  drivers/iio/light/apds9960.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index b62c139baf41..38d4c7644bef 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -54,9 +54,6 @@
>  #define APDS9960_REG_CONTROL_PGAIN_MASK_SHIFT  2
>
>  #define APDS9960_REG_CONFIG_2  0x90
> -#define APDS9960_REG_CONFIG_2_GGAIN_MASK       0x60
> -#define APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT 5
> -
>  #define APDS9960_REG_ID                0x92
>
>  #define APDS9960_REG_STATUS    0x93
> @@ -77,6 +74,9 @@
>  #define APDS9960_REG_GCONF_1_GFIFO_THRES_MASK_SHIFT    6
>
>  #define APDS9960_REG_GCONF_2   0xa3
> +#define APDS9960_REG_GCONF_2_GGAIN_MASK                        0x60
> +#define APDS9960_REG_GCONF_2_GGAIN_MASK_SHIFT          5
> +
>  #define APDS9960_REG_GOFFSET_U 0xa4
>  #define APDS9960_REG_GOFFSET_D 0xa5
>  #define APDS9960_REG_GPULSE    0xa6
> @@ -396,9 +396,9 @@ static int apds9960_set_pxs_gain(struct apds9960_data=
 *data, int val)
>                         }
>
>                         ret =3D regmap_update_bits(data->regmap,
> -                               APDS9960_REG_CONFIG_2,
> -                               APDS9960_REG_CONFIG_2_GGAIN_MASK,
> -                               idx << APDS9960_REG_CONFIG_2_GGAIN_MASK_S=
HIFT);
> +                               APDS9960_REG_GCONF_2,
> +                               APDS9960_REG_GCONF_2_GGAIN_MASK,
> +                               idx << APDS9960_REG_GCONF_2_GGAIN_MASK_SH=
IFT);
>                         if (!ret)
>                                 data->pxs_gain =3D idx;
>                         mutex_unlock(&data->lock);
> --
> 2.34.1
