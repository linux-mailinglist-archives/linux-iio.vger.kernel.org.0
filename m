Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD945860AF
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jul 2022 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiGaTLM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jul 2022 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiGaTLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2022 15:11:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4FE65EB;
        Sun, 31 Jul 2022 12:11:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so3580842edi.8;
        Sun, 31 Jul 2022 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N9TzygIlXLM3Z2KukcycWlOSx5kWJFifEhCzKRgF1gA=;
        b=HNbVpHwWmTCmas9WysmtUinZwpcopaWvw3wyTXyvfs8hMHTdlN+e4YbkyPB/R37e6T
         0lZKS+DHXVMtyTS8qA8aGH2vscG4Kk+hxS+/qOnLJtugCsTK/vsXUqSH26zWP10UaRZN
         YIPBTCtnxfRZldIxNyVfhn+UgzDxGSIS3Ow48lLHEFZmk/a7G21FE5A81N6sUMD6byhR
         jj7u5i/g4turdzS9xHikpdV4JEHmjuEkT3gQ0PLqRYpoHavDBQebUn9LcLR00piHNbBJ
         0khY6FMSAhtA4Hu1cUTXTDAqfE35fuTlomUPXWaBm6wBevGuAI2Axwpb3wfOhritVM9X
         fOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N9TzygIlXLM3Z2KukcycWlOSx5kWJFifEhCzKRgF1gA=;
        b=RBNY8/+VGKVCnH0l1w3xpfL/y2SktAiL019v5jIQyz75PNJ7OeH8mQIp8XcOy7/1D2
         svDsNuukbkx20to7X6RWp16pPSQXZWJNZvpJAbojmBOIVWW6cSX3nyavX5Ub5ZzHJQ6L
         9/Y+I7rPL1FEorT/usXIP3R3xNZ3EbmMjkBmXmAp7OcLzOm6Cmisgy5X/iLxBZFmVIzp
         r95zyg9rRzsWVKMBPeQc7ZdoWBu0I9YMDhzWhBefoaHoU1zduHCs6nYszho05f72XHrq
         TrEsDb6/PERaTTGgDMIAPaNQp3FXEUdJfrz403UvZwf3NcwyrjbhD0qQDBKTY4qlF92q
         +AJw==
X-Gm-Message-State: AJIora+/NBv/pQaAVW7E+3dV0Yz72HzY5ZRJV8PnqxDiDLfC3CAfIM/Q
        xCEaJvOC+W+I+Ez5uGTZTJeiDrymdrUqN0ZGB2KCgDomkTE=
X-Google-Smtp-Source: AGRyM1syYtGLjvc5qY6nTrcS6BJOI5qSZHSFfA51YPadw3WE403l9yEgF4/WW19jPXYlUVuqO17uPZ+m/WIEErP/PcE=
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id
 h11-20020a056402280b00b0043b5d75fcfamr12320552ede.114.1659294669132; Sun, 31
 Jul 2022 12:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154723.99947-1-matt.ranostay@konsulko.com>
In-Reply-To: <20220729154723.99947-1-matt.ranostay@konsulko.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Jul 2022 21:10:32 +0200
Message-ID: <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 29, 2022 at 5:49 PM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> Add support for 3x 10-bit ADC and 1x DAC channels registered via
> the iio subsystem.
>
> To prevent breakage and unexpected dependencies this support only is
> only built if CONFIG_IIO is enabled, and is only weakly referenced by
> 'imply IIO' within the respective Kconfig.
>
> Additionally the iio device only gets registered if at least one channel
> is enabled in the power-on configuration read from SRAM.

I tried to leave the comments not clashed with Jonathan's ones below.

...

> Cc: Rishi Gupta <gupt21@gmail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use --cc in the parameters to `git format-patch` or move them after
the cutter '---' line below, so they won't pollute the Git commit
message.

...

> -       depends on GPIOLIB
> +       select GPIOLIB

I'm not sure why.

...

>  #include <linux/hidraw.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio/driver.h>

+ blank line.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

+ blank line.

>  #include "hid-ids.h"

> +#if IS_REACHABLE(CONFIG_IIO)
> +       struct iio_chan_spec iio_channels[3];
> +       struct iio_dev *indio_dev;
> +       u16 adc_values[3];
> +       u8 dac_value;
> +#endif
> +};

...

> +#if IS_REACHABLE(CONFIG_IIO)
> +                       if (mcp->indio_dev)
> +                               memcpy(&mcp->adc_values, &data[50], 6);

sizeof()

> +#endif

...

> +               // Confirm value is within 10-bit range
> +               if (*val > GENMASK(9, 0))

  if (*val >= BIT(10))

 will make comment useless

> +                       return -EINVAL;
> +       }

...

> +       if (val < 0 || val > GENMASK(4, 0))

In a similar way, val >= BIT(5).

> +               return -EINVAL;

...

> +       memset(mcp->txbuf, 0, 12);

sizeof() ?

...

> +       ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);

Ditto,

> +       hid_hw_power(mcp->hdev, PM_HINT_NORMAL);

Even in an error case?

> +       if (ret) {
> +               mutex_unlock(&mcp->lock);
> +               return -EINVAL;
> +       }

...

> +#if IS_REACHABLE(CONFIG_IIO)
> +       if (mcp->indio_dev)

Do you need this check?

> +               iio_device_unregister(mcp->indio_dev);
> +#endif

...

Overall what I really do not like is that ugly ifdeffery. Can we avoid
adding it?

-- 
With Best Regards,
Andy Shevchenko
