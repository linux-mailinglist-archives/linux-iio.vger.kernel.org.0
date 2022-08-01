Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E700586348
	for <lists+linux-iio@lfdr.de>; Mon,  1 Aug 2022 06:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiHAET7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Aug 2022 00:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHAET6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2022 00:19:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146B13DD7
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 21:19:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v185so7567826ioe.11
        for <linux-iio@vger.kernel.org>; Sun, 31 Jul 2022 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7y69nF8yylApvNF8tnbnFLvYv1tkhmPPUVUPa2891qc=;
        b=DdXTOmV+TuIZy/mE4W6jNZd6uiwDY7MDmCSWRkBNW3cgfAqAI38xyqbn6VVnzEEAhb
         8G4MUMe9Hy5VxVs9CTBDnrEEMkIReFp4kcAdZ6D9CR9PFIdm+C6XGZE1hd1vdvN00oOL
         2RcgT4WsE2Y7qBZ8/6ootJRrgq5EGDvO0G2QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7y69nF8yylApvNF8tnbnFLvYv1tkhmPPUVUPa2891qc=;
        b=bvD2x1GmtAd9oa3IIhYjWhPv+D5g5xedxte3z5qTo16CNFRoRbS7k9U1G6JoFLfBKW
         RXDdL29jqjariSmIImIO4JZ3GEzofFG8DEwoyPM4h/j8NZz5BO3lQ2UcCX1mLTker5D7
         ipGkCfI4YBefNjBG6WUEN+T3u7Pp5t0uEbVk8cBQHeoYlqc9hwZw9QfvAx/Szv2odbFV
         BGf7Yw3qqpC2aCKkKZoe5yt6oQNS3ieNmjViuDt/cEaoShLWvmlFdlSDdP1Zlw4C9GTx
         BEQWvjMyuM0A1Cl+UY7PmHSFeeWeTbAsbyR4qHUTbQnxm6ZwNX9EGwokl0lwI/mRRvHw
         dlCQ==
X-Gm-Message-State: AJIora9AJV1ebWrZNI9p33QQbnA/vAmGfnJZu95QQAp5FGY8SRB5HsKd
        R3roBku9gOxguypOWYI2EJQLIXhBQyoSGy07ioRBjw==
X-Google-Smtp-Source: AGRyM1tBcfkws8S5Mv3ZWo4TZS8WuMZ7q8sUQvrr9rAzPOy8paIkj6HqvTFTxnv3QpKTmLVLyVlVJB1j6A/PSngNKz0=
X-Received: by 2002:a05:6638:dd1:b0:341:55c2:38b6 with SMTP id
 m17-20020a0566380dd100b0034155c238b6mr5539717jaj.245.1659327589288; Sun, 31
 Jul 2022 21:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154723.99947-1-matt.ranostay@konsulko.com> <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com>
In-Reply-To: <CAHp75VcOAbrZ2yciwH6teYs5L0vYnE4z==SQ6ejye63+_v9v+g@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 1 Aug 2022 12:19:37 +0800
Message-ID: <CAJCx=gnxV7-oQCNE1LvpcFGhPCQ86rRbn_2NMh4MWpvmQ9WAYw@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 1, 2022 at 3:11 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 29, 2022 at 5:49 PM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > Add support for 3x 10-bit ADC and 1x DAC channels registered via
> > the iio subsystem.
> >
> > To prevent breakage and unexpected dependencies this support only is
> > only built if CONFIG_IIO is enabled, and is only weakly referenced by
> > 'imply IIO' within the respective Kconfig.
> >
> > Additionally the iio device only gets registered if at least one channel
> > is enabled in the power-on configuration read from SRAM.
>
> I tried to leave the comments not clashed with Jonathan's ones below.
>
> ...
>
> > Cc: Rishi Gupta <gupt21@gmail.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Use --cc in the parameters to `git format-patch` or move them after
> the cutter '---' line below, so they won't pollute the Git commit
> message.

Noted for the future.
>
> ...
>
> > -       depends on GPIOLIB
> > +       select GPIOLIB
>
> I'm not sure why.

Changed to select from 'depends on' to avoid this circular dependency

  SYNC    include/config/auto.conf.cmd
drivers/gpio/Kconfig:14:error: recursive dependency detected!
drivers/gpio/Kconfig:14:        symbol GPIOLIB is selected by I2C_MUX_LTC4306
drivers/i2c/muxes/Kconfig:47:   symbol I2C_MUX_LTC4306 depends on I2C_MUX
drivers/i2c/Kconfig:62: symbol I2C_MUX is selected by MPU3050_I2C
drivers/iio/gyro/Kconfig:127:   symbol MPU3050_I2C depends on IIO
drivers/iio/Kconfig:6:  symbol IIO is implied by HID_MCP2221
drivers/hid/Kconfig:1298:       symbol HID_MCP2221 depends on GPIOLIB
For a resolution refer to Documentation/kbuild/kconfig-language.rst

>
> ...
>
> >  #include <linux/hidraw.h>
> >  #include <linux/i2c.h>
> >  #include <linux/gpio/driver.h>
>
> + blank line.
>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
>
> + blank line.
>
> >  #include "hid-ids.h"
>
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +       struct iio_chan_spec iio_channels[3];
> > +       struct iio_dev *indio_dev;
> > +       u16 adc_values[3];
> > +       u8 dac_value;
> > +#endif
> > +};
>
> ...
>
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +                       if (mcp->indio_dev)
> > +                               memcpy(&mcp->adc_values, &data[50], 6);
>
> sizeof()

sizeof(mcp->adc_values) would work here if needed.

>
> > +#endif
>
> ...
>
> > +               // Confirm value is within 10-bit range
> > +               if (*val > GENMASK(9, 0))
>
>   if (*val >= BIT(10))
>
>  will make comment useless
>
> > +                       return -EINVAL;
> > +       }
>
> ...
>
> > +       if (val < 0 || val > GENMASK(4, 0))
>
> In a similar way, val >= BIT(5).
>
> > +               return -EINVAL;
>
> ...
>
> > +       memset(mcp->txbuf, 0, 12);
>
> sizeof() ?

txbuf isn't 12 bytes long but 64 since that is the full max size a HID
transaction could
have. So sizeof() won't work in these cases..

>
> ...
>
> > +       ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);
>
> Ditto,

See above.

>
> > +       hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
>
> Even in an error case?

hid_hw_power was set to PM_HINT_FULLON before the check, and in error case it
should reset back to normal hint.

>
> > +       if (ret) {
> > +               mutex_unlock(&mcp->lock);
> > +               return -EINVAL;
> > +       }
>
> ...
>
> > +#if IS_REACHABLE(CONFIG_IIO)
> > +       if (mcp->indio_dev)
>
> Do you need this check?

Yes basically if no ADC or DAC channel is enabled then no iio_device
get allocated or registered.

>
> > +               iio_device_unregister(mcp->indio_dev);
> > +#endif
>
> ...
>
> Overall what I really do not like is that ugly ifdeffery. Can we avoid
> adding it?

Could make CONFIG_IIO required for building but not sure we really
want to add as an additional dependency.
Which is way the imply is set for CONFIG_IIO

- Matt

>
> --
> With Best Regards,
> Andy Shevchenko
