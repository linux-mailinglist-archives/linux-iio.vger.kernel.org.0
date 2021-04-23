Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD57368D3F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhDWGmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 02:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWGmO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 02:42:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF0C061574
        for <linux-iio@vger.kernel.org>; Thu, 22 Apr 2021 23:41:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 20so20803341pll.7
        for <linux-iio@vger.kernel.org>; Thu, 22 Apr 2021 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TeFMlmYbBmcWxhSr0jRAB5JaVOXlpBCV+KEW4jx/GE=;
        b=WyuDkQ9jHGlgBdFv0bGAxj5TrLsLP/14U4NV6LHmsOm4P6o5AmtyzAFTeud5QxmAHD
         Q4zp75YdJeo3DRqTMTXatYVo8wnMnccOMKlkllrAwAz6iJbYBY3BJAFc9DB+0YqUYxXf
         6kkNkv1Yq/KmjjmDCIe8uIJ4+Pelk/NMWRjV/Yt7SR0mO8kYMf1zzhBkbWG7DVLtyjk6
         gKpi76PjdUV3+CCWOsv12wJ7j665Gyq+5ELKAnidLLxOQ56toejbtLn6WWAUpuqSKGiv
         vE26SjBtHSgCtcH+IYcF9T78ISeD07jx6FG9uWCqD20XEGm0/klWQZEzZGD3fmERsve7
         129Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TeFMlmYbBmcWxhSr0jRAB5JaVOXlpBCV+KEW4jx/GE=;
        b=rKvazAjEh6d0+J7sWgKnsvN+QQsD56Qn2sh96H4HPEDIBCCyET8o2B9ynlr0CzlWEC
         ghe7gdafAzx/v3ARz9Pna9/Q/rzW3aP11ZfqW2lMcD9wML3KHdfbf0voyP2P/6FjeaLa
         XSJ30SP4gVgcxaKyfzzeZyoLalnavp+PIVWUHUMqJyRkZphh14WT/kjwqit9Hri/2C2K
         Ocumbr/Q3XRDD01GKrVJJS8YrVvKYJYRuiWMhRdygxYNka/a53RqDUqpV3sQZfzkvha3
         nhnppli4G8RSoHhe/QdIyAp+U937xOmP7PmCbKM//CraDWCm6YuQ6y6QEXZca3gT61Sq
         m1AQ==
X-Gm-Message-State: AOAM533zSO0ZQA/PuR3DueoEysrA66+Lc9+yn2XCp/Y4SOk2obsyaylg
        ae0sUGilOJfmhk1EyzK/aiAfqEOB9K7aXqoVxeU=
X-Google-Smtp-Source: ABdhPJxvfUbwh3L+JhmEc/1+IR2RXJ/5XG4YtJVw0kS4u0pJ1gXcIXGNjPrP+lvWXhwz5/7pEsfC5SttjHVhO4dSTlQ=
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr4278818pjx.19.1619160097752;
 Thu, 22 Apr 2021 23:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-4-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-4-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 09:41:26 +0300
Message-ID: <CA+U=Dsq0SYxfZ+k-CoKnYDk93LkV4xEpJDSoWjMvgDcmv8UhVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] iio: adis16475: do not return ints in irq handlers
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
> On an IRQ handler we should return normal error codes as 'irqreturn_t'
> is expected.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 1de62fc79e0f..51b76444db0b 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1068,7 +1068,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>
>         ret = spi_sync(adis->spi, &adis->msg);
>         if (ret)
> -               return ret;
> +               goto check_burst32;
>
>         adis->spi->max_speed_hz = cached_spi_speed_hz;
>         buffer = adis->buffer;
> --
> 2.31.1
>
