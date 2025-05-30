Return-Path: <linux-iio+bounces-20044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE1AAC931B
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673309E6918
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906712367D6;
	Fri, 30 May 2025 16:09:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D292356BF;
	Fri, 30 May 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621371; cv=none; b=aQqASkcMx4AXrcHGbPSgas76NjMbJ9FJOGsCQZoWAD8/qX7RNkYB67SUZJl7e75Hp9m3/Vc6uaqhMXL3I6U0yEBR8ZnV+52JWWvj9043d3laaoi7K21M0r3ifLouTqVX/9K4yILikyipO411XasO7xzGv3UfWAIxXl/7kLWAqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621371; c=relaxed/simple;
	bh=JmVpSKKZOPOlCo9BFqRQoedyXzcdHKCWpOwCJrIX4hI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpVQWXDxbHgR5xSboI8yO/MmlN4gfQA3RbumGP5wyxaSfkqGyD8bsuBD4ZHZPV7myU2xesAxXikPE8LUrarVcsz7usHfp4gfmf4cwFWJ+gk+3j1kuZQSVreUj46jq9W37dLyHectFYj7tjbv2oIxo3Ep0EwfpqkACNIPfIMm2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b87Ph4p1Rz6L4x4;
	Sat, 31 May 2025 00:05:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E5600140557;
	Sat, 31 May 2025 00:09:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 18:09:23 +0200
Date: Fri, 30 May 2025 17:09:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <andy@kernel.org>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
	<jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
	<linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
	<andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
	<djrscally@gmail.com>
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <20250530170922.000019a5@huawei.com>
In-Reply-To: <27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
	<27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 19:50:29 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
>=20
> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization while replacing sync-in-gpios property.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

A couple of trivial comments.  Not enough to respin unless something else c=
omes
up.


> @@ -296,6 +301,27 @@ static const struct regmap_config ad7768_regmap24_co=
nfig =3D {
>  	.max_register =3D AD7768_REG24_COEFF_DATA,
>  };
> =20
> +static int ad7768_send_sync_pulse(struct ad7768_state *st)
> +{
> +	if (st->en_spi_sync)
> +		return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
> +
> +	/*
> +	 * The datasheet specifies a minimum SYNC_IN pulse width of 1.5 =D7 Tmc=
lk,
> +	 * where Tmclk is the MCLK period. The supported MCLK frequencies range
> +	 * from 0.6 MHz to 17 MHz, which corresponds to a minimum SYNC_IN pulse
> +	 * width of approximately 2.5 =B5s in the worst-case scenario (0.6 MHz).
> +	 *
> +	 * Add a delay to ensure the pulse width is always sufficient to
> +	 * trigger synchronization.
> +	 */
> +	gpiod_set_value_cansleep(st->gpio_sync_in, 1);
> +	fsleep(3);
> +	gpiod_set_value_cansleep(st->gpio_sync_in, 0);

This change + comment should really have been in a separate patch
as there is always the potential someone might want to backport it.

> +
> +	return 0;
> +}
> +
>  static int ad7768_set_mode(struct ad7768_state *st,
>  			   enum ad7768_conv_mode mode)
>  {
> @@ -392,10 +418,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *s=
t,
>  		return ret;
> =20
>  	/* A sync-in pulse is required every time the filter dec rate changes */
> -	gpiod_set_value(st->gpio_sync_in, 1);
> -	gpiod_set_value(st->gpio_sync_in, 0);
> -
> -	return 0;
> +	return ad7768_send_sync_pulse(st);
>  }

> +
> +static int ad7768_trigger_sources_get_sync(struct device *dev,
> +					   struct ad7768_state *st)
> +{
> +	struct fwnode_handle *dev_fwnode =3D dev_fwnode(dev);
> +
> +	/*
> +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> +	 * to synchronize one or more devices:
> +	 * 1. Using an external GPIO.
> +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +	 *    synchronization pulse that drives the SYNC_IN pin.
> +	 */
> +	if (fwnode_property_present(dev_fwnode, "trigger-sources"))
> +		return ad7768_trigger_sources_sync_setup(dev, dev_fwnode, st);
> +
> +	/*
> +	 * In the absence of trigger-sources property, enable self
> +	 * synchronization over SPI (SYNC_OUT).
> +	 */
> +	st->en_spi_sync =3D true;

Really trivial but if you respin for some reason blank line here.

> +	return 0;
> +}


