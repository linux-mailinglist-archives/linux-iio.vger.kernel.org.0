Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E15228861
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgGUSiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgGUSiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:38:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423DC061794;
        Tue, 21 Jul 2020 11:38:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a23so9545652pfk.13;
        Tue, 21 Jul 2020 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nK0qyZhDC5FOaiCS+0m8+f94Mck9PjMzVoSYX7yYY/I=;
        b=QfwTkuihkP0iu36Lp5fIlAA/9PVqLMj1DUNgbSq1j6vhz1igzaFRbNcT10oxAF50OZ
         fwTEiJyW8omXyVmDrv/vFtGF7lu5T3A7UvAqvs8tm2ggRS7kTIb5jPJ7O1e31hcmlA9J
         zK3Eti1u55UWQJGSV4b8EvtPb7n93zrln2mF02n+XqGfYO6Wx6Ew/M8lNtORRu2Gcr/y
         LfU2EbwRRwGKoTmbL4uj2eufhcRPlKgYL9TrQGKxi8up3+vFi/jufBgyl57Vkwau1MRz
         JYD/aZxhc+Lb2zVoTkT9C0rhpkmcc+NbeMO3foWFF2qcI1PqjoACGbJrYKuXGXU3haYT
         ntKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nK0qyZhDC5FOaiCS+0m8+f94Mck9PjMzVoSYX7yYY/I=;
        b=cCScoR/Oi+mAxaZ1j+NiqOT+Iv14FMmz+xkv1quih/BssTN2E2Nid2hsKRQpySqHUm
         ncqT9CxLe37pjBJnPRGZxzpqIueP0okgOXoWCTmFcRHTx+uf0yZURThaIKtll3nee/um
         gfIr8AMSJqt/Y+jg3mbd/dGixOgZAqDLPihHNHTEh2PCkwFSlf4hZZsQt6e+kb8lX0nf
         48JdyKcQcbxl8bfJhh1KDicIRWQ+WsYWYF6jxhnrl1TPeb2IzLmo08AR9hyIubv6xCio
         vF5GzNzNnIMabwZ8lRUW1gXnHjvrY9G65VhZV/py+i25C6+koBOW51z3kgO6w/i0HAtO
         SynA==
X-Gm-Message-State: AOAM5315eMHg5B3S/fS6BGNmVWnwzA3eqseqqcaYsSzwqPPOdUM7hMZY
        UFJgoJ9qXyGqjdcxUOVuoLCSd8QHdMlY68itF3rSyj1V
X-Google-Smtp-Source: ABdhPJwl4Mn+VjJt/0js6aaU/ssjh5ofSGB7Ux0ae97IETnIaAdpXZsfRKrrmHuLDLuD4qqhlTKGIwZ78e6+TcOP/WE=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr24584523pfd.170.1595356684306;
 Tue, 21 Jul 2020 11:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200720134931.71537-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200720134931.71537-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:37:47 +0300
Message-ID: <CAHp75VfmvGgCK3Cg1nxPtYeF1Y9oQAKST1bAnKXxB2hpd8=feg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adxl372: Add OF device ID table
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 20, 2020 at 4:48 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Stefan Popa <stefan.popa@analog.com>
>
> The driver does not have a struct of_device_id table, but supported
> devices are registered via Device Trees. This patch adds OF device ID
> table.
>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/accel/adxl372_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
> index e1affe480c77..5197d1eb6803 100644
> --- a/drivers/iio/accel/adxl372_i2c.c
> +++ b/drivers/iio/accel/adxl372_i2c.c
> @@ -8,6 +8,8 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>


> +#include <linux/of.h>
> +#include <linux/of_device.h>

With the huge patch series from Jonathan I think you may learn that
proper header here is

mod_devicetable.h.


>
>  #include "adxl372.h"
>
> @@ -46,9 +48,16 @@ static const struct i2c_device_id adxl372_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
>
> +static const struct of_device_id adxl372_of_match[] = {
> +       { .compatible = "adi,adxl372" },

> +       { },

No comma, please!

> +};
> +MODULE_DEVICE_TABLE(of, adxl372_of_match);
> +
>  static struct i2c_driver adxl372_i2c_driver = {
>         .driver = {
>                 .name = "adxl372_i2c",
> +               .of_match_table = adxl372_of_match,
>         },
>         .probe = adxl372_i2c_probe,
>         .id_table = adxl372_i2c_id,
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
