Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332033AAD01
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jun 2021 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFQHJs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Jun 2021 03:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFQHJo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jun 2021 03:09:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A38C06175F;
        Thu, 17 Jun 2021 00:07:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y15so4257266pfl.4;
        Thu, 17 Jun 2021 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTOj6xfPO3fsV1CEIiylHgE3vD+iDDnuC1azPtYCNX0=;
        b=DRQ5tSHVtx3G7/1u/hpCsP42+aMBuGl6MJf+zD6fKAGhuB0GY0hE7tz/0AgF/Vqa5Y
         tbVOi2NfOVFfz4/Sx8VTuhTMdMYa1Gnx1PjsReCL4ngXvg7/9jLU2lzElEAChofFi3uX
         6W4UuK8ogbB5NwoVjkGWXv+r56GBYgZQdOwCdSBvDbf7GNP8XgvjvwymLFtCjCcI85wY
         ahWO3PhxLnZcq2LibmiI3KQx33AIde5fmMMZFy44k1d4lRmojIeccUCF/Z5YUVPqX05t
         W7t+fIie63EXEA+to2CDo7Ovl+LdRy8rSSGXFoTegYEr4ZzQY4ZrXRvlIv77qVArZCXZ
         7I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTOj6xfPO3fsV1CEIiylHgE3vD+iDDnuC1azPtYCNX0=;
        b=PCP2X66mClHV2GBOOw8tS/30kJbT4FWyQ9ycr5gHJc4bReCOxahzmpQGTcWk6zuviK
         S15x1jough8JwAudOG4HKqqGrcCR8n1kYilDK4VJQxlXfsauxhNm8iDC3di+31GHjTfZ
         ONXTQShyWxZtvEgwBk+OOuMNRethiRMN3dZdbHVA7+g61RD/2AOeIji3vD0pOrfrQgkH
         IEeyjrpZNec9mUPPIdvzrPth37CT1+FAdyDVLynW8bsQoqExG3zFa0pwBXT+VdE8euvR
         aMiiaDmXDOdcHlC90CLoy8vYuMron1SWPHLn6a/GQCAiQ+V0Mt3YUFu05WzO0nZrLAiS
         J50A==
X-Gm-Message-State: AOAM533HEdj6y3iTxaErdAbZJTVIYWu+Jvqw79S0qr59GLFXaAqCGKLK
        tv4llEpXfwJp5Ht2hjH9m/2r0xPlzKhLKCDQ8EVyRlo23jk=
X-Google-Smtp-Source: ABdhPJzIxRJtTuS6xsgzFG4n1rzZprPGin+rzMki23EjsAvTRZeldD9nMVWMOrUOdSqxYhJak4NoNeSLip3VKtkJOT8=
X-Received: by 2002:a05:6a00:8c4:b029:2b4:8334:ed4d with SMTP id
 s4-20020a056a0008c4b02902b48334ed4dmr3847867pfu.36.1623913654992; Thu, 17 Jun
 2021 00:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210616155706.17444-1-paul@crapouillou.net> <20210616155706.17444-2-paul@crapouillou.net>
In-Reply-To: <20210616155706.17444-2-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 17 Jun 2021 10:07:23 +0300
Message-ID: <CA+U=Dsqcf5EERsFHh5LFHwe5U9MhpPxQNLBVUjM9boTMnp+rQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: core: Forbid use of both labels and extended names
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 7:01 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Extended names are a problem for user-space as they make the filenames
> in sysfs sometimes not parsable. They are now deprecated in favor of
> labels.
>
> This change makes sure that a device driver won't provide both labels
> and extended names for its channels. It has never been the case and we
> don't want it to happen.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/industrialio-core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 59efb36db2c7..81f40dab778a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1836,6 +1836,24 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>         return 0;
>  }
>
> +static int iio_check_extended_name(const struct iio_dev *indio_dev)
> +{
> +       unsigned int i;
> +
> +       if (!indio_dev->info->read_label)
> +               return 0;
> +
> +       for (i = 0; i < indio_dev->num_channels; i++) {
> +               if (indio_dev->channels[i].extend_name) {
> +                       dev_err(&indio_dev->dev,
> +                               "Cannot use labels and extend_name at the same time\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> @@ -1860,6 +1878,10 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>         if (ret < 0)
>                 return ret;
>
> +       ret = iio_check_extended_name(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
>         iio_device_register_debugfs(indio_dev);
>
>         ret = iio_buffers_alloc_sysfs_and_mask(indio_dev);
> --
> 2.30.2
>
