Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA436C00A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhD0H0D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 03:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhD0H0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 03:26:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C5C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:25:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b21so1869875plz.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DAfZOvPWzlB9oWnK3vHPTeKQa+jIZO0MvGEZH9ySsk=;
        b=XVSFEB+0xD25tEf6O9AsRTPSbG19jIG4EOYYjEWqc1BRPAg9cFThEEJDuBazlr6JFc
         Ij5s/AnyP5J6N8YvUcyeGuQcyza6rtJOC4yOiuv8lh4SD3EpCLlum8NpiaTB4k75OOSo
         fiWkinskhSyWtKUbzjRxNFx1YcLSPq8FxtYgDTRTHq7lHNyOLuUZdpzIT/Wa930Yn6Mp
         oC4zM6dvUcaVUYmW/FXmaXWXgFfvM/zwqomAjFLvDgBSQ6LSuiacp3j/ZdKnUN/uHOP4
         MEdVSv5xeAupPf03v7t1GWB013RoFr26XplUeGo/Xcdu94dLSoZDRmmd/A9tznInfTTU
         Qf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DAfZOvPWzlB9oWnK3vHPTeKQa+jIZO0MvGEZH9ySsk=;
        b=iAO/sqszUXBv+HTUyBEY4DdAd0Dg7k6a2QUp0u5FzZPdHxHsvjfGUCNLXo7pml1Bxz
         AQU8g8xQNpuyRwO3fixEJHiEUWbVi7L+FzIhPC0048kdZpNozzf0AnZdD2u09Ey0NcAu
         Ng5MLZ6EOXQC1uBIVvSIl7TbzLMYyERTXNOsgEscccDMxf1oJnUsOaCCOZHdqTTqGHec
         bZ59GVSn4WjGbR8zwvIyUQYhaMbybv5LwLhJSW5mSrT5YPA8NQGkfYwf2DynA8euu0YN
         DjaTitt8h7P6Lo/ExVrOywul76JEqE7/YDNdpV5988HCMRdgHnJsnYo8+ilTBjc8ywB2
         C8mA==
X-Gm-Message-State: AOAM530cNJ7bMOw0A02nC7upEqkR52dgWSHs2q9dPEOmTrKSQOtulnmf
        jQsq2qAOqI9j3+Ger1mBzw1twXwYPZuIP90Gtfw=
X-Google-Smtp-Source: ABdhPJy1wmAyddxJfTjk1yJRn1UXc7rS1gt8ndS2vsNAD4ktxjBnXJqm61+erSUEhm3ArPHIrcwVI04ITZyBHakr6q8=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr26494571pjq.86.1619508316462;
 Tue, 27 Apr 2021 00:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210426170251.351957-1-jic23@kernel.org> <20210426170251.351957-5-jic23@kernel.org>
In-Reply-To: <20210426170251.351957-5-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 10:25:05 +0300
Message-ID: <CA+U=DsqEkmwz6nV7-uqO7+dLQS-Ezyw2P4fCxmSz-YZQ7kWZog@mail.gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Already set to the same value in devm_iio_device_alloc()
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/iio/adc/mt6360-adc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 6b39a139ce28..07c0e6768391 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -337,7 +337,6 @@ static int mt6360_adc_probe(struct platform_device *pdev)
>         }
>
>         indio_dev->name = dev_name(&pdev->dev);

unrelated to this series, this dev_name(&pdev->dev) looks a bit weird;
this should resolve to the driver name AFAICT; which is "mt6360-adc"
it feels a bit off with respect to ABI; but maybe it's too late to change it?

> -       indio_dev->dev.parent = &pdev->dev;
>         indio_dev->info = &mt6360_adc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = mt6360_adc_channels;
> --
> 2.31.1
>
