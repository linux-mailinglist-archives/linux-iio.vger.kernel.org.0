Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E107A3526E9
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 09:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBHZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 03:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhDBHZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 03:25:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A16C0613E6
        for <linux-iio@vger.kernel.org>; Fri,  2 Apr 2021 00:25:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k25so4584543iob.6
        for <linux-iio@vger.kernel.org>; Fri, 02 Apr 2021 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1DW5nPM5fYXf4twXgqosSowInqYdAIsq0cd085Qo54=;
        b=fH/nf/CYBZSpVKDOxcQPtRAdj0AW1wYro0RfdPxiCv2JBi0J8skcuiCraYenZbL4Rh
         uH7BwBcX/Fa6wOUGMW2bh20NWLVNKW12BXvw6IT2RsGF4xavq8krvxaQq+iOGF842s2V
         n0Z7fsGn1tQcLeyMIU3KGHJE8h998q+SYxEMTOKU6Tkm3pfbsHR6kkQs/eCFD06GQByT
         iA4Bec4dpEaEE8nrwHS4DLjGnraNjX1cX+MVoWgWmXVYQ8FG7e7GQxS7Zfqc7dc9RI6S
         peedLdxefnUFNVhtc6OTS/HLw4YBhgaSJhO1Myb/k2n2dL0cW00mGrbtJtbcjDUn1562
         /CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1DW5nPM5fYXf4twXgqosSowInqYdAIsq0cd085Qo54=;
        b=XZOdImyeWn1Ldx4C0kqvS12+4EMpS7fdrikTA+DNg/3c0xSXtJwoShzeeiDhLoz8E1
         IfXz/yrBzv1Y+/BiqnF0aGgW3hK97yU/5/Rrpnh7CKtvmHYpvkblCnqjOJfG2aoe//+a
         0V37yAccPYKD3rGhjY4F2IV5j87AjYZdRzFCLfCJpkp/LeeA189/LrVpJk0s6mhKzKSQ
         AyD9kXcr7mHS/x4N7GoZScnlBw9xT59MgMEVYldY/gUH0XFBS+a+zZXIPExSGJv2Jc7j
         F29AjcnIPHsln0pYwJbpn9dnINjtbxg296rgrbVWx78UCjOE+sfWhKbeOQjEaPZEfWJS
         BWNg==
X-Gm-Message-State: AOAM530dpZuv9zlfCy4VsNPRk2MLSbpA/bQsuSMrSv+KRcZGwL32/Qde
        mGEVrYjzduMbAeXE1ElzNphwC4bHFG3DRyzrHrA=
X-Google-Smtp-Source: ABdhPJzBU6QYtsDokcs8JDKeUzl0ksdPiVuWuMfRzQytRDXud5otGwZmQk8GQy5yuUpVBPtXZ3kvRCjC0z4j4ol0pbc=
X-Received: by 2002:a05:6638:3791:: with SMTP id w17mr11455435jal.91.1617348352826;
 Fri, 02 Apr 2021 00:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210401145410.226917-1-jic23@kernel.org>
In-Reply-To: <20210401145410.226917-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 2 Apr 2021 10:25:41 +0300
Message-ID: <CA+U=DsoFoBXAht_1QmROOshXKe=Vh8PBo5HfXj6c2WSn-_Qgpw@mail.gmail.com>
Subject: Re: [PATCH] iio:adc: Drop false comment about lack of timestamp control
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 1, 2021 at 5:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The timestamp control has been a function implemented in the core of
> IIO for a long time, so this comment is incorrect and has clearly been
> cut and paste into all these drivers.
>
> The remainder of the comment added nothing and was confusing so dropped
> that as well.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
>
> ---
>  drivers/iio/adc/ad7298.c | 6 ------
>  drivers/iio/adc/ad7887.c | 6 ------
>  drivers/iio/adc/ad7923.c | 6 ------
>  drivers/iio/adc/ad799x.c | 6 ------
>  4 files changed, 24 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 689ecd5dd563..d2163cb62f4f 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -142,12 +142,6 @@ static int ad7298_update_scan_mode(struct iio_dev *indio_dev,
>         return 0;
>  }
>
> -/*
> - * ad7298_trigger_handler() bh of trigger launched polling to ring buffer
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - */
>  static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  {
>         struct iio_poll_func *pf = p;
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 4f6f0e0e03ee..9b3cbe1ddc6f 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -109,12 +109,6 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
>         return spi_sync(st->spi, &st->msg[AD7887_CH0]);
>  }
>
> -/*
> - * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - **/
>  static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>  {
>         struct iio_poll_func *pf = p;
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 287f4c13194e..9a649745cd0a 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -192,12 +192,6 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
>         return 0;
>  }
>
> -/*
> - * ad7923_trigger_handler() bh of trigger launched polling to ring buffer
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - */
>  static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>  {
>         struct iio_poll_func *pf = p;
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 1575b7670207..18bf8386d50a 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -182,12 +182,6 @@ static int ad799x_update_config(struct ad799x_state *st, u16 config)
>         return 0;
>  }
>
> -/*
> - * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
> - *
> - * Currently there is no option in this driver to disable the saving of
> - * timestamps within the ring.
> - **/
>  static irqreturn_t ad799x_trigger_handler(int irq, void *p)
>  {
>         struct iio_poll_func *pf = p;
> --
> 2.31.1
>
