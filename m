Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F72312D7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgG1Th7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgG1Th6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:37:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A6DC0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so460958pje.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=XvERaqFheH0HRUPOb8gs3iC+0Q5eyWBPoexQsxXgrJ4=;
        b=B952i8sjasHSiAKM9favYcPbSad3O4QOLiVT+vUDeBVL4e54NhZ3Af0zWfZ3qipUWh
         Bbe8OAlmQou7V5E7NaSGbiT/GpzA0GnIxQ4SOKyR1+WJCkiSyZj5q/wPCeHpHkkV0FOM
         AnzsKDfOh2C+2HNkfzQ5VJpxY4TGuSGsfmWV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=XvERaqFheH0HRUPOb8gs3iC+0Q5eyWBPoexQsxXgrJ4=;
        b=WnBtrZ8S0iB8KfGUTIZt/wR2bAyCYd/H05lDutOoeFrR8o3xkdRMDhr/h9UbhBxeac
         3rhX7Nu/r7VscJtqVKngVuj/gqikgiPopFkse4zkbcx0Gtdz11AX9v2fUq5Kf0DavcqW
         kaupI8qMgQXZxIWWUq6FxYgRoDmTP6sDjOrxAeLDYc82xZGxt8syUqbF5PMiDElUGMrI
         0hcOci/1uOmIJ9U4/e3nfJe62/iM84JxrJhgOJZ0w+mfjHmpltcJi/eT/YRQHtvoCJGF
         qhgHa/dLfWogkELY2cnbU2Nw4dcdXbH7L8rTbkF+9KdcbwV3rJuSsGIxGj0OwFFWi6Pf
         eAWg==
X-Gm-Message-State: AOAM5323f0xELFP4VJj0W+SM4wSd3vEmR6dSFTKD7zFcjqeXyeHSVjcn
        x8gUpIzltg1iXrJPMGx2zytx4w==
X-Google-Smtp-Source: ABdhPJx8Ozl0JiSmdLvPYl2ISDoCK9PBJEQjs0xYqc1jKnDf7w2sK1QD0gqDay8iUxq7nQTuGD9KyA==
X-Received: by 2002:a17:90a:22ab:: with SMTP id s40mr6376782pjc.117.1595965078315;
        Tue, 28 Jul 2020 12:37:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b13sm9150898pgd.36.2020.07.28.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:37:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
Subject: Re: [PATCH 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:37:56 -0700
Message-ID: <159596507657.1360974.12104693281408043672@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:51)
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 2465064971d0a7..3956fd679c6db9 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -810,22 +810,17 @@ static int sx9310_init_compensation(struct iio_dev =
*indio_dev)
>         if (ret < 0)
>                 return ret;
> =20
> -       for (i =3D 100; i >=3D 0; i--) {
> -               msleep(20);
> -               ret =3D regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> -               if (ret < 0)
> -                       goto out;
> -               if (!(val & SX9310_COMPSTAT_MASK))
> -                       break;
> -       }
> -
> -       if (i < 0) {
> -               dev_err(&data->client->dev,
> -                       "initial compensation timed out: 0x%02x", val);
> -               ret =3D -ETIMEDOUT;
> +       ret =3D regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, =
val,
> +                                      !(val & SX9310_REG_STAT1_COMPSTAT_=
MASK),
> +                                      20000, 2000000);
> +       if (ret) {
> +               if (ret =3D=3D -ETIMEDOUT)
> +                       dev_err(&data->client->dev,
> +                               "0x02 << 3l compensation timed out: 0x%02=
x",

What does 0x02 << 3l mean?

> +                               val);
> +               return ret;
>         }
>
