Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945052D7135
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgLKIGw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390215AbgLKIGj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:06:39 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97400C0613CF
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:05:59 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id q137so8568914iod.9
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4c0NnrO4dM8/LQcDdzojkirCdiiZmmugYm6UycKVcr0=;
        b=faxodaGw7wodve3j8vpeZkJKmg1n42VYcTziaioAPE+Bp/2jzJHERWwNG3xGWoFf5W
         zPodl+DK84Kf+2Av+EKXfPIN42mAWpKaW7EWF96WDnBMePQWe9e5ryh+2iDSS6i+EZ7Q
         An4kf3yxHjOVsc9K0Y/62H2otWeFKH7xptJ2ucOuzDroHLNMCORngQQrNzLJCzXvm698
         jE/CdPcAGhku8cIyrCS4OUL5hgs0A3sqS+pHzonP/xnVSljeEhhxSbXoBnpblNnpes9e
         To0ROAej83VM6tg6pdZU+bAx+7KlEA4fIak/Uos02574UznG/TkLpk7uiUwjlYfsgiYp
         eNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c0NnrO4dM8/LQcDdzojkirCdiiZmmugYm6UycKVcr0=;
        b=D2mlsixQBfv3CP3qiWR+QP9IhPD1MXMLWwSNqhQjF3SvqxSSi+Jgp0b9paMILLLb4f
         0BqOuHC9R3qF/dh4JWTdn2KNUNG/+cfuV+0KUWVLuV0QtOZhZrCsXOpLmglYLgUNDbMV
         3AW4YqAENS+PiRD1CNDm8+IV/JpWXb6hw6yu04QlMmjEMMjEK4n1MxXUyjm3et6xfGT9
         eK6w83ohGa4qb8rKL9btAuvckD3wvPpECJYI/nlhdzoI0J7tbnoSaneESufTulZaxXvA
         hnOYX+JoJ+uFLSElzM7iLrFZsanHADkDUVQCC2UkISqFbizRmXD/Y3RiaMir1rTOHPtV
         oA6A==
X-Gm-Message-State: AOAM530Nd5gO0b2iZHMPSIVEKo1OBnF2wAKWfHV4dQlK9TgpowY8Swxu
        8gXALhbK7xHDn68XnSZ9RLBgUTGWFFxOZKXamXyj8Rx0gtk=
X-Google-Smtp-Source: ABdhPJwhW9J8/cr+SZQfw3oUHrCzbUKFgYopPghi+JTXy4+ijcKhdQ/JDR3JfLBY6aC/jCy0CmRsgaQFFTbICR1qzWM=
X-Received: by 2002:a02:8622:: with SMTP id e31mr14200498jai.88.1607673957614;
 Fri, 11 Dec 2020 00:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20201210204211.967018-1-gwendal@chromium.org> <20201210204211.967018-7-gwendal@chromium.org>
In-Reply-To: <20201210204211.967018-7-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 11 Dec 2020 10:05:46 +0200
Message-ID: <CA+U=DspnB67F0rF+4B71oXHHy73vM5WDWUzA_BGORbCogYhFHQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: chemical: atlas: Remove code to set trigger parent
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

Worth noting that 'indio_dev->dev.parent == &client->dev;'

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index cdab9d04dedd..56ba6c82b501 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -649,7 +649,6 @@ static int atlas_probe(struct i2c_client *client,
>         data->client = client;
>         data->trig = trig;
>         data->chip = chip;
> -       trig->dev.parent = indio_dev->dev.parent;
>         trig->ops = &atlas_interrupt_trigger_ops;
>         iio_trigger_set_drvdata(trig, indio_dev);
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
