Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC136231163
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgG1SOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1SOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:14:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE44C061794;
        Tue, 28 Jul 2020 11:14:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id il6so303275pjb.0;
        Tue, 28 Jul 2020 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPfWteNuEXgFZuXXeO7IhILnI3TLTwJdRgXJjFfk1rA=;
        b=bdDpa7U7HD8JOEPfv+fYkOAfrUoI05RUnLRodD0MfT+cqu0EzyoVAqVRcheORJlBT4
         gb5P31Cq5sjyRXNDYrOhrRLdBihBwFG4UjeA0VTAkciRLvPXzKi1ab4tehbcNvoMkeuH
         D9A1tzxxnhZGMYW0/1Mj1rTjFoYM6wNBitFzyB0iUiVLb62UAohSCa6ss8dntrXcSb9V
         LEHc/obNB2TsOO8/iIpGtSYlwVlDff00I1RRaZj+7kzaZEEPcosPeJtVVfs02OSrxe9Y
         fe/cv/9EqeW94KkI/Do6oAeGx4AZLAjUiVEe9Ehry9OZ6ixOMKdEGqmexaWoUGL/E6zM
         +dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPfWteNuEXgFZuXXeO7IhILnI3TLTwJdRgXJjFfk1rA=;
        b=Fr3MhSVWagH/8dltwDy9Heil4sE/uF1rF48QeKNCLufTF/n2GAMIryM+oRyNafNT5i
         7/qdnXLBczFEUNN5zk+1uPbi4X1tVZjD8+x2hijB52I+Cm7/DrxU7diV4O4o6sy9aMG8
         4kFuk2fziD1RTX09KV6kaaEYzjarfpcsDpZq2BnpZI1gYZ7TtdNpqoc74Z23P4Rp3RGr
         6u8/+N82/aju8/6UZvbeHwisqJ9qOjEAc2asdz+S2qv6VJXL+0V1P04L1lMcNI/mWJBI
         Z54mtL9MMSAExptZj2A+SeA7yUfas4MlSh0Hem522EJWx/FevQtyVFzmDap9TuBEl1EZ
         VtdQ==
X-Gm-Message-State: AOAM533jra/hmAcWisdAh68zSUamPT0HA8X/np7bOIofEnvIrruLev/L
        ybzEQ/Ybjwup56H4TduHjcOswv43Mg/NM1mwHb8jLPOO+7/Raw==
X-Google-Smtp-Source: ABdhPJzIfTTUoQm76ap/H9WvznCcQvzCKUmZIaQ8YO4ge1+1fHQen5gj2Bzt1qEDN2kklC6mi1M06d219xg3NvIBQHM=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr5884904pjp.228.1595960071147;
 Tue, 28 Jul 2020 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
In-Reply-To: <20200728091057.8.I34c7a1bfca7fe3d607f8876ef9f10c22153556d2@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:14:14 +0300
Message-ID: <CAHp75VfQ5N_EOF7NKUsfuy8c43B1PrvPTaqOpHPRVEO9DPj8kA@mail.gmail.com>
Subject: Re: [PATCH 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:15 PM Daniel Campello <campello@chromium.org> wrote:
>
> Simplify compensation stage by using regmap_read_poll_timeout().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 2465064971d0a7..3956fd679c6db9 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -796,7 +796,7 @@ static const struct sx9310_reg_default sx9310_default_regs[] = {
>  static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  {
>         struct sx9310_data *data = iio_priv(indio_dev);
> -       int i, ret;
> +       int ret;
>         unsigned int val;
>         unsigned int ctrl0;
>
> @@ -810,22 +810,17 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>         if (ret < 0)
>                 return ret;
>
> -       for (i = 100; i >= 0; i--) {
> -               msleep(20);
> -               ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> -               if (ret < 0)
> -                       goto out;
> -               if (!(val & SX9310_COMPSTAT_MASK))
> -                       break;
> -       }
> -
> -       if (i < 0) {
> -               dev_err(&data->client->dev,
> -                       "initial compensation timed out: 0x%02x", val);
> -               ret = -ETIMEDOUT;
> +       ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
> +                                      !(val & SX9310_REG_STAT1_COMPSTAT_MASK),
> +                                      20000, 2000000);
> +       if (ret) {
> +               if (ret == -ETIMEDOUT)
> +                       dev_err(&data->client->dev,
> +                               "0x02 << 3l compensation timed out: 0x%02x",
> +                               val);
> +               return ret;
>         }
>
> -out:
>         regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);
>         return ret;
>  }
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
