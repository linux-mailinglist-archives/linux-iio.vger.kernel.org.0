Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAD31A860
	for <lists+linux-iio@lfdr.de>; Sat, 13 Feb 2021 00:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBLXmc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 18:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLXmb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 18:42:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20762C061574
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 15:41:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b8so631631plh.12
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=83lFxPGciwi0BW2bGY+UIZNJws83+SlKMPehUGg/B8w=;
        b=F8xqoeITuep9oybv7WsriqCGtcQCbeYPmdU8c2dBK46AHRK4r1AY4ZWT6AJBKMyE4C
         aur2s2bk+jDECsLov7Cb65SyuxX4NcfFnRZd5hpnrH9g0buyMXqwZDD7i4Pwt/ckfjrj
         iHAP/9VaQVAI1yrmWGrrFAUAWYCv9rCjP23HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=83lFxPGciwi0BW2bGY+UIZNJws83+SlKMPehUGg/B8w=;
        b=gxi9a03ifOeITMOD1BnDSllzVflLU80QOh6n/2CkazRdGESaWHQd29lgEkZvY6dDxj
         FWI1gwDTiEoe8Hfm/FK8WS1RW28o6nFQ2pqW5QwU8wEacw6lM6nfgdM+sSyOT5bEet0T
         g4z/FTmHOPh1b5PUNevNorUJQERTAnPd6FscIyhDq8bq+XyDhd1qAUk/+eGlBOVlE8F3
         WQqg89qN7XL/0EV1C9ECuFnn+KaYSTl3R6CipUGmeQpXwRXh2A8IO7zFfZEF0n9APTvN
         Qzpv5+xsxaRV2buCtSXiOURQHyu1q6HxBzeStyadgJXBt2oI54bvlJw1BHkQ0prdIIVT
         Xh2w==
X-Gm-Message-State: AOAM531eSNpDzsY2QWNImSw9oI+LdBaMjheI3RJWGf8zH+l9IEAcfSNV
        7PXvo2FQB3jwEOlXbxzfOy72K5KyUF4Kww==
X-Google-Smtp-Source: ABdhPJwP19IUcgwLUmGHEn7l8P7Gn3BlwbXpPeKeKYTrlvAVpMzzYTnn9pfgHmkeTacMceL/AsJpyg==
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr4668243pjo.222.1613173310318;
        Fri, 12 Feb 2021 15:41:50 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:483a:c54c:e9b3:6222])
        by smtp.gmail.com with ESMTPSA id t25sm10148008pgv.30.2021.02.12.15.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 15:41:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210212214033.1304840-1-gwendal@chromium.org>
References: <20210212214033.1304840-1-gwendal@chromium.org>
Subject: Re: [PATCH v3] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>, campello@chromium.org,
        jic23@kernel.org, lars@metafoo.de
Date:   Fri, 12 Feb 2021 15:41:48 -0800
Message-ID: <161317330808.1254594.17984303595904501880@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-12 13:40:33)
> Use device_property_read_... to support both device tree and ACPI
> bindings.
> Given |semtech,combined-sensors| is a variable array, use
> device_property_count to get the length of the array first before
> reading it to avoid underflow errors.
>=20
> Add support for variable array per documentation
> ("iio/proximity/semtech,sx9310.yaml").
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

It's attempting to fix a bug. Please add=20

Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")

> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 6a04959df35e5..6440d12773c64 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1215,31 +1216,42 @@ static int sx9310_init_compensation(struct iio_de=
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

This should move after the parsing of the property, and only be done if
the semtech,combined-sensors property is present and valid.

> -               of_property_read_u32_array(np, "semtech,combined-sensors",
> -                                          combined, ARRAY_SIZE(combined)=
);
> -               for (i =3D 0; i < ARRAY_SIZE(combined); i++) {
> +               count =3D device_property_count_u32(dev, "semtech,combine=
d-sensors");
> +               if (count > 0 && count <=3D ARRAY_SIZE(combined))
> +                       ret =3D device_property_read_u32_array(dev,
> +                                       "semtech,combined-sensors", combi=
ned,
> +                                       count);
> +               else
> +                       ret =3D -EINVAL;
> +               if (ret) {
> +                       /*
> +                        * Either the property does not exist in the DT, =
the
> +                        * number of entries is incorrect, or we could no=
t read
> +                        * the array (invalid DT).
> +                        * In all cases, use the default from the diver.
> +                        */
> +                       count =3D ARRAY_SIZE(combined);
> +               }
> +
> +               for (i =3D 0; i < count; i++) {
>                         if (combined[i] <=3D SX9310_NUM_CHANNELS)
>                                 comb_mask |=3D BIT(combined[i]);
