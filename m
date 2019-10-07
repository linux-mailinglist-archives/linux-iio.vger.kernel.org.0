Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF45CE0F1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 13:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfJGLxQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 07:53:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJGLxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 07:53:16 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85C3AFFAEE359F2DFEA3;
        Mon,  7 Oct 2019 19:53:14 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 19:53:09 +0800
Date:   Mon, 7 Oct 2019 12:52:59 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Message-ID: <20191007125259.00002eba@huawei.com>
In-Reply-To: <fcddb48f722392578431ecccce4862288bbec6ba.camel@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
        <20191006113732.1ffd597c@archlinux>
        <fcddb48f722392578431ecccce4862288bbec6ba.camel@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 09:10:06 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> On Sun, 2019-10-06 at 11:37 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Fri, 4 Oct 2019 15:55:18 +0200
> > Nuno Sá <nuno.sa@analog.com> wrote:
> >   
> > > The LTC2983 is a Multi-Sensor High Accuracy Digital Temperature
> > > Measurement System. It measures a wide variety of temperature
> > > sensors and
> > > digitally outputs the result, in °C or °F, with 0.1°C accuracy and
> > > 0.001°C resolution. It can measure the temperature of all standard
> > > thermocouples (type B,E,J,K,N,S,R,T), standard 2-,3-,4-wire RTDs,
> > > thermistors and diodes.
> > > 
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>  
> > 
> > Two things inline that I'd missed before. Otherwise looks good.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > Changes in v2:
> > >  * Added some needed blank lines (for readability);
> > >  * Allocate iio_chan in the setup() function;
> > >  * Rename reset to sleep;
> > >  * Remove unneeded dev_dbg calls;
> > >  * Remove unneeded line wrapping;
> > >  * Remove unneeded comments;
> > >  * Remove extend_names. Use the standard ABI;
> > >  * Adapt the scales to report in millivolt and milli degrees;
> > >  * Adapt the of_property readings to the renaming of the
> > > properties;
> > >  * For custom thermistors, excitation-current cannot be set to Auto
> > > range.
> > > 
> > > Changes in v3:
> > >  * Use normal `devm_request_irq`;
> > >  * Handle and decode the new devicetree properties for sensor
> > > configuration.
> > > 
> > >  MAINTAINERS                       |    7 +
> > >  drivers/iio/temperature/Kconfig   |   10 +
> > >  drivers/iio/temperature/Makefile  |    1 +
> > >  drivers/iio/temperature/ltc2983.c | 1554
> > > +++++++++++++++++++++++++++++
> > >  4 files changed, 1572 insertions(+)
> > >  create mode 100644 drivers/iio/temperature/ltc2983.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f0c03740b9fb..14a256e785ca 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9491,6 +9491,13 @@ S:	Maintained
> > >  F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > >  F:	drivers/iio/dac/ltc1660.c
> > >  
> > > +LTC2983 IIO TEMPERATURE DRIVER
> > > +M:	Nuno Sá <nuno.sa@analog.com>
> > > +W:	http://ez.analog.com/community/linux-device-drivers
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Supported
> > > +F:	drivers/iio/temperature/ltc2983.c
> > > +
> > >  LTC4261 HARDWARE MONITOR DRIVER
> > >  M:	Guenter Roeck <linux@roeck-us.net>
> > >  L:	linux-hwmon@vger.kernel.org
> > > diff --git a/drivers/iio/temperature/Kconfig
> > > b/drivers/iio/temperature/Kconfig
> > > index 737faa0901fe..04b5a67b593c 100644
> > > --- a/drivers/iio/temperature/Kconfig
> > > +++ b/drivers/iio/temperature/Kconfig
> > > @@ -4,6 +4,16 @@
> > >  #
> > >  menu "Temperature sensors"
> > >  
> > > +config LTC2983
> > > +	tristate "Analog Devices Multi-Sensor Digital Temperature
> > > Measurement System"
> > > +	depends on SPI  
> > 
> > Select REGMAP_SPI needed I think.  
> 
> ack.
> 
> > > +	help
> > > +	  Say yes here to build support for the LTC2983 Multi-Sensor
> > > +	  high accuracy digital temperature measurement system.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called ltc2983.
> > > +
> > >  config MAXIM_THERMOCOUPLE
> > >  	tristate "Maxim thermocouple sensors"
> > >  	depends on SPI
> > > diff --git a/drivers/iio/temperature/Makefile
> > > b/drivers/iio/temperature/Makefile
> > > index baca4776ca0d..d6b850b0cf63 100644
> > > --- a/drivers/iio/temperature/Makefile
> > > +++ b/drivers/iio/temperature/Makefile
> > > @@ -3,6 +3,7 @@
> > >  # Makefile for industrial I/O temperature drivers
> > >  #
> > >  
> > > +obj-$(CONFIG_LTC2983) += ltc2983.o
> > >  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> > >  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> > >  obj-$(CONFIG_MAX31856) += max31856.o
> > > diff --git a/drivers/iio/temperature/ltc2983.c
> > > b/drivers/iio/temperature/ltc2983.c
> > > new file mode 100644
> > > index 000000000000..f899c1d75f8a
> > > --- /dev/null
> > > +++ b/drivers/iio/temperature/ltc2983.c
> > > @@ -0,0 +1,1554 @@  
> > ...
> >   
> > > +static int ltc2983_chan_read(struct ltc2983_data *st,
> > > +			const struct ltc2983_sensor *sensor, int *val)
> > > +{
> > > +	u32 start_conversion = 0;
> > > +	int ret;
> > > +	unsigned long time;
> > > +	__be32 temp;
> > > +
> > > +	/*
> > > +	 * Do not allow channel readings if device is in sleep state.
> > > +	 * A read/write on the spi bus would bring the device
> > > prematurely
> > > +	 * out of sleep.
> > > +	 */
> > > +	if (st->sleep)
> > > +		return -EPERM;
> > > +
> > > +	start_conversion = LTC2983_STATUS_START(true);
> > > +	start_conversion |= LTC2983_STATUS_CHAN_SEL(sensor->chan);
> > > +	dev_dbg(&st->spi->dev, "Start conversion on chan:%d,
> > > status:%02X\n",
> > > +		sensor->chan, start_conversion);
> > > +	/* start conversion */
> > > +	ret = regmap_write(st->regmap, LTC2983_STATUS_REG,
> > > start_conversion);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	reinit_completion(&st->completion);
> > > +	/*
> > > +	 * wait for conversion to complete.
> > > +	 * 300 ms should be more than enough to complete the
> > > conversion.
> > > +	 * Depending on the sensor configuration, there are 2/3
> > > conversions
> > > +	 * cycles of 82ms.
> > > +	 */
> > > +	time = wait_for_completion_timeout(&st->completion,
> > > +					   msecs_to_jiffies(300));
> > > +	if (!time) {
> > > +		dev_warn(&st->spi->dev, "Conversion timed out\n");
> > > +		return -ETIMEDOUT;
> > > +	}
> > > +
> > > +	/* read the converted data */
> > > +	ret = regmap_bulk_read(st->regmap,
> > > LTC2983_CHAN_RES_ADDR(sensor->chan),
> > > +			       &temp, sizeof(temp));  
> > 
> > I'd missed this before.  regmap_bulk_read can directly use the
> > supplied buffer
> > for dma.  Hence it needs to be dma safe.  That means you have to have
> > it
> > in it's own cacheline.  There is no way of enforcing that on the
> > stack so
> > either allocate it locally from the heap, or put it at the end of the
> > data structure and mark it __cacheline_aligned (we make sure those
> > structures
> > are also cacheline aligned and on the heap specifically to allow us
> > to do that
> > trick).  
> 
> Just for my understanding. I do see the the need of using
> __cacheline_aligned on the struct parameter we want to align. I was now
> trying to understand your comment on parenthesis. Why do we need that
> trick? Wouldn't be sufficient to have the struct element marked with
> __cacheline_aligned?
> 

Ah.  That is down to what __cacheline_aligned actually does and
how we create the region accessed by iio_priv()

If we have a stand alone structure allocated with kmalloc with an
element marked __cacheline_aligned it will indeed have the correct
alignment.

iio_priv is done by increasing the size of the memory allocation
done in iio_device_alloc, the iio_priv() pointer then gives us
the address of a region beyond the end of the iio_dev structure.

That region has to also be cacheline aligned so that when we find
the location of the __cacheline_aligned element of the structure
we are putting there (basically an offset from iio_priv) it will
also have the right alignment.

The compiler has no way of knowing we are doing this stuff so it
just adds padding to the private structure on the assumption
the structure itself is aligned.

Jonathan


> >   
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = __be32_to_cpu(temp);
> > > +
> > > +	if (!(LTC2983_RES_VALID_MASK & *val)) {
> > > +		dev_err(&st->spi->dev, "Invalid conversion
> > > detected\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	ret = sensor->fault_handler(st, *val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = sign_extend32((*val) & LTC2983_DATA_MASK,
> > > LTC2983_DATA_SIGN_BIT);
> > > +	return 0;
> > > +}
> > > +  
> > ...  
> 
> Thanks!
> Nuno Sá


