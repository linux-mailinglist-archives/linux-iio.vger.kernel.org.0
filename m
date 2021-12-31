Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC6482256
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhLaFta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:49:30 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05DC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:30 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p65so31918930iof.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxf1WVHg5sM8/ppth64tIpYmCJr7akG7YkvOsZIytnw=;
        b=hz9rvJW7O3dcm46veC9qQWaF4pfY0l5TZLt8cZS0TIX84XQ5xVg9UNs8yzdJbEjntZ
         zP13T4sYrvS3Co8OYlVTQdQc5A+O6SwP8BqCSQCuM+ORiToVkfl7JzSEZHA7Y8kCFqID
         mwjFY6S2MGvW9867cWxZmJ+f46jsnU3B+73yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxf1WVHg5sM8/ppth64tIpYmCJr7akG7YkvOsZIytnw=;
        b=OB5P/oXe5f0lcV3nzxOIn74DTcueh8u/JWphzvC2j37Xz0vDDdsf4crwM+kog8iJLu
         g+qSiaAnK2Srkykw9pfBbp9SFzA0AYt0EOJ78rG34TkaxYPghxKWb84ocq945GLnTLIW
         KC6Uc708ffk4+/JiNIRusKNSvFSs/6VwGmxcWxo8v5dj+7HS0n1zFWAVFPTqXNmADFM1
         xbxsRXjp1XSQTNjs9MOQ6LuwsCoHA3giqkPFfQu9sbhugPOuroD6uiNKW8bgdibx/eIx
         S383teqni0cVWnvywyLj++iXlXaKMc6gzvGawsA/+e8QNuEaZQ2NxBKweqo2OnOqYe+L
         MR8Q==
X-Gm-Message-State: AOAM531pw0wXgJGuZepewZkXtS3X0kh80eEOPi9X6hZKnBNS6XygMASa
        bmPLFARa90JeG7oUG6mzO83TjqL9VFBSdI4+ReAmJg==
X-Google-Smtp-Source: ABdhPJxllCsUi3gHWL+gxEKQW0FAEcG0JDks7uXufTodoey9h69Bs9HvTjlFbNm8jLtq6jVcgC1k9jGvoRHLvLsho9c=
X-Received: by 2002:a05:6638:1302:: with SMTP id r2mr14340673jad.37.1640929769376;
 Thu, 30 Dec 2021 21:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-11-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-11-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:49:17 -0800
Message-ID: <CAPUE2uunMzDM5Sfia3SL36FkUznm4QRr3xwYC8GDju=fnUBbVQ@mail.gmail.com>
Subject: Re: [PATCH 10/16] iio:frequency:admv1013: White space cleanup of
 spacing around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing was inconsistent with a space after the { but not
> before the }. Tidy this up to avoid providing a bad example to copy into
> new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/frequency/admv1013.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> index 6cdeb50143af..849a9ea7ebe5 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -630,7 +630,7 @@ static int admv1013_probe(struct spi_device *spi)
>  }
>
>  static const struct spi_device_id admv1013_id[] = {
> -       { "admv1013", 0},
> +       { "admv1013", 0 },
>         {}
>  };
>  MODULE_DEVICE_TABLE(spi, admv1013_id);
> --
> 2.34.1
>
