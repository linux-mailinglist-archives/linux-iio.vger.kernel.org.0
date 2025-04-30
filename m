Return-Path: <linux-iio+bounces-18922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6BAA58C8
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 01:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6863C1896FA7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3F22A1EF;
	Wed, 30 Apr 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGRFC65G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED043172;
	Wed, 30 Apr 2025 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746056242; cv=none; b=gwlEPQ5g+gEj+eob0/iaavNac28Jp3wA5RT9c4AgpplTprEqq1v7GjqcEmTAYiRF8ib5h01HaVh8sld4dsH+LgxiT+CmP5OZOupZFLBhx6u9cYncG+EqxwDWCBY9Jn0/KGUNVhNMJTsU+uB8k+nYjUZRgx8Fn8q8L92yAg7AYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746056242; c=relaxed/simple;
	bh=B970KZDsXmpyPOq0E5Oh6oE/Vo+fufArxrI9navEPuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3LwcR5ZeJQG9nzPIfUFnwKSwr5pkhvJHARnEtyyLX5MdLav569ca0ysaD33Fa4UupN8oPRg79J28+BpvpmNzRfK3Rj2DexAXIhEurP70Qp1oiG7ERgpQNXXWO8eWB7nfJWm2+R7O0doE6pw9IED1pTWOR0QAJbXrIyjtvTAlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGRFC65G; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a2b5dffcso745721cf.3;
        Wed, 30 Apr 2025 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746056238; x=1746661038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrJlWH+zIFXdSZX5AezxsKUSnRhp9kKWsYHOhzctSM0=;
        b=dGRFC65GDNvZXwyTNpU3moOiE+tWF3Dhis+yoprtp4nIbnoWxZ2dC80kWCjNBlLIrk
         4YLgruxkqmtHNbeQD9ZgDmElzlHi1wtQzSEQrxvYL2EBH0+qn0B2LtBaJfxrP3Iac2OB
         14TMmoO5McSU2FUPjVuRAENajMdYZTP6Y+UtdK7wcdJ1WOEPGVBmxosCo5luLU0Ihx2E
         jG+6pV12YtG0lt+bNLP4sSSlNIdkwtI9OtuFiTxL0W0dXxOjNXRnVe2JOEwPT7xLsyvE
         IErF8zc3PUjpejD4oOk5ivyu4xY1J/MugTG8Wa1QMHuzdBIc+C4/YhMHyIWrGwByO+xD
         BGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746056238; x=1746661038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrJlWH+zIFXdSZX5AezxsKUSnRhp9kKWsYHOhzctSM0=;
        b=C5d+UGdt34xqIU0+J+aYdoc665rN0jOk7sIRt5YxMfuMzbnm51uaO+rA2J8FMcUM2G
         kAEZ8w4EN2k/YtC/1U7peV2toGIhJk5AZfpQroeMrfJuCwIPzjGHNSoS9vi0rTeE7Lel
         ECHT/H+AjJ0FEvPLhaRn2TKT/EAeiQkCFNzPRkXxSbp+Y9nB6qi6zaslWki1tMQAnFfd
         4rMTABM+rKM2/wpYJbN2lLVaR+GDfIxiNTfFuJnOa/gYuGMyOOtPy1mPp7yP5+lYWts5
         kJy0NBSVQA61eyTUZ6Z1OgUU7ibb6G+Jgi4lXMQlKfM0zxg/Vslmdz7YGqSyr77WI5Zl
         6xqw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ83SBl+n5C+Geba5bud/DbisIXpkkgU442R3LZWKPVwTS2KMXTzAvLp2UhYI5mKz129vt8N1p8XCG@vger.kernel.org, AJvYcCV9rsVIzQUK/Oz+sBGFZjEM6DQhuK/bgmL5yEWC9LaCGyYX86QGTlFWGAMmJjvpoK37AOrQY+q+UchcRg==@vger.kernel.org, AJvYcCVb/yLaZ1379Rqq4lqVfFnTBrDKRM5Ys6n2gTFTMXtnvRaHF47ojoljJ40vCYzlFsW3qJqDj5Ld5KA0cuwP@vger.kernel.org, AJvYcCWxi5JgSsCAEP0ia1fP2tHOdYTL8zrw//VS1ByL2AmDJqMskEKKuKT8J03h6PWqWFCGGdaBs0sjy80K@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmoYU/H1Rm6r7rF1Hu5NqWzJCkokM9P73jteR2/2duCCZ/xab
	dmZX6aSLJD/sOsNZBOF79Uc6l+UFDXn6LPmwutHRfEs+sf8T1IJFJ0dJwci9
X-Gm-Gg: ASbGncuJHoDlqkfXYTWlarW51Iwpjh9pdBwIY/NG8bqnXgklhtHKUyZs3WLkLXLjHqI
	8Fmuk4Q948fxVKuoxKx1NTkde1lKIiljGzkpdiUzWulb8CPDJ/tOEIWgzT3PxFF0exhqFKxznJ4
	+XS1tQfaUuMbyoGMyXGd3O5PxRYuDDFeZqZDb3mdgGFIKlRKTCf2NnLZsQAIL0MbSxoVVrQ4qXl
	WWBPtVY0/8eaaQHGsbVK/pNteQuRbmztUSoQQd92Pc62iT2xn6NfHhZG+VvTMVVyV1dH9BCFlt1
	XVqvJy7DsL6i0OzBBOqmnbpwCAWUxH2S8hihT3gNn1T4uePhUAT2nohxhLFO1g==
X-Google-Smtp-Source: AGHT+IHVkPU+rQ+imsB2Nyk1HVkqj3rX+OoC/8PwmiLa4C1LnGUCpXLf5tu6vTNNBgwvnyJHbf+meQ==
X-Received: by 2002:ac8:5d50:0:b0:477:e9f:7530 with SMTP id d75a77b69052e-489e61ec118mr27075391cf.12.1746056237788;
        Wed, 30 Apr 2025 16:37:17 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe85e6dasm13998606d6.108.2025.04.30.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 16:37:17 -0700 (PDT)
Date: Wed, 30 Apr 2025 20:37:11 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, andy@kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 06/11] iio: adc: ad7768-1: Add GPIO controller support
Message-ID: <aBK0J8yriQy3BcN5@JSANTO12-L01.ad.analog.com>
Reply-To: CAHp75VdbD4HTonEZT8O-3bsqQ70_XRnZd7vS7gdyrG2gKYBHPA@mail.gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <2a8a327e589703ee53dbfb5190d20680ac3b350f.1745605382.git.Jonathan.Santos@analog.com>
 <CAHp75VdbD4HTonEZT8O-3bsqQ70_XRnZd7vS7gdyrG2gKYBHPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdbD4HTonEZT8O-3bsqQ70_XRnZd7vS7gdyrG2gKYBHPA@mail.gmail.com>

On 04/28, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 3:13 AM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> >
> > The AD7768-1 has the ability to control other local hardware (such as gain
> > stages),to power down other blocks in the signal chain, or read local
> > status signals over the SPI interface.
> >
> > Add direct mode conditional locks in the gpio callbacks to prevent register
> > access when the device is in buffered mode.
> >
> > This change exports the AD7768-1's four gpios and makes them accessible
> > at an upper layer.
> 
> ...
> 
> > +#include <linux/gpio.h>
> 
> No way. This header must not be in any of the code. (Yes, there are
> leftovers in the kernel, but work is ongoing to clean that up)
> 

Sorry about that, will fix it.

> > +#include <linux/gpio/driver.h>
> >  #include <linux/gpio/consumer.h>
> 
> >  #include <linux/kernel.h>
> 
> And since you are doing the big series for the driver, please drop
> this header and replace it (if required) with what is used. No driver
> code should use kernel.h.
> 

Sure, noted.

> >  #include <linux/module.h>
> 
> ...
> 
> > struct ad7768_state {
> 
> >         struct regulator_dev *vcm_rdev;
> >         unsigned int vcm_output_sel;
> >         struct clk *mclk;
> > +       struct gpio_chip gpiochip;
> >         unsigned int mclk_freq;
> >         unsigned int samp_freq;
> >         struct completion completion;
> 
> Btw, have you run `pahole`? Is this the best place for a new field in
> accordance with its output?
> 

I didn't, but I am going to use it.

> ...
> 
> > +static int ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> > +{
> > +       struct iio_dev *indio_dev = gpiochip_get_data(chip);
> > +       struct ad7768_state *st = iio_priv(indio_dev);
> > +       unsigned int val;
> > +       int ret;
> > +
> > +       if (!iio_device_claim_direct(indio_dev))
> > +               return -EBUSY;
> > +
> > +       ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> > +       if (ret)
> > +               goto err_release;
> > +
> > +       if (val & BIT(offset))
> > +               ret = regmap_update_bits(st->regmap, AD7768_REG_GPIO_WRITE,
> > +                                        BIT(offset), value << offset);
> 
> And if value happens to be > 1?
> Also consider the use of regmap_assign_bits().
> 

ok!

> > +err_release:
> > +       iio_device_release_direct(indio_dev);
> > +
> > +       return ret;
> > +}
> 
> ...
> 
> > +static int ad7768_gpio_init(struct iio_dev *indio_dev)
> > +{
> > +       struct ad7768_state *st = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> > +                          AD7768_GPIO_UNIVERSAL_EN);
> > +       if (ret)
> > +               return ret;
> > +
> > +       st->gpiochip = (struct gpio_chip) {
> 
> > +               .label = "ad7768_1_gpios",
> 
> What is '_1' for?
> Also, what will happen if the device has two or more such ADCs
> installed? Will they all provide _the same_ label?!
> 

the '_1' is because the part name is 'ad7768-1'.
Most of similar devices only define a static name, but I could use the
reg field, if you beleive it is better.

> > +               .base = -1,
> > +               .ngpio = 4,
> > +               .parent = &st->spi->dev,
> > +               .can_sleep = true,
> > +               .direction_input = ad7768_gpio_direction_input,
> > +               .direction_output = ad7768_gpio_direction_output,
> > +               .get = ad7768_gpio_get,
> > +               .set_rv = ad7768_gpio_set,
> > +               .owner = THIS_MODULE,
> > +       };
> > +
> > +       return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
> > +}
> 
> ...
> 
> > +       /* Only create a Chip GPIO if flagged for it */
> > +       if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
> > +               ret = ad7768_gpio_init(indio_dev);
> > +               if (ret < 0)
> 
> Why ' < 0'?
> 
> > +                       return ret;
> > +       }
> 
> -- 
> With Best Regards,
> Andy Shevchenko

