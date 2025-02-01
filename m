Return-Path: <linux-iio+bounces-14827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F2A24A0E
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74CA165018
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9D1C3BEE;
	Sat,  1 Feb 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRE0VTK6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC0182;
	Sat,  1 Feb 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738425040; cv=none; b=amjOBdBxkeAQ8K4yp/gHzAHFYtHYBBS62MTgYGySwGfhAeVD/o+fBsOq2MXEVK1ralAI38hcd/bT+V7iIszrXGlxI9SeSxuvA7rFcok87/gbnZXqgokYJkk9ucwRud7iy1snRN+D8aMsWbRmkttjvyZOMM0k3iCaH3mR4kSVROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738425040; c=relaxed/simple;
	bh=aksvLma06eyni1rchA3DyQtJYprBqJ4isNSzP2QRvcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU4Myj+63BnZO1IsLdrMYsCh3lm03Th+N0wm08gIdkM1TcEmXd3yvkU9/NxbFlhWQaVprB1O8fstnkZCb/iLhdzgblkhxfb8Csm8PgbARYARYsqUJ+Dumi0SttCYL7A9oflPMpLL95w9GOXdpotqNJRuNIDBrsvayceuRnXm9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRE0VTK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76610C4CED3;
	Sat,  1 Feb 2025 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738425039;
	bh=aksvLma06eyni1rchA3DyQtJYprBqJ4isNSzP2QRvcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRE0VTK6Rc/IUXI7Z/g3dfEqoVs1KhutWjf5sbJz/sDxr2+x7nlZWdBRQ4TsSeFh1
	 FbXQYPP2zbknSXPI2RHyv7Bl7lRiRykR/hOuKOk2TI4DZokS4gcHOm4+yF+c40IhzF
	 q3tv3DWVtStVTGlZ/v13ROVc2mKQPO5+4/+ePd8AZjaAAQI6o06I29ZHQC6dpRSrRB
	 EkjihmKPKizs16AEkqteAHnAiU3Ac0lMwstsKWDgcH3l5khTUHoJbcZm33tBuc5G5Z
	 U6asa1bT1JhJA2jCLJj/xC3+q4unr5PbNLlWMLVqcIZqyVXM9Aku4TMiM7lAcXGbbw
	 Aso0LzzIzX1gA==
Date: Sat, 1 Feb 2025 15:50:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 12/16] iio: adc: ad7768-1: Add GPIO controller
 support
Message-ID: <20250201155029.650a7769@jic23-huawei>
In-Reply-To: <4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<4067fc67ef617edbaea0de21241d59d6ff8eaf98.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:13:45 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The AD7768-1 has the ability to control other local hardware (such as gain
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
> 
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
> 
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
As David observed, the direct mode release calls are missing.

Also, there are a few places where you wrap lines much shorter than needed.

> +static int ad7768_gpio_direction_output(struct gpio_chip *chip,
> +					unsigned int offset, int value)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap,
> +				  AD7768_REG_GPIO_CONTROL,
> +				  BIT(offset),
> +				  AD7768_GPIO_OUTPUT(offset));
Again, wrap less.

> +}
> +
> +static int ad7768_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
You aren't releasing it.  That should have deadlocked the second time
you called this.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val & BIT(offset))
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_WRITE, &val);
> +	else
> +		ret = regmap_read(st->regmap, AD7768_REG_GPIO_READ, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(val & BIT(offset));
> +}
> +
> +static void ad7768_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +	struct iio_dev *indio_dev = gpiochip_get_data(chip);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
As above, needs a matching release.  May mean you want to factor
out the guts of this as a helper function so you can still do
direct returns on error.

> +	if (ret)
> +		return;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &val);
> +	if (ret < 0)
> +		return;
> +
> +	if (val & BIT(offset))
> +		regmap_update_bits(st->regmap,
> +				   AD7768_REG_GPIO_WRITE,
> +				   BIT(offset),
> +				   (value << offset));
	Wrap a little less and drop the unnecessary brackets.

		regmap_update_bits(st->regmap, AD7768_REG_GPIO_WRITE,
				   BIT(offset), value << offset);
Also, check return value?

> +}
> +

> +
> +static int ad7768_gpio_init(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			   AD7768_GPIO_UNIVERSAL_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->gpio_avail_map = AD7768_GPIO_CONTROL_MSK;
> +	st->gpiochip.label = "ad7768_1_gpios";
> +	st->gpiochip.base = -1;
> +	st->gpiochip.ngpio = 4;
> +	st->gpiochip.parent = &st->spi->dev;
> +	st->gpiochip.can_sleep = true;
> +	st->gpiochip.direction_input = ad7768_gpio_direction_input;
> +	st->gpiochip.direction_output = ad7768_gpio_direction_output;
> +	st->gpiochip.get = ad7768_gpio_get;
> +	st->gpiochip.set = ad7768_gpio_set;
> +	st->gpiochip.request = ad7768_gpio_request;
> +	st->gpiochip.owner = THIS_MODULE;
Might not be worth it but I'd be tempted to do

	st->gpiochip = (struct gpio_chip) {
		.label = "ad7768_1_gpios",
		.base = -1,
		.ngpio = 4,
...
	};
perhaps.  This one is entirely up to your preference.
> +
> +	return gpiochip_add_data(&st->gpiochip, indio_dev);
> +}
> +

