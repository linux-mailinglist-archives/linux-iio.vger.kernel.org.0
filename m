Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33F35EE71
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhDNH3e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349737AbhDNH3e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:29:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC2C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:29:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so13149749pfn.6
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjgM3bgK4p0b578hXo7Ut19Mnv+/4KF0S0BfZO9C9nw=;
        b=NfBC3BkgQZTPRPcxSkUhKBQL30M2ZUMkNf8j3zI4qTs0A1RSM8S5gCY7I7wbVzswX/
         dTJB0p6WC4KqQj8d3MMWDOLZ+h90hn5vjzz5WkPZZNSdUXb4hRZ8iJ7+VmMCIz9vv0a+
         jPhyW6xWB1lTiZYQ/jDhPcFvMOv45Li+h4va1DcIFznMg2FlbRUhTjP7DppW4z8HEh6X
         3wt4pn+E3sm5YF1nszYL8BM6zdwEJ8+h0O8HL//Wj9WvdGNuvcG9PFgBjExbnPaIG/OO
         aQjKScYj+IMYZuh4OYyoX912+W5FA1poBWz+KgS1okqGQp2FJlY7brpzaQbvEWKXV7lg
         Pf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjgM3bgK4p0b578hXo7Ut19Mnv+/4KF0S0BfZO9C9nw=;
        b=bAiQ3aZIroqF56Qctkm3ixI1ayzYR38gqp94HoxOdEQbOjOGwal08S27rIlMSwLnJ7
         vMrvOX7oDd6BZzTtYSS6txoBv1A9exyWwGjUoAhuTPSaU7hRZl+jyruGT/Cod3XwQ0ng
         vZ0jVFNuhxTj+cWyhN0pPOTk+P37dcvY4LpHcyvgk8e+WzfzqO2KW4NrO3FqZ1v8NPjN
         fCb1gqF8/M47wwhXa+auaEo4HjS1Q4FBIf7RINsQD8h59BQLxlNuQdKC+oUXb5A1fK8A
         SjcVQ0CCc44c2kd7RgRxKW5jyzXoIOgALrz9LLgTlRXYW6+3a8zi1yhiEqnynLTwgvh2
         YD9Q==
X-Gm-Message-State: AOAM530WQ30cuiTL+KTrRcEhydiujw4jTUMfI3sDLoBIHJYhQet+s6Sv
        0ZY1nbwp2mB9KxqhfX4Rofkw3OVSIcCqBbp4sJWOwFoXZ5X1VA==
X-Google-Smtp-Source: ABdhPJwo52aj4UkcEQuoNn5s68Ek1pj+8B0auEZEKeqqiUZtnD7bhBV9qoV/4fy4ex5Fb5MOeIOe9glFaOX+3hPpkVw=
X-Received: by 2002:a63:43c2:: with SMTP id q185mr35458323pga.41.1618385349566;
 Wed, 14 Apr 2021 00:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-5-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-5-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:28:58 +0300
Message-ID: <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: adis16475: re-set max spi transfer
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> In case 'spi_sync()' fails, we would be left with a max spi transfer
> which is not the one the user expects it to be. Hence, we need to re-set
> it also in this error path.
>
> Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 51b76444db0b..9dca7e506200 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1067,8 +1067,10 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>         adis->spi->max_speed_hz = ADIS16475_BURST_MAX_SPEED;
>
>         ret = spi_sync(adis->spi, &adis->msg);

Purely stylistic here.
But, the restore from the cached variable could be done here in a single line.
So. just moving [1] here.

> -       if (ret)
> +       if (ret) {
> +               adis->spi->max_speed_hz = cached_spi_speed_hz;
>                 goto check_burst32;
> +       }
>
>         adis->spi->max_speed_hz = cached_spi_speed_hz;
[1]

>         buffer = adis->buffer;
> --
> 2.31.1
>
