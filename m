Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0B4482258
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhLaFt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:49:58 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC76C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y18so23528325iob.8
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu9wNtB1wXUtKc4wZLqGa9tnVrqxvEy/fwj2YyMas/s=;
        b=XIfgO7OjTrk0IQEEy7sSvIGnwuclSek30+c9Vy6QmRf5J2jc/NGJAzC5Nj9STTdayi
         zC+ifEHEjHVejpiX2AW10Fe15axtRLxIB0r39Wr3n+S9SokECdsUqHPLhZJD/bmv/Mvx
         SPn/jPx5PJxA6hyhHJ5MPZ07L+5m7vutWXEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu9wNtB1wXUtKc4wZLqGa9tnVrqxvEy/fwj2YyMas/s=;
        b=oottCGTNyPZCirUga/6VI3bNBZxnYp7v7SaHDL7z5ZOvbgyRthVzKND8xqVuUkPj/y
         MDcGSdZYEcxNUugnzawvurIc1deh/VshgPcuUMoPFr2odS/3O1y4lzeLw4R1l1VS8a2b
         a6NfVoCWsgA0eyCXhYu6pQbI6OZj+aEdHaO55ofSNLAlogJvW3oBY9pf2pXEy7hyR4V5
         vpKF0nYZivcuEW1nSNWCQ3dqMnX6U6RQLS8PcPetAz2pqzZT22foDrr6xdt3D2rBoo1P
         5E3yNR3d8a1i5YC+vguqH+uZSAjghWo/3t0PLDg0/XFnZAYCLpVeEoUU1bRsh7qSiCBi
         MYmQ==
X-Gm-Message-State: AOAM53381YMxfdXM0qzPzFNEeVO59L1N/zWfRbG0YlHy487XKM4x87VY
        bruezXKZcoM71w3niF/SCIpD2p4MRlob39ZLPAg9Ug==
X-Google-Smtp-Source: ABdhPJzgWlNi9CgWDXtaP2l5BsRsJO+nq0e6HS9b80CViA2cIY45i9sv9obqComLZaM+0tcvh8t5xgH1KLPpSOuVNbY=
X-Received: by 2002:a05:6602:2d53:: with SMTP id d19mr15891896iow.77.1640929797555;
 Thu, 30 Dec 2021 21:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-13-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-13-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:49:45 -0800
Message-ID: <CAPUE2ut1_pyp-1AgiFpcfO1KzN8RQNZOmtvrfUC8DtBWEWG6cA@mail.gmail.com>
Subject: Re: [PATCH 12/16] iio:adc:hi8435: Tidy up white space around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously inconsistent with space after { but not before }.
> Tidy that up to avoid providing a bad example to copy into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/adc/hi8435.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index e665e14c6e54..8eb0140df133 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -529,7 +529,7 @@ static const struct of_device_id hi8435_dt_ids[] = {
>  MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
>
>  static const struct spi_device_id hi8435_id[] = {
> -       { "hi8435", 0},
> +       { "hi8435", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(spi, hi8435_id);
> --
> 2.34.1
>
