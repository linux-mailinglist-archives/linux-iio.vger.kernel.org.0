Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CA338E0E9
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhEXGPQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 02:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEXGPP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 02:15:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD5C061574
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 23:13:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so10533169pjv.1
        for <linux-iio@vger.kernel.org>; Sun, 23 May 2021 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FLp5uAzHH0SGDaZUtYfbnoxCEr5N8vN7+aFLGvxmDuQ=;
        b=LDH3zdYeeEsnkTMi0AZVURMUtrJmNKDrRL3AVUIe0AfGAA+HEBfnrIGsvMvpTomH3X
         LPJynxv/dOCDP5/muQ8SjfvbkorBwP/VHh6sxYK0NRp+J/j0Y4KZAf2Gd1iWGeL5IWCv
         ncUi7O+PvQtTljYoYxEptH1yUOX2/EtcYZfvfkdZNz+8sjBvbKccoD8ik+Qmyw/+FW2n
         P5lNlHFQeFdjE0V5x7C9aAAuPrM+QwL2l19Tw2zx6GMCJtM06MRs4ogPg/sUPekrhcof
         35je0RZbS36X5vAeWvvU2cM78ppU2chWOIDe6BX989UWe19aRoTzRZ+MDQ95mq8mYP8a
         8vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FLp5uAzHH0SGDaZUtYfbnoxCEr5N8vN7+aFLGvxmDuQ=;
        b=C4yD/2CA4xaqzPyFpqsC+4pxWeKxkOQ/ZrAAVP4gW2X9/qOo66yGk0zFo/hljK8Pm4
         f4IkKtP4dLMpCYCVAb+r7gBEErQtq1AE2lOGs42pzX5ONZjQPIlmC61iUwJjbvepuZaU
         fbu9teaNCEIMnKFYIO4/HEjoSeCMGc6q9/4nx9e0SITM+IIVhHjIqRa+HJYyCc6Uvllj
         EJ5SqepUVV7bXGoLu4CVXjDiRDN8mskmYROE1GuBChkVQ3uJ3rnW0ja6dhJt42ROjsY/
         JLJKYmSeJSAd4U7aVrVXsokbQRPKRu9+UjAw+XuQLi7r9MrNBSs1u+lh5lNLEVM/njiJ
         SnEw==
X-Gm-Message-State: AOAM530qC6ziXVe++tTm/nzaF9OWxvkvZEKeC+FxJIb1idKld3X0dQ5g
        zefKjiUrVI/Co2VyS+O7K1g3r4JBbwC+BPSen6I=
X-Google-Smtp-Source: ABdhPJy35hDjOSJ8CwQUisC+/l/oLkE8JZcA0idvwHfj8860vzHvhJKfXcvb5Yer/Bt3NHrG4JZ07VQJFL4wXJmsa7M=
X-Received: by 2002:a17:902:a3cb:b029:f0:6ebe:3530 with SMTP id
 q11-20020a170902a3cbb02900f06ebe3530mr24182431plb.21.1621836826757; Sun, 23
 May 2021 23:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-4-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-4-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 24 May 2021 09:13:30 +0300
Message-ID: <CAHp75VcPvyOkmv18D4DBxeMdJwcKH8sYjoYPLPrCfsymFGCjfw@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: accel: mma9551: Add support to get irqs directly
 from fwnode
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 23, 2021 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The driver previous supported using GPIO requests to retrieve

previously

> multiple interrupt lines.  As existing firmware may be using
> this method, we need to continue to support it.  However, that doesn't
> stop us also supporting just getting irqs directly.
>
> The handling of irqflags has to take into account the fact that using
> a GPIO method to identify the interrupt does not convey direction of
> the trigger that fwnode_irq_get() will. So we need to set the
> IRQF_TRIGGER_RISING in that path but not otherwise, where it will
> cause an issue if we reprobe the driver after removal.

...

> +               /* fwnode_irq_get() returns 0 for not present on OF, and -EINVAL for ACPI */
> +               if (ret == 0 || ret == -EINVAL) {
> +                       gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> +                       if (IS_ERR(gpio)) {

> +                               dev_err(dev, "gpio get index failed\n");
> +                               return PTR_ERR(gpio);

This should be dev_err_probe().
(I guess you need to prepend this patch with one that switches to
dev_err_probe() API)

> +                       }
> +
> +                       ret = gpiod_to_irq(gpio);
> +                       if (ret < 0)
> +                               return ret;

> +                       /* GPIO interrupt does npt have a specified direction */
> +                       irqflags |= IRQF_TRIGGER_RISING;

I'm not sure I understand this part. If we are talking about the ACPI
GpioInt() resource, then it should have this flag. If GpioIo() is in
use (which is already a sign of either using the line in dual
direction mode, but this needs to be described in the data sheet and
thus used in the driver, or misdesigned ACPI tables). DT, I suppose,
should have all necessary information.

> +               }



-- 
With Best Regards,
Andy Shevchenko
