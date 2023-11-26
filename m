Return-Path: <linux-iio+bounces-409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 614147F94CE
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA881F20DD4
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320E1094E;
	Sun, 26 Nov 2023 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsP2FAzX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94028EAD6;
	Sun, 26 Nov 2023 18:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564E6C433C8;
	Sun, 26 Nov 2023 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701022624;
	bh=y5A6d9XUtPolGuHANG8CCFGRtGSFjaWe+7EWUBbWjxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsP2FAzXeMYj+xrJ8YYKfkosv4OuxaXAmmGxNLE+IAW8zemA6/GeBH4LMn4HJXOwX
	 zAo57eyjyqN3UCMbb2yVu73u/zg+ZGt/ASEdsdiVTDdBGu7S7Hpgpvpwr5RFEwLF3U
	 lqfT0lRf8BmoUTf5hcQku9R5HukgsPTcg9rOuF2xSMsPLDzwQWM6vPHenNyKdRB4tt
	 uK2XN8NeviDfyomnod+aZ4NH3QAYirvOn5PM4r3LUz+3ixIDyXDY/RG5A2r848Kfys
	 HAx8UqcumfhDH/c4kZaSFPYGOgKNa0GnnQM8KOo1ws8l5z9GB6D/JJzkYFr1h/1Ivi
	 7YoBVokPT7i9w==
Date: Sun, 26 Nov 2023 18:16:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231126181655.4e1040f9@jic23-huawei>
In-Reply-To: <20231125222738.97875-2-marex@denx.de>
References: <20231125222738.97875-1-marex@denx.de>
	<20231125222738.97875-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 23:26:23 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Hi Marek,

One last question + a comment in general. Act on that if you like.

Thanks,

Jonathan


> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };

Why have an available attribute for a single value. Is it useful for anything?


> +static int isl76682_probe(struct i2c_client *client)
> +{

...

> +	indio_dev->info = &isl76682_info;
> +	indio_dev->channels = isl76682_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
> +	indio_dev->name = ISL76682_DRIVER_NAME;
Trivial but I'm not a fan of using defines in cases like this. It just makes
me go find the define when I could see the string directly here.

In cases where matching or similar strictly requires the naming to be the same
in various places a define is useful. In this case less so.

Anyhow, it's a very minor comment so never mind if you prefer to leave it
as it stands.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


