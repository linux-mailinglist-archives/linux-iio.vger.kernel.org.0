Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3428A475054
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 02:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhLOBLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 20:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhLOBLE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 20:11:04 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8DC06173E
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:11:03 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so22965633otj.7
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UG/0sQ14QZswuwQj/wSz2zNJWW363tA1/CAAMqV/KSA=;
        b=hFvM02v4A9MXdWCWrgbMqrvKFUDeLWyO2iqlRyx5vM0RL7mAk6uwlq/ZnqWUXe87ny
         EIYDsZDUW+RqmrT9vt2bVGWDu0NvRdzmCmSv5JnN7xd6IUUJt+YsCAepFrePo22xx+P0
         lOEU80oDsLXz+fsJ9A/DWMhlAoDdeu+tDtBMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UG/0sQ14QZswuwQj/wSz2zNJWW363tA1/CAAMqV/KSA=;
        b=TX3f+9/XDfFnflnRrgd5Qxm81pixEFSpD9knr7OcOiuiC8yrIJzeXBxBYanHWt+57T
         8l5CTJcbYiuwpS2DNRAijbNhmWnWU3op+jZfAn0szMPqw5+gXWwRxD8JQmYqVATIGycB
         BqG7Ds7lQuyBRhuyiOrJqko2DovNF0rR2SoBt6ePuB9tOIKDx95jTzoOwMhDszywaiRT
         USPXgOT+LtU7xu6hW/ABuwzIUF8nQJGotFTR1bAz2T1r0Tw0bNA89YySMQcs+cQ8NHJ2
         olNEvY7YkKPesMhw+QxagWMtNEdWSjARncCdUMvm0IBsTYX1P2Z3Xo2V5SxOlTwl6lFz
         hGUw==
X-Gm-Message-State: AOAM5301X37TZurFZ7Su9KVf9jEhbJ+fyzpYofpKaHgpJZglLc/BuDpY
        6kYd27sGj6jJkl/JXiea548H65UErozDeZCUkLNQxNwqWD4=
X-Google-Smtp-Source: ABdhPJwrjFVegSz9z+1kBBjfV+SzIlcW3foCphQ5Y1ythcmPuJ9rM9pivs6NMalSW76de82RQL2FEFDH6bMagtrqQYk=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr6757364ots.159.1639530663267;
 Tue, 14 Dec 2021 17:11:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 02:11:02 +0100
MIME-Version: 1.0
In-Reply-To: <20211210192328.2844060-3-gwendal@chromium.org>
References: <20211210192328.2844060-1-gwendal@chromium.org> <20211210192328.2844060-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 02:11:02 +0100
Message-ID: <CAE-0n503kdCNHUj7KsjS_1kXmDoGZQkAYD3m5-EcS0tgCCX_FQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-12-10 11:23:25)
> Before adding new Semtech sensors, move common logic to all Semtech SAR
> sensor in its own file:
> - interface with IIO subsystem,
> - interrupt management,
> - channel access conrol,
> - event processing.
>
> The change adds a bidirectional interface between sx93xx and sx_common.
>
> The change is quite mechanical, as the impacted functions are moved
> and renamed.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 7c7203ca3ac638..e88fc373c2c903 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -112,11 +112,15 @@ config SRF04
>           To compile this driver as a module, choose M here: the
>           module will be called srf04.
>
> +config SX_COMMON
> +       tristate

It may be useful to have a help here as a comment about what this symbol
is for. Like

	  help
	    Common Semtech proximity sensor code.

> +
>  config SX9310
>         tristate "SX9310/SX9311 Semtech proximity sensor"
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         select REGMAP_I2C
> +       select SX_COMMON
>         depends on I2C
>         help
>           Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
