Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA033A457
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhCNLIQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 07:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhCNLIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 07:08:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA8C061574;
        Sun, 14 Mar 2021 04:08:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e7so6750758ile.7;
        Sun, 14 Mar 2021 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2gJVCiOzZRSOU8yuw0xGh2d/ty3OmRn7TDCBELtPRw=;
        b=PUBewag3El8v206Nhk0atvmek2BUNWAPufAsSR2oFncOGGqfyNv7vAEsE508yviQfA
         n5FGHWLw0byj3iMYTL4/2+GP7CfPDWHGQNgY/XmlQ88CNaGlm6tPK+fyKFaHe84+3Fn0
         dWpe4RqrQondbTZ9U7FHy0RAXu1QD+zWeDL352Vc0/j+vswzAj1OoZ6Gea8lrLg+qybq
         J/PHZzVjafdO3woIfsLANMVipxpYsbmoCdX8jwP7ihawUg9gp6d2dFbxMk+Ywmjp5pvq
         eLdPgW8sN3EiSG2XRnks4Jj+81N457OrzYREhZzOGnSS6Kn6nRvm5Ruxad159ceO0Xre
         /CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2gJVCiOzZRSOU8yuw0xGh2d/ty3OmRn7TDCBELtPRw=;
        b=nJDKemH65HGwU4BNSemrpJ57vlC4j8eXTtzpPFMQkMb61vyjUbWYemP7hK3guH0FKj
         GM3CucMuURKHKF2C9cwMdMtoVJ/ShfChvT2645Nbd4Vxsre5yoMBvS+ylmR7O9rWEhV3
         Pq/DoxCm5xWF00dUNvmlszNL+NNSvIDWVxwNzlJXMKhuxIVR/7M5CW53tfjhZvbPnOXQ
         G2GyBAB3mYJi5d0L8azSP1ziFSztIl6rrgDUZUogPcEQCOlPIigiQDEWM808ptZwAtzw
         oXfImKN1uakUdRAtvJhZ0WnpUhlKLdlRgVOvP/uJAIVjzkc/0gRLG0a7nWaNEX9iBL0z
         UH/A==
X-Gm-Message-State: AOAM5331ZyRb3daqCW1c/nzS0qN3xHHcaFmo1Opjwv7w+QO8es59Ztit
        PWY2z9G/FYWI+wnf8fUUIJrt6oINdZP1Zg+8aVc=
X-Google-Smtp-Source: ABdhPJwybSdTGkZm7YJAMqXFYWPwEvQytGccmmznnyQod+aeJmwsGhJLE6r6AFZtaZndTOAAbR+HVZRPbgBmZFCrWfQ=
X-Received: by 2002:a92:3652:: with SMTP id d18mr8662777ilf.100.1615720083436;
 Sun, 14 Mar 2021 04:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210314093356.10609-1-dmugil2000@gmail.com>
In-Reply-To: <20210314093356.10609-1-dmugil2000@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 14 Mar 2021 13:07:52 +0200
Message-ID: <CA+U=DspBephozOheNQYBX9jG6bdwm4FeOTF_9tEggOWNvTQ32Q@mail.gmail.com>
Subject: Re: [PATCH] iio:dac:max517: Use devm_iio_device_register()
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 11:34 AM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
>
> Use devm_iio_device_register() to avoid remove function and
> drop explicit call to iio_device_unregister().
>
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> ---
>  drivers/iio/dac/max517.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 7e01838ef4d0..5f72f126162d 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -189,13 +189,7 @@ static int max517_probe(struct i2c_client *client,
>                         data->vref_mv[chan] = platform_data->vref_mv[chan];
>         }
>
> -       return iio_device_register(indio_dev);
> -}
> -

In this case you can also remove the line with
     i2c_set_clientdata(client, indio_dev);

A lot of times, when functions like i2c_get_clientdata() get removed,
the i2c_set_clientdata() function becomes useless.
i.e. it stores some data that will never be used in the lifetime of the driver.

It isn't always the case that you can do that; so, some care must be
taken to avoid special cases.
But in this case, you can remove the i2c_set_clientdata() call.


> -static int max517_remove(struct i2c_client *client)
> -{
> -       iio_device_unregister(i2c_get_clientdata(client));
> -       return 0;
> +       return devm_iio_device_register(&client->dev, indio_dev);
>  }
>
>  static const struct i2c_device_id max517_id[] = {
> @@ -214,7 +208,6 @@ static struct i2c_driver max517_driver = {
>                 .pm     = &max517_pm_ops,
>         },
>         .probe          = max517_probe,
> -       .remove         = max517_remove,
>         .id_table       = max517_id,
>  };
>  module_i2c_driver(max517_driver);
> --
> 2.25.1
>
