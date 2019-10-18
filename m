Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B7DBE43
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393770AbfJRHXw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Oct 2019 03:23:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46893 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfJRHXv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 03:23:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so2401153plr.13;
        Fri, 18 Oct 2019 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oURX1jatq95p/LOVREIyzuENJitA0cliieG2C4uLfJ0=;
        b=SgFKgnTV4m6E5YvLcdWAZ0nwZVCZH17M7wZ8RNdeW8360T4VhoLbxI6YV2uJez2m0c
         kEjdvSkbbtMAdz0USdqoDoSkLi1V1A73wuh1eeVJU2r5aX7HoZn6zuvKvdOPJVeuiPDu
         t/cafyuoc/5xX//WWg4Mrd9zrUU3gKUIa44FvbTW5i29pa83qPYXIGRzKPhiZzeVCwVw
         1o31zP05NIAtfcsCgQFAyfywnczNbG0WjC+Dp7Zbxufa2ONuzux5lHp4/Scysk4X51h4
         z+j3owVojlR03UdJBlViTI7WqO99Oq1dYHukmEL2hgvV0UFuFdz3bzNsEcp2WKwz9eSr
         1j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oURX1jatq95p/LOVREIyzuENJitA0cliieG2C4uLfJ0=;
        b=jliyeoFlH7+ZNCr2K/u2gA8uiDlxOIkAdfzIjnXNO1d/nb/6jQcptxEfx+le2eKqvY
         /lzNj83ifMB2YW6VYEJYk79O3Cyr4d5dqWdXoqkW9nkhMzfuky1PpZQUp95hy7AX51Cw
         5EnA6SykdyKYc5hdXjMUyl49JPqzSrISjWKPCxU3Wi4up0jFm1Fl/ouSBsHVuGO4XNbW
         Axupkot2sqozYjmSA9eShrvoa5HyqKUWGpxuI1MZhQKdpl/kkrsV7QyeR6G/zmLDuYBo
         ITpiPUsPhAUYGyG6yn7Y4LLwy3TBYQfY+lKDe7wKRJxnUHX+s5jefpO55Q+PhyM0DAsl
         oQEw==
X-Gm-Message-State: APjAAAWhJ/cMmN+aWfl7jNvo9qxNi02QaWt91UuToyTubp08yyAnEXL/
        mvk/LTPxrLylP/7T/QvU6Jtw7A/d0+tJcTKm3vE=
X-Google-Smtp-Source: APXvYqzyjiVfSAkK/kZ9HBuHbW+swauFuUO99rgqSZMr6aHybtgffwSHIamiL0dBLu6xKNB3EmXSc+7cNtLexyqleew=
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr8275237plr.262.1571383429214;
 Fri, 18 Oct 2019 00:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191018031848.18538-1-dan@dlrobertson.com> <20191018031848.18538-3-dan@dlrobertson.com>
In-Reply-To: <20191018031848.18538-3-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 10:23:38 +0300
Message-ID: <CAHp75VfMW0fvmO9jGTnQumJ9Sm-SgNL0ohjSR4qRQY365aeMBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 18, 2019 at 6:44 AM Dan Robertson <dan@dlrobertson.com> wrote:
>
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.

Thanks for an update, my comments below.


> @@ -0,0 +1,85 @@

> + * bma400.h - Register constants and other forward declarations
> + *            needed by the bma400 sources.

Including file name in the file is not the best practice. Imagine if
by some reason we will need to rename it (to support more sensors, for
example, and reflect it by replacing 00 -> 0x).
So, please, remove here and everywhere else.

> + *
> + * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
> + */

> +#define BMA400_TWO_BITS_MASK    0x03
> +#define BMA400_LP_OSR_MASK      0x60
> +#define BMA400_NP_OSR_MASK      0x30
> +#define BMA400_ACC_ODR_MASK     0x0f
> +#define BMA400_ACC_SCALE_MASK   0xc0

GENMASK()
(Don't forget to include bits.h for it)

> +extern const struct regmap_config bma400_regmap_config;

I'm not sure, why you need this exposed.

> + * bma400_core.c - Core IIO driver for Bosch BMA400 triaxial acceleration
> + *                 sensor. Used by bma400-i2c.

No name.

> +/*
> + * The G-range selection may be one of 2g, 4g, 8, or 16g. The scale may
> + * be selected with the acc_range bits of the ACC_CONFIG1 register.
> + */
> +static const int bma400_scale_table[] = {
> +       0, 38344,
> +       0, 76590,
> +       0, 153277,

> +       0, 306457

Better to leave comma here. It doesn't matter for this device, but
make of use the better practices.

> +};

Also, I'm wondering why values are not exactly multiply by 2. Is in DS
of the chip any explanation for this?

> +static const int bma400_osr_table[] = { 0, 1, 3 };

> +/* See the ACC_CONFIG1 section of the datasheet */
> +static const int bma400_sample_freqs[] = {
> +       12,  500000,
> +       25,  0,
> +       50,  0,
> +       100, 0,
> +       200, 0,
> +       400, 0,
> +       800, 0,
> +};

This can be replaced by a formula(s).

> +struct bma400_sample_freq {
> +       int hz;
> +       int uhz;
> +};

I'm wondering why above table is not using this struct.

> +const struct regmap_config bma400_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = BMA400_CMD_REG,
> +       .cache_type = REGCACHE_RBTREE,
> +       .writeable_reg = bma400_is_writable_reg,
> +       .volatile_reg = bma400_is_volatile_reg,
> +};

> +EXPORT_SYMBOL(bma400_regmap_config);

Why? And why it's not _GPL?

> +       int ret;
> +       int host_temp;
> +       unsigned int raw_temp;

Better reversed xmas tree order.

> +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &raw_temp);

> +

Redundant blank line..

> +       if (ret < 0)
> +               return ret;

> +               odr = (val & BMA400_ACC_ODR_MASK);

Too many parentheses.

> +               idx = (odr - BMA400_ACC_ODR_MIN) * 2;

> +

Redundant.

> +               if (idx + 1 >= ARRAY_SIZE(bma400_sample_freqs)) {

Why do you need this churn with +1 and = ?

> +                       dev_err(data->dev, "sample freq index is too high");
> +                       ret = -EINVAL;
> +                       goto error;
> +               }


> +       for (i = 0; i + 1 < ARRAY_SIZE(bma400_sample_freqs); i += 2) {

Using defined struct will guarantee you to have always 2x members in
the array. So, drop this arithmetic churn.

> +       if (i + 1 >= ARRAY_SIZE(bma400_sample_freqs))

As a bit above.

> +               return -EINVAL;

> +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);

> +

Redundant.

> +       if (ret < 0)
> +               return ret;

> +       idx = (((val & BMA400_ACC_SCALE_MASK) >> BMA400_SCALE_SHIFT) * 2) + 1;

Too many parentheses.

> +       if (idx >= ARRAY_SIZE(bma400_scale_table))
> +               return -EINVAL;

Why + 1 above and =  here?
You may do + 1 below.

> +       data->scale = bma400_scale_table[idx];


> +       idx = bma400_get_accel_scale_idx(data, val);

> +

Redundant

> +       if (idx < 0)
> +               return idx;


> +       /* Preserve the low-power oversample ratio etc */
> +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
> +                          mode | (val & ~BMA400_TWO_BITS_MASK));

> +

Redundant

> +       if (ret < 0) {
> +               dev_err(data->dev, "Failed to write to power-mode");
> +               return ret;
> +       }

> +static int bma400_init(struct bma400_data *data)
> +{
> +       int ret;
> +       unsigned int val;
> +
> +       /* Try to read chip_id register. It must return 0x90. */
> +       ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
> +
> +       if (ret < 0) {
> +               dev_err(data->dev, "Failed to read chip id register: %x!", ret);

%x for returned error code is too hackerish.

> +               return ret;

> +       } else if (val != BMA400_ID_REG_VAL) {

Redundant 'else'

> +               dev_err(data->dev, "CHIP ID MISMATCH: %x!", ret);

Hacker detected!

> +               return -ENODEV;
> +       }

> +               /*
> +                * TODO: The datasheet waits 1500us here in the example, but
> +                * lists 2/ODR as the wakeup time.
> +                */
> +               usleep_range(1500, 20000);

These range values are too sparse. Usually the second one is less than
first one * 2.
Fix it now.

> +EXPORT_SYMBOL(bma400_probe);

Why is not GPL?

> +EXPORT_SYMBOL(bma400_remove);

Ditto.

P.S. I probably missed some places with the same mistake as commented
above. Please address all places in the code where my comments are
applicable.

-- 
With Best Regards,
Andy Shevchenko
