Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE49370878
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 20:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEAStJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 14:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhEAStH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 14:49:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9853C06174A;
        Sat,  1 May 2021 11:48:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m37so837160pgb.8;
        Sat, 01 May 2021 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7W3JgmwHDep/UvnfXDHgnfK70cemiWTO4OL9vhnong=;
        b=VX6g7yZKf3wfvE1/ZrcdHsjYFjcG4a3oOUMUYZ8wOSepPa12pXo1GIhzoJEJumjp8M
         jwhPeaToMfPL/LqdQnOUQIw7j+97Hcl4gRHzbc2HZNJnoJe8CkxHrpWldTzZglXE0pOo
         Wy73LXJHTrI4j+mhENOi0oaEkYEyCndUOuP53CT/cI+AuWHd0N73TcljLgWyYZTlphDJ
         K13xJZFlOs/10ppuhvPVQIDJ4HqgvDho3VFMAwofk0uh8npIyMngqmZEfv7MrSu0y09t
         8plTNSFJc9ZG24KWZ0uCjOxQNxiZQUUSwrHsYS9LU+Mobs7NomOlZ0KgMONGpAqzqggw
         HbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7W3JgmwHDep/UvnfXDHgnfK70cemiWTO4OL9vhnong=;
        b=sV/C9iG8lCJCqWsxUma9rtf0VOlqR87xazw2PWlN0ZIwKmYsG+mo5IqCwNsDZTLh9r
         NCPmFWaOglKb0KzbgGpIAF2nHokMhjh4rhOoxUZ6wDlaZ+HpooSR0lTNM7k9LpAeowRp
         W0rTmioq/xWJZDITzwoxpsCr/SSUMMlmE3uA7u3DwjoeshgSmHjvxDqyAhcQ7egEgeba
         ksTCRhVz9XyM5p/w6OEOrNntR32Zy6+Eg4Zn+9Q84mAIFVUdA/rO/MB+vv9mcmjrhRXN
         A1NfpSr5heHAeH7fqwt+fRoGQ+eh+D5Sw19OFeZHqt8B+3wZr5tqVd3QHS3wuovK62ua
         W2XQ==
X-Gm-Message-State: AOAM532rQFFDSVfjOYtFGqs9Bo1TvvRlx05loMLoq0Ni8IojIZ6hHvdU
        wM9oqKZyUqCglBcuL6BkgKJOYLWtSyJpoAbqMko=
X-Google-Smtp-Source: ABdhPJzRxsRwZahNRsvo17YAvkoiBO0o2YQyd1DEbJYFN5Oox26Q9NA5SaN57vgb6VA3vF7WXBgB7LnJxdLjHtOLXg8=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr10418613pgs.4.1619894897277;
 Sat, 01 May 2021 11:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210430152419.261757-1-i.mikhaylov@yadro.com> <20210430152419.261757-2-i.mikhaylov@yadro.com>
In-Reply-To: <20210430152419.261757-2-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 21:48:01 +0300
Message-ID: <CAHp75VcZk_Brin=K7ofHkq9CV90LoqKm2k_ULrXLMCxWVWv9Nw@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: proximity: vcnl3020: add periodic mode
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 30, 2021 at 6:17 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add the possibility to run proximity sensor in periodic measurement
> mode.

...

> +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
> +{
> +       struct vcnl3020_data *data = iio_priv(indio_dev);
> +       int rc;
> +       int icr;
> +       int cmd;
> +       int isr;
> +
> +       if (state) {
> +               rc = iio_device_claim_direct_mode(indio_dev);
> +               if (rc)
> +                       return rc;
> +
> +               /* Enable periodic measurement of proximity data. */
> +               cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> +
> +               /*
> +                * Enable interrupts on threshold, for proximity data by
> +                * default.
> +                */
> +               icr = VCNL_ICR_THRES_EN;
> +       } else {
> +               if (!vcnl3020_is_thr_enabled(data))
> +                       return 0;
> +
> +               cmd = 0;
> +               icr = 0;
> +               isr = 0;
> +       }
> +
> +       rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> +       if (rc)
> +               goto end;
> +
> +       rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
> +       if (rc)
> +               goto end;
> +
> +       if (!state)
> +               /* Clear interrupts */
> +               rc = regmap_write(data->regmap, VCNL_ISR, isr);
> +
> +end:
> +       if (state)
> +               iio_device_release_direct_mode(indio_dev);
> +
> +       return rc;
> +}

The code will benefit in case you split above to two helpers, i.e.
_on() and _off().
It will gain better readability.

-- 
With Best Regards,
Andy Shevchenko
