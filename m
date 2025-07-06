Return-Path: <linux-iio+bounces-21402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1048AFA654
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085FB3B5489
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA202882D8;
	Sun,  6 Jul 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT6ZE57e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486915D1;
	Sun,  6 Jul 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818259; cv=none; b=sHt715SasiJa4+eHKx1J7lmjt297BAKdFbAjoWRGijX6NRyzmcF+wF/b/zGHsn1sf7075cuaMGv50Q11G0v8RaRZxGsU5M9F1bzguBw/zweNuv+Foktr5lJG697t0KmR4mH8xlJAi54cJLs30I6h9SD6XzZJlHjY8gSuNKJvb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818259; c=relaxed/simple;
	bh=W4z+DhE+690s6ZsS02gbHOefeqFV25uvHqTaF8NqBKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J690QaMCL3YznDWkBTfgPPni1YuZlunOpLNUPmgDQvLR+sIcmzLMKhJo2B3FWcFvY1T6vut1moSH9v94Wf8wn1werOSerFiJ6bIFTqwgWcE6+8/nNSjPVO04lGndWNA/9V89h0EpF5YuwTVN8gh0zhR0+17PAEh9KCeSP4kAhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT6ZE57e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AC1C4CEEF;
	Sun,  6 Jul 2025 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818259;
	bh=W4z+DhE+690s6ZsS02gbHOefeqFV25uvHqTaF8NqBKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gT6ZE57exdUBczZv91YxpELfwe9rt3qw7d3CVcPepAFHQOElX5dQmL62fpX9+JTD8
	 DQ5AxC7prU8YKks7BGejjPAJpqCER8tE3lsC5up3Rmjtgw/1q9GrFdMjo8EOXperLZ
	 DTRRE0hQilaO6Q0BhRkfFFv/zgkwM9zZ+T4aYBdnVDGjONmAI2Z1fpfaV2j67dWkoB
	 PitNmv21AQEOMtcqqMFKCYHNJYeQwxZqNkKUsPpCKzSTgbKSZciXEjzR+0AfkqGwEU
	 0chzXjZlhkZzQyUbtGFkw0wXs8uBZI58cwo8AW0CJg/u/5BgHPHqgOVScLINNMpy/q
	 F8s24aiCX5jeQ==
Date: Sun, 6 Jul 2025 17:10:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v11 1/8] iio: accel: adxl345: simplify interrupt mapping
Message-ID: <20250706171051.678c2519@jic23-huawei>
In-Reply-To: <20250702230315.19297-2-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
	<20250702230315.19297-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 23:03:08 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Refactor the sensor interrupt mapping by utilizing regmap_assign_bits(),
> which accepts a boolean value directly. Introduce a helper function to
> streamline the identification of the configured interrupt line pin. Also,
> use identifiers from units.h to represent the full 8-bit register when
> setting bits.
> 
> This is a purely refactoring change and does not affect functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I'd really like to reduce the number of patches outstanding so I'll
apply a few of these now.

Applied this one.

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 34 +++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index e21ec6c15d15..6c437d7a59ed 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -1088,6 +1088,19 @@ static const struct iio_info adxl345_info = {
>  	.hwfifo_set_watermark = adxl345_set_watermark,
>  };
>  
> +static int adxl345_get_int_line(struct device *dev, int *irq)
> +{
> +	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (*irq > 0)
> +		return ADXL345_INT1;
> +
> +	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +	if (*irq > 0)
> +		return ADXL345_INT2;
> +
> +	return ADXL345_INT_NONE;
> +}
> +
>  /**
>   * adxl345_core_probe() - Probe and setup for the accelerometer.
>   * @dev:	Driver model representation of the device
> @@ -1203,23 +1216,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (ret)
>  		return ret;
>  
> -	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> -	if (irq < 0) {
> -		intio = ADXL345_INT2;
> -		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> -		if (irq < 0)
> -			intio = ADXL345_INT_NONE;
> -	}
> -
> +	intio = adxl345_get_int_line(dev, &irq);
>  	if (intio != ADXL345_INT_NONE) {
>  		/*
> -		 * Any bits set to 0 in the INT map register send their respective
> -		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> -		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> +		 * In the INT map register, bits set to 0 route their
> +		 * corresponding interrupts to the INT1 pin, while bits set to 1
> +		 * route them to the INT2 pin. The intio should handle this
> +		 * mapping accordingly.
>  		 */
> -		regval = intio ? 0xff : 0;
> -
> -		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
> +		ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_MAP,
> +					 U8_MAX, intio);
>  		if (ret)
>  			return ret;
>  


