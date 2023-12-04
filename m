Return-Path: <linux-iio+bounces-595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F7803938
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E47B20B96
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD752D039;
	Mon,  4 Dec 2023 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3FSjTKQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD62C18A;
	Mon,  4 Dec 2023 15:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08EFC433C8;
	Mon,  4 Dec 2023 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701705125;
	bh=sLrwXKlgpUH4XcLJWMQP/dKn9qdJ9bPMqLmWrNS2VyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3FSjTKQpOQlFLB2G8k+Q9wkA2RQBQttVjE1w79xEwSgkSVHp3u8g055qfRUhlGel
	 5TGTUWtcI84zFkKCY8pK/LlGhlWjGdiZn7ViI3S7uydkeM/YGzqEVvjkWpYhAGJmst
	 zq5JI2OX0HsWYrTOvM3UqOvoXl2G1m1fIftKuHM/D11fbFxwMMhB52ukFaSCS0LcHp
	 0j18raVLP1+9jvOPJiQGW9mQEoZ6ocwippWqvFqyrKj600H8M7O+BRWZFx6In4WUdG
	 UIYCmH0/eiuKaCgzezMqADPFrjXNThC47xSxLsFjQLTdZygoEUNJmINYXvD/e5i/k3
	 lvmJD4Hw5wsQQ==
Date: Mon, 4 Dec 2023 15:51:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 11/12] iio: adc: adi-axi-adc: convert to regmap
Message-ID: <20231204155158.411b4bbd@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-11-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-11-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:20:24 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use MMIO regmap interface. It makes things easier for manipulating bits.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Perhaps put this in the precursor set as well. Looks fine to me and will just
be noise in the main discussion.

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 85 ++++++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index ae83ada7f9f2..c247ff1541d2 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
>  #include <linux/iio/iio.h>
> @@ -62,7 +63,7 @@ struct adi_axi_adc_state {
>  	struct mutex				lock;
>  
>  	struct adi_axi_adc_client		*client;
> -	void __iomem				*regs;
> +	struct regmap				*regmap;
>  };
>  
>  struct adi_axi_adc_client {
> @@ -90,19 +91,6 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
>  }
>  EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
>  
> -static void adi_axi_adc_write(struct adi_axi_adc_state *st,
> -			      unsigned int reg,
> -			      unsigned int val)
> -{
> -	iowrite32(val, st->regs + reg);
> -}
> -
> -static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
> -				     unsigned int reg)
> -{
> -	return ioread32(st->regs + reg);
> -}
> -
>  static int adi_axi_adc_config_dma_buffer(struct device *dev,
>  					 struct iio_dev *indio_dev)
>  {
> @@ -163,17 +151,20 @@ static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
>  {
>  	struct adi_axi_adc_state *st = iio_priv(indio_dev);
>  	struct adi_axi_adc_conv *conv = &st->client->conv;
> -	unsigned int i, ctrl;
> +	unsigned int i;
> +	int ret;
>  
>  	for (i = 0; i < conv->chip_info->num_channels; i++) {
> -		ctrl = adi_axi_adc_read(st, ADI_AXI_REG_CHAN_CTRL(i));
> -
>  		if (test_bit(i, scan_mask))
> -			ctrl |= ADI_AXI_REG_CHAN_CTRL_ENABLE;
> +			ret = regmap_set_bits(st->regmap,
> +					      ADI_AXI_REG_CHAN_CTRL(i),
> +					      ADI_AXI_REG_CHAN_CTRL_ENABLE);
>  		else
> -			ctrl &= ~ADI_AXI_REG_CHAN_CTRL_ENABLE;
> -
> -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i), ctrl);
> +			ret = regmap_clear_bits(st->regmap,
> +						ADI_AXI_REG_CHAN_CTRL(i),
> +						ADI_AXI_REG_CHAN_CTRL_ENABLE);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> @@ -310,21 +301,32 @@ static int adi_axi_adc_setup_channels(struct device *dev,
>  	}
>  
>  	for (i = 0; i < conv->chip_info->num_channels; i++) {
> -		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i),
> -				  ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> +		ret = regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
> +				   ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
>  }
>  
> -static void axi_adc_reset(struct adi_axi_adc_state *st)
> +static int axi_adc_reset(struct adi_axi_adc_state *st)
>  {
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, 0);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
> +	if (ret)
> +		return ret;
> +
>  	mdelay(10);
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> +			   ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	if (ret)
> +		return ret;
> +
>  	mdelay(10);
> -	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
> -			  ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
> +	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
> +			    ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
>  }
>  
>  static void adi_axi_adc_cleanup(void *data)
> @@ -335,12 +337,20 @@ static void adi_axi_adc_cleanup(void *data)
>  	module_put(cl->dev->driver->owner);
>  }
>  
> +static const struct regmap_config axi_adc_regmap_config = {
> +	.val_bits = 32,
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x0800,
> +};
> +
>  static int adi_axi_adc_probe(struct platform_device *pdev)
>  {
>  	struct adi_axi_adc_conv *conv;
>  	struct iio_dev *indio_dev;
>  	struct adi_axi_adc_client *cl;
>  	struct adi_axi_adc_state *st;
> +	void __iomem *base;
>  	unsigned int ver;
>  	int ret;
>  
> @@ -361,15 +371,24 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	cl->state = st;
>  	mutex_init(&st->lock);
>  
> -	st->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(st->regs))
> -		return PTR_ERR(st->regs);
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> +					   &axi_adc_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
>  
>  	conv = &st->client->conv;
>  
> -	axi_adc_reset(st);
> +	ret = axi_adc_reset(st);
> +	if (ret)
> +		return ret;
>  
> -	ver = adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
> +	ret = regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
> +	if (ret)
> +		return ret;
>  
>  	if (cl->info->version > ver) {
>  		dev_err(&pdev->dev,
> 


