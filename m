Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E2240314
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgHJIBl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Aug 2020 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJIBk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 04:01:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F34C061756
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2020 01:01:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so4742509pfn.5
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2020 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2M+hWY57ToYAt5QrVv379XNqX96RixZbB1Pn/ixjYCE=;
        b=hFBhfRncAAGpaswZHvJa2kc+lQFBEIkOJl639ePLlrwOnMbvfDIvLZXhH3e5oG4p/5
         XbMbYAaImgjnVB9cTRkreMVcrqkTDicWvkHM0MqFbjZ8a7clUJcB2ntQ7Nu8lmZpBmDw
         l/0WyLWr9/dVESduyQItSt37D+8pFA5SYHK7pEFkXl/XIyyfUsHrTBVZQOFj+yPrr6ki
         2VxIE82nERMrhGvP/NV0vZ+lqMKHllW7SH1dufqvMv7atH4pWPQe0B1UxFQT9oAhYsuI
         YvE6rQXD3U8csqIwvrpd/YkQ1x1gCFfyQEUsVo/+Ivrml/jcbEVsJZzvxZiPq/WENM/C
         mmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2M+hWY57ToYAt5QrVv379XNqX96RixZbB1Pn/ixjYCE=;
        b=ICWPxN+/ks/AKTEqgsVHWNOqI8NxVWC2Clf7B3S2DQEGiiIOfippo2vfqUHUgu9Zdj
         oTAiqFVNnOuUmILMXKr1DurQZyQCJfM58IqoNALre0iV6RZMtkGcbORMLlincr0cexz7
         dRjpvd/kQg35ftYgxeO4BkCvn8QHsBtsoNGFFKvH5eIX3W43dXDL6NNP1VArwaBsRHa4
         OgYW3P6IWC1+ABM1xV8s2RIRfe0RKtViLok9FNia41x5peKsYmLUA+LDT3fFrC07DenQ
         spqoGgLTsWSPEMj9uUVlgx9qUUizqVtx3kJ9v7zLgSOAwjlTulSWUnKEYgSYoRbvG3Ul
         3txQ==
X-Gm-Message-State: AOAM531ShSifpbz7Zm+F/NWVdq+WoqUSxjGfYCSLjrgN/IBwOVat3HWU
        yprUM7iNPmNKch0/OqO5GXhYwRQJDlb82afMhliL3wtEUqg=
X-Google-Smtp-Source: ABdhPJz9xai6nx1isSVYWDaXUurZNdblabVasddRUSSMQPpr7X8o+3u+L5Glle1h+vOh1+4+3/5UiMQFxodeG1MNK4w=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr20643046pgk.4.1597046499465;
 Mon, 10 Aug 2020 01:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200809141305.205993-1-jic23@kernel.org>
In-Reply-To: <20200809141305.205993-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Aug 2020 11:01:22 +0300
Message-ID: <CAHp75VfLNRmEQ3L217H05My4+9Erhj9+EDd8ONX5bM+=gP5bwg@mail.gmail.com>
Subject: Re: [PATCH v3] iio:adc:axp20x: Convert from OF to generic fw / device properties
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 9, 2020 at 5:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst fairly unlikely anyone will ever use this driver with anything
> other than DT, we are trying to move IIO over to the generic interfaces
> where easy to do so.
>
> In this case this involved moving to generic check on presence
> of fwnode, generic device_get_match_data() and dropping the of_match_ptr
> protection.  Also relevant header changes to have property.h and
> mod_devicetable.h only.
>
> Also drop the casting away of a const in favour of retaining
> the const throughout.


Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Quentin Schulz <quentin.schulz@bootlin.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> V3 changes: Tidy up the commit message as suggested by
> Andy Schevchenko.
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
>                 const struct platform_device_id *id;
>
>                 id = platform_get_device_id(pdev);
> -               info->data = (struct axp_data *)id->driver_data;
> +               info->data = (const struct axp_data *)id->driver_data;
>         } else {
>                 struct device *dev = &pdev->dev;
>
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
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
