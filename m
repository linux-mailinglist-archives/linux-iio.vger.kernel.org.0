Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF2325732
	for <lists+linux-iio@lfdr.de>; Thu, 25 Feb 2021 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBYT7n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 14:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhBYT6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 14:58:35 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E9C06174A
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2021 11:57:53 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so4324637pfu.8
        for <linux-iio@vger.kernel.org>; Thu, 25 Feb 2021 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=QFMdutzLSFz9pH4bdJbbu6ejYPbhrD5Zo32SFND9l2I=;
        b=TCDT/w6GjzyiLablryErRtrUWy+M9CBaYqE2VsnGy95c/ucnen8NLTIftmC44edutZ
         34MZRL/t2NuJ1ZFVeSpyCTFVuxLJSAURSZdze4IhC/jy3eFQCtQsrIuAbtaJ/M51dko/
         9MJgnKfGBr4x+k4cSCoJ9m8PeCf6dVhs505x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=QFMdutzLSFz9pH4bdJbbu6ejYPbhrD5Zo32SFND9l2I=;
        b=YQvfi0/8sh/gZlHjwkImJaKSVwmrFKgRfsxSrTVah+knZ5sGU5wJWzuhKdtzB1HU+G
         1oHTZ0UzpHz5SKQbXJIaFmEtXb4z3QN8E3akgyHDl+CJtgbI9HSAG8uv7T2cVUP6xyGI
         x6Jsm7pxS0FdOr49t/JExjWJtsJN4MqIaDB0gLR20mhQfUuSMN/BQ4rltW7BuuUaeM10
         ruq8fFUOpUb+NxlK7P7Du12pXTyI7pp3r1S+ICDLIJK23mYY9EPjswc/Eu9fn/BC5i28
         Nzd8/6ORvDxec7B3Cc6Sj7hTPmtyRvJicwaYiGYloHOCYuPj1fiW+kmqkVQCDFs4fV89
         5ftA==
X-Gm-Message-State: AOAM531sWzw4mTOF8pkHs3Q7IfKklH8goTypkW2pHBlWUPX3h13DKOjk
        n5vnX6EOVa0hZeP/Xj5CZJJyBZrATVcLYg==
X-Google-Smtp-Source: ABdhPJx4mvYCDXcVyNpct4FoBoVGmCDU6eGDqu3nG7rRPJsepbCdyi+orgG7FSIhmGGaIJ97hY1zYA==
X-Received: by 2002:a62:1791:0:b029:1ed:161e:9083 with SMTP id 139-20020a6217910000b02901ed161e9083mr4788876pfx.68.1614283072547;
        Thu, 25 Feb 2021 11:57:52 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id h123sm4976742pfe.115.2021.02.25.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:57:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210217061829.1199408-1-gwendal@chromium.org>
References: <20210217061829.1199408-1-gwendal@chromium.org>
Subject: Re: [PATCH v4] iio: sx9310: Support ACPI property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>, campello@chromium.org,
        jic23@kernel.org, lars@metafoo.de
Date:   Thu, 25 Feb 2021 11:57:50 -0800
Message-ID: <161428307047.1254594.14666702652501631212@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-02-16 22:18:29)
> Use device_property_read_... to support both device tree and ACPI
> bindings.
> Given |semtech,combined-sensors| is a variable array, use
> device_property_count to get the length of the array first before
> reading it to avoid underflow errors.
>=20
> Add support for variable array per documentation
> ("iio/proximity/semtech,sx9310.yaml").
>=20
> Fixes: 5b19ca2c78a0 ("iio: sx9310: Set various settings from DT")
>=20

Usually there isn't a newline here and Fixes is attached to the SoB.

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Changes since v3:
>    Add "Fixes" comment in commit message
>    Fix the logic set COMBMODE register: when we know the DT property is
>    missing or incorrect, exit as soon as possible.

I'd still prefer it to be two patches, one for the fix of array property
parsing to send back to stable trees and one to add the ACPI parsing
support, but I'm not the maintainer here so this isn't really up to me.

>  Changes since v2:
>    Add comment how the default array is used.
>    Add comment in commit message to indicate this CL fix an issue with
>      existing use of of_property_read_u32_array() when reading a variale
>      length array.
>  Changes since v1:
>    Use device_property_count_u32(...) instead of device_property_read_u32=
_array(..., NULL, 0)
>=20
>  drivers/iio/proximity/sx9310.c | 54 +++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 6a04959df35e5..77d2c9e102842 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -1215,36 +1216,49 @@ static int sx9310_init_compensation(struct iio_de=
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
> -       u32 combined[SX9310_NUM_CHANNELS] =3D { 4, 4, 4, 4 };
> +       int ret, count;
> +       u32 combined[SX9310_NUM_CHANNELS];
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
> -               reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> -               of_property_read_u32_array(np, "semtech,combined-sensors",
> -                                          combined, ARRAY_SIZE(combined)=
);
> -               for (i =3D 0; i < ARRAY_SIZE(combined); i++) {
> -                       if (combined[i] <=3D SX9310_NUM_CHANNELS)
> -                               comb_mask |=3D BIT(combined[i]);
> +               count =3D device_property_count_u32(dev, "semtech,combine=
d-sensors");
> +               if (count > 0 && count <=3D ARRAY_SIZE(combined)) {
> +                       ret =3D device_property_read_u32_array(dev,
> +                                       "semtech,combined-sensors", combi=
ned,
> +                                       count);
> +               } else {
> +                       /*
> +                        * Either the property does not exist in the DT, =
the
> +                        * number of entries is incorrect.
> +                        */
> +                       break;
> +               }
> +               if (ret) {
> +                       /* We could not read the array (invalid DT). */
> +                       break;
>                 }

Wouldn't this be shorter?

		count =3D device_property_count_u32(dev, "semtech,combined-sensors");
		if (count < 0 || count > ARRAY_SIZE(combined))
			break;
	=09
		ret =3D device_property_read_u32_array(dev,
						     "semtech,combined-sensors",
						     combined, count);
		if (ret)
			break;


If the 'break' logic is off-putting then I suggest moving it to another
function and using 'return' to indicate early returns from the code
flow.

> =20
> -               comb_mask &=3D 0xf;
> +               for (i =3D 0; i < count; i++) {
> +                       if (combined[i] >=3D SX9310_NUM_CHANNELS) {
> +                               /* Invalid sensor (invalid DT). */
> +                               break;

Don't think we need to do this. We have DT validation for this instead
so that we don't have to carry code in the kernel to validate something
that can be checked at build time. Hopefully ACPI has something similar?

> +                       }
> +                       comb_mask |=3D BIT(combined[i]);
> +               }
> +
> +               reg_def->def &=3D ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
>                 if (comb_mask =3D=3D (BIT(3) | BIT(2) | BIT(1) | BIT(0)))
>                         reg_def->def |=3D SX9310_REG_PROX_CTRL2_COMBMODE_=
CS0_CS1_CS2_CS3;
>                 else if (comb_mask =3D=3D (BIT(1) | BIT(2)))
