Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007543BA965
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhGCQS1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 3 Jul 2021 12:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCQS1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:18:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887D661935;
        Sat,  3 Jul 2021 16:15:50 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:18:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] iio: frequency: adrf6780: add support for ADRF6780
Message-ID: <20210703171813.2ef6215b@jic23-huawei>
In-Reply-To: <PH0PR03MB63663787FD770A037A8593B599019@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210629142308.25868-1-antoniu.miclaus@analog.com>
        <20210629142308.25868-2-antoniu.miclaus@analog.com>
        <CA+U=Dsq6kJjqgPUrZ3SE3+gpGN0e6Lh40dMKTvWs-zOPGN=rOQ@mail.gmail.com>
        <PH0PR03MB63663787FD770A037A8593B599019@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 12:04:16 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hey Alex,
> 
> Thanks for the review,
> 
> > From: Alexandru Ardelean <ardeleanalex@gmail.com>
> > Sent: Wednesday, June 30, 2021 10:38 AM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; LKML <linux-  
> > kernel@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;  
> > devicetree <devicetree@vger.kernel.org>; Rob Herring
> > <robh+dt@kernel.org>
> > Subject: Re: [PATCH 1/2] iio: frequency: adrf6780: add support for
> > ADRF6780
> > 
> > On Tue, Jun 29, 2021 at 5:25 PM Antoniu Miclaus
> > <antoniu.miclaus@analog.com> wrote:  
> > >
> > > Add support for the ADRF6780 microwave upconverter.  
> > 
> > Hey,
> > 
> > A few comments inline.
> > The description of the commit could have a bit more information.
> > Maybe a short description of the chip (typically I'd adapt something
> > from the datasheet).
> > And maybe a link to the datasheet.
> >   
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  drivers/iio/frequency/Kconfig    |  13 +
> > >  drivers/iio/frequency/Makefile   |   1 +
> > >  drivers/iio/frequency/adrf6780.c | 534  
> > +++++++++++++++++++++++++++++++  
> > >  3 files changed, 548 insertions(+)
> > >  create mode 100644 drivers/iio/frequency/adrf6780.c
> > >
> > > diff --git a/drivers/iio/frequency/Kconfig  
> > b/drivers/iio/frequency/Kconfig  
> > > index 240b81502512..fc9751c48f59 100644
> > > --- a/drivers/iio/frequency/Kconfig
> > > +++ b/drivers/iio/frequency/Kconfig
> > > @@ -49,5 +49,18 @@ config ADF4371
> > >
> > >           To compile this driver as a module, choose M here: the
> > >           module will be called adf4371.
> > > +
> > > +config ADRF6780
> > > +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> > > +        depends on SPI
> > > +        depends on COMMON_CLK
> > > +        depends on OF
> > > +        help
> > > +          Say yes here to build support for Analog Devices ADRF6780
> > > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > > +
> > > +          To compile this driver as a module, choose M here: the
> > > +          module will be called adrf6780.
> > > +
> > >  endmenu
> > >  endmenu
> > > diff --git a/drivers/iio/frequency/Makefile  
> > b/drivers/iio/frequency/Makefile  
> > > index 518b1e50caef..ae3136c79202 100644
> > > --- a/drivers/iio/frequency/Makefile
> > > +++ b/drivers/iio/frequency/Makefile
> > > @@ -7,3 +7,4 @@
> > >  obj-$(CONFIG_AD9523) += ad9523.o
> > >  obj-$(CONFIG_ADF4350) += adf4350.o
> > >  obj-$(CONFIG_ADF4371) += adf4371.o
> > > +obj-$(CONFIG_ADRF6780) += adrf6780.o
> > > diff --git a/drivers/iio/frequency/adrf6780.c  
> > b/drivers/iio/frequency/adrf6780.c  
> > > new file mode 100644
> > > index 000000000000..c492c4e4adf1
> > > --- /dev/null
> > > +++ b/drivers/iio/frequency/adrf6780.c
> > > @@ -0,0 +1,534 @@
> > > +// SPDX-License-Identifier: GPL-2.0+  
> > 
> > about the licensing;
> > 
> > SPDX-License-Identifier: GPL-2.0+    ==   MODULE_LICENSE("GPL v2");
> > SPDX-License-Identifier: GPL-2.0    ==   MODULE_LICENSE("GPL v2");
> > 
> > I usually don't care about this licensing details, but it seems to be
> > important elsewhere.
> >   
> > > +/*
> > > + * ADRF6780 driver  
> > 
> > This could be   "Analog Devices ADRF6780 driver"
> >   
> > > + *
> > > + * Copyright 2021 Analog Devices Inc.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/clkdev.h>
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/spi/spi.h>  
> > 
> > Not all these headers look used.
> > For one thing, regmap.h doesn't look used at all.
> > Maybe trim the list.
> >   
> > > +
> > > +/* ADRF6780 Register Map */
> > > +#define ADRF6780_REG_CONTROL                   0x00
> > > +#define ADRF6780_REG_ALARM_READBACK            0x01
> > > +#define ADRF6780_REG_ALARM_MASKS               0x02
> > > +#define ADRF6780_REG_ENABLE                    0x03
> > > +#define ADRF6780_REG_LINEARIZE                 0x04
> > > +#define ADRF6780_REG_LO_PATH                   0x05
> > > +#define ADRF6780_REG_ADC_CONTROL               0x06
> > > +#define ADRF6780_REG_ADC_OUTPUT                        0x0C
> > > +
> > > +/* ADRF6780_REG_CONTROL Map */
> > > +#define ADRF6780_PARITY_EN_MSK                 BIT(15)
> > > +#define ADRF6780_PARITY_EN(x)  
> > FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)  
> > > +#define ADRF6780_SOFT_RESET_MSK                        BIT(14)
> > > +#define ADRF6780_SOFT_RESET(x)  
> > FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)  
> > > +#define ADRF6780_CHIP_ID_MSK                   GENMASK(11, 4)
> > > +#define ADRF6780_CHIP_ID                       0xA
> > > +#define ADRF6780_CHIP_REVISION_MSK             GENMASK(3, 0)
> > > +#define ADRF6780_CHIP_REVISION(x)  
> > FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_ALARM_READBACK Map */
> > > +#define ADRF6780_PARITY_ERROR_MSK              BIT(15)
> > > +#define ADRF6780_PARITY_ERROR(x)  
> > FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)  
> > > +#define ADRF6780_TOO_FEW_ERRORS_MSK            BIT(14)
> > > +#define ADRF6780_TOO_FEW_ERRORS(x)  
> > FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)  
> > > +#define ADRF6780_TOO_MANY_ERRORS_MSK           BIT(13)
> > > +#define ADRF6780_TOO_MANY_ERRORS(x)  
> > FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)  
> > > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK       BIT(12)
> > > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)  
> > FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_ENABLE Map */
> > > +#define ADRF6780_VGA_BUFFER_EN_MSK             BIT(8)
> > > +#define ADRF6780_VGA_BUFFER_EN(x)  
> > FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)  
> > > +#define ADRF6780_DETECTOR_EN_MSK               BIT(7)
> > > +#define ADRF6780_DETECTOR_EN(x)  
> > FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)  
> > > +#define ADRF6780_LO_BUFFER_EN_MSK              BIT(6)
> > > +#define ADRF6780_LO_BUFFER_EN(x)  
> > FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)  
> > > +#define ADRF6780_IF_MODE_EN_MSK                        BIT(5)
> > > +#define ADRF6780_IF_MODE_EN(x)  
> > FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)  
> > > +#define ADRF6780_IQ_MODE_EN_MSK                        BIT(4)
> > > +#define ADRF6780_IQ_MODE_EN(x)  
> > FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)  
> > > +#define ADRF6780_LO_X2_EN_MSK                  BIT(3)
> > > +#define ADRF6780_LO_X2_EN(x)  
> > FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)  
> > > +#define ADRF6780_LO_PPF_EN_MSK                 BIT(2)
> > > +#define ADRF6780_LO_PPF_EN(x)  
> > FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)  
> > > +#define ADRF6780_LO_EN_MSK                     BIT(1)
> > > +#define ADRF6780_LO_EN(x)  
> > FIELD_PREP(ADRF6780_LO_EN_MSK, x)  
> > > +#define ADRF6780_UC_BIAS_EN_MSK                        BIT(0)
> > > +#define ADRF6780_UC_BIAS_EN(x)  
> > FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_LINEARIZE Map */
> > > +#define ADRF6780_RDAC_LINEARIZE_MSK            GENMASK(7, 0)
> > > +#define ADRF6780_RDAC_LINEARIZE(x)  
> > FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_LO_PATH Map */
> > > +#define ADRF6780_LO_SIDEBAND_MSK               BIT(10)
> > > +#define ADRF6780_LO_SIDEBAND(x)  
> > FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)  
> > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK  
> > GENMASK(7, 4)  
> > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)  
> > FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)  
> > > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK  
> > GENMASK(3, 0)  
> > > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)  
> > FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_ADC_CONTROL Map */
> > > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK                BIT(3)
> > > +#define ADRF6780_VDET_OUTPUT_SELECT(x)  
> > FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)  
> > > +#define ADRF6780_ADC_START_MSK                 BIT(2)
> > > +#define ADRF6780_ADC_START(x)  
> > FIELD_PREP(ADRF6780_ADC_START_MSK, x)  
> > > +#define ADRF6780_ADC_EN_MSK                    BIT(1)
> > > +#define ADRF6780_ADC_EN(x)  
> > FIELD_PREP(ADRF6780_ADC_EN_MSK, x)  
> > > +#define ADRF6780_ADC_CLOCK_EN_MSK              BIT(0)
> > > +#define ADRF6780_ADC_CLOCK_EN(x)  
> > FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)  
> > > +
> > > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > > +#define ADRF6780_ADC_STATUS_MSK                        BIT(8)
> > > +#define ADRF6780_ADC_STATUS(x)  
> > FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)  
> > > +#define ADRF6780_ADC_VALUE_MSK                 GENMASK(7, 0)
> > > +#define ADRF6780_ADC_VALUE(x)  
> > FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
> > 
> > The indentation for the bit-values doesn't look consistent in all places.
> >   
> > > +
> > > +enum supported_parts {
> > > +       ADRF6780,
> > > +};  
> > 
> > This enum doesn't seem used anywhere
> >   
> > > +
> > > +struct adrf6780_dev {
> > > +       struct spi_device       *spi;
> > > +       struct clk              *clkin;
> > > +       /* Protect against concurrent accesses to the device */
> > > +       struct mutex            lock;
> > > +       bool                    parity_en;  
> > 
> > Maybe remove this parity check.
> > There are many drivers that support some form of simple error
> > checking, but in the kernel this is typically left up to the SPI
> > framework.
> > So, I'd just disable the error checking entirely.  
> 
> I would just argue here... Though parity check is not the most reliable one
> out there, it does give some extra checking on top of what the SPI framework
> can give (AFAICT). As this part might be used is some  sensitive applications, I
> can imagine someone wanting this extra feature that does not really cost that
> much (if something). However it looks like that on the write side, the only way
> to know about parity issues (or other errors) is to make use of ALM pin.

If there is hardware parity support and we can safely use it (ie. the ALM pin
is connected) then I would support it as always on.

Note I haven't looked at the code yet, so this is just a general principle.

Not something for a module parameter though.  If it's really costly for some reason
we might provide a runtime control to disable it.

> 
> Anyways, I do agree that having this as a devicetree parameter is, at least, arguable
> (I don't think it is terribly wrong though). But I guess that, at least, as a module
> parameter would be something more acceptable.
>  
> Or, as you suggested, It can also be removed and only implemented if someone
> really cares/asks for it...
> 
> - Nuno Sá

