Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EA36C010
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhD0H1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0H1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 03:27:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3865C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:26:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d124so40725572pfa.13
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzPROtxuFTeCgBM1ohK5HklLv1/Rfzjr1coVJHvmoG8=;
        b=szT/CMFI9BnRO+md52kTj1tcfk1pWiZ3OxDp5s9nbF3lc7ukI9GvLs0Hb+UNM40Obc
         Udz1/+AmtyBje8gBZFoXEbxRnE3ikQj+XClWEnCvcOVRHheXUFJmdTyztJfQl/2cNe4a
         Vxj+dYdFvYBgQRiu/CFZ0aCYxWiCd8udLm624zIBCC2n02OD6urWNmevmV58pdVj51ef
         wF+Yx2W/HMa/sqHE4NnjJTLRJVadltzs3caBJ6YKy3TSAZIAts5FxdxcKj1tiZum2X1U
         lR7gjemSoNWtBOQPHEgUiDQ3qei3oEUGLm+JdS/wf42C9YgTUjmQXKQgL5/O1qJIAMj+
         tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzPROtxuFTeCgBM1ohK5HklLv1/Rfzjr1coVJHvmoG8=;
        b=NdfRoKCM7PMoMyaU1GNW4elWhLy9UooO6lMoamBldIRzvCe1XtcoMXEJPAzeRcKCLt
         XgXsbvRN7IlV9hpOoV6mzvkBYzu1RjEYGA7U0e9a5GyA0QEiJfNRByKM2iT6U79LIboa
         qbsPOZJcMAlw4usayCoK+5mP6s2mg/k/QWhOcONv8WOMvaxCUgIOqp+a+3QtVc0hiKma
         6pQY+w7pkWm3YD9HbHooWeLgTrnX3Yz76aKeu0IcQl6tBaWZslnhCR41FegEiF74Xk1k
         ESm6mri7mocmdh0QcP4v4tpgykwFoDcUc1zAg2oRquMsKa/6PfJu/P8lc3mYJMcvspQs
         67Ew==
X-Gm-Message-State: AOAM532LQ4Q3Q1FCqdP7zi3pCyy8pMRIM6IhS9dnWCf2soepphAD4Wka
        4ZoBXIUuVKcilHg5r+a14zNNTnmkRN4/hPRioLg=
X-Google-Smtp-Source: ABdhPJyO31GeiodsUhNHS8hOdhWAKNNGpS4lk12jsI45WIl/6zA05wj9debtYssqO+rrW01w8jnfIBqz8veXWd2jyEE=
X-Received: by 2002:a63:b515:: with SMTP id y21mr20912199pge.253.1619508402408;
 Tue, 27 Apr 2021 00:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210426170251.351957-1-jic23@kernel.org> <20210426170251.351957-3-jic23@kernel.org>
In-Reply-To: <20210426170251.351957-3-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 10:26:31 +0300
Message-ID: <CA+U=Dso3G_P-HkXTwSWtjtPgC-TV5X-pGcFh1xfQUEZpra1B9w@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Pop <cristian.pop@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This is set to the same value in devm_iio_device_alloc() so no need to do
> it again.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Cristian Pop <cristian.pop@analog.com>
> ---
>  drivers/iio/dac/ad5766.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> index 79837a4b3a41..b0f180d46394 100644
> --- a/drivers/iio/dac/ad5766.c
> +++ b/drivers/iio/dac/ad5766.c
> @@ -597,7 +597,6 @@ static int ad5766_probe(struct spi_device *spi)
>         indio_dev->channels = st->chip_info->channels;
>         indio_dev->num_channels = st->chip_info->num_channels;
>         indio_dev->info = &ad5766_info;
> -       indio_dev->dev.parent = &spi->dev;
>         indio_dev->dev.of_node = spi->dev.of_node;

Unrelated to this series.
This looks like it could do without the of_node assignment as well.

I probably should have noticed this earlier.

>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> --
> 2.31.1
>
