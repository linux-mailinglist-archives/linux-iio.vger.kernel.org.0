Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5DA77AB1A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Aug 2023 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjHMUQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Aug 2023 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHMUQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Aug 2023 16:16:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B110F9;
        Sun, 13 Aug 2023 13:16:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a7d7de894bso2505225b6e.3;
        Sun, 13 Aug 2023 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691957783; x=1692562583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbq+ZoL+3cYllWrZqE2glhR/uej79xUgT6XSVMz6GME=;
        b=Fe65SPY5+SIb43a9+eOmljhPnronAMZKF44mVr3LHQ2DrFG54Pnge8Pera7OxyvypZ
         pYV4c1L8pznRUEfeMhtlHqj5WOEUyFM+ItJdQErid8JZ3JD8b6nBCwbJS1Jr1UZ8s1Um
         9rf4VYrTHicY0WswdkuSbFPnHQO7gF4DE2FYysQvLZy43fD7DWPR4aeypGlA9Il9jHLt
         K4uuIMqpXK9wuxtBk/2W+HH8E5MlO4g5UiQW7RcsxQVN1g8SVBg/kwJCiO6XBgTIbzm6
         3uIvJsnsUFCvfCnDocDKSYzNJ0DAXGLiSaFvaTJhT1UfwonlBkXUYKNTpfaUvpJ45FYF
         I9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691957783; x=1692562583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbq+ZoL+3cYllWrZqE2glhR/uej79xUgT6XSVMz6GME=;
        b=GDLiJ5S3yJTApd/FNZw7koI57I4bHt/RiesSlobNF6Oyr82rB6+f104orf7wknZc1u
         iodbfFgzKmWNcsAzr/Mrxan18efIrSjxJoZlsAyX2XiX9Ucbk5wzG+VS67cfBI/98Etx
         1nXwA/SO5RmdtWTJEGKk2tXE9dnqaY9zJFOnCpUsiHmWt+WYd29V3rR28oPIdlZD0IIT
         HCGRP/pGYdI31UIMTFhoMdBKs4FBXzcZZIYGLXfRF94/8lz1syK9hOIBbMuVJ5exCg8i
         /aRVVc/dStO4pR6G7KK7ITbKzneX0rp2+2ztXNWmmCQXotwt0SmhudwFx8ay7xr6JlvV
         tuTA==
X-Gm-Message-State: AOJu0YzTGyFihrXtr5x1RfoWOLtg3Kp4RaDF8FKkHD3CqOl8E5BQwLrO
        EopksCqj1p0zym4KHchcT4qXoiyqON3rbGYfOJc=
X-Google-Smtp-Source: AGHT+IF4Cfup7NtYYZZ9hIWSgVIsqHG4rKNu/4/pBIA/nnIJHQHr1oxeRQMsqeMjAOgyep/bfIj2oA0Y4JNzMQiBU04=
X-Received: by 2002:a05:6808:1797:b0:3a7:4400:ebf0 with SMTP id
 bg23-20020a056808179700b003a74400ebf0mr8171647oib.5.1691957782972; Sun, 13
 Aug 2023 13:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230812133825.141581-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230812133825.141581-1-biju.das.jz@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Aug 2023 23:15:46 +0300
Message-ID: <CAHp75VeX+T=hAN+PgtHTdv4b6UtDVgveUUww1b1kuOngzDinFw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adxl345: Convert enum->pointer for data in
 match data table
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 4:38=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Convert enum->pointer for data in match data table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
>
> Add struct adxl3x5_chip_info and replace enum->adxl3x5_chip_info in the
> match table and simplify adxl345_probe().

...

> +       info =3D device_get_match_data(dev);
> +       if (info->type !=3D ADXL345 && info->type !=3D ADXL375)
>                 return -EINVAL;

I would rather use switch-case.
Anyway, same comments here as for the other patch: ENODEV and trailing comm=
as.

...

> +static const struct adxl3x5_chip_info adxl345_i2c_info =3D {
> +       .name =3D "adxl345",
> +       .type =3D ADXL345
> +};
> +
> +static const struct adxl3x5_chip_info adxl375_i2c_info =3D {
> +       .name =3D "adxl375",
> +       .type =3D ADXL375
> +};

> +static const struct adxl3x5_chip_info adxl345_spi_info =3D {
> +       .name =3D "adxl345",
> +       .type =3D ADXL345
> +};
> +
> +static const struct adxl3x5_chip_info adxl375_spi_info =3D {
> +       .name =3D "adxl375",
> +       .type =3D ADXL375
> +};

Why dup?

--=20
With Best Regards,
Andy Shevchenko
