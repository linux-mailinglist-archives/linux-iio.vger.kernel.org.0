Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575E036F77A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 11:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhD3JDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhD3JDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 05:03:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF74C06174A;
        Fri, 30 Apr 2021 02:02:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m11so4858779pfc.11;
        Fri, 30 Apr 2021 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfGbSMZc7bvjVY6nx1HPF1pRepvP5IrlXq3RZS+72MY=;
        b=pz8Tc/MBWdz5VC1p7aLi42FHnVMNJs3NPJ2adbMjhFR2Zzs/aTW1U4L1dfZWNqyJYK
         MKO7iMs57DpAilXlC4ywIVRs9yA9CGIff6s/jvY/L9swib7pYvOxlsCkgEYBYWXgFBxR
         zktT/pk5pQXucYSR5DfLOp4o7guK6T8p+kAdI7AVLfshQEbe2DiloOYFWeF2aoBaEn0U
         4eeAVzxCHUmgF4pByfxpc+/LQPG6vBE3e6KH2fzUG28kX1NWRCXjppFZu5DxqfIEIKP+
         ooB49gkVdVvSAidHKXX8kQJ/CTTG18Ug5s1QRVqraOGtKWurhecXnSWXVo9wWMJTBEhI
         BGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfGbSMZc7bvjVY6nx1HPF1pRepvP5IrlXq3RZS+72MY=;
        b=CdwVhx5YTpxvWG4sSjWKY8KdOWjvkU01xnAZQMmZuL48+016qdYOD/oR0tj+9sKN0U
         Zl1u7Sd38TZU5Wr6ONbo/V/c9+gVrwz2fGnnE6WRbqeT6gUaZGKMWkfEjiwdLKBeIeeO
         evsCriLgfg1isSjgQdGjldW/yopvJHwBIHK21mIk4X2sz+EDWlVkqkXHgAPQ9zGvCbCm
         JtshJEaYvuO3s0z2am45BMctf8WK52JZ7vZCSHhxyWsS1VUvmb0QbbODUHAIZRd6g+/O
         /4S+quOMg/9+HqyzkrmD7xnB7CFwDZttm/XMP7rGf60ATAMky2F+N3hsNlFhOP5E5Qeh
         dW/Q==
X-Gm-Message-State: AOAM533CgbwgX2yvFchD79D3FXQBs/FtH3D6NrDkv0fkC3D2jRF8uWFf
        cCVoUL4hp4JfQxJAEfHZ2tUhDEMGfhXrsJUqV7U=
X-Google-Smtp-Source: ABdhPJz72seNM8qiGKE4ZlJrRuJfr9QGEGlAlFoa0eNUUgXz/SZALqMGcniYzRfjPFox5XdFo3teVG2gNVcyunQjHVs=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr3766067pgs.4.1619773372827;
 Fri, 30 Apr 2021 02:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210429122806.3814330-1-sean@geanix.com> <20210429122806.3814330-4-sean@geanix.com>
In-Reply-To: <20210429122806.3814330-4-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 12:02:36 +0300
Message-ID: <CAHp75Vf7-5EOpsP8u4rfcjceoKFwQH+U90+JazsLJvmARXmEBQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] iio: accel: fxls8962af: add interrupt support
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 29, 2021 at 3:28 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> Preparation commit for the next that adds hw buffered sampling

It misses a better description of what's going on here.
It misses the period at the end of the line.

...

> +#include <linux/of_irq.h>

See below.

...

> +static irqreturn_t fxls8962af_interrupt(int irq, void *p)
> +{
> +       struct iio_dev *indio_dev = p;
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +       unsigned int reg;
> +       int ret;
> +
> +       ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
> +       if (ret < 0)
> +               return IRQ_NONE;
> +
> +       return IRQ_NONE;

And how is it handled?

> +}

...

> +static void fxls8962af_get_irq(struct device *dev, enum fxls8962af_int_pin *pin)
> +{
> +       if (!device_property_match_string(dev, "interrupt-names", "INT2")) {

This doesn't feel right.
You should use fwnode_get_irq() or introduce fwnode_get_irq_by_name().

Since ACPI has no given names for Interrupt resources (and moreover
there are two types of them), it also needs a support from the
software like we have for GPIOs with struct acpi_gpio_table (luckily
it's part of _DSD() nowadays, but in general it's not required by the
spec).

> +               *pin = FXLS8962AF_PIN_INT2;
> +               return;
> +       }
> +
> +       *pin = FXLS8962AF_PIN_INT1;
> +}


-- 
With Best Regards,
Andy Shevchenko
