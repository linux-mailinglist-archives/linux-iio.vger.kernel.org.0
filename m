Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C4732FB5D
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 16:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhCFPdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 6 Mar 2021 10:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhCFPdL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 10:33:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA59B64FE4;
        Sat,  6 Mar 2021 15:33:09 +0000 (UTC)
Date:   Sat, 6 Mar 2021 15:33:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Milan Stevanovic <milan.o.stevanovic@gmail.com>,
        linux-iio@vger.kernel.org,
        Tomasz Kazimierz Motyl <tomasz.motyl@se.com>,
        Frederic Loreaud <frederic.loreaud@se.com>,
        Pierre Castellan <pierre.castellan@non.se.com>
Subject: Re: [PATCH] iio:adc: Add RZ/N1D ADC driver
Message-ID: <20210306153306.1d10ffad@archlinux>
In-Reply-To: <4e3c02e-d153-c997-8e34-b8aa7f58584b@pmeerw.net>
References: <20210305105652.107087-1-milan.stevanovic@se.com>
        <4e3c02e-d153-c997-8e34-b8aa7f58584b@pmeerw.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Mar 2021 12:35:52 +0100 (CET)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> >   This is ADC driver that can be found in the Renesas  RZ/N1D SoC
> >   https://www.renesas.com/us/en/document/man/rzn1d-group-rzn1s-group-rzn1l-group-users-manual-peripherals-0?language=en&r=1054561
> >   
> some comments below; some are purely matter-of-taste and can be ignored :)
Thanks Peter.

I'll review on top of yours so hopefully no overlap.

Jonathan


> 
> >   ADC Core Features
> >   - Up to 2 units
> >   - Resolution 12-bit
> >   - Sampling rate from 0.0625 MSPS to 1 MSPS
> >   - Successive approximation
> >   - Maximal conversion time 21 ADC_CLK
> >   - Analog inputs 8 channels per core
> >   (5 standard channels + 3 channels with sample/hold)
> >   - Each channel has his own input trigger to start the conversion,
> >   the triggers are managed by the ADC Controller
> >   - Power down mode
> >   - ADC clock frequency from 4 MHz to 20 MHz
> > 
> > Signed-off-by: Tomasz Kazimierz Motyl <tomasz.motyl@se.com>
> > Signed-off-by: Frederic Loreaud <frederic.loreaud@se.com>
> > Signed-off-by: Pierre Castellan <pierre.castellan@non.se.com>
> > ---
> >  .../devicetree/bindings/iio/adc/rzn1-adc.txt  |  64 ++++
> >  drivers/iio/adc/Kconfig                       |   9 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/rzn1-adc.c                    | 325 ++++++++++++++++++
> >  4 files changed, 399 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
> >  create mode 100644 drivers/iio/adc/rzn1-adc.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt b/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
> > new file mode 100644
> > index 000000000000..ff5b277fb470
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/rzn1-adc.txt
yaml

No new bindings accepted in txt (certainly for IIO, but probably more
general by now).

Binding also needs to be in a separate patch and cc'd to device tree
maintainers and list.

> > @@ -0,0 +1,64 @@
> > +ADC for the Renesas RZ/N1D (R9A06G032).
> > +Specifications on the converters can be found at:
> > +https://www.renesas.com/us/en/document/man/rzn1d-group-rzn1s-group-rzn1l-group-users-manual-peripherals-0?language=en&r=1054561
> > +
> > +Required properties:
> > +
> > +- compatible: Must be "iio,rzn1-adc", "rzn1-adc"
> > +- reg: Offset and length of the register set for the device
> > +- clocks: phandle to the master clock (all_adc)
> > +	see: Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +- clock-names: Must be "rzn1_adc_clk".
> > +
> > +Optional properties:

If optional, you shouldn't print a message if it is not there.

> > +channels:
> > +label: A channel label that is used as channel's extended name part i.e.:
> > +       A label = "temp1"  for channel1@1 results in a following entry in the sysfs:
> > +       /sys/bus/iio/devices/iio:device0/in_voltage1_temp1_raw .
> > +       If the label would not be specified the resulting sysfs entry would be as follows:  
> 
> maybe: If the label is not specified, the results sysfs entry will be as follows:

given we now have
in_voltage1_label well defined via the read_label() callback and that deals
with the mess around extend_name and having to dynamically generate the
chan_spec array, just use that instead.
It's a standard binding in Documentation/devicetree/bindings/iio/adc/adc.yaml

As a side note, bindings don't describe linux behaviour (used across lots
of different software even if they do still hid in the kernel tree) so
drop all this description anyway.


> 
> > +       /sys/bus/iio/devices/iio:device0/in_voltage1_raw .
> > +
> > +
> > +Whenever specified incorrectly or unspecified an entry gets skipped and driver falls back to hard-coded defaults.  
> 
> maybe comma after 'unspecified'
> 
> > +
> > +Example:
> > +
> > +  rzn1_adc: rzn1-adc@0x40065000 {
> > +    #address-cells = <1>;
> > +    #size-cells = <1>;
> > +    compatible = "renesas,r9a06g032-adc", "iio,rzn1-adc", "rzn1-adc";
> > +    reg =  <0x40065000 0x1000>;
> > +    clocks = <&sysctrl R9A06G032_CLK_ADC>;
> > +    clock-names = "rzn1_adc_clk";
> > +    status = "okay";
> > +
> > +       channels {
> > +         #address-cells = <1>;
> > +         #size-cells    = <0>;
> > +
> > +         chan0@0 { /* Channel 0 placeholder */
> > +           reg = <0>;
> > +           label = "adc1_in0";
> > +         };
> > +
> > +         chan1@1 { /* Channel 1 placeholder */
> > +           reg   = <1>;
> > +           label = "adc1_in1";
> > +         };
> > +
> > +         chan2@2 { /* Channel 2 placeholder */
> > +           reg = <2>;
> > +           label = "adc1_in2";
> > +         };
> > +
> > +         chan3@3 { /* Channel 3 placeholder */
> > +           reg   = <3>;
> > +           label = "adc1_in3";
> > +         };
> > +
> > +         chan4@4 { /* Channel 4 placeholder */
> > +           reg = <4>;
> > +           label = "adc1_in4";
> > +         };
> > +      }; /* channels */
> > +    }; /* rzn1-adc */
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index f0af3a42f53c..d4d1af3e6ba2 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -746,6 +746,15 @@ config ROCKCHIP_SARADC
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called rockchip_saradc.
> >  
> > +config RZN1_ADC
> > +	tristate "Renesas ADC driver"

Depends on SOMETHING_RENESAS || COMILE_TEST
would normally be the case to avoid this accidentally turning up in the
distro on my x86 laptop.

> > +	help
> > +	  Say yes here to build support for the ADCs found in SoCs from
> > +	  Renesas.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called rzn1_adc.
> > +
> >  config SC27XX_ADC
> >  	tristate "Spreadtrum SC27xx series PMICs ADC"
> >  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index ef9cc485fb67..562d3ac3c7be 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -70,6 +70,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> >  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> > +obj-$(CONFIG_RZN1_ADC) += rzn1-adc.o
> >  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> >  obj-$(CONFIG_STX104) += stx104.o
> > diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c
> > new file mode 100644
> > index 000000000000..3f5fbb1fd9aa
> > --- /dev/null
> > +++ b/drivers/iio/adc/rzn1-adc.c
> > @@ -0,0 +1,325 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Driver for Renesas RZN1 SoC built-in ADC
> > + *
> > + * Authors:
> > + *  Tomasz Kazimierz Motyl
> > + *  Frédéric Loreaud
> > + *  Pierre Castellan
> > + *
> > + * Copyright (C) 2021 Schneider-Electric
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mutex.h>
> > +#include <linux/completion.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/iio/driver.h>
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <linux/firmware/lces_monitor.h>
> > +#include <linux/delay.h>
> > +#include <linux/bits.h>
> > +
> > +static const uint32_t RZN1_ADC_SET_FORCE_REG_OFFSET = 13 * sizeof(uint32_t);	// force conversion register
Very long lines so think about how to reduce these.
Also, why not just use defines?

> > +
> > +static const uint32_t RZN1_ADC_CONFIG_REG_OFFSET = 16 * sizeof(uint32_t);	// configuration register
> > +static const uint32_t RZN1_ADC_CONFIG_POWER_DOWN_BIT = BIT(3);	// configuration register's power down bit
> > +
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET = 48 * sizeof(uint32_t);	// virtual channels 0..15 control registers
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK = GENMASK(2, 0);	// control registers' virtual channels' bits
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT = BIT(15);	// control registers' enable bit
> > +
> > +static const uint32_t RZN1_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET = 64 * sizeof(uint32_t);	// ADC 1 virtual channels conversion data register
> > +
> > +static const uint32_t RZN1_ADC_READ_DATA_VALUE_MASK = GENMASK(11, 0);	// read data register's bits
> > +static const uint32_t RZN1_ADC_READ_DATA_UPDATE_BIT = BIT(31);	// read data register's update bit
> > +
> > +#define RZN1_ADC_CHANNEL(index, bits, _shift, _info_mask_sep, name) {  \
> > +	.type = IIO_VOLTAGE,                                  \
> > +	.indexed = 1,                                         \
> > +	.channel = index,                                     \  
> 
> maybe also parenthesis, (index)
> 
> > +	.info_mask_separate = _info_mask_sep,                 \
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> > +	.scan_type = {          \
> > +		.sign = 'u',          \
> > +		.realbits = (bits),   \
> > +		.storagebits = 16,    \
> > +		.shift = (_shift),    \
> > +		.endianness = IIO_BE, \
> > +	},                      \
> > +	.extend_name = name,    \
> > +}
> > +
> > +#define RZN1_ADC_NUM_CHANNELS 8	// RZN1 ADC has 8 channels
> > +
> > +static struct iio_chan_spec rzn1_adc_channels[RZN1_ADC_NUM_CHANNELS] = {
const

If you use the label stuff I mention below then driver won't be modifying these.

> > +	RZN1_ADC_CHANNEL(0, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),

Odd to have a parameter then set it to same value in all cases.
RZN1_ADC_CHANNEL(0) looks like enough to me.


> > +	RZN1_ADC_CHANNEL(1, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(2, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(3, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(4, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(5, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(6, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL),
> > +	RZN1_ADC_CHANNEL(7, 12, 0, BIT(IIO_CHAN_INFO_RAW), NULL)
> > +};
> > +
> > +// Device's private data
> > +struct rzn1_adc {
> > +	struct device *dev;
> > +
> > +	struct mutex lock;

Locks should have a comment defining exactly what they are protecting.
Here I think it is serializing reads...

> > +	struct completion complete;
> > +	void __iomem *registers;
> > +	resource_size_t phys_base;
> > +	struct clk *clk;
> > +};
> > +
> > +static inline uint32_t rzn1_adc_read32(struct rzn1_adc *const adc, const uint32_t reg_off)
> > +{
> > +#if defined(CONFIG_LCES_SECURE_MONITOR)
> > +	return __monitor_readl(adc->phys_base + reg_off);
> > +#else
> > +	void __iomem *addr = adc->registers + reg_off;
> > +
> > +	return ioread32(addr);
> > +#endif
> > +}
> > +
> > +static inline void rzn1_adc_write32(struct rzn1_adc *const adc, const uint32_t reg_off, const uint32_t val)
> > +{
> > +#if defined(CONFIG_LCES_SECURE_MONITOR)

Is this upstream?  It sounds like an odd thing to do via a define rather than
some sort of runtime switch.


> > +	__monitor_masked_writel(val, adc->phys_base + reg_off, ~0UL);
> > +#else
> > +	iowrite32(val, adc->registers + reg_off);
> > +#endif
> > +}
> > +
> > +static bool interrupt_status(struct rzn1_adc *const adc, const int virtual_channel)  
> 
> rzn1_adc_ prefix for consistency please
> 
> > +{
> > +	bool ret = false;
> > +
> > +	if ((virtual_channel >= 0) && (virtual_channel < RZN1_ADC_NUM_CHANNELS)) {

I think you've already checked this in the caller. No point in doing it again.


> > +		// interrupt 0 status register has a 0 offset in register table
> > +		uint32_t status = rzn1_adc_read32(adc, 0);
> > +
> > +		if (status & BIT(virtual_channel))
> > +			ret = true;

return true;

or

return status & BIT(virtual_channel);

> > +	}
> > +
> > +	return ret;
return false;

> > +}
> > +
> > +static int rzn1_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> > +{
> > +	int ret = IIO_VAL_INT;
> > +
> > +	struct rzn1_adc *adc = iio_priv(indio_dev);
> > +	int virtual_channel = chan->channel;
> > +	uint32_t virtual_channel_control_offset = RZN1_ADC_VIRTUAL_CHANNNELS_REGS_OFFSET + 4 * virtual_channel;
Rethink naming to reduce length of these lines to manageable level.  Kernel uses
u32 and similar types for internal stuff.
	u32 virt_chan_ctl_off = RZN1_ADC_VIRT_CHAN_REG_OFF + 4 * virt_chan;
for example

> > +	uint32_t virtual_channel_control = RZN1_ADC_VIRTUAL_CHANNEL_ADC1_ENABLE_BIT | (RZN1_ADC_VIRTUAL_CHANNEL_ADC1_SELECTION_MASK & virtual_channel);
> > +	uint32_t read_data = 0;
> > +
> > +	(void)mask;

?  Kernel doesn't care about unused variables in callback functions.

> > +	(void)val2;
> > +
> > +	if ((virtual_channel >= 0) && (virtual_channel < RZN1_ADC_NUM_CHANNELS)) {  
> 
> not sure if the channel number can be invalid, maybe the IIO framework 
> guarantees it is in range

It does though not uncommon to exercise a bit of paranoia and check it
so I don't mind if this stays

> 
> I think it is generally more readable to check for error condition and 
> error out, like so:
> if (sth_wrong) {
>   return -EINVAL;
> }
> sth_right;

Definitely (I'm reviewing backwards so a many comments on this below :)

If you have a mutex held, use a goto unlock; and appropriate label.


> 
> > +		mutex_lock(&adc->lock);
> > +
> > +		// disable power down mode, disable DMA and Sample & Hold mode
> > +		rzn1_adc_write32(adc, RZN1_ADC_CONFIG_REG_OFFSET, 0x00000000);
> > +
> > +		// map virtual to physical channels 1:1
> > +		rzn1_adc_write32(adc, virtual_channel_control_offset, virtual_channel_control);
> > +
> > +		// force conversion on vc[chan_idx] channel
> > +		rzn1_adc_write32(adc, RZN1_ADC_SET_FORCE_REG_OFFSET, BIT(virtual_channel));
> > +
> > +		//  Wait for maximum conversion duration of 21 ADC clock periods
> > +		//  ADC clock frequency is 20 MHz hence period is 50 ns
> > +		//  Add one more period for safety
> > +		ndelay(22 * 50);
> > +
> > +		read_data = rzn1_adc_read32(adc, RZN1_ADC_VIRTUAL_CHANNEL_ADC1_CONVERSION_DATA_REGS_OFFSET + 4 * virtual_channel);
> > +
> > +		if ((read_data & RZN1_ADC_READ_DATA_UPDATE_BIT)
> > +		    && (interrupt_status(adc, virtual_channel) == true))
> > +			*val = read_data & RZN1_ADC_READ_DATA_VALUE_MASK;
> > +		else
> > +			ret = -EINVAL;	// error reading input value
> > +
> > +		// enable power down mode, keep DMA and Sample & Hold mode disabled
> > +		rzn1_adc_write32(adc, RZN1_ADC_CONFIG_REG_OFFSET, RZN1_ADC_CONFIG_POWER_DOWN_BIT);
> > +
> > +		mutex_unlock(&adc->lock);
> > +	} else {
> > +		dev_err(adc->dev, "virtual channel index (%i) is greater than 16\n", virtual_channel);  
> 
> why 16? _NUM_CHANNELS is 8?
> 
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info rzn1_adc_info = {
> > +	.read_raw = &rzn1_adc_read_raw
> > +};
> > +
> > +static int rzn1_adc_parse_channels_of(struct rzn1_adc *adc, struct device_node *dn, const int num_channels)

Very long lines.  Keep to 80 chars max unless there is a good reason and
a very very good reason is needed to go beyond 100 chars
(usually something like not splitting a string up someone might want to
grep for)

> > +{
> > +	int ret = 0;
> > +

No blank lines in variable declarations unless they add something.

> > +	struct device_node *channels = NULL;  
> 
> no need to initialize
> 
> > +	struct device_node *channel = NULL;  
> 
> put in local scope?
> 
> > +
> > +	channels = of_get_child_by_name(dn, "channels");
> > +	if (channels == NULL) {
> > +		dev_err(adc->dev, "no channels child node found\n");
> > +		ret = -EINVAL;  
> 
> maybe just return -EINVAL here?

As below, definitely so as to allow dropping indentation of following
code.

> 
> > +	} else {
> > +		for_each_available_child_of_node(channels, channel) {
> > +			// Stop parsing channels if any error occured
> > +			if (!ret) {

Just return where you get the error rather than this odd carry on of
the loop whilst not doing anything.

> > +				uint32_t reg = 0;
> > +
> > +				ret = of_property_read_u32(channel, "reg", &reg);
> > +				if (ret) {
> > +					dev_err(adc->dev, "no reg child node found\n");

return ret;

> > +				} else {
> > +					if (reg >= num_channels) {
> > +						dev_err(adc->dev, "wrong reg child node value %i\n", reg);
> > +						ret = -EINVAL;

return -EINVAL;

> > +					} else {
> > +						struct iio_chan_spec *chanp = &rzn1_adc_channels[reg];
> > +						chanp->extend_name = of_get_property(channel, "label", NULL);

We now have a core support for a _label attribute for channels.  That's
a much nicer interface than extend_name ever was so please switch
over to that.  It uses the read_label() callback.

> > +					}
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int setup_channel_names(struct rzn1_adc *adc, struct iio_dev *const indio_dev)  

This wrapper doesn't do much, so I'd just call the parse_channels_of() directly
at the call site.

> 
> rzn1_adc_ prefix?
> 
> > +{
> > +	//struct iio_chan_spec rzn1_adc_channels  
> 
> drop comment
> 
> > +	struct device_node *dn = indio_dev->dev.of_node;
> > +	int err = rzn1_adc_parse_channels_of(adc, dn, indio_dev->num_channels);  
> 
> maybe err -> ret?
> 
> > +
> > +	if (err < 0)
> > +		dev_warn(adc->dev, "unable to parse channels!\n");

Not fatal?  Sounds like it probably should be, or we shouldn't be warning.

> > +
> > +	return err;
> > +}
> > +
> > +static int rzn1_adc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct iio_dev *indio_dev = NULL;  
> 
> no need to initialize
> 
> > +	struct rzn1_adc *adc = NULL;
> > +	struct resource *res = NULL;  
> 
> put in local scope, init needed?
> 
> > +	int ret = 0;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> > +
> > +	if (indio_dev == NULL) {
> > +		dev_err(&pdev->dev, "Failed to allocate memory for an IIO device!\n");
> > +		ret = -ENOMEM;  
> 
> just return -ENOMEM?

Absolutely.

> 
> > +	} else {

returning above also means you can drop indentation here.
If you do the devm_ stuff I've commented on in remove I suspect
platform_set_drvdata() isn't needed any more.

> > +		platform_set_drvdata(pdev, indio_dev);
> > +
> > +		adc = iio_priv(indio_dev);
> > +
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		// initilize private physical address for RZN1 secure monitor calls

In  IIO, all comments use /* */ syntax.

> > +		adc->phys_base = res->start;
> > +		adc->registers = devm_ioremap_resource(dev, res);
> > +
> > +		if (IS_ERR(adc->registers)) {
> > +			dev_err(dev, "Unable to acquire memory mapping for the registers!\n");
> > +			ret = PTR_ERR(adc->registers);

return PTR_ERR(adc->registers);

> > +		} else {

Having returned above can drop indent.

> > +			platform_set_drvdata(pdev, indio_dev);
> > +			adc->dev = dev;
> > +
> > +			// Enabling clock for the ADC
> > +			adc->clk = devm_clk_get(&pdev->dev, "rzn1_adc_clk");
> > +
> > +			if (IS_ERR(adc->clk)) {
> > +				dev_err(dev, "Failed to get the clock!\n");
> > +				ret = PTR_ERR(adc->clk);

return PTR_ERR() etc

> > +			} else {
> > +				ret = clk_prepare_enable(adc->clk);

Use devm_add_action_or_reset() to ensure this is disable on error or remove.
Lots of examples of this in other drivers.

> > +				if (ret) {
> > +					dev_err(dev, "Could not prepare or enable the clock!\n");

That's a failure case if it happens (I would imagine) so why not error out here.
If it's optional then make that clear with a comment or similar.

> > +				} else {
> > +					dev_info(dev, "ADC clock rate: %lu Hz\n", clk_get_rate(adc->clk));

Is that interesting to a normal user?  If not, dev_dbg()

> > +
> > +					mutex_init(&adc->lock);
> > +					init_completion(&adc->complete);
> > +
> > +					indio_dev->name = dev_name(dev);

I'm lazy - what does that end up as?  This should be a part number or similar.

> > +					indio_dev->dev.parent = dev;
> > +					indio_dev->dev.of_node = pdev->dev.of_node;
> > +					indio_dev->info = &rzn1_adc_info;
> > +					indio_dev->modes = INDIO_DIRECT_MODE;
> > +					indio_dev->channels = rzn1_adc_channels;
> > +					indio_dev->num_channels = ARRAY_SIZE(rzn1_adc_channels);
> > +
> > +					if (setup_channel_names(adc, indio_dev) < 0)
> > +						dev_warn(dev, "Invalid channels information - using defaults.\n");
> > +
> > +					ret = iio_device_register(indio_dev);
> > +					if (ret) {
> > +						dev_err(dev, "Failed to register IIO device %s': %d\n", indio_dev->name, ret);
> > +					}  
> 
> avoid nested blocks
> shouldn't the clock be disabled on failure?
> 
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int rzn1_adc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_map_array_unregister(indio_dev);

Hmm.. We still don't have devm_iio_map_array_register and probably should by
now. In meantime (if you don't want to add it) you can use
devm_add_action_or_reset() to register automated unwinding of this
and then use devm_iio_device_register() and get rid of _remove() entirely.


> > +
> > +	return 0;
> > +}
> > +
> > +static const struct platform_device_id rzn1_adc_ids[] = {
> > +	{ .name = "rzn1-adc", },

Do we actually need this?  I'm guessing all modern platforms
are DT based and won't use this?

> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(platform, rzn1_adc_ids);
> > +
> > +static const struct of_device_id rzn1_adc_dt_ids[] = {
> > +	{ .compatible = "rzn1-adc", },

Vendor prefix

> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, rzn1_adc_dt_ids);
> > +
> > +static struct platform_driver rzn1_adc_driver = {
> > +	.driver = {
> > +		   .name = "rzn1-adc",
> > +		   .of_match_table = of_match_ptr(rzn1_adc_dt_ids),

Whilst I guess we can be fairly sure this driver will only ever be
used with DT, our preference in IIO is to not use the of_match_ptr
protection and just potentially waste a tiny bit of storage if
the driver is built for a non DT system.

Main reason for this is to reduce places it can be cut and paste
from where other firmware options are common (this blocks use of
ACPI PRP0001 based bindings for example)

> > +		    },

Indent of that bracket is unusual.  Normally aligns with .

> > +	.probe = rzn1_adc_probe,
> > +	.remove = rzn1_adc_remove,
> > +	.id_table = rzn1_adc_ids,
> > +};
> > +
> > +module_platform_driver(rzn1_adc_driver);
> > +
> > +MODULE_DESCRIPTION("RZN1 ADC Driver for LCES2");
> > +MODULE_AUTHOR("Tomasz Kazimierz Motyl <Tomasz.Motyl@schneider-electric.com>");
> > +MODULE_LICENSE("GPL");
> >   
> 

