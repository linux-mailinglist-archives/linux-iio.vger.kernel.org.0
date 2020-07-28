Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08323117F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgG1SUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgG1SUD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:20:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E98C061794;
        Tue, 28 Jul 2020 11:20:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so12427041pgm.11;
        Tue, 28 Jul 2020 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZBzta7lAYJUOw09aiHa5V4Dk9/7UMQ8wjoH5iK9UWo=;
        b=qnNiheKfcwNExALiaamHgrgGkn6Z2ZsQ5wMoA7wPH2CPmqGPHwo4tqJGkYYeZH/HAP
         uxeo9k3YaQBcD3eiEQeLj6WpFL5n8p8uA8AURwPEnG9D8V2AD8Wu7tDL9cMt/d1BioB9
         dcWXCLgE60m9eOhxyd9378D+VcowrlGY5oTDEnZNNSlVp3hFhzc2Xixy27a7acX0RE/q
         eNKC1YIK8vaxaRiLZqEfydBvFu0B9B6iZmBg91jpESc0iooViHcuMBHIm9i6IEAv1bX1
         YDgI2LuFyW/wF4ynRroMRY+xfvGPc0iXwONQ19siE4N4zxkjCc48tqirI+PHhdEG8zIG
         WGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZBzta7lAYJUOw09aiHa5V4Dk9/7UMQ8wjoH5iK9UWo=;
        b=VXq0jY2hMUTubgpdJFC8GbB+D8y/BAD7H2q2gffEpXgg7z2agbad8lc+3LIxrqa2fH
         tDtkGhEfc9E1+sOgfXmw+OPgNrgZcyOrSkpzg9eOSczkv9DGCZZT1ymjNuSnBosPvlCR
         K2V+/CtkVuHxYl3kyycv0xJkzMuFIHXzPwvJh3MPD+fvI2FZsiAOiJhwHCPQAp2Fa+Tm
         +kazt5lBi2ZmR3mNf1qXL2uYUHL4LwFbpSAbYy5whdgOHEirwwtHLUpP7Hz9mjVLSd12
         fYtyUSjBDpKAm8OE9jhgLAyL9FB/jMWdtVY6Dp5gOMBrEP/RdKVCu9YuDpXuAw220TKP
         +BgQ==
X-Gm-Message-State: AOAM530hrPhUgbHMqB5jMcJef1ffZ0eWPc7oQXZyY1U0u5iX2ps0kw1N
        d2G+VxW6eCpgcdlrqRd4QmYZVGNicoa55+XJGVU=
X-Google-Smtp-Source: ABdhPJxpZgdYnVr2qsORcDCPC8Re24qRNfIJfjFQhiEGF8anSzvzcoEBrNRm4TSBgh4a4FXYOQhlUSpbencvaymMsig=
X-Received: by 2002:a63:924b:: with SMTP id s11mr24826083pgn.74.1595960402390;
 Tue, 28 Jul 2020 11:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.13.I14600506d0f725bf800c8da4ef89fdb3c3fb45cd@changeid>
In-Reply-To: <20200728091057.13.I14600506d0f725bf800c8da4ef89fdb3c3fb45cd@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:19:45 +0300
Message-ID: <CAHp75VdSxkgd-+CBTNUJD+WUdOX3e1x3Ysap=D9+33Yo1Kk+yA@mail.gmail.com>
Subject: Re: [PATCH 13/15] iio: sx9310: Add newlines to printks
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> Printks in the kernel have newlines at the end. Add them to the few

Printk()s

> printks in this driver.

printk()s

> Reviewed-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>

It has ordering issues
Should be

Fixes:
SoB: Stephen
Rb: Douglas
Rb: Daniel
SoB: Daniel


> ---
>
>  drivers/iio/proximity/sx9310.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 3f981d28ee4056..4553ee83a016a3 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -809,7 +809,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>         if (ret) {
>                 if (ret == -ETIMEDOUT)
>                         dev_err(&data->client->dev,
> -                               "0x02 << 3l compensation timed out: 0x%02x",
> +                               "0x02 << 3l compensation timed out: 0x%02x\n",

Looks like ping-pong style in the series, i.e. you may fix this when
you introduced this line.

Check the rest (and not only printk()s) for the similar style and
avoid the latter.

>                                 val);
>                 return ret;
>         }
> @@ -855,7 +855,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>
>         ddata = (uintptr_t)device_get_match_data(dev);
>         if (ddata != whoami) {
> -               dev_err(dev, "WHOAMI does not match device data: %u", whoami);
> +               dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
>                 return -ENODEV;
>         }
>
> @@ -867,7 +867,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>                 indio_dev->name = "sx9311";
>                 break;
>         default:
> -               dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> +               dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
>                 return -ENODEV;
>         }
>
> @@ -896,7 +896,7 @@ static int sx9310_probe(struct i2c_client *client)
>
>         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
>         if (ret) {
> -               dev_err(dev, "error in reading WHOAMI register: %d", ret);
> +               dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
>                 return ret;
>         }
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
