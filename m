Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1E254FA2
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0UB3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UB1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 16:01:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02886C061264;
        Thu, 27 Aug 2020 13:01:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 17so4329176pfw.9;
        Thu, 27 Aug 2020 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvjSdv4nUxPfwBP9PKjoRBAQ4y+6+2F4ni6LT9Fuaqw=;
        b=H8LyWEgNqOpDRjSSDYB9n9KmWL3CtBr2jnO1bgCkicNJQLaAzjXu56afxptqb2MvJr
         QE+3oafRBg5l1ARaKoGkOAqtmaPZR2pYOm1smalhZaJv6ND6sCy2q1yMwD1CQb+ny5bT
         jo+/Uve7QIH8I3TGoiXlFrnRmFnDrMxL41sZa2WJlyMnxr/ewFu0azP2BolPZNw8FL9S
         mYFfPBlosvKpNaNeBlCPfPbQOFWX775syR8FZmU9289TyTEPXQOOZi+KDmdAGqZC7Ir0
         Zuy0V/AZ0QwQ0N6MekI9WFEVkauZr4xejAvIIW+nQw6Phj7CBtrcnlI69zL1vrD0KYAs
         xc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvjSdv4nUxPfwBP9PKjoRBAQ4y+6+2F4ni6LT9Fuaqw=;
        b=YrzgJ/bAC033qpc662807NVU+JhTe78PjE9vQLqb957gOoGS5BfnLQGK3hpWkID8vk
         lC14HNrlk8TeZTvwge7eMYsZES6t/aAW7yPQTQuwSnxBH2nC8a/CIqvA44dSfcZjCTM6
         2Yc2r5wmjGRz4hmStXy4HZObED7YPUi942K6oXLFH9JEz4qlAECY7zYSWi7oYbyzn8aq
         v0MCoF+6t8/SUFfCuNu1amGsD8obLTxgddetglZ38AQCjgwasP8D+z4s7AmHP89MMW3Y
         R0unK96mPRd3cunP1bicrGUZShVuYxzR3BcIhipDmo94FBqq0xNgg510aNqVIWGPy+1R
         3CRA==
X-Gm-Message-State: AOAM532VcHJUZTyUyndWj+dEvuUqH/poThRtcu3+jLbBPb5D1LqhYcFN
        pjvX7YTTgK9vg/FBi/eJoeIOFnsMj32e2QDugSw=
X-Google-Smtp-Source: ABdhPJwSRYUZsSB/8KnvgLSmu13GxDxmWJ06S1nuD0ZKldgoptbvJ3SrDq+X27CzDqiFe3ukQbDy/QDCjgIaF8SxOns=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr15676744pgk.4.1598558486512;
 Thu, 27 Aug 2020 13:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-16-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-16-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 23:01:10 +0300
Message-ID: <CAHp75VdTTH3ZNxoFqsXLMBnGcBwaCdRZYUJrHBznvcb46i9Afg@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] iio: magnetometer: ak8974: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 10:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Wrap dev_err_probe() lines at 100 character
> ---
>  drivers/iio/magnetometer/ak8974.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index cbb44e401c0a..548c686e29d6 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -843,15 +843,8 @@ static int ak8974_probe(struct i2c_client *i2c,
>         ret = devm_regulator_bulk_get(&i2c->dev,
>                                       ARRAY_SIZE(ak8974->regs),
>                                       ak8974->regs);
> -       if (ret < 0) {
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
> -               else
> -                       dev_dbg(&i2c->dev,
> -                               "regulators unavailable, deferring probe\n");
> -
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(&i2c->dev, ret, "cannot get regulators\n");
>
>         ret = regulator_bulk_enable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
>         if (ret < 0) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
