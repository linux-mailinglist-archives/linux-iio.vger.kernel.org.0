Return-Path: <linux-iio+bounces-7088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F96C91D3E4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 22:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C12815B2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10413B59F;
	Sun, 30 Jun 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsVmvypp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B4200C1;
	Sun, 30 Jun 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779207; cv=none; b=lC7hkLJ5T78F2aotESY7qLwysW0W7ywzhhn+dTGNIGN58xBRUPXmSCXpuSTVZPsUTsb5G/4IPSrS23RuRT+H3wDrweOtHtx6rmNSNmXqz4hdqauX5QARMY1CqjMDTsKcxbSkP1gxLx5bjsRQUOTeG+OxrQwORds3JmVQIr8Qx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779207; c=relaxed/simple;
	bh=y3Oc+yFIm1iu5LgGh875+lF0h3v6q0P7/imJlXrOwxA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C98vlr9z1PhXGqi51czRhVbTQva1T3L/0AgQA9pUMNTP/S2cSKT4SHDwLOrWmD6SDew2TLQ+R8dS+GGEYuv9iJ1548CJBBCjbvBI9wHtv9jbC9L5hI7NtbOlvD1Eot1iK3HbDuBs9XREe9WxhKU1KW8/vbFdW/xyX4L5eqJBYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsVmvypp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a751ed17b1eso94836766b.1;
        Sun, 30 Jun 2024 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719779204; x=1720384004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqqFNS3RpqqaEd08AdiOfTL3uAe8sYuhxm/jFhUP19o=;
        b=QsVmvyppIZxGkwIcm3+fveAa0qMJusCdwaNmmOLiD4XBZQ7WAga1XO6xscdauCIgvy
         xquKLjit88/SDRdfN6KBMM8JwqiirAKN+oPiDs7U/YlbRhAgoL7Cuy9+nF/GW64unKIk
         9HkLYOzpYBpkwW1kvRjpE/we95glF0g83IzZs1oi6aZP0zepyUYZDCkiA0YmnyMEkjs2
         qAQJTXnvI+ZQTjj5orbn4v+hUFtxB0/jcUjlcMHo/xxmlUQl0H+5/oULljefqqPK4JQd
         9COxaXCeXp+EY79qSmpto0b7bklwX4M8hMQWZbULL1/feaDFFCw7FAqf1I8QmzXkW15V
         aCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719779204; x=1720384004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqqFNS3RpqqaEd08AdiOfTL3uAe8sYuhxm/jFhUP19o=;
        b=LWZOxCj9Lzkmor7PFxm6kGx8FTK8Bl+zUr3R6NRjbeph+UtxrZ0oozd4pwcQYYJqDc
         OEauVoS6UM3YrXq6V/Fo1O/bobtzgHrIfpIHf3RYWoHZ0WINvYlexm/lO6Bbnbn14viZ
         LsyIAIgkfnbbI2IgBTcuWjNq7j7NzGJscMpNfhfy5VfnBh1H5aCn+ZeceH0QYko/gcKu
         4eJaPGta9MG30e/Z9DkGfCKSrL1cLXQQ4D8Yp6xcs8ypngR7a3rlb3pPFw9QXWk+Xid3
         3gNX5ZlFk4p8vkG+bPJQz91rKtsOaKM8ClILzawYxwo3NwSwbqG3HUvHuY3PYurQPz8w
         vgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXFj5AWyDoX5YfSe4j1Z6h0i8m1hqQbEK1aswe8P3yAzuCxmywJ0Hj4j4tSGnviaOjezJzDbPcj3iMAdO4mUt5QDFgreezJ3x82oxP0pHxyPOf9ADzkyExESgwF4FpgwGFZub+aKNl
X-Gm-Message-State: AOJu0YwPrL9qgTKyOTyyy6pkMnVOUBusZS2cyiGUQLmTpmiLSAuNe4wD
	k3gNnq67MkSVEg+3BYARrsNd/JyNGzsG8iXsadtu2fq/9M3SS74BN2pXUQ==
X-Google-Smtp-Source: AGHT+IHbzehF3/ulBH7kaBkVhitvqZnuyGLgTCV+QmC3ZjJBC9CUm9He2QRuO7DnqyKw9LLeGEKYUw==
X-Received: by 2002:a17:907:1c07:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a751386ebebmr443012866b.5.1719779203764;
        Sun, 30 Jun 2024 13:26:43 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:427:8e07:6fdd:d397])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72affddd7bsm242469066b.186.2024.06.30.13.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 13:26:42 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 30 Jun 2024 22:26:40 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, dpfrey@gmail.com, himanshujha199640@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, mike.looijmans@topic.nl
Subject: Re: [PATCH v3 00/15] iio: chemical: bme680: Driver cleanup
Message-ID: <20240630202640.GA185141@vamoiridPC>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>

On Mon, Jun 10, 2024 at 01:38:11AM +0200, Vasileios Amoiridis wrote:
> Based on fixes-togreg as the 4 first commits are already applied
> 
> Patch 1/15: Added comment for explanation of what mutex is used for
> 
> Patch 2/15: Removed fixes tag
> 
> Patch 3-15/15: Reworded the commit messages to come close to convention
> 	       of 75 chars per line.
> 
> v2: https://lore.kernel.org/linux-iio/20240606212313.207550-1-vassilisamir@gmail.com/
> 
> Patch 4/19:
> 	- Combined the bme680_conversion_time_us() and bme680_wait_for_eoc()
> 	  into one function.
> 	- Added better comment for the calculation.
> 	- Added checks in the bme680_wait_for_eoc() function.
> 
> Patch 5/19:
> 	- Fixed typo in commit message.
> 
> Patch 6/19:
> 	- Added a fixes tag since without the mutexes, read operations can be
> 	  broken.
> 
> Patch 10/19:
> 	- Converted shifting operation to FIELD_GET()
> 
> Patch 11/19:
> 	- Changed convention from &data->bufer[0] to data->buffer.
> 	- Removed IIO_DMA_MINALIGN as it is not needed anymore.
> 
> Patch 13/19:
> 	- Removed IIO_DMA_MINALIGN
> 
> Patch 14/19:
> 	- Splitted from Patch v1 14/19
> 
> Patch 15/19:
> 	- Splitted from Patch v1 14/19
> 
> Patch 16/19: **NEW**
> 	- Use dev_err_probe() where applicable.
> 
> v1: https://lore.kernel.org/linux-iio/20240527183805.311501-1-vassilisamir@gmail.com/
> 
> This started as a series to add support for buffers and the new
> BME688 but it ended up being just a cleaning series. These might
> be quite some patches for such a thing but I feel that they are
> are well split, in order to allow for better review.
> 
> The patches are mostly small changes but essential for the correct use
> of the driver. The first patches looked like fixes that should be
> marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
> is quite straightforward and 17/17 is basically a duplication of a
> very similar commit coming from the BMP280 driver [1].
> 
> In general, the datasheet [2] of the driver is not very descriptive,
> and it redirects the user to the BME68x Sensor API [3]. All the things
> that were identified from the BME68x Sensor API have been marked with
> links to the original locations of the GitHub code. If this is too much
> and we don't want this type of information on the commit message, please
> let me know and I will fix it.
> 
> [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
> [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> [3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master
> 
> 
> Vasileios Amoiridis (15):
>   iio: chemical: bme680: Fix read/write ops to device by adding mutexes
>   iio: chemical: bme680: Fix typo in define
>   iio: chemical: bme680: Drop unnecessary casts and correct adc data
>     types
>   iio: chemical: bme680: Remove remaining ACPI-only stuff
>   iio: chemical: bme680: Sort headers alphabetically
>   iio: chemical: bme680: Remove duplicate register read
>   iio: chemical: bme680: Use bulk reads for calibration data
>   iio: chemical: bme680: Allocate IIO device before chip initialization
>   iio: chemical: bme680: Add read buffers in read/write buffer union
>   iio: chemical: bme680: Make error checks consistent
>   iio: chemical: bme680: Modify startup procedure
>   iio: chemical: bme680: Move probe errors to dev_err_probe()
>   iio: chemical: bme680: Remove redundant gas configuration
>   iio: chemical: bme680: Move forced mode setup in ->read_raw()
>   iio: chemical: bme680: Refactorize reading functions
> 
>  drivers/iio/chemical/bme680.h      |  41 +-
>  drivers/iio/chemical/bme680_core.c | 631 +++++++++++++----------------
>  2 files changed, 291 insertions(+), 381 deletions(-)
> 
> 
> base-commit: 4241665e6ea063a9c1d734de790121a71db763fc
> -- 
> 2.25.1
> 

Hi Jonathan,

It's been three weeks so I am just checking-in here, to be sure that this
series was not lost in the countless e-mails that you receive. Totally
understand the summer time on top, so no hurry at all, just checking in
that it is not lost! :) Thanks for the amazing job with the reviews
though anyways! :)

Cheers,
Vasilis

