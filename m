Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5694BCCDC8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 03:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfJFB5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 21:57:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44557 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJFB5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2019 21:57:00 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so21415379iol.11
        for <linux-iio@vger.kernel.org>; Sat, 05 Oct 2019 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfSUEEil4QWABz4sAsJXciZnz4w3PkW8WWsIR/qy9vI=;
        b=nJtZFFIHOI8yHcmZcvZDr7Sgq580Q3oGqtaFsmXYYvW61XN0v3gd2Abd5SHXzo0Bj5
         RnB1x2pm62OQ6XshrPsfWcqy2jfiowdayQ7qzbh2cQMcZ/Ty4lSZUwPt+pEJQSVNQVsW
         UnhrdMmpITS1WGGe75Eu8aSv70+Fmo7jFQJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfSUEEil4QWABz4sAsJXciZnz4w3PkW8WWsIR/qy9vI=;
        b=FvzoIVWr7Ofh++VIdXDo17oyGmBfDunKYK0l2YbNAfqm0k1fd+pldW7YovPq8X4Gnj
         Fhp1vkvMU9u3VwurCn1sJ7N1/XhnmaFPtG3bjYXvwNLkwFg//CGJx51WVOP//BfmbkYP
         yB8j4Ed0QcDuCpX+UG8vCR9lVJWe+btS9YBZc9QMJYCic5ca+UVIAeeCKeWpZ9njA4F2
         +RDOdO0z6QhzIzB2Kxe0wL4VhN+d0a5yTg1J6Zs0lBF6jRFBhhx0vHsGV1XyxaPKh0VJ
         6XS6gTQCEc1cDVQblbWNghJ8J3xhuh8txArdZgr+JpOnLUFyhfXStfOwhe4WeRgCdnGv
         imyw==
X-Gm-Message-State: APjAAAWA3u06AiazMNQ/gF2OapNFXin/+aVo0WPqqZ6DIEmG2J0UINoU
        i8kKevRGHyCBUGFq8zR3yFMx84BOsAQ/u1UeQiUeTg==
X-Google-Smtp-Source: APXvYqzjIDr3VGrYy1tgIRumhuPxoi31jBZnMciu9rDoVIKr9JLHBBhONht/MfXNZ90hE1xKtFLWl0xUsB4IocIBq6U=
X-Received: by 2002:a6b:bd42:: with SMTP id n63mr7649064iof.53.1570327019078;
 Sat, 05 Oct 2019 18:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190920073122.21713-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190920073122.21713-1-alexandru.ardelean@analog.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 5 Oct 2019 18:56:48 -0700
Message-ID: <CAJCx=g=y9xDHHZ06wjGNRVG0hLVSsWQZJJcPVTtAxmYVW8dwxw@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix iio_triggered_buffer_predisable()
 position
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 20, 2019 at 12:31 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
>
> The iio_triggered_buffer_predisable() should be called last, to detach the
> poll func after the devices has been suspended.
>
> The position of iio_triggered_buffer_postenable() is correct.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Sorry didn't notice this till now. Looks good to me.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 3a20cb5d9bff..6c175eb1c7a7 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>         struct atlas_data *data = iio_priv(indio_dev);
>         int ret;
>
> -       ret = iio_triggered_buffer_predisable(indio_dev);
> +       ret = atlas_set_interrupt(data, false);
>         if (ret)
>                 return ret;
>
> -       ret = atlas_set_interrupt(data, false);
> +       pm_runtime_mark_last_busy(&data->client->dev);
> +       ret = pm_runtime_put_autosuspend(&data->client->dev);
>         if (ret)
>                 return ret;
>
> -       pm_runtime_mark_last_busy(&data->client->dev);
> -       return pm_runtime_put_autosuspend(&data->client->dev);
> +       return iio_triggered_buffer_predisable(indio_dev);
>  }
>
>  static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
> --
> 2.20.1
>
