Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2868F150819
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 15:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgBCOLF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 09:11:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40735 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgBCOLF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 09:11:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so7638083pfh.7;
        Mon, 03 Feb 2020 06:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRQ1hHCz0CeKY1g3DDbbp7TdDivpaRH+PNik/agQaN8=;
        b=CgUTpKQDyVzPKohmcbd6EQ1W/9fcgDkJ0t7n2ZT7j4gnVZKe1P2qsGKBupYKbCkuKS
         i8mi0ukGCyD6qJCo4wW8fuByob5g+UWRCDfesJOu9IaCDKg46oinWy/aOmiiD5tZ2lPU
         kRKAt9TL6GSnzf6w4oFwnOR7/Bcc3RGZPSPQnEif8gNKWg0H7aEaHJDRNuK4iOHGxdd2
         S6NIJaZXbRre+qWgZbpi7nOA/DNhuMAFpGuYs3j9pLETwhuEBeoy6A5hJETe+eouSS2X
         zWNDPVta4jxRnbhB/pJOM2+7L2zheIBwry4100Jb7Z/23vsQvSTmU3TV4T4F0ECpLiwL
         XE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRQ1hHCz0CeKY1g3DDbbp7TdDivpaRH+PNik/agQaN8=;
        b=OHXBuleKu20GgWwmDNnBzJMISaf3PTdHqr6YfimEPoPLxfFYKvuQervFxpQQ0doXTf
         nyo8bvCANnPWQEYEkDmv4iyAFE1874UkQo4X1NRDfl1lzjYAWjkETw82MktSN76XR/59
         UkcUQB7bFJ4ix0molKEBcsnJ+q7jXUK0JA2Kw+rd4+HqcYaJgQLPEYSwM3oS9jQ6b6sd
         dcQEVvyMrmnKY3Thm0f0namRyEakQob2iePeKZmaV10Io2pVcfa09j4HwQCnZD2w5gzK
         SXhsO5Lp1B71mPJrJvb6EHKHHHXvU1/+I2TOUztX8SAN1u2ECALeaBD8we8/Q9xbFeWX
         6C0Q==
X-Gm-Message-State: APjAAAWqsqyuVwY4Nf5uk/S6gsD9G5DGxevw0fGZqP7XGRucWUcWO6PR
        U0nrqMvTE7Lb3Onld8MiOUtUhlh6OXFjeRxYnjU=
X-Google-Smtp-Source: APXvYqwZTAYrbILCWu7y5BTJeqPAPB1rFBskSHBcp7ocuAG5TDt9SRxEU6oafx3Hpm1Q4UJT5GMI/qeDOmgTlPzMVio=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr25064930pfa.64.1580739063957;
 Mon, 03 Feb 2020 06:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20200128111302.24359-1-alexandru.ardelean@analog.com>
 <20200202144549.3209f04b@archlinux> <9f7217403fc2e69934eded4502d39198c2427806.camel@analog.com>
In-Reply-To: <9f7217403fc2e69934eded4502d39198c2427806.camel@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 16:10:55 +0200
Message-ID: <CAHp75Vfc9OeubEGUPrMzKwhWeC1D1rziatARYCFkXy07dNZK_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: frequency: adf4360: Add support for ADF4360 PLLs
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "ekigwana@gmail.com" <ekigwana@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 3, 2020 at 1:47 PM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
> On Sun, 2020-02-02 at 14:45 +0000, Jonathan Cameron wrote:
> > On Tue, 28 Jan 2020 13:13:00 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

Just few comments on the code in case either this will go, or to teach
an author about best practices in LK.

> > > +#include <linux/err.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/util_macros.h>

...

> > > +enum {
> > > +   ADF4360_CTRL,
> > > +   ADF4360_RDIV,
> > > +   ADF4360_NDIV,

> > > +   ADF4360_REG_NUM,

Sounds line no need for comma (is it indeed a terminator line?).

> > > +};

...

> > > +static int adf4360_write_reg(struct adf4360_state *st, unsigned int reg,
> > > +                        unsigned int val)
> > > +{
> > > +   int ret;
> > > +
> > > +   val |= reg;

This is dangerous. Shouldn't be some mask applied?

> > > +   st->spi_data[0] = (val >> 16) & 0xff;
> > > +   st->spi_data[1] = (val >> 8) & 0xff;
> > > +   st->spi_data[2] = val & 0xff;

All ' & 0xff' are redundant.

> > > +   ret = spi_write(st->spi, st->spi_data, ARRAY_SIZE(st->spi_data));
> > > +   if (ret == 0)
> > > +           st->regs[reg] = val;
> > > +
> > > +   return ret;

Please, use pattern:
  if (ret)
    return ret;

  ...
  return 0;

> > > +}

...

> > > +static unsigned int adf4360_calc_prescaler(unsigned int pfd_freq,
> > > +                                      unsigned int n,
> > > +                                      unsigned int *out_p,
> > > +                                      unsigned int *out_a,
> > > +                                      unsigned int *out_b)
> > > +{
> > > +   unsigned int rate = pfd_freq * n;
> > > +   unsigned int p, a, b;
> > > +
> > > +   /* Make sure divider counter input frequency is low enough */
> > > +   p = 8;
> > > +   while (p < 32 && rate / p > ADF4360_MAX_COUNTER_RATE)
> > > +           p *= 2;
> > > +
> > > +   /*
> > > +    * The range of dividers that can be produced using the dual-modulus
> > > +    * pre-scaler is not continuous for values of n < p*(p-1). If we end up
> > > +    * with a non supported divider value, pick the next closest one.
> > > +    */
> > > +   a = n % p;
> > > +   b = n / p;

You may avoid divisions if you use shifts.
Currently it's a bit hard to compiler to prove that p is power of 2.

> > > +   if (b < 3) {
> > > +           b = 3;
> > > +           a = 0;
> > > +   } else if (a > b) {

Does this guarantee p >= a?

> > > +           if (a - b < p - a) {
> > > +                   a = b;
> > > +           } else {
> > > +                   a = 0;
> > > +                   b++;
> > > +           }
> > > +   }

I guess above conditional tree can be a bit improved, although I don't
see right now in what way.

> > > +   return p * b + a;
> > > +}

...

> > > +   /* ADF4360-0 to AD4370-7 have an optional by two divider */
> > > +   if (st->part_id <= ID_ADF4360_7) {
> > > +           if (rate < st->vco_min / 2)
> > > +                   return st->vco_min / 2;
> > > +           if (rate < st->vco_min && rate > st->vco_max / 2) {
> > > +                   if (st->vco_min - rate < rate - st->vco_max / 2)
> > > +                           return st->vco_min;

> > > +                   else

Redundant.

> > > +                           return st->vco_max / 2;
> > > +           }

> > > +   } else {
> > > +           if (rate < st->vco_min)

} else if (...) {

> > > +                   return st->vco_min;
> > > +   }

...

> > > +   case ADF4360_POWER_DOWN_REGULATOR:
> > > +           if (!st->vdd_reg)
> > > +                   return -ENODEV;
> > > +
> > > +           if (st->chip_en_gpio)
> > > +                   ret = __adf4360_power_down(st, ADF4360_POWER_DOWN_CE);
> > > +           else
> > > +                   ret = __adf4360_power_down(st,
> > > +                                           ADF4360_POWER_DOWN_SOFT_ASYNC);

Missed error check.

> > > +
> > > +           ret = regulator_disable(st->vdd_reg);
> > > +           if (ret)
> > > +                   dev_err(dev, "Supply disable error: %d\n", ret);
> > > +           break;
> > > +   }

...

> > > +   if (ret == 0)
> > > +           st->power_down_mode = mode;
> > > +
> > > +   return 0;

Looks like 'return ret;' but see one comment at the beginning of the letter.

...

> > > +static ssize_t adf4360_read(struct iio_dev *indio_dev,
> > > +                       uintptr_t private,
> > > +                       const struct iio_chan_spec *chan,
> > > +                       char *buf)
> > > +{
> > > +   struct adf4360_state *st = iio_priv(indio_dev);
> > > +   unsigned long val;

> > > +   int ret = 0;

Redundant variable.

> > > +
> > > +   switch ((u32)private) {
> > > +   case ADF4360_FREQ_REFIN:
> > > +           val = st->clkin_freq;
> > > +           break;
> > > +   case ADF4360_MTLD:
> > > +           val = st->mtld;
> > > +           break;
> > > +   case ADF4360_FREQ_PFD:
> > > +           val = st->pfd_freq;
> > > +           break;
> > > +   default:
> > > +           ret = -EINVAL;
> > > +           val = 0;
> > > +   }
> > > +
> > > +   return ret < 0 ? ret : sprintf(buf, "%lu\n", val);
> > > +}

...

> > > +static ssize_t adf4360_write(struct iio_dev *indio_dev,
> > > +                        uintptr_t private,
> > > +                        const struct iio_chan_spec *chan,
> > > +                        const char *buf, size_t len)
> > > +{
> > > +   struct adf4360_state *st = iio_priv(indio_dev);
> > > +   unsigned long readin, tmp;
> > > +   bool mtld;
> > > +   int ret = 0;
> > > +
> > > +   mutex_lock(&st->lock);
> > > +   switch ((u32)private) {

Strange casting. Why?

> > > +           if ((readin > ADF4360_MAX_REFIN_RATE) || (readin == 0)) {

Too many parentheses.

> > > +                   ret = -EINVAL;
> > > +                   break;
> > > +           }
> > > +
> > > +           if (st->clkin) {
> > > +                   tmp = clk_round_rate(st->clkin, readin);
> > > +                   if (tmp != readin) {
> > > +                           ret = -EINVAL;
> > > +                           break;
> > > +                   }
> > > +
> > > +                   ret = clk_set_rate(st->clkin, tmp);
> > > +                   if (ret)
> > > +                           break;
> > A bit odd to directly provide an interface to control and entirely different
> > bit of hardware.   If there are specific demands on the input clock as a
> > result
> > of something to do with the outputs, then fair enough.  Direct tweaking like
> > this seems like a very odd interface.
> >
> > > +           }
> > > +
> > > +           st->clkin_freq = readin;
> > > +           break;

> > > +   case ADF4360_FREQ_PFD:
> > > +           ret = kstrtoul(buf, 10, &readin);
> > > +           if (ret)
> > > +                   break;
> > > +


> > > +           if ((readin > ADF4360_MAX_PFD_RATE) || (readin == 0)) {

Ditto.

> > > +                   ret = -EINVAL;
> > > +                   break;
> > > +           }
> > > +
> > > +           st->pfd_freq = readin;
> > > +           break;
> > > +   default:
> > > +           ret = -EINVAL;

Nevertheless 'break;' is good to have even here.

> > > +   }

> > > +
> > > +   if (ret == 0)

Maybe this, or maybe

  if (ret)
    goto out_unlock;

> > > +           ret = adf4360_set_freq(st, st->freq_req);
> > > +   mutex_unlock(&st->lock);
> > > +
> > > +   return ret ? ret : len;
> > > +}

...

> > > +   int ret = 0;

Redundant assignment.

> > > +   mutex_lock(&st->lock);
> > > +   writeval = st->regs[ADF4360_CTRL] & ~ADF4360_ADDR_MUXOUT_MSK;
> > > +   writeval |= ADF4360_MUXOUT(mode & 0x7);
> > > +   ret = adf4360_write_reg(st, ADF4360_REG(ADF4360_CTRL), writeval);

> > > +   if (ret == 0)
> > > +           st->muxout_mode = mode & 0x7;
> > > +   mutex_unlock(&st->lock);

Similar comment to the return check style as above.

> > > +   return ret;
> > > +}

...

> > > +static const struct iio_chan_spec_ext_info adf4360_ext_info[] = {

> > > +   IIO_ENUM("power_level", false, &adf4360_pwr_lvl_modes_available),
> > > +   { },

No need to have comma for terminator line.

> > > +};

...

> > > +   struct adf4360_state *st = iio_priv(indio_dev);
> > > +   bool lk_det;
> > > +
> > > +   switch (mask) {
> > > +   case IIO_CHAN_INFO_FREQUENCY:
> > > +           if (adf4360_is_powerdown(st))
> > > +                   return -EBUSY;
> > > +
> > > +           lk_det = (ADF4360_MUXOUT_LOCK_DETECT | ADF4360_MUXOUT_OD_LD) &
> > > +                    st->muxout_mode;
> > > +           if (lk_det && st->muxout_gpio) {
> > > +                   if (!gpiod_get_value(st->muxout_gpio)) {
> > > +                           dev_dbg(&st->spi->dev, "PLL un-locked\n");
> > > +                           return -EBUSY;
> > > +                   }
> > > +           }
> > > +
> > > +           *val = st->freq_req;

> > > +           return IIO_VAL_INT;
> > > +   default:
> > > +           return -EINVAL;
> > > +   }

> > > +
> > > +   return 0;

How this is possible?

...

> > > +   default:
> > > +           ret = -EINVAL;

break;

...

> > > +   struct adf4360_state *st = iio_priv(indio_dev);

> > > +   int ret = 0;

Would be better to have this assignment...

> > > +
> > > +   if (reg >= ADF4360_REG_NUM)
> > > +           return -EFAULT;
> > > +
> > > +   mutex_lock(&st->lock);
> > > +   if (readval) {
> > > +           *readval = st->regs[reg];

...here.

> > > +   } else {
> > > +           writeval &= 0xFFFFFC;

What this magic does? Make a define using GENMASK().

> > > +           ret = adf4360_write_reg(st, reg, writeval);
> > > +   }
> > > +   mutex_unlock(&st->lock);
> > > +
> > > +   return ret;
> > > +}

...

> > > +   /* ADF4360 PLLs are write only devices, try to probe using GPIO. */
> > > +   for (i = 0; i < 4; i++) {
> > > +           if (i & 1)
> > > +                   val = ADF4360_MUXOUT(ADF4360_MUXOUT_DVDD);
> > > +           else
> > > +                   val = ADF4360_MUXOUT(ADF4360_MUXOUT_GND);
> > > +
> > > +           ret = adf4360_write_reg(st, ADF4360_REG(ADF4360_CTRL), val);
> > > +           if (ret)
> > > +                   return ret;
> > > +
> > > +           ret = gpiod_get_value(st->muxout_gpio);

> > > +           if (ret ^ (i & 1)) {

I guess == or != is better than ^ here.

> > > +                   dev_err(dev, "Probe failed (muxout)");
> > > +                   return -ENODEV;
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +}

...

> > Hmm. This makes me wonder why this is an IIO driver rather than a clk
> > driver?  Definitely needs some more information in the patch description
> > or a cover letter.

+1.

...

> > > +   ret = device_property_read_string(dev, "clock-output-names",
> > > +                                     &st->clk_out_name);

Your driver is OF dependent, why to bother with device property API?

> > > +   if ((ret < 0) && dev->of_node)

Oh, this is bad. Why do you need to check for OF node at all?!

> > > +           st->clk_out_name = dev->of_node->name;

...

> > > +           /*
> > > +            * ADF4360-7 to ADF4360-9 have a VCO that is tuned to a specific
> > > +            * range using an external inductor. These properties describe
> > > +            * the range selected by the external inductor.
> > > +            */
> > > +           ret = device_property_read_u32(dev,
> > > +                                          "adi,vco-minimum-frequency-hz",
> > > +                                          &tmp);
> > > +           if (ret == 0)
> > > +                   st->vco_min = max(st->info->vco_min, tmp);
> > > +           else
> > > +                   st->vco_min = st->info->vco_min;

Why to use tmp at all?

                                          &st->vco_min);
           if (ret)
                   st->vco_min = st->info->vco_min;

           st->vco_min = max(st->info->vco_min, st->vco_min);

> > > +           ret = device_property_read_u32(dev,
> > > +                                          "adi,vco-maximum-frequency-hz",
> > > +                                          &tmp);
> > > +           if (ret == 0)
> > > +                   st->vco_max = min(st->info->vco_max, tmp);
> > > +           else
> > > +                   st->vco_max = st->info->vco_max;

Ditto.

> > > +   ret = device_property_read_u32(dev,
> > > +                                  "adi,loop-filter-pfd-frequency-hz",
> > > +                                  &tmp);
> > > +   if (ret == 0) {
> > > +           st->pfd_freq = tmp;

Ditto!

> > > +   } else {
> > > +           dev_err(dev, "PFD frequency property missing\n");
> > > +           return ret;
> > > +   }

> > > +
> > > +   ret = device_property_read_u32(dev,
> > > +                           "adi,loop-filter-charge-pump-current-microamp",
> > > +                           &tmp);
> > > +   if (ret == 0) {
> > > +           st->cpi = find_closest(tmp, adf4360_cpi_modes,
> > > +                                  ARRAY_SIZE(adf4360_cpi_modes));

Ditto!

> > > +   } else {
> > > +           dev_err(dev, "CPI property missing\n");
> > > +           return ret;
> > > +   }
> > > +
> > > +   ret = device_property_read_u32(dev, "adi,power-up-frequency-hz", &tmp);
> > > +   if (ret == 0)
> > > +           st->freq_req = tmp;
> > > +   else
> > > +           st->freq_req = st->vco_min;

Ditto.

> > > +   ret = device_property_read_u32(dev, "adi,power-out-level-microamp",
> > > +                                  &tmp);
> > > +   if (ret == 0)
> > > +           st->power_level = find_closest(tmp, adf4360_power_lvl_microamp,
> > > +                                   ARRAY_SIZE(adf4360_power_lvl_microamp));
> > > +   else
> > > +           st->power_level = ADF4360_PL_5;

Ditto.

...

> > > +   if (spi->dev.of_node)
> > > +           indio_dev->name = spi->dev.of_node->name;

Use %pOFn instead

> > > +   else
> > > +           indio_dev->name = spi_get_device_id(spi)->name;

...

> > > +static const struct of_device_id adf4360_of_match[] = {
> > > +   { .compatible = "adi,adf4360-0", },
> > > +   { .compatible = "adi,adf4360-1", },
> > > +   { .compatible = "adi,adf4360-2", },
> > > +   { .compatible = "adi,adf4360-3", },
> > > +   { .compatible = "adi,adf4360-4", },
> > > +   { .compatible = "adi,adf4360-5", },
> > > +   { .compatible = "adi,adf4360-6", },
> > > +   { .compatible = "adi,adf4360-7", },
> > > +   { .compatible = "adi,adf4360-8", },
> > > +   { .compatible = "adi,adf4360-9", },

> > > +   {},

No comma here.

> > > +};

-- 
With Best Regards,
Andy Shevchenko
