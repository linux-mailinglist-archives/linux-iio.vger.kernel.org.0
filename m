Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5ED20EF45
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgF3HZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgF3HZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:25:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E30DC061755
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:25:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so1557271plk.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fatHyVfhtp8JcImWm17T4AdoKoc/9JSdDzcjhpbsolo=;
        b=uCj4mvymif8HPaedK9WUUSqob9WJ74SOM/2XWZJYKE6TZ7LcXzMUMjpZurHbUfs0Dl
         gl846V/yBaqcFaOyhovhok37MjeGOHzR3tjXoOnwPZ/1/7TGviT9BUNtG0Horm4E4Uni
         HMxUNNs8eH+DAwENTOeyfv7v23U6VdoY8NVN+j6vbrZ1QDlPTBlWZNbULHTdozIBmP88
         z7XqqvIBtwEmyXxq8DyMvkDuD8hB0dIz1dub+YymXFfY3JsKF2ORVBPaQC6kMYLaHAdE
         VDXUMU/D5T7VpXtidS1+9ejpxZdMY1pqpUg7kfTrVoYbDOTqHgJSl0mMkjfHZy0aqpQN
         f21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fatHyVfhtp8JcImWm17T4AdoKoc/9JSdDzcjhpbsolo=;
        b=jjbgolQz2XR+5EFWZkUkXS6b3A4Qfk2tiQloBNucdmAbjo0lzuL4IFv8F8p8mW1z7l
         JScMQDaesVNXiRtq+aEnLTs2hZGvIA/+H+u14lKKCbjO8f2v2vFqp8xvXuBhtDWRZzt8
         SNa3WYHtGykQW6E1YH3fT8c1HQU7xq3xId4UbrCOyuVBjzUaeWyRKz/G/G6DYXVi84ak
         ZmL7XPnmB0uFEJ2vVNQbqvxt9Gg8hInajB0W/g8TuEjc3muH4XwFk/RKsAfzWQ7X+T/r
         4xA9Abx8HjlrswWN2u+s/qLlCoG9rnXGYBfQOJ0PTxsekFP4hWechq9ZlwD16miX13k4
         xAQw==
X-Gm-Message-State: AOAM531VfJonQ1QGpnr6YdScarRIOkVDXOPPE1IOKSFCit2R4cxJseOA
        /1u/vKjXMNCpFE9b4ab9zttTrLFiMdjEYPid2to=
X-Google-Smtp-Source: ABdhPJyEX1SSV3AzOT/WENU4Ptwy3/xKYs0WFlKMYPWZGuO6wOi3PErZg215+f5iXffWc4wYOJHex3+GzGmkmjIAACI=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr20897913pjr.181.1593501938089;
 Tue, 30 Jun 2020 00:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-23-jic23@kernel.org>
In-Reply-To: <20200628123654.32830-23-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 10:25:24 +0300
Message-ID: <CAHp75Vf7vfEo9vrL3GseZNfSZWugQtKrks+eCvR+z0NKMgMzAA@mail.gmail.com>
Subject: Re: [PATCH 22/23] iio:adc:bcm_iproc: Drop of_match_ptr protection and
 switch to mod_devicetable.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst it's unlikely that this driver will ever be instantiated from
> ACPI PRP0001 there is little advantage in using the of_match_ptr
> protection.  The switch of header is because we only use of_match_id
> in here and that is defined in mod_devicetable.h not of.h.
>
> Note the main reason for this patch is to avoid providing instances
> of of_match_ptr being used in IIO that might get copied into new drivers.
>

Commit message is misleading. The change won't help with ACPI due to
syscon_regmap_lookup_by_phandle() call.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 936da32faa9d..44e1e53ada72 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -4,7 +4,7 @@
>   */
>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/mfd/syscon.h>
> @@ -617,7 +617,7 @@ static struct platform_driver iproc_adc_driver = {
>         .remove = iproc_adc_remove,
>         .driver = {
>                 .name   = "iproc-static-adc",
> -               .of_match_table = of_match_ptr(iproc_adc_of_match),
> +               .of_match_table = iproc_adc_of_match,
>         },
>  };
>  module_platform_driver(iproc_adc_driver);
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
