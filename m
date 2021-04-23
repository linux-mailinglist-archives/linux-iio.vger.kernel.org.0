Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918A6368DBF
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhDWHPi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:15:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AEC061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:15:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e9so7816626plj.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UR4ccHzmNfbzQe6WHOzqmgABDlK6zbcYqMSpzojceLs=;
        b=cPhyfvyqBsfaDJ2FuPDa0YIZd1OX5pwyOZPtcm7KfxYnoD50tKXGF2VKZ7LpxtoCB+
         SLvxc66ax3CKAGU5z9H65NqsnkJT9UdOWWu6m8KvvnC5YmDTOi2RWqKDbxHtF7Sgfsmn
         7PEItKLvUo6JKTNyC6O2tzJ3RPIYdaV3iKAgSwUQVrPXmlFd+9TUM7iIjegVINyriYx0
         0FAE+8Q/rmw4XsvwD19IxmXtA+nC2hRpOEbHiDUaA7tKzwslcoV9reXbW8Ts8u+SwTDe
         /nLAwf63LkkUvSFFQ3OyUOInh97K0lIMZuz7DNn6FWPmUV143NJ+AYXLx5YiYX6R/lFu
         K0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UR4ccHzmNfbzQe6WHOzqmgABDlK6zbcYqMSpzojceLs=;
        b=ZRyPai1bKZ6ktNQ0zHNADTKp2Fa0M0n8idHC4uEgRqrO4UxiiApsAQ051oJH4yfrS7
         rrAXALrwoZq4iQ62h5GZNl2IQeSFXiGRB6oo5ldaC9CwuZsbF9hR1O0zC0099GNsHs5t
         uF01WiGCpyomkQDhaWSgYTwTSXQmxb6qJc9RonrF40RGNqNHbIo48PHL8B/9ej/n5BnA
         iacRKrp0oG2GeqwQAm5tMCIJ48V46pFHt/fK8zL/tAROMNCV1YyMgJK1cieOr7eqIyAk
         3SJS26GUzjqRpu7OhfKf4o4NciUZiWS/VhwgVPH4P0XObuih8cMYSGj5ZtnXXnlTOlxW
         YQUA==
X-Gm-Message-State: AOAM532o029/ScOS9LX9pLuGDnU35SXbjaO2AehQ4vO8uOiaWV2ks7FU
        rbzuZLfUVF2Y+MgAlpQmTw2lHKWplzKSXjVd9kM=
X-Google-Smtp-Source: ABdhPJzHmr03EaY8Fg0Kgj5MUfa2nIPr3DnkK3oWx1B3A3sHyJ3wbZ3E5Ov8weMi34oyWjwCdub2UJue/ZYJqulmDdc=
X-Received: by 2002:a17:902:e851:b029:eb:1fd0:fa8e with SMTP id
 t17-20020a170902e851b02900eb1fd0fa8emr2492340plg.38.1619162099934; Fri, 23
 Apr 2021 00:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-5-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-5-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:14:48 +0300
Message-ID: <CA+U=Dsp6Rc6j5cwN77F1s=inBy3Cj+L=zwSm2AchZdmugAe1HQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] iio: adis_buffer: check return value on page change
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> On the trigger handler, we might need to change the device page. Hence,
> we should check the return value from 'spi_write()' and act accordingly.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 175af154e443..0ae551a748eb 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -134,7 +134,12 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                 if (adis->current_page != 0) {
>                         adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
>                         adis->tx[1] = 0;
> -                       spi_write(adis->spi, adis->tx, 2);
> +                       ret = spi_write(adis->spi, adis->tx, 2);
> +                       if (ret) {
> +                               dev_err(&adis->spi->dev, "Failed to change device page: %d\n", ret);
> +                               mutex_unlock(&adis->state_lock);
> +                               goto irq_done;
> +                       }
>                 }
>         }
>
> @@ -151,6 +156,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>         iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
>                 pf->timestamp);
>
> +irq_done:
>         iio_trigger_notify_done(indio_dev->trig);
>
>         return IRQ_HANDLED;
> --
> 2.31.1
>
