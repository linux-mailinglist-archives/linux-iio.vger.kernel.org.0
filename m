Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26A3189798
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 10:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCRJJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 05:09:38 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:46951 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 05:09:37 -0400
Date:   Wed, 18 Mar 2020 11:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584522574;
        bh=2EG+HTV0ZqvlySCrIfOmh5fswxl5KMpiCY70rvAVfb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYYQ0bXbE2S6/fcsFcOEMQ/iarsr87k9rqWHcZViK66g5Lk8KyI0hLI9oBbxCM5y5
         Ajrh3e3pmFF+jjyBv9LZU0XuZeYvn/xJK4tU2FhW3+ma2cK2ldGaj8q1rntM6k+yOw
         aM7gVRgDHglFYTqMCqaxfey4eK/85BvUXJpSfetnuBwZ0/v26lU+RqTTtPlc1UTAAe
         x9FJjGyabtFbZkAqr1vMi2Ae+tgV582sOpDNb9Lgkgwaj/gTTuJKgrttwI5rOd1Hyy
         nqXu2ByC0ubL41PJitLnwGfvgrY0Qi1YHzuoU1p8RMx9hlyVif3GB9aTXOhre/Kc1F
         awi0o+irQObSQ==
From:   Alexandru Lazar <alazar@startmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
Message-ID: <20200318091407.GA2481@leena.republic>
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2964715e81108283d08258bcfa8420baef36737f.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey,

Thanks for the comments! I'll make the changes that you suggested!

I did run checkpatch.pl -- the only thing it complained about was
that the length of a line in the commit message was too long, and I
don't think I can do anything about it because the line in question is a
file path :-).

otoh I definitely didn't do dt_binding_check, I had no idea that was a
thing. I'll run it and integrate any necessary changes in the revised
version. Thanks!

Best regards,
Alex

On Wed, Mar 18, 2020 at 06:50:41AM +0000, Ardelean, Alexandru wrote:
> On Tue, 2020-03-17 at 22:17 +0200, Alexandru Lazar wrote:
> > [External]
> > 
> > Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
> > includes support for this device's low-power operation mode.
> 
> hey,
> 
> overall looks good;
> 
> i'd run ./scripts/checpatch.pl on the patches a bit;
> you can run it on the patch file, or on the git commit with
> ./scripts/checpatch.pl -g <git-commits>
> 
> i usually do ./scripts/checpatch.pl -g HEAD~2.. [or something like that] before
> generating patches;
> i sometimes forget to do that;  
> 
> some more comments inline
> 
> 
> > 
> > Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> > ---
> >  drivers/iio/adc/Kconfig   |  12 +++
> >  drivers/iio/adc/Makefile  |   1 +
> >  drivers/iio/adc/max1241.c | 215 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 228 insertions(+)
> >  create mode 100644 drivers/iio/adc/max1241.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 5d8540b7b427..3a55beec69c9 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -566,6 +566,18 @@ config MAX1118
> >  	  To compile this driver as a module, choose M here: the module will be
> >  	  called max1118.
> >  
> > +config MAX1241
> > +	tristate "Maxim max1241 ADC driver"
> > +	depends on SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for Maxim max1241 12-bit, single-channel
> > +          ADC.
> 
> nitpick: this looks inconsistently indented
> 
> > +
> > +	  To compile this driver as a module, choose M here: the module will be
> > +	  called max1118.
> > +
> >  config MAX1363
> >  	tristate "Maxim max1363 ADC driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index a1f1fbec0f87..37d6f17559dc 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -54,6 +54,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o
> >  obj-$(CONFIG_MAX1027) += max1027.o
> >  obj-$(CONFIG_MAX11100) += max11100.o
> >  obj-$(CONFIG_MAX1118) += max1118.o
> > +obj-$(CONFIG_MAX1241) += max1241.o
> >  obj-$(CONFIG_MAX1363) += max1363.o
> >  obj-$(CONFIG_MAX9611) += max9611.o
> >  obj-$(CONFIG_MCP320X) += mcp320x.o
> > diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> > new file mode 100644
> > index 000000000000..2bd31f22fb2c
> > --- /dev/null
> > +++ b/drivers/iio/adc/max1241.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MAX1241 low-power, 12-bit serial ADC
> > + *
> > + * Copyright (c) 2020 Ioan-Alexandru Lazar <alazar@startmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License.  See the file COPYING in the main
> > + * directory of this archive for more details.
> 
> This license text is no longer needed.
> The SPDX-License-Identifier header should handle that.
> 
> > + *
> > + * Datasheet: 
> > https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> > + */
> > +
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define MAX1241_VAL_MASK 0xFFF
> > +#define MAX1241_SHDN_DELAY_USEC 4
> > +
> > +enum max1241_id {
> > +	max1241,
> > +};
> > +
> > +struct max1241 {
> > +	struct spi_device *spi;
> > +	struct mutex lock;
> > +	struct regulator *reg;
> > +	struct gpio_desc *shdn;
> > +
> > +	__be16 data ____cacheline_aligned;
> 
> Jonathan may know better than me here, but you could technically avoid needing
> to explicitly use the __be16 datatype; and just use u16;
> 
> i think the SPI framework should have some handling for that;
> maybe using the 'bits_per_word' field;
> you'd probably still need to do the shifting though;
> i remember some discussion about this on ad7949.c
> though there may be other drivers doing this as well
> 
> though, this isn't a big deal; and i don't feel strongly about doing like this
> or some other way;
> this comment tries to be more informative [or just noisy]
> 
> 
> > +};
> > +
> > +static const struct iio_chan_spec max1241_channels[] = {
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				BIT(IIO_CHAN_INFO_SCALE),
> > +		.scan_index = 0,
> > +		.scan_type = {
> > +			.sign = 'u',
> > +			.realbits = 12,
> > +			.storagebits = 16,
> > +		},
> > +	},
> > +};
> > +
> > +static int max1241_read(struct max1241 *adc)
> > +{
> > +	int ret;
> > +	struct spi_device *spi = adc->spi;
> > +	struct spi_transfer xfers[] = {
> > +		/*
> > +		 * Begin conversion by bringing /CS low for at least
> > +		 * tconv us.
> > +		 */
> > +		{
> > +			.len = 0,
> > +			.delay_usecs = 8,
> 
> 'delay_usecs' is going to go away.
> Can you change this to?
> .delay.value = 8,
> .delay.unit = SPI_DELAY_UNIT_USECS.
> 
> SPI_DELAY_UNIT_USECS is 0, so if you don't assign it's fine, but it's a good
> idea to assign it, to make it clear it's usecs
> 
> 
> 
> > +		},
> > +		/*
> > +		 * Then read two bytes of data in our RX buffer.
> > +		 */
> > +		{
> > +			.rx_buf = &adc->data,
> > +			.len = 2,
> > +		},
> > +	};
> > +
> > +	ret = spi_sync_transfer(spi, xfers, 2);
> > +
> > +	return ret;
> > +}
> > +
> > +static int max1241_read_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int *val, int *val2, long mask)
> > +{
> > +	int ret, vref_uV;
> > +	struct max1241 *adc = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&adc->lock);
> > +
> > +		if (adc->shdn) {
> > +			gpiod_set_value(adc->shdn, 0);
> > +			udelay(MAX1241_SHDN_DELAY_USEC);
> > +		}
> > +
> > +		ret = max1241_read(adc);
> > +
> > +		if (adc->shdn)
> > +			gpiod_set_value(adc->shdn, 1);
> > +
> > +		if (ret) {
> > +			mutex_unlock(&adc->lock);
> > +			return ret;
> > +		}
> > +
> > +		*val = (be16_to_cpu(adc->data) >> 3) & MAX1241_VAL_MASK;
> > +
> > +		mutex_unlock(&adc->lock);
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		vref_uV = regulator_get_voltage(adc->reg);
> > +
> > +		if (vref_uV < 0)
> > +			return vref_uV;
> > +
> > +		*val = vref_uV / 1000;
> > +		*val2 = 12;
> > +
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_info max1241_info = {
> > +	.read_raw = max1241_read_raw,
> > +};
> > +
> > +static int max1241_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct max1241 *adc;
> > +	int ret = 0;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	adc = iio_priv(indio_dev);
> > +	adc->spi = spi;
> > +	mutex_init(&adc->lock);
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> > +	if (IS_ERR(adc->reg)) {
> > +		dev_err(&spi->dev, "failed to get vref regulator\n");
> > +		return PTR_ERR(adc->reg);
> > +	}
> > +
> > +	ret = regulator_enable(adc->reg);
> > +	if (ret)
> > +		return ret;
> > +
> 
> [1]
> 
> > +	adc->shdn = devm_gpiod_get_optional(&spi->dev, "shdn", GPIOD_OUT_HIGH);
> > +	if (!adc->shdn)
> > +		dev_info(&spi->dev, "no shdn pin passed, low-power mode
> > disabled");
> > +	else
> > +		dev_info(&spi->dev, "shdn pin passed, low-power mode enabled");
> > +
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->info = &max1241_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = max1241_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
> > +
> > +	ret = iio_device_register(indio_dev);
> 
> This should disable the regulator on the error path.
> if (ret) {
>      regulator_disable(adc->reg);
>      return ret;
> }
> 
> return 0;
> 
> Though, I would argue in favor of adding a devm_add_action_or_reset() callback
> to disable the regulator on error & remove.
> This should be placed at [1]
> 
> Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/isl29018.c#n762
> 
> I've started to grow quite fond of these type of callbacks.
> For one part, you can remove the 'remove' part of the driver.
> On another part you can do neat stuff to simplify/reduce error paths in probe.
> We typically suggest these during our internal reviews.
> 
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static int max1241_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct max1241 *adc = iio_priv(indio_dev);
> > +	int ret = 0;
> > +
> > +	iio_device_unregister(indio_dev);
> > +	ret = regulator_disable(adc->reg);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct spi_device_id max1241_id[] = {
> > +	{ "max1241", max1241 },
> > +	{},
> > +};
> > +
> > +#ifdef CONFIG_OF
> 
> i'd remove this CONFIG_OF
> i guess this was copied from max1118.c
> see [2]
> 
> > +
> > +static const struct of_device_id max1241_dt_ids[] = {
> > +	{ .compatible = "maxim,max1241" },
> 
> the datasheet mentions also max1240
> you could add that to the list as well
> typically, it's a good idea, since some people get hung-up on the naming [which
> is not a bad idea]
> so, if you add max1240 to this list, the driver officially supports both max1240
> & max1241
>  
> 
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, max1241_dt_ids);
> > +
> > +#endif
> > +
> > +static struct spi_driver max1241_spi_driver = {
> > +	.driver = {
> > +		.name = "max1241",
> > +		.of_match_table = of_match_ptr(max1241_dt_ids),
> 
> [2]
> i'd remove of_match_ptr() and make it just
> 
> .of_match_table = max1241_dt_ids,
> 
> there's this code in the kernel that parses of_match_table for ACPI as well;
> might as well allow it to work
> 
> > +	},
> > +	.probe = max1241_probe,
> > +	.remove = max1241_remove,
> > +	.id_table = max1241_id,
> > +};
> > +module_spi_driver(max1241_spi_driver);
> > +
> > +MODULE_AUTHOR("Alexandru Lazar <alazar@startmail.com>");
> > +MODULE_DESCRIPTION("MAX1241 ADC driver");
> > +MODULE_LICENSE("GPL v2");
