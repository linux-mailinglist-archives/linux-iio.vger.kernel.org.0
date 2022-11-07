Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9861EF94
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiKGJve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 04:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKGJv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 04:51:27 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70F1759E
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 01:51:26 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i5so5127804ilc.12
        for <linux-iio@vger.kernel.org>; Mon, 07 Nov 2022 01:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AoL7FmVz6r2tQd3mQtIVijHkUaNKI+DE6r8B6gf4Szc=;
        b=Xlm2fAzrOt2ZZDxIu0KIVrjRQsV+klFfJZEfDAVW/WmWb6oNhpCU0ltFiyF6DkT6fc
         h7/WrXKC+1RJ/DMVEcFBSWArdxhYJfjinNUYYNKPiLiZ9sQPZxqaQEH3SGL/uJ7JG5fX
         2KlC3RX7bsBlQYZ1wYjWhOrOL9jxB2lX0V4AQlM1DR9vIqYpc0pwJawLH2nGkIaJDGK7
         BMRBiodPtuFHwijEtJWxKcyWavxz0QrzSQRUkpZB1cxNh9USa+Iw6H1rOdoSTaE6OtBP
         DubAbKtcJU2GrXZg+ljj7VjuAAp+pFTCn3f9/B9jlEKAYLeEG4nob/Tg/f/4/WRDmRnL
         YEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AoL7FmVz6r2tQd3mQtIVijHkUaNKI+DE6r8B6gf4Szc=;
        b=DukgZOMtx4wIJZmETF0Ru3dLZqlGOO/oQb+5ritY8tt88UxAoLhj11HuZP54AOGzXh
         +V5s+WybWJ9ilBo2A4gPeFL0YmjEtYX3MVSfEmKAXep1OAFTE/VmqnJR72Ijt5kPtj2k
         Gcqtl8YGnh90DSV5oMWxLX02IydeoyQor9Tp83ImhfSoSORA/H2hwRXhFJwtzWre/+5+
         3inz1C2OnV6THCH2hY9ARASQo95CL4W8jv2ARmEFEEOYQgfW52uvkvXQwxlzdfAOLZff
         bWi+H4KwmUJm8Owp+TDthDgo+kqus7m97K6uiOIbL5VNIEYafgcuWLW8WgljD9mVWyM+
         uuMw==
X-Gm-Message-State: ANoB5pnVzbE3AvepYaEbquacLRJq/HyiSGC0ycJLsNRERWOTcfLx4g8J
        bRaPJxOsW95yj3zM9J9hnrsDL023HZ0As5//cip5hA==
X-Google-Smtp-Source: AA0mqf6f372MSR+G4wC8oTUp1GHEW4r965N5qfKoYdXa+K5td4iYYWhXSFY9cFQasyGT++RxTeUGGmXSa3UXzp9LUw8=
X-Received: by 2002:a05:6e02:1aab:b0:302:770:3997 with SMTP id
 l11-20020a056e021aab00b0030207703997mr5424759ilv.34.1667814686277; Mon, 07
 Nov 2022 01:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20221105125108.383193-1-jic23@kernel.org> <20221105125108.383193-3-jic23@kernel.org>
In-Reply-To: <20221105125108.383193-3-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 7 Nov 2022 10:50:50 +0100
Message-ID: <CAKv63uvOxSD+65aYpHEavnaO3R4YcuwPe6NopY5sXcBX4GCHVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: temperature: mlx90632: Add missing static
 marking on devm_pm_ops
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-off-by: Crt Mori <cmo@melexis.com>

On Sat, 5 Nov 2022 at 13:51, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Only used within this file, so should be marked static.
>
> Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 7572ae3f8432..f1f5ebc145b1 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1326,7 +1326,7 @@ static int mlx90632_pm_runtime_suspend(struct device *dev)
>         return mlx90632_pwr_set_sleep_step(data->regmap);
>  }
>
> -const struct dev_pm_ops mlx90632_pm_ops = {
> +static const struct dev_pm_ops mlx90632_pm_ops = {
>         SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
>         RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend, NULL, NULL)
>  };
> --
> 2.38.1
>
