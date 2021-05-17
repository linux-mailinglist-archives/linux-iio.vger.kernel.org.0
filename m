Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DD33825A1
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhEQHro (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhEQHrn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:47:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DDC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:46:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4080838pjo.0
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9Y2K5Ans0M4CSOMKP1w1Y9kx0u6b1RLtEmzO6UjsDk=;
        b=dH4nQnYiVHZUW+9DJTmab/Ne9FtVtcTrulVqztp+mHJBkhx03FRSruAhle5mbBV6uk
         T9skGSiVeFehPBHp0hFihc2U6xf+bpuFMpctfe9PrA6OINyd3cmWwEcx8mvklr4MR7El
         vmxCbr8naeWjS5Q2yu4DiP6LjP5IPth8fQRJeC6t7h6aetA1nVc0GeUoBnrZ/938k/a1
         0iwbWW1rum1n5ElQCMy7z+BHaoSJktkpuBeMUzPhjUlLo+FgqgY3a96VdWLZFcmX6b+Q
         yjHdMd2onLP/UplW/8E9DBYPmdlQ1kXY6XN+m7ZvL3bwRFiWQ8lpMnULKHsJCHDsSe1T
         mxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9Y2K5Ans0M4CSOMKP1w1Y9kx0u6b1RLtEmzO6UjsDk=;
        b=TDod36YdcvM+heWsxbRGpFq7qrH3m07mL6MjUquuzbKIpOJ2XFnfzO+im3PgiKg5+j
         ipAOjCo8oKMcyTNo9VW9sqSgsos/OET5IFbsYKTUERmO3Tn4sIvuED/xv5HQfRJaE9yj
         XkKMBm3eT3zmNXiw6Rlbk24d5nYTXj/49nFBotRWaT9wHzGKtp/ElduVfI1jRYM4mhBs
         3omzwrobv6+P2V64hKXQ83X4oaTCu+8UgDiyjVSxfKq+tbr0PG6Zu4NTwK29MsIwhV0p
         MAWcuvioeJ73/5Li0NoqAhIlQFORsxRQdPKliEieAy8eXRAT47ypUPUWUKSeewre9qop
         jrwA==
X-Gm-Message-State: AOAM5304WVBnxfnDfff+RkIpRNBcJcIYwNHfuwwuQkWc2v3YeDQi9G/x
        SQSg1uUTgTSkgo7BQBq0MyJU6gExzK8iNxGkyRE=
X-Google-Smtp-Source: ABdhPJzTsVzVVVPGebowcEMAg8E7NftAfZEWH0wHhHEIiX/N3bnuVCEWz/KlzueBLV3Ykuf/CTd66wATQNq3jSsTxeY=
X-Received: by 2002:a17:90a:d184:: with SMTP id fu4mr1622116pjb.129.1621237587294;
 Mon, 17 May 2021 00:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210515000058.204601-1-linus.walleij@linaro.org>
In-Reply-To: <20210515000058.204601-1-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 May 2021 10:46:11 +0300
Message-ID: <CAHp75Ve-dNqKprs-qsEDbKtZAh74Tdvbggwj5p6W9Akt1=01FQ@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
To:     Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 15, 2021 at 6:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The ST accelerators support a special type of quirky
> mounting matrix found in ACPI systems, but not a generic
> mounting matrix such as from the device tree.
>
> Augment the ACPI hack to be a bit more generic and
> accept a mounting matrix from device properties.
>
> This makes it possible to fix orientation on the Ux500
> HREF device.

I think this entire thread may be interesting to Hans, hence Cc him.


> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/st_accel_core.c | 51 ++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 43c50167d220..cfbcf740e3cb 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1069,26 +1069,25 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>
> -#ifdef CONFIG_ACPI
>  static const struct iio_mount_matrix *
> -get_mount_matrix(const struct iio_dev *indio_dev,
> -                const struct iio_chan_spec *chan)
> +st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
> +                         const struct iio_chan_spec *chan)
>  {
>         struct st_sensor_data *adata = iio_priv(indio_dev);
>
>         return adata->mount_matrix;
>  }
>
> -static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
> -       IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
> +static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
> +       IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
>         { },
>  };
>
> +#ifdef CONFIG_ACPI
>  /* Read ST-specific _ONT orientation data from ACPI and generate an
>   * appropriate mount matrix.
>   */
> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> -                                 struct iio_chan_spec *channels)
> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  {
>         struct st_sensor_data *adata = iio_priv(indio_dev);
>         struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> @@ -1207,22 +1206,20 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>                 }
>         }
>
> -       /* Expose the mount matrix via ext_info */
> -       for (i = 0; i < indio_dev->num_channels; i++)
> -               channels[i].ext_info = mount_matrix_ext_info;
> -
>         ret = 0;
>         dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
>
>  out:
>         kfree(buffer.pointer);
> +       dev_warn(&indio_dev->dev,
> +                "failed to apply ACPI orientation data: %d\n", ret);
> +
>         return ret;
>  }
>  #else /* !CONFIG_ACPI */
> -static int apply_acpi_orientation(struct iio_dev *indio_dev,
> -                                 struct iio_chan_spec *channels)
> +static int apply_acpi_orientation(struct iio_dev *indio_dev)
>  {
> -       return 0;
> +       return -EINVAL;
>  }
>  #endif
>
> @@ -1251,6 +1248,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>         struct iio_chan_spec *channels;
>         size_t channels_size;
>         int err;
> +       int i;
>
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &accel_info;
> @@ -1275,9 +1273,28 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>                 goto st_accel_power_off;
>         }
>
> -       if (apply_acpi_orientation(indio_dev, channels))
> -               dev_warn(&indio_dev->dev,
> -                        "failed to apply ACPI orientation data: %d\n", err);
> +       /* First try ACPI orientation then try the generic function */
> +       err = apply_acpi_orientation(indio_dev);
> +       if (err) {
> +               adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
> +                                                  sizeof(*adata->mount_matrix),
> +                                                  GFP_KERNEL);
> +               if (!adata->mount_matrix) {
> +                       err = -ENOMEM;
> +                       goto st_accel_power_off;
> +               }
> +
> +               err = iio_read_mount_matrix(adata->dev, "mount-matrix",
> +                                           adata->mount_matrix);
> +               if (err)
> +                       goto st_accel_power_off;
> +       }
> +       /*
> +        * We have at least an identity matrix, so expose the mount
> +        * matrix via ext_info
> +        */
> +       for (i = 0; i < indio_dev->num_channels; i++)
> +               channels[i].ext_info = st_accel_mount_matrix_ext_info;
>
>         indio_dev->channels = channels;
>         adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
