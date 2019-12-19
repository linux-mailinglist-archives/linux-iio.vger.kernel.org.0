Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A2E126061
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLSLCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 06:02:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36994 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLSLCi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 06:02:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so2360246pjb.2;
        Thu, 19 Dec 2019 03:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+r1HKCBriFzIoCX8L5uyYociaU+Sa1uGxae7TY0vSs=;
        b=cfkeeELXTz7NjDjxtICyJ0BLK0YJLg+sxrMl9yJklc26hsc7dYlv3icbSsPy4Q+UQX
         NSli7tEK1jcAVg3uuG281j8Eep439Go8DxsAhIPwr1F1eI7+5PsoLqOf4BT4dLlD8iXR
         fFW2xvxBMIeNLVj6YMYufCUPgtNP3+lqIcostBYzT0vD3sLlDDd5NJG6Iszm/YM4BCtV
         HSJqbQPg6iOpq4jiJHvG3GTvOQKGlBzz4W8aTaGW32bGjS1LrySk4Oukp2sqzOpt7gTO
         yTUjIk7xV0VwCct5MtNZ+BlMjBJpkNYEcjXnUk7C+YyV3Sp4dEuMbG6tdYJIZB754PFl
         Obdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+r1HKCBriFzIoCX8L5uyYociaU+Sa1uGxae7TY0vSs=;
        b=qND02OEV8paEEXwNDHiioDFri67CdAuzFN+5xvSOjYou6D0egwomyjqA7AK8h8WwZs
         ihT0lTky5EF/BBAb8I2flqI3T1OXeJ/fLNoXs6SQSXZKLY24UbyDTlCWXuYlzRYPvoTT
         TjFEsdGsyMZ7cvk7qUDBCKzqip3K2+a/P9G/mkamoDW7isSeVGTunE7NnFGN7Szrat40
         +KdWQamPqkhCD2ckkkrWA7tyHYiAHUXHyYkIA/q6/FAkleuO+oMlEdvLOTec26FdMbDu
         fpsHgL/WBnYJZTxTgOh7O2Iuw1NSRhl5+P846QsX2+7xRHmDJFpuHVEoop1/rxf/MoZa
         3qTg==
X-Gm-Message-State: APjAAAXQfeeVdiFrhJZKqGjXvWW/FHpyuF8AQCJ8F4hNWsL4f9YjGqS/
        bBOsoi4XJR0QCFOf9F+LPtcvlk1lcXqcQKuX0SUsEDMo
X-Google-Smtp-Source: APXvYqwi37AaaH078CJ7lzNLxijRKJG1bQPJW/R2wE2MhZ/5nYbsXgrzlDrnrokA5SzRdncSVZ1pv8tigLwtPe9Xw9A=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr8660446plk.18.1576753357972;
 Thu, 19 Dec 2019 03:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-3-dan@dlrobertson.com>
In-Reply-To: <20191219041039.23396-3-dan@dlrobertson.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Dec 2019 13:02:28 +0200
Message-ID: <CAHp75VdVmfAi5hSp23Gn8nm6LmX-Mr5Tnxcbus90DrRL+gVFRA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
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
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 19, 2019 at 6:27 AM Dan Robertson <dan@dlrobertson.com> wrote:
> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.

...

> +static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> +                                            int hz, int uhz)
> +{
> +       unsigned int idx;
> +       unsigned int odr;
> +       unsigned int val;
> +       int ret;
> +
> +       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> +               if (uhz || hz % BMA400_ACC_ODR_MIN_WHOLE_HZ)
> +                       return -EINVAL;
> +
> +               val = hz / BMA400_ACC_ODR_MIN_WHOLE_HZ;

Again, AFAICS division may be avoided in both cases (% and / above)
because of is_power_of_2() check below.
Can you revisit this?

> +               if (!is_power_of_2(val))
> +                       return -EINVAL;
> +
> +               idx = __ffs(val) + BMA400_ACC_ODR_MIN_RAW + 1;
> +       } else if (hz == BMA400_ACC_ODR_MIN_HZ && uhz == 500000) {
> +               idx = BMA400_ACC_ODR_MIN_RAW;
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
> +       if (ret)
> +               return ret;
> +
> +       /* preserve the range and normal mode osr */

> +       odr = idx | (~BMA400_ACC_ODR_MASK & val);

Yoda style?

> +
> +       ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG, odr);
> +       if (ret)
> +               return ret;
> +
> +       bma400_output_data_rate_from_raw(idx, &data->sample_freq.hz,
> +                                        &data->sample_freq.uhz);
> +       return 0;
> +}
...

> +int bma400_accel_scale_to_raw(struct bma400_data *data, unsigned int val)
> +{
> +       int scale = val / BMA400_SCALE_MIN;
> +       int raw;
> +
> +       if (scale == 0)
> +               return -EINVAL;
> +
> +       raw = __ffs(scale);
> +
> +       if (val % BMA400_SCALE_MIN || !is_power_of_2(scale))
> +               return -EINVAL;

Ditto.

> +
> +       return raw;
> +}

...

> +out:

Make a little sense. Why not return directly?

> +       return ret;

...

> +       ret = bma400_init(data);
> +       if (ret < 0)

May it be positive value returned?

> +               return ret;

...

> +static int bma400_i2c_probe(struct i2c_client *client,
> +                           const struct i2c_device_id *id)
> +{
> +       struct regmap *regmap;
> +
> +       regmap = devm_regmap_init_i2c(client, &bma400_regmap_config);

> +

Redundant blank line.

> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "failed to create regmap\n");
> +               return PTR_ERR(regmap);
> +       }
> +
> +       return bma400_probe(&client->dev, regmap, id->name);
> +}

-- 
With Best Regards,
Andy Shevchenko
