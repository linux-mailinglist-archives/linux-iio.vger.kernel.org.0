Return-Path: <linux-iio+bounces-16229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5702A4AF2E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 04:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631C03ABAA2
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C94155389;
	Sun,  2 Mar 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6var03g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751C757EA;
	Sun,  2 Mar 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740887311; cv=none; b=NeOgtashjyLQW7nzQL7jIquiKiplMyFTaqcF/X/fUnRS+RGd2m2MQ+HVQe1++vc+bWuJQ86ZAhIEEX5++W021ilJwok1LHGKSeS2RY8/zpJ4K4E4sdty1EAoAPTdBNrxC2mVTtL8cyzWqsH6pfgkf0rv5aelJJP/eyW33eOaYyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740887311; c=relaxed/simple;
	bh=GCHeyfxkGkvIchus3GM+deq2n2Ej9SrlPO3hBk7T/cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2XmdmUFQI2KLM+FZvGTimB3IQtw6gQnsQ5xAamd3pV5aDG/UpngOOwrxZh8OeRzWpIIMOsLfk2bGYYv/xc4YfQ6aJFQletElhEj/oRjiBOf8ShagVuIlVc8hKme3LUR60rFUsfWMupayOB4/nZJGQ2qpjcyH/LSi8g9Wn7eYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6var03g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B06C4CEE2;
	Sun,  2 Mar 2025 03:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740887310;
	bh=GCHeyfxkGkvIchus3GM+deq2n2Ej9SrlPO3hBk7T/cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6var03g/VBNqQQ1++7eZs13WnPx5s47dELYpLjGcVwvwY5aQ/TMqh7dAQQpvBj0Z
	 m59c5nbUJo7PZd+Ayy9Qt/7g3G3gzNWuLOdVJOXTwxoFPFg4GcdHRdSSCvgh3Fqmta
	 9+u/tQFtWSJcawg2WYQIO3Vj5Li/+4KUCstdKHj8PQkrbGaosx89c5tKozK8c8awRg
	 2HbrZeqNTXhpHTaMoAQwJgVmePY9dd/Og79xFsPIEYWdhEMyAz+xbpekzO0hAYq3hB
	 8SlC/C965imuhmwZY3tuE0w38lCFWgdFX+O7VgTTsC+D0HUOfASDWlvhy6lvWDKsY3
	 SC2xephK1WgMw==
Date: Sun, 2 Mar 2025 03:48:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250302034807.680a3971@jic23-huawei>
In-Reply-To: <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 20:33:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> There are ADC ICs which may have some of the AIN pins usable for other
> functions. These ICs may have some of the AIN pins wired so that they
> should not be used for ADC.
> 
> (Preferred?) way for marking pins which can be used as ADC inputs is to
> add corresponding channels@N nodes in the device tree as described in
> the ADC binding yaml.
> 
> Add couple of helper functions which can be used to retrieve the channel
> information from the device node.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v3 => v4:
>  - Drop diff-channel support
>  - Drop iio_adc_device_channels_by_property()
>  - Add IIO_DEVICE namespace
>  - Move industrialio-adc.o to top of the Makefile
>  - Some styling as suggested by Andy
>  - Re-consider included headers
> v2 => v3: Mostly based on review comments by Jonathan
>  - Support differential and single-ended channels
>  - Rename iio_adc_device_get_channels() as
>    iio_adc_device_channels_by_property()
>  - Improve spelling
>  - Drop support for cases where DT comes from parent device's node
>  - Decrease loop indent by reverting node name check conditions
>  - Don't set 'chan->indexed' by number of channels to keep the
>    interface consistent no matter how many channels are connected.
>  - Fix ID range check and related comment
> RFC v1 => v2:
>  - New patch
> 
> iio: adc: helper: drop headers
> ---
>  drivers/iio/adc/Kconfig            |  3 +
>  drivers/iio/adc/Makefile           |  2 +
>  drivers/iio/adc/industrialio-adc.c | 89 ++++++++++++++++++++++++++++++
>  include/linux/iio/adc-helpers.h    | 22 ++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 drivers/iio/adc/industrialio-adc.c
>  create mode 100644 include/linux/iio/adc-helpers.h
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..37b70a65da6f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -6,6 +6,9 @@
>  
>  menu "Analog to digital converters"
>  
> +config IIO_ADC_HELPER
> +	tristate
> +
>  config AB8500_GPADC
>  	bool "ST-Ericsson AB8500 GPADC driver"
>  	depends on AB8500_CORE && REGULATOR_AB8500
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..1c410f483029 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -3,6 +3,8 @@
>  # Makefile for IIO ADC drivers
>  #
>  
> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
> +
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industrialio-adc.c
> new file mode 100644
> index 000000000000..d8e9e6825d2b
> --- /dev/null
> +++ b/drivers/iio/adc/industrialio-adc.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Helpers for parsing common ADC information from a firmware node.
> + *
> + * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/adc-helpers.h>
> +#include <linux/iio/iio.h>
> +
> +int iio_adc_device_num_channels(struct device *dev)
> +{
> +	return device_get_child_node_count_named(dev, "channel");
> +}
> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
Just noticed, this isn't namespaces which is a bit odd.  I'd drop
the export anyway in favour of static inline but if you don't match
the namespace of the next one.

