Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260854A15B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiFMVaC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbiFMV3T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 17:29:19 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8727D390
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 14:25:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n11so7485213iod.4
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NnE+Xgzg7AJlz/AVhS5h85z464OyTQxoGvdET9a4HY=;
        b=dGPjzDX0wzDFKyXDAUW16dsPz49CqHJLXNBHBiPeOgaE5d8xIbI0bX7Mtw+wOV7ghH
         YdkHbi8kLXpQAGTQENTv5yw/FQizJyoXOIltRHJDFSNGf7ugFCFAHx/drsOJszoBvwES
         3p+trjrQuIZ1rUqPy7JNsgwyvKgJewjazkJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NnE+Xgzg7AJlz/AVhS5h85z464OyTQxoGvdET9a4HY=;
        b=a1uUa5wQ35L3qVHSDQQMyIs8NCfRQgsosQupgBKaKwFAsHwxJEiW+hjZc+WU8GniRB
         0durF0rMH1jgGjZn3N3nyBHM63lk8dNYPPFhPUro3P7yoZ/vhbDcEhSH7aGda8disEH3
         eyZnQ+4BG2opeDew94t2Ak7xJMp1hC+d5jA38CL8LOIl7lxfFFmFgQeaARAAzmdO/WMS
         d3+wnoNC+59cMBJanV1fQFX9sv5KcDeWeFbHUn347/42brwZn/x61pED02NcWk1kKe/M
         jNMyKvyFF9RHm+JdLET1ccf0Uf0v8fuVgEIkdRVDcWtb79b6Iv/3CR++kYf8mkBZEIf3
         fAAA==
X-Gm-Message-State: AOAM532Qxfgd3OguZc4PiFUejyckRc+Xt+PCV8swRxJFulP02p3f2aO1
        tO9QYxraEeNtMd8jX/BU5IMzTOrd0vBU0cfRs6h+0g==
X-Google-Smtp-Source: ABdhPJyIxaI4vfZUSuU/ut9uN+5eC6ns20NayC9QlK+nuCJcAcU7BG8to5jvy1RRIeWa4opwhwvNAExigeFrGbuL6o8=
X-Received: by 2002:a05:6602:13c3:b0:669:cb19:6fe6 with SMTP id
 o3-20020a05660213c300b00669cb196fe6mr818734iov.177.1655155531829; Mon, 13 Jun
 2022 14:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com> <20220603180618.4b643391@jic23-huawei>
In-Reply-To: <20220603180618.4b643391@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 13 Jun 2022 14:25:21 -0700
Message-ID: <CAPUE2usmrREACn+bjRfMyNvF1aeozJq+tHCQY6XT7KMXvp94Bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to take
 care of firmware node
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The reason we have the code ACPI_COMPANION_SET and dev.of_node set (by
commit 74a53a959028e ("iio:proximity:sx_common: Fix device property
parsing on DT systems") from Stephen is we are getting device propery
in ->get_default_reg(), which is called in sx_common_init_device(),
before devm_iio_device_register().

We have the same code path in other driver, like adc/stm32-adc.c,
where indio_dev->dev.of_node is set manually to be able to set the
resolution based on device tree properties.

Gwendal.

On Fri, Jun 3, 2022 at 9:57 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 30 May 2022 20:43:26 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > IIO core correctly will take care of firmware node if it's not set in
> > the driver. Drop ACPI and OF specifics from the driver and allow IIO
> > core to handle this.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Looks fine to me.  As such I'll apply it now, but Gwendal, you've
> been active with this driver recently so if you have time to sanity check
> that would be great.  Once I've caught up with new stuff I plan to check
> where we are with your various series on this driver.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/proximity/sx_common.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> > index 8ad814d96b7e..6bb68c1835da 100644
> > --- a/drivers/iio/proximity/sx_common.c
> > +++ b/drivers/iio/proximity/sx_common.c
> > @@ -5,7 +5,6 @@
> >   * Common part of most Semtech SAR sensor.
> >   */
> >
> > -#include <linux/acpi.h>
> >  #include <linux/bitops.h>
> >  #include <linux/byteorder/generic.h>
> >  #include <linux/delay.h>
> > @@ -520,8 +519,6 @@ int sx_common_probe(struct i2c_client *client,
> >       if (ret)
> >               return dev_err_probe(dev, ret, "error reading WHOAMI\n");
> >
> > -     ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> > -     indio_dev->dev.of_node = client->dev.of_node;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >
> >       indio_dev->channels =  data->chip_info->iio_channels;
>
