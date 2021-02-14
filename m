Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9831B1F0
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 19:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBNSWx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBNSWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 13:22:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45BDC061574;
        Sun, 14 Feb 2021 10:22:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so6174367wrx.4;
        Sun, 14 Feb 2021 10:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CdEdxzE/f5VndENzXSoJYwfI2PIWPruyaeU5aQR3n4E=;
        b=VpEBQWYKzE+sZGpe3ZQ1OKt8XgemOmQ9VCy03tP0oe/HR6cfqbOmWvmUY1hAvC+NKG
         LXpOVhCDQZCUh1MXRPuBXcyuaBX6StSiy3pqL6sFEeDMIS/pAg/mNXqaqElGY90IDEye
         X/PCsDmYMf/b21hvJKf/rYcOtEEcAVc9U//SLvOhuO9CpYCr8IQSli4whjB1j1fD2VRf
         chFTATTjnDHfbsUqDEdvFgPX9KQJhrhJKCbFAWklVOx0J3P0SM5eurOxsF63NOaizEUe
         IvUnMbRLkDibULSbnyKcPukAsIXRKm1ms25cWI+SvrxP5Z2MfamqWIYXjjqM+5wGXI8M
         X49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdEdxzE/f5VndENzXSoJYwfI2PIWPruyaeU5aQR3n4E=;
        b=RWGdRAlPe+3XwyknOQxNXpiqIrE2nv7q6RDbnP5st3syCJ6POe0Fi59dqIMSZfEAXm
         rYQWzKsy/umcqBG9LNpnZOBY4yZEpNB9mjo6IKZ3cthPnoDXq6tSHPKHFFiqty0QhvmU
         tA14lhRSJI1Ak1sPDsBov3xwWfq5K9i/mPUdz8qyrFIZHfJOCVAdKuEmD1ktCyKvUHqn
         bbtIBBph37+DLAlTDqELA0NnfvvuOCYuIoTRiZN45ivcF8KRtdR3z42HV30wxAWb/vO7
         Wt3UDBh4dvL2jqjBmaIuwXxlm2OE2JCwKG5T/CZIDRU7LHpVkDygJOwTb3xhT8hPLvDy
         THdg==
X-Gm-Message-State: AOAM533rVYibALUAeYA4Dq/5bWVTouBki8t/pbEgaZAja54fIivr3n6N
        cP8+dRUS9mUBmJQOFossixc=
X-Google-Smtp-Source: ABdhPJxHXe6YkpRXoZXA6S6Od+4k0+dlg130VpNQMrN2pp/bLV6hyR1bVRpm1d1w6rp171dQJ+H0Dg==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr9651032wrw.222.1613326925015;
        Sun, 14 Feb 2021 10:22:05 -0800 (PST)
Received: from pop-os.localdomain (cpc126866-lewi25-2-0-cust31.2-4.cable.virginm.net. [82.7.143.32])
        by smtp.gmail.com with ESMTPSA id q2sm14199908wrx.79.2021.02.14.10.22.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Feb 2021 10:22:04 -0800 (PST)
Date:   Sun, 14 Feb 2021 18:22:02 +0000
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] Added AMS tsl2591 driver implementation
Message-ID: <20210214182201.nv2stz4gufo2cyd5@pop-os.localdomain>
References: <20210213132241.15808-1-joe.g.sandom@gmail.com>
 <20210214122353.22c2b3b9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214122353.22c2b3b9@archlinux>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 14, 2021 at 12:23:53PM +0000, Jonathan Cameron wrote:
> On Sat, 13 Feb 2021 13:22:41 +0000
> Joe Sandom <joe.g.sandom@gmail.com> wrote:
> 
> > Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
> > 
> > This driver supports configuration via device tree and sysfs.
> > Supported channels for raw infrared light, raw visible light,
> > raw combined light and combined lux value.
> > The driver additionally supports iio events on lower and
> > upper thresholds.
> > 
> > This is a very-high sensitivity light-to-digital converter that
> > transforms light intensity into a digital signal.
> > 
> > Datasheet Available at: https://ams.com/tsl25911
> > 
> > Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> 
> Various bits and bobs inline.  Note that before we can apply this
> you will have to figure out how to deal with your email issues.
> gmail will alow smtp I believe, so I'd use that and
> git send-email if possible.
> 
> Jonathan

Hi Jonathan,

Thanks again for the comprehensive review. A lot of valuable points
made! all looks fine now with get send-email + gmail, thanks for that.
I'll work on getting a new revision out this week.

Thanks,
Joe

> 
> > ---
> > Changes in v3:
> > - Cleaned up descriptions in binding file and Kconfig
> > - Changed macros to be uppercase
> > - Cleaned up comment formatting for capitalisation and block comments
> > - Changed tsl2591_settings to tsl2591_als_settings as settings only
> >   related to als
> > - Return -EINVAL directly in default case to save some lines
> > - Consistent use of const in "compatible" check functions
> > - Removed mutex use in _show functions as not necessary
> > - Removed print's which contribute little value/have little meaning
> > 
> > NOTES;
> > - Where spaces are seen at the end of some lines, it looks like gmail
> >   has mangled things slightly.
> Ah.  You need to work out how to fix that unfortunately otherwise it
> won't be possible to apply patches.
> 
> There are some hints in Documentation/process/email-clients.rst
> 
> 
> > - checkpatch.pl --strict remarks that mutex definition should have a
> >   comment above it. I agree it has little meaning, but just added it to
> >   satisfy checkpatch.pl :)
> 
> Hmm. Comment on that below.  It should have a meaningful comment defining
> the scope of the lock.
> 
> > - For sysfs functions e.g. "in_illuminance_*", they're not currently
> >   prefixed with "tsl2591" because I wanted to keep things consistent
> >   with the other light drivers. Is this something we're looking to
> >   change with the other drivers too?
> Most of these shouldn't exist anyway as they are handled by the core
> of IIO via read_raw() and read_avail() callbacks.
> 
> The one remainder is the event _available one as we haven't yet added
> infrastructure to build those in the core.  I'd prefer it was prefixed
> but not enough to suggest we add noise fixing other drivers that do
> it differently.  Key rule of kernel development, never assume another
> driver is right - it may just be we decided it wasn't worth the pain
> of tidying it up!
> 
> > 
> > REASON FOR RESEND;
> > - Mailing lists were rejecting my outlook email, so switched to gmail as
> >   mailing lists seem to accept without issues.
> > 
> >  .../bindings/iio/light/amstaos,tsl2591.yaml   |   50 +
> >  drivers/iio/light/Kconfig                     |   11 +
> >  drivers/iio/light/Makefile                    |    1 +
> >  drivers/iio/light/tsl2591.c                   | 1220 +++++++++++++++++
> >  4 files changed, 1282 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> >  create mode 100644 drivers/iio/light/tsl2591.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> > new file mode 100644
> > index 000000000000..29a53e0019dd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> 
> Dt bindings should be a in a separate patch titled
> dt-bindings: * 
> to make them easy for Rob and devicetree specialists to spot.
> 
> > +$id: http://devicetree.org/schemas/iio/light/tsl2591.yaml#
> Try building this binding as per instructions in 
> Documentation/devicetree/writing-schema.rst
> 
> The line above needs the vendor prefix.
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS/TAOS TSL2591 Ambient Light Sensor (ALS)
> > +
> > +maintainers:
> > +  - Joe Sandom <joe.g.sandom@gmail.com>
> > +
> > +description: |
> > +  AMS/TAOS TSL2591 is a very-high sensitivity
> > +  light-to-digital converter that transforms light intensity into a digital
> > +  signal.
> > +
> > +properties:
> > +  compatible:
> > +    const: amstaos,tsl2591
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      Interrupt (INT:Pin 2) Active low. Should be set to IRQ_TYPE_EDGE_FALLING.
> > +      interrupt is used to detect if the light intensity has fallen below
> > +      or reached above the configured threshold values.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        tsl2591@29 {
> > +            compatible = "amstaos,tsl2591";
> > +            reg = <0x29>;
> > +            interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> > +       };
> > +    };
> > +...
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 33ad4dd0b5c7..07550f1a1783 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -501,6 +501,17 @@ config TSL2583
> >  	  Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
> >  	  Access ALS data via iio, sysfs.
> >  
> > +config TSL2591
> > +        tristate "TAOS TSL2591 ambient light sensor"
> > +        depends on I2C
> > +        help
> > +          Select Y here for support of the AMS/TAOS TSL2591 ambient light sensor,
> > +          featuring channels for combined visible + IR intensity and lux illuminance.
> > +          Access als data via iio and sysfs. Supports iio_events.
> > +
> > +          To compile this driver as a module, select M: the
> > +          module will be called tsl2591.
> > +
> >  config TSL2772
> >  	tristate "TAOS TSL/TMD2x71 and TSL/TMD2x72 Family of light and proximity sensors"
> >  	depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index ea376deaca54..d10912faf964 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
> >  obj-$(CONFIG_TCS3414)		+= tcs3414.o
> >  obj-$(CONFIG_TCS3472)		+= tcs3472.o
> >  obj-$(CONFIG_TSL2583)		+= tsl2583.o
> > +obj-$(CONFIG_TSL2591)		+= tsl2591.o
> >  obj-$(CONFIG_TSL2772)		+= tsl2772.o
> >  obj-$(CONFIG_TSL4531)		+= tsl4531.o
> >  obj-$(CONFIG_US5182D)		+= us5182d.o
> > diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> > new file mode 100644
> > index 000000000000..fafa1f11c1f9
> > --- /dev/null
> > +++ b/drivers/iio/light/tsl2591.c
> > @@ -0,0 +1,1220 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Joe Sandom <joe.g.sandom@gmail.com>
> > + *
> > + * Datasheet available at: https://ams.com/tsl25911
> > + *
> > + * Device driver for the TAOS TSL2591. This is a very-high sensitivity
> > + * light-to-digital converter that transforms light intensity into a digital
> > + * signal.
> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +/* ALS integration time conversion macros */
> > +#define ALS_TIME_SECS_TO_MS(x) (((x) + 1) * 100)
> 
> Prefix as TSL2591_TIME_SECS_TO_MS
> 
> Though it's also confusing because * 100 doesn't normally
> do seconds to milliseconds, so what is this doing?
> 
> > +#define ALS_TIME_MS_TO_SECS(x) (((x) / 100) - 1)
> > +
> > +/* TSL2591 register set */
> > +#define TSL2591_ENABLE      0x00
> > +#define TSL2591_CONTROL     0x01
> > +#define TSL2591_AILTL       0x04
> > +#define TSL2591_AILTH       0x05
> > +#define TSL2591_AIHTL       0x06
> > +#define TSL2591_AIHTH       0x07
> > +#define TSL2591_NP_AILTL    0x08
> > +#define TSL2591_NP_AILTH    0x09
> > +#define TSL2591_NP_AIHTL    0x0A
> > +#define TSL2591_NP_AIHTH    0x0B
> > +#define TSL2591_PERSIST     0x0C
> > +#define TSL2591_PACKAGE_ID  0x11
> > +#define TSL2591_DEVICE_ID   0x12
> > +#define TSL2591_STATUS      0x13
> > +#define TSL2591_C0_DATAL    0x14
> > +#define TSL2591_C0_DATAH    0x15
> > +#define TSL2591_C1_DATAL    0x16
> > +#define TSL2591_C1_DATAH    0x17
> > +
> > +/* TSL2591 command register definitions */
> > +#define TSL2591_CMD_NOP             0xA0
> > +#define TSL2591_CMD_SF_INTSET       0xE4
> > +#define TSL2591_CMD_SF_CALS_I       0xE5
> > +#define TSL2591_CMD_SF_CALS_NPI     0xE7
> > +#define TSL2591_CMD_SF_CNP_ALSI     0xEA
> > +
> > +/* TSL2591 enable register definitions */
> > +#define TSL2591_PWR_ON              0x01
> > +#define TSL2591_PWR_OFF             0x00
> > +#define TSL2591_ENABLE_ALS          0x02
> > +#define TSL2591_ENABLE_ALS_INT      0x10
> > +#define TSL2591_ENABLE_SLEEP_INT    0x40
> > +#define TSL2591_ENABLE_NP_INT       0x80
> > +
> > +/* TSL2591 control register definitions */
> > +#define TSL2591_CTRL_ALS_INTEGRATION_100MS  0x00
> > +#define TSL2591_CTRL_ALS_INTEGRATION_200MS  0x01
> > +#define TSL2591_CTRL_ALS_INTEGRATION_300MS  0x02
> > +#define TSL2591_CTRL_ALS_INTEGRATION_400MS  0x03
> > +#define TSL2591_CTRL_ALS_INTEGRATION_500MS  0x04
> > +#define TSL2591_CTRL_ALS_INTEGRATION_600MS  0x05
> > +#define TSL2591_CTRL_ALS_LOW_GAIN           0x00
> > +#define TSL2591_CTRL_ALS_MED_GAIN           0x10
> > +#define TSL2591_CTRL_ALS_HIGH_GAIN          0x20
> > +#define TSL2591_CTRL_ALS_MAX_GAIN           0x30
> > +#define TSL2591_CTRL_SYS_RESET              0x80
> > +
> > +/* TSL2591 persist register definitions */
> > +#define TSL2591_PRST_ALS_INT_CYCLE_0        0x00
> > +#define TSL2591_PRST_ALS_INT_CYCLE_ANY      0x01
> > +#define TSL2591_PRST_ALS_INT_CYCLE_2        0x02
> > +#define TSL2591_PRST_ALS_INT_CYCLE_3        0x03
> > +#define TSL2591_PRST_ALS_INT_CYCLE_5        0x04
> > +#define TSL2591_PRST_ALS_INT_CYCLE_10       0x05
> > +#define TSL2591_PRST_ALS_INT_CYCLE_15       0x06
> > +#define TSL2591_PRST_ALS_INT_CYCLE_20       0x07
> > +#define TSL2591_PRST_ALS_INT_CYCLE_25       0x08
> > +#define TSL2591_PRST_ALS_INT_CYCLE_30       0x09
> > +#define TSL2591_PRST_ALS_INT_CYCLE_35       0x0A
> > +#define TSL2591_PRST_ALS_INT_CYCLE_40       0x0B
> > +#define TSL2591_PRST_ALS_INT_CYCLE_45       0x0C
> > +#define TSL2591_PRST_ALS_INT_CYCLE_50       0x0D
> > +#define TSL2591_PRST_ALS_INT_CYCLE_55       0x0E
> > +#define TSL2591_PRST_ALS_INT_CYCLE_60       0x0F
> > +#define TSL2591_PRST_ALS_INT_CYCLE_MAX      TSL2591_PRST_ALS_INT_CYCLE_60
> > +
> > +/* TSL2591 persist interrupt cycle literals */
> > +#define TSL2591_PRST_ALS_INT_CYCLE_1_LIT      1
> > +#define TSL2591_PRST_ALS_INT_CYCLE_2_LIT      2
> > +#define TSL2591_PRST_ALS_INT_CYCLE_3_LIT      3
> > +#define TSL2591_PRST_ALS_INT_CYCLE_5_LIT      5
> > +#define TSL2591_PRST_ALS_INT_CYCLE_10_LIT     10
> > +#define TSL2591_PRST_ALS_INT_CYCLE_15_LIT     15
> > +#define TSL2591_PRST_ALS_INT_CYCLE_20_LIT     20
> > +#define TSL2591_PRST_ALS_INT_CYCLE_25_LIT     25
> > +#define TSL2591_PRST_ALS_INT_CYCLE_30_LIT     30
> > +#define TSL2591_PRST_ALS_INT_CYCLE_35_LIT     35
> > +#define TSL2591_PRST_ALS_INT_CYCLE_40_LIT     40
> > +#define TSL2591_PRST_ALS_INT_CYCLE_45_LIT     45
> > +#define TSL2591_PRST_ALS_INT_CYCLE_50_LIT     50
> > +#define TSL2591_PRST_ALS_INT_CYCLE_55_LIT     55
> > +#define TSL2591_PRST_ALS_INT_CYCLE_60_LIT     60
> > +
> > +/* TSL2591 PID register mask */
> > +#define TSL2591_PACKAGE_ID_MASK 0x30
> > +
> > +/* TSL2591 ID register mask */
> > +#define TSL2591_DEVICE_ID_MASK  0xFF
> > +
> > +/* TSL2591 status register masks */
> > +#define TSL2591_STS_ALS_VALID_MASK   0x01
> 
> BIT() or GENMASK() for masks.
> 
> > +#define TSL2591_STS_ALS_INT_MASK     0x10
> > +#define TSL2591_STS_NPERS_INT_MASK   0x20
> > +#define TSL2591_STS_VAL_HIGH_MASK    0x01
> > +
> > +/* TSL2591 constant values */
> > +#define TSL2591_PACKAGE_ID_VAL  0x00
> > +#define TSL2591_DEVICE_ID_VAL   0x50
> > +
> > +/* Power off suspend delay time MS */
> > +#define TSL2591_POWER_OFF_DELAY_MS	2000
> > +
> > +/* TSL2591 default values */
> > +#define TSL2591_DEFAULT_ALS_INT_TIME          TSL2591_CTRL_ALS_INTEGRATION_300MS
> > +#define TSL2591_DEFAULT_ALS_GAIN              TSL2591_CTRL_ALS_MED_GAIN
> > +#define TSL2591_DEFAULT_ALS_PERSIST           TSL2591_PRST_ALS_INT_CYCLE_ANY
> > +#define TSL2591_DEFAULT_ALS_LOWER_THRESHOLD   100
> > +#define TSL2591_DEFAULT_ALS_UPPER_THRESHOLD   1500
> > +
> > +/* TSL2591 number of data channels */
> > +#define TSL2591_NUM_DATA_CHANNELS      4
> That's not true. There are 4 bytes, but it's not the number of channels.
> > +
> > +/* TSL2591 number of valid status reads on ADC complete */
> > +#define TSL2591_ALS_STS_VALID_COUNT    10
> > +
> > +/* TSL2591 maximum values */
> > +#define TSL2591_MAX_ALS_INT_TIME_MS    600
> > +#define TSL2591_ALS_MAX_VALUE	       65535
> > +
> > +/*
> > + * LUX calculations;
> > + * AGAIN values from Adafruits TSL2591 Arduino library
> > + * https://github.com/adafruit/Adafruit_TSL2591_Library
> > + */
> > +#define TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER   1
> > +#define TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER   25
> > +#define TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER  428
> > +#define TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER   9876
> > +#define TSL2591_LUX_COEFFICIENT      408
> > +
> > +static const u8 tsl2591_data_channels[] = {
> 
> They aren't channels, they are registers so rename as such.
> 
> > +	TSL2591_C0_DATAL,
> > +	TSL2591_C0_DATAH,
> > +	TSL2591_C1_DATAL,
> > +	TSL2591_C1_DATAH,
> > +};
> > +
> > +struct tsl2591_als_readings {
> As mentioned below, I don't think this structure is useful.
> Rewrite the function that fills it to return only the value
> or values of interest to a particular call rather than burying this
> data inside the chip state structure.
> 
> > +	u16 als_ch0;
> > +	u16 als_ch1;
> > +	u16 als_lux_int;
> > +	u16 als_lux_decimal;
> > +};
> > +
> > +struct tsl2591_als_settings {
> > +	u8 als_int_time;
> > +	u8 als_gain;
> > +	u8 als_persist;
> > +	u16 als_lower_threshold;
> > +	u16 als_upper_threshold;
> > +};
> > +
> > +struct tsl2591_chip {
> > +	/* ALS mutex */
> 
> Not informative.  For a lock what we want is a statement of
> what state it is protecting.
> 
> 	/*
> 	 * Keep als_settings in sync with hardware state
> 	 * and ensure multiple readers are serialized.
> 	 */
> 
> Though more detail that that would be even better.
> 
> > +	struct mutex als_mutex;
> > +	struct i2c_client *client;
> > +	struct tsl2591_als_settings als_settings;
> > +	struct tsl2591_als_readings als_readings;
> > +
> > +	bool events_enabled;
> > +};
> > +
> > +/*
> > + * Period table is ALS persist cycle x integration time setting
> > + * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
> > + * ALS cycles: 1, 2, 3, 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60
> > + */
> > +static const char * const tsl2591_als_period_list[] = {
> > +	"0.1 0.2 0.3 0.5 1.0 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 ",
> > +	"0.2 0.4 0.6 1.0 2.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0",
> > +	"0.3 0.6 0.9 1.5 3.0 6.0 7.5 9.0 10.5 12.0 13.5 15.0 16.5 18.0",
> > +	"0.4 0.8 1.2 2.0 4.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0 ",
> > +	"0.5 1.0 1.5 2.5 5.0 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0",
> > +	"0.6 1.2 1.8 3.0 6.0 12.0 15.0 18.0 21.0 24.0 27.0 30.0 33.0 36.0",
> > +};
> > +
> > +static int tsl2591_gain_to_multiplier(const u8 als_gain)
> > +{
> > +	switch (als_gain) {
> > +	case TSL2591_CTRL_ALS_LOW_GAIN:
> > +		return TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER;
> > +	case TSL2591_CTRL_ALS_MED_GAIN:
> > +		return TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER;
> > +	case TSL2591_CTRL_ALS_HIGH_GAIN:
> > +		return TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER;
> > +	case TSL2591_CTRL_ALS_MAX_GAIN:
> > +		return TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static u8 tsl2591_multiplier_to_gain(const u32 multiplier)
> > +{
> > +	switch (multiplier) {
> > +	case TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER:
> > +		return TSL2591_CTRL_ALS_LOW_GAIN;
> > +	case TSL2591_CTRL_ALS_MED_GAIN_MULTIPLIER:
> > +		return TSL2591_CTRL_ALS_MED_GAIN;
> > +	case TSL2591_CTRL_ALS_HIGH_GAIN_MULTIPLIER:
> > +		return TSL2591_CTRL_ALS_HIGH_GAIN;
> > +	case TSL2591_CTRL_ALS_MAX_GAIN_MULTIPLIER:
> > +		return TSL2591_CTRL_ALS_MAX_GAIN;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
> > +{
> > +	switch (als_persist) {
> > +	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_1_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_2:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_2_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_3:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_3_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_5:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_5_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_10:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_10_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_15:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_15_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_20:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_20_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_25:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_25_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_30:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_30_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_35:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_35_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_40:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_40_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_45:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_45_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_50:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_50_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_55:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_55_LIT;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_60:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_60_LIT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> > +{
> > +	switch (als_persist) {
> > +	case TSL2591_PRST_ALS_INT_CYCLE_1_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_2_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_2;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_3_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_3;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_5_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_5;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_10_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_10;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_15_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_15;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_20_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_20;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_25_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_25;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_30_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_30;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_35_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_35;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_40_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_40;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_45_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_45;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_50_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_50;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_55_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_55;
> > +	case TSL2591_PRST_ALS_INT_CYCLE_60_LIT:
> > +		return TSL2591_PRST_ALS_INT_CYCLE_60;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
> > +				       const u32 als_integration_time)
> > +{
> > +	switch (als_integration_time) {
> > +	case TSL2591_CTRL_ALS_INTEGRATION_100MS:
> > +	case TSL2591_CTRL_ALS_INTEGRATION_200MS:
> > +	case TSL2591_CTRL_ALS_INTEGRATION_300MS:
> > +	case TSL2591_CTRL_ALS_INTEGRATION_400MS:
> > +	case TSL2591_CTRL_ALS_INTEGRATION_500MS:
> > +	case TSL2591_CTRL_ALS_INTEGRATION_600MS:
> > +		chip->als_settings.als_int_time = als_integration_time;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_compatible_gain(struct tsl2591_chip *chip, const u8 als_gain)
> > +{
> > +	switch (als_gain) {
> > +	case TSL2591_CTRL_ALS_LOW_GAIN:
> > +	case TSL2591_CTRL_ALS_MED_GAIN:
> > +	case TSL2591_CTRL_ALS_HIGH_GAIN:
> > +	case TSL2591_CTRL_ALS_MAX_GAIN:
> > +		chip->als_settings.als_gain = als_gain;
> 
> As below, either set at caller rather than hiding in here, or
> possibly rename the function to indicate it's setting this.
> 
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_compatible_als_persist(struct tsl2591_chip *chip,
> > +					  const u32 als_persist)
> > +{
> > +	switch (als_persist) {
> > +	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_2:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_3:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_5:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_10:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_15:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_20:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_25:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_30:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_35:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_40:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_45:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_50:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_55:
> > +	case TSL2591_PRST_ALS_INT_CYCLE_60:
> > +		chip->als_settings.als_persist = als_persist;
> 
> Don't hid this in a function that appears to be simply checking it is
> a valid value.  Return the value and set 
> chip->als_settings.als_persist at the caller instead.
> 
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	struct tsl2591_als_settings settings = chip->als_settings;
> > +	int delay = ALS_TIME_SECS_TO_MS(settings.als_int_time);
> > +	int ret;
> > +	int i;
> > +
> > +	if (!delay)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Sleep for ALS integration time to allow enough time
> > +	 * for an ADC read cycle to complete. Check status after
> > +	 * delay for ALS valid
> > +	 */
> > +	msleep(delay);
> > +
> > +	/* Check for status ALS valid flag for up to 100ms */
> > +	for (i = 0; i < TSL2591_ALS_STS_VALID_COUNT; ++i) {
> > +		ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP |
> > +			TSL2591_STATUS);
> > +		if (ret < 0) {
> > +			dev_err(&client->dev, "Failed to read register\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if ((ret & TSL2591_STS_ALS_VALID_MASK) == TSL2591_STS_VAL_HIGH_MASK)
> > +			break;
> > +
> > +		if (i == (TSL2591_ALS_STS_VALID_COUNT - 1))
> > +			return -ENODATA;
> > +
> > +		usleep_range(9000, 10000);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * tsl2591_read_channel_data() - Reads raw channel data and calculates lux
> > + *
> > + * Formula for lux calculation;
> > + * Derived from Adafruit's TSL2591 library
> > + * Link: https://github.com/adafruit/Adafruit_TSL2591_Library
> > + * Counts Per Lux (CPL) = (ATIME_ms * AGAIN) / LUX DF
> > + * lux = ((C0DATA - C1DATA) * (1 - (C1DATA / C0DATA))) / CPL
> > + *
> > + * Scale values to get more representative value of lux i.e.
> > + * lux = ((C0DATA - C1DATA) * (1000 - ((C1DATA * 1000) / C0DATA))) / CPL
> > + *
> > + * Channel 0 = IR + Visible
> > + * Channel 1 = IR only
> > + * Visible = Channel 0 - Channel 1
> > + *
> > + */
> > +static int tsl2591_read_channel_data(struct iio_dev *indio_dev)
> 
> I think this would end up simpler if you had this function return the reading
> requested directly rather than putting it in a structure from where
> it is later fetched.
> 
> If we also specified which channel was being read it would cut down
> on the amount of work if it's not the lux channel.
> 
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct tsl2591_als_settings *settings = &chip->als_settings;
> > +	struct i2c_client *client = chip->client;
> > +	int i;
> > +	int ret;
> > +	u8 channel_data[TSL2591_NUM_DATA_CHANNELS];
> > +
> > +	int counts_per_lux;
> > +	int lux;
> > +	int gain_multiplier;
> > +
> > +	ret = tsl2591_wait_adc_complete(chip);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "No data available. Err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < TSL2591_NUM_DATA_CHANNELS; ++i) {
> > +		int reg = TSL2591_CMD_NOP | tsl2591_data_channels[i];
> > +
> > +		ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP | reg);
> > +		if (ret < 0) {
> > +			dev_err(&client->dev,
> > +				"Failed to read register %#04x\n", reg);
> > +			return -EINVAL;
> > +		}
> > +		channel_data[i] = ret;
> 
> This loop looked unusual, so I had a look at the datasheet.
> Can we not use the autoincrement and 4 byte read mentioned in the docs
> for these registers?
> 
> Mind you, the random datasheet google found for me doesn't actually say how
> to do this - so perhaps better playing it safe and doing 4 single byte reads.
> 
> > +	}
> > +
> > +	chip->als_readings.als_ch0 =
> > +		le16_to_cpup((const __le16 *)&channel_data[0]);
> > +	chip->als_readings.als_ch1 =
> > +		le16_to_cpup((const __le16 *)&channel_data[2]);
> > +
> > +	dev_dbg(&client->dev, "both: %d\n", chip->als_readings.als_ch0);
> > +	dev_dbg(&client->dev, "ir: %d\n", chip->als_readings.als_ch1);
> 
> Given we can read those both directly seems pointless to have this debug
> info here in a production driver.
> 
> > +
> > +	gain_multiplier = tsl2591_gain_to_multiplier(settings->als_gain);
> > +	if (gain_multiplier < 0) {
> > +		dev_err(&client->dev, "Invalid multiplier. Err: %d\n",
> > +			gain_multiplier);
> > +		return -EINVAL;
> 
> 		return gain_multiplier;
> 
> Obviously it's current the same thing but better to not give impression of
> eating a potentially useful error code.
> 
> > +	}
> > +
> > +	/* Calculate counts per lux value */
> > +	counts_per_lux = (ALS_TIME_SECS_TO_MS(settings->als_int_time) *
> > +			gain_multiplier) / TSL2591_LUX_COEFFICIENT;
> > +
> > +	dev_dbg(&client->dev, "Counts Per Lux (CPL): %d\n", counts_per_lux);
> > +
> > +	/* Calculate lux value */
> > +	lux = ((chip->als_readings.als_ch0 - chip->als_readings.als_ch1) *
> > +	(1000 - ((chip->als_readings.als_ch1 * 1000) /
> > +	chip->als_readings.als_ch0))) / counts_per_lux;
> > +
> > +	/* Divide by 1000 to get real lux value before scaling */
> > +	chip->als_readings.als_lux_int = lux / 1000;
> > +
> > +	/* Get the decimal part of lux reading */
> > +	chip->als_readings.als_lux_decimal =
> > +		(lux - (chip->als_readings.als_lux_int * 1000));
> > +
> > +	dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_set_als_gain_int_time(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	struct tsl2591_als_settings als_settings = chip->als_settings;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client,
> > +					TSL2591_CMD_NOP | TSL2591_CONTROL,
> > +					als_settings.als_int_time |
> > +					als_settings.als_gain);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als gain & int time\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_set_als_thresholds(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	struct tsl2591_als_settings als_settings = chip->als_settings;
> > +	int ret;
> > +
> > +	u8 als_lower_l;
> > +	u8 als_lower_h;
> > +	u8 als_upper_l;
> > +	u8 als_upper_h;
> > +
> > +	if (als_settings.als_lower_threshold >= als_settings.als_upper_threshold) {
> > +		dev_warn(&client->dev, "Lower threshold higher than upper\n");
> This looks like it can be triggered directly from userspace.   Don't print to the
> kernel logs in that case, just return an error if the driver can't cope with the
> value provided.
> 
> Note however, that this may mean thresholds need to be set in a particular order
> and we almost certainly want to avoid that.  Various solutions exist.
> 1) Only update thresholds at event enable. - may not be wise on this device
>    as we frequently want to adjust light thresholds during normal usecases.
> 2) Enforce the constraint by changing the other threshold as well if needed.
> 
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (als_settings.als_upper_threshold > TSL2591_ALS_MAX_VALUE) {
> > +		dev_warn(&client->dev, "Upper threshold higher than max\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	als_lower_l = (als_settings.als_lower_threshold & 0x00FF);
> > +	als_lower_h = ((als_settings.als_lower_threshold >> 8) & 0x00FF);
> > +	als_upper_l = (als_settings.als_upper_threshold & 0x00FF);
> > +	als_upper_h = ((als_settings.als_upper_threshold >> 8) & 0x00FF);
> > +
> > +	dev_dbg(&client->dev, "Setting configuration - als lower l: %#04x\n",
> > +		als_lower_l);
> > +	dev_dbg(&client->dev, "Setting configuration - als lower h: %#04x\n",
> > +		als_lower_h);
> > +	dev_dbg(&client->dev, "Setting configuration - als upper l: %#04x\n",
> > +		als_upper_l);
> > +	dev_dbg(&client->dev, "Setting configuration - als upper h: %#04x\n",
> > +		als_upper_h);
> 
> This level of debug doesn't belong in an a driver in upstream. It's useful
> stuff whilst debugging perhaps, but not remote under normal use conditions.
> 
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +		TSL2591_AILTL, als_lower_l);
> As with all the other cases like this reformat to put line breaks
> in places that are better for readability + align with opening brackets
> e.g.
> 
> 	ret = i2c_smbus_write_byte_data(client,
> 					TSL2591_CMD_NOP | TSL2591_AILTL,
> 					als_lower_l);
> 
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als lower threshold\n");
> 
> Don't carry on.  Always return on first error.
> 
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +		TSL2591_AILTH, als_lower_h);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als lower threshold\n");
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +		TSL2591_AIHTL, als_upper_l);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als upper threshold\n");
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +		TSL2591_AIHTH, als_upper_h);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als upper threshold\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_set_als_persist_cycle(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	struct tsl2591_als_settings als_settings = chip->als_settings;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +		TSL2591_PERSIST, als_settings.als_persist);
> 
> Please align parameters with opening bracket where possible (we are a bit
> flexible on this where it would lead to very long lines.  Also, avoid unusual
> line breaks mid parameter if you can.
> 
> 	ret = i2c_smbus_write_byte_data(client,
> 					TSL2591_CMD_NOP | TSL2591_PERSIST,
> 					als_settings.als_persist);
> 
> Is the best we can do with this case.
> 
> 
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to set als persist cycle\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_set_power_state(struct tsl2591_chip *chip, u8 state)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, TSL2591_CMD_NOP |
> > +					TSL2591_ENABLE, state);
> > +	if (ret < 0)
> > +		dev_err(&client->dev,
> > +			"Failed to set the power state to %#04x\n", state);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_get_power_state(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, TSL2591_CMD_NOP |
> > +					TSL2591_ENABLE);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to get power state\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t in_illuminance_integration_time_show(struct device *dev,
> > +						    struct device_attribute *attr,
> > +						    char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +
> > +	int als_int_time = ALS_TIME_SECS_TO_MS(chip->als_settings.als_int_time);
> > +
> > +	return sprintf(buf, "%d\n", als_int_time);
> > +}
> > +
> > +static ssize_t in_illuminance_integration_time_store(struct device *dev,
> > +						     struct device_attribute *attr,
> > +						     const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +
> > +	u32 int_time;
> > +	int value;
> > +
> > +	if (kstrtoint(buf, 0, &value) || !value)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +
> > +	int_time = ALS_TIME_MS_TO_SECS(value);
> > +
> > +	if (tsl2591_compatible_int_time(chip, int_time))
> > +		goto calibrate_error;
> > +
> > +	if (tsl2591_set_als_gain_int_time(chip))
> > +		goto calibrate_error;
> > +
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	return len;
> > +
> > +calibrate_error:
> > +	dev_err(&client->dev, "Failed to calibrate sensor\n");
> > +	mutex_unlock(&chip->als_mutex);
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t in_illuminance_calibscale_show(struct device *dev,
> > +					      struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +
> > +	return sprintf(buf, "%d\n", tsl2591_gain_to_multiplier
> > +		(chip->als_settings.als_gain));
> > +}
> > +
> > +static ssize_t in_illuminance_calibscale_store(struct device *dev,
> > +					       struct device_attribute *attr,
> > +						const char *buf, size_t len)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +
> > +	u8 gain;
> > +	int value;
> > +
> > +	if (kstrtoint(buf, 0, &value) || !value)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +
> > +	gain = tsl2591_multiplier_to_gain(value);
> > +
> > +	if (tsl2591_compatible_gain(chip, gain))
> > +		goto calibrate_error;
> > +
> > +	if (tsl2591_set_als_gain_int_time(chip))
> > +		goto calibrate_error;
> > +
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	return len;
> > +
> > +calibrate_error:
> > +	dev_err(&client->dev, "Failed to calibrate sensor\n");
> > +	mutex_unlock(&chip->als_mutex);
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t in_illuminance_period_available_show(struct device *dev,
> > +						    struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "%s\n",
> > +		       tsl2591_als_period_list[chip->als_settings.als_int_time]);
> > +}
> > +
> > +static IIO_CONST_ATTR(in_illuminance_integration_time_available,
> > +				"100 200 300 400 500 600");
> > +static IIO_CONST_ATTR(in_illuminance_calibscale_available,
> > +				"1 25 428 9876");
> > +static IIO_DEVICE_ATTR_RW(in_illuminance_integration_time, 0);
> > +static IIO_DEVICE_ATTR_RW(in_illuminance_calibscale, 0);
> > +
> > +static struct attribute *tsl2591_sysfs_attrs_ctrl[] = {
> 
> We should only see attrs like this for obscure bits of interface that
> don't form part of the standard IIO interfaces.  These are all
> handled via the info_mask system.
> That brings both advantages in reviewability (as we don't have to check
> the naming etc is as per the ABI) and also make them available for use
> by in kernel consumers of the IIO channels (though for light sensors I don't
> think there are any yet).
> 
> > +	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> 
> We have the read_avail() callback to provide these _available elements.
> Note that it's not universally used yet in IIO as it's a relatively recent
> addition, but I would prefer that new drivers use it.
> Also add BIT(IIO_CHAN_INFO_INT_TIME) to info_mask_shared_by_all_available
> 
> > +	&iio_const_attr_in_illuminance_calibscale_available.dev_attr.attr,
> > +	&iio_dev_attr_in_illuminance_integration_time.dev_attr.attr,
> 
> This is a standard IIO element you can do by adding
> BIT(IIO_CHAN_INFO_INT_TIME) to info_mask_shared_by_all
> 
> > +	&iio_dev_attr_in_illuminance_calibscale.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group tsl2591_sysfs_attribute_group = {
> > +	.attrs = tsl2591_sysfs_attrs_ctrl,
> > +};
> > +
> > +static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
> > +
> > +static struct attribute *tsl2591_event_attrs_ctrl[] = {
> > +	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group tsl2591_event_attribute_group = {
> > +	.attrs = tsl2591_event_attrs_ctrl,
> > +};
> > +
> > +static const struct iio_event_spec tsl2591_events[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	}, {
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	}, {
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_EITHER,
> > +		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
> > +				BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec tsl2591_channels[] = {
> > +	{
> > +		.type = IIO_INTENSITY,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_LIGHT_IR,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +	{
> > +		.type = IIO_INTENSITY,
> > +		.modified = 1,
> > +		.channel2 = IIO_MOD_LIGHT_BOTH,
> > +		.event_spec = tsl2591_events,
> > +		.num_event_specs = ARRAY_SIZE(tsl2591_events),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +	},
> > +	{
> > +		.type = IIO_LIGHT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +	},
> > +};
> > +
> > +static int tsl2591_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +
> > +	dev_dbg(&client->dev, "Reading from sensor");
> 
> Drop this low level debug.   It isn't useful in a production driver.
> It just tells you the function was called and ftrace etc can do that
> much better than a debug print.
> 
> > +
> > +	pm_runtime_get_sync(&chip->client->dev);
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +
> > +	ret = -EINVAL;
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (chan->type == IIO_INTENSITY) {
> 
> Flip condition to reduce deep indenting.
> 
> 		if (chan->type != IIO_INTENSITY)
> 			break;
> 
> 		ret = tsl...
> 
> > +			ret = tsl2591_read_channel_data(indio_dev);
> > +			if (ret < 0)
> > +				break;
> > +
> > +			if (chan->channel2 == IIO_MOD_LIGHT_BOTH) {
> > +				*val = chip->als_readings.als_ch0;
> > +				ret = IIO_VAL_INT;
> > +			} else if (chan->channel2 == IIO_MOD_LIGHT_IR) {
> > +				*val = chip->als_readings.als_ch1;
> > +				ret = IIO_VAL_INT;
> > +			} else {
> > +				ret = -EINVAL;
> > +			}
> > +		}
> > +		break;
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		if (chan->type == IIO_LIGHT) {
> > +			ret = tsl2591_read_channel_data(indio_dev);
> > +			if (ret < 0)
> > +				break;
> > +			*val = chip->als_readings.als_lux_int;
> > +			*val2 = (chip->als_readings.als_lux_decimal * 1000);
> > +			ret = IIO_VAL_INT_PLUS_MICRO;
> > +		}
> > +		break;
> > +	}
> > +
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	pm_runtime_mark_last_busy(&chip->client->dev);
> > +	pm_runtime_put_autosuspend(&chip->client->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_read_event_value(struct iio_dev *indio_dev,
> > +				    const struct iio_chan_spec *chan,
> 
> Fix all this indentation.
> 
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info, int *val,
> > +				int *val2)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +	int als_persist;
> > +	int period;
> > +	int ret;
> > +	int int_time;
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			mutex_lock(&chip->als_mutex);
> 
> As below, I'd take the lock outside of the switch statements.
> 
> > +			*val = chip->als_settings.als_upper_threshold;
> > +			mutex_unlock(&chip->als_mutex);
> > +			break;
> > +		case IIO_EV_DIR_FALLING:
> > +			mutex_lock(&chip->als_mutex);
> > +			*val = chip->als_settings.als_lower_threshold;
> > +			mutex_unlock(&chip->als_mutex);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_EV_INFO_PERIOD:
> > +		mutex_lock(&chip->als_mutex);
> > +
> > +		ret = i2c_smbus_read_byte_data(client,
> > +					       TSL2591_CMD_NOP | TSL2591_PERSIST);
> > +		if (ret <= 0 || ret > TSL2591_PRST_ALS_INT_CYCLE_MAX)
> > +			goto err;
> > +
> > +		als_persist = tsl2591_persist_cycle_to_lit(ret);
> > +		int_time = ALS_TIME_SECS_TO_MS(chip->als_settings.als_int_time);
> > +		period = als_persist * (int_time * MSEC_PER_SEC);
> > +
> > +		*val = period / USEC_PER_SEC;
> > +		*val2 = period % USEC_PER_SEC;
> > +
> > +		mutex_unlock(&chip->als_mutex);
> > +		ret = IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +
> > +err:
> > +	mutex_unlock(&chip->als_mutex);
> > +	return -EINVAL;
> > +}
> > +
> > +static int tsl2591_write_event_value(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info, int val,
> > +				int val2)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	int period, int_time, als_cycle;
> > +
> > +	if (val < 0 || val2 < 0)
> > +		return -EINVAL;
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		if (val > TSL2591_ALS_MAX_VALUE)
> > +			return -EINVAL;
> > +		/* Lower threshold should not be higher than upper */
> 
> I'm guessing that's true in both directions, so if the upper is set
> after the lower (and to a lower value) should fault out here as well.
> 
> As mentioned elsewhere, I wonder if you are better off 'pushing' the other
> threshold as that will look more intuitive to userspace if it is messing
> with these in a silly order (particularly if the event isn't even enabled).
> 
> > +		if (dir == IIO_EV_DIR_FALLING)
> > +			if (val > chip->als_settings.als_upper_threshold)
> > +				return -EINVAL;
> > +
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			mutex_lock(&chip->als_mutex);
> > +			chip->als_settings.als_upper_threshold = val;
> > +			if (tsl2591_set_als_thresholds(chip))
> 
> Never eat the return code from a function and reorg this a tiny
> bit and you can directly return from in here, simplifying the flow
> 
> 			ret = tsl2591_set_als_thresholds(chip);
> 			mutex_unlock(&chip->als_mutex);
> 			return ret;
> 
> Though see below, I think you are better off moving locking outside
> of the switch statement in this case.
> 
> 
> > +				goto err;
> > +			mutex_unlock(&chip->als_mutex);
> > +			break;
> > +		case IIO_EV_DIR_FALLING:
> > +			mutex_lock(&chip->als_mutex);
> > +			chip->als_settings.als_lower_threshold = val;
> > +			if (tsl2591_set_als_thresholds(chip))
> > +				goto err;
> > +			mutex_unlock(&chip->als_mutex);
> 
> As above, don't eat error return and reorder to unlock before checking the
> error code so that you can return directly.
> 
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case IIO_EV_INFO_PERIOD:
> > +		mutex_lock(&chip->als_mutex);
> 
> Given marginally fiddly lock handling, I'd factor this out as as separate
> function.
> 
> > +		int_time = ALS_TIME_SECS_TO_MS(chip->als_settings.als_int_time);
> > +		if (!val && val2)
> > +			period = (val2 / MSEC_PER_SEC) / int_time;
> > +		else if (val && !val2)
> > +			period = (val * MSEC_PER_SEC) / int_time;
> 
> No need for multiple cases.  It's fine to divide 0 by whatever so final
> case is fine in all paths.
> 
> Alternative is to take the local outside of the switch statement.
> All real paths you are going to hit in here will take it anyway and
> if you do that the lock and unlock are more obviously correct.
> 
> > +		else if (val && val2)
> > +			period = ((val * MSEC_PER_SEC) +
> > +				(val2 / MSEC_PER_SEC)) / int_time;
> > +		else
> > +			goto err;
> > +
> > +		als_cycle = tsl2591_persist_lit_to_cycle(period);
> > +		if (als_cycle < 0)
> > +			goto err;
> > +		if (tsl2591_compatible_als_persist(chip, als_cycle))
> > +			goto err;
> > +		if (tsl2591_set_als_persist_cycle(chip))
> > +			goto err;
> > +		mutex_unlock(&chip->als_mutex);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +err:
> > +	mutex_unlock(&chip->als_mutex);
> > +	return -EINVAL;
> return err, not -EINVAL so we get more useful specific errors.
> 
> > +}
> > +
> > +static int tsl2591_read_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +	ret = tsl2591_get_power_state(chip);
> > +	mutex_unlock(&chip->als_mutex);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return !!(ret & TSL2591_ENABLE_ALS_INT);
> 
> Given you have chip->events_enabled, why not just return that
> instead of reading the register? 
> 
> > +}
> > +
> > +static int tsl2591_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				int state)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +
> > +	if (state && !chip->events_enabled) {
> > +		chip->events_enabled = true;
> > +		pm_runtime_get_sync(&client->dev);
> > +	} else if (!state && chip->events_enabled) {
> > +		chip->events_enabled = false;
> > +		pm_runtime_mark_last_busy(&client->dev);
> > +		pm_runtime_put_autosuspend(&client->dev);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info tsl2591_info = {
> > +	.attrs = &tsl2591_sysfs_attribute_group,
> > +	.event_attrs = &tsl2591_event_attribute_group,
> > +	.read_raw = tsl2591_read_raw,
> > +	.read_event_value = tsl2591_read_event_value,
> > +	.write_event_value = tsl2591_write_event_value,
> > +	.read_event_config = tsl2591_read_event_config,
> > +	.write_event_config = tsl2591_write_event_config,
> > +};
> > +
> > +static int __maybe_unused tsl2591_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +	ret = tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static int __maybe_unused tsl2591_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	int ret;
> > +	int power_state;
> > +
> > +	if (chip->events_enabled)
> > +		power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS_INT |
> > +				TSL2591_ENABLE_ALS;
> > +	else
> > +		power_state = TSL2591_PWR_ON | TSL2591_ENABLE_ALS;
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +	ret = tsl2591_set_power_state(chip, power_state);
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops tsl2591_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +				pm_runtime_force_resume)
> > +	SET_RUNTIME_PM_OPS(tsl2591_suspend, tsl2591_resume, NULL)
> > +};
> > +
> > +static irqreturn_t tsl2591_event_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *dev_info = private;
> > +	struct tsl2591_chip *chip = iio_priv(dev_info);
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +
> > +	if (!chip->events_enabled)
> > +		return IRQ_HANDLED;
> > +
> > +	iio_push_event(dev_info,
> > +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> > +					    IIO_EV_TYPE_THRESH,
> > +					IIO_EV_DIR_EITHER),
> 
> Fix alignment so all parameters align with opening bracket.
> 
> > +			iio_get_time_ns(dev_info));
> > +
> > +	/* Clear ALS irq */
> > +	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> > +	if (ret < 0)
> > +		dev_err(&client->dev, "Failed to clear als irq\n");
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int tsl2591_load_defaults(struct tsl2591_chip *chip)
> > +{
> > +	struct i2c_client *client = chip->client;
> > +
> > +	chip->als_settings.als_int_time = TSL2591_DEFAULT_ALS_INT_TIME;
> > +	chip->als_settings.als_gain = TSL2591_DEFAULT_ALS_GAIN;
> > +	chip->als_settings.als_persist = TSL2591_DEFAULT_ALS_PERSIST;
> > +	chip->als_settings.als_lower_threshold =
> > +		TSL2591_DEFAULT_ALS_LOWER_THRESHOLD;
> > +	chip->als_settings.als_upper_threshold =
> > +		TSL2591_DEFAULT_ALS_UPPER_THRESHOLD;
> > +
> 	ret = tsl2591_set_als_gain_int_time(chip);
> 	if (ret)
> 		reutrn ret;
> 
> That way we avoid removing information on the error that occurred which
> has been passed up from lower level functions.
> 
> Please adopt this style throughout.
> 
> > +	if (tsl2591_set_als_gain_int_time(chip)) {
> > +		dev_err(&client->dev, "Failed to set als gain and int time\n");
> 
> tsl2591_set_als_gain_int_time() has already printed an equivalent error message
> in this path so no point in doing so again.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (tsl2591_set_als_persist_cycle(chip)) {
> > +		dev_err(&client->dev, "Failed to set als persist cycle\n");
> 
> As previous, both on message and returning error reported by lower levels.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (tsl2591_set_als_thresholds(chip)) {
> > +		dev_err(&client->dev, "Failed to set als thresholds\n");
> > +		return -EINVAL;
> 
> As above.
> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void tsl2591_chip_off(void *data)
> > +{
> > +	struct iio_dev *indio_dev = data;
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +
> > +	pm_runtime_disable(&client->dev);
> > +	pm_runtime_set_suspended(&client->dev);
> > +	pm_runtime_put_noidle(&client->dev);
> > +
> > +	tsl2591_set_power_state(chip, TSL2591_PWR_OFF);
> > +}
> > +
> > +static int tsl2591_probe(struct i2c_client *client)
> > +{
> > +	struct tsl2591_chip *chip;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter,
> > +				     I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +		dev_err(&client->dev,
> > +			"I2C smbus byte data functionality is not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	chip = iio_priv(indio_dev);
> > +	chip->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	if (client->irq) {
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, tsl2591_event_handler,
> > +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +				"tsl2591_irq", indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "IRQ request error %d\n", -ret);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	mutex_init(&chip->als_mutex);
> > +
> > +	ret = i2c_smbus_read_byte_data(client,
> > +				       TSL2591_CMD_NOP | TSL2591_DEVICE_ID);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"Failed to read the device ID register\n");
> > +		return ret;
> > +	}
> > +
> > +	if ((ret & TSL2591_DEVICE_ID_MASK) != TSL2591_DEVICE_ID_VAL) {
> > +		dev_err(&client->dev, "Device ID: %#04x unknown\n", ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	indio_dev->info = &tsl2591_info;
> > +	indio_dev->channels = tsl2591_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tsl2591_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->name = chip->client->name;
> > +	chip->events_enabled = false;
> > +
> > +	pm_runtime_enable(&client->dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev,
> > +					 TSL2591_POWER_OFF_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +
> > +	if (tsl2591_load_defaults(chip)) {
> > +		dev_err(&client->dev, "Failed to load sensor defaults\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to clear als irq\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Add chip off to automatically managed path */
> > +	ret = devm_add_action_or_reset(&client->dev,
> > +				       tsl2591_chip_off,
> > +					indio_dev);
> 
> Some uneven indentation here.   Also, try to keep things on minimum lines
> possible whilst respecting limit of 80 chars (100 chars if readability
> is helped by being a bit more flexible.
> 
> 	ret = devm_add_action_or_reset(&client->dev, tsl2591_chip_off,
> 				       indio_dev);
> 
> Is appropriate in this case. I'd also expect clear matching between
> what happens in probe and what happens in remove.  Where it is necessary
> to do a little more a comment on why is useful. For example, it's not
> obviously that the power is going to need disabling in the *_chip_off()
> function.
> 
> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id tsl2591_of_match[] = {
> > +	{ .compatible = "amstaos,tsl2591"},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, tsl2591_of_match);
> > +
> > +static struct i2c_driver tsl2591_driver = {
> > +	.driver = {
> > +		.name = "tsl2591",
> > +		.pm = &tsl2591_pm_ops,
> > +		.of_match_table = tsl2591_of_match,
> > +	},
> > +	.probe_new = tsl2591_probe,
> > +};
> > +module_i2c_driver(tsl2591_driver);
> > +
> > +MODULE_AUTHOR("Joe Sandom <joe.g.sandom@gmail.com>");
> > +MODULE_DESCRIPTION("TAOS tsl2591 ambient light sensor driver");
> > +MODULE_LICENSE("GPL");
> 
