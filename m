Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4E3E8A9C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbhHKG4P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 02:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhHKG4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 02:56:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A173C061765;
        Tue, 10 Aug 2021 23:55:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l11so1426896plk.6;
        Tue, 10 Aug 2021 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7AlmSMJFL9CZuv4ZMDoQncOvo4wdtjIioroW75mJOc=;
        b=IQPToxVxxPwFf04sG4MbkPdQictI0Cle9yl8szD8Ubgeyp4bgM4POoC/Qx8+zZ4HqY
         m6BiNILgqr1cvCMKqwCMQTq5p98ZLk9AG8xVuTIGmvw3kouKusxYuScR2rIu2m3I/U7v
         ZRCNU+oQX/4iGk7mjM1x+PLK+lb5rLRRYcNukMIAY7UV8Gvt1gvkJtHB3VcTTxruGBU/
         v74I9zRA8fVwKJBPl10ldFijrvJHVyrADxx+Bzf9H8hSa2oAYYk5JdjwkhOMpOliPgXI
         VH3W+zIU9j2/sdaKMARsd42aGIlgqDiz0v4HRYMg1z3u9t8EHhKMALdOW2CH01IaTAbI
         3SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7AlmSMJFL9CZuv4ZMDoQncOvo4wdtjIioroW75mJOc=;
        b=fi19RxVnVRHlNr8axmRl/06oiXoafX8wjdFC+aIJROVfk45Te7nYr2m5YDmFzPH7wm
         1m77oWXTsQVzFZvTZThP8XoNQiUm+MBo7laat/yc3uCCBSP+oU3W5IQXNE7B/tXOF0C2
         FAPXeow47k6aoWYtxw7u+22FzapItf02uHcMjW97gCS/SPYnlmlmL4nMZdY6FZEt9XST
         ZKkiZhPf0fAsVsBr/yLgFwOpRJFdbrJEJMElHfUcnPdg0cw7Cv04sXCU3usrtemy32UL
         4cj8hR1r0m3orZdDyQGZ2hHlZbvzTkSJg9DamRfY4hH1zaUQL4wrOY5k8agtG2wSoNKr
         szhA==
X-Gm-Message-State: AOAM533NIeMvv8gGGGWF4ZWMDOltdhWUJXnfz6V2KT2+NfpDPsmCZoch
        cbXL12tqfX4mZpfvZzeSdGFcV+Epyj0elnt0Dh0=
X-Google-Smtp-Source: ABdhPJzZ9bgzm0TFKO1+EAzhIrRVjpHkxePfCFeP4/jJkQvodZXLUkb4vJXTxaSqjwGshqdpo/Z7LhSp/A5Tv2ot82A=
X-Received: by 2002:a17:90a:cf18:: with SMTP id h24mr18886728pju.228.1628664951538;
 Tue, 10 Aug 2021 23:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210811051938.111191-1-puranjay12@gmail.com> <20210811051938.111191-3-puranjay12@gmail.com>
In-Reply-To: <20210811051938.111191-3-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Aug 2021 09:55:14 +0300
Message-ID: <CAHp75VeWSwk7g+HUQ21cRKFDBdHKv4M4mTjv6Ng5DnZz-ugj2Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] iio: accel: Add driver support for ADXL355
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 11, 2021 at 8:19 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
> low 0g offset drift, low power with selectable measurement ranges.
> It also features programmable high-pass and low-pass filters.

Thanks for an update! My comments below.
After addressing, feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> +#ifndef _ADXL355_H_
> +#define _ADXL355_H_
> +
> +#include <linux/regmap.h>

What I meant here is you need to add a forward declaration, i.e.

struct device;

line.

> +extern const struct regmap_access_table adxl355_readable_regs_tbl;
> +extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> +
> +int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> +                      const char *name);
> +
> +#endif /* _ADXL355_H_ */

...

> +#define MEGA(x) ((x) * 1000000)
> +#define TERA(x) ((x) * 1000000000000UL)

What I meant is to define just constants. It will be easier to move
this to a global space (I have a patch, btw, but it may be applied
later). So, just

#define MEGA  1000000UL
#define TERA 1000000000000UUL

And note that the second one should have a ULL suffix.

...

> +       ret = regmap_bulk_write(data->regmap,
> +                               adxl355_chans[chan].offset_reg,
> +                               data->transf_buf, 2);

ARRAY_SIZE() ?

> +       if (ret)
> +               goto set_opmode_unlock;

-- 
With Best Regards,
Andy Shevchenko
