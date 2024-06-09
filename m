Return-Path: <linux-iio+bounces-6092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F4901551
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F471C21559
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEE1CD24;
	Sun,  9 Jun 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS4LRnKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B8360;
	Sun,  9 Jun 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925470; cv=none; b=EDo58zez23uaRrwpM/Akv/mIf1w69axF0LrjWvGd/n8Z8klVk7+pisTootNakGwkH9n0xYGtecjS73KBRKo6UdkSAjwAW0va2aq7ZJoXdceF8Kavl64acT9epOQBvVaWvp493zFtGk++EFY1bxIg9nQtozEzKfBEWsYUmY8OmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925470; c=relaxed/simple;
	bh=jXOCtKxUztDJQHOsx2MNS1JltHk7f/xxhqp0JBqI5Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsuRxON8DN19ChT6+hSaYBO/R5sLMtBxQqKO3CbZqRdpyJVklvz/JOZFfzTs5ZGfjl6cjUwGXtX0vcJce2ItQrV6UtlevVFoFNL4xj1yaoCUJRCU7booxUYW5DeIC4qUZUQztpC92kGDwCbVDCMhugsTP11Xsq2KUoiLUWydqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS4LRnKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB5AC2BD10;
	Sun,  9 Jun 2024 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717925470;
	bh=jXOCtKxUztDJQHOsx2MNS1JltHk7f/xxhqp0JBqI5Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lS4LRnKn6nIb4Jw2kD/zVGvFtpSjyfOv5na0eTJxZ5cxY1CI9AKlUSv595j5V1UmI
	 2T2V1tPoy53ySkc9TCATmi/lspGgbd9PCY7KGkL7QhxjfrJkBVRHbfTvhpSBw4GYZX
	 41+xqDF8G8zdbQ+a77x4IPGCjrgYUhDkIokzzOeKyFF/IPNVbLByZJveIKlf/zsxYI
	 8cdU2+V0lAZAwRgtP2+U9ZysKlV+j6gTUti6TiSp0LK/aQBwvN8t0Od1bRQoIEaMyu
	 5bKNG3p4D5o4AHS2AcufojZ8NsOPS1V08clMb8XJcJQugKye0qozOoUFrt5AM12PaZ
	 LkcMJvtrpGI1A==
Date: Sun, 9 Jun 2024 10:30:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <20240609103033.2f746f1e@jic23-huawei>
In-Reply-To: <20240604225747.7212-4-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
	<20240604225747.7212-4-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 19:57:27 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> for indoor air quality monitoring. The driver supports readings of
> CO2 and VOC, and can be accessed via both SPI and I2C.
> 
> Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
> 
No blank lines in tags block.  Datahsheet is a semi official tag.
I'll tidy up in this and previous patch if everything else fine.

> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
>  drivers/iio/chemical/Kconfig       |  22 +++
>  drivers/iio/chemical/Makefile      |   3 +
>  drivers/iio/chemical/ens160.h      |   7 +
>  drivers/iio/chemical/ens160_core.c | 221 +++++++++++++++++++++++++++++
>  drivers/iio/chemical/ens160_i2c.c  |  60 ++++++++
>  drivers/iio/chemical/ens160_spi.c  |  60 ++++++++
>  6 files changed, 373 insertions(+)
>  create mode 100644 drivers/iio/chemical/ens160.h
>  create mode 100644 drivers/iio/chemical/ens160_core.c
>  create mode 100644 drivers/iio/chemical/ens160_i2c.c
>  create mode 100644 drivers/iio/chemical/ens160_spi.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 02649ab81..e407afab8 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -76,6 +76,28 @@ config CCS811
>  	  Say Y here to build I2C interface support for the AMS
>  	  CCS811 VOC (Volatile Organic Compounds) sensor
>  
> +config ENS160
> +	tristate "ScioSense ENS160 sensor driver"
> +	depends on (I2C || SPI)
> +	select REGMAP
> +	select ENS160_I2C if I2C
> +	select ENS160_SPI if SPI
> +	help
> +	  Say yes here to build support for ScioSense ENS160 multi-gas sensor.
> +
> +	  This driver can also be built as a module. If so, the module for I2C
> +	  would be called ens160_i2c and ens160_spi for SPI support.
> +
> +config ENS160_I2C
> +	tristate
> +	depends on I2C && ENS160
> +	select REGMAP_I2C
> +
> +config ENS160_SPI
> +	tristate
> +	depends on SPI && ENS160
> +	select REGMAP_SPI

As these two config symbols aren't exposed I think you don't need the
depends lines.

See the BMA400 entry in drivers/iio/accel/Kconfig for example.

If everything else looks good I'll drop those two lines whilst
applying.

Jonathan

