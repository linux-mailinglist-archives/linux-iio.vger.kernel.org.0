Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE858312B15
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBHH2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 02:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBHH2b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:28:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1745C061756
        for <linux-iio@vger.kernel.org>; Sun,  7 Feb 2021 23:27:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n2so13938957iom.7
        for <linux-iio@vger.kernel.org>; Sun, 07 Feb 2021 23:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hU3cmz681hcEYIYHHUEkknX5BOs8loQLHjQEL4TAQy0=;
        b=PWhOSpKxZX3iuJOmMyT5VXVJ07MlWdUSB3+7wihmtBqqii/u3d4mioySnM/Nrjy+4O
         XC0TjMCvT8Ge4I6ZQ0J0nyO0Nd8SZ2VM0m8J3EZB5M/Mj0YbeVUKTMti73tx1kcyFmub
         ClTAqYMWywLusK2klBOWJiB7t4l7qcWFkHYAndeIUc0DGAFMbA5ywA4pdNV00g0aL7or
         4SQyX13wWQdW3YGt3MsRBkoxoefQoy7pwUJDEAB08EieuJ2jBODbvsodspRthAEaTNI5
         +BWhrZ7y8ftEaZJ1LQWEbyPH8aYoUogy2gzZV3Ijmu0JpBZ1rxRC79rwIqZWLxPeOAmh
         5Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hU3cmz681hcEYIYHHUEkknX5BOs8loQLHjQEL4TAQy0=;
        b=OXjYIbLlsTPNiRHELj2qxA+gcs5LmBWaGsfCDMFNIpEn150W8Va2ic82So9/uuID8U
         57iamm6XTAxB+b6Ld3+5uXABJzc+NwxqnZF0/yoAprRcKI3nYcivKaDeG02olkYZrZsV
         llexqgtAeOrb6QbbLf7nF9qbVjfGPoK3qmllUN9SGXA0YPWeK8s1gfARAC3FePSY0ln4
         VxbNJKdlV+QNuricBwP9FDc4LAg7VoE5F5ZLbrWPatjJzwi3dLR/JjMuvaO8HrO+nEyK
         qvkcPhwHFP04ZJlvS+dtQfpE1XbtNUk/0p4txHKvK7U1Mi1RxyK/et7tiSaiI/yY2l0V
         X1Zg==
X-Gm-Message-State: AOAM530l7qE7IV4vBFmtTkroaXDDHX0fwq4PsGkOzYy4277C00x0b6DM
        8j0kmKQ7CqnmDkyYln93WFXetzzojB34EgKVkCXxjwFP
X-Google-Smtp-Source: ABdhPJzL9bzu4RoK0CJkuwLIa2dda5HJJ54jwpl7mg9+MNYezTli4bE/eY3GLcNNXItI4YsgTn7m2cDbZYPE7eZevOk=
X-Received: by 2002:a02:3b6c:: with SMTP id i44mr16102460jaf.91.1612769269912;
 Sun, 07 Feb 2021 23:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20210207160901.110643-1-hdegoede@redhat.com> <20210207160901.110643-2-hdegoede@redhat.com>
In-Reply-To: <20210207160901.110643-2-hdegoede@redhat.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Feb 2021 09:27:38 +0200
Message-ID: <CA+U=DsriyMvU5=iRrh73UJxHxT7FuA_P_pCHVaY9JskmLSffNA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: core: Allow drivers to specify a label without
 it coming from of
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 7, 2021 at 6:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Only set indio_dev->label from of/dt if there actually is a label
> specified in of.
>
> This allows drivers to set a label without this being overwritten with
> NULL when there is no label specified in of. This is esp. useful on
> devices where of is not used at all, such as your typical x86/ACPI device.

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>


>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/industrialio-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e9ee9363fed0..b409e076818b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1755,6 +1755,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
> +       const char *label;
>         int ret;
>
>         if (!indio_dev->info)
> @@ -1765,8 +1766,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>         if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>                 indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
>
> -       indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
> -                                          NULL);
> +       label = of_get_property(indio_dev->dev.of_node, "label", NULL);
> +       if (label)
> +               indio_dev->label = label;
>
>         ret = iio_check_unique_scan_index(indio_dev);
>         if (ret < 0)
> --
> 2.30.0
>
