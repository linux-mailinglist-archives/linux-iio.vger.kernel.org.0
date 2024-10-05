Return-Path: <linux-iio+bounces-10201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93052991906
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1D21C20FDF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A74157A5A;
	Sat,  5 Oct 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpLT3QOM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCF1AAC4;
	Sat,  5 Oct 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150717; cv=none; b=GvneaBF4DMiiWaKrLhqvgX02LMv4QvNts9HIXNZcR+r33DcpsfGGWewVwKqPBDnFUfHZwg9Z0OJkUBb3beGOAmtVQGCTV11RD0vC13K6XTKb+hOROgRX01M3DtmI2sZ/YtoA+Xxs98weI+JE0RfXyTdZ2I+U+OYy9ieJrbXdrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150717; c=relaxed/simple;
	bh=sZ72GpiX27oBYO5yJVHbSgbTy9LerUgFHoSYAueFan8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mP4udfzCKhMkRXaXOyFu0zb7PM1Vaq6uVwhKnrgk3Ml2yXpRPVwuw11eUetYAO4wmfFhloWI+SGtXoDzPYOe0ymSesSGNSeINTEpJlmvB8Xmhrp7vyowNxQYe+4VHsPIWRA6S0gBNZ/2d4Q0p6XvXLD49AE3WYTyZbisfpCtG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpLT3QOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97588C4CEC2;
	Sat,  5 Oct 2024 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150717;
	bh=sZ72GpiX27oBYO5yJVHbSgbTy9LerUgFHoSYAueFan8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpLT3QOMPbmCwm6xLji6JcfcdWDNXQM3AUi+NhoGIl4boPyckXCAyO5XlTuuwR8Hb
	 oTZn2rs/QOlQSCdbeVvk+DRIjki6xZUUxalo/G/fkNT9/vUo4M0jmcIUd6soXS0ECR
	 YjQOa1JcvgtxUlOSUm3ujxXhJq6Gh6X1mpYl3OWZLLcQ6bDqcGbTpw6W3+EMh8x2ZJ
	 xaYaS/uDGwS95nXm0ZuzRLoUMiLBt0OhXZuYt3CbXdd9zZSXMiPokWjgBQJeD6wSOz
	 2usr00P1cr272WrYF7U/n6MZlcAr5XF39ik72Xt0GsorICD+itrA/mHNMkigaKwEYP
	 GnWpAkkLDDckQ==
Date: Sat, 5 Oct 2024 18:51:17 +0100
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
Subject: Re: [PATCH 06/13] iio: adc: ti-lmp92064: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185117.531f5103@jic23-huawei>
In-Reply-To: <20241003-iio-select-v1-6-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-6-67c0385197cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 23:04:52 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 6c7bc1d27bb2 ("iio: adc: ti-lmp92064: add buffering support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 1206a5487334..1bf915c3d053 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1532,6 +1532,8 @@ config TI_LMP92064
>  	tristate "Texas Instruments LMP92064 ADC driver"
>  	depends on SPI
>  	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the LMP92064 Precision Current and Voltage
>  	  sensor.
> 


