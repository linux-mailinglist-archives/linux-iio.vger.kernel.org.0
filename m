Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DE3820B6
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhEPUB1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEPUB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 16:01:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8252C061573
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:00:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d11so3848207iod.5
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0EF+O7GPExbd2A2WnJ0L2myYdAjshCOooCjDvywwIY=;
        b=QExxBJjd54g2vJpmW3GDfsZD9bJ7VMHZKcVyOhdVgH+AC7jfOkMxp2gsswRT40uMX0
         Ce8rsR8CaL9hq+wBFVuAUOEVcWA+eDqvI8M1S3ZOHpFKhG8od1SZlTKN0K/ogNEiCfxj
         dFJVPXztGMMypN7Lh+NEAcPEDcdVTh5k/0pOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0EF+O7GPExbd2A2WnJ0L2myYdAjshCOooCjDvywwIY=;
        b=qpdAdxVDD7GKPFWLKO2KJNj/AVEXk05bjfKR8O2h7hECfF+P2yXA5rjyx1Ek49x5yK
         kQr38yO+9jxMAdwrfBYQw/eimcEk94rkobvULNOKSMHSKp5yr60tK38atnM+xVQEiOnQ
         TAiMVs77ibHZTxsYZ48OL1nl0PnNF3eJzxPjZ1tSeojkLBdhgOIR30lLKE+KixxGDcKx
         D2VjajWS/Ygij2ZkpWjLMWy0kxZGxC6XrM3MaVsW1bEnFHdSBtWekZ4GWnfNOg01lY+K
         ih0Tfh4pTJOpZqRG8Qw0HActaJjPhiC2gzR1gn46WienVdcQ5oRs7YlYN+JxZvLPCDae
         dSZA==
X-Gm-Message-State: AOAM532vSbXMdKCoxRu+Q3EgBLUuZNmJybdV6u113DGza5ZE3/M14L3c
        nW21HARtATvWy/POQRLDFLyA2X9D5vE0xE+Sdjlakw==
X-Google-Smtp-Source: ABdhPJzEVONVaaL/QZ1Wh66hgnfN5o/N8UwtSem/3Kv63R2xzCrzxOlbaSRRyydzemvwTD+Lb5lBzb4nhyxbeUC8x+8=
X-Received: by 2002:a5e:8305:: with SMTP id x5mr41409636iom.112.1621195211011;
 Sun, 16 May 2021 13:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210516162103.1332291-1-jic23@kernel.org> <20210516162103.1332291-4-jic23@kernel.org>
In-Reply-To: <20210516162103.1332291-4-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 May 2021 12:59:59 -0700
Message-ID: <CAJCx=gmbeS11+JbAVxYR5q=mcq1ikomKeSmHhZ7UD2xnJa2+Qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 16, 2021 at 9:22 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The pm_runtime_put_noidle() call in remove isn't balanced with any get, so
> drop it.  Note this isn't a bug as the runtime pm core will not allow the
> reference count to go negative, making this a noop. However, it is
> confusing to the reader so let's drop it.
>
> pm_runtime_resume_and_get() replacement found using the coccicheck script
> under review at:
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
>  drivers/iio/chemical/atlas-sensor.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 0fdb3b29c5eb..9cb99585b6ff 100644
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
> @@ -741,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
>
>         pm_runtime_disable(&client->dev);
>         pm_runtime_set_suspended(&client->dev);
> -       pm_runtime_put_noidle(&client->dev);
>
>         return atlas_set_powermode(data, 0);
>  }
> --
> 2.31.1
>
