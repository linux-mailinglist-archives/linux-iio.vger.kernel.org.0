Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C525606FC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jun 2022 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF2RHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jun 2022 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiF2RHw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2022 13:07:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC733B3F4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2022 10:07:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l24so16594599ion.13
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2022 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWMzIXojI+ttY2SDXagOqcxEQRzCsEmFvrsDHTBRK20=;
        b=gX9xngP3D5r+MYEe5RPECfjmwoQUsE9Em2GuQBIkntlGZtBPem7PD87guLunPxJdfn
         FUPCj6Gkx1agFt6O1sU7h/HfeIVcctXHolf6UbF6PzvLUBIXJ7VoGuBBervuqWgJtsf3
         KiZg9xPoHuNFkw/7pxLCchqUoDfgMxZGDDC4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWMzIXojI+ttY2SDXagOqcxEQRzCsEmFvrsDHTBRK20=;
        b=OtVgE5fL5pcbBqVWdFnCdBbt+QGGl1OWHw6zlRmXLHqHTQ7wgfpnlLvHfujpjET+B3
         RBwFOn1LHhRwAnGw7JGYzr/BncGUaYpgn+rvOUyDHETyZ7ggaZU2D1Kluj53mE2obR5P
         agqETaChAdOJQXmxzrGczakh8X3jisCF/w7SFRXoLZgo6L3ZU16Fs/RiJ7kHocH3b4oG
         XkoTbg0ZjoS9pZ+o16W2dqcNDFCL5pXGJZhqlRM+gQTJkjMJ1ueKOViFGd3/UkFLhuJw
         dOKSiTeX1wl/rGybsz+twc/B/s3ZauZjiQ8Nts30RFFOOss98UAyGKe0AKrhOhuXOjxx
         6Jyg==
X-Gm-Message-State: AJIora9BR4pSwzqjYij8qfJnIUm3fvkUwhnk78A/bLU0gOATdEf8i9X3
        7LbEkJUWu3FOocoR8XzMaL5O3vsrXqs8nnbVBNVzbw==
X-Google-Smtp-Source: AGRyM1u+XGcHanakfZb+s8mMtKAP7a50kIS8vjCPialWF3iF9lJKL2UEVSmRn+5W6qgs8LKLfdayVvRAmcY0VNlYElw=
X-Received: by 2002:a05:6638:37a6:b0:339:c91c:76ba with SMTP id
 w38-20020a05663837a600b00339c91c76bamr2595483jal.103.1656522471088; Wed, 29
 Jun 2022 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com> <20220615114746.2767-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220615114746.2767-2-andriy.shevchenko@linux.intel.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 29 Jun 2022 10:07:40 -0700
Message-ID: <CAPUE2use-nt7LRQ0g_L7EW7wWfPQ-c7LinRoyx_WeMzLfdWOag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: proximity: sx_common: Allow IIO core to take
 care of firmware node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 15, 2022 at 4:47 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> IIO core correctly will take care of firmware node if it's not set in
> the driver. Drop ACPI and OF specifics from the driver and allow IIO
> core to handle this.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> v2: no changes
>  drivers/iio/proximity/sx_common.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index 9f2e47385198..d70a6b4f0bf8 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -5,7 +5,6 @@
>   * Common part of most Semtech SAR sensor.
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/bitops.h>
>  #include <linux/byteorder/generic.h>
>  #include <linux/delay.h>
> @@ -519,8 +518,6 @@ int sx_common_probe(struct i2c_client *client,
>         if (ret)
>                 return dev_err_probe(dev, ret, "error reading WHOAMI\n");
>
> -       ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         indio_dev->channels =  data->chip_info->iio_channels;
> --
> 2.35.1
>
