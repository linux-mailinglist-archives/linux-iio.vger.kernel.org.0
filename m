Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D473CA337
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhGOQxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGOQxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 12:53:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504D7C06175F;
        Thu, 15 Jul 2021 09:50:17 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u14so7094964pga.11;
        Thu, 15 Jul 2021 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFWFee6bQHbnSz5GpSNixvWUan+/ZoMl4OFkX2jAXbA=;
        b=tFVOMcho+x8fApi7UcWNTQjDgmONPx+FoQ3IkISkOs7WVqd/gZm/pXe3bnGWLuLbu3
         us3FYxwmgS5vHXlmqlXaWgQqHvWo/W67C762U6itD17DoXMxjL5QPfKtM3L10zikGQOL
         ACkxtChncnnbP1EqFMzK697ZlLEHLFFarPtEWOfjpQK5pgd0xUi59akwxHQnSP1/7IFO
         oPc8PLO9nok2Hx73eYfmOyYUfVjCbCs2oZZXs7xyLZSw9THk/HAPTWu+7ENKjWoqae9q
         TtedItLRF+YYdPn+5ibxhTcWc9Egxf18mdBowh9MUWcIOVtn5Evt2L6vjv+Q9rrkxiCn
         qVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFWFee6bQHbnSz5GpSNixvWUan+/ZoMl4OFkX2jAXbA=;
        b=UA+PIeFXFXx1JocanxFAOnPjtlc0wtA4Go30fYA/uMcZcfsuwcZw/o5W6JbPV0s2xD
         4qgNLoWnH1Qxc+PaIXx4oSsYJ9gKyfBSjPHyizsWsz8mBcliCgIPVxw5FKEs7GI2nWQp
         QfSUkpq7IXyMMdj8Z1XggLvCSi9G+PVUOXvNJ6X0HgGBEyOcyaqqKUVfoRT56aFs2b+y
         wsJTSkGUuRDLOjfd1CfzCnNnqzRmYfQzzP4POY02kw6o1F7D5VvighcE6K13mwgUSqm3
         S/KSN2fBCPmFxv9QMXHAEp3JVS3Yy3J4bM95crPY/xSaacBxqQrL3JWjK4zceatM5P0B
         iPWg==
X-Gm-Message-State: AOAM530hnh6cH6Di4gjm8tS8iaPVRudwHA6YNprMjzteQ2AZoDOSSIDT
        Bfaq0f8+YU6LdzdVZqjY8bAuoigXiPMGfIqBOVl05rXNBiFavQ==
X-Google-Smtp-Source: ABdhPJw5rjbMYImv762rw799WrDj5PBN3xnf1Bcf+OLFE2ccy7I53G7ZseDdyLDvy8Ou4Xvgu+PGVZv7UZ8Dj+pvzRM=
X-Received: by 2002:a63:d014:: with SMTP id z20mr5502887pgf.203.1626367816484;
 Thu, 15 Jul 2021 09:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com> <20210715141742.15072-3-andrea.merello@gmail.com>
In-Reply-To: <20210715141742.15072-3-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 19:49:35 +0300
Message-ID: <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        matt.ranostay@konsulko.com, andriy.shevchenko@linux.intel.com,
        vlad.dogaru@intel.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 15, 2021 at 5:21 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> can be connected via both serial and I2C busses; separate patches will
> add support for them.
>
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also do calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
>
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass
> filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> they can be customized; this is why AMG mode can still be interesting.

...

> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Cc: Andrea Merello <andrea.merello@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org

Instead of polluting commit messages with this, use --to and --cc
parameters. You may utilize my script [1] which finds automatically to
whom to send (of course it allows manually to add more).

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

...

> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# driver for Bosh bmo055

Driver

Point of this comment actually is ..?

...

> +# Makefile for bosh bno055

Ditto.

...

> +// SPDX-License-Identifier: GPL-2.0-or-later

Is it the correct one, looking at the portions taken from other drivers?

> +/*
> + * IIO driver for Bosh BNO055 IMU
> + *
> + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> + * Electronic Design Laboratory
> + * Written by Andrea Merello <andrea.merello@iit.it>
> + *
> + * Portions of this driver are taken from the BNO055 driver patch
> + * from Vlad Dogaru which is Copyright (c) 2016, Intel Corporation.
> + *
> + * This driver is also based on BMI160 driver, which is:
> + *     Copyright (c) 2016, Intel Corporation.
> + *     Copyright (c) 2019, Martin Kelly.
> + */

...

> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>

> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>

Can you move this group to...

> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>

...be here?

> +#include "bno055.h"

...

> +#define BNO055_CALIB_STAT_MASK 3

GENMASK()

...

> +#define BNO055_UNIT_SEL_ANDROID BIT(7)

Android? What does this mean?

...

> +#define BNO055_CALDATA_LEN (BNO055_CALDATA_END - BNO055_CALDATA_START + 1)

Can you put just a plain number?

...

> +#define BNO055_ACC_CONFIG_LPF_MASK 0x1C

GENMASK() here and everywhere where it makes sense.

...

> +#define BNO055_UID_LEN (0xF)

Useless parentheses. If the LEN is a plain number, use decimal, if
it's limited by register width, use the form of (BIT(x) - 1). In such
a case it's easy to see how many bits are used for it.

...

> +       int i;
> +       int best_idx, best_delta, delta;
> +       int first = 1;

Use reversed xmas tree order.

...

> +       for (i = 0; i < len; i++) {
> +               delta = abs(arr[i] - val);
> +               if (first || delta < best_delta) {
> +                       best_delta = delta;
> +                       best_idx = i;
> +               }
> +               first = 0;
> +       }

I think I saw this kind of snippet for the 100th time. Can it be
factored out to some helper and used by everyone?

...

> +       if ((reg >= 0x8 && reg <= 0x3A) ||

Use names instead of values here and in similar places elsewhere.

> +           /* when in fusion mode, config is updated by chip */
> +           reg == BNO055_MAG_CONFIG_REG ||
> +           reg == BNO055_ACC_CONFIG_REG ||
> +           reg == BNO055_GYR_CONFIG_REG ||
> +           (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END))

Please, split this to 3 or more conditionals that are easier to read
(logically separated).
Same comment to the rest of the similar functions.

...

> +               .selector_mask = 0xff,

GENMASK() ?

...

> +       if (res && res != -ERESTARTSYS) {

Shouldn't RESTARTSYS be handled on a regmap level?

...

> +/* must be called in configuration mode */
> +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> +{
> +       int i;
> +       unsigned int tmp;
> +       u8 cal[BNO055_CALDATA_LEN];
> +       int read, tot_read = 0;
> +       int ret = 0;
> +       char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> +
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       memcpy(buf, fw->data, fw->size);

kmemdup() ?

> +       buf[fw->size] = '\0';

> +       for (i = 0; i < BNO055_CALDATA_LEN; i++) {
> +               ret = sscanf(buf + tot_read, "%x%n",
> +                            &tmp, &read);
> +               if (ret != 1 || tmp > 0xff) {
> +                       ret = -EINVAL;
> +                       goto exit;
> +               }
> +               cal[i] = tmp;
> +               tot_read += read;
> +       }

Sounds like NIH hex2bin().

> +       dev_dbg(priv->dev, "loading cal data: %*ph", BNO055_CALDATA_LEN, cal);
> +       ret = regmap_bulk_write(priv->regmap, BNO055_CALDATA_START,
> +                               cal, BNO055_CALDATA_LEN);
> +exit:
> +       kfree(buf);
> +       return ret;
> +}

...

> +       int ret = bno055_reg_read(priv, reg, &hwval);
> +
> +       if (ret)
> +               return ret;

In all cases (esp. when resource allocations are involved) better to use

int ret;

ret = func();
if (foo)
  return ret;

...

> +       dev_dbg(priv->dev, "WR config - reg, mask, val: 0x%x, 0x%x, 0x%x",
> +               reg, mask, hwval);

Why? Enable regmap trace events for this and drop these unneeded prints.

...

> +       __le16 raw_val;

> +               ret = regmap_bulk_read(priv->regmap, chan->address,
> +                                      &raw_val, 2);

sizeof(raw_val)

and everywhere where similar cases are.

> +               if (ret < 0)
> +                       return ret;

...

> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               if (chan->type == IIO_MAGN)
> +                       return bno055_get_mag_odr(priv, val, val2);
> +               else
> +                       return -EINVAL;

Use usual pattern

  if (!cond)
   return ERRNO;
  ...
  return bar;

...


> +               for (i = 0; i < 4; i++)
> +                       vals[i] = (s16)le16_to_cpu(raw_vals[i]);

Extract this to be a helper like there are for u32 and u64.

...

> +               vals[1] = 1 << 14;

BIT(14) But still magic.

...
> +               switch (mask) {
> +               case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +                       return bno055_set_gyr_lpf(priv, val, val2);

default?

> +               }

...

> +       struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> +
> +       return scnprintf(buf, PAGE_SIZE, "%s\n",
> +                        (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "20" :
> +                        "2 6 8 10 15 20 25 30");

IIO core should do this, besides the fact that it must use sysfs_emit().
Ditto for the similar.

...

> +       if (sysfs_streq(buf, "amg"))
> +               priv->operation_mode = BNO055_OPR_MODE_AMG;
> +       else if (sysfs_streq(buf, "fusion"))
> +               priv->operation_mode = BNO055_OPR_MODE_FUSION;
> +       else if (sysfs_streq(buf, "fusion_fmc_off"))
> +               priv->operation_mode = BNO055_OPR_MODE_FUSION_FMC_OFF;
> +       else
> +               return -EINVAL;

Wondering if you may use sysfs_match_string().

...

> +       return res ? res : len;

ret, res, ... Be consistent!
Besides that the form

  return ret ?: len;

is shorter and better.


...


> +       static const char * const calib_status[] = {"bad", "barely enough",
> +                                                  "fair", "good"};

Please use better indentation

    static char ... foo[] = {
        { a, b, c, d, }
    };



> +       for (size = 0, i = 0; i < BNO055_CALDATA_LEN; i++) {
> +               ret = scnprintf(buf + size,
> +                               PAGE_SIZE - size, "%02x%c", data[i],
> +                               (i + 1 < BNO055_CALDATA_LEN) ? ' ' : '\n');
> +               if (ret < 0)
> +                       return ret;
> +               size += ret;
> +       }

And if it's more than 4/3 kBytes (binary)?
Isn't it better to use the request_firmware() interface or something similar?
If IIO doesn't provide the common attributes for this it probably
should and it has to be a binary one.

...

> +static IIO_DEVICE_ATTR_RO(in_magn_sampling_frequency_available,
> +                         0);

Definitely one line.

...


> +       &iio_dev_attr_in_autocalibration_status_gyro.dev_attr.attr,
> +       &iio_dev_attr_in_autocalibration_status_magn.dev_attr.attr,
> +       &iio_dev_attr_in_calibration_data.dev_attr.attr,
> +       NULL,

No comma for terminator line.

...

> +/*
> + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> + * and applies mask to cull (skip) unneeded samples.
> + * Updates buf_idx incrementing with the number of stored samples.
> + * Samples from HW are xferred into buf, then in-place copy on buf is

transferred

> + * performed in order to cull samples that need to be skipped.
> + * This avoids copies of the first samples until we hit the 1st sample to skip,
> + * and also avoids having an extra bounce buffer.
> + * buf must be able to contain len elements inspite of how many samples we are

in spite of

> + * going to cull.
> + */

...


> +       /* All chans are made up 1 16bit sample, except for quaternion

16-bit

Multi-line comment style. And be consistent!

> +        * that is made up 4 16-bit values.
> +        * For us the quaternion CH is just like 4 regular CHs.
> +        * If out read starts past the quaternion make sure to adjust the
> +        * starting offset; if the quaternion is contained in our scan then
> +        * make sure to adjust the read len.

Your lines here like a drunk person. use the space more monotonically.

> +        */

...

> +               n = ((start_ch + i) == BNO055_SCAN_QUATERNION) ? 4 : 1;

Too many parentheses.

...

> +                       for (j = 0; j < n; j++)
> +                               dst[j] = src[j];

NIH memcpy()

...

> +               __le16 chans[(BNO055_GRAVITY_DATA_Z_LSB_REG -
> +                             BNO055_ACC_DATA_X_LSB_REG) / 2];

Can you define separately what's inside square brackets?

...

> +       while (!finish) {
> +               end = find_next_zero_bit(iio_dev->active_scan_mask,
> +                                        iio_dev->masklength, start);
> +               if (end == iio_dev->masklength) {
> +                       finish = true;

NIH for_each_clear_bit().

> +               } else {
> +                       next = find_next_bit(iio_dev->active_scan_mask,
> +                                            iio_dev->masklength, end);
> +                       if (next == iio_dev->masklength) {
> +                               finish = true;

Ditto.

> +                       } else {
> +                               quat = ((next > BNO055_SCAN_QUATERNION) &&
> +                                       (end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;
> +                               thr_hit = (next - end + quat) >
> +                                       priv->xfer_burst_break_thr;
> +                       }
> +               }
> +
> +               if (thr_hit || finish) {
> +                       mask = *iio_dev->active_scan_mask >> xfer_start;
> +                       ret = bno055_scan_xfer(priv, xfer_start,
> +                                              end - xfer_start,
> +                                              mask, buf.chans, &buf_idx);
> +                       if (ret)
> +                               goto done;
> +                       xfer_start = next;
> +               }
> +               start = next;
> +       }

...

> +       /* base name + separator + UID + ext + zero */
> +       char fw_name_buf[sizeof(BNO055_FW_NAME BNO055_FW_EXT) +
> +                        BNO055_UID_LEN * 2 + 1 + 1];

Perhaps devm_kasprintf()?

...

> +       memset(priv, 0, sizeof(*priv));

Why?!

...

> +       if (IS_ERR(rst) && (PTR_ERR(rst) != -EPROBE_DEFER)) {
> +               dev_err(dev, "Failed to get reset GPIO");
> +               return PTR_ERR(rst);
> +       }

  if (IS_ERR(...))
    return dev_err_probe(...);

...

> +       if (IS_ERR(priv->clk) && (PTR_ERR(priv->clk) != -EPROBE_DEFER)) {
> +               dev_err(dev, "Failed to get CLK");
> +               return PTR_ERR(priv->clk);
> +       }

Ditto.

...

> +       clk_prepare_enable(priv->clk);

Missed clk_disabled_unprepare() from all below error paths.
Use devm_add_action_or_reset() approach.

...

> +       dev_dbg(dev, "Found BMO055 chip");

Useless noise and LOC.

...

> +       dev_info(dev, "unique ID: %*ph", BNO055_UID_LEN, priv->uid);

Can it be printed somewhere together with firmware revision?

...

> +       sprintf(fw_name_buf, BNO055_FW_NAME "-%*phN" BNO055_FW_EXT,

Simply define a format string as FW_FMT somewhere above and use it here.

> +               BNO055_UID_LEN, priv->uid);

...

> +               dev_notice(dev, "Failed to load calibration data firmware file; this has nothing to do with IMU main firmware.");
> +               dev_notice(dev, "You can calibrate your IMU (look for 'in_autocalibration_status*' files in sysfs) and then copy 'in_calibration_data' to your firmware file");

'\n' exists on purpose.

...

> +#include <linux/device.h>

No user of this.

> +#include <linux/regmap.h>
> +
> +int bno055_probe(struct device *dev, struct regmap *regmap, int irq,
> +                int xfer_burst_break_thr);
> +extern const struct regmap_config bno055_regmap_config;

-- 
With Best Regards,
Andy Shevchenko
