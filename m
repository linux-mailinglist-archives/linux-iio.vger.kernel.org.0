Return-Path: <linux-iio+bounces-10200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC86991903
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CCC2814AE
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F32157A5A;
	Sat,  5 Oct 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO3+cUML"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C61AAC4;
	Sat,  5 Oct 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150632; cv=none; b=NoU7c4Qhw/cx+73U+JCoOgl/nJvacVLZ5jZZtulxMt+1jVOa4Pxkf4sbdOib9wb70ZJa/RApOa6LgnBxQsJ95rtZQT1oHpVXo/hmzTI4QzN8F4/0v3EFUnGERmQ6V5eIiIamyQFoh45MB9rn0o90Vj1kgutyz9USGl4sL0NmlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150632; c=relaxed/simple;
	bh=Ag/3FvoYJ71do1kiINPWOESDJm9nSOqoyMtG/VtIUIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTflvA0fMs0bkmto/UbsSBt9G42+rz1MPOMFjZ6M006C5+KjHD+g2ei8tpHfa2kWe3xep+cX/WJeVTzJ0gCxduyPfkpmm9nLT3qshs8ObxSYKpvkyJ1wqXZP8cO0n/yaZ/QZebI0r8nSmj16MgzmGvkMwPWhMA2FfirPMINjvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO3+cUML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806CFC4CEC2;
	Sat,  5 Oct 2024 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150632;
	bh=Ag/3FvoYJ71do1kiINPWOESDJm9nSOqoyMtG/VtIUIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vO3+cUMLC7pzQISoXnSKnvvxDkXJ/Fxu+t92xR7hMvtKGT/oIz7T26Z2Tv1sB/UU1
	 /dvxizsvfnZZ2RbPnPAQKVzFjbi9eyBFlQEgMJIvnNJiS3rwEYCSidP0KwLr9ibjUa
	 woo7g5ab0Wfr+vMkyYb1GiUN8cgq85Q4y1EegntKH8NNeUWP6ry7MyM3izXu5KOFm7
	 lB/33cA/qjmES1slQQzy2Fedbs6jNiMB9FxGCVOc8Wu3Hh05ZjWN9jJIJ0FP1pFZ2W
	 zBwlaEJGTkCIQcM8980yo/cCFR3xktynijWrWoZfo9EXCeUm2JEIm2Yw96ofbCcjaL
	 996KHJhcIOj8Q==
Date: Sat, 5 Oct 2024 18:50:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer
 <sean@geanix.com>, Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>, Alexandru Ardelean
 <ardeleanalex@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, Shoji
 Keita <awaittrot@shjk.jp>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas
 Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 05/13] iio: adc: ti-lmp92064: add missing select
 REGMAP_SPI in Kconfig
Message-ID: <20241005185001.396cb92c@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-5-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-5-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:51 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: 627198942641 ("iio: adc: add ADC driver for the TI LMP92064 controller")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

J
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index e6be1f1ec79f..1206a5487334 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1531,6 +1531,7 @@ config TI_AM335X_ADC
>  config TI_LMP92064
>  	tristate "Texas Instruments LMP92064 ADC driver"
>  	depends on SPI
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for the LMP92064 Precision Current and Voltage
>  	  sensor.
> 


