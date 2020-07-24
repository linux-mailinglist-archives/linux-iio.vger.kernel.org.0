Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667EF22D194
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jul 2020 00:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXWCh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXWCh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 18:02:37 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74881C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 15:02:37 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id o25so3435859uar.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGzC+sVdjHSu3GhMjbQg0qh4uA4cJT945O2o3Z2Av+I=;
        b=Duthh2stsQSdK8VnX81qLigVLWKcai2/zxrcazQ226LqX4/Hf1SEtz0LOwfBg+u72L
         Id1NqmpRjVHC60o3JRr1yd2uuOC2SFgUAJjvb30Qb94tGZ5wnHxmtuV2ETMbKrCrx9FQ
         EegBSyKwEMTpwVTCJt15UDY1/63ElhyJ26QC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGzC+sVdjHSu3GhMjbQg0qh4uA4cJT945O2o3Z2Av+I=;
        b=qt9TkOwRc4AuD+5KFIXGLz3FXUpgerXl8NTyxOkyhOKirHCtXCHIr5jKbCAyMPGp5t
         dsNGs2M3PkcIeIND9TlZLza6GLx7OtuAz/DsdaNMwyW/HNYtp4oORTtn5BKhDKOFfBh2
         SOaTRes8p5+YFTumZ5JL56aH8cfqUSwHXCzuTiLknB4dGn5d0yCkFXqsq/rN6kYJE4S9
         /oj/V45u8ILeViz/NpxxzjCZVi49vyE8RU+tUVWnpc09h04kBE0zG2aArr0ZFCDOKItM
         lqUbFPxmDSkUz4ON48tSyN25C80/TMw6aw+HS5bzo3Op1ZfjI05D7eAnZK/jHMNPRJQj
         iY/Q==
X-Gm-Message-State: AOAM533r34ihi7+R/vPCYVcKB7YBF4Msz3Otqn/EMtZUOFQdAGl4JIii
        F3DfYL3q2YT6xiYl0scn1bQUC9JHRzY=
X-Google-Smtp-Source: ABdhPJwLfSLgdiEkM0SCygwpQko26Sh89QalrjDQHRDFD34H/YE7QAePa0ilyY5EQiZSd8UhuBIiBw==
X-Received: by 2002:a9f:2265:: with SMTP id 92mr9886230uad.49.1595628156405;
        Fri, 24 Jul 2020 15:02:36 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id v63sm286469vkf.45.2020.07.24.15.02.35
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id b24so3432259uak.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr9883887uan.121.1595628155128;
 Fri, 24 Jul 2020 15:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-6-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-6-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 15:02:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
Message-ID: <CAD=FV=WKTsCB=7rDSgjqE5w00SsayBd5OT9O65sjkiM9crS5aQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: sx9310: Enable vdd and svdd regulators at probe
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Enable the main power supply (vdd) and digital IO power supply (svdd)
> during probe so that the i2c communication and device works properly on
> boards that aggressively power gate these supplies.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 1e1f6bba50f6..ad6ed100c7a6 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
>  #include <linux/iio/buffer.h>
> @@ -899,12 +900,21 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>         return 0;
>  }
>
> +static void sx9310_regulator_disable(void *supplies)
> +{
> +       regulator_bulk_disable(2, supplies);
> +}
> +
>  static int sx9310_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
>         int ret;
>         struct iio_dev *indio_dev;
>         struct sx9310_data *data;
> +       struct regulator_bulk_data supplies[] = {
> +               { .supply = "vdd" },
> +               { .supply = "svdd" },
> +       };
>
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>         if (indio_dev == NULL)
> @@ -919,6 +929,23 @@ static int sx9310_probe(struct i2c_client *client,
>         if (IS_ERR(data->regmap))
>                 return PTR_ERR(data->regmap);
>
> +       ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(supplies), supplies);
> +       if (ret)
> +               return ret;
> +
> +       ret = regulator_bulk_enable(ARRAY_SIZE(supplies), supplies);
> +       if (ret)
> +               return ret;
> +       /* Must wait for Tpor time after initial power up */
> +       usleep_range(1000, 1100);
> +
> +       /* Update sx9310_regulator_disable() size if this bug is hit */
> +       BUILD_BUG_ON(ARRAY_SIZE(supplies) != 2);
> +       ret = devm_add_action_or_reset(&client->dev, sx9310_regulator_disable,
> +                                      supplies);

...but, but...  Aren't you storing a pointer to stack memory?  How
does that work?  I think you either need to store the "struct
regulator_bulk_data" in your private data or just make two normal
regulator calls.

-Doug
