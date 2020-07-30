Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A22330F2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG3Lbw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jul 2020 07:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG3Lbv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2020 07:31:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE64C061794;
        Thu, 30 Jul 2020 04:31:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r4so3184591pls.2;
        Thu, 30 Jul 2020 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySjFb6xHTA8Omh7FF42l3yV01aH6PLF0+fI/lUr+5WM=;
        b=gYvwLdhRLgmKRATmq2uyKUpvBP/YpVxF0ms/2OKnuW9vB6ExHbPGPqkfvSjHL/SXg/
         jGyIOK0zRMsDXTZSnr/WoVUS73EeCxvGQcwaEepvSYwdjWcQGfyPLLyMTKIky4HfcPU4
         Sf1SOClOqsa3GacOF5p4HXwAFuwxks1u9xa4euRMPXzwZLJFsfEcHqem5tkqW8W57tng
         hVoxguv+yb+p3Qnna9O2ag0ObJFldBvaS/uwN9QK4kfFYGq8TjkN3lfunX++wSKpiHdI
         8EFcXIhOALo+qk9JAFqljWLzLNjsNGb7u2681EIcLkT/UG6++NhccknOWDyAnhiOIyeD
         0XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySjFb6xHTA8Omh7FF42l3yV01aH6PLF0+fI/lUr+5WM=;
        b=ZZVKhyAi3/QnzahfHhEckJdJInnI/eHMW98Mkoa9ddhE7uu/LWUADYxnb++YbHC/qZ
         dquaLHLiKT9xdV15Fefw8qXKqt96tPcIg1ILPg5xCPRTUSqB2EfaZSqAlbAdMwuICRSI
         y2zE9oK2H6jpCL8UXMBMSD9G0cVNTr+Z2L3RtQEQBEUyPwSCHlP9xxwCFxZSgiItHNok
         l+ND/E/rAlWQ/kLsmYFtOVe6uJuxe5qwBkcEc127mRmlr9wHNG6UmJJzg4MQ4wNXhoBq
         LKHkQWVpjzTFTN7COgE+c7LQ0G7uYU3vLu8qNjd6I13eBXV8UY5zuDx7jH02v/8HrMMh
         F5LQ==
X-Gm-Message-State: AOAM530v/alcZaKCyp/LASUQu+s990qYdwLdDm1fTsf9imifsYrcqzVv
        Lx9RSXyHoerSrfZyyWgpmlTD2V6AhmbA/hqQLDo=
X-Google-Smtp-Source: ABdhPJwY3wW8qBfm4pNGjqcSXo15lYCqxsHL4k+xQOGA6M50Zq84lsr9P/Mc0doXNFEzr1goBkgqXLP1RVm2eqyx6cM=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr15182595pjp.228.1596108710486;
 Thu, 30 Jul 2020 04:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200730104946.39148-1-ceggers@arri.de> <20200730104946.39148-3-ceggers@arri.de>
In-Reply-To: <20200730104946.39148-3-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jul 2020 14:31:31 +0300
Message-ID: <CAHp75VeXqFgqiGUkS71B1xCD-60iQFS4EKJwVFX-L_dTUFMc6A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Thu, Jul 30, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:
> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
>
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
>
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.

...

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>

Ordered?

...

> +/**
> + * struct as73211_data - Instance data for one AS73211
> + * @client: I2C client.
> + * @osr:    Cached Operational State Register.
> + * @creg1:  Cached Configuration Register 1.
> + * @creg2:  Cached Configuration Register 2.
> + * @creg3:  Cached Configuration Register 3.
> + * @buffer: Buffer for triggered measurements.
> + * @mutex:  Keeps cached registers in synch with the device.
> + * @completion: Completion to wait for interrupt.
> + */
> +struct as73211_data {
> +       struct i2c_client *client;
> +       u8 osr;
> +       u8 creg1;
> +       u8 creg2;
> +       u8 creg3;
> +       struct mutex mutex;
> +       struct completion completion;
> +};

Actually Jonathan is correct -- the above has kernel doc issues.

...

> +#define AS73211_SCAN_MASK_COLOR \
> +       (BIT(AS73211_SCAN_INDEX_X) | BIT(AS73211_SCAN_INDEX_Y) | BIT(AS73211_SCAN_INDEX_Z))

> +#define AS73211_SCAN_MASK_ALL (BIT(AS73211_SCAN_INDEX_TEMP) | AS73211_SCAN_MASK_COLOR)

Perhaps split for easy reading.

...

> +static unsigned int as73211_integration_time_us(struct as73211_data *data)
> +{
> +       /* Integration time has 15 steps, the step size depends on the clock. */
> +       unsigned int mul = BIT(3 - (data->creg3 & GENMASK(1, 0)));

Shouldn't be rather

#define FOO  GENMASK(1, 0)
mul = BIT(FOO - (creg & FOO));

with a descriptive name of FOO?

Or if both 3:s have different meaning, two definitions?

> +       return as73211_integration_time_cycles(data) * 125 * mul;
> +}

...

> +static unsigned int as73211_gain(struct as73211_data *data)
> +{

> +       return BIT(0xb - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));

Magic!

> +}

...

> +       struct device *dev = &data->client->dev;
> +       unsigned int time_us = as73211_integration_time_us(data);
> +       int ret;
> +       union i2c_smbus_data smbus_data;
> +       u16 osr_status;

Can you keep this in reversed tree order?

       unsigned int time_us = as73211_integration_time_us(data);
       struct device *dev = &data->client->dev;
       union i2c_smbus_data smbus_data;
       u16 osr_status;
       int ret;

Same comment to the rest where applicable.

...

> +       /* Add some extra margin for the timeout. sensor timing is not as precise
> +        * as our one ...
> +        */

Comment style. Same to the rest of the code where applicable.

...

> +       if (data->client->irq) {
> +               dev_dbg(dev, "Waiting for completion...\n");
> +               ret = wait_for_completion_timeout(&data->completion,

> +                                       2 + usecs_to_jiffies(time_us));

Magic!

> +               if (!ret) {
> +                       dev_err(dev, "timeout waiting for READY IRQ\n");
> +                       i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +                       return -ETIMEDOUT;
> +               }
> +       } else {
> +               /* Wait integration time */

> +               dev_dbg(dev, "Sleeping %d us\n", time_us);

Looks like a noise (good for development, bad for upstream)

> +               usleep_range(time_us, time_us + 100000);

If time_us appears to be, let's say, 100. The above margin is way too high.

> +       }

...

> +       osr_status = (u16)ret;

Why casting?

...

> +       dev_dbg(dev, "osr_status = 0x%04x\n", osr_status);

Looks like a noise (good for development, bad for upstream)

...

> +               if (osr_status & AS73211_OSR_SS) {
> +                       dev_warn(dev, "%s() Measurement has not stopped\n", __func__);
> +                       return -ETIME;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_NOTREADY) {
> +                       dev_warn(dev, "%s() Data is not ready\n", __func__);
> +                       return -ENODATA;
> +               }
> +               if (!(osr_status & AS73211_OSR_STATUS_NDATA)) {
> +                       dev_warn(dev, "%s() New new data available\n", __func__);
> +                       return -ENODATA;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_LDATA) {
> +                       dev_warn(dev, "%s() Result buffer overrun\n", __func__);
> +                       return -ENOBUFS;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_ADCOF) {
> +                       dev_warn(dev, "%s() ADC overflow\n", __func__);
> +                       return -EOVERFLOW;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_MRESOF) {
> +                       dev_warn(dev, "%s() Measurement result overflow\n", __func__);
> +                       return -EOVERFLOW;
> +               }
> +               if (osr_status & AS73211_OSR_STATUS_OUTCONVOF) {
> +                       dev_warn(dev, "%s() Timer overflow\n", __func__);
> +                       return -EOVERFLOW;
> +               }
> +               dev_warn(dev, "%s() Unexpected status value\n", __func__);
> +               return -EIO;
> +       }

All above dev_warn() are wrong. Should be dev_err(). Otherwise all
return -ERRNO are wrong.

...

> +               int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +               if (ret)
> +                       return ret;

Please, use better arrangement, i.e.

  int ret;

  ret = ...
  if (ret)
  ...

+ blank line.

> +               ret = as73211_req_data(data);
> +               if (ret < 0) {
> +                       iio_device_release_direct_mode(indio_dev);
> +                       return ret;
> +               }

+ blank line

> +               ret = i2c_smbus_read_word_data(data->client, chan->address);
> +               iio_device_release_direct_mode(indio_dev);
> +               if (ret < 0)
> +                       return ret;

+ blank line

> +               *val = ret;
> +               return IIO_VAL_INT;
> +       }

...

> +       case IIO_CHAN_INFO_SCALE:
> +       {

On one line.

...

> +               *val = BIT(data->creg3 & GENMASK(1, 0)) * 1024 * 1000;

1000 is magic and 1024 either.

1000 is frequency multiplier? If it's not defined do it like
  #define HZ_PER_KHZ
  #define KHZ_PER_MHZ
or what is that?

...

> +               *val = time_us / 1000000;
> +               *val2 = time_us % 1000000;

Ditto.

NSEC_PER_SEC or what?

...

> +               int reg_bits, freq_kHz = val / 1000;  /* 1024, 2048, ... */

HZ_PER_KHZ?

...

> +               if (val < 0 || (freq_kHz * 1000) != val || val2)

Ditto.

...

> +               return i2c_smbus_write_byte_data(data->client, AS73211_REG_CREG3, data->creg3);

Can it suddenly return positive number?

...

> +               int time_us = val * 1000000 + val2, time_ms;

NSEC_PER_MSEC ?
USEC_PER_SEC ?

...

> +               time_ms = (time_us * mul) / 1000;  /* 1 ms, 2 ms, ... (power of two) */

NSEC_PER_MSEC

...

> +               if (time_ms < 0 || !is_power_of_2(time_ms) || time_ms > 16384)

Magic! Shouldn't be rather BIT(14)  and defined somewhere?

...


> +       /* Need to switch to config mode ... */

Not sure how this comment related to locking.

> +       mutex_lock(&data->mutex);

...

> +               dev_dbg(&indio_dev->dev, "Switching to configuration state...");

Noise.

...

> +static irqreturn_t as73211_ready_handler(int irq __always_unused, void *priv)
> +{

> +       struct iio_dev *indio_dev = priv;

Unneeded churn.

> +       struct as73211_data *data = iio_priv(indio_dev);

iio_priv(priv)

> +       complete(&data->completion);
> +
> +       return IRQ_HANDLED;
> +}

...

> +       struct iio_dev *indio_dev = pf->indio_dev;

Ditto. Do you use indio_dev below (except one case)? I haven't noticed.

> +       struct as73211_data *data = iio_priv(indio_dev);

...

> +               struct i2c_msg msgs[] = {
> +                       {
> +                               .addr = data->client->addr,
> +                               .flags = 0,
> +                               .len = 1,
> +                               .buf = &addr

+ comma

> +                       },
> +                       {
> +                               .addr = data->client->addr,
> +                               .flags = I2C_M_RD,
> +                               .len = sizeof(scan.chan),
> +                               .buf = (u8 *)&scan.chan

+ comma

> +                       },
> +               };

...

> +       }
> +       /* Optimization for reading only color channels */
> +       else {

Should be one line. Had you run checkpatch?

...

> +static ssize_t as73211_show_samp_freq_available(struct device *dev __always_unused,
> +                                                struct device_attribute *attr __always_unused,
> +                                                char *buf)
> +{
> +}
> +
> +static ssize_t as73211_show_int_time_available(struct device *dev,
> +                                               struct device_attribute *attr __always_unused,
> +                                               char *buf)
> +{
> +}
> +
> +static ssize_t as73211_show_hardwaregain_available(struct device *dev __always_unused,
> +                                                   struct device_attribute *attr __always_unused,
> +                                                   char *buf)
> +{
> +}

I guess above is an overkill. See example here

commit 6085102c494b8afc62bc093f8f32d6248f6d33e5
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Mar 23 12:41:26 2020 +0200

   iio: pressure: bmp280: Convert to use ->read_avail()

...

> +       ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
> +       if (ret < 0)
> +               return ret;

Yeah, be consistent. Either all such call should be checked against
negative error code, or drop ' < 0' everywhere it applies.

...

> +       /* At the time of writing this driver, only DEVID 2 and MUT 1 is known. */
> +       if ((ret & AS73211_AGEN_DEVID_MASK) != AS73211_AGEN_DEVID(2)
> +                       || (ret & AS73211_AGEN_MUT_MASK) != AS73211_AGEN_MUT(1))

Looks like broken indentation, and leave || on previous line.

> +               return -ENODEV;

...

> +       if (client->irq) {
> +               ret = request_threaded_irq(client->irq,
> +                               NULL,
> +                               as73211_ready_handler,

> +                               IRQF_TRIGGER_RISING | IRQF_ONESHOT,

Should not be IRQ trigger type here. (Do you have broken firmware table?)

> +                               client->name, indio_dev);
> +               if (ret)
> +                       goto buffer_cleanup;
> +       }

-- 
With Best Regards,
Andy Shevchenko
