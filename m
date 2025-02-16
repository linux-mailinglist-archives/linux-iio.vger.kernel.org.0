Return-Path: <linux-iio+bounces-15596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0FA37632
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA0516F0BE
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380941993BD;
	Sun, 16 Feb 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5EUEH45"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A7C2EF;
	Sun, 16 Feb 2025 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725901; cv=none; b=Z5DPOO1Z+EB4Zaen/u4Qie6UhF5gTfTDmJZslESDNKMs63RgK5GJXea1FT72DeMTJ0KyJq6LCAHS1C5lelJDAefhEgTnmqA2rMKNUsacbqZPKOP8Cn+rIy2hKsWQWPXTmG7KV6Kx7/kATxe3qOzAroyhzp2XhwozBR08f8bVo60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725901; c=relaxed/simple;
	bh=E3tM1vECsfCNDcVKuUmehQ1xAbFy3el7aesQvhH+k9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAej/2HcOM0uEIpAk5DHAw5nREjuSKFamNweJV82XCEyg76f5i3LRPsuHb1eI7I5qs7nBmMIoTtuV1udaiA7PZgF4H7ySvAz3s8HBOg0a0/X/n2DXe9uGj+bZFrx29bndiLd3ZH5GAQa0Sqp0R4utuJp4VmymRmiU5F8uuJ4Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5EUEH45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C922C4CEDD;
	Sun, 16 Feb 2025 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725900;
	bh=E3tM1vECsfCNDcVKuUmehQ1xAbFy3el7aesQvhH+k9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d5EUEH45FgIT0tSYCP+/dp+hDPvoqH2cgVpcdfKjF7xJajbfN/BtvB9J+85qvoAiQ
	 ZcbloqGjoyyI6t+C0+ywv0irkGFXXcywQFtj/KIWvhvlBPJQ2484LwsEfRyCbPGH4e
	 nGWgagkX+sxG1s77xbtZ3QhLFpIAQd/c/QBEgdnBSCR061osm3/qx6mQeOagWpC6c6
	 Kvocnxv7x0p/drZGLZYK8MXU81kyHKB548b9qBQikSSN8QZx8hLfJur4jRZwHPg+UO
	 LABq9C+6MtuFoBZPVDr1txsonojHCuQeeaYRt9e8M5fu916OSwrnGSOW1Kg+W4oA6r
	 vCtq8u2sGFBvw==
Date: Sun, 16 Feb 2025 17:11:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 04/14] iio: accel: adxl345: refac set_interrupts and
 IRQ map
Message-ID: <20250216171132.46445edc@jic23-huawei>
In-Reply-To: <20250210110119.260858-5-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:09 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Split the current set_interrupts() functionality. Separate writing the
> interrupt map from writing the interrupt enable register.
> 
> Move writing the interrupt map into the probe(). The interrupt map will
> setup which event finally will go over the INT line. Thus, all events
> are mapped to this interrupt line now once at the beginning.
> 
> On the other side the function set_interrupts() will now be focussed on
> enabling interrupts for event features. Thus it will be renamed to
> write_interrupts() to better distinguish from further usage of get/set
> in the conext of the sensor features.
> 
> Also, add the missing initial reset of the interrupt enable register.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

After this cleanup (which is good) I wonder why we need to store
intmap at all?  Can we not just get it back from the regmap cache
in the few places we need it (mostly as RMW updates I think).

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 46 +++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 2928c1c0760f..910ad21279ed 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -14,10 +14,10 @@
>  #include <linux/regmap.h>
>  #include <linux/units.h>
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/sysfs.h>

Unrelated change.  Should not be in this patch

>  
>  #include "adxl345.h"
>  
> @@ -96,26 +96,6 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>  
> -static int adxl345_set_interrupts(struct adxl345_state *st)
> -{
> -	int ret;
> -	unsigned int int_enable = st->int_map;
> -	unsigned int int_map;
> -
> -	/*
> -	 * Any bits set to 0 in the INT map register send their respective
> -	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> -	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> -	 */
> -	int_map = st->intio ? st->int_map : ~st->int_map;
> -
> -	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
> -	if (ret)
> -		return ret;
> -
> -	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
> -}
> -
>  static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -376,7 +356,7 @@ static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
>  	struct adxl345_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = adxl345_set_interrupts(st);
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -395,7 +375,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	st->int_map = 0x00;

Maybe you deal with this in a later patch, but in general, why do we need a cached value?
Maybe we should rely on regmap caching to get it back from the register cheaply wherever
it is needed.


> -	return adxl345_set_interrupts(st);
> +	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
>  }
>  
>  static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
> @@ -514,6 +494,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENODEV;
>  	st->fifo_delay = fifo_delay_default;
>  
> +	st->int_map = 0x00;			/* reset interrupts */
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -521,6 +503,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  	indio_dev->available_scan_masks = adxl345_scan_masks;
>  
> +	/* Reset interrupts at start up */
> +	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
> +	if (ret)
> +		return ret;
> +
>  	if (setup) {
>  		/* Perform optional initial bus specific configuration */
>  		ret = setup(dev, st->regmap);
> @@ -571,6 +558,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	}
>  
>  	if (st->intio != ADXL345_INT_NONE) {
> +		/*
> +		 * Any bits set to 0 in the INT map register send their respective
> +		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
> +		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
> +		 */
> +		regval = st->intio ? 0xff : 0;
> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
> +		if (ret)
> +			return ret;
> +
>  		/* FIFO_STREAM mode is going to be activated later */
>  		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
>  		if (ret)


