Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A12F1E98
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 20:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbhAKTHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 14:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732381AbhAKTHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 14:07:24 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87771C061786
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 11:06:44 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 15so273448pgx.7
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4XxPHvPQWjVwaEkEd8T8F1/rjFPbxSNi2UBaBoVDUtc=;
        b=mIExJjylsTO80y1KhYW3GugF5Hcp/CTU0F64h97OgiqeAJj9vk+HpS4CLufxxBBHE5
         JaIZrXMnxx8mTQrTX0MKxlqyeBJeVBcI/unvXSYBPi9wsAE/1m46kARQk3/qvUsJHC54
         K20zytdr6XAmk68JniuAxsjxHl2T64mlKrqkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4XxPHvPQWjVwaEkEd8T8F1/rjFPbxSNi2UBaBoVDUtc=;
        b=oqAY+dOJKApnXu+vJYrlncEEAPBnjpseday/DqLk3bzNior6NvgxQbz21/vgCpJ6VV
         Czkl6HOt3xS9ssw4JHzQAxPWz/6spS/g1Qx9uV1Bks/Npy3Q4xQE+Q1d9oYqmc7N/OTa
         qL8zT+vnqCAv8d2I1qpFNrlqDcdCe3vWLEhb4wlbDEajvodruk6fDXFnV6NnVXlFgF6F
         Lh+0xadkwbTDgZPOTcN406FXH3oKuBK2XzJqBuHWG9jwyrFprMxer1zb3teK5byI6As8
         c5FDXPbpot9T/d8TJhWgKF7IJ0ZJLBhQmbTZGWU+3hU325jYmb1wyJLd5SzBmJeD+5Au
         f59w==
X-Gm-Message-State: AOAM531dnoIYo0L7weRvwVkevyLBtFpJR6p+WoERsuRgxqcVkdiK5Jb7
        JOI9mWsmhfz2EMw1+/OTpjSzIg==
X-Google-Smtp-Source: ABdhPJzOUrGSKtLNol2dA29k+WZ+URak7Sde4U7uNwOCsrZSJEYEitMk2izJ7nt4dzvvel4ArSg4EA==
X-Received: by 2002:a63:5952:: with SMTP id j18mr966601pgm.29.1610392004115;
        Mon, 11 Jan 2021 11:06:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id mw15sm121965pjb.34.2021.01.11.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:06:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201202200252.986230-1-swboyd@chromium.org>
References: <20201202200252.986230-1-swboyd@chromium.org>
Subject: Re: [PATCH v3] iio: sx9310: Fix semtech,avg-pos-strength setting when > 16
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 11 Jan 2021 11:06:41 -0800
Message-ID: <161039200192.1580929.14023513752851296639@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Stephen Boyd (2020-12-02 12:02:52)
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 31. Also use clamp() because we're here.
>=20
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Hi Jonathan,

Happy new year! Can this be picked up? Or should I resend?=20

>=20
> Changes from v2 (https://lore.kernel.org/r/20201120182944.543428-1-swboyd=
@chromium.org):                                                            =
                                            =20
>  * Use clamp()
>  * Add comment to clarify
>=20
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboy=
d@chromium.org):                                                           =
                                             =20
>  * Changed ternary to consider 17 to 31 as the same as 16  =20
>=20
>  drivers/iio/proximity/sx9310.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index a2f820997afc..0e6863e4d384 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1305,7 +1305,8 @@ sx9310_get_default_reg(struct sx9310_data *data, in=
t i,
>                 if (ret)
>                         break;
> =20
> -               pos =3D min(max(ilog2(pos), 3), 10) - 3;
> +               /* Powers of 2, except for a gap between 16 and 64 */
> +               pos =3D clamp(ilog2(pos), 3, 11) - (pos >=3D 32 ? 4 : 3);
>                 reg_def->def &=3D ~SX9310_REG_PROX_CTRL7_AVGPOSFILT_MASK;
>                 reg_def->def |=3D FIELD_PREP(SX9310_REG_PROX_CTRL7_AVGPOS=
FILT_MASK,
>                                            pos);
>=20
> base-commit: 5b19ca2c78a0838976064c0347e46a2c859b541d
