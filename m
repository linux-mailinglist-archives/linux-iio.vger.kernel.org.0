Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB641B4DA1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 21:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDVTt6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVTt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 15:49:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CF2C03C1A9;
        Wed, 22 Apr 2020 12:49:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so1627788pgi.5;
        Wed, 22 Apr 2020 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HEjXLWdl4sPw3XwPrs+z0qSSwTKkZOkRFQhqNicUnn8=;
        b=hmUe4CbGCx7ZGzijtOIN3tmK9FTwPhKDYRSCHLVOzn7pV6XooalEFsDq91hNgXpblR
         N09kyRKZ/hyOaNU/0Jju84PzZpnqRSgl1aw9FoH3FXGk5O62q0UufIqzaIUULi3lMSGa
         EPOuSiDFw3FEgzhNl/TaWePHvp0dmHqxmjG1iLlxyZDTDY40XvHECFTBlS2Tyh4so24+
         Wa07s+y5L5acSUlMs+ho2pbfQwF14TXMW0OqFNG5KcvCg6cCpD9mepg9Bv5QXEUo26av
         0HTjRD2ddNgSd5QbYuA0O29gezH01ftVFtMeLVQjeEW5AdL3tLW+Pgdx+spld6qRgryM
         MIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEjXLWdl4sPw3XwPrs+z0qSSwTKkZOkRFQhqNicUnn8=;
        b=R6WAZu1UROnwfDxUsv8EYTMc7tVChGhWeWlFwY8dwJQpZcanxQ3m3Iry9EZr6xdv21
         MJR5lESXa3LaJ2Pq1QG4zzqwF8gk8Ks6nQspaf/rQ8YrFRJK6glZpZv/cPiC4heScUJr
         UnMpwxf7DyZmQqOj/Nqj3ZFhW14Iww9pwD4gW2AwbPWa7GEValWuGAzwFSZkV9MrXXDV
         +6S4tu6UOWEjnQIRSxQd9selniYmBUik/yw8BuuKc6dGS0c4be86KB/z3PkAyCxL4Qc9
         BtuVbBEYnkhh37fOG0f5e32+ZnmSqUI9GXO1iLhThEfWcpxLK043yI1JjyLWNxYVU7zL
         lN9Q==
X-Gm-Message-State: AGi0PubmUj9EnKYvJuhOjUQacsXPZAAukIKKKCsoD/puQkHryF+XHStz
        NBvnCo5wTuJTipWAfngsj6vr0E43ATEoTmPZT0hLgUYPzihUNg==
X-Google-Smtp-Source: APiQypIxyLahKCi/vpYF0opnA8l/k+KC9QX6ZJk1GOml3m2DnJfOIKNJrf7hKD/6La/CA40tlXqFvOF6AFIYCRvpy8M=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr663246pgb.203.1587584997877;
 Wed, 22 Apr 2020 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com> <20200422141135.86419-2-tomasz.duszynski@octakon.com>
In-Reply-To: <20200422141135.86419-2-tomasz.duszynski@octakon.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Apr 2020 22:49:44 +0300
Message-ID: <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> Add Sensirion SCD30 carbon dioxide core driver.

And DocLink tar of Datasheet: with a link?

...

> +static SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);

Would it be used in every module? You will get a compiler warning per
each module that is not using it.

...

> +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> +               int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> +                              u16 arg, char *rsp, int size));

My gosh.
Please, supply proper structure member in priv or alike.

...

> + * Copyright (c) Tomasz Duszynski <tomasz.duszynski@octakon.com>

Year?

...

> +#include <asm/byteorder.h>

asm goes after linux.

> +#include <linux/bits.h>
> +#include <linux/compiler.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>

Are you sure you need all of them?!

...

> +/* pressure compensation in millibars */
Put the unit as a suffix to each definition and drop useless comment.

> +/* measurement interval in seconds */

Ditto.

> +/* reference CO2 concentration in ppm */

Ditto.

> +enum {
> +       CONC,
> +       TEMP,
> +       HR,
> +};

Way too generic names for anonymous enum.

...

> +static int scd30_command(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
> +                        char *rsp, int size)
> +{

> +       /*
> +        * assumption holds that response buffer pointer has been already
> +        * properly aligned so casts are safe
> +        */
> +       while (size >= sizeof(u32)) {

> +               *(u32 *)rsp = be32_to_cpup((__be32 *)rsp);

Seems like rsp should be void * rather than char *.

> +               rsp += sizeof(u32);
> +               size -= sizeof(u32);
> +       }

NIH of https://elixir.bootlin.com/linux/v5.7-rc2/ident/be32_to_cpu_array ?

> +       if (size)

It can be done before even while loop with an immediate bail out.

> +               *(u16 *)rsp = be16_to_cpup((__be16 *)rsp);
> +
> +       return 0;
> +}

...

> +/* simplified float to fixed point conversion with a scaling factor of 0.01 */
> +static int scd30_float_to_fp(int float32)
> +{
> +       int fraction, shift,
> +           mantissa = float32 & GENMASK(22, 0),
> +           sign = float32 & BIT(31) ? -1 : 1,
> +           exp = (float32 & ~BIT(31)) >> 23;
> +
> +       /* special case 0 */
> +       if (!exp && !mantissa)
> +               return 0;
> +
> +       exp -= 127;
> +       if (exp < 0) {
> +               exp = -exp;

> +               /* return values ranging from 1 to 99 */
> +               return sign * ((((BIT(23) + mantissa) * 100) >> 23) >> exp);

  shift = 23 + exp;
  ... >> shift);

> +       }
> +
> +       /* return values starting at 100 */
> +       shift = 23 - exp;
> +       float32 = BIT(exp) + (mantissa >> shift);
> +       fraction = mantissa & GENMASK(shift - 1, 0);
> +
> +       return sign * (float32 * 100 + ((fraction * 100) >> shift));
> +}

Sounds like a candidate to IIO library or even lib/math/*.c.

...

> +static int scd30_wait_meas_irq(struct scd30_state *state)
> +{
> +       int ret, timeout = msecs_to_jiffies(state->meas_interval * 1250);

Magic number.

> +       reinit_completion(&state->meas_ready);
> +       enable_irq(state->irq);
> +       ret = wait_for_completion_interruptible_timeout(&state->meas_ready,
> +                                                       timeout);
> +       if (ret > 0)
> +               ret = 0;
> +       else if (!ret)
> +               ret = -ETIMEDOUT;
> +
> +       disable_irq(state->irq);
> +
> +       return ret;
> +}

...

> +static int scd30_wait_meas_poll(struct scd30_state *state)
> +{
> +       int tries = 5;
> +
> +       while (tries--) {
> +               int ret;
> +               u16 val;
> +
> +               ret = scd30_command(state, CMD_MEAS_READY, 0, (char *)&val,
> +                                   sizeof(val));
> +               if (ret)
> +                       return -EIO;
> +
> +               /* new measurement available */
> +               if (val)
> +                       break;
> +
> +               msleep_interruptible(state->meas_interval * 250);
> +       }
> +
> +       if (tries == -1)
> +               return -ETIMEDOUT;

unsigned int tries = ...;

do {
 ...
} while (--tries);
if (!tries)
  return ...;

looks better and I guess less code in asm.

> +       return 0;
> +}

...

> +       if (kstrtou16(buf, 0, &val))
> +               return -EINVAL;

Shadowed error code. Don't do like this.

> +       if (kstrtou16(buf, 0, &val))
> +               return -EINVAL;

Ditto.

> +       if (kstrtou16(buf, 0, &val))
> +               return -EINVAL;

Ditto.

> +       val = !!val;

kstrtobool()?

...

> +       if (kstrtou16(buf, 0, &val))
> +               return -EINVAL;

No shadowed error code, please. Check entire code.

> +static IIO_DEVICE_ATTR_RW(pressure_comp, 0);
> +static IIO_DEVICE_ATTR_RO(pressure_comp_available, 0);
> +static IIO_DEVICE_ATTR_RW(meas_interval, 0);
> +static IIO_DEVICE_ATTR_RO(meas_interval_available, 0);
> +static IIO_DEVICE_ATTR_RW(asc, 0);
> +static IIO_DEVICE_ATTR_RW(frc, 0);
> +static IIO_DEVICE_ATTR_RO(frc_available, 0);
> +static IIO_DEVICE_ATTR_RW(temp_offset, 0);
> +static IIO_CONST_ATTR(temp_offset_available, "[0 1 65535]");
> +static IIO_DEVICE_ATTR_WO(reset, 0);

Do you need all of them? Doesn't  IIO core provides a tons of helpers for these?
Btw, where is ABI documentation? It's a show stopper.

-- 
With Best Regards,
Andy Shevchenko
