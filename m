Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E833E5A10
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbhHJMhR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbhHJMhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 08:37:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2DC0613D3;
        Tue, 10 Aug 2021 05:36:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so5086801pjb.3;
        Tue, 10 Aug 2021 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C+S1OeBaTHdPvRI8Q3o0BpEm1qixIpiZeGXCGP5NrEs=;
        b=cmIsnA6grRZsy2+jYkXmECMNvEFYuTvxA1TdCx5KNZuHzu5oe7Ex8J26LiLhKkBGRb
         hCvVr/Nse4AScgrzGSyvu8VI/pxosjicKEIMp1lJZBSeUZ7kBFlv5qL4rZyoLrSMtPfK
         8tbkD2ItrQUGqQAOHBN6jAhl9Hv9Lyzk9T20rQcBAwF7IVANqcx3McRyOhB3A1Mu3s4a
         tl0N5bmhmTqiM1LYaHuO2Piu/96HvFIHKjHW+DPq02JtY4veIpjRj+kkvRvnNSulIFVZ
         /P3WsZFRd+zGgftae3/uqr6d6ck26P76JCpZwhJs5xuFrOsfjSnu/0s0AaEDn3HL1b3k
         Fikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C+S1OeBaTHdPvRI8Q3o0BpEm1qixIpiZeGXCGP5NrEs=;
        b=VF7ciIMXqgRUXiHwoRmWWzxGACqRC942QyvdzJrS+rDsewarxhlJ1/Xalush8tvUvh
         4iTQ78sVtSbsJhbD1DW0k5Sz/d7XPTbG83XfekMImB9q0k2zhYH/Jv1CTOVtn9JeqpVV
         Zl8Qa2pwdghT28X664UJSRIbbZYKfAWKkNy8TFXwaq5ZCbYlsPxXHRksVsNompW6nr9Q
         Gz0t/+sqYF9YvCHN9IhmNmnJLiUhvbZefiAEPOfJYOe+zaEHfCeBKjuvnOPspFyMCi9V
         1ng+MkSZRCFWvHdyeQWjx3VeshhSXWFn4ZBxrhtyic66Pk177xrO8zyZa1y9TN2lFhuM
         ARMA==
X-Gm-Message-State: AOAM5317MJZ+3ZdmnT9fw9w43h/I3D2I88OG8jL1gQmXWSDzqM1Ojewb
        HcoJVRee72dBuB6lPAcbv5UOYPjDc1PT+Zq25mY=
X-Google-Smtp-Source: ABdhPJxXDfhMaPSYP96hFVMEUA1XjrrlqGrOdizfjCzgztRUIfsWPwc6Q0RWsecXCjxJEpWzwqPN7wY6Dkhvk7LmQo4=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr28753021pfi.7.1628599012364; Tue, 10
 Aug 2021 05:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210809074512.34757-1-puranjay12@gmail.com> <20210809074512.34757-2-puranjay12@gmail.com>
In-Reply-To: <20210809074512.34757-2-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 15:36:15 +0300
Message-ID: <CAHp75VebXai6phWVhBxTPjMz1jBZOZpVBpTEYRr9DiD0oPDfPg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] iio: accel: Add driver support for ADXL355
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 9, 2021 at 10:46 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> ADXL355 is 3-axis MEMS Accelerometer. It offers low noise density,

is a 3-axis

> low 0g offset drift, low power with selectable measurement ranges.
> It also features programmable high-pass and low-pass filters.

...

> +F:     drivers/iio/accel/adxl355.h
> +F:     drivers/iio/accel/adxl355_core.c
> +F:     drivers/iio/accel/adxl355_i2c.c
> +F:     drivers/iio/accel/adxl355_spi.c
> +F:     Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

Have you run checkpatch?

...

> +#ifndef _ADXL355_H_
> +#define _ADXL355_H_
> +
> +#include <linux/regmap.h>

Missed declaration for struct device.

> +extern const struct regmap_access_table adxl355_readable_regs_tbl;
> +

I think you may drop this blank line.

> +extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> +
> +int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> +                      const char *name);

+ blank line?

> +#endif /* _ADXL355_H_ */

...

> +#include <asm/unaligned.h>

asm/* is less generic, can you move it after linux/*?

> +#include <linux/bitfield.h>

Does this imply bits.h? If not, add the latter.

> +#include <linux/iio/iio.h>
> +#include <linux/limits.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>

...

> +static const struct regmap_range adxl355_read_reg_range[] = {
> +       regmap_reg_range(ADXL355_DEVID_AD_REG, ADXL355_FIFO_DATA_REG),
> +       regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_SELF_TEST_REG)

Leave commas in non-terminator lines.

> +};

...

> +static const struct regmap_range adxl355_write_reg_range[] = {
> +       regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_RESET_REG)

Ditto.

> +};

...

> +enum adxl355_op_mode {

> +       ADXL355_TEMP_OFF

Ditto.

> +};
> +
> +enum adxl355_odr {

> +       ADXL355_ODR_3_906HZ

Ditto.

> +};
> +
> +enum adxl355_hpf_3db {

> +       ADXL355_HPF_0_0238

Ditto.

> +};
> +
> +static const int adxl355_odr_table[][2] = {

> +       [10] = {3, 906000}

Ditto.

> +};
> +
> +static const int adxl355_hpf_3db_multipliers[] = {

> +       238

Ditto.

> +};
> +
> +enum adxl355_chans {
> +       chan_x, chan_y, chan_z

Ditto.

> +};

> +static const struct adxl355_chan_info adxl355_chans[] = {

> +       [chan_z] = {
> +               .data_reg = ADXL355_ZDATA3_REG,
> +               .offset_reg = ADXL355_OFFSET_Z_H_REG
> +       }

Ditto.

> +};

To avoid adding extra entries, consider using static_assert():s.

...

> +static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
> +{
> +       int i;
> +       u64 rem;
> +       u64 div;
> +       u32 multiplier;

Reversed xmas tree order?

> +       u64 odr = mul_u64_u32_shr(adxl355_odr_table[data->odr][0], 1000000, 0) +
> +                                 adxl355_odr_table[data->odr][1];

Split definition and assignment.

> +       for (i = 0; i < ARRAY_SIZE(adxl355_hpf_3db_multipliers); i++) {
> +               multiplier = adxl355_hpf_3db_multipliers[i];
> +               div = div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0),
> +                                   100000000000000UL, &rem);
> +
> +               data->adxl355_hpf_3db_table[i][0] = div;
> +               data->adxl355_hpf_3db_table[i][1] = div_u64(rem, 100000000);
> +       }

Do all those power-of-ten constants have a meaning? Shouldn't it be
better to use named definitions?

> +}

...

> +       /*
> +        * Perform a software reset to make sure the device is in a consistent
> +        * state after start up.

start-up

> +        */

...

> +       ret = regmap_bulk_read(data->regmap, addr, data->transf_buf, 3);

ARRAY_SIZE() ?

> +       if (ret < 0)
> +               return ret;

...

> +               /*
> +                * The datasheet defines an intercept of 1885 LSB at 25 degC
> +                * and a slope of -9.05 LSB/C. The following formula can be used
> +                * to find the temperature:
> +                * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
> +                * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
> +                * Hence using some rearranging we get the scale as -110.497238
> +                * and offset as -2111.25

Missed period.

> +                */

...

> +               /*
> +                * At +/- 2g with 20-bit resolution, scale is given in datasheet
> +                * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2

Ditto for all multi-line comments.

> +                */

...

> +static const struct regmap_config adxl355_i2c_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = 0x2F,
> +       .rd_table = &adxl355_readable_regs_tbl,
> +       .wr_table = &adxl355_writeable_regs_tbl

+ comma

> +};

...

> +       regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> +                       PTR_ERR(regmap));

One line?

> +               return PTR_ERR(regmap);
> +       }

...

> +static const struct i2c_device_id adxl355_i2c_id[] = {
> +       { "adxl355", 0 },
> +       { }
> +};

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
> +
> +static const struct of_device_id adxl355_of_match[] = {
> +       { .compatible = "adi,adxl355" },
> +       { }
> +};

> +

Ditto.

> +MODULE_DEVICE_TABLE(of, adxl355_of_match);
> +
> +static struct i2c_driver adxl355_i2c_driver = {
> +       .driver = {
> +               .name   = "adxl355_i2c",
> +               .of_match_table = adxl355_of_match,
> +       },
> +       .probe_new      = adxl355_i2c_probe,
> +       .id_table       = adxl355_i2c_id,
> +};

> +

Ditto.

> +module_i2c_driver(adxl355_i2c_driver);

For SPI part the very same bunch of comments.

-- 
With Best Regards,
Andy Shevchenko
