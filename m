Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF04502FE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhKOLD6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 06:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhKOLBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 06:01:35 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EDC061767
        for <linux-iio@vger.kernel.org>; Mon, 15 Nov 2021 02:58:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so33543251edu.4
        for <linux-iio@vger.kernel.org>; Mon, 15 Nov 2021 02:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W7ElyeVUPPU9LKXMiMMgz6zNgMEvLtv3GY5xJWumrsM=;
        b=B7OBpWcTi3Z5PvS4edgFAtNjOrwf8UKf1hIfSnvcLjCjTEIQ3EIsE17fxM9w0KJJ7W
         12dexcf60rUIzu5rRsr97daOvVFz97LgMz0UrM4LQK7TazEQkVs/KjhiRa1fR/ryBagu
         0vcZP6LTDiNUcURCP/prtqEr31bai95dVLDP9a9JAXG+URWXytJURT+Td4At85tpDhK7
         gl7IIV41SozhHtRXJNL/kwlrd+u9A+zkPHGT/2AFeSbDohxb+vcnoRDt8jfioqtxiOtm
         tylLpLaH0L2UBSkB4ZsR9HjUIyNhMoYpEb9B9cNYprD4SIqW91ukRCQ0nQGJLPRTx89F
         brDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W7ElyeVUPPU9LKXMiMMgz6zNgMEvLtv3GY5xJWumrsM=;
        b=R9aTI5kBnwxwKZ0HElIy8lMUHuyl9F2mSGLy6aHujmCzvutKTwkrTLRIrLj9DdKyGJ
         1OXvENvexLvDiEZ8pn2xGKELaxksR3xG05f6dVeBu0X0HNCxsyJp5pdBG8TonGmNRyj0
         BUq/9H2V96sE++wKGnQG1lX7+tN5IxOaIzFFA1/hijrodI1+Edr4Qdi4vXtfBxydF4Jc
         pqzANKVSRgmzHeRjtTka9jMAJrIhAnjfOrKP50NZItwW6BGIV2tSJ68r4Wgh9N2Ubhvf
         hnzzYd9dqnNFvU6L7MEKz11B5KFEH6KrTLo586dJ4JS48FMBx/w8tilB05GYkwRd6gdP
         vJNA==
X-Gm-Message-State: AOAM532wQLk1OapViuEgYrY90c4CWe1tsz0PirGI1XCyAVH9CwvgnXVZ
        pxTUgs39tva5foK9L2XU1AZV7LJHPNZOIWVfTuw=
X-Google-Smtp-Source: ABdhPJzoK8lHO9O7IkYNEw+526nQnogtwhSjsVVqYXl/f1Qiw1OACN+ZNrNgnXX5wW9tuRncTltGTOLyzahKxrgpLS0=
X-Received: by 2002:a50:fb09:: with SMTP id d9mr19602469edq.283.1636973908131;
 Mon, 15 Nov 2021 02:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20211115104147.18669-1-nuno.sa@analog.com>
In-Reply-To: <20211115104147.18669-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 12:57:46 +0200
Message-ID: <CAHp75Vc+AyaDmvssME39YO2LOY+yBb7QyNCnvNWJxYr-Of16ig@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adxrs290: fix data signedness
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Kister Genesis Jimenez <kister.jimenez@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 12:41 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> From: Kister Genesis Jimenez <kister.jimenez@analog.com>
>
> Properly sign-extend the rate and temperature data.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 2c8920fff1457 ("iio: gyro: Add driver support for ADXRS290")
> Signed-off-by: Kister Genesis Jimenez <kister.jimenez@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
> changes in v2:
>  * removed redundant temp & 0xFFF.
>
> changes in v3:
>  * full name in Signed-off-by tag.
>
>  drivers/iio/gyro/adxrs290.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index 3e0734ddafe3..600e9725da78 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -124,7 +125,7 @@ static int adxrs290_get_rate_data(struct iio_dev *ind=
io_dev, const u8 cmd, int *
>                 goto err_unlock;
>         }
>
> -       *val =3D temp;
> +       *val =3D sign_extend32(temp, 15);
>
>  err_unlock:
>         mutex_unlock(&st->lock);
> @@ -146,7 +147,7 @@ static int adxrs290_get_temp_data(struct iio_dev *ind=
io_dev, int *val)
>         }
>
>         /* extract lower 12 bits temperature reading */
> -       *val =3D temp & 0x0FFF;
> +       *val =3D sign_extend32(temp, 11);
>
>  err_unlock:
>         mutex_unlock(&st->lock);
> --
> 2.33.1
>


--=20
With Best Regards,
Andy Shevchenko
