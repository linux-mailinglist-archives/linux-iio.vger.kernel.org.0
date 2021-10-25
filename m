Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE6439368
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJYKOL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhJYKOL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 06:14:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDEC061745;
        Mon, 25 Oct 2021 03:11:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z20so17698195edc.13;
        Mon, 25 Oct 2021 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBDtSkb+dGGN2tqHEpHesGVMQTFs7wdi20nGWFMJJF4=;
        b=n2Z58umT1+y0hJ5/VfGH1xRDoEhFgQuhRInFhcwYSFtUZxXCAzmQErcbgeU1nAhleh
         K/5HCcYFZnIft/4SR8pXSjoEeuHcQOc0vJ1Ob+e8qwqFPsb33LVJpjFbFAGalIb5TS0J
         lnBm7OFJx8isN4EzqP9C3HAkx/ZeqSDNqkyoAzoNob219dzQHLpkH44o3Qy5dQHYZy0N
         lVW5jrjKe702eSujSxyfPWuuvJ04B2GomOuMQN+6dkX2RhSRuVhYjDesbodIlDYQdVMX
         YkKwpLFEu6fGw7Gee2awRAdaYrR5OPeaZa6n1u3SAE0vomAdtK9Gs3semnj2dbqHT0z7
         Ag9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBDtSkb+dGGN2tqHEpHesGVMQTFs7wdi20nGWFMJJF4=;
        b=GOzDMl0WBKHgd9QjXQFgB96tWX8cV1Hpjzw8xMqXwnwcjtOLQ3Cn9H7VXjhO0feu7h
         GkmznSGZIeEmYWzNiJJNnNgMZmONvTa+xUMRfVpxQ9KDSpbjqDv7BaNryl4eLJ34x/Lc
         BGOs7iSw3RsrzxmPAVuo7PmEhx9+1utWL4IrQiZ9YHrr2VJOFzo6vFaicxoSMVbR4DH2
         8q8BdDRwyUCaazAyVyNax2a5y3xPRdEkVHqY9+xYu21bg6E/2PYJZIVX802ZNDwAokb8
         ErfnAKBGCwA0EB+CduWM6j+pVTScSSBgNYfjHc43KEYiknycFl35JPjK9lbInpzDPfB5
         iFXw==
X-Gm-Message-State: AOAM532emzADzL5sf06wMruuo1DWiFexYDApSuna8aHekWVcbI3QLQMd
        EUgBdcFS7nbG7Ng4xZ/OH8Q/t8KJHv1ibKSzFlAvs4FwpT5wC0t7
X-Google-Smtp-Source: ABdhPJxnVs+40H4BfrBPiJ9jq/jYd7cxqczAPOsv2ew+ObXa4taiOCia9XzqsSkUyVhDTJnu3UyfP0mDRcNp0ExmemU=
X-Received: by 2002:a05:6402:150f:: with SMTP id f15mr25381328edw.224.1635156705178;
 Mon, 25 Oct 2021 03:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com> <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
In-Reply-To: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Oct 2021 13:10:50 +0300
Message-ID: <CAHp75Vf+dWSG6g-JsVnkJc0nREviRGZCeqoCfi20YZ9ouD+=hg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 19, 2021 at 6:22 PM Anand Ashok Dumbre
<anand.ashok.dumbre@xilinx.com> wrote:
>
> The AMS includes an ADC as well as on-chip sensors that can be used to
> sample external voltages and monitor on-die operating conditions, such
> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
> PL-SYSMON block is capable of monitoring off chip voltage and
> temperature.
> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> from external master. Out of these interface currently only DRP is

from an external
interfaces

> supported.
> Other block PS-SYSMON is memory mapped to PS.
> The AMS can use internal channels to monitor voltage and temperature as
> well as one primary and up to 16 auxiliary channels for measuring
> external voltages.
> The voltage and temperature monitoring channels also have event
> capability which allows to generate an interrupt when their value falls
> below or raises above a set threshold.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

What does this SoB mean here? Have you read Submitting Patches?

> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

...

> +config XILINX_AMS
> +       tristate "Xilinx AMS driver"
> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       depends on HAS_IOMEM
> +       help

> +         Say yes here to have support for the Xilinx AMS.

It's not important for most of the users. Please, strat help with more
useful information like below.

> +         The driver supports Voltage and Temperature monitoring on Xilinx Ultrascale
> +         devices.
> +
> +         The driver can also be built as a module. If so, the module will be called
> +         xilinx-ams.

...

> + *  Manish Narani <mnarani@xilinx.com>

A-ha! You probably forgot the Co-developed-by tag above.

> + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>

...

Missed headers, like bits.h.

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of_address.h>

Do you need this? Maybe mod_devicetable.h?

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

...

> +static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;

Why not define (esp. taking into account another similar define below?

...

> +#define AMS_REGCFG1_ALARM_MASK         0xF0F
> +#define AMS_REGCFG3_ALARM_MASK         0x3F

> +#define AMS_PL_ALARM_MASK              0xFFFF0000U
> +#define AMS_ISR0_ALARM_MASK            0xFFFFFFFFU
> +#define AMS_ISR1_ALARM_MASK            0xE000001FU
> +#define AMS_ISR1_EOC_MASK              0x00000008U

What is so special about these that they are not using combinations of
GENMASK() / BIT()?

...

> +enum ams_alarm_bit {
> +       AMS_ALARM_BIT_TEMP,
> +       AMS_ALARM_BIT_SUPPLY1,
> +       AMS_ALARM_BIT_SUPPLY2,
> +       AMS_ALARM_BIT_SUPPLY3,
> +       AMS_ALARM_BIT_SUPPLY4,
> +       AMS_ALARM_BIT_SUPPLY5,
> +       AMS_ALARM_BIT_SUPPLY6,
> +       AMS_ALARM_BIT_RESERVED,
> +       AMS_ALARM_BIT_SUPPLY7,
> +       AMS_ALARM_BIT_SUPPLY8,
> +       AMS_ALARM_BIT_SUPPLY9,
> +       AMS_ALARM_BIT_SUPPLY10,
> +       AMS_ALARM_BIT_VCCAMS,
> +       AMS_ALARM_BIT_TEMP_REMOTE

Is it terminator line? Doesn't sound like it to me. So, please add a
comma. Same for the rest.

> +};

...

> +       AMS_SEQ_MAX

This seems correct, no comma is needed :-)

...

> +struct ams {
> +       void __iomem *base;
> +       void __iomem *ps_base;
> +       void __iomem *pl_base;
> +       struct clk *clk;
> +       struct device *dev;

> +       /* check kernel doc above */

Useless

> +       struct mutex lock;

> +       /* check kernel doc above */

Ditto.

> +       spinlock_t intr_lock;
> +       unsigned int alarm_mask;
> +       unsigned int masked_alarm;
> +       u64 intr_mask;
> +       int irq;
> +       struct delayed_work ams_unmask_work;
> +};

...

> +       writel((val & ~mask) | (data & mask), ams->ps_base + offset);

Split to assignment and simple writel() call. Same to the rest.

...

> +       ams->intr_mask &= ~mask;
> +       ams->intr_mask |= (val & mask);

This may be combined to one line as it's a standard pattern.

...

> +       if (ams->ps_base) {
> +               /* Configuring PS alarm enable */
> +               cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> +                              AMS_CONF1_ALARM_2_TO_0_SHIFT);
> +               cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> +                               AMS_CONF1_ALARM_6_TO_3_SHIFT);
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
> +                                 cfg);
> +
> +               cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> +                               AMS_ISR0_ALARM_12_TO_7_MASK);
> +               ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
> +                                 cfg);
> +       }

By factoring out the body of the conditional to a helper function you may:
- decrease indentation
- make code better to read
- reduce LOCs

> +       if (ams->pl_base) {
> +               pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
> +               pl_alarm_mask = FIELD_GET(AMS_PL_ALARM_MASK, alarm_mask);
> +               /* Configuring PL alarm enable */
> +               cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> +                       AMS_CONF1_ALARM_2_TO_0_SHIFT);
> +               cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> +                        AMS_CONF1_ALARM_6_TO_3_SHIFT);
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG1,
> +                                 AMS_REGCFG1_ALARM_MASK, cfg);
> +
> +               cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> +                       AMS_ISR0_ALARM_12_TO_7_MASK);
> +               ams_pl_update_reg(ams, AMS_REG_CONFIG3,
> +                                 AMS_REGCFG3_ALARM_MASK, cfg);
> +       }

Ditto. And the same applies to all the rest where it gains something
from the above list of improvements.

...

> +       int i;
> +       unsigned long long scan_mask;
> +       struct ams *ams = iio_priv(indio_dev);

Reversed xmas tree order, please.
Same for the rest.

...

> +       /* Run calibration of PS & PL as part of the sequence */
> +       scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);

BIT(0) ?

...

> +       ams_update_intrmask(ams, ~0, ~0);

Replace ~0 to proper GENMASK()./BIT() combination which takes into
account real bits used by hardware.

...

> +       case IIO_CHAN_INFO_RAW:
> +               mutex_lock(&ams->lock);
> +               if (chan->scan_index >= (AMS_PS_SEQ_MAX * 3)) {

Too many parens.

> +                       ret = ams_read_vcc_reg(ams, chan->address, val);
> +                       if (ret) {
> +                               mutex_unlock(&ams->lock);
> +                               return -EINVAL;
> +                       }
> +                       ams_enable_channel_sequence(indio_dev);
> +               } else if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +                       *val = readl(ams->pl_base + chan->address);
> +               else
> +                       *val = readl(ams->ps_base + chan->address);
> +               mutex_unlock(&ams->lock);
> +
> +               return IIO_VAL_INT;

...

> +       return -EINVAL;

Use corresponding defaul cases in each of the switches.

...

> +       int offset = 0;

Make the assignment as an else branch, so all offset assignments will
be grouped together.

> +       if (dir == IIO_EV_DIR_FALLING) {
> +               if (scan_index < AMS_SEQ_SUPPLY7)
> +                       offset = AMS_ALARM_THRESHOLD_OFF_10;
> +               else
> +                       offset = AMS_ALARM_THRESHOLD_OFF_20;
> +       }

...

> +       return 0;

default case.

> +}

...

> +static const struct iio_chan_spec
> +*ams_event_to_channel(struct iio_dev *indio_dev, u32 event)

Unusual indentation.

...

> +       case AMS_ALARM_BIT_TEMP_REMOTE:
> +               scan_index += AMS_SEQ_TEMP_REMOTE;
> +               break;

default?
Same for the rest of the cases like this.

...

> +       return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;

!! would work as well.

...

> +               /*
> +                * The temperature channel only supports over-temperature
> +                * events

Missed period.

> +                */

...

> +       /* only process alarms that are not masked */

Inconsistent style (here capitalization is missed). Make all comments
in the code consistent.

> +       isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);

> +

Redundant blank line.

> +       if (!isr0)

How did you test this branch? (Hint: something very important should
be done here)

> +               return IRQ_NONE;

...

> +       for_each_child_of_node(chan_node, child) {
> +               ret = of_property_read_u32(child, "reg", &reg);
> +               if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> +                       continue;
> +
> +               memcpy(&channels[num_channels], &ams_pl_channels[reg +
> +                      AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
> +
> +               if (of_property_read_bool(child, "xlnx,bipolar"))
> +                       channels[num_channels].scan_type.sign = 's';
> +
> +               num_channels++;
> +       }

Use device property API here instead of *of_*() calls.

...

> +       /* Initialize buffer for channel specification */
> +       ams_channels = kzalloc(sizeof(ams_ps_channels) +
> +                              sizeof(ams_pl_channels) +
> +                              sizeof(ams_ctrl_channels), GFP_KERNEL);

Use the corresponding macro from overflow.h.

> +       if (!ams_channels)
> +               return -ENOMEM;

...

> +       if (of_device_is_available(np)) {

fwnode_device_is_available()

> +               ret = ams_init_module(indio_dev, np, ams_channels);
> +               if (ret < 0)
> +                       goto err;
> +
> +               num_channels += ret;
> +       }

...

> +       for_each_child_of_node(np, child_node) {
> +               if (of_device_is_available(child_node)) {
> +                       ret = ams_init_module(indio_dev, child_node,
> +                                             ams_channels + num_channels);
> +                       if (ret < 0)
> +                               goto err;
> +
> +                       num_channels += ret;
> +               }
> +       }

As per above.

...

> +       if (!pdev->dev.of_node)
> +               return -ENODEV;

Drop this, please. It will allow reuse of the driver in ACPI environments.

...

> +       ams->irq = platform_get_irq(pdev, 0);
> +       if (ams->irq == -EPROBE_DEFER) {

Is IRQ optional or not?

> +               ret = -EPROBE_DEFER;
> +               return ret;
> +       }

...

> +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +
> +       return ret;

return devm_...

...

> +       clk_prepare_enable(ams->clk);

It might fail.


-- 
With Best Regards,
Andy Shevchenko
