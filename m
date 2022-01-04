Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562C4483C00
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 07:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiADGlY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jan 2022 01:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiADGlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jan 2022 01:41:23 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD0C061761
        for <linux-iio@vger.kernel.org>; Mon,  3 Jan 2022 22:41:23 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u8so43075549iol.5
        for <linux-iio@vger.kernel.org>; Mon, 03 Jan 2022 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9tKcGF2cUl8XUR3bGWRtfEGBDa1DUmuRbqcyOgu+uk=;
        b=jU18jziaKEymd2xoG0EL1NVVdI14YWfgnBdTXNGU6yyYko8SCZFqR3xa97Kkbenkxd
         S9wogc206MgIG8b1D0xceRWScnDKaVSPiBNTaVlBHMaorMUmgniO6i/jcosOiVtyzwQ2
         54e2Mu82fqR11Of4NWKu8bC+yx4GVnEYB8DgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9tKcGF2cUl8XUR3bGWRtfEGBDa1DUmuRbqcyOgu+uk=;
        b=ofCY5+kaa8uQctLrZt4A7vTX49KsK+y0F7m79xJhcfblek09ehoxCTtgm8y3sDO4CJ
         7mHoe2HRWC1DpCSr7UxHlCMG9I8ZSNHiefNGLzJNC/Hl3IDY88jRFZjXgWQo8brfyiPt
         cUym737CSjepCtUcwI7ZiY3f5axy3NrNqZuoxlY96mOKb205hNbdCyxPufNO9f+iQMo1
         EFf4m4ihSfQ0OlBlDZIF2w4BdF1VwlIDCsJYxjKRwiAludP0ujrywGP0/SnF6LViSbSL
         vc+dYbblKogGP5OF9abuEcDdJsnxuHpQvELNU3gwQXYZbyUzIfzrm7XgA1AK7OdgJk0q
         2zRA==
X-Gm-Message-State: AOAM532Z6uBr8EnCOm87fvgwb+Fq6cWgvzpS/fY2GGwT/lFjA6V+fp0N
        qayC0XNECMex3YzqgEUckgNFfZhw3bicrO7gO/1dfw==
X-Google-Smtp-Source: ABdhPJzzzQYmlkdGTR5v394lr6YXe450S5Eu2CLHlyGviQ5XbvWkA1Cw6uUy4d3F/rCNJ/XFS/8iNb65sTQUs59tRhU=
X-Received: by 2002:a02:ba8b:: with SMTP id g11mr21512869jao.20.1641278482546;
 Mon, 03 Jan 2022 22:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20220102125617.1259804-1-jic23@kernel.org> <20220102125617.1259804-40-jic23@kernel.org>
In-Reply-To: <20220102125617.1259804-40-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 3 Jan 2022 22:41:11 -0800
Message-ID: <CAPUE2uuy7+LxhJoNybakih__jKuaUfvopCbcTS2E7a-g3y0aFw@mail.gmail.com>
Subject: Re: [PATCH v2 39/51] iio:proximity:as3935: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 4:52 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>

To speed the transition to the new PM_OPS macros, we can use cocci to
automate the process a little. I had to use sed script so cocci can
identify the structure and function names:

find $DIR -type f -name \*.c \ -exec sed -i 's/static
SIMPLE_DEV_PM_OPS(\(.*\), */gg_type \1 = gg_arg(/' {} \+
spatch -sp_file no_SIMPLE_DEV_PM_OPS.cocci -dir $DIR | patch -p 1 -d $DIR
sed -i 's/gg_type \(.*\) = gg_arg(/DEFINE_SIMPLE_DEV_PM_OPS(\1, /'
$(git diff --name-only)

where no_SIMPLE_DEV_PM_OPS.cocci is:
@ Replacement @
identifier operation;
identifier suspend, resume;
@@

gg_type operation = gg_arg(suspend, resume);

@@
identifier Replacement.suspend;
identifier dev;
@@

- __maybe_unused
suspend(struct device* dev ) { ... }

@@
identifier Replacement.resume;
identifier dev;
@@

- __maybe_unused
resume(struct device* dev ) { ... }

@@
identifier Replacement.operation;
@@

- &operation
+ pm_sleep_ptr(&operation)


>  drivers/iio/proximity/as3935.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 51f4f92ae84a..5716048e228c 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -295,7 +295,6 @@ static void calibrate_as3935(struct as3935_state *st)
>         as3935_write(st, AS3935_NFLWDTH, st->nflwdth_reg);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
>  static int as3935_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -337,12 +336,7 @@ static int as3935_resume(struct device *dev)
>         return ret;
>  }
>
> -static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
> -#define AS3935_PM_OPS (&as3935_pm_ops)
> -
> -#else
> -#define AS3935_PM_OPS NULL
> -#endif
> +DEFINE_SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
>
>  static void as3935_stop_work(void *data)
>  {
> @@ -472,7 +466,7 @@ static struct spi_driver as3935_driver = {
>         .driver = {
>                 .name   = "as3935",
>                 .of_match_table = as3935_of_match,
> -               .pm     = AS3935_PM_OPS,
> +               .pm     = pm_sleep_ptr(&as3935_pm_ops),
>         },
>         .probe          = as3935_probe,
>         .id_table       = as3935_id,
> --
> 2.34.1
>
