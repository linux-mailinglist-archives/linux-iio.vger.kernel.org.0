Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F692D711A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391467AbgLKHuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 02:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390532AbgLKHub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 02:50:31 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18568C0613CF
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 23:49:51 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p5so7914513ilm.12
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5jPW5xrdnXrUmlqPwfg6aea4TyLHiSibriUPQtVJL0=;
        b=UbZPpDkEFz1NsaD896NDjcCUrPz2Xqkb17fx5J4t/YJVEhGdMKXWcBM8NqGwR0ZmH0
         zkkiwiM0r3KqqYDYGxeheGfp21px3GDSlBhx9d/fndSaLGfgjwyLotjteA/RooQZHeVW
         3HOKEpzB96Ls9H1v17yvE8AraAymw/rndgoi2FEFIODvoeyIX230zhxfDPI7GQbtMo8V
         2taWcBkj5rmW3bngEdplwDPbRsJ4M+4XQi+l23SydpQgA2Eb37q1ZbsVUt4frA1a9QfC
         y85z4sk4kaPLl63zrBxmB4ZcrRBAd3B8Xw7ojkVHYYrahCzBe3D9q38tKL0ofKbY0Rv9
         Q6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5jPW5xrdnXrUmlqPwfg6aea4TyLHiSibriUPQtVJL0=;
        b=pjmGx5bdyISGSXGrkuW3dZRnoi1m1XMMENRk+dQ8jmm9sKNJpufDU03GBgDX8kYosl
         feM95r/pk/BMgYHlVXzYDjmpBZkh90cEv5r3Z6jV6OxzwEYqxNWiwCTN7AVxzL6snjeK
         V8RAYnBC+5qwf4NBJ7AoRNUM4jbIwgM7ajTDdyZFtmaYfdz/7lyf0FNJZorBW11BK64W
         Aj0JpOXiUUQJ0wAE/4NUFhdBeXrg1R6+mteFE0hshe8AlTBxj4b6KAHUmSstv+b9ZgFV
         5yVtAbYy6Y+9X79LSegM/A6zZP9Fc/vHF+x14uROP/R7cpGw2GuQf7PN0TKuVu7XSu4j
         0ZsA==
X-Gm-Message-State: AOAM532FCgXidBlJv6gKHShHWApsoApLp9/mFrOVSHM7SJOh2cmZdRIL
        43/LsECORWzImgJThUzZEPktm9IQcNTLrlEtqvg=
X-Google-Smtp-Source: ABdhPJwP/R5BFuLq9DMU8ns5DCbqo8SXbbN6qX93VCDyX70MoNdYUhj1jnc/HxSwj4ZaOCPo9ZFoUNE2EG0gEKfgNC4=
X-Received: by 2002:a05:6e02:12a2:: with SMTP id f2mr14433224ilr.292.1607672990583;
 Thu, 10 Dec 2020 23:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20201210204211.967018-1-gwendal@chromium.org> <20201210204211.967018-5-gwendal@chromium.org>
In-Reply-To: <20201210204211.967018-5-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 11 Dec 2020 09:49:39 +0200
Message-ID: <CA+U=DspyeOM1ctF18D1iQTkvg2MfOmOeTVoNNfKwn3wjW_HQAw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iio: gp2ap020a00f: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Already done in boiler plate code

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/light/gp2ap020a00f.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index e2850c1a7353..d1d9f2d319e4 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1551,7 +1551,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
>         }
>
>         data->trig->ops = &gp2ap020a00f_trigger_ops;
> -       data->trig->dev.parent = &data->client->dev;
>
>         init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
