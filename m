Return-Path: <linux-iio+bounces-8842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109B9628BD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671F0B22DD8
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 13:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC520184118;
	Wed, 28 Aug 2024 13:34:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1F1D554;
	Wed, 28 Aug 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852087; cv=none; b=QMp8gcVV3BwDmBA2EHa5ndgZzFUJwuHrgqga0Km/5dY8jF4ema27SBT5EZBmWe2+V0vIkpeLiFd3tjWyr8nk4ODpWwLDg1LajrDz/FFETyy7zTpmjxJ3L11ywiUC6cSA+kW7FcXC0kNLz9QBJhHtqikdgUoxxfu1f81j/DogtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852087; c=relaxed/simple;
	bh=hYxXtkxsQKOAkmN+b3xnHbaMT1UgdiIJMQzTuDcUAIk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbwhaPeqbyK3VhVb98to6lt9EG4XEij2w4F3l2oWPahaj+WJdIzqDAsVXHjacL0t8Tiw9DINlopBtNj5fkp0mrqdhKz+p1tECGU8OBmYm9l9lCHTy83xtGmBGAJHn8I92jgAbs+KznxfJ14nLNytUv1q9NJaADcc1hLZhsvwNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv50X51yfz6H7YP;
	Wed, 28 Aug 2024 21:31:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 008C1140B30;
	Wed, 28 Aug 2024 21:34:41 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:34:40 +0100
Date: Wed, 28 Aug 2024 14:34:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Esteban Blanc <eblanc@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, "Rob Herring"
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Jonathan Corbet
	<corbet@lwn.net>, <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240828143439.00006d3d@Huawei.com>
In-Reply-To: <D3QUGZYL7INK.R3U3WQR0OCUS@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
	<20240824122111.425fa689@jic23-huawei>
	<D3QUGZYL7INK.R3U3WQR0OCUS@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 18:45:49 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> On Sat Aug 24, 2024 at 1:21 PM CEST, Jonathan Cameron wrote:
> > On Thu, 22 Aug 2024 14:45:18 +0200
> > Esteban Blanc <eblanc@baylibre.com> wrote:
> >  
> > > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> > > 
> > > The driver implements basic support for the AD4030-24 1 channel
> > > differential ADC with hardware gain and offset control.
> > > 
> > > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>  
> > Hi Esteban
> >
> > Some additional comments.  David did a good review already so
> > I've tried not to duplicate too much of that.
> >
> > The big one in here is don't use extended_name.
> > It's effectively deprecated for new drivers plus
> > it would have required you add a lot of ABI docs as every
> > sysfs file would have a strange name.
> >  
> > > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > > new file mode 100644
> > > index 000000000000..a981dce988e5
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ad4030.c  
> >  
> > > +struct ad4030_state {
> > > +	struct spi_device *spi;
> > > +	struct regmap *regmap;
> > > +	const struct ad4030_chip_info *chip;
> > > +	struct gpio_desc *cnv_gpio;
> > > +	int vref_uv;
> > > +	int vio_uv;
> > > +	int offset_avail[3];
> > > +	u32 conversion_speed_hz;
> > > +	enum ad4030_out_mode mode;
> > > +
> > > +	/*
> > > +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> > > +	 * to live in their own cache lines.
> > > +	 */
> > > +	u8 tx_data[AD4030_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> > > +	struct {
> > > +		union {
> > > +			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> > > +			struct {
> > > +				s32 val;
> > > +				u32 common;
> > > +			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];  
> >
> > David pointed out this doesn't need to be packed.
> > Given you have a union here, add __beXX as needed to avoid casts below.  
> 
> They also pointed out that I should reduce the size for the common field.
> I was planing to use an u32 bitfield here, 8 bits for common and 24 bits for
> padding. As far as I understood, the C standard is quite flexible on the
> size used for bitfield, so I should probably keep the __packed, right?
Don't use a bitfield - they are a pain as the C standard is very vague
on the data arrangement. Just use big enough storage and #define x GENMASK()
etc to extract the dta.

> 

> > > +static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
> > > +			   void *val, size_t val_size)
> > > +{
> > > +	struct ad4030_state *st = context;
> > > +
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = st->tx_data,
> > > +		.rx_buf = st->rx_data.raw,
> > > +		.len = reg_size + val_size,
> > > +	};
> > > +	int ret;
> > > +
> > > +	memcpy(st->tx_data, reg, reg_size);
> > > +
> > > +	/*
> > > +	 * This should use spi_write_the_read but when doing so, CS never get
> > > +	 * deasserted.  
> >
> > I'm confused.  As a single transfer it won't be deasserted in the transfer
> > whereas spi_write_then_read() will. So is this comment backwards or
> > is it referring to something else?  
> 
> So, with a single transfer (what is done now), the transfer is working
> as expected: CS goes low, the data is transferred, CS goes high again.
> With spi_write_then_read(), CS goes low, data is transferred but CS never
> goes high again. After some time I get a timeout error in the kernel logs.

That's odd.  spi_write_then_read() should not behave differently.
Perhaps a quirk of your SPI controller?

That one is worth digging into as in both cases we should have some
transactions and after that the chip select should behave the same.



> > > +static int ad4030_reset(struct ad4030_state *st)
> > > +{
> > > +	struct device *dev = &st->spi->dev;
> > > +	struct gpio_desc *reset;
> > > +	int ret;
> > > +
> > > +	/* Use GPIO if available ... */
> > > +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(reset))
> > > +		return dev_err_probe(dev, PTR_ERR(reset),
> > > +				"Failed to get reset GPIO\n");
> > > +
> > > +	if (reset) {
> > > +		ndelay(50);
> > > +		gpiod_set_value_cansleep(reset, 0);
> > > +	} else {
> > > +		/* ... falback to software reset otherwise */
> > > +		ret = ad4030_enter_config_mode(st);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> > > +				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	/* Wait for reset to complete before communicating to it */  
> >
> > I'd rather see a reference for the value than a generic comment
> > like this.  Also pull the actual value down here. Not particularly
> > useful to have a define for what is a real time unless you are going
> >  to have some combined docs for a bunch of timings (i.e a datasheet
> > table reference)  
> 
> I will put the real value in fsleep call directly. When you say "I'd
> rather see a reference for the value", you ment a reference to the place
> the value is defined in the datasheet, right?
Exactly.

> 
> > > +static int ad4030_detect_chip_info(const struct ad4030_state *st)
> > > +{
> > > +	unsigned int grade;
> > > +	int ret;
> > > +
> > > +	ret = regmap_read(st->regmap, AD4030_REG_CHIP_GRADE, &grade);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	grade = FIELD_GET(AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE, grade);
> > > +	if (grade != st->chip->grade)
> > > +		return dev_err_probe(&st->spi->dev, -EINVAL,
> > > +					"Unknown grade(0x%x) for %s\n", grade,
> > > +					st->chip->name);  
> >
> > Is this similar to a missmatch on a whoami value?  
> 
> Yes. It also saved me multiple hours of debuging when the eval board
> was not connected porperly and the SPI link was just not working.
> 
> > I.e. should we print a message and carry on in the interests of providing
> > some degree of support for newer devices on older kernel?
> > (fallback compatibles in DT)  
> 
> Ok, let's go with a warning then.
> 
> > > +static const struct spi_device_id ad4030_id_table[] = {
> > > +	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
> > > +	{}  
> >
> > I'm going to assume you have a bunch of other parts you plan to
> > support soon. Otherwise we normally don't add the chip specific
> > support until it is needed.  It tends to complicate initial driver
> > review a little and experience says that sometimes no other devices
> > are ever added.  
> 
> I'm sending the other devices in the same series (patch 4 and 5).
> For the sake of reducing noise in the later patches, I've put it in
> the initial driver. If you feel like I should wait and do it in the
> following patch (patch 4), I can do that.

Oops. I didn't ready on ;)  Absolutely fine to have this here.

Jonathan

> 
> Thanks for your time,
> 


