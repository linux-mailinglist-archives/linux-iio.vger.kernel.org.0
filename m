Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE7D5728
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 19:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfJMR6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 13:58:39 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43530 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfJMR6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 13:58:39 -0400
Received: by mail-io1-f66.google.com with SMTP id v2so32641368iob.10
        for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2019 10:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgjciGW3EUw8J7QiKJ5CuBFqgOpr7DEABczokyzu7Ys=;
        b=TOyr4vv3PCHCncrNU0f36ARpDUDfcSPIIpxXwajgFAFve8ejXBpgAU4rNFFRNjJnLQ
         LpF50UulLkS6ZqVW9tAxKU0rgAgfdYixSK3u9sgOCIqxy1J2ntHq0PLx7bEJEdyk44yv
         AZMyhdde0bk10RkZ/kgQBR0PoRr50OEfM9/w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgjciGW3EUw8J7QiKJ5CuBFqgOpr7DEABczokyzu7Ys=;
        b=BInjXk/36XHoiMafQsgj9EHjOoTn76UOjgVQ7r1zY3rFpNxuHl0DoxqramGf01YJdf
         i3MSlQX1x4SY3a9mxQihHKffq8YCnMZBuen95KusOi5XGo0qTUkprchrMGePaEs5paYE
         nNX8ECWzlwLPpWqkqXJu+mq/6x+ZI57Nj7T1OQfJwPCKBIvQACvukPfXkoPacjjteli+
         09aFnt9xFlCyxV5Uou+GS+RVsxWve/Qh9PkSwLpm4zON01yxRRApm7ya92Ig5horVS+t
         Ny02RaixC7kpjMzygalcsy9o4xksFQEPZ0uLNsigHPtXPYRf6BeLtwtbc3zvuXBxGgfS
         qC3g==
X-Gm-Message-State: APjAAAUWC0/HIewjgZ4p2iUjqTptkdfI0fo/PO+zwdhTa6zIcl5msBn0
        LSocq+6s7kYS1xkD37PJfXuo386Pb0Ixj/VFX/tDwQ==
X-Google-Smtp-Source: APXvYqxYNJBRmhV6rUc4U98GQ6/wbOrmWQWZUbIfJXFxwOTI04pCM9l0oY40/m57AM9t32P1qWmqfLoagk5UTMTbPxc=
X-Received: by 2002:a05:6602:2547:: with SMTP id j7mr15260259ioe.77.1570989518042;
 Sun, 13 Oct 2019 10:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191013102600.1463679-1-jic23@kernel.org>
In-Reply-To: <20191013102600.1463679-1-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 13 Oct 2019 20:58:26 +0300
Message-ID: <CAJCx=gnYkdwOOspqa_WynyPsDo8pLhPN3_5UNj6Z2bGWoxr_2A@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: pulsedlight v2: Tidy up an endian issue
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 1:28 PM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Sparse identified the following
> CHECK   drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
> drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
>
> This cleans up by adding a local variable to hold the value whilst
> it is __be16 before applying endian converstion into eventual destination.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 47af54f14756..5b369645ef49 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -136,12 +136,13 @@ static inline int lidar_write_power(struct lidar_data *data, int val)
>
>  static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>  {
> +       __be16 value;
>         int ret = data->xfer(data, LIDAR_REG_DATA_HBYTE |
>                         (data->i2c_enabled ? LIDAR_REG_DATA_WORD_READ : 0),
> -                       (u8 *) reg, 2);
> +                       (u8 *) &value, 2);
>
>         if (!ret)
> -               *reg = be16_to_cpu(*reg);
> +               *reg = be16_to_cpu(value);
>
>         return ret;
>  }
> --
> 2.23.0
>
