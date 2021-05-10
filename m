Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA72377986
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 02:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhEJAiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 20:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhEJAiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 20:38:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DCC061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 17:36:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w13so457282ilv.11
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YS2uZUqo6KsgBNHQLgUQkMZON369j9rpi8fPtcvhVdk=;
        b=KCBGo+fakQCyxCVUoG/0Ej2nPkw74r3s+V0e+I4NRt53rCA2rzf7a86ztmQ+pK9WWY
         lkNK04RWyXXLATnhccbheWCJynuYzCEOoWx4q6KZ8I2/LAzlZnCypcGLIh/rSk47bSuu
         4KBw2OR6c9CM2QEJtB9Ktx218oq4/Dh3NqB7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YS2uZUqo6KsgBNHQLgUQkMZON369j9rpi8fPtcvhVdk=;
        b=KOnTed/ADgALfXb5iO71II1GJPQb4h9kR8iVM1nlfCu2I8HU+gs859WSG/Z7pj9qJ/
         JaEx5xDOrkAJw25xxeds1kL5GdxY94dbOpSvkIwLtJIfP2ciit1UN/kfwTlmktVnHm5R
         MNXAixuqeCa6fMKqLIscgF5p2kWWfRd5uBrBvusUYPOpLeXhPLwpShRDy3EyGRKPILLN
         7sDHsBnA0G7A//P9y3GNVqaM2onUgeE6ux5TVEZh0VoL+JNkBPAnQOHj1HHS+Ta3kEn+
         BGuFnFwvcjOVm4FaWPR6rkZutjJQokoTdgrsEYB436U7YC2Q2iRZQJDJr4BicJf+Gk5X
         MSUg==
X-Gm-Message-State: AOAM5310xAJMVFmUU4FlK9YvSJkIN9vLjSK4wVd/fGCnZRo2okVeP+QV
        b2us5WEbto2t3MrYiLVqj253DytS3I1mofcc5UMnFA==
X-Google-Smtp-Source: ABdhPJwt+wcNncgn3rcRgp7GDgq0gQNI/Vu7RhqCdOHwNUO+J3C1I8QmG/eVvakP5VpfNq40oupi5OpqF4wD7/6Je2I=
X-Received: by 2002:a92:ad07:: with SMTP id w7mr18676029ilh.98.1620607019283;
 Sun, 09 May 2021 17:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210509113354.660190-1-jic23@kernel.org> <20210509113354.660190-19-jic23@kernel.org>
In-Reply-To: <20210509113354.660190-19-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 9 May 2021 17:36:47 -0700
Message-ID: <CAJCx=g=-UgQ4Q4X_XwHbTcRs4yZYB586xTRgBdcNnDxBg58ZBw@mail.gmail.com>
Subject: Re: [PATCH 18/28] iio: chemical: atlas-sensor: Use
 pm_runtime_resume_and_get() to replace open coding.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 9, 2021 at 4:37 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
>
> As pm_runtime_resume_and_get() returns <= 0 take advantage of that to
> change the error checking to if (ret) which is more in keeping with the
> rest of this driver.
>
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index d10f921b233a..90bb3f5bff19 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -410,11 +410,9 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
>         struct atlas_data *data = iio_priv(indio_dev);
>         int ret;
>
> -       ret = pm_runtime_get_sync(&data->client->dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(&data->client->dev);
> +       ret = pm_runtime_resume_and_get(&data->client->dev);
> +       if (ret)
>                 return ret;
> -       }
>
>         return atlas_set_interrupt(data, true);
>  }
> @@ -487,11 +485,9 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
>         int suspended = pm_runtime_suspended(dev);
>         int ret;
>
> -       ret = pm_runtime_get_sync(dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(dev);
> +       ret = pm_runtime_resume_and_get(dev);
> +       if (ret)
>                 return ret;
> -       }
>
>         if (suspended)
>                 msleep(data->chip->delay);
> --
> 2.31.1
>
