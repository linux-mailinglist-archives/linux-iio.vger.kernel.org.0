Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2E2319D1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgG2GzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 02:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2GzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 02:55:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA52C061794;
        Tue, 28 Jul 2020 23:55:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e22so1583097pjt.3;
        Tue, 28 Jul 2020 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U92rYb0+TwGY8zlPAefy1rRg023bgbGHmt6DlPysSbE=;
        b=VY6IUoYjKXKRjRWH0ph58QPyVXNjhf1ZrmDeymuKLS34LOaCvII7jQi/p9QBtzpRDf
         I1oZFIZsAkiUmiVX9antZvETncgRdreGJNXoyyTrAWkMh/eJt8SMA5rcJfVZzyWK2IvL
         jC5TZ+hRNbYfJ8H1EKaliqMMn/v6/Kvs2dFcTAq298FW7f3BYyr0WszmoUL7htFkxDtm
         qK5if0Zzf9fVJmWaFjIga89to7YQpmFVvQukJJ+7g4nU4bFg0gbB9eh3s62n+UxOukDY
         7zOcRlxkC79KIv9n9kuW9gRHMsr07KieZeiEmnR03aYYcaAlT1ro7Wt7a84EmljQhY1B
         2/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U92rYb0+TwGY8zlPAefy1rRg023bgbGHmt6DlPysSbE=;
        b=Foaac5k8T8dTncH7bajZb36TWW8Y3Zs+u9/fHZLO9zzhcCXpOvxI6L4844g6YvETVj
         PmEv9GHYzoBRTzM76ot7NV/MJrta0BpG5zkJJ1wbCxBT5kEL0ospfXKzUX39j7TJ+2jX
         a9m4CTuVq32LUfC3Y5OM2h8OPVfXur4bdOecdqupRal52wcZ+51gjJsZ2pqof9E2q2H6
         vkSj4mHwTcarhp1DolWTKzpL63VgzBgLsSYyU0DxaQRmuTmZ+EGsn14BnA2l3TvRdepB
         G0ewL9mN0X9hykJdnmjcBhXbIF3GjZjHJzmMlZd9MSum7+fpmMFBgRkldhnmrSvdY89v
         EA6g==
X-Gm-Message-State: AOAM532/lG/HkjxOzeiLbNFn1agHqmSs7qpwCpfEQID+gPO5mGKsD12v
        JcKGPVC2J4ThpeURfRaF7Zg7WsNadPyN3wgVKfc=
X-Google-Smtp-Source: ABdhPJxlzMpzxpTX2nZWp7zuUifsx3/qC2nScve7EvSpqfgAtH56PXOrZv3AreiCKdsRuYfWKzRL4h5c52N8VIIhzX8=
X-Received: by 2002:a17:90a:390f:: with SMTP id y15mr817996pjb.181.1596005705069;
 Tue, 28 Jul 2020 23:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
In-Reply-To: <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 09:54:48 +0300
Message-ID: <CAHp75VdYnXsB2KKkJZg-JRoSEkLz91BQwxaYR1uFMbbzU=M_WQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] iio: sx9310: Remove acpi and of table macros
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 2:05 AM Daniel Campello <campello@chromium.org> wrote:
>
> Avoids unused warnings due to acpi/of table macros.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
> Changes in v2:
>  - Added #include <linux/mod_devicetable.h>
>
>  drivers/iio/proximity/sx9310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 108d82ba81146e..04b646ae8a1009 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -15,8 +15,8 @@
>  #include <linux/i2c.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -1051,8 +1051,8 @@ MODULE_DEVICE_TABLE(i2c, sx9310_id);
>  static struct i2c_driver sx9310_driver = {
>         .driver = {
>                 .name   = "sx9310",
> -               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> -               .of_match_table = of_match_ptr(sx9310_of_match),
> +               .acpi_match_table = sx9310_acpi_match,
> +               .of_match_table = sx9310_of_match,
>                 .pm = &sx9310_pm_ops,
>         },
>         .probe          = sx9310_probe,
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


-- 
With Best Regards,
Andy Shevchenko
