Return-Path: <linux-iio+bounces-12602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E09D7743
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B60E281F18
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D213774D;
	Sun, 24 Nov 2024 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLIy9Uz3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133472500BD;
	Sun, 24 Nov 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472622; cv=none; b=i6uH620DqmBGp1uNejpOHXPSx9hsYBALpdPi0A4YXtMUqdnrC1snqBDedM/4xff634WV+7S1130oqaR8rqKPsucDkLO1GWE2CY7Nr3AnE8+aWz5im04cP5ioay/zFbJ5XRWPxe5zE+H3p216UKHTVTbzQAvgggVohFaotZwwuC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472622; c=relaxed/simple;
	bh=tWDZRcOpw0WVBvBLmZCIxdmriq1O3FKl6HlKlVIot6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIOC7TivfG5n9LgQuukzuUhhwJiE8jLbwNDCKtlyJzAN7MZl/Xs0tVO0e7/3L2efK3mP2mZo9+hjWOpdJfLOHCtxrMpVhSAvuwrVuh6OvkQ7eLx8/RDOxwx5D45R8FGshnP52V2+SRwzMJ5zvbb6aawMkYRczooGNiYSzbaQvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLIy9Uz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA20C4CECC;
	Sun, 24 Nov 2024 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732472621;
	bh=tWDZRcOpw0WVBvBLmZCIxdmriq1O3FKl6HlKlVIot6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLIy9Uz3YQSgbFeptj10KBqJvkFBsTWzWevpYpA3/qsyQWC/8RJWRkv2sLsm838V8
	 R10RoKzgFN7w3eGW3g1qY0Z3lzJje0EBIEs7fo5Kt4GRoIM9sFVzqJx/DP8kUNYV3C
	 IzWTQDzAITguUft2rrweLa4BWCgi/ccCvfiQCA10LBDBdKc/zMfmQyO2IJsw0G+zWr
	 DlHtgpZRqjqtMNXgHelPpmPPRpJZ1+Y51ybIFns4lu0LhyJ1uAQZuDlyDFA9Ny0sND
	 lhaXPkogjBy3ENhc2d3OCT/5h4SA1bLB56kX5+0GZe8B+XM/jlNub5kq6BQUIQik5k
	 B3V1OnEqaGHWg==
Date: Sun, 24 Nov 2024 18:23:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 10/22] iio: accel: adxl345: set interrupt line to
 INT1
Message-ID: <20241124182333.375b49a7@jic23-huawei>
In-Reply-To: <20241117182651.115056-11-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:39 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The adxl345 sensor uses one of two interrupt lines, INT1 or INT2. The
> interrupt lines are used to signal feature events such as watermark
> reached, single tap, double tap, activity, etc. Only one interrupt line
> is used and must be configured. The adxl345 default is to use INT1 and
> in many installations only INT1 is even connected. Therefore configure
> INT1 as the sensor's default interrupt line.
In others only INT2 is connected. Hence earlier comment and you will need
the driver to detect which is connected by using interrupt names
and then set this up appropriately.

It would be fine to also have the driver just fail to probe on the
INT2 only case, but you must check for it rather than routing interrupts
to a potentially unconnected pin.

Jonathan

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index c8d9e1f9e0..32163cfe6f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -131,6 +131,7 @@ struct adxl34x_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  	bool fifo_delay; /* delay: delay is needed for SPI */
> +	u8 intio;
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -345,6 +346,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENODEV;
>  
>  	st->fifo_delay = fifo_delay_default;
> +	st->intio = ADXL345_INT1;
>  
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;


