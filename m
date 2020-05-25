Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C71E0E1E
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 14:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390364AbgEYMIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390312AbgEYMIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 08:08:38 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AA5C061A0E
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2020 05:08:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so10400338lfd.7
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2020 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CHAAKFX3pEaSff34cERZoUYbpxCNcU2X+3WVAr0kFk=;
        b=gjOUxiJcvU7kd1nAL1KpnclOmR9URRq5eYNI9VZD/PKAcjH1r802SkGZTk8F3ZnDBs
         Z4ikvH0/vGC3PLD7CozcWqmuaR/2yvjleRhrY0sIl7dGApkgwmkaZ5QlfHnz+pPk1EVu
         jzM1lrEGCLze/JGcwqmIO7WrWmHYezwicvnMfJpfOw2p3A1LaizOMixR93jzOYiap58M
         cnEMKu2w+RLcbgNvGH9xn1WDrlZuwJJdLBKGnONE3PK6BSn8uypv3EWdAl9tWuAHiHJm
         qUeUlK8VZdFaMHxHTTiDPBbQfNxy6BUNpqPL90yRiLeSSMR9cVdaHU8AXdI9zKJa92mq
         xjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CHAAKFX3pEaSff34cERZoUYbpxCNcU2X+3WVAr0kFk=;
        b=jGJOf5N3F1NVe5/3glDlrbnnJ7m0+rBo8hlm68FQqDVUFx+ZDj5aOok3yIRveH+Jkt
         Mjsgt5pIOQWSuMPvyLuJx7Nlf2uTYMUXrddL1qx6MJNzzALPi1HUdWUiueLv2qGl55Eb
         GDdMd8gJ1NdHv724he0UGK/skzy/UvmOWpkhNipBvQlB64QsF/Utj7YmIwv4NiRCI+lY
         KgBJsIr5TE47BAKjGH+VTTomDX3ImwJMcD2Wl3t0zF0gpD9LVVOLlGpwryVaqGOWhEsi
         dUSYYMVh2zUJ8c1djoLOdzIe4ThA6/VTytaInSOOdcmnkywvYTX2eWsUyvTu+3oF9Cbb
         caIA==
X-Gm-Message-State: AOAM530ZzPy0PeC2BpqEDtryvXvESDZkAnN4KesSCUvrWmTwExYkFZjR
        tTMNqAyE2yZocI/hMfP8GgB1s/ACDE9XkZJNif91xA==
X-Google-Smtp-Source: ABdhPJwK3vZKxsHvTjeywR4/47lTwqIC3Ne4uIwlSTe4pBmxjbgQnN6Z6KOagErCzzkOb263sgfT9u1oNO3O1EnMQ4k=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr14099568lft.194.1590408516752;
 Mon, 25 May 2020 05:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 14:08:25 +0200
Message-ID: <CACRpkda9ENYMLZVnTzN2rn9UvsMOWpeDnOhh7zs4ttAJqgipKw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8974: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 24, 2020 at 4:51 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When devm_regmap_init_i2c() returns an error code, a pairing
> runtime PM usage counter decrement is needed to keep the
> counter balanced. For error paths after ak8974_set_power(),
> ak8974_detect() and ak8974_reset(), things are the same.
>
> However, When iio_triggered_buffer_setup() returns an error
> code, we don't need such a decrement because there is already
> one before this call. Things are the same for other error paths
> after it.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

>         ak8974->map = devm_regmap_init_i2c(i2c, &ak8974_regmap_config);
>         if (IS_ERR(ak8974->map)) {
>                 dev_err(&i2c->dev, "failed to allocate register map\n");
> +               pm_runtime_put_noidle(&i2c->dev);
> +               pm_runtime_disable(&i2c->dev);
>                 return PTR_ERR(ak8974->map);

This is correct.

>         ret = ak8974_set_power(ak8974, AK8974_PWR_ON);
>         if (ret) {
>                 dev_err(&i2c->dev, "could not power on\n");
> +               pm_runtime_put_noidle(&i2c->dev);
> +               pm_runtime_disable(&i2c->dev);
>                 goto power_off;

What about just changing this to goto disable_pm;

>         ret = ak8974_detect(ak8974);
>         if (ret) {
>                 dev_err(&i2c->dev, "neither AK8974 nor AMI30x found\n");
> +               pm_runtime_put_noidle(&i2c->dev);
> +               pm_runtime_disable(&i2c->dev);
>                 goto power_off;

goto disable_pm;

> @@ -786,6 +792,8 @@ static int ak8974_probe(struct i2c_client *i2c,
>         ret = ak8974_reset(ak8974);
>         if (ret) {
>                 dev_err(&i2c->dev, "AK8974 reset failed\n");
> +               pm_runtime_put_noidle(&i2c->dev);
> +               pm_runtime_disable(&i2c->dev);

goto disable_pm;

>  disable_pm:
> -       pm_runtime_put_noidle(&i2c->dev);
>         pm_runtime_disable(&i2c->dev);
>         ak8974_set_power(ak8974, AK8974_PWR_OFF);

Keep the top pm_runtime_put_noidle().

The ak8974_set_power() call is fine, the power on call does not
need to happen in balance. Sure it will attempt to write a register
but so will the power on call.

Yours,
Linus Walleij
