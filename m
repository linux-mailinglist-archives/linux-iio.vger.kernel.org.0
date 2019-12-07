Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D158115BCC
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGKPX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKPX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:15:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE256217BA;
        Sat,  7 Dec 2019 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575713722;
        bh=nrS5Iq2q1EPwMCZjg9YlSPeQ5eUDtHqFbwex8qOrekw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2Yp2cZtgozfc2OE2squyMd0pyScfGTvZqncB/tj+JV02MO0SQD8TV+W//h8oKyqs
         OMfsYsHWWgthoVeH724mHU/FOeUPYvGR2V8c8DW2HbSFga5++RnXSTXUvYkG25U4m1
         Zl23EUDJ1fA4HxOnguCnS/UiBkKHUMMMP8UdpkXo=
Date:   Sat, 7 Dec 2019 10:15:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "amsfield22@gmail.com" <amsfield22@gmail.com>
Subject: Re: [PATCH] iio: ad7266: Convert to use GPIO descriptors
Message-ID: <20191207101517.21def822@archlinux>
In-Reply-To: <f0b763b0d81e7754d638268b0ffa2e2fec63401e.camel@analog.com>
References: <20191202093806.93632-1-linus.walleij@linaro.org>
        <f0b763b0d81e7754d638268b0ffa2e2fec63401e.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 14:39:01 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2019-12-02 at 10:38 +0100, Linus Walleij wrote:
> > The AD7266 have no in-tree users making use of the platform
> > data mechanism to pass address GPIO lines when not using
> > a fixed address, so we can easily convert this to use
> > GPIO descriptors instead of the platform data integers
> > currently passed.
> > 
> > Lowercase the labels "ad0".."ad2" as this will make a better
> > fit for platform descriptions like device tree that prefer
> > lowercase names such as "ad0-gpios" rather than "AD0-gpios".
> > 
> > Board files and other static users of this device can pass
> > the same GPIO descriptors using machine descriptor
> > tables if need be.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This could do with some DT work when someone has time and consideration
of relaxing the fact these gpios are only available from platform data
at the moment (that had me confused for a while as I though this
would break DT).

Doesn't look like a big job to tidy this up.

Applied,

Thanks,

Jonathan


> 
> > Cc: Alison Schofield <amsfield22@gmail.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/iio/adc/ad7266.c             | 29 ++++++++++++----------------
> >  include/linux/platform_data/ad7266.h |  3 ---
> >  2 files changed, 12 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> > index c31b8eabb894..c8524f098883 100644
> > --- a/drivers/iio/adc/ad7266.c
> > +++ b/drivers/iio/adc/ad7266.c
> > @@ -11,7 +11,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/err.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> >  
> >  #include <linux/interrupt.h>
> > @@ -34,7 +34,7 @@ struct ad7266_state {
> >  	enum ad7266_range	range;
> >  	enum ad7266_mode	mode;
> >  	bool			fixed_addr;
> > -	struct gpio		gpios[3];
> > +	struct gpio_desc	*gpios[3];
> >  
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) requires the
> > @@ -117,7 +117,7 @@ static void ad7266_select_input(struct ad7266_state
> > *st, unsigned int nr)
> >  	}
> >  
> >  	for (i = 0; i < 3; ++i)
> > -		gpio_set_value(st->gpios[i].gpio, (bool)(nr & BIT(i)));
> > +		gpiod_set_value(st->gpios[i], (bool)(nr & BIT(i)));
> >  }
> >  
> >  static int ad7266_update_scan_mode(struct iio_dev *indio_dev,
> > @@ -376,7 +376,7 @@ static void ad7266_init_channels(struct iio_dev
> > *indio_dev)
> >  }
> >  
> >  static const char * const ad7266_gpio_labels[] = {
> > -	"AD0", "AD1", "AD2",
> > +	"ad0", "ad1", "ad2",
> >  };
> >  
> >  static int ad7266_probe(struct spi_device *spi)
> > @@ -419,14 +419,14 @@ static int ad7266_probe(struct spi_device *spi)
> >  
> >  		if (!st->fixed_addr) {
> >  			for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
> > -				st->gpios[i].gpio = pdata->addr_gpios[i];
> > -				st->gpios[i].flags = GPIOF_OUT_INIT_LOW;
> > -				st->gpios[i].label = ad7266_gpio_labels[i];
> > +				st->gpios[i] = devm_gpiod_get(&spi->dev,
> > +						      ad7266_gpio_labels[i]
> > ,
> > +						      GPIOD_OUT_LOW);
> > +				if (IS_ERR(st->gpios[i])) {
> > +					ret = PTR_ERR(st->gpios[i]);
> > +					goto error_disable_reg;
> > +				}
> >  			}
> > -			ret = gpio_request_array(st->gpios,
> > -				ARRAY_SIZE(st->gpios));
> > -			if (ret)
> > -				goto error_disable_reg;
> >  		}
> >  	} else {
> >  		st->fixed_addr = true;
> > @@ -465,7 +465,7 @@ static int ad7266_probe(struct spi_device *spi)
> >  	ret = iio_triggered_buffer_setup(indio_dev,
> > &iio_pollfunc_store_time,
> >  		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
> >  	if (ret)
> > -		goto error_free_gpios;
> > +		goto error_disable_reg;
> >  
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret)
> > @@ -475,9 +475,6 @@ static int ad7266_probe(struct spi_device *spi)
> >  
> >  error_buffer_cleanup:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> > -error_free_gpios:
> > -	if (!st->fixed_addr)
> > -		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
> >  error_disable_reg:
> >  	if (!IS_ERR(st->reg))
> >  		regulator_disable(st->reg);
> > @@ -492,8 +489,6 @@ static int ad7266_remove(struct spi_device *spi)
> >  
> >  	iio_device_unregister(indio_dev);
> >  	iio_triggered_buffer_cleanup(indio_dev);
> > -	if (!st->fixed_addr)
> > -		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
> >  	if (!IS_ERR(st->reg))
> >  		regulator_disable(st->reg);
> >  
> > diff --git a/include/linux/platform_data/ad7266.h
> > b/include/linux/platform_data/ad7266.h
> > index 7de6c16122df..f0652567afba 100644
> > --- a/include/linux/platform_data/ad7266.h
> > +++ b/include/linux/platform_data/ad7266.h
> > @@ -40,14 +40,11 @@ enum ad7266_mode {
> >   * @range: Reference voltage range the device is configured for
> >   * @mode: Sample mode the device is configured for
> >   * @fixed_addr: Whether the address pins are hard-wired
> > - * @addr_gpios: GPIOs used for controlling the address pins, only used
> > if
> > - *		fixed_addr is set to false.
> >   */
> >  struct ad7266_platform_data {
> >  	enum ad7266_range range;
> >  	enum ad7266_mode mode;
> >  	bool fixed_addr;
> > -	unsigned int addr_gpios[3];
> >  };
> >  
> >  #endif  

