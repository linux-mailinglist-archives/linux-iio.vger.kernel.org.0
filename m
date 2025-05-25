Return-Path: <linux-iio+bounces-19877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9FAC3492
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6AD1890F85
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98D51DF254;
	Sun, 25 May 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlZ3cYRl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A82FC1D;
	Sun, 25 May 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748176413; cv=none; b=Qps0OZHBUvxA6NCjxIbB7pu2WtZOslSbPug4nebSuec7O7WM1ou2DOLQ36X/MnhFsIqyXxsDOfEMgVC+2h1RcOeuhBw/Sx5bvQiuZ263/puU+nxZ14h+rF6ehD2cBfq0hOU3+pDWJCZZZcF8RYb2H9JJvL3C/RLk4uS/cjDT9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748176413; c=relaxed/simple;
	bh=hIuIlhuZNJDW5L2piUkx5iUdAk1UaXHfkrN/76XdtI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqdVVLzGbvK1tlUzg4tmLV1i+wfNkx70nmkznLgmYu0kcBehTJXh+mz77g6haEtqWrhILH6zZbMlgtZBWJowMQKAvly3VFP++ebFQ569AJEJmfA7HFIqOo6nj23AvdsAuS6KWsN7cJYt+WxJqGJGiDRTarnLodDXh06n3ThLBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlZ3cYRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEBBC4CEEA;
	Sun, 25 May 2025 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748176413;
	bh=hIuIlhuZNJDW5L2piUkx5iUdAk1UaXHfkrN/76XdtI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WlZ3cYRlokMLjsYVB09Y6zzriHoKVwVOOT3b6ea6z7SQCtDyN4kKfPokd7ZIPHZj9
	 NLU+ay5oX74T2vFeDC3je0ubFEhsOH03g4HUWUtVkKXjCZGMSFVYtIt0mUI/2dwOKc
	 3AzLbI7n3OQG8fLGF1cOUO4pUjm1ggT/WlRNBbLFmtbIpyAJxVbfJWzu4+7bBR6vNu
	 PL8tfjBAxTNhWEz7zgh77cVBAUBscnUUcdk6YRxR6t/s6iqwRjexLoxJhlu2vcOION
	 csplkD9uOgG+pggFQSKr+VXgiJHh87V5MY6fUZ5B+qP0LOIKJV4QcvZVSbf1ZJ4DHe
	 0qfVnXGX1++gw==
Date: Sun, 25 May 2025 13:33:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/12] iio: accel: adxl313: prepare interrupt
 handling
Message-ID: <20250525133325.2a70e888@jic23-huawei>
In-Reply-To: <20250523223523.35218-7-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:17 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Evaluate the devicetree property for an optional interrupt line, and
> configure the interrupt mapping accordingly. When no interrupt line
> is defined in the devicetree, keep the FIFO in bypass mode as before.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl313.h      |  8 ++++++++
>  drivers/iio/accel/adxl313_core.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> index 9bf2facdbf87..ab109d1c359e 100644
> --- a/drivers/iio/accel/adxl313.h
> +++ b/drivers/iio/accel/adxl313.h
> @@ -21,7 +21,9 @@
>  #define ADXL313_REG_ACT_INACT_CTL	0x27
>  #define ADXL313_REG_BW_RATE		0x2C
>  #define ADXL313_REG_POWER_CTL		0x2D
> +#define ADXL313_REG_INT_ENABLE		0x2E
>  #define ADXL313_REG_INT_MAP		0x2F
> +#define ADXL313_REG_INT_SOURCE		0x30
>  #define ADXL313_REG_DATA_FORMAT		0x31
>  #define ADXL313_REG_DATA_AXIS(index)	(0x32 + ((index) * 2))
>  #define ADXL313_REG_FIFO_CTL		0x38
> @@ -45,6 +47,11 @@
>  #define ADXL313_SPI_3WIRE		BIT(6)
>  #define ADXL313_I2C_DISABLE		BIT(6)
>  
> +#define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
> +
> +#define ADXL313_FIFO_BYPASS			0
> +#define ADXL313_FIFO_STREAM			2
> +
>  extern const struct regmap_access_table adxl312_readable_regs_table;
>  extern const struct regmap_access_table adxl313_readable_regs_table;
>  extern const struct regmap_access_table adxl314_readable_regs_table;
> @@ -65,6 +72,7 @@ struct adxl313_data {
>  	struct regmap	*regmap;
>  	const struct adxl313_chip_info *chip_info;
>  	struct mutex	lock; /* lock to protect transf_buf */
> +	int irq;

Curious.  Why do we need to keep this around?  Normally we only need
the actual interrupt number in the probe() function.

>  	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 6170c9daa30f..9db318a03eea 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -8,11 +8,17 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  
>  #include "adxl313.h"
>  
> +#define ADXL313_INT_NONE			U8_MAX
> +#define ADXL313_INT1				1
> +#define ADXL313_INT2				2
> +
>  static const struct regmap_range adxl312_readable_reg_range[] = {
>  	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
>  	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> @@ -436,6 +442,7 @@ int adxl313_core_probe(struct device *dev,
>  {
>  	struct adxl313_data *data;
>  	struct iio_dev *indio_dev;
> +	u8 int_line;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -461,6 +468,30 @@ int adxl313_core_probe(struct device *dev,
>  		return ret;
>  	}
>  
> +	int_line = ADXL313_INT1;
> +	data->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +	if (data->irq < 0) {
> +		int_line = ADXL313_INT2;
> +		data->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +		if (data->irq < 0)
> +			int_line = ADXL313_INT_NONE;
> +	}
> +
> +	if (int_line == ADXL313_INT1 || int_line == ADXL313_INT2) {

Why not int_line != ADXL313_INT_NONE ?
Or flip the logic so that you do that case first.

> +		/* FIFO_STREAM mode */
> +		ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_MAP,

A number of bits in this register are give in datasheet as always 0.
As a general rule writing bits documented like that is unwise. Sometimes
they have undocumented side effects.

> +					 0xff, int_line == ADXL313_INT2);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* FIFO_BYPASSED mode */

I'd like the comment to say why you bypass the fifo in this case.
In theory nothing stops us polling for the watermark. I don't mind
the driver not doing that because all reasonable boards will wire
the interrupt if they want fifo support, but we should talk a little
more about why here.

> +		ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
> +				   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
> +					      ADXL313_FIFO_BYPASS));
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, IIO_ADXL313);


