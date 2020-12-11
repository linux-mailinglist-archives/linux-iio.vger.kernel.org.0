Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717502D7134
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgLKIFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Dec 2020 03:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391992AbgLKIFU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2020 03:05:20 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DEC0613CF
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:04:40 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id c18so7944342iln.10
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2020 00:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tC+rUHvr5S7mlsHDM0OE7UVMGGzATKF7PJuqB5ljrsM=;
        b=BRK4yyVtsf0Q5K1dkKp8IXrzc0AcRjSu6WccsV0Xkb5SX7zAq/Wr30O7WPYgQjF7Qr
         iLnP1DoKmWZr5znreOqdzE7vA8isKPnUeX9JqI6yImAas9o6Rn6cVWA5d79XLBQWdphB
         rC0YZ2JTh+CbpYYCbVf+YmXjnvKpjWzoXLg56f/QYYFjqiiYq+jBtN9X2h+HzPbpRnvk
         jsgXOcUbleWgS3q4UCIvP68ouYm/gTcVfq4WXMDmgNAupNftttnALBi2ujGQKXBMEqm6
         8TXIXeVaeDMQCaQ870koVdmXdz9edE6B/a8HlRMUoRW2ASsS+y0raR6KGVfTn0B1ZBCO
         KVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tC+rUHvr5S7mlsHDM0OE7UVMGGzATKF7PJuqB5ljrsM=;
        b=sXalU6q65r9geeCqToNGJd2HCvIomvg3F0+3bBfdhz4VhdZak9RJMDNQMuA4YJ1osI
         JlGuRiCmxjh8+SBDzqq68AlT+cj0pHgSZQahrhV3c4S5ZsDMaZcPPJ0gxmUN2I0C48O1
         TqwzXKPREfOnOcnEOMq7a5/XI8oEHJG1gW1gDgQJL04oy46waBP2zxjEwGt7Vrr6IOdR
         4/7RmaRF3KkCdEksj/qLmLN8h4rLXLGmGqnagHN8E9/Tuz14dX/HfhUQto05lpihLsig
         skX/BfQdl7++4J8sHIHgk5Q0JT8TmifUakFAGyMzizza//VmvHKOEPMcNPjZ7IJk29uc
         5iwg==
X-Gm-Message-State: AOAM530xU0Z4zCoXNTpQDWb3+tsufLvkvq1/ijl4BU33IXCayzIB/gpF
        nBrw2ULrWBz3P8ytx4vmqqVT0yaTX4Sc1OfCgKM=
X-Google-Smtp-Source: ABdhPJz5VPO0SjjU+8Qxy8Z6zwqB8IUqRVjeyF5ztSVizC3LWXzlBNzwxRU0NGolCri6BnBDZOu8vWESeeKk4p63BOE=
X-Received: by 2002:a92:8419:: with SMTP id l25mr14388863ild.100.1607673879601;
 Fri, 11 Dec 2020 00:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20201210204211.967018-1-gwendal@chromium.org> <20201210204211.967018-6-gwendal@chromium.org>
In-Reply-To: <20201210204211.967018-6-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 11 Dec 2020 10:04:28 +0200
Message-ID: <CA+U=DspM-Z45p7xCx2DsdwrXPhCdWf8PAo=OyRXi4Av1ddAn4A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] iio: lmp91000: Remove code to set trigger parent
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
>

Worth noting that 'data->dev == dev'

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/potentiostat/lmp91000.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index f34ca769dc20..8a9c576616ee 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -322,7 +322,7 @@ static int lmp91000_probe(struct i2c_client *client,
>                 return PTR_ERR(data->regmap);
>         }
>
> -       data->trig = devm_iio_trigger_alloc(data->dev, "%s-mux%d",
> +       data->trig = devm_iio_trigger_alloc(dev, "%s-mux%d",
>                                             indio_dev->name, indio_dev->id);
>         if (!data->trig) {
>                 dev_err(dev, "cannot allocate iio trigger.\n");
> @@ -330,7 +330,6 @@ static int lmp91000_probe(struct i2c_client *client,
>         }
>
>         data->trig->ops = &lmp91000_trigger_ops;
> -       data->trig->dev.parent = dev;
>         init_completion(&data->completion);
>
>         ret = lmp91000_read_config(data);
> --
> 2.29.2.576.ga3fc446d84-goog
>
