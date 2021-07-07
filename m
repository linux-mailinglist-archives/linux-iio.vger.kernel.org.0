Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7253BE4CE
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 10:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGGI7e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 7 Jul 2021 04:59:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3371 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhGGI7e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 04:59:34 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GKY1474CLz6J68Z;
        Wed,  7 Jul 2021 16:46:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 10:56:47 +0200
Received: from localhost (10.47.89.60) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 7 Jul 2021
 09:56:46 +0100
Date:   Wed, 7 Jul 2021 09:56:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Message-ID: <20210707095629.00004bb8@Huawei.com>
In-Reply-To: <PH0PR03MB6366BC5E806B18A8889EDDE9991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
        <20210703175716.7864358a@jic23-huawei>
        <PH0PR03MB63667CCA2691D4A43F28041E991C9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210706100405.00001507@Huawei.com>
        <PH0PR03MB6366190FBDC12B1AD1CCBC43991B9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <PH0PR03MB6366BC5E806B18A8889EDDE9991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.89.60]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 7 Jul 2021 08:26:59 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Tuesday, July 6, 2021 12:23 PM
> > To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org
> > Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> > ADRF6780
> > 
> > 
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Tuesday, July 6, 2021 11:04 AM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> > > <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > robh+dt@kernel.org
> > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> > > ADRF6780
> > >
> > > On Mon, 5 Jul 2021 10:18:51 +0000
> > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > >  
> > > > > -----Original Message-----
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Saturday, July 3, 2021 6:57 PM
> > > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > devicetree@vger.kernel.org; robh+dt@kernel.org
> > > > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support  
> > > for  
> > > > > ADRF6780
> > > > >
> > > > > On Fri, 2 Jul 2021 14:12:38 +0300
> > > > > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > > > >  
> > > > > > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > > > > > microwave upconverter optimized for point to point microwave
> > > > > > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > > > > > range.
> > > > > >
> > > > > > Datasheet:
> > > > > > https://www.analog.com/media/en/technical-  
> > > documentation/data-  
> > > > > sheets/ADRF6780.pdf  
> > > > > >
> > > > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> > > > >
> > > > > Hi Antoniu,
> > > > >
> > > > > Frequency drivers are fairly unusual so if you could add a listing of
> > > > > the attributes in sysfs that would be great (it's nice practice  
> > anyway  
> > > but  
> > > > > I don't insist on it!)
> > > > >
> > > > > Various fairly minor comments inline.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Jonathan
> > > > >
> > > > >  
> > > > > > ---
> > > > > >  changes in v4:
> > > > > >   - change license to: GPL-2.0-only
> > > > > >  drivers/iio/frequency/Kconfig    |  13 +
> > > > > >  drivers/iio/frequency/Makefile   |   1 +
> > > > > >  drivers/iio/frequency/adrf6780.c | 498  
> > > > > +++++++++++++++++++++++++++++++  
> > > > > >  3 files changed, 512 insertions(+)
> > > > > >  create mode 100644 drivers/iio/frequency/adrf6780.c
> > > > > >
> > > > > > diff --git a/drivers/iio/frequency/Kconfig  
> > > > > b/drivers/iio/frequency/Kconfig  
> > > > > > index 240b81502512..fc9751c48f59 100644
> > > > > > --- a/drivers/iio/frequency/Kconfig
> > > > > > +++ b/drivers/iio/frequency/Kconfig
> > > > > > @@ -49,5 +49,18 @@ config ADF4371
> > > > > >
> > > > > >  	  To compile this driver as a module, choose M here:  
> > the  
> > > > > >  	  module will be called adf4371.
> > > > > > +
> > > > > > +config ADRF6780
> > > > > > +        tristate "Analog Devices ADRF6780 Microwave  
> > Upconverter"  
> > > > > > +        depends on SPI
> > > > > > +        depends on COMMON_CLK
> > > > > > +        depends on OF  
> > > > >
> > > > > Why?  Pretty much everything seems to have defaults if not  
> > > provided  
> > > > > via OF.
> > > > > I've asked for the generic firmware functions anyway, so you can  
> > > drop  
> > > > > this
> > > > > for that reason if nothing else!
> > > > >  
> > > > > > +        help
> > > > > > +          Say yes here to build support for Analog Devices  
> > ADRF6780  
> > > > > > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > > > > > +
> > > > > > +          To compile this driver as a module, choose M here: the
> > > > > > +          module will be called adrf6780.
> > > > > > +
> > > > > >  endmenu
> > > > > >  endmenu
> > > > > > diff --git a/drivers/iio/frequency/Makefile  
> > > > > b/drivers/iio/frequency/Makefile  
> > > > > > index 518b1e50caef..ae3136c79202 100644
> > > > > > --- a/drivers/iio/frequency/Makefile
> > > > > > +++ b/drivers/iio/frequency/Makefile
> > > > > > @@ -7,3 +7,4 @@
> > > > > >  obj-$(CONFIG_AD9523) += ad9523.o
> > > > > >  obj-$(CONFIG_ADF4350) += adf4350.o
> > > > > >  obj-$(CONFIG_ADF4371) += adf4371.o
> > > > > > +obj-$(CONFIG_ADRF6780) += adrf6780.o
> > > > > > diff --git a/drivers/iio/frequency/adrf6780.c  
> > > > > b/drivers/iio/frequency/adrf6780.c  
> > > > > > new file mode 100644
> > > > > > index 000000000000..472a66f90c7f
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/iio/frequency/adrf6780.c
> > > > > > @@ -0,0 +1,498 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * ADRF6780 driver
> > > > > > + *
> > > > > > + * Copyright 2021 Analog Devices Inc.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/bitfield.h>
> > > > > > +#include <linux/bits.h>
> > > > > > +#include <linux/clk.h>
> > > > > > +#include <linux/clkdev.h>
> > > > > > +#include <linux/clk-provider.h>
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/iio/iio.h>
> > > > > > +#include <linux/module.h>  
> > > > >
> > > > > #include <linux/mod_devicetable.h>
> > > > >  
> > > > > > +#include <linux/spi/spi.h>
> > > > > > +
> > > > > > +/* ADRF6780 Register Map */
> > > > > > +#define ADRF6780_REG_CONTROL			0x00
> > > > > > +#define ADRF6780_REG_ALARM_READBACK		0x01
> > > > > > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > > > > > +#define ADRF6780_REG_ENABLE			0x03
> > > > > > +#define ADRF6780_REG_LINEARIZE			0x04
> > > > > > +#define ADRF6780_REG_LO_PATH			0x05
> > > > > > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > > > > > +#define ADRF6780_REG_ADC_OUTPUT  
> > 	0x0C  
> > > > > > +
> > > > > > +/* ADRF6780_REG_CONTROL Map */
> > > > > > +#define ADRF6780_PARITY_EN_MSK			BIT(15)
> > > > > > +#define ADRF6780_PARITY_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)  
> > > > > > +#define ADRF6780_SOFT_RESET_MSK  
> > 	BIT(14)  
> > > > > > +#define ADRF6780_SOFT_RESET(x)  
> > > > > 	FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)  
> > > > > > +#define ADRF6780_CHIP_ID_MSK  
> > > 	GENMASK(11, 4)  
> > > > > > +#define ADRF6780_CHIP_ID			0xA
> > > > > > +#define ADRF6780_CHIP_REVISION_MSK  
> > > 	GENMASK(3, 0)  
> > > > > > +#define ADRF6780_CHIP_REVISION(x)  
> > > > > 	FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_ALARM_READBACK Map */
> > > > > > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > > > > > +#define ADRF6780_PARITY_ERROR(x)  
> > > > > 	FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)  
> > > > > > +#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
> > > > > > +#define ADRF6780_TOO_FEW_ERRORS(x)  
> > > > > 	FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)  
> > > > > > +#define ADRF6780_TOO_MANY_ERRORS_MSK  
> > 	BIT(13)  
> > > > > > +#define ADRF6780_TOO_MANY_ERRORS(x)  
> > > > > 	FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)  
> > > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> > > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_ENABLE Map */
> > > > > > +#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
> > > > > > +#define ADRF6780_VGA_BUFFER_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)  
> > > > > > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > > > > > +#define ADRF6780_DETECTOR_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)  
> > > > > > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > > > > > +#define ADRF6780_LO_BUFFER_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)  
> > > > > > +#define ADRF6780_IF_MODE_EN_MSK  
> > 	BIT(5)  
> > > > > > +#define ADRF6780_IF_MODE_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)  
> > > > > > +#define ADRF6780_IQ_MODE_EN_MSK  
> > > 	BIT(4)  
> > > > > > +#define ADRF6780_IQ_MODE_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)  
> > > > > > +#define ADRF6780_LO_X2_EN_MSK			BIT(3)
> > > > > > +#define ADRF6780_LO_X2_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)  
> > > > > > +#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
> > > > > > +#define ADRF6780_LO_PPF_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)  
> > > > > > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > > > > > +#define ADRF6780_LO_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_LO_EN_MSK, x)  
> > > > > > +#define ADRF6780_UC_BIAS_EN_MSK  
> > 	BIT(0)  
> > > > > > +#define ADRF6780_UC_BIAS_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_LINEARIZE Map */
> > > > > > +#define ADRF6780_RDAC_LINEARIZE_MSK  
> > > 	GENMASK(7, 0)  
> > > > > > +#define ADRF6780_RDAC_LINEARIZE(x)  
> > > > > 	FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_LO_PATH Map */
> > > > > > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > > > > > +#define ADRF6780_LO_SIDEBAND(x)  
> > > > > 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)  
> > > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK  
> > > > > 	GENMASK(7, 4)  
> > > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)  
> > > > > 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)  
> > > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK  
> > > > > 	GENMASK(3, 0)  
> > > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)  
> > > > > 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_ADC_CONTROL Map */
> > > > > > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK  
> > > 	BIT(3)  
> > > > > > +#define ADRF6780_VDET_OUTPUT_SELECT(x)  
> > > > > 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)  
> > > > > > +#define ADRF6780_ADC_START_MSK			BIT(2)
> > > > > > +#define ADRF6780_ADC_START(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADC_START_MSK, x)  
> > > > > > +#define ADRF6780_ADC_EN_MSK			BIT(1)
> > > > > > +#define ADRF6780_ADC_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADC_EN_MSK, x)  
> > > > > > +#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
> > > > > > +#define ADRF6780_ADC_CLOCK_EN(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)  
> > > > > > +
> > > > > > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > > > > > +#define ADRF6780_ADC_STATUS_MSK  
> > 	BIT(8)  
> > > > > > +#define ADRF6780_ADC_STATUS(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)  
> > > > > > +#define ADRF6780_ADC_VALUE_MSK  
> > > > > 	GENMASK(7, 0)  
> > > > > > +#define ADRF6780_ADC_VALUE(x)  
> > > > > 	FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
> > > > >
> > > > > Not used.  In general, just use FIELD_PREP / FIELD_GET inline  
> > > rather  
> > > > > than having extra
> > > > > macros like these. That approach is simpler for reviewers to  
> > follow.  
> > > > >  
> > > > > > +
> > > > > > +struct adrf6780_dev {
> > > > > > +	struct spi_device	*spi;
> > > > > > +	struct clk		*clkin;
> > > > > > +	/* Protect against concurrent accesses to the device */
> > > > > > +	struct mutex		lock;
> > > > > > +	bool			vga_buff_en;
> > > > > > +	bool			lo_buff_en;
> > > > > > +	bool			if_mode_en;
> > > > > > +	bool			iq_mode_en;
> > > > > > +	bool			lo_x2_en;
> > > > > > +	bool			lo_ppf_en;
> > > > > > +	bool			lo_en;
> > > > > > +	bool			uc_bias_en;
> > > > > > +	bool			lo_sideband;
> > > > > > +	bool			vdet_out_en;
> > > > > > +};
> > > > > > +
> > > > > > +static int adrf6780_spi_read(struct adrf6780_dev *dev,  
> > > unsigned int  
> > > > > reg,  
> > > > > > +			      unsigned int *val)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +	unsigned int temp;
> > > > > > +	struct spi_transfer t = {0};
> > > > > > +	u8 data[3];
> > > > > > +
> > > > > > +	data[0] = 0x80 | (reg << 1);
> > > > > > +	data[1] = 0x0;
> > > > > > +	data[2] = 0x0;
> > > > > > +
> > > > > > +	t.rx_buf = &data[0];
> > > > > > +	t.tx_buf = &data[0];
> > > > > > +	t.len = 3;
> > > > > > +
> > > > > > +	ret = spi_sync_transfer(dev->spi, &t, 1);  
> > > > >
> > > > > data needs to be dma safe.
> > > > >  
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	temp = ((data[0] | 0x80 | (reg << 1)) << 16) |
> > > > > > +		(data[1] << 8) | data[2];  
> > > > >
> > > > > Ouch. That's a bit nasty, but why are you writing the reg into
> > > > > it?  Looks like a get_unaligned_be24() >> 1 and a 16bit mask.
> > > > > (use GENMASK(15, 0) for that to make it apparent what is  
> > > happening.  
> > > > >  
> > > > > > +
> > > > > > +	*val = (temp >> 1) & 0xFFFF;
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > > > > > +				      unsigned int reg,
> > > > > > +				      unsigned int val)
> > > > > > +{
> > > > > > +	u8 data[3];
> > > > > > +
> > > > > > +	val = (val << 1);
> > > > > > +
> > > > > > +	data[0] = (reg << 1) | (val >> 16);
> > > > > > +	data[1] = val >> 8;
> > > > > > +	data[2] = val;  
> > > > >
> > > > > An opportunity for
> > > > > put_unaligned_be24() with a value of (I think)
> > > > >
> > > > > (val << 1) | (reg << 17)
> > > > >
> > > > >  
> > > > > > +
> > > > > > +	return spi_write(dev->spi, &data[0], 3);  
> > > > >
> > > > > Needs a dma safe buffer, which basically means it can't be on the
> > > > > stack.
> > > > > Lots of ways of handling that, but look for __cacheline_aligned in  
> > > IIO  
> > > > > drivers
> > > > > to see the one we probably use mostly commonly in IIO drivers.  
> > > >
> > > > Hi Jonathan,
> > > >
> > > > This is something I wanted to ask for some time so I will take the  
> > > opportunity here :).  
> > > > Is this something you prefer just not to risk at all and make it an  
> > hard  
> > > requirement  
> > > > (which is fair)? ...  
> > >
> > > Yes, I think we need to keep this as a hard requirement.
> > > There are drivers out there which we missed this on in the past, and
> > > I'm not necessarily
> > > going to take the time to go through them all as this can be hard to
> > > spot, but lets not
> > > introduce any more potential problems.
> > >  
> > 
> > I see. That makes sense and it's fair :). The only annoying (but not too
> > annoying :)) is that
> > making the data/buffer global forces you to use a lock in cases you
> > potentially would
> > not have too (just using local buffers). But that's life, better play safe :)
> >   
> > > >
> > > > I'm asking this because, tbh, I would be very surprised if any spi/i2c  
> > > controller out there  
> > > > is using dma for a 3byte transfer. I guess the overhead of setting it  
> > up  
> > > is probably not  
> > > > worth it...  
> > >
> > > There are (I believe) a few i2c and spi controllers out there that don't
> > > do anything other
> > > than DMA.  Wolfram mentioned one of those in his talk on adding
> > > DMA support to i2c.  
> > 
> > Hmm, I see...
> >   
> > > Also, the reference in the file below to the wonderful case of USB to
> > > i2c bridges that always
> > > require DMA safe buffers.  
> > 
> > Indeed it does.
> >   
> 
> Hi Jonathan,
> 
> Just for closure, I also realized that the pattern in IIO looks to be to use
> DMA safe buffers only on the tx side. For instance in the IMU lib [1],
> only the tx buffer is safe (well, I think there's problem with this as
> I believe all spi transfers buffers should be properly aligned which won't
> be the case in the IMU lib). Is there any reason for this? AFAICT, we should
> also take care with rx buffers or am I missing something?
Ah.  So this is a fun corner :)

The reason cache line corruption can occur is as follows.
1. DMA starts, typically involving some tx and rx usage by the device.
   This flushes the CPU caches for the relevant lines. 
... whilst DMA is not completed ...
2. The host software pulls the line into it's cache and updates something (say a flag
   elsewhere in that cacheline).
3. Cacheline is evicted from the CPU cache causing a write back.
4. Device then writes back the stuff it had cached locally which is allowed to include data
   it wasn't accessing in the same cache line.  Boom, it just overwrote the flag we updated
   with an older value.  Basically this is a performance optimization / simplification
   the DMA engine is allowed to make.  Note I believe they are 'technically' allowed to
   write back to the RX buffers as well, though not sure what devices do this for i2c/spi.

So, why do we only need to force one of the buffers to the start of a cacheline?

What we are actually doing, is not keeping the buffer in it's own cacheline, but rather
making sure nothing else is in the same cacheline (so there is no race as above).
(it's easier to move the buffer, than to ensure everything else is moved out of the cache
line it happens to be in!)
There is a safe assumption here that the DMA device can't corrupt it's own data as that
would be crazy :)

Hence, pushing the first buffer to the start of a line, allows the second one to be
after it in the same line (it's not a problem if it takes multiple lines)

One more subtlety is why we can be sure nothing else ends up after the buffers.
That's by construction.  The allocations IIO does for those iio_priv structures should
always get padded out to at least the end of the cacheline.
(IIRC, not looked at this code for many years!)

> 
> [1]: https://elixir.bootlin.com/linux/latest/source/include/linux/iio/imu/adis.h#L129
> 
> - Nuno S�

