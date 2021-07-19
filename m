Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3793CEC4F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349189AbhGSRbP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 13:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380066AbhGSR1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 13:27:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844B5C0613B8;
        Mon, 19 Jul 2021 10:50:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso509358pjg.2;
        Mon, 19 Jul 2021 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFXqr9SBbhGLc4gzBlPZyX7QfeDsbpHVJ8qn3lIpRcI=;
        b=hDJb7GZOq8GJ3QesKXcm8D4HGjcYRUSccp+zOnu3stSWzoSbwWdFUcF4oeTdnjJD+7
         pyWO92788icz6+Ex4H6Jms+06bdPPprmtu0FbcbXGBQYCgK+AgQ/eJpwsEFoZRQ7nDB9
         OPLBofOxyDkp2Ycu1HtaTfh4auhT8fx+uMlr/OVJaLCSrKYtEhHw/lmIhc654izW0Yug
         m7C5vGKrj6TnmkCrwDdhP0VN5bPmUit/nPbaPyvmw2e423JaJv9H95Fcf5yHShRcV9yl
         NJ+Fu4DQkkFsKCZ6EVQGvPXdHp47cHm27wmQpzMdwQGPBYm4juSHnECXSquqZl/d+q3m
         shSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFXqr9SBbhGLc4gzBlPZyX7QfeDsbpHVJ8qn3lIpRcI=;
        b=rMqwSNworjiUBWZ6T+q1zQ4dtuPbK4ST2e5MscWhlkUj7W6s+sjh7G/xV+tjQjKl8A
         iWD3JEIwDyCL82uTCiJMeJmBHdujBCtPsHgrBLj1/R9UPA2T5pj0/CkrO5mnJfEoeCh6
         PyBT5+TZY9HHJFP4txUTSs9Jpwr5s2TxFpDBzTKQC1eBM3raRD3AA8xt/JtL3KAXahWN
         l23X/w0/9QYBOCSg1kOF+9FKhxyRJK8VR9E5+QmRqzT4kHXwCfKQdX3w7FBoKR4CJwAM
         XYyDyWblmgu4ueqQTMWK8iAZmh2ZaoxkHFrxarbA6Z0EpMcFSof2tSasyZ24hil2jFOy
         rQXw==
X-Gm-Message-State: AOAM531LWR345cxnlDXdCv/zU4IfKPdM+mLhGhrB3cs6k1jtEshMvUrM
        aRFRlFCOmhvHBgAid/8c3e2z0SI5rXi8wSpITb8=
X-Google-Smtp-Source: ABdhPJxdRRZh/m5iXvd5TO5QnKWMWgOX5NaVwlpP7S1iqPREf00DXgRNc7A8x7iF0YDnkfYH8TbSPQmZ4UPHAJ3L5LY=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr26035146pjb.228.1626717988829;
 Mon, 19 Jul 2021 11:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210719112156.27087-1-stephan@gerhold.net> <20210719112156.27087-4-stephan@gerhold.net>
 <CACRpkdYNqi0EDrtC3j=cu5cp17sEJ6_nf2KRn-hxCxgbTGhgXw@mail.gmail.com>
 <CAHp75VcsVFO2Oizpyeh53MNt2v9yD81vXp1xKCVX-U4zb-KTdg@mail.gmail.com>
 <YPWV537oN3gDpAQS@gerhold.net> <CAHp75Vdjotgi9RrmKQC4J_QQSYdRWwp+-8aHGkChx6VFLPDh-Q@mail.gmail.com>
 <YPW1xGtLyLNGKqjJ@gerhold.net>
In-Reply-To: <YPW1xGtLyLNGKqjJ@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 21:05:48 +0300
Message-ID: <CAHp75VcZDSL5u2bP_ZFySmk7cPkHRycyA-+gMqSVWCpgFXhn7Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: bmc150: Make it possible to configure
 INT2 instead of INT1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Nikita Travkin <nikita@trvn.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 8:29 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Mon, Jul 19, 2021 at 07:19:05PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 19, 2021 at 6:11 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > On Mon, Jul 19, 2021 at 06:01:01PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 19, 2021 at 5:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > > On Mon, Jul 19, 2021 at 1:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:

...

> > > > > >  #include <linux/acpi.h>
> > > > > > +#include <linux/of_irq.h>
> > > > > (...)
> > > > > > +       irq_info = bmc150_accel_interrupts_int1;
> > > > > > +       if (irq == of_irq_get_byname(dev->of_node, "INT2"))
> > > > > > +               irq_info = bmc150_accel_interrupts_int2;
> > > > >
> > > > > This looks a bit DT-specific, but I don't see that ACPI has
> > > > > named IRQs so I don't know what to do about it either.
> > > >
> > > > Yeah, we only have so far the (de facto) established way of naming
> > > > GPIO based IRQs, and not IOxAPIC ones.
> > > >
> > > > > What does platform_get_irq_byname() do on ACPI systems?
> > > >
> > > > See above.
> > > >
> > > > > If there is no obvious fix I would leave it like this until the
> > > > > first ACPI used needing this comes along, but I think maybe
> > > > > Andy has suggestions.
> > > >
> > > > The platform_get_irq_byname() should do something similar that has
> > > > been done in platform_get_irq() WRT ACPI.
> > > > Here for sure the platform_get_irq_byname() or its optional variant
> > > > should be used.
> > >
> > > I don't think there is a platform device here, we only have the
> > > i2c_client or spi_device. That's why I didn't use
> > > platform_get_irq_byname(). :)
> > >
> > > Is there something equivalent for I2C/SPI drivers?
> >
> > Not yet. You probably need to supply some code there to allow
> > multi-IRQ devices (in resource provider agnostic way).
> >
> > You need to provide fwnode_get_irq_byname() to be similar with
> > https://elixir.bootlin.com/linux/latest/source/drivers/base/property.c#L1010
> >
> > Then use it in the drivers.
> >
> > And/or integrate into frameworks somehow (something in between the
> > lines: https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L461).
> >
>
> Well, I don't think anyone has an ACPI use case for this right now so
> it's probably better if this is done by someone who actually needs this
> and can test it somewhere. :)
>
> I actually just "copied" this approach from some other IIO drivers where
> this is done similarly (and additionally checked the source code to make
> sure this won't break anything for ACPI platforms).

I see in today's Linux Next snapshot:

drivers/iio/accel/fxls8962af-core.c:774:        irq =
of_irq_get_byname(of_node, "INT2");
drivers/iio/accel/mma8452.c:1616:               irq2 =
of_irq_get_byname(client->dev.of_node, "INT2");
drivers/iio/gyro/fxas21002c_core.c:834: irq1 = of_irq_get_byname(np, "INT1");
drivers/iio/imu/adis16480.c:1265:               irq =
of_irq_get_byname(of_node, adis16480_int_pin_names[i]);
drivers/iio/imu/bmi160/bmi160_core.c:655:       irq =
of_irq_get_byname(of_node, "INT1");
drivers/iio/imu/bmi160/bmi160_core.c:661:       irq =
of_irq_get_byname(of_node, "INT2");

I believe we may stop distributing this and actually start using a
common API. I don't want this to be spread again over all IIO. Btw, I
have LSM9DS0, which supports two INT pins for IMU and currently it
uses hard coded pin mapping.

Side note to Jonathan, I believe the below may be (lazily) converted
to fwnode / device properties APIs.

drivers/iio/adc/ab8500-gpadc.c:1041:    nchans =
of_get_available_child_count(np);
drivers/iio/adc/ad7124.c:747:   st->num_channels =
of_get_available_child_count(np);
drivers/iio/adc/berlin2-adc.c:287:      struct device_node *parent_np
= of_get_parent(pdev->dev.of_node);
drivers/iio/adc/qcom-pm8xxx-xoadc.c:830:        adc->nchans =
of_get_available_child_count(np);
drivers/iio/adc/qcom-spmi-adc5.c:650:   channel_name = of_get_property(node,
drivers/iio/adc/qcom-spmi-adc5.c:813:   adc->nchannels =
of_get_available_child_count(node);
drivers/iio/adc/qcom-spmi-vadc.c:743:   vadc->nchannels =
of_get_available_child_count(node);
drivers/iio/adc/stm32-adc.c:1630:static int
stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
drivers/iio/adc/stm32-adc.c:1935:       ret =
stm32_adc_of_get_resolution(indio_dev);
drivers/iio/adc/xilinx-xadc-core.c:1248:        chan_node =
of_get_child_by_name(np, "xlnx,channels");
drivers/iio/imu/adis16480.c:1293:static int
adis16480_of_get_ext_clk_pin(struct adis16480 *st,
drivers/iio/imu/adis16480.c:1328:       pin =
adis16480_of_get_ext_clk_pin(st, of_node);
drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c:68:           mux_node =
of_get_child_by_name(dev->of_node, "i2c-gate")
;
drivers/iio/industrialio-core.c:1877:   label =
of_get_property(indio_dev->dev.of_node, "label", NULL);
drivers/iio/inkern.c:228:               if (np && !of_get_property(np,
"io-channel-ranges", NULL))
drivers/iio/temperature/ltc2983.c:1275: st->num_channels =
of_get_available_child_count(dev->of_node);


-- 
With Best Regards,
Andy Shevchenko
