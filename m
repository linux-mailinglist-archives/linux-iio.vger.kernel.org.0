Return-Path: <linux-iio+bounces-11326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639A9B178F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F641F22440
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7A1D4613;
	Sat, 26 Oct 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyWL5xmM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B61D4173;
	Sat, 26 Oct 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943152; cv=none; b=sbLsXpHOQ/WysV4koRFhlvyFtU4S1rpy+u1meF2ETdBGW4IeNLcOfErQArG8UP7P+zElvdCIM7vtCgwic5rDgc2RjBaRwTTQlUcF6B+atT/NoJ4YW4+5Rzcf6BV7HxokUEB7gEdMjrF+eelg2ZdLdg4Tpf2NbrJYyt3uX84JYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943152; c=relaxed/simple;
	bh=a35+QMqR1cso9E3ink4OQ1d61lHfV2h+oLIQ9w8eR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8k76BJzU49xKixBXTbWG9k9c/WAhH0rveii4tXGpHK3kb35g44iB1PkQnBST2b7G4jfrFa2ZR9+zmzMlT3Ubq5sG00q+ZxBhtqxV+b2vT8Ih6bnMRwiuLg33uZNVN+FHSD9cJ6gqxCysgq+pAVKVdxjfYukZPnVw2Agwf179PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyWL5xmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAC0C4CEC6;
	Sat, 26 Oct 2024 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943151;
	bh=a35+QMqR1cso9E3ink4OQ1d61lHfV2h+oLIQ9w8eR4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AyWL5xmM3zdAoOUTq/8/qe+8dw6S4vE+dC25o0gXqSBu2KGuilnY+MoNPolqPnpJI
	 oRsmKPR/B3gGa0k1/k0lmtBZVQAAPdRHwHAuMBec3ggBeAoY9N3qmDIPMytqmEaFTV
	 HNiSHv3mvoA0qqtRzxUNXX9cUoyrRFod/gg3Ekca9LolPKUxBQkThiARA7ewnd8PW2
	 c7LMAzoI73N7Cg0hmnDwunVcMj6zim8mh2ZWIGZYNtv2ksVEUt3eVDH63yJ63r6TJn
	 iIr5r55Au8KUm46vhPem/uWabULdXFFo31z669mFSLIvuYJ8MjlLxZSVzUbw3/HT6p
	 PQ8fWsltFnUcw==
Date: Sat, 26 Oct 2024 12:45:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 17/24] iio: accel: mma9551: Replace custom
 implementation of iio_get_acpi_device_name()
Message-ID: <20241026124515.0898eea0@jic23-huawei>
In-Reply-To: <20241024191200.229894-18-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-18-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:06 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> IIO core (ACPI part) provides a generic helper that may be used in
> the driver. Replace custom implementation of iio_get_acpi_device_name().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

> ---
>  drivers/iio/accel/mma9551.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index fa1799b0b0df..a5d20d8d08b8 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -4,11 +4,11 @@
>   * Copyright (c) 2014, Intel Corporation.
>   */
>  
> -#include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/iio.h>
> @@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static const char *mma9551_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -
> -	return dev_name(dev);
> -}
> -
>  static int mma9551_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -464,8 +453,8 @@ static int mma9551_probe(struct i2c_client *client)
>  
>  	if (id)
>  		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = mma9551_match_acpi_device(&client->dev);
> +	else
> +		name = iio_get_acpi_device_name(&client->dev);
>  
>  	ret = mma9551_init(data);
>  	if (ret < 0)


