Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9E234000
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgGaHeV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgGaHeV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 03:34:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE4C061574;
        Fri, 31 Jul 2020 00:34:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so16614320plr.8;
        Fri, 31 Jul 2020 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xb0omRdLCCOfPt+/txYpi30U3/iAQj16OMiIXME8RHE=;
        b=eICLEEfuqsvaqONwxsXU0zTjVt7XwYqtzlEdhkJWOrcd5QWruln7gDnvuaxTwcWNl/
         7R5TSmM1aTljm0DOvpe/wMK7PpbNevNiRQZDmJMJe1Tm9SlKcnhUMQOKbzelrB2kUglb
         AJ6QmNyv3F/07+qeauXqxWZShr1LnfxF6dTD/wB3fOpyiA66NzlJ2h7iS05ii0Fe9SEk
         fMaj7NW3lSJmq2eHNwRAHUsXGXzfgzXF6D8ZX/pxoPrHaHV1b49tCAh8y+c+nJeVMsHi
         wbZpfn8jfwHdaEwrGTmjix2XJXj8Y7uCvQ9qoyqgM9NA/w0XOdN24AveYQm1fx7OZF//
         +UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xb0omRdLCCOfPt+/txYpi30U3/iAQj16OMiIXME8RHE=;
        b=l0AeicTyaEAyM/+nZDfD8hJ4RX+mjnZ/L7fsIl0op1cTX/P5RRI/KUpGWwjLG05CgH
         H3rwOB24V2M/gLJZHN/eQE16/lUt58Yrt8XBiB7DlaAmFocPL+yTtzALt99A50aguzWw
         xIASMx6UH1xzO4eIMFtVyAOguwhebPk+1cd7jOQANvPNi+cl7Q/2V7jm4930NGGTneBm
         e4V4zjwDRtjuos/sfLrKWzOJaR0fP7HRCuR2aYBy3q/ReZUa1dsOwgJ5VtXCC+dnCf8a
         m/urnIAqXMlqKT6QEDBjYehzCVjai1Bzp5xPxAx5UTLzxjmgAUXT6jRKKzpcCR2TqnvA
         X+fQ==
X-Gm-Message-State: AOAM532vPAw1aDSVua4gfN07NYmPb7RtU8CvYWQbwRNLmJZA8tyCFVyp
        3eCwSRws1DMIKJSUsBLuHh4sw9okGbM56thu2yo=
X-Google-Smtp-Source: ABdhPJyZHQKcB2t4Z1ootQs26PfgvB/0wuwI05c4XIXu3y8NhHk95Iu3B+XejQESRdlccgeDi6ARnjBWoWChet6hX/Y=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr2576822pgi.203.1596180860350;
 Fri, 31 Jul 2020 00:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200731070114.40471-1-ceggers@arri.de> <20200731070114.40471-3-ceggers@arri.de>
In-Reply-To: <20200731070114.40471-3-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 10:34:02 +0300
Message-ID: <CAHp75VdDCnQLh0Qts8hsgLBy5TqibOKAYSeFxuV69XLroRBOEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 31, 2020 at 10:03 AM Christian Eggers <ceggers@arri.de> wrote:
>
> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
>
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
>
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.

Thanks for an update. My comments below.

...

> +static const int as73211_samp_freq_avail[] = { 1024000, 2048000, 4096000, 8192000 };

This looks related to the below mentioned 1.024MHz.

Perhaps add a definition above and comment here?

#define AS73211_BASE_FREQ_1024KHZ   1024000

/* Available sample frequencies are power of two multiplier by 1.024MHz */
(Rephrase it better)

> +static const int as73211_hardwaregain_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128,
> +                                                  256, 512, 1024, 2048 };

Indentation. Better is
... foo = {
  bar, baz,
};

And in both cases leave comma at the last value.

...

> +/**
> + * struct as73211_data - Instance data for one AS73211
> + * @client: I2C client.
> + * @osr:    Cached Operational State Register.
> + * @creg1:  Cached Configuration Register 1.
> + * @creg2:  Cached Configuration Register 2.
> + * @creg3:  Cached Configuration Register 3.

> + * @mutex:  Keeps cached registers in synch with the device.

sync

> + * @completion: Completion to wait for interrupt.
> + * @int_time_avail: Available integration times (depend on sampling frequency).
> + */

...

> +/* integration time in units of 1024 clock cycles */
Unify this with below one. Or the other way around, i.o.w. join one of
them into the other.

> +static unsigned int as73211_integration_time_1024cyc(struct as73211_data *data)
> +{
> +       /* integration time in CREG1 is in powers of 2 (x 1024 cycles) */
> +       return BIT(FIELD_GET(AS73211_CREG1_TIME_MASK, data->creg1));
> +}

...

> +static unsigned int as73211_integration_time_us(struct as73211_data *data,
> +                                                unsigned int integration_time_1024cyc)
> +{
> +       /*
> +        * f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz)
> +        * t_cycl is configured in CREG1 in powers of 2 (x 1024 cycles)
> +        * t_int_us = 1 / (f_samp) * t_cycl * US_PER_SEC
> +        *          = 1 / (2^CREG3_CCLK * 1,024,000) * 2^CREG1_CYCLES * 1,024 * US_PER_SEC
> +        *          = 2^(-CREG3_CCLK) * 2^CREG1_CYCLES * 1,000

> +        *            in order to get rid of negative exponents, we extend the
> +        *            "fraction" by 2^3 (3 == CREG3_CCLK,max)

In the parentheses swap left and right parts for better reading.

Perhaps shift left to have formulas separated from text visually.

> +        *          = 2^(3-CREG3_CCLK) * 2^CREG1_CYCLES * 125

Okay, 125 = 1000/2^3.

> +        */
> +       return BIT(3 - FIELD_GET(AS73211_CREG3_CCLK_MASK, data->creg3)) *
> +               integration_time_1024cyc * 125;
> +}

...

> +               data->int_time_avail[i * 2] = time_us / USEC_PER_SEC;

I would do + 0, but it's up to you (complete style preference).

> +               data->int_time_avail[i * 2 + 1] = time_us % USEC_PER_SEC;

...

> +       unsigned int time_us = as73211_integration_time_us(data,
> +                                                           as73211_integration_time_1024cyc(data));

One line?

...

> +               /* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
> +               *val = BIT(FIELD_GET(AS73211_CREG3_CCLK_MASK, data->creg3)) * 1024000;

As above mentioned, definition can be used.

...


> +               int reg_bits, freq_kHz = val / 1000 /* HZ_PER_KHZ */;  /* 1024, 2048, ... */
> +
> +               /* val must be 1024 * 2^x */
> +               if (val < 0 || (freq_kHz * 1000 /* HZ_PER_KHZ */) != val ||
> +                               !is_power_of_2(freq_kHz) || val2)
> +                       return -EINVAL;

Please, define HZ_PER_KHZ locally. It will really help when we move
these definitions to a global level.

...

> +               /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> +               reg_bits = 13 - ilog2(val);

13 is the second time in the code. Deserves a descriptive definition.

...

> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +       if (indio_dev == NULL)

if (!indio_dev)

> +               return -ENOMEM;

...

> +       indio_dev->dev.parent = dev;

Doesn't IIO core do this for you?

...

> +       /* At the time of writing this driver, only DEVID 2 and MUT 1 is known. */

are known

...

> +       /* enable device */

This is confusing and by the fact useless.

...

> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret < 0)
> +               goto powerdown;
> +
> +       return 0;

> +powerdown:
> +       as73211_power(indio_dev, false);
> +       return ret;

devm_*() is tricky. Here you broke ordering heavily. So, consider to
add this under devm_add_action_or_reset().

...

> +static int as73211_remove(struct i2c_client *client)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +       as73211_power(indio_dev, false);
> +
> +       return 0;
> +}

And as a result of the above this will be gone.

-- 
With Best Regards,
Andy Shevchenko
