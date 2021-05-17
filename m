Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BD3824E5
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 08:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhEQHBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhEQHBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:01:11 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C657C061573
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 23:59:54 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id t6so2572090vsp.13
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReTTiFWa1m1hmQDvf71/ta5Pzoxt6mRHHiPQQ3OOXk8=;
        b=G303/rVc3KLJhCxCDPKOPXxHPRPSBUdm1J3sDIRBZzPbLQ29PJ796p232bAH0dLb9v
         QA1iLaQrwXCvOXsLs/0ZChWBrWAiVQ4plhbd1Mn4WKy5CyzuBVkeHikX9qAkVk2F4aiK
         g1rQhuVQWeGXrY7IFQ69BlVAkw8KQBgMr3IwG/WVsl87v+gKHdisXl1LrhLIQb+asILa
         zDXHsjWB2S0KnAjTdrOiWxHP0vxBALt6M17XGUUWuVDww6OLRFFPdgg7N0uzirT7kgcs
         tli30R1O05gFeDwnkVWUjof0BMKLOH4l/AI2OBBZWoQhYqoUGU3fZTQj6FITO6mv/mpH
         IWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReTTiFWa1m1hmQDvf71/ta5Pzoxt6mRHHiPQQ3OOXk8=;
        b=OlqmJubhHQs72JglCBDuXpN9NkjasQdvEfAJdOl3VpjYZRA0LVEilaUu3mCq7yg7nX
         ZtH2PFr2SHaoRUQefW7eTwddesHKjt+od8d+HJAimdiKYYIaA5H7QpDNTQ7khkYjavsC
         ihkD3DVdyThPs+ekY5K7kL1on6ppCEEWbr/d4vPkR8O8j1tMOdKDDF5CTbdEPWyvOB85
         CsYi5Iui+OPqid7nIcGA4wGyroSfUduwf0Es6463xoecxK4LW4eUo6jNH+LyXiqTsWmv
         nkvE4ep0BXUGYw1mYIAX9Rdya9BqSx3inlNlAE6HJ0hP+HgkhXa3IiuDrlURKPrYYJp9
         vDvw==
X-Gm-Message-State: AOAM532tIMCBu9qnSsg5Qoio/32NHbvGQ10324FwaSYNrb8klSE2TdO2
        ayL1fqc7BbL313aw8RroUcnNygXxg6jUNBvel6qq1Q==
X-Google-Smtp-Source: ABdhPJxj/S5umGtScA89JIoi9QicWkysy1P51bONskgdVO0kCBZo5Wtb0UnNjaQQTF29pKVxBytOkAvh1oeclSBdtTk=
X-Received: by 2002:a67:db91:: with SMTP id f17mr50202698vsk.47.1621234792215;
 Sun, 16 May 2021 23:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-2-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-2-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 09:59:41 +0300
Message-ID: <CAASAkobT5CaBhZpTykuLeUOEZK+NMdbL4t5xRmFvoMh8tCDFug@mail.gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: max11100: Use get_unaligned_be16() rather
 than opencoding.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The function is more explicit in showing the intent + quicker on some
> platforms.

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/iio/adc/max11100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index 6cf21758ca66..69d607fa17aa 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <asm/unaligned.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
> @@ -63,7 +64,7 @@ static int max11100_read_single(struct iio_dev *indio_dev, int *val)
>                 return -EINVAL;
>         }
>
> -       *val = (state->buffer[1] << 8) | state->buffer[2];
> +       *val = get_unaligned_be16(&state->buffer[1]);
>
>         return 0;
>  }
> --
> 2.31.1
>
