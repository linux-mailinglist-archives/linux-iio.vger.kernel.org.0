Return-Path: <linux-iio+bounces-12603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CE9D77A7
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB29B25673
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A98537E9;
	Sun, 24 Nov 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkRCdG6C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049092500A6;
	Sun, 24 Nov 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473077; cv=none; b=A7aO9J13pqbh73F2w2zIJu4gB5baYd0xBRv9lmb2xXTWlUTYk95ZWJPD6HuyXrCpgKeEgjGeUV4tuIvoecQHXLzhMfp4Chv2Pdwf5fC2u0cz3gveZOLKHMeY/07GonBR+5+fJqn840TjpmyvbAqoIyeYu/BGtp0DnXQZ4g24XS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473077; c=relaxed/simple;
	bh=6GtikB/z1ymZzCutCpBHlxGdJoF4KZj+dHp+mUvGpwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnB4OfLO3LRRsFKMAF8L0zutKdABiDs+sdUUIGUi8L/hRTlCh0c/5pPCHR+k+FUHujFpI2lDCSrb6Dnqq8iuZh1MRYm7wGC/Bm3XM55F7Q86dK0Pud9lAEcc49aI9d4Nb928dx1G+/w3+Lzl7pBAf57tXcZushijuTyw85S9Hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkRCdG6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B39C4CECC;
	Sun, 24 Nov 2024 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732473076;
	bh=6GtikB/z1ymZzCutCpBHlxGdJoF4KZj+dHp+mUvGpwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TkRCdG6CxFRzjNPc+yUEQ3QbR3581+7iLp8EdxnV7XPafqYdjeVIKG26zG5p9iR+3
	 uTj5HiSVNPNE8J6pyfRJ8LhDMtbbT/ndwA4TN1zLoEORr/eSSIhV663JHXttTyPOkz
	 ojqXq0xMN3Aqo/YtdHS0XwOYcI4D+pu5pABjrkXWGhayCbYfW5Z+NaWzbplKh9p4TX
	 5Z/TeQ/g0HdrFA56zNix/fSY6pstu90hO+h+CHBrgxyRw05IXvnLNn7aeOpcvtOEU8
	 IJ9e8qyhhLq4n+lHV6aVU0KuU0R9b5659sbIXc02HKnQM1pcBqXtw4G0UKWR3euaWZ
	 ij0JkVJ9sQccA==
Date: Sun, 24 Nov 2024 18:31:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 11/22] iio: accel: adxl345: import adxl345 general
 data
Message-ID: <20241124183108.18e0a7f7@jic23-huawei>
In-Reply-To: <20241117182651.115056-12-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:40 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Use struct adxl34x_platform_data from the included public header of the
> input driver for ADXL34x with the following argumentation for this
> approach:
> 
> - The iio driver for the ADXL34x covers features also implemented in
>   the older input driver. The iio driver will implement the same
>   features but can also benefit from including the common header and
>   struct adxl34x_platform_data. Once complete, the input driver could
>   be faded out.

In general platform_data is long dead means that predates hardware configuratino
coming from device tree.

Such a header is legacy that we want to get rid of, not reuse.

> 
> - The fields in the input driver are identical to the fields the IIO
>   implementation will need. Including the header over reimplementing,
>   avoids a duplication of almost identical headers in IIO and iio.
> 
> - The header for the input driver is public. It provides a public
>   interface for adxl34x related implementation and is not private to
>   the input system.

There are no users of that header in the upstream kernel. Better
move would be to proposed deleting it and hard coding the defaults the
input driver.  That should shake out if anyone is using it in a downstream
kernel (I'd be surprised if they are).



> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 32163cfe6f..b16887ec1c 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -16,6 +16,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +#include <linux/input/adxl34x.h>
> +
>  #include "adxl345.h"
>  
>  /* ADXL345 register map */
> @@ -126,10 +128,15 @@
>   */
>  #define ADXL34x_FIFO_SIZE  33
>  
> +static const struct adxl34x_platform_data adxl345_default_init = {
> +	.tap_axis_control = ADXL_TAP_X_EN | ADXL_TAP_Y_EN | ADXL_TAP_Z_EN,
> +};
> +
>  struct adxl34x_state {
>  	int irq;
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
>  	bool fifo_delay; /* delay: delay is needed for SPI */
>  	u8 intio;
>  };
> @@ -331,6 +338,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
>  					 ADXL345_DATA_FORMAT_FULL_RES |
>  					 ADXL345_DATA_FORMAT_SELF_TEST);
> +	const struct adxl34x_platform_data *data;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -346,6 +354,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return -ENODEV;
>  
>  	st->fifo_delay = fifo_delay_default;
> +	data = dev_get_platdata(dev);
> +	if (!data) {
> +		dev_dbg(dev, "No platform data: Using default initialization\n");
> +		data = &adxl345_default_init;
> +	}
> +	st->data = *data;
> +
> +	/* some reasonable pre-initialization */
> +	st->data.act_axis_control = 0xFF;
> +
>  	st->intio = ADXL345_INT1;
>  
>  	indio_dev->name = st->info->name;


