Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05331400271
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhICPiV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhICPiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 11:38:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22595C061575
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 08:37:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so3478218pje.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pa9H0PPyr31EsRiFPOZU4B2G9nQvRDCCHnuNpHoLAKw=;
        b=V4PTufZDbv0VJwttxLeZuCz14/vGFEk4LqTvihbxsxdLeLoLgaR6448Hh/AL5VbLT2
         dTtFOMX6loczhOsYTfElSg3AqpVAZo6oC8opPDdtJPwV4CmGX62CsB/yn+Sttq01voF8
         GUFqwexCbrmXDb6QT2fB5now84YQcgdVQrUedh4mLNDi/yh894jWalJY3y57fQOfLwdV
         +zLGEHbYBpfiycYma123JMAGyyy1lN5iEs9HxMNQ0zqe7mkexxuwcBHdaM/MBRQwPjKC
         ostPh9WerNyvjNw5mlGlWLL296lu9qVv59bLDuvAgax8r4Zo8K4M89ANBlClN2KQPp5V
         22Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pa9H0PPyr31EsRiFPOZU4B2G9nQvRDCCHnuNpHoLAKw=;
        b=keMvbJITM50Xjujn8grWpj6ZF7EZHThM0G2fz2scYeezmdU0gc8kHLytTOqNdTW6Yh
         xOq4Eo7EdqalW2WNz0MN80k00s7CDpQ7SbRbcVrWMQZS681Y9w4uIKplCpz0KmHn5Bjo
         fvPa4UZtn+3Rym6ghIeRMi0LyC4q86Cf/G3Qm/9RRv3WQIx60D1+G49GIEROyTxRYike
         9gNrId7kyfu5AHhqi58ELuACJW4KxogZdwD5zoI/vH9ARxmfi3NiDFw82O5E/AzuY+B2
         8dnthx98hCrtLBPiupnqz8WwMYOweEkFJkR/zGr4cGl4x5ZFN7/8h0ILa6MT9Em0zWwo
         N9QQ==
X-Gm-Message-State: AOAM5318lF5+B0xG9nzSbVR2W5zCwCnTfDTVq190ndIACbC+eFg4fOvD
        EH33X9YHXP3TDtWoJIXQPusQg+lXbk3bLApVA0g=
X-Google-Smtp-Source: ABdhPJxH0WbSNzJGwfMfHGVpK/zA3fvdniZyQxGP55c44ZcOix7CdnVlZmzjLIjk0Nin+fTLvfFRfF1kWpMvmXblQHo=
X-Received: by 2002:a17:90b:2212:: with SMTP id kw18mr1407270pjb.59.1630683440513;
 Fri, 03 Sep 2021 08:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210903144828.497166-1-jacopo@jmondi.org> <20210903144828.497166-3-jacopo@jmondi.org>
In-Reply-To: <20210903144828.497166-3-jacopo@jmondi.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Sep 2021 18:36:44 +0300
Message-ID: <CAHp75VdX0=JCGDQaqCU5fDGe7vJBNTDTJHu=QOqd_YtGK4Rgdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: chemical: Add Senseair Sunrise 006-0-007 driver
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 3, 2021 at 5:50 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.

...

> +static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
> +{
> +       unsigned int val;
> +       int ret;
> +
> +       /*
> +        * Lock the 'wakeup' session.
> +        *
> +        * If another read/write call sneaks in between the wakeup message
> +        * and the i2c transaction, the chip goes back in sleep state.
> +        */

> +       mutex_lock(&sunrise->wakeup_lock);
> +       sunrise_wakeup(sunrise);
> +       ret = regmap_read(sunrise->regmap, reg, &val);
> +       mutex_unlock(&sunrise->wakeup_lock);

Seems to me that you may redefine ->read() for regmap (but double
check this, esp. in regard to bulk transfers) with wakeup implied and
in that case you probably can use regmap's lock only.

> +       if (ret) {

> +               dev_err(&sunrise->client->dev,
> +                       "Read byte failed: reg 0x%2x (%d)\n", reg, ret);

With the same LOCs I slightly prefer temporary variable

struct device *dev = ...;
  ...
dev_err(dev, ...); // on a single line

Ditto everywhere.

> +               return ret;
> +       }
> +
> +       return val;
> +}

...

> +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> +{
> +       __be16 be_val;
> +       int ret;
> +
> +       mutex_lock(&sunrise->wakeup_lock);
> +       sunrise_wakeup(sunrise);

> +       ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, 2);

sizeof(be_val)

> +       mutex_unlock(&sunrise->wakeup_lock);
> +       if (ret) {
> +               dev_err(&sunrise->client->dev,
> +                       "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> +               return ret;
> +       }
> +
> +       *val = be16_to_cpu(be_val);
> +
> +       return 0;
> +}

...

> +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> +{
> +       __be16 be_data = cpu_to_be16(data);
> +       int ret;
> +
> +       mutex_lock(&sunrise->wakeup_lock);
> +       sunrise_wakeup(sunrise);
> +       ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, 2);
> +       mutex_unlock(&sunrise->wakeup_lock);
> +       if (ret) {
> +               dev_err(&sunrise->client->dev,
> +                       "Write word failed: reg 0x%2x (%d)\n", reg, ret);

> +               return ret;
> +       }
> +
> +       return 0;

return ret;

> +}

...

> +       /* Write a calibration command and poll the calibration status bit. */
> +       ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG,
> +                                data->cmd);

Dunno how long it is, but to me seems one line is okay.

> +       if (ret)
> +               return ret;

...

> +static ssize_t sunrise_cal_read(const char *buf, size_t len)
> +{
> +       bool enable;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &enable);
> +       if (ret)
> +               return ret;
> +
> +       if (!enable)
> +               return len;
> +
> +       return 0;

Why is this a separate function to begin with?

Not sure I have got the logic behind. If enable is true you return 0?!

> +}

...

> +static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
> +                                        uintptr_t private,
> +                                        const struct iio_chan_spec *chan,
> +                                        const char *buf, size_t len)
> +{
> +       struct sunrise_dev *sunrise = iio_priv(iiodev);
> +       int ret;
> +
> +       mutex_lock(&sunrise->lock);
> +       ret = sunrise_cal_read(buf, len);

> +       if (ret) {
> +               mutex_unlock(&sunrise->lock);
> +               return ret;
> +       }

Possibly

  if (ret)
    goto out_unlock;

> +       ret = sunrise_calibrate(sunrise,
> +                               &calib_data[SUNRISE_CALIBRATION_FACTORY]);

One line?

out_unlock:

> +       mutex_unlock(&sunrise->lock);
> +       if (ret)
> +               return ret;
> +
> +       return len;
> +}

...

> +       errors = value;
> +       for_each_set_bit(i, &errors, ARRAY_SIZE(sunrise_error_statuses))
> +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);

> +

Can drop this (up to you).

> +       if (len)
> +               buf[len - 1] = '\n';

...

> +                       ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
> +                                               &value);

One line?

...

> +                       ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
> +                                               &value);

Ditto.

...

> +               /* x10 to comply with IIO scale (1/1000 degress celsius). */

1/1000 -->  millidegrees
(Also note spelling)

--
With Best Regards,
Andy Shevchenko
