Return-Path: <linux-iio+bounces-8529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED5955774
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170BD1F21F8B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B63149C7A;
	Sat, 17 Aug 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWCeF1sJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDD145B1D;
	Sat, 17 Aug 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894357; cv=none; b=C46fhf4NA3Hum6ahLoVYhIT6GNZcUlg3L0nPMgvtvp8zUzY3f2mZdJn5TJxfDQ1+QHLlbAvszN5ohaB5BJ8aqXbYjw9X/aNa4ds6KCjhJXtB1SWnl+CO6sB+WXVfbkPI3h7NXmwGmfh9xuMKeoUPy93xx3RlmTEAxgGZqJdj21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894357; c=relaxed/simple;
	bh=Tl1nqVyNUDE1Xz8spO574JD89qKO1gVZSNkkZ4XCCzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P70xcKTZ5CEb5HeYPbWCLBx3ONsU+NTDXMPsHuvj1A+LDwxw7EGdfB4BNjqWBYIs9K32l6GLsGSXOWZQhb010UMBrS2HCu0guejaLTCCuzOPX48TbKRA+2FpaUkOhIxjvRE4cIAeKAT3qEuRolzLVoTCfGJIHpcIHlcbfPGSx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWCeF1sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8314DC116B1;
	Sat, 17 Aug 2024 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723894356;
	bh=Tl1nqVyNUDE1Xz8spO574JD89qKO1gVZSNkkZ4XCCzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWCeF1sJ9HQzgKW0nFmYA0A4JWSANBWHpVf2XSqW3dX9Cksul+JI3z0FuKvqV8G+u
	 uOru9NRC4OsUeVuR6kVX2BA8fIH9UQjHFievwecA+DIX8A0kWneg0NaPgpkt3Cxz/n
	 2L276TzX00RK3n3IKRp6ECK7JC/2FaumsX7LaF/MEi4VkCpGEdjoOOujrjUAHvCmb4
	 pmEK+Owi+x3SYQLYPLR8ha/2mE/AkAfSehZlR0ZgpJwZdZYF7lURqtnm2JJEe/RZQ7
	 NAbG9n3haqkSQtrP67SpU2+83RpmNkyeY/5Bb/gPltozjxeID85mFdO3KIDgtR9hCC
	 Skt98GIOmcmpQ==
Date: Sat, 17 Aug 2024 12:32:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iio: dac: ad5449: drop support for platform data
Message-ID: <20240817123210.04b3c2f8@jic23-huawei>
In-Reply-To: <20240814092629.9862-1-brgl@bgdev.pl>
References: <20240814092629.9862-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 11:26:29 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are no longer any users of the platform data struct. Remove
> support for it from the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm fine with this but want an ADI ack.

Jonathan

> ---
>  drivers/iio/dac/ad5449.c             | 15 ++---------
>  include/linux/platform_data/ad5449.h | 39 ----------------------------
>  2 files changed, 2 insertions(+), 52 deletions(-)
>  delete mode 100644 include/linux/platform_data/ad5449.h
> 
> diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
> index 4572d6f49275..953fcfa2110b 100644
> --- a/drivers/iio/dac/ad5449.c
> +++ b/drivers/iio/dac/ad5449.c
> @@ -20,8 +20,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#include <linux/platform_data/ad5449.h>
> -
>  #define AD5449_MAX_CHANNELS		2
>  #define AD5449_MAX_VREFS		2
>  
> @@ -268,7 +266,6 @@ static const char *ad5449_vref_name(struct ad5449 *st, int n)
>  
>  static int ad5449_spi_probe(struct spi_device *spi)
>  {
> -	struct ad5449_platform_data *pdata = spi->dev.platform_data;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct iio_dev *indio_dev;
>  	struct ad5449 *st;
> @@ -306,16 +303,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
>  	mutex_init(&st->lock);
>  
>  	if (st->chip_info->has_ctrl) {
> -		unsigned int ctrl = 0x00;
> -		if (pdata) {
> -			if (pdata->hardware_clear_to_midscale)
> -				ctrl |= AD5449_CTRL_HCLR_TO_MIDSCALE;
> -			ctrl |= pdata->sdo_mode << AD5449_CTRL_SDO_OFFSET;
> -			st->has_sdo = pdata->sdo_mode != AD5449_SDO_DISABLED;
> -		} else {
> -			st->has_sdo = true;
> -		}
> -		ad5449_write(indio_dev, AD5449_CMD_CTRL, ctrl);
> +		st->has_sdo = true;
> +		ad5449_write(indio_dev, AD5449_CMD_CTRL, 0x0);
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> diff --git a/include/linux/platform_data/ad5449.h b/include/linux/platform_data/ad5449.h
> deleted file mode 100644
> index d687ef5726c2..000000000000
> --- a/include/linux/platform_data/ad5449.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * AD5415, AD5426, AD5429, AD5432, AD5439, AD5443, AD5449 Digital to Analog
> - * Converter driver.
> - *
> - * Copyright 2012 Analog Devices Inc.
> - *  Author: Lars-Peter Clausen <lars@metafoo.de>
> - */
> -
> -#ifndef __LINUX_PLATFORM_DATA_AD5449_H__
> -#define __LINUX_PLATFORM_DATA_AD5449_H__
> -
> -/**
> - * enum ad5449_sdo_mode - AD5449 SDO pin configuration
> - * @AD5449_SDO_DRIVE_FULL: Drive the SDO pin with full strength.
> - * @AD5449_SDO_DRIVE_WEAK: Drive the SDO pin with not full strength.
> - * @AD5449_SDO_OPEN_DRAIN: Operate the SDO pin in open-drain mode.
> - * @AD5449_SDO_DISABLED: Disable the SDO pin, in this mode it is not possible to
> - *			read back from the device.
> - */
> -enum ad5449_sdo_mode {
> -	AD5449_SDO_DRIVE_FULL = 0x0,
> -	AD5449_SDO_DRIVE_WEAK = 0x1,
> -	AD5449_SDO_OPEN_DRAIN = 0x2,
> -	AD5449_SDO_DISABLED = 0x3,
> -};
> -
> -/**
> - * struct ad5449_platform_data - Platform data for the ad5449 DAC driver
> - * @sdo_mode: SDO pin mode
> - * @hardware_clear_to_midscale: Whether asserting the hardware CLR pin sets the
> - *			outputs to midscale (true) or to zero scale(false).
> - */
> -struct ad5449_platform_data {
> -	enum ad5449_sdo_mode sdo_mode;
> -	bool hardware_clear_to_midscale;
> -};
> -
> -#endif


