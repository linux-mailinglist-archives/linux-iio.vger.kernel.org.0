Return-Path: <linux-iio+bounces-1806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1A835720
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A371F21B0B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB7381CB;
	Sun, 21 Jan 2024 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="TXj11sNS"
X-Original-To: linux-iio@vger.kernel.org
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488DE37713
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705858506; cv=none; b=A2QAanpwHeBvZKLmeA7w6dmQ7jMCBuyxDlKDIel3FfMHUE9fN7yQen3kF9ZPNrTBezAIMNcl1OlvmO6/LUNfKbN+dwqpE6X4vEaZoHBddajwNFWTVFhfGq9fv7+RArq0ogt0XxNCD0vcg8CSlNf9tSKDIgo6V8w53NVy1s5kRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705858506; c=relaxed/simple;
	bh=YpV57zBD0GBuOHClA+5mHx4jH+nCh146hi3uQtZq6Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF1L4rayJiJ+qLIYBWy6SiM6s+103bPFjtwaM4Djc/WNOJql55E/O4a/pvW/qlgObTpkFGlsKdzvVAgx3lZAWAzUnjcV2Y5skq5meyFjxQBGDV5xTe9Z0x0ouJJJFBFV7uXrui6rfe0lSgxNoffCIbxGJlE+QoZxpdkLHEXnZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=TXj11sNS; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d+0Yjn2sUzlOE5kijAHJL6VJsMQlJz2OGaZzTLQFMwQ=; b=TXj11sNSH9b0UUJprd0TV1fXBe
	flLRVAqM4Yo29AYUFQ/IE9zXhHVPWw8+UTuOWELIiyjcF5uyJW6Trp+Dhr+iDvs5twF8jvxKlCM/d
	tSdYdh8lGqjS9/HHVF+2YPD7o5+S/bpeY6e9L9tYCCeA0YIIJjOWztmnPmLH6JDbkLHRjdtNixMv+
	VIbhSKfVFslS86ipB2nGhvBTcY7uIf+cRhhhAl/D/SMUTa+/FTU7fBZPjXehTxojx35qNxT+EyQgY
	kA2meDtrBP4xH5CidrKAGk2Zi5crZ1Z3v18UF2yqvpyYiT7SOq1ERA7SxXvgCe8OO5HiUm/fGgVda
	PGb+WUag==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1rRbig-0004Zk-Vi; Sun, 21 Jan 2024 18:34:55 +0100
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lars@metafoo.de>)
	id 1rRbig-000CnV-JV; Sun, 21 Jan 2024 18:34:54 +0100
Message-ID: <d909090f-c77f-4ee9-b8ca-f92205d9296f@metafoo.de>
Date: Sun, 21 Jan 2024 09:34:52 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: hdc3020: Add Makefile, Kconfig and
 MAINTAINERS entry
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>
References: <20240121135123.71506-1-jic23@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240121135123.71506-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27161/Sun Jan 21 10:38:57 2024)

On 1/21/24 05:51, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Something when wrong when applying the original patch and only the
> c file made it in.  Here the rest of the changes are applied.
>
> Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Cc: Li peiyu <579lpy@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good, thanks Jonathan.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   MAINTAINERS                   |  8 ++++++++
>   drivers/iio/humidity/Kconfig  | 12 ++++++++++++
>   drivers/iio/humidity/Makefile |  1 +
>   3 files changed, 21 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..1b590e6f6bdd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22005,6 +22005,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
>   F:	drivers/media/i2c/ds90*
>   F:	include/media/i2c/ds90*
>   
> +TI HDC302X HUMIDITY DRIVER
> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +M:	Li peiyu <579lpy@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> +F:	drivers/iio/humidity/hdc3020.c
> +
>   TI ICSSG ETHERNET DRIVER (ICSSG)
>   R:	MD Danish Anwar <danishanwar@ti.com>
>   R:	Roger Quadros <rogerq@kernel.org>
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 2de5494e7c22..b15b7a3b66d5 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -48,6 +48,18 @@ config HDC2010
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called hdc2010.
>   
> +config HDC3020
> +	tristate "TI HDC3020 relative humidity and temperature sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say yes here to build support for the Texas Instruments
> +	  HDC3020, HDC3021 and HDC3022 relative humidity and temperature
> +	  sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hdc3020.
> +
>   config HID_SENSOR_HUMIDITY
>   	tristate "HID Environmental humidity sensor"
>   	depends on HID_SENSOR_HUB
> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> index f19ff3de97c5..5fbeef299f61 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
>   obj-$(CONFIG_DHT11) += dht11.o
>   obj-$(CONFIG_HDC100X) += hdc100x.o
>   obj-$(CONFIG_HDC2010) += hdc2010.o
> +obj-$(CONFIG_HDC3020) += hdc3020.o
>   obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
>   
>   hts221-y := hts221_core.o \



