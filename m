Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567F35EE4C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbhDNHYK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbhDNHYI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:24:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407F6C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:23:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso12017794pji.3
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsJjvl96ZNZtufLqMaRTOWlnQdvU3hCsf4mFJbBQVbA=;
        b=Xwx7g5Yff4JE13ZiTa+dKbg76lERE7MaVW+Iucu5yTwx6i8iHJpg6kaZrSjiJBjiQw
         zkccE3OfTrXcJhJ3zBf50JIvpSzy4bQUuIme0UhrCHF5X8kCINrfj706LeFGvgjNqVRG
         xvAykMRL3bFWe5m5z2nUcX+zgnH97/L0s+0SSatljS0FEx4MhtbJ4B8n6u0xBio0NSBY
         RFMjKWenMDvpvUjJzkTO3Gl84AmLaR/kZL2mgMYvgd3OFDJ69l7q3rGD9JqI6ocJ/Ybi
         tn+kf1/kmc5or8zhsuURNyU3GsqsUHW1YNLlzFO8B59rFtGvhshW0BBAAHIJ4zg86XQx
         6OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsJjvl96ZNZtufLqMaRTOWlnQdvU3hCsf4mFJbBQVbA=;
        b=gyVyaQ/Xso2yj0FVFhygOM7ez9kyKUz7EKePJlqw2RqY2/HAY2SW/KzhhWrjKrM2dw
         API3Z9xeq/TGo5H5n9+DNTxFMgZ33Tb1LLBv1+pDdfIZpyXLBZ7Eku/D8ju/DDV7aJWD
         egIWBhiBNbSILt8Uk1SjtdCq34w/5Z+x4d04E/uo0AZ/5rv9SnVO1PC7sw7RAoJdqCaP
         JTN+SH2I20YQQTsp5pjkYWelfpyzS7PGEG/gxRO+sfkB+mOxZE6ZTt3hodPY6kjnATlj
         hVdP2rtpRMzE6b0p+4VW/5Gksliw8I8YwPZncyfuCCR5sPYBxeb7XYNyqg2Ve3LC7xnA
         +86A==
X-Gm-Message-State: AOAM530H7BTfiWYup/aY3yAhInooddKv54NEWkUAxEvh1flhEgBc0Hjp
        rN0G/d1TUp06ZMRcebvHhLujl00NAjzuYblZr8GSBWyX2xtMKw==
X-Google-Smtp-Source: ABdhPJzcsW0pIXE9YybI366broqJ/rgXT1LfwEzY9gv8FUshMLDsL2mYe6EuKZaRfjtwrf3Uj1Hzh3lIldrrwiMs2B4=
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr2172324pjx.19.1618385025390;
 Wed, 14 Apr 2021 00:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-2-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-2-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:23:34 +0300
Message-ID: <CA+U=DsohUdAdUGG9_U5URp5HLYpEO=uQtX-V6UzpzikO1G0Syg@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: adis_buffer: do not return ints in irq handlers
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
> On an IRQ handler we should return normal error codes as 'irqreturn_t'
> is expected.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: ccd2b52f4ac69 ("staging:iio: Add common ADIS library")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index ac354321f63a..f89bce10090a 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -130,7 +130,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>         int ret;
>
>         if (!adis->buffer)
> -               return -ENOMEM;
> +               goto irq_done;
>
>         if (adis->data->has_paging) {
>                 mutex_lock(&adis->state_lock);
> @@ -154,6 +154,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
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
