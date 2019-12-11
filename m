Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AD611ABF9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 14:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfLKNWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 08:22:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41326 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbfLKNWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 08:22:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id bd4so1422577plb.8;
        Wed, 11 Dec 2019 05:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL3VegZeG6jSDZ1lQ26BJg9kkfIICZ20YiNfjrSGi9I=;
        b=WYtttMhYD3mso0o2sHaeizx0l2vT34aK1v7JOPL/YmqWSgy6FDqkP4/s39v4rdZBIO
         +DCIhh1L+9GAMtrZ83NQvwXttHyABVJckxAe1HWTHuI2U7+WhM3a/J+cq+zQxZmc8Vzh
         nCVc333eRYkkHYrkCW/709kjB4eR9SNCQxBmn9vfTxeMKsBetUzruJqIkg2mErv9Y46y
         qFyy9i0RaBL7+kC7smxX3l8ZlNC3foUZbUtEAG9Tb2ZnxUvLCtyZp5DgWeqsr4bePPpW
         R5jEy9DAO10joTuB3niFo1VcZzxqCLkRm0mI3+eWlZsS2QfG5tSmovAhFYNQeH1EFZcx
         Vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL3VegZeG6jSDZ1lQ26BJg9kkfIICZ20YiNfjrSGi9I=;
        b=ifCBg8mqyt8l7H2H6uBaZgAPqRxAjE3xKcq3CbcojIT78L7UHKeMxrzWTyc9t8H1Dk
         SfH/0lOl0sTyTRxqvMsdvtoph2JEzeXtv8w5M8W8/htpSRc6IRLI5LBh8kcP82WM93XN
         OJZvo5VnWOjaoU1kABLEq3adOpvQjNFgS7WlNT8sQ8E9fbVsTWs4kvGDO1RRXRqZUT4e
         ij61Fus6wVZBIVhRyL2PLsZZOQDJMx6nre0o92WHyqLo6dpLlXPcz3ULS5v6GJg/T4gs
         nEe91fWjFvmjYtwRCYhUoKZ4kjDD9xFiTP8JviCptbVLJEdixDNdleSAzU/jogQKzu+P
         fCgQ==
X-Gm-Message-State: APjAAAWLK5/tydDOvZ9L9cV/JqYleCB69zvEIQ/drHPflNCc7eKOMdz7
        Dc6tOdUpwobb5FWRKK3Kcno8MWACr2Q1OfU6bOVBnCcNsGc=
X-Google-Smtp-Source: APXvYqwC8BI6qwyH+dGs9Gu3TdTluWXkwRuBt4B2QdBTOVLqQE4/BDTxe1J81h7lkPFcSLFykPDw6CZEDBM0j61z8rA=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr3591149pjq.132.1576070526864;
 Wed, 11 Dec 2019 05:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20191211010308.1525-1-dan@dlrobertson.com> <20191211010308.1525-3-dan@dlrobertson.com>
In-Reply-To: <20191211010308.1525-3-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Dec 2019 15:21:56 +0200
Message-ID: <CAHp75VdAJwMkPZQLLQrOk4HABjG-parEOmH8S-6kU+zyYnnfww@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 11, 2019 at 3:20 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.

> +#define BMA400_LP_OSR_SHIFT         0x05
> +#define BMA400_NP_OSR_SHIFT         0x04
> +#define BMA400_SCALE_SHIFT          0x06

I'm not sure why this is being defined as hex number instead of plain decimal...

> +#define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
> +#define BMA400_LP_OSR_MASK          GENMASK(6, BMA400_LP_OSR_SHIFT)
> +#define BMA400_NP_OSR_MASK          GENMASK(5, BMA400_NP_OSR_SHIFT)
> +#define BMA400_ACC_ODR_MASK         GENMASK(3, 0)
> +#define BMA400_ACC_SCALE_MASK       GENMASK(7, BMA400_SCALE_SHIFT)

And here simple better to put same numbers. It will help to read.

...

> +extern const struct regmap_config bma400_regmap_config;

> +const struct regmap_config bma400_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = BMA400_CMD_REG,
> +       .cache_type = REGCACHE_RBTREE,
> +       .writeable_reg = bma400_is_writable_reg,
> +       .volatile_reg = bma400_is_volatile_reg,
> +};
> +EXPORT_SYMBOL(bma400_regmap_config);

I'm not sure I got the idea why this one is being exported.

...

> +               if (odr < BMA400_ACC_ODR_MIN_RAW ||
> +                   odr > BMA400_ACC_ODR_MAX_RAW) {

One line?

> +                       ret = -EINVAL;
> +                       goto error;
> +               }

...

> +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> +                       return -EINVAL;
> +
> +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;
> +               idx = __ffs(val);
> +

> +               if (val ^ BIT(idx))

Seems like funny way of checking is_power_of_2(). But it's up to maintainers.
And your variant may even be better here (in code generation perspective)...

However, the whole idea here is, IIUC, to have something like

  hz = 2^idx * BMA400_ACC_ODR_MIN_WHOLE_HZ

I think you may do it without divisions, i.e. call __ffs() first and then do
   idx = __ffs(...);
   val = hz >> idx;
   if (val != BMA400_ACC_ODR_MIN_WHOLE_HZ)
    return -EINVAL;

or something like above.

> +                       return -EINVAL;

...

> +       odr = (~BMA400_ACC_ODR_MASK & val) | idx;

I'm wondering why Yoda style is being used here.

...

> +static void bma400_accel_scale_from_raw(int raw, unsigned int *val)
> +{
> +       *val = BMA400_SCALE_MIN * (1 << raw);

Isn't it the same as
    *val = BMA400_SCALE_MIN << raw;
?

> +}

...

> +       if (val % BMA400_SCALE_MIN || scale ^ BIT(raw))

Similar comment as above about divisions, is_power_of_2(), etc.

> +               return -EINVAL;

...

> +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
> +       if (ret < 0)

I'm wondering if in all of these regmap_read()...

> +               return ret;

> +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> +                          mode | (val & ~BMA400_TWO_BITS_MASK));
> +       if (ret < 0) {

...and regmap_write() calls you ever can get a positive returned code.

> +               dev_err(data->dev, "Failed to write to power-mode\n");
> +               return ret;
> +       }

...

> +       regmap = devm_regmap_init_i2c(client, &bma400_regmap_config);

> +

Redundant blank line.

> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "failed to create regmap\n");
> +               return PTR_ERR(regmap);
> +       }

-- 
With Best Regards,
Andy Shevchenko
