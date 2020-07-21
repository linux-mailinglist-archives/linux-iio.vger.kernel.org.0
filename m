Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900E228837
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgGUS3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUS3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:29:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A3C061794
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:29:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so12330323pgc.5
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2020 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEfVyHpPfB6xcmy3whs2E4kinDnpEVD88pZ16wpYHCs=;
        b=pdABKYl9y/mAfwEgQa/ElaKbjUDLUwvvK3Bi71skVdoz3d9h3DH0vpPlVoulVdpNO6
         u0aiAI59s/a/ChvOVSL0GQ2T/Sk1NaLtHfcLaW1EhCFhk65riJmdwsapcyUUAlYZmuyT
         tZEMU6/IvC4SMq5KcOIlsGYGFL7TUn3wLV/KItpVT0naoKIve5rTxD/RqRLi6w4DsJKg
         yWB1IFhJbd/SFLyiiM6/auSLBycIoVEZ6aqncBibOx7JEFgJ8X4GzbbtXJ+gGjoRvOPs
         M7kCTHngIOrP3FXwRSM4RZg+W2tmuFzqQmaZor+kEVYNcOHwZswfYdFud9bi+lp724/k
         QCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEfVyHpPfB6xcmy3whs2E4kinDnpEVD88pZ16wpYHCs=;
        b=hsPyRB5UwMhd3pAQo3u7OnWfI0seda02SQvyJJygzIBq01uQwX0XfomFSAg8XkXGFZ
         CgY3oIBMLw5ojbL6sXTOqbjeaiaBO2TeZioIJsOeSgq+IfE3oL2H6i14pT+vy+Hf8X6Q
         7fG+d7Ubde5O9D1VBA5dtaP+89t+m8GwQAtBS0NvISIcZbmEy2e8Lw9g+vr69gTW9tbn
         W6cXMQ2R//W0Em1ZsQrcRUNA26IacmBvLt+B6uyF5wLeBaSwTG3J0vMp5yB4iskTAGZH
         Fa1zD6gt5oisTWvShzWTj+1BDY4C4A5FS8eYfkvDNLgRsUNPV0OZnJloEMBYI1wAygI5
         7RuQ==
X-Gm-Message-State: AOAM530EKUr4I+W4tDLDnH0hcx/VaJ7keZGm77nvbMQ/ZosxO1sOLfZF
        gPKQnkQNPQ7/cIFaNuWQG+1W4ROHLDiMFaCGdY0=
X-Google-Smtp-Source: ABdhPJxJBSATN5YYanu1rX/5gEeR8uzBeH66IDXYKHvnbsgaBLA7sKtfJ/G/rI9Q+vyPz6IIhizhbAeMriJGlait5gk=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr24555831pfd.170.1595356159880;
 Tue, 21 Jul 2020 11:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200721171444.825099-1-jic23@kernel.org> <20200721171444.825099-2-jic23@kernel.org>
In-Reply-To: <20200721171444.825099-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:29:02 +0300
Message-ID: <CAHp75VehvPa3Z-or4zGmEOgj-+8cXfJSj5w-ghbnCSVPumyPTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio:adc:axp20x: Convert from OF to generic fw /
 device properties
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 21, 2020 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst fairly unlikely anyone will ever use this driver with anything
> other than DT, we are trying to move IIO over to the generic interfaces
> where easy to do so.
>
> In this case this involved moving to generic check on presence
> of fw_node, generic device_get_match_data and dropping the of_match_ptr

Please refer to the
- fwnode
- function()

as established practice in the documentation (and thus commit messages).

> protection.  Also relevant header changes to have property.h and
> mod_devicetable.h only.
>
> Also drop the casting away of a const in favour of retaining
> the const throughout.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
> v1->v2
>
> * Avoid the casting away of const by keeping it const throughout.
>
> drivers/iio/adc/axp20x_adc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 798ff2d89691..3e0c0233b431 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -9,10 +9,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/thermal.h>
>
> @@ -67,7 +67,7 @@ struct axp_data;
>
>  struct axp20x_adc_iio {
>         struct regmap           *regmap;
> -       struct axp_data         *data;
> +       const struct axp_data   *data;
>  };
>
>  enum axp20x_adc_channel_v {
> @@ -670,15 +670,15 @@ static int axp20x_probe(struct platform_device *pdev)
>         info->regmap = axp20x_dev->regmap;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> -       if (!pdev->dev.of_node) {

> +       if (!dev_fwnode(&pdev->dev)) {

After the below change I think you may use positive conditional.

>                 const struct platform_device_id *id;
>
>                 id = platform_get_device_id(pdev);
> -               info->data = (struct axp_data *)id->driver_data;
> +               info->data = (const struct axp_data *)id->driver_data;
>         } else {
>                 struct device *dev = &pdev->dev;

This is probably good to have for the entire ->probe(). Or drop it
here completely.

> -               info->data = (struct axp_data *)of_device_get_match_data(dev);
> +               info->data = device_get_match_data(dev);
>         }
>
>         indio_dev->name = platform_get_device_id(pdev)->name;
> @@ -742,7 +742,7 @@ static int axp20x_remove(struct platform_device *pdev)
>  static struct platform_driver axp20x_adc_driver = {
>         .driver = {
>                 .name = "axp20x-adc",
> -               .of_match_table = of_match_ptr(axp20x_adc_of_match),
> +               .of_match_table = axp20x_adc_of_match,
>         },
>         .id_table = axp20x_adc_id_match,
>         .probe = axp20x_probe,
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
