Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0E2DC90F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 23:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgLPWlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 17:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPWlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 17:41:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B6C061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:40:45 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w16so18678815pga.9
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuHhy+XOc3H9ottoKa/MRCxm7AlEZQRj0LGCIjpARC8=;
        b=negaYNhQ+oMdXIdDzs2XfLDCrIAhcoqZHpte5mV6n05YxAFWMhCPSnzSJvQmBiX70N
         5xu5X0x0XL+7Nq7Ngn9t5bd/pIkMAKRZTfVy//nEmBKMZXLGNRXrrOB9NCNkGWRk70yF
         74UiVFZmJI+0Kwn3sWWUeNDPEZUU9gHg4G/nxWnHr87iajsH5cylMJbpO7o6wPFbM8Ey
         9k4Woos3FF6J/uSaqonkbfHdwa1cICY360kATOscps6ntff2IJqSiL82AewuYsEcsxNt
         +vAAfpnTpMm5YSnbowt5qEXNZ0+7Hj+e5vaQkwmKjTdb6DfK+p7JXpg9sE9pwOQi75C8
         7OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuHhy+XOc3H9ottoKa/MRCxm7AlEZQRj0LGCIjpARC8=;
        b=U1quf+v5EbW7guCSaa8yrATmYnhP8YMKH+lruH1pdgfhjrvg1f4eDBfNdbRVyyxLPe
         RJnzhElCmoi/ttYc3QVssEFgvrZAejveDRLh+uZUu2x3bxXTmWFdmQwm47+JuPDSeGUm
         Nt0hvtSSeyaIripgqFaCirKDIj8wCRGmBPrEnn0ABHNWZLjSYBXn6uhLfQ/AXmDgw4/N
         Msz9XusyEcllb1W/MNGynVDYSxfaJIxFtS1l8aFc76AYEgc7dewXWtKz7/KhgqTHyWyl
         gBzdEsfDROnjfFp6BBSUZuvLdG9VOhVPgqQqguZeVTwkn7dUDiICSKj+IinphSbcY6os
         eVHQ==
X-Gm-Message-State: AOAM533z33p1xM+nEnCfdxduxrLDyn58xpsBBlwmPNbljbh/4ZK9bB35
        s8mwE2lSr0S9LFC/blcdj6HCzQWCOHOJH6mIPhw=
X-Google-Smtp-Source: ABdhPJz0gmaWmfQoAIOpyeOalruN5rNJ1BM0GXR/bthTYi6QsUJpvL/mAeobdk5RsFl8YqV9fMHWHD7lty1CXpOELOA=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr27058292pfz.73.1608158445182; Wed, 16
 Dec 2020 14:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20201216214107.774969-1-gwendal@chromium.org> <20201216214107.774969-3-gwendal@chromium.org>
In-Reply-To: <20201216214107.774969-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Dec 2020 00:40:28 +0200
Message-ID: <CAHp75Ve+mA7NhyRN34KA--rhUMNo1YNV2fan15Cfw7b47jQe+A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: acpi_als: Add local variable dev in probe
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 11:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Use dev = &device->dev in probe routine for clarity.
> Remove setting parent of iio device, already done in iio_device_alloc().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Added in v4.
>  Changes in v5:
>  Follow inverted xmas tree declaration convention.
>
>  drivers/iio/light/acpi-als.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 6dbaeeebe2041..fd20808d4a119 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -161,11 +161,12 @@ static const struct iio_info acpi_als_info = {
>
>  static int acpi_als_add(struct acpi_device *device)
>  {
> -       struct acpi_als *als;

I was talking only about dev, but I don't think it's a big deal for
maintainers to have this change here.

> +       struct device *dev = &device->dev;
>         struct iio_dev *indio_dev;
>         struct iio_buffer *buffer;
> +       struct acpi_als *als;
>
> -       indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
>         if (!indio_dev)
>                 return -ENOMEM;
>
> @@ -181,13 +182,13 @@ static int acpi_als_add(struct acpi_device *device)
>         indio_dev->channels = acpi_als_channels;
>         indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>
> -       buffer = devm_iio_kfifo_allocate(&device->dev);
> +       buffer = devm_iio_kfifo_allocate(dev);
>         if (!buffer)
>                 return -ENOMEM;
>
>         iio_device_attach_buffer(indio_dev, buffer);
>
> -       return devm_iio_device_register(&device->dev, indio_dev);
> +       return devm_iio_device_register(dev, indio_dev);
>  }
>
>  static const struct acpi_device_id acpi_als_device_ids[] = {
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
With Best Regards,
Andy Shevchenko
