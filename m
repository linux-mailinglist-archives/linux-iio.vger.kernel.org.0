Return-Path: <linux-iio+bounces-8538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABA9557F9
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 15:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE301C21104
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137814A635;
	Sat, 17 Aug 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtTbljhR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C211187;
	Sat, 17 Aug 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723899937; cv=none; b=ZMZKRtjnnMafxjfMwZ0qEZb4TnUtYuhfkDSISPM/FUANI0CcmhVGsCVyX7QRip/9GAIJ/8DwBmAcEqGxmUDG3YZVtlAIkaVIp6UdJGm8s7MM7XsC+nkhOBzg/FFabnMoAGYpIK+qEt3rkw3zCSyibFeCq7LitQvxca7Nw3TOyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723899937; c=relaxed/simple;
	bh=ynNt+qJtq1GzV89D76JrRGwxuyN/mwj7wAUxZty0RdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0gffVFulls6VRj2omgMyZfiO/BNqABAEzOQ+si6ac4eYt7c1Z2NoVovJM3YgkxAyfhgjRTa+SiJfOYmX8AEBDDS+DOtX696hLdWHKcRudoFjk1VJu2Vc+QN3UKU4fXnEvWyFIhiWKDi0nvqp4q2U8vOdcnwzT2sCzPUATWeDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtTbljhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9825BC116B1;
	Sat, 17 Aug 2024 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723899936;
	bh=ynNt+qJtq1GzV89D76JrRGwxuyN/mwj7wAUxZty0RdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtTbljhRNWfbu8mQXFzCcwJGFYssq8HLr5wsVb3erywUw3VacOH5pxZK1JQawlUr6
	 d5d67vkY2bgPhnNdGL3haWx5pS9xgW4Jbi8U7i7SByzD/Nrp4HUbTC0OqdJcDwH7zs
	 +8Q41T+TeLUUB87zsXFoZUf5V9sKpQYP2cbV8MlHKvmn3zEMjL1D2Ln9dL2SMgOifS
	 tHO5A4udD0eANPE+7bBUvLeoF6P9NA/2woXJVDBwmtnVT9cv/fb49F1xat8SZHSRAb
	 DJ6nqYVhT70Gi1NIslOd1AzSvQbg9QMOpkeAi9Pp91aoBCFpUHulTE5bfu7GgALMST
	 zCx9tTXAMyrQQ==
Date: Sat, 17 Aug 2024 14:05:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV18XX series SARADC
Message-ID: <20240817140526.579cd9cc@jic23-huawei>
In-Reply-To: <20240812-sg2002-adc-v4-2-599bdb67592f@bootlin.com>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
	<20240812-sg2002-adc-v4-2-599bdb67592f@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 17:00:56 +0200
Thomas Bonnefille <thomas.bonnefille@bootlin.com> wrote:

> This adds a driver for the common Sophgo SARADC.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Similar comment on wild cards to the one you resolved in the dt binding
applies to the driver.

So normally convention is pick a part and name after that for
all function names, parameters etc.

cv1800b seems appropriate given the binding.

Other than that, just one trivial comment from me.

Jonathan


> diff --git a/drivers/iio/adc/sophgo-cv18xx-adc.c b/drivers/iio/adc/sophgo-cv18xx-adc.c
> new file mode 100644
> index 000000000000..ab7ee0f482cc
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-cv18xx-adc.c
> @@ -0,0 +1,208 @@

> +static int cv18xx_adc_probe(struct platform_device *pdev)
> +{
> +	struct cv18xx_adc *saradc;
> +	struct iio_dev *indio_dev;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	saradc = iio_priv(indio_dev);
> +	indio_dev->name = "sophgo-cv18xx-adc";
This definitely doesn't want to be wildcard based

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &cv18xx_adc_info;
> +	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
> +	indio_dev->channels = sophgo_channels;
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(saradc->regs))
> +		return PTR_ERR(saradc->regs);
> +
> +	saradc->irq = platform_get_irq_optional(pdev, 0);
> +	if (saradc->irq >= 0) {
> +		init_completion(&saradc->completion);
> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> +				       cv18xx_adc_interrupt_handler, 0,
> +				       dev_name(&pdev->dev), saradc);
> +		if (ret)
> +			return ret;
> +
> +		writel(1, saradc->regs + CV18XX_ADC_INTR_EN_REG);
> +	}
> +
> +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);

Is this used?

> +	writel(FIELD_PREP(CV18XX_ADC_DEF_STARTUP_CYCLE_MASK, 0xF) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_SAMPLE_WINDOW_MASK, 0xF) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_CLOCK_DIVIDER_MASK, 0x1) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_COMPARE_CYCLE_MASK, 0xF),
> +	       saradc->regs + CV18XX_ADC_CYC_SET_REG);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}


