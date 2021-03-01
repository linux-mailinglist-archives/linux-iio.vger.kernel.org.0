Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9936C327D99
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 12:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhCALvk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 06:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbhCALv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 06:51:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E62C061797;
        Mon,  1 Mar 2021 03:50:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d11so9700991plo.8;
        Mon, 01 Mar 2021 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdRNjUMU4aQiIlBErOHAN/fdGX558LB+Z7yKXsNpBrE=;
        b=WQzCvqhX6V4brPcIBvIllv7Vcw99c7HiwTX49EAXfyDBBDv/Y8JRXy/zw5rr9HIMcD
         tSQMhfwN4AnS0GqR8Os4hJo7EyN6MvXL/gTc+VD9i/Ro3jgOnLeXBwsYnqcjLKiCANrT
         bQ72rGQMeLV16d2nrGoSjkLWMzjy0CsnzoDQdnpzbDt9BrvWV6280xXRWrEEziiocbxs
         HxN56hbObNXa5gyuqX4kWURGG0OuH3nmarzLP8t8JMvdUX9pMZQNhKr3ne4ARLpkI4T/
         UhxWoe3v2ObbghsRbeFJ+Pvuh1dfgRo2dEBAf3iWl07yMqSPaXB/Vmo97d7J+fzvCoCO
         Fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdRNjUMU4aQiIlBErOHAN/fdGX558LB+Z7yKXsNpBrE=;
        b=i0xBMR7D1UwTsF+i3Q+x9oyd5ZdCwteDqvObAMbQzrag4AfF1lr+33rQK09H4mhFXa
         jcXc8a4dVOcdg2CIFDLmIxVCnxvWUJELjT0KohyebZiACF9KLq0zfpORQelLfryNhKZl
         GyLOB4opFNzcSvdLeSzjP1lT1UbCmaXuBdvBjcfKPrkKOAXKC6JEbp4qXILKe2CC94hh
         gH+GjHTtuvC7VdpWzuyuJ/olUgUX8+VxJbad8F6P9d266nOOG5czl1eHBXscdzY9RCOB
         oDxpIzcnKemy5IlE3Bytq3qFmoZSaGeAtWuV7x/jBPfVxxPJXwwT8nPzif/shFMv6cx9
         vwEA==
X-Gm-Message-State: AOAM530TUZb3W1WnxzYitp58XTuF0EFiUGbAQiRIIu6GPsRnqG06dSCZ
        OH40MU61c0ZjaZjeHbJha1CC9N2/xUzq/rdCE9g5t8wYb8carw==
X-Google-Smtp-Source: ABdhPJwlVbnInb4MlWPNEJeKYo4HNSmP0K235GsCCVVXe022cn9cNdOzEkK3anPLCOnwmO2HJ5dqaEGHM4PSjpUazV8=
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr17868170pjh.129.1614599406260;
 Mon, 01 Mar 2021 03:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20210222212313.29319-1-joe.g.sandom@gmail.com> <20210227165526.0f8917c8@archlinux>
In-Reply-To: <20210227165526.0f8917c8@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Mar 2021 13:49:49 +0200
Message-ID: <CAHp75VcSW2xXdH--rXaN7xt0Ju+qfw9c_va0gGRGPgpBua0H-Q@mail.gmail.com>
Subject: Re: [RESEND][PATCH v4 1/2] Added AMS tsl2591 driver implementation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Joe Sandom <joe.sandom@outlook.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 27, 2021 at 6:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 22 Feb 2021 21:23:12 +0000
> Joe Sandom <joe.g.sandom@gmail.com> wrote:

I will give my review on top of Jonathan's ones.

...

> > Datasheet Available at: https://ams.com/tsl25911

Can we use Datasheet tag, please?

Datasheet: <URL>

> >

...and drop this blank line.

> > Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>

...

> > +config TSL2591
> > +        tristate "TAOS TSL2591 ambient light sensor"
> > +        depends on I2C
> > +        help
> > +          Select Y here for support of the AMS/TAOS TSL2591 ambient light sensor,
> > +          featuring channels for combined visible + IR intensity and lux illuminance.
> > +          Access als data via iio and sysfs. Supports iio_events.

"Access data via IIO ad sysfs."

> > +          To compile this driver as a module, select M: the
> > +          module will be called tsl2591.

...

> > +/* ALS integration time field value to als time*/

Besides missing space the phrase confuses me (mostly due to "ALS ...
als..." passage).

> > +#define TSL2591_FVAL_TO_ATIME(x) (((x) + 1) * 100)

...

> > +/* TSL2591 command register definitions */
> > +#define TSL2591_CMD_NOP             (BIT(5) | BIT(7))
> > +#define TSL2591_CMD_SF_INTSET       (BIT(2) | GENMASK(7, 5))
> > +#define TSL2591_CMD_SF_CALS_I       (BIT(0) | BIT(2) | GENMASK(7, 5))
> > +#define TSL2591_CMD_SF_CALS_NPI     (GENMASK(2, 0) | GENMASK(7, 5))
> > +#define TSL2591_CMD_SF_CNP_ALSI     (BIT(1) | BIT(3) | GENMASK(7, 5))

If it's a bit combination, describe each bit field separately, but my
guts are telling me that BIT() and GENMASK() use here is wrong.

...

> > +/* TSL2591 enable register definitions */
> > +#define TSL2591_PWR_ON              BIT(0)
> > +#define TSL2591_PWR_OFF             0x00

Similar to above, here you rather use (1 << 0) and (0 << 0), or plain numbers.

...

> > +#define TSL2591_CTRL_ALS_INTEGRATION_100MS  0x00
> > +#define TSL2591_CTRL_ALS_INTEGRATION_200MS  BIT(0)
> > +#define TSL2591_CTRL_ALS_INTEGRATION_300MS  BIT(1)
> > +#define TSL2591_CTRL_ALS_INTEGRATION_400MS  GENMASK(1, 0)
> > +#define TSL2591_CTRL_ALS_INTEGRATION_500MS  BIT(2)
> > +#define TSL2591_CTRL_ALS_INTEGRATION_600MS  (BIT(0) | BIT(2))

Similar to the above. Drop all BIT() / GENMASK() use here and convert
to plain numbers.

...

> > +#define TSL2591_CTRL_ALS_LOW_GAIN           0x00
> > +#define TSL2591_CTRL_ALS_MED_GAIN           BIT(4)
> > +#define TSL2591_CTRL_ALS_HIGH_GAIN          BIT(5)

Ditto. And so on. Please, revisit all descriptions above and below.

...

> > +#define TSL2591_ALS_MAX_VALUE               65535

If it's limited by the amount of bits in use, I prefer to spell it as
(BIT(16) - 1), and we will immediately see this implication.

...

> > +/*
> > + * Period table is ALS persist cycle x integration time setting
> > + * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
> > + * ALS cycles: 1, 2, 3, 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60
> > + */
> > +static const char * const tsl2591_als_period_list[] = {
> > +     "0.1 0.2 0.3 0.5 1.0 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0",
> > +     "0.2 0.4 0.6 1.0 2.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0",
> > +     "0.3 0.6 0.9 1.5 3.0 6.0 7.5 9.0 10.5 12.0 13.5 15.0 16.5 18.0",
> > +     "0.4 0.8 1.2 2.0 4.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0",
> > +     "0.5 1.0 1.5 2.5 5.0 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0",
> > +     "0.6 1.2 1.8 3.0 6.0 12.0 15.0 18.0 21.0 24.0 27.0 30.0 33.0 36.0",
> > +};

Okay... But it can be generated I guess.

...

> > +static int tsl2591_als_time_to_fval(const u32 als_integration_time)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(tsl2591_int_time_available); ++i) {
> > +             if (als_integration_time == tsl2591_int_time_available[i])
> > +                     return ((als_integration_time / 100) - 1);

Looks like a reversed function of a macro you have above. Care to
introduce a counterpart macro instead and use it here?

> > +             if (i == (ARRAY_SIZE(tsl2591_int_time_available) - 1))
> > +                     break;

This doesn't make any sense to me.

> > +     }
> > +
> > +     return -EINVAL;
> > +}

...

> > +static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
> > +{
> > +     struct i2c_client *client = chip->client;
> > +     struct tsl2591_als_settings settings = chip->als_settings;

> > +     int delay = TSL2591_FVAL_TO_ATIME(settings.als_int_time);

Move the assignment closer to the conditional below.

> > +     int ret;
> > +     int i;
> > +
> > +     if (!delay)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Sleep for ALS integration time to allow enough time
> > +      * for an ADC read cycle to complete. Check status after
> > +      * delay for ALS valid

Missed period.

> > +      */
> > +     msleep(delay);
> > +
> > +     /* Check for status ALS valid flag for up to 100ms */
> > +     for (i = 0; i < TSL2591_ALS_STS_VALID_COUNT; ++i) {

i++ works perfectly.

> > +             ret = i2c_smbus_read_byte_data(client,
> > +                                            TSL2591_CMD_NOP | TSL2591_STATUS);
> > +             if (ret < 0) {
> > +                     dev_err(&client->dev, "Failed to read register\n");
> > +                     return -EINVAL;
> > +             }
> > +             ret = FIELD_GET(TSL2591_STS_ALS_VALID_MASK, ret);
> > +             if (ret == TSL2591_STS_VAL_HIGH_MASK)
> > +                     break;
> > +
> > +             if (i == (TSL2591_ALS_STS_VALID_COUNT - 1))

In many cases you added too many parentheses. It's not a LISP language :-)

> > +                     return -ENODATA;
> > +
> > +             usleep_range(9000, 10000);
> > +     }

This can be done using iopoll.h and readx_poll_timeout() helper.

> > +     return 0;
> > +}

...

> > +static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
> > +                                  struct iio_chan_spec const *chan,
> > +                                  int *val, int *val2)
> > +{
> > +     struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +     struct tsl2591_als_settings *settings = &chip->als_settings;
> > +     struct i2c_client *client = chip->client;
> > +     int ret;
> > +     u8 als_data[TSL2591_NUM_DATA_REGISTERS];

Try to keep reversed xmas tree order in the definition block(s).

> > +

This should not be here.

> > +     int counts_per_lux;
> > +     int lux;
> > +     int gain_multi;
> > +     int int_time_fval;

> > +

Ditto.

> > +     u16 als_ch0;
> > +     u16 als_ch1;
> > +
> > +     ret = tsl2591_wait_adc_complete(chip);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "No data available. Err: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret = i2c_smbus_read_i2c_block_data(client,
> > +                                         TSL2591_CMD_NOP | TSL2591_C0_DATAL,
> > +                                         sizeof(als_data), als_data);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "Failed to read data bytes");
> > +                     return ret;
> For comment below if (ret), that won't work on these calls because IIRC they
> return the number of bytes transferred.  However, you can move the check locally
> that this is the right length and ensure 0 is returned for the good path.
> > +     }

> > +     als_ch0 = le16_to_cpup((const __le16 *)&als_data[0]);
> > +     als_ch1 = le16_to_cpup((const __le16 *)&als_data[2]);

The casting looks wrong. Why do you need it? Perhaps your type of
als_data is not okay? Or perhaps you need to use get_unaligned_le16()?
I dunno.

> > +     switch (chan->type) {
> > +     case IIO_INTENSITY:
> > +             if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
> > +                     *val = als_ch0;
> > +             else if (chan->channel2 == IIO_MOD_LIGHT_IR)
> > +                     *val = als_ch1;
> > +             else
> > +                     return -EINVAL;
> > +             break;
> > +     case IIO_LIGHT:
> > +             gain_multi = tsl2591_gain_to_multiplier(settings->als_gain);
> > +             if (gain_multi < 0) {
> > +                     dev_err(&client->dev, "Invalid multiplier");
> > +                     return gain_multi;
> > +             }
> > +
> > +             int_time_fval = TSL2591_FVAL_TO_ATIME(settings->als_int_time);
> > +             /* Calculate counts per lux value */

> > +             counts_per_lux =
> > +                     (int_time_fval * gain_multi) / TSL2591_LUX_COEFFICIENT;

One line.

> > +             dev_dbg(&client->dev, "Counts Per Lux: %d\n", counts_per_lux);

> > +             /* Calculate lux value */
> > +             lux = ((als_ch0 - als_ch1) *
> > +                    (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;

> > +             dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
> > +
> > +             /* Divide by 1000 to get real lux value before scaling */
> > +             *val = lux / 1000;

Doing this before the following one makes precision drop. Or not?

> > +             /* Get the decimal part of lux reading */
> > +             *val2 = ((lux - (*val * 1000)) * 1000);
> > +
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return ret;
>
> See above for why: I'd return 0 here
>
> > +}

...

> > +     als_lower_l = (als_settings.als_lower_thresh & 0x00FF);
>
> Given you are writing these into a byte field, probably better to express those
> masks as 0xFF.

u8 type may never be bigger than 255. Masks like that are redundant.

> > +     als_lower_h = ((als_settings.als_lower_thresh >> 8) & 0x00FF);
> > +     als_upper_l = (als_settings.als_upper_thresh & 0x00FF);
> > +     als_upper_h = ((als_settings.als_upper_thresh >> 8) & 0x00FF);

Ditto.

...

> > +static int tsl2591_write_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int val, int val2, long mask)
> > +{
> > +     struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +
> > +     u8 gain;
> > +     u32 int_time;
> > +     int ret;

No need for power management?

> > +     mutex_lock(&chip->als_mutex);

> > +     mutex_unlock(&chip->als_mutex);
> > +     return ret;
> > +}

...

> > +static int tsl2591_read_event_value(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 enum iio_event_info info, int *val,
> > +                                 int *val2)

Ditto.

...

> > +static int __maybe_unused tsl2591_resume(struct device *dev)
> > +{
> > +     struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +     struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +     int ret;
> > +     int power_state;
> > +
> > +     if (chip->events_enabled)

> > +             power_state = TSL2591_PWR_ON |
> > +                           TSL2591_ENABLE_ALS_INT |
> > +                           TSL2591_ENABLE_ALS;

At least the last two can be on one line.

> > +     else
> > +             power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS;
> > +
> > +     mutex_lock(&chip->als_mutex);
> > +     ret = tsl2591_set_power_state(chip, power_state);
> > +     mutex_unlock(&chip->als_mutex);
> > +
> > +     return ret;
> > +}

...

> > +static const struct dev_pm_ops tsl2591_pm_ops = {
> > +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                             pm_runtime_force_resume)

One line?

> > +     SET_RUNTIME_PM_OPS(tsl2591_suspend, tsl2591_resume, NULL)
> > +};

...

> > +static irqreturn_t tsl2591_event_handler(int irq, void *private)
> > +{

> > +     /* Clear ALS irq */
> > +     ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> > +     if (ret < 0)

> > +             dev_err(&client->dev, "Failed to clear als irq\n");

In the IRQ handler? Hmm... It potentially floods the logs.

> > +     return IRQ_HANDLED;
> > +}

...

> > +static const struct of_device_id tsl2591_of_match[] = {
> > +     { .compatible = "amstaos,tsl2591"},

> > +     {},

Comma is not needed on the terminator line.

> > +};

-- 
With Best Regards,
Andy Shevchenko
