Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D82B3CB52E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhGPJWk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhGPJWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 05:22:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4169C06175F;
        Fri, 16 Jul 2021 02:19:43 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a127so8397528pfa.10;
        Fri, 16 Jul 2021 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=I6EOkZlKA6CqR4vf+tKZO75Xy0O5qyO6l8kSx38oX8k=;
        b=UJ3iHayZhKn+h3JfJgY2UIfQpbbLrqQgYS6KzMIUAEe0hN5FqI7tuHZLVagwiGNNbt
         3JTA2qxg8z6vuh0uRoLY3WJ/2lPKF626mTkBnlD5okxQM9JCbCaXPMv0twAnccKFA5Y+
         Vb4QNHCOSNSksCGEdBRsUAQYMoChBqqIXycUyiF8o5x3ue3adb4JztxVpUdZVRYsFyRx
         fVF/CqXsJcQjBKafdoN9vAOEn2fD6YojWvc4WNPZrEcrQD7lZLtfFKCS8oVRJhsJiboj
         Wt0+vnOnRPnsTKXE1X732BS9CT/dVaJX6srECqgwI5IO83sqwswzAgElT4eGReyjuJEH
         GLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=I6EOkZlKA6CqR4vf+tKZO75Xy0O5qyO6l8kSx38oX8k=;
        b=MG3KfpKk5pKEVjPzO3R2wrLpDFAR8r1lK3ZgNS/xNrUqrNg2YK3Ef0kKtUoBkwbqVp
         +1aDU0H0Ul6vm1PRci8r4LJNnS2KQyScdQ1Qwe8IX1kYmgw08W9IDsuFjhAQT3Z5VrVW
         k9HeBjtyO6riLBuyUTpDcKJk7naal1Yoyw5sgf9TUvQ2Eezwju4pxaHJczobY8LjKjS6
         pbKw8Tpye8hasZsTM4Y816v9CYGvX93GT+kt8NqEy5kQfC1bL1xMA6UzyHkmS1O3Q2II
         +4YNIYRpXh+TveXpeGSzTelMgyptKg097Uu+gm1BSahnrwNgFNID4lS8nhd8etEO6Tez
         +YUA==
X-Gm-Message-State: AOAM532u6ZENDzhxb/aSz5Pm28J0G6/ImNO3WZTzqrrIrnNdFZhGReC6
        wYA8A99aOmBSEbaTZvPWm7bfvO+VxnKEXuE/o1LQkLrDdxUI7A==
X-Google-Smtp-Source: ABdhPJz+1hPHltO+F7H5Agd9lq/luNwj+IYejCY0j8RmZQSwelyDAG1tTd5sgjKSDIupofP6r06cGW9NQ5VvLC4v6iY=
X-Received: by 2002:a63:5946:: with SMTP id j6mr9219667pgm.0.1626427183305;
 Fri, 16 Jul 2021 02:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
In-Reply-To: <CAHp75Vf_Og2wjRy2j0gC37DgR0x9B_F5iSUj8VOtWkhWjgiOag@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 16 Jul 2021 11:19:31 +0200
Message-ID: <CAN8YU5NKGLO6a4wqaW07NAU-OdsdBohoXzMCBcskaFsCRtrGhw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        andriy.shevchenko@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 15 lug 2021 alle ore 18:50 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Thu, Jul 15, 2021 at 5:21 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > can be connected via both serial and I2C busses; separate patches will
> > add support for them.
> >
> > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > that provides raw data from the said internal sensors, and a couple of
> > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > euler angles, quaternions, linear acceleration and gravity measurements).
> >
> > In fusion modes the AMG data is still available (with some calibration
> > refinements done by the IMU), but certain settings such as low pass
> > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > they can be customized; this is why AMG mode can still be interesting.
>
> ...
>
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > Cc: Andrea Merello <andrea.merello@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
>
> Instead of polluting commit messages with this, use --to and --cc
> parameters. You may utilize my script [1] which finds automatically to
> whom to send (of course it allows manually to add more).
>
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

I thought it was a good & widespread practice, sorry. Will drop from
future series respin.

> ...
>
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# driver for Bosh bmo055
>
> Driver
>
> Point of this comment actually is ..?

IMO None :) I just saw other drivers do have a comment like this one,
so I did the same.. I'll drop these also.

> ...
>
> > +# Makefile for bosh bno055
>
> Ditto.
>
> ...
>
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Is it the correct one, looking at the portions taken from other drivers?

Looks like cut-n-paste mistake, sorry; I need to drop "or-later" part.
Thanks for pointing this out.

> > +/*
> > + * IIO driver for Bosh BNO055 IMU
> > + *
> > + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> > + * Electronic Design Laboratory
> > + * Written by Andrea Merello <andrea.merello@iit.it>
> > + *
> > + * Portions of this driver are taken from the BNO055 driver patch
> > + * from Vlad Dogaru which is Copyright (c) 2016, Intel Corporation.
> > + *
> > + * This driver is also based on BMI160 driver, which is:
> > + *     Copyright (c) 2016, Intel Corporation.
> > + *     Copyright (c) 2019, Martin Kelly.
> > + */
>
> ...
>
> > +#include <linux/clk.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/sysfs.h>
>
> Can you move this group to...
>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/util_macros.h>
>
> ...be here?

OK

> > +#include "bno055.h"
>
> ...
>
> > +#define BNO055_CALIB_STAT_MASK 3
>
> GENMASK()

OK

> ...
>
> > +#define BNO055_UNIT_SEL_ANDROID BIT(7)
>
> Android? What does this mean?

Sensors support the so-called "Android" and "Windows" modes. They
differs about pitch direction (CW vs CCW). I'd like to stick close to
the datasheet names, but I can add a comment here.

> ...
>
> > +#define BNO055_CALDATA_LEN (BNO055_CALDATA_END - BNO055_CALDATA_START + 1)
>
> Can you put just a plain number?

OK

> ...
>
> > +#define BNO055_ACC_CONFIG_LPF_MASK 0x1C
>
> GENMASK() here and everywhere where it makes sense.

OK.

> ...
>
> > +#define BNO055_UID_LEN (0xF)
>
> Useless parentheses. If the LEN is a plain number, use decimal, if
> it's limited by register width, use the form of (BIT(x) - 1). In such
> a case it's easy to see how many bits are used for it.

It's byte number, defined by how many 8-bits registers make up the
UID. I'll go for a decimal and I'll drop the parentheses.

> ...
>
> > +       int i;
> > +       int best_idx, best_delta, delta;
> > +       int first = 1;
>
> Use reversed xmas tree order.

Looks like the kernel code is plenty of declarations in random order,
neither I can find any clue about this in coding-style.rst. Where does
this come from?

If that's mandatory then I'll do. If that's about a mere preference,
then I honestly prefer to put all declaration-plus-initialization
after all declarations-olny (but I can use reversed xmas tree order
inside each block, if you want).

>
> > +       for (i = 0; i < len; i++) {
> > +               delta = abs(arr[i] - val);
> > +               if (first || delta < best_delta) {
> > +                       best_delta = delta;
> > +                       best_idx = i;
> > +               }
> > +               first = 0;
> > +       }
>
> I think I saw this kind of snippet for the 100th time. Can it be
> factored out to some helper and used by everyone?

I can try to macroize this function and move it to util_macros.h

> ...
>
> > +       if ((reg >= 0x8 && reg <= 0x3A) ||
>
> Use names instead of values here and in similar places elsewhere.

When I wrote this, I was actually unsure about which is best :) Do you
have a strong opinion on this?

My point:
Most of this is just about register areas, which are bounded by
addresses - register meaning is of no interest here. Using numerical
addresses here IMO is a little advantageous because it is at least
clear which is the greatest number, and it is less prone to swapping
by mistake start/end registers vrt greater-than/lesser-than comparison
operators.

It's still true that when comparing address against a specific
register address (e.g. reg == BNO055_MAG_CONFIG_REG) there is no
advantage in using numerical addresses, and it can be better to use
names (because e.g. you simply know that specific register is
volatile).

> > +           /* when in fusion mode, config is updated by chip */
> > +           reg == BNO055_MAG_CONFIG_REG ||
> > +           reg == BNO055_ACC_CONFIG_REG ||
> > +           reg == BNO055_GYR_CONFIG_REG ||
> > +           (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END))
>
> Please, split this to 3 or more conditionals that are easier to read
> (logically separated).
> Same comment to the rest of the similar functions.

Do you mean splitting into separate if statements? OK.

> ...
>
> > +               .selector_mask = 0xff,
>
> GENMASK() ?

OK

> ...
>
> > +       if (res && res != -ERESTARTSYS) {
>
> Shouldn't RESTARTSYS be handled on a regmap level?

Can you please elaborate on this?

> ...
>
> > +/* must be called in configuration mode */
> > +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> > +{
> > +       int i;
> > +       unsigned int tmp;
> > +       u8 cal[BNO055_CALDATA_LEN];
> > +       int read, tot_read = 0;
> > +       int ret = 0;
> > +       char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> > +
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       memcpy(buf, fw->data, fw->size);
>
> kmemdup() ?

Ah, OK

>
> > +       buf[fw->size] = '\0';
>
> > +       for (i = 0; i < BNO055_CALDATA_LEN; i++) {
> > +               ret = sscanf(buf + tot_read, "%x%n",
> > +                            &tmp, &read);
> > +               if (ret != 1 || tmp > 0xff) {
> > +                       ret = -EINVAL;
> > +                       goto exit;
> > +               }
> > +               cal[i] = tmp;
> > +               tot_read += read;
> > +       }
>
> Sounds like NIH hex2bin().

Indeed.. I've failed to find out this helper. Looking at the code it
seems it wouldn't work as drop-in replacement here, because of spaces
in the HEX string. But I might just decide to format the HEX string
without spaces in order to being able to use hex2bin().

>
> > +       dev_dbg(priv->dev, "loading cal data: %*ph", BNO055_CALDATA_LEN, cal);
> > +       ret = regmap_bulk_write(priv->regmap, BNO055_CALDATA_START,
> > +                               cal, BNO055_CALDATA_LEN);
> > +exit:
> > +       kfree(buf);
> > +       return ret;
> > +}
>
> ...
>
> > +       int ret = bno055_reg_read(priv, reg, &hwval);
> > +
> > +       if (ret)
> > +               return ret;
>
> In all cases (esp. when resource allocations are involved) better to use
>
> int ret;
>
> ret = func();
> if (foo)
>   return ret;

OK (assuming you meant if(ret) actually)

> ...
>
> > +       dev_dbg(priv->dev, "WR config - reg, mask, val: 0x%x, 0x%x, 0x%x",
> > +               reg, mask, hwval);
>
> Why? Enable regmap trace events for this and drop these unneeded prints.

Good point. Going to drop it.

> ...
>
> > +       __le16 raw_val;
>
> > +               ret = regmap_bulk_read(priv->regmap, chan->address,
> > +                                      &raw_val, 2);
>
> sizeof(raw_val)
>
> and everywhere where similar cases are.

OK

> > +               if (ret < 0)
> > +                       return ret;
>
> ...
>
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               if (chan->type == IIO_MAGN)
> > +                       return bno055_get_mag_odr(priv, val, val2);
> > +               else
> > +                       return -EINVAL;
>
> Use usual pattern
>
>   if (!cond)
>    return ERRNO;
>   ...
>   return bar;
>

OK

>
>
> > +               for (i = 0; i < 4; i++)
> > +                       vals[i] = (s16)le16_to_cpu(raw_vals[i]);
>
> Extract this to be a helper like there are for u32 and u64.

Could you please point me to those helpers? I don't know what you are
referring to.

> ...
>
> > +               vals[1] = 1 << 14;
>
> BIT(14) But still magic.

Why magic? there is a comment a few line above explaining this - maybe
I can move it a couple of LOCs below. And BTW conceptually it is about
math (2^14), it has nothing to do with BITs.

> ...
> > +               switch (mask) {
> > +               case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +                       return bno055_set_gyr_lpf(priv, val, val2);
>
> default?

Ah, right.

> > +               }
>
> ...
>
> > +       struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                        (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "20" :
> > +                        "2 6 8 10 15 20 25 30");
>
> IIO core should do this, besides the fact that it must use sysfs_emit().
> Ditto for the similar.

Ok for sysfs_emit(), thanks. But what do you mean with "IIO core
should do this"? Can you please elaborate?

> ...
>
> > +       if (sysfs_streq(buf, "amg"))
> > +               priv->operation_mode = BNO055_OPR_MODE_AMG;
> > +       else if (sysfs_streq(buf, "fusion"))
> > +               priv->operation_mode = BNO055_OPR_MODE_FUSION;
> > +       else if (sysfs_streq(buf, "fusion_fmc_off"))
> > +               priv->operation_mode = BNO055_OPR_MODE_FUSION_FMC_OFF;
> > +       else
> > +               return -EINVAL;
>
> Wondering if you may use sysfs_match_string().

Ah, yes. I'll probably need a local array for the various
BNO055_OPR_MODE_* and then I can index it with sysfs_match_string()
return value.

> ...
>
> > +       return res ? res : len;
>
> ret, res, ... Be consistent!

Sure; you're right

> Besides that the form
>
>   return ret ?: len;
>
> is shorter and better.
>

OK

> ...
>
>
> > +       static const char * const calib_status[] = {"bad", "barely enough",
> > +                                                  "fair", "good"};
>
> Please use better indentation
>
>     static char ... foo[] = {
>         { a, b, c, d, }
>     };
>

OK, but why nested parentheses?

>
> > +       for (size = 0, i = 0; i < BNO055_CALDATA_LEN; i++) {
> > +               ret = scnprintf(buf + size,
> > +                               PAGE_SIZE - size, "%02x%c", data[i],
> > +                               (i + 1 < BNO055_CALDATA_LEN) ? ' ' : '\n');
> > +               if (ret < 0)
> > +                       return ret;
> > +               size += ret;
> > +       }
>
> And if it's more than 4/3 kBytes (binary)?

It's few bytes long (binary)

> Isn't it better to use the request_firmware() interface or something similar?

No: I already use request_firmware() for getting the initial
calibration data (if any), but the IMU sometimes (re)calibrates. This
function is for getting current IMU calibration, so we need to read it
from registers (especially you want to get it the 1st time, in order
to create the calibration file that request_firmware() will fetch next
time you boot).

> If IIO doesn't provide the common attributes for this it probably
> should and it has to be a binary one.

I couldn't find anything for it. I wasn't sure whether exposing
calibration data using IIO attribute is something that other drivers
might need to do, hence whether it could make sense to make it generic
or not.. I wasn't even sure that an IIO attribute is the right place
to expose it, indeed :)

> ...
>
> > +static IIO_DEVICE_ATTR_RO(in_magn_sampling_frequency_available,
> > +                         0);
>
> Definitely one line.

OK

> ...
>
>
> > +       &iio_dev_attr_in_autocalibration_status_gyro.dev_attr.attr,
> > +       &iio_dev_attr_in_autocalibration_status_magn.dev_attr.attr,
> > +       &iio_dev_attr_in_calibration_data.dev_attr.attr,
> > +       NULL,
>
> No comma for terminator line.

OK

> ...
>
> > +/*
> > + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> > + * and applies mask to cull (skip) unneeded samples.
> > + * Updates buf_idx incrementing with the number of stored samples.
> > + * Samples from HW are xferred into buf, then in-place copy on buf is
>
> transferred

OK

> > + * performed in order to cull samples that need to be skipped.
> > + * This avoids copies of the first samples until we hit the 1st sample to skip,
> > + * and also avoids having an extra bounce buffer.
> > + * buf must be able to contain len elements inspite of how many samples we are
>
> in spite of

OK

> > + * going to cull.
> > + */
>
> ...
>
>
> > +       /* All chans are made up 1 16bit sample, except for quaternion
>
> 16-bit

OK

>
> Multi-line comment style. And be consistent!

OK

> > +        * that is made up 4 16-bit values.
> > +        * For us the quaternion CH is just like 4 regular CHs.
> > +        * If out read starts past the quaternion make sure to adjust the
> > +        * starting offset; if the quaternion is contained in our scan then
> > +        * make sure to adjust the read len.
>
> Your lines here like a drunk person. use the space more monotonically.

Do you mean: Assuming you are sticking to the old 80-cols-long lines
(which is still do, unless in few cases), then some lines still have
room for more words, and you could reflow the text ?

> > +        */
>
> ...
>
> > +               n = ((start_ch + i) == BNO055_SCAN_QUATERNION) ? 4 : 1;
>
> Too many parentheses.

OK

> ...
>
> > +                       for (j = 0; j < n; j++)
> > +                               dst[j] = src[j];
>
> NIH memcpy()

Right.

> ...
>
> > +               __le16 chans[(BNO055_GRAVITY_DATA_Z_LSB_REG -
> > +                             BNO055_ACC_DATA_X_LSB_REG) / 2];
>
> Can you define separately what's inside square brackets?

OK

> ...
>
> > +       while (!finish) {
> > +               end = find_next_zero_bit(iio_dev->active_scan_mask,
> > +                                        iio_dev->masklength, start);
> > +               if (end == iio_dev->masklength) {
> > +                       finish = true;
>
> NIH for_each_clear_bit().

Not sure it is convenient to use for_each_clear_bit(): Here we're
searching for contiguous blocks of set-bits, and we only want indexes
of first and last set-bit in a block; alternate calls to
find_next_zero_bit() and find_next_bit() seem appropriate here to me.

Do you have in mind a better/simpler implementation using or_each_clear_bit() ?


> > +               } else {
> > +                       next = find_next_bit(iio_dev->active_scan_mask,
> > +                                            iio_dev->masklength, end);
> > +                       if (next == iio_dev->masklength) {
> > +                               finish = true;
>
> Ditto.

see above.

>
> > +                       } else {
> > +                               quat = ((next > BNO055_SCAN_QUATERNION) &&
> > +                                       (end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;
> > +                               thr_hit = (next - end + quat) >
> > +                                       priv->xfer_burst_break_thr;
> > +                       }
> > +               }
> > +
> > +               if (thr_hit || finish) {
> > +                       mask = *iio_dev->active_scan_mask >> xfer_start;
> > +                       ret = bno055_scan_xfer(priv, xfer_start,
> > +                                              end - xfer_start,
> > +                                              mask, buf.chans, &buf_idx);
> > +                       if (ret)
> > +                               goto done;
> > +                       xfer_start = next;
> > +               }
> > +               start = next;
> > +       }
>
> ...
>
> > +       /* base name + separator + UID + ext + zero */
> > +       char fw_name_buf[sizeof(BNO055_FW_NAME BNO055_FW_EXT) +
> > +                        BNO055_UID_LEN * 2 + 1 + 1];
>
> Perhaps devm_kasprintf()?

Wouldn't this keep the buffer allocated until the device is removed?
We just need this buffer while probing.

> ...
>
> > +       memset(priv, 0, sizeof(*priv));
>
> Why?!

IIRC a leftover from a time in which nothing worked and I was doubting
about priv being really zeroed at allocation time. Will remove..

> ...
>
> > +       if (IS_ERR(rst) && (PTR_ERR(rst) != -EPROBE_DEFER)) {
> > +               dev_err(dev, "Failed to get reset GPIO");
> > +               return PTR_ERR(rst);
> > +       }
>
>   if (IS_ERR(...))
>     return dev_err_probe(...);

Sure; I never saw this before, but it looks good.

> ...
>
> > +       if (IS_ERR(priv->clk) && (PTR_ERR(priv->clk) != -EPROBE_DEFER)) {
> > +               dev_err(dev, "Failed to get CLK");
> > +               return PTR_ERR(priv->clk);
> > +       }
>
> Ditto.

Sure

> ...
>
> > +       clk_prepare_enable(priv->clk);
>
> Missed clk_disabled_unprepare() from all below error paths.
> Use devm_add_action_or_reset() approach.

I indeed use devm_add_action_or_reset(), and clock is disabled and
unprepared in its action callback (but snooping in Alexandru's
comments in next mail I see there is still something to be addressed
about this).

> ...
>
> > +       dev_dbg(dev, "Found BMO055 chip");
>
> Useless noise and LOC.

Will drop it.

> ...
>
> > +       dev_info(dev, "unique ID: %*ph", BNO055_UID_LEN, priv->uid);
>
> Can it be printed somewhere together with firmware revision?

Yes, I can group those two prints.

> ...
>
> > +       sprintf(fw_name_buf, BNO055_FW_NAME "-%*phN" BNO055_FW_EXT,
>
> Simply define a format string as FW_FMT somewhere above and use it here.

OK (but BNO055_FW_NAME and BNO055_FW_EXT contribute to build up two
different strings, so they will not go away, rather they will be used
in both FW_FMT and the other one definitions)

> > +               BNO055_UID_LEN, priv->uid);
>
> ...
>
> > +               dev_notice(dev, "Failed to load calibration data firmware file; this has nothing to do with IMU main firmware.");
> > +               dev_notice(dev, "You can calibrate your IMU (look for 'in_autocalibration_status*' files in sysfs) and then copy 'in_calibration_data' to your firmware file");
>
> '\n' exists on purpose.

Ah, I initially did that, but IIRC I saw a bad-looking indentation or
something like that in my kernel log while using "\n".. Then I just
forgot about this.. I'll try again with "\n"..

> ...
>
> > +#include <linux/device.h>
>
> No user of this.

Will drop this

> > +#include <linux/regmap.h>
> > +
> > +int bno055_probe(struct device *dev, struct regmap *regmap, int irq,
> > +                int xfer_burst_break_thr);
> > +extern const struct regmap_config bno055_regmap_config;
>
> --
> With Best Regards,
> Andy Shevchenko
