Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149982438F7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMKy0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMKy0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 06:54:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2245C061757;
        Thu, 13 Aug 2020 03:54:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so2473252plt.3;
        Thu, 13 Aug 2020 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=026T1eG5lZk+Wr91d+c3pl0tT533eyHDT1un/ZVIEiQ=;
        b=N5g4MUvi3aX7cw4+QxHxSCaHu0HzL9AeTap8dDQfgMkVFxtzETldAZzXAdpY+jbNKI
         CnnDbCPonLGmZrJdN7NEEJDjfxb8qUzHsLv/Ht0wEKYnNJJ9tPTZBWShQBw5+h8Pn4hr
         LbZ1kcQ+QPko2tFgW4ASzqfIx1Zbb2Ycczf36/dJqP2cF1XkhEFgn3a/gBQGBhZvxUlA
         AOSfrlPRvT4Ep/bInbBDA9WeERb9K1nRXQsQGp9zu6JBBLTGC7uNVI9LLb9/bd/Gf6dy
         CotDoqyxdwYd9pUJ0oltzGOeeVyMTFYzHngH5BObxCr6NOtOxCcGZux2ntnRQ7jSW7zW
         FBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=026T1eG5lZk+Wr91d+c3pl0tT533eyHDT1un/ZVIEiQ=;
        b=Twzj6UGKVsn/GJmxCse1+QiFMW08AHruxMzYoPGLNJWQBK+wdddQ2APiI51EyytjhV
         5JO3HpsQRIZ5uCH9/AxM+GC3ge0rWKUhWhn7QO7VyORF9M2Reo7xadP/luGEBuo3ptD8
         Oe5zlGVE5PYCq+pBG2EQewdG0r5gGWNsTz3xgBxk2z9fr9KbE6e0vP8YKPtf1jwMK4Ob
         b42YosDcj0W48zeaozGmxrPvTxvGTG6rQRqucB7frgNp6h27cIFpc0rbOS1IDEb/XaTs
         dIN0W4O/wHNFoHV4HkPv65lHRcslsCfCuOqx2YDDszU340Elic5VnSItUEHMv9a7E509
         aSww==
X-Gm-Message-State: AOAM5334nUIn5w8Hiwwz+SwURHVWhPdCD4vBEu84/GxhKKEDVyBz/Loy
        W0ZrplGAeemZSL+kn/du2z7Imb50REUaR1yG4wI=
X-Google-Smtp-Source: ABdhPJz3SSmn8gR4W4NFbW4GPuuVS3v88BRlmU6R2ZhnspZZTqdHUwI6xo75LP306ipW5G/4PtsGz7q0ZvJzqiuD8LU=
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr4332425pjv.181.1597316065322;
 Thu, 13 Aug 2020 03:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-3-cmo@melexis.com>
In-Reply-To: <20200813075125.4949-3-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 13:54:09 +0300
Message-ID: <CAHp75Vc3_WkUQOaC86aKe9Fh88Zpip3brShyR64KjXJBt5rrng@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] iio:temperature:mlx90632: Add kerneldoc to the
 internal struct
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:
>
> Document internal/private struct for mlx90632 device.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index c3de10ba5b1e..ce75f5a3486b 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -89,9 +89,16 @@
>  #define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
>  #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
>
> +/**
> + * struct mlx90632_data - private data for the MLX90632 device
> + * @client: I2C client of the device
> + * @lock: Internal mutex for multiple reads for single measurement
> + * @regmap: Regmap of the device
> + * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
> + */
>  struct mlx90632_data {
>         struct i2c_client *client;
> -       struct mutex lock; /* Multiple reads for single measurement */
> +       struct mutex lock;
>         struct regmap *regmap;
>         u16 emissivity;
>  };
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
