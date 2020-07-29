Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC3231B64
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 10:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgG2IlC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 04:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgG2IlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 04:41:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB567C0619D4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:41:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so1714226pjt.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=UZ6MAhR5j6amGSoFFGPG4pk0azdkEksnZheJKcn2abA=;
        b=OYYYKBNhL9fF72pj0+bLFlk7Y5oNif9G8mquMQtqxeEELXBrS2SPrfcPZpogKcRn0N
         2HPWXia7c5PwiAMCkjbJtfvSdMUehP7GB5vgzl9r5HqIBT3sC3cpO68Z0lAesIPP9Yx2
         UahdJ+RiDKdIDsEOlhWfmu7Vm7K68mjNGVFYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=UZ6MAhR5j6amGSoFFGPG4pk0azdkEksnZheJKcn2abA=;
        b=an9PZkJ68AoFfljnbJ7t6s5Wm6bwbbLqtXI1EGP7byN5XjH02AMHqwXT4Nf1em+ZKr
         CYAvN0zyjXIc9qBGjPdkp5JNb69LUclJt1xPeHkkCz++GmBjtINFgXyuIz0oPWzLCrU3
         AnkmH6wTaqRe96JjmHkOK4tvkfAuu8RGMAWppx6nkoFgK+7s5r0k1shbx+7C8JioMPfX
         k9IAWKsBWCxnKj8jTDekGTKG/UlSP59a9szTAWGWOjVlFAAVdX2ZvwQra/v+/8J9Cz/f
         vXbMmjKOKdcdk3EgvviIZsfI/qsc2NpkcZvlT+SljQsBs/mfv/wb0jq62AJzYWng+Z8g
         5eoA==
X-Gm-Message-State: AOAM533qDq5CDJpFyfo8hoff2MEChHYUaX6GkulmYQ9mAIMvsLnVQT9i
        ILx5qx/rYRp2gPg1NOvybiUYzA==
X-Google-Smtp-Source: ABdhPJzrnA7zEGw1DgXocfYDrn7TERVujMt11CJIltoSmzrN2INTqf2WnQcYSHVJGV5yRbWBbVrDRw==
X-Received: by 2002:a17:90a:3fc7:: with SMTP id u7mr8565488pjm.231.1596012061371;
        Wed, 29 Jul 2020 01:41:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z190sm1511032pfz.67.2020.07.29.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:41:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
Subject: Re: [PATCH v2 03/14] iio: sx9310: Fix irq handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 01:40:59 -0700
Message-ID: <159601205939.1360974.7963147221648753018@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:09)
> Fixes enable/disable irq handling at various points. The driver needs to
> only enable/disable irqs if there is an actual irq handler installed.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>=20
> Changes in v2:
>  - Reordered error handling on sx9310_resume()
>=20
>  drivers/iio/proximity/sx9310.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx931=
0.c
> index 07895d4b935d12..108d82ba81146e 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -376,13 +376,15 @@ static int sx9310_read_proximity(struct sx9310_data=
 *data,
>         if (ret < 0)
>                 goto out;
> =20
> -       ret =3D sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
> -       if (ret < 0)
> -               goto out_put_channel;
> +       if (data->client->irq) {
> +               ret =3D sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);

I still think it makes more sense to push the if condition inside the
enable/disable irq functions so that the call sites read simpler.

> +               if (ret)
> +                       goto out_put_channel;
> +       }
> =20
>         mutex_unlock(&data->mutex);
> =20
> -       if (data->client->irq > 0) {
> +       if (data->client->irq) {
>                 ret =3D wait_for_completion_interruptible(&data->completi=
on);
>                 reinit_completion(&data->completion);
>         } else {
> @@ -401,9 +403,11 @@ static int sx9310_read_proximity(struct sx9310_data =
*data,
>         *val =3D sign_extend32(be16_to_cpu(rawval),
>                              (chan->address =3D=3D SX9310_REG_DIFF_MSB ? =
11 : 15));
> =20
> -       ret =3D sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> -       if (ret < 0)
> -               goto out_put_channel;
> +       if (data->client->irq) {
> +               ret =3D sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +               if (ret)
> +                       goto out_put_channel;
> +       }
> =20
>         ret =3D sx9310_put_read_channel(data, chan->channel);
>         if (ret < 0)
> @@ -414,7 +418,8 @@ static int sx9310_read_proximity(struct sx9310_data *=
data,
>         return IIO_VAL_INT;
> =20
>  out_disable_irq:
> -       sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +       if (data->client->irq)
> +               sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);

And so this isn't duplicated check.

>  out_put_channel:
>         sx9310_put_read_channel(data, chan->channel);
>  out:
