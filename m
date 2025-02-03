Return-Path: <linux-iio+bounces-14918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B2A25A5C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4083188816E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA44204C31;
	Mon,  3 Feb 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLsy7qR1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87088C139;
	Mon,  3 Feb 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588135; cv=none; b=oLfWRIgxUHWmQnRtWPthnLg155z2Q0Se0gmnY6RruwMFv/xkJA3pYUA5mW7hcBS28K5CPBSDqKm74EuwJyzt6nh9LmvnIMdjUWCUd5kPVhwCONj8/xYVX4FjScpJ3SnkWC2CfCULrHguUQilk5kWxxIZb3XLSnQshz0+skP/z64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588135; c=relaxed/simple;
	bh=uVAMvhFVmhaZQMyq8sE9xqZswhwVTo+AbxI41rusfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBpu6iBbC3ekjn/t2LyjKKp7hxxUJCO7kkWvGWIX/mXgHl0dltV6jmuqHwuWnsN0TfpOYMysDwAeD6osiFnXmxNyOvxOv4vXYTfg9rFqvrub6vM7Ed3Rmv4xaAcYm1358eSZb0FRjoyeL1uSU3L3cOtAowAXtmO7brTr5qlx+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLsy7qR1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46e48278a9dso7070631cf.0;
        Mon, 03 Feb 2025 05:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738588132; x=1739192932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHjKhVXQwB5PNmTEPHLSlpwqAm0HS0J9XwM/xzqkTnw=;
        b=iLsy7qR1ckQUrdm4JhQ7HTpQDiqkcrfTyBqBgSibmveyLA/Ot2vtMkILNgijnc1MbM
         /rihPOh/LzOnrG+1W/wDK/M9rP2givPBIGqCzqAks97YeKNNXaB7rQdUzDdJCQlrV1Ve
         4UtaXvinoB9bUkt5MjUyDCnp5W5Br7m4+G23+rUwTBbUEygPhZx4hQSLQOLohdHwQqhK
         OAlCPNnKYUb7DMI/cJ9sgExdRe2rb7g+xSnGtNXTwQykuFFF9bMEnG346NLkyOPS1ndS
         PRxBVnEz9C4J6pmQKkWE3keN1V7EeB+LkOPpv1tlPGoRlrQIw6UthB6VrjWy0TOYanvY
         E6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738588132; x=1739192932;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHjKhVXQwB5PNmTEPHLSlpwqAm0HS0J9XwM/xzqkTnw=;
        b=oXrwiccKRjhKeWJmLFXF76pHMOseB9DGbuSNMVkvSL9iNmk9//LKeiO4d4K7XtiqYN
         O7lPtizk1/xvZvCMXo+e6fwS9UR4WEbnJTyUbcu7Hx1sBGXXtJnqczTbU/Fw7HFnMSt1
         iCupVcpXFA/QLn82eOTUyYy9p7/Zd7WjHxIsbMVxsJSYN9mkowBulzKNWS05ZXx0oEFK
         3NB4t3wgsXdH41uy/LJxEL9u3yPeZNWRQo//n5QQ99Jox7X2Bh3Xvis6GuilG8inaGL2
         Qpg2q7jknBSzc+evpuCmpwKSo6+EF4bRa+PGzLLnF1crlG/hPCLk2m62bHFt+9Qf1N+C
         omEA==
X-Forwarded-Encrypted: i=1; AJvYcCVFJ79VF4Jgfpi4aittew2p/L2MzFwhSWZISPb1Qu40RbwMr+PjdJYXoYHH9Lct8Z5ujzlOdURErVvj@vger.kernel.org, AJvYcCWkDP4IedxAiitk3QDXOMdYeFVYax6WXjKf1j+NKULA4WXu0LrFdi3IZA1CtSsnyZiAFHT4+LLCPLFiNNYD@vger.kernel.org, AJvYcCWlYg5rrSOrlCtK8s/oMq5qncySQ1YRYMHLK+hkOpRRyo7uxCMo2Gb7X6LHshG2yWcDRQgGEjxBahFw@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSR3iyrDdxpUTOCV6J00OEsYQR5vmLJcfgbu0r57/5tTGg1P0
	E80LCuv6MtlVGyawVOZ8wfmjOUUeTC56oI2X2CiX37gLpoG8K7tI
X-Gm-Gg: ASbGncucbmT2bJJrKyhWZOF/bmi+SkEQIZlDGrUaxYcbEcf5ZF1UmDMwY56ujfKHmny
	mfYUXL59YXFKmLSGuPvI/y+6TlUygWRaYfVo4eNgb0vVjS8pUdar7+ukBnzfrinOZNW3IfnEf4+
	lEQmGLWitB/iP8hGAHHgrxZ6TZJvsyzJ1FwLGn/u9jxu8KUTPANBRRP0H20OV27yuPJpvNZQo57
	jbRYoMb1EO02k1UxCJWr625APl/uJ1yahOF/wP0iFCyuFW3ozkObhjOX0qqya6KpNkBlOLHCjyl
	oC59K+eYgFY8XmNV6TybvCXTgv2SxosxrfQW
X-Google-Smtp-Source: AGHT+IEqnpw2iu4Rhuyshxr0dAVk2n19CIbEqrlmz7BVxwnupqK/gZxIcSCsyO+Mxbh2xCyzQyBbbQ==
X-Received: by 2002:a05:622a:1821:b0:460:9272:6591 with SMTP id d75a77b69052e-46fddba8284mr91829271cf.14.1738588132191;
        Mon, 03 Feb 2025 05:08:52 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a74a5sm48423181cf.8.2025.02.03.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:08:50 -0800 (PST)
Date: Mon, 3 Feb 2025 10:08:46 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 12/16] iio: adc: ad7768-1: Add GPIO controller support
Message-ID: <Z6C/3qqJaHUc1IR/@JSANTO12-L01.ad.analog.com>
Reply-To: be495c92-6e6f-47dc-baee-9524055f4f53@baylibre.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
 <be495c92-6e6f-47dc-baee-9524055f4f53@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be495c92-6e6f-47dc-baee-9524055f4f53@baylibre.com>

On 01/27, David Lechner wrote:
> On 1/27/25 9:13 AM, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > The AD7768-1 has the ability to control other local hardware (such as gain
> > stages),to power down other blocks in the signal chain, or read local
> > status signals over the SPI interface.
> > 
> > This change exports the AD7768-1's four gpios and makes them accessible
> > at an upper layer.
> > 
> > Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> > v2 Changes:
> > * Replaced mutex for iio_device_claim_direct_mode().
> > * Use gpio-controller property to conditionally enable the
> >   GPIO support.
> > * OBS: when the GPIO is configured as output, we should read 
> >   the current state value from AD7768_REG_GPIO_WRITE.
> > ---
> >  drivers/iio/adc/ad7768-1.c | 148 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 146 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index c540583808c2..e3ea078e6ec4 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -9,6 +9,8 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -79,6 +81,19 @@
> >  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
> >  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> >  
> > +/* AD7768_REG_GPIO_CONTROL */
> > +#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
> > +#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
> > +
> > +/* AD7768_REG_GPIO_WRITE */
> > +#define AD7768_GPIO_WRITE_MSK		GENMASK(3, 0)
> > +
> > +/* AD7768_REG_GPIO_READ */
> > +#define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
> > +
> > +#define AD7768_GPIO_INPUT(x)		0x00
> > +#define AD7768_GPIO_OUTPUT(x)		BIT(x)
> > +
> >  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
> >  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
> >  
> > @@ -160,6 +175,8 @@ struct ad7768_state {
> >  	struct regulator *vref;
> >  	struct mutex lock;
> >  	struct clk *mclk;
> > +	struct gpio_chip gpiochip;
> > +	unsigned int gpio_avail_map;
> >  	unsigned int mclk_freq;
> >  	unsigned int samp_freq;
> >  	struct completion completion;
> > @@ -309,6 +326,125 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
> >  	return 0;
> >  }
> >  
> > +static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> 
> Missing iio_device_release_direct_mode() here and in other functions.
> 
> (And we are in the process of removing iio_device_claim_direct_scoped(), so
> don't use that.)
> 

Sure, my mistake. I am fixing this.

> > +
> > +	return regmap_update_bits(st->regmap,
> > +				  AD7768_REG_GPIO_CONTROL,
> > +				  BIT(offset),
> > +				  AD7768_GPIO_INPUT(offset));
> 
> Can be simplified to regmap_clear_bits(), then we can get rid of the odd
> AD7768_GPIO_INPUT macro that ignores the argument.
> 
> > +}
> > +
> > +static int ad7768_gpio_direction_output(struct gpio_chip *chip,
> > +					unsigned int offset, int value)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_update_bits(st->regmap,
> > +				  AD7768_REG_GPIO_CONTROL,
> > +				  BIT(offset),
> > +				  AD7768_GPIO_OUTPUT(offset));
> 
> And regmap_set_bits() here.
> 
> > +}
> > +
> > +static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (val & BIT(offset))
> > +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
> > +	else
> > +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);
> 
> Can we get a comment explaining why GPIO_READ doesn't work in output mode?
> 
> Or if it does work, we can simplify this function.
> 
> 

The datasheet does not mention this; I reached this conclusion through testing.
It seems they separate the output state from the read register. Anyway, I will
add a comment.

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return !!(val & BIT(offset));
> > +}
> > +
> > +static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> > +	if (ret < 0)
> > +		return;
> > +
> > +	if (val & BIT(offset))
> > +		regmap_update_bits(st->regmap,
> > +				   AD7768_REG_GPIO_WRITE,
> > +				   BIT(offset),
> > +				   (value << offset));
> 
> Can remove extra ().
> 
> > +}
> > +
> > +static int ad7768_gpio_request(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +
> > +	if (!(st->gpio_avail_map & BIT(offset)))
> > +		return -ENODEV;
> > +
> > +	st->gpio_avail_map &= ~BIT(offset);
> 
> Is this really needed? It seems like GPIO core would be keeping track already.
> 
> Also would need a .free callback to undo this action.
> 
> It seems like most ADC's with GPIO controllers don't implement .request though.
> 

Indeed, .request is optional and does not seem to make a pratical  
difference if the core handles that. If that is the case i can remove
this

> > +
> > +	return 0;
> > +}
> > +

