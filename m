Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAD30CB52
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhBBTUv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 14:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbhBBTSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 14:18:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE51C061573
        for <linux-iio@vger.kernel.org>; Tue,  2 Feb 2021 11:17:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y205so15008002pfc.5
        for <linux-iio@vger.kernel.org>; Tue, 02 Feb 2021 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xslRSXaGznA6UGnAhZFdGfAaEmgh74RUDbp7wv1Zo2A=;
        b=NkMeA8f3NizAwTRgGvJxAMsVqx4LoGHBHDDf5BX6QKF+23crilPi9Rba80L5L+1SjG
         mlmRZCRVSt1QPzEPm2cRGthIT2EUmgzYOCt0ehnxJUBHvc9h4F5BPHWMkhqgw2Md7eAI
         hNW/zLR7ltwvQvofPgAT07+oLfISIKzGXlvY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xslRSXaGznA6UGnAhZFdGfAaEmgh74RUDbp7wv1Zo2A=;
        b=Xwall9ilU0F8T+GmRsGBofhNFRKMtioFNjP3mDfyJtcTl1eA3DtZKGFSaHGgO+TmCa
         9dnlP8q9fRvvnhNsc56ifddizUut/Bx3Py15a66NQvjDjpOL5IsL/DLX9pzmQ4gawkzu
         HNQUfY61/xAiZtUuVvw76dmkH6Bj23aHYEKpzjggTri5L4p+VnnYAvfM8Ho0Pe6K67de
         03X0RCWmrdzG0LUrbk/oZ4Vrvn4g+Sd/1W20uiYotDOWL8s939riQr0EKmVO1FaRwCK5
         GsXwYJgqIevudwDpAyTFVKxsbsDBrUUBd8AyaTy4TVo3b6Jc6iQHWXBriXwyQZgsyyw1
         4Jkg==
X-Gm-Message-State: AOAM5338eCoOiv4BA8qnxDROqmpLlGO1w+icTNbuoHdZS7/wK/XCA5Yh
        eChHFJAwh+ICWN9sgKXfGef2XGXb9D+b5Q==
X-Google-Smtp-Source: ABdhPJyIq7MB0Qx5afaCe8X9IS+Q1i0bfJVRH/e5Koq/yr+5b+KRPYt9dAZ/j9zGG62NIRfWaANL/w==
X-Received: by 2002:a62:cd86:0:b029:1c7:f5f6:787f with SMTP id o128-20020a62cd860000b02901c7f5f6787fmr22906811pfg.62.1612293469387;
        Tue, 02 Feb 2021 11:17:49 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id s21sm21482787pga.12.2021.02.02.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:17:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210202064541.2335915-1-gwendal@chromium.org>
References: <20210202064541.2335915-1-gwendal@chromium.org>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>, campello@chromium.org,
        jic23@kernel.org, lars@metafoo.de
Date:   Tue, 02 Feb 2021 11:17:47 -0800
Message-ID: <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-01 22:45:41)
> Use device_property_read_... to support both device tree and ACPI
> bindings.
>=20
> Add support for variable array per documentation
> ("iio/proximity/semtech,sx9310.yaml").
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 36 ++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 37fd0b65a0140..1a8a441c9774d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1213,31 +1214,36 @@ static int sx9310_init_compensation(struct iio_de=
v *indio_dev)
>  }
> =20
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int i,
> +sx9310_get_default_reg(struct device *dev, int i,
>                        struct sx9310_reg_default *reg_def)
>  {
> -       int ret;
> -       const struct device_node *np =3D data->client->dev.of_node;
> +       int ret, count;
>         u32 combined[SX9310_NUM_CHANNELS] =3D { 4, 4, 4, 4 };
>         unsigned long comb_mask =3D 0;
>         const char *res;
>         u32 start =3D 0, raw =3D 0, pos =3D 0;
> =20
>         memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> -       if (!np)
> -               return reg_def;
> -
>         switch (reg_def->reg) {
>         case SX9310_REG_PROX_CTRL2:
> -               if (of_property_read_bool(np, "semtech,cs0-ground")) {
> +               if (device_property_read_bool(dev, "semtech,cs0-ground"))=
 {
>                         reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_SHIELDEN=
_MASK;
>                         reg_def->def |=3D SX9310_REG_PROX_CTRL2_SHIELDEN_=
GROUND;
>                 }
> =20
>                 reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> -               of_property_read_u32_array(np, "semtech,combined-sensors",
> -                                          combined, ARRAY_SIZE(combined)=
);
> -               for (i =3D 0; i < ARRAY_SIZE(combined); i++) {
> +               count =3D device_property_read_u32_array(dev,
> +                               "semtech,combined-sensors", NULL, 0);
> +               if (count > 0 && count <=3D ARRAY_SIZE(combined))
> +                       ret =3D device_property_read_u32_array(dev,
> +                                       "semtech,combined-sensors", combi=
ned,
> +                                       count);
> +               else
> +                       ret =3D -EINVAL;
> +               if (ret)
> +                       count =3D ARRAY_SIZE(combined);

I wish this could be written simpler. Unfortunately there isn't any sort
of for_each_device_property() iterator macro like we have with
of_property_for_each_u32(). Or device_property_read_u32_array() can be
OK if the length of the property doesn't exceed the size of the
'combined' array?

> +
> +               for (i =3D 0; i < count; i++) {
>                         if (combined[i] <=3D SX9310_NUM_CHANNELS)
>                                 comb_mask |=3D BIT(combined[i]);
>                 }

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
