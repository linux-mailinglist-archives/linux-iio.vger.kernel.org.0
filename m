Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E090755E26
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGQIPm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjGQIPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 04:15:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38F11F;
        Mon, 17 Jul 2023 01:15:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso66750911fa.0;
        Mon, 17 Jul 2023 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689581737; x=1692173737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1XHO/vsvtpAqGXEQ75kS5A6LWDh8NKT1MTF1P1LSQc=;
        b=kRbmfmqDrLiE4jp7gsbyjXXcry9tTi6NPW2LmyNeM4RWlImXm3Z+OXsLvvQnL8HvA9
         cVJ84Beunw7zilmhky7lO41VIie7DYegONT3J+MS6cLcEYVw1Q4FtLHKdL93LVTXPQPj
         GqGSh826ibG0ldM3j3lrc7P51kyKORPBUzSmg6lca8potI3HloGA3E0GdOHAG/GY2wMb
         ko04B5pDiBikzmETPTz40Dzu+YO0l11hqG53sEKPzETOfDLGg2mLHV2o7wm11H6QP2bG
         Y74vAkyTpy7Gz1A/5LpVGdr/3X1o2NWqwYFTaWPtJ+QQZ+uBqj2uu6OhT72bMxd/t97Z
         l2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581737; x=1692173737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1XHO/vsvtpAqGXEQ75kS5A6LWDh8NKT1MTF1P1LSQc=;
        b=GJwfgnwUPvgbC3EwH2x7g0wwn1RrzhFFX/9atOyJSZNhbArb6pzpU99YvpM1nEIXkK
         kEwT24OZ5LT/J5tZ517KDtQX9clXYHlJm8Y5MxShCd9iAWUH5cQW8rWwXbgXpdWE3o58
         iJZZjWYlnBdqsSl6z41fV+vJGKlP/4QP3sjCz2gUJ4NZqDiHsmlbP3zUZCedCL06fvxs
         VFvrOAgPvPrUG+Y3d9WWEH7Q2U652e05P/LB2R8hy7JcwwtPYyDJ61ykWmGgEcqhFFQy
         C7Engc57nSjuvW3FglMA2CZ1HEEkGaEIJZTgpUjXRsBc2+CFJ9JCjYRivFE558cz6Owc
         zsUg==
X-Gm-Message-State: ABy/qLbR74trAPhtNEpanGYN28Xa7KgzrO76KVrtWrPW3C57ezqndHQ+
        jCRB0bIPaeroW878AR3aTb9r8UFK4EGn45t7D08=
X-Google-Smtp-Source: APBJJlG0tJK4svq+Wee4qAV414l7PfbDXRoaH6I8xboE59b+e6bK6W57+lCDauY2xlkgHvzcAYZt8VpKL2yv4Flos38=
X-Received: by 2002:a2e:8546:0:b0:2b9:4492:1226 with SMTP id
 u6-20020a2e8546000000b002b944921226mr878260ljj.11.1689581737245; Mon, 17 Jul
 2023 01:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com> <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230716175218.130557-2-biju.das.jz@bp.renesas.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 17 Jul 2023 10:15:26 +0200
Message-ID: <CANk7y0j_Xug9per52CAdmvWiG1-5YRFuJ+3dxCsarnqmKGdnVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: accel: adxl355: Simplify probe()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 16, 2023 at 7:52=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Simplify the probe() by replacing of_device_get_match_data() and
> i2c_match_id() by i2c_get_match_data() as we have similar I2C
> and DT-based matching table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/accel/adxl355_i2c.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_=
i2c.c
> index d5beea61479d..32398cde9608 100644
> --- a/drivers/iio/accel/adxl355_i2c.c
> +++ b/drivers/iio/accel/adxl355_i2c.c
> @@ -24,19 +24,10 @@ static int adxl355_i2c_probe(struct i2c_client *clien=
t)
>  {
>         struct regmap *regmap;
>         const struct adxl355_chip_info *chip_data;
> -       const struct i2c_device_id *adxl355;
>
> -       chip_data =3D device_get_match_data(&client->dev);
> -       if (!chip_data) {
> -               adxl355 =3D to_i2c_driver(client->dev.driver)->id_table;
> -               if (!adxl355)
> -                       return -EINVAL;
> -
> -               chip_data =3D (void *)i2c_match_id(adxl355, client)->driv=
er_data;
> -
> -               if (!chip_data)
> -                       return -EINVAL;
> -       }
> +       chip_data =3D i2c_get_match_data(client);
> +       if (!chip_data)
> +               return -ENODEV;
>
>         regmap =3D devm_regmap_init_i2c(client, &adxl355_i2c_regmap_confi=
g);
>         if (IS_ERR(regmap)) {
> --
> 2.25.1
>

Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>
