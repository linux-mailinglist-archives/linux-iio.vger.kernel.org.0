Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC22DC90D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgLPWkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 17:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPWkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 17:40:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D56EC061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:39:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z21so1523492pgj.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 14:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7Ff/ixC5JIizsfVKcH1Zoe87yYdksvlJCzuf1y4f0c=;
        b=TlpY9oBDmtBJxMPyYYBZU7XXDAk3APx0ubt8Z8C+jpwjuNgRbEDAG6vBhPC+mBmiE6
         LLY5TB8axz8aTviTcEQQw4U3gKiDxiUaQq+O8gB1AqE1B2Jupu9WfvzCUNzWubyg6c2G
         AWlt3khMcLIATTmInCVFRZ6o1qqm7e1xKmLH4vZjjlCbseChyzWDmcv4iGLBVE9mIdwg
         R5qzV35MLK5W0iI8aUZfKoK6b923Gs+UfRLWZwFrnqQKA8/sgSAmVnQxQRaoLkukq18M
         NmfT8S6ue2WhJRLCd/W8LGTaf9+vy0nO4kzrRuZkpdzjVvJKjvdmdVTzF8oD7zRyRdLD
         X2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7Ff/ixC5JIizsfVKcH1Zoe87yYdksvlJCzuf1y4f0c=;
        b=IJKP0aCDcccsXErunbGRzXfgOTqPzvYkw4U41W6UZY6RySpzx5iaa0ru8yQu2kiBVZ
         NaWvFZkHMENuj/ToxS6tzlwt3uFTqHDADjEq7yke8Nozl4ZZa2UxC/7Cmwi+iQgVKS94
         V9Mys2XNEhcsAaP38MCp3vuHUJjqMjZkv4cD+9YQ/gkZF/qec4R8oh3FCIW3im4GqTiX
         ChwHLg+boSNkEtEYg/1xyHQheo6hGG1Dkb/QVIdlTvdWDH3QKOQ/PTgBEkcUYUvgJd/v
         PQZP/vdJM3y6F+KK+vfxocEPPTf9N2ok2D34JuIBvPNHyE8VTpTwMrqsP6FlngaTAv12
         e5yQ==
X-Gm-Message-State: AOAM533GRcDL4R52Gw8F2CXlzhw7tAL+MaftpkiWQspyE6jPYaJmCqZS
        Pla+jwEy7NAj141QDJ6E9sg/iVGANWWBhHk37pidH6S27++rcw==
X-Google-Smtp-Source: ABdhPJxas+38VvNSlORe35CrTdPFiwLlNf05MsmHKbReX12rl+l487RSSLRllCfvd9HHjqL2OYQ4cjQ6BymO8M3usiY=
X-Received: by 2002:a63:74b:: with SMTP id 72mr7527748pgh.4.1608158364868;
 Wed, 16 Dec 2020 14:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20201216214107.774969-1-gwendal@chromium.org> <20201216214107.774969-2-gwendal@chromium.org>
In-Reply-To: <20201216214107.774969-2-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 17 Dec 2020 00:39:08 +0200
Message-ID: <CAHp75Vc_tbznokTHDxK0=85QFz9tB2=zKQurV8tpk3z9pnnrYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: acpi_als: Add timestamp channel
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
> Add timestamp channel in list of channel, to allow retrieving timestamps
> when events are produced.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Changes in v4:
>  Fix spelling.
>  Changes in v5:
>  Fill comment line.
>
>  drivers/iio/light/acpi-als.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 2be7180e2cbfa..6dbaeeebe2041 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -45,24 +45,22 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>                 .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
>                                           BIT(IIO_CHAN_INFO_PROCESSED),
>         },
> +       IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>
>  /*
>   * The event buffer contains timestamp and all the data from
>   * the ACPI0008 block. There are multiple, but so far we only
> - * support _ALI (illuminance). Once someone adds new channels
> - * to acpi_als_channels[], the evt_buffer below will grow
> - * automatically.
> + * support _ALI (illuminance): One channel, padding and timestamp.
>   */
> -#define ACPI_ALS_EVT_NR_SOURCES                ARRAY_SIZE(acpi_als_channels)
>  #define ACPI_ALS_EVT_BUFFER_SIZE               \
> -       (sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
> +       (sizeof(s32) + sizeof(s32) + sizeof(s64))
>
>  struct acpi_als {
>         struct acpi_device      *device;
>         struct mutex            lock;
>
> -       s32                     evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
> +       s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
>  };
>
>  /*
> --
> 2.29.2.729.g45daf8777d-goog
>


-- 
With Best Regards,
Andy Shevchenko
