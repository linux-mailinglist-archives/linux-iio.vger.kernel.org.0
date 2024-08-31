Return-Path: <linux-iio+bounces-8906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFD967111
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91614284123
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE217C7CC;
	Sat, 31 Aug 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCS1ylG/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CE16CD1D;
	Sat, 31 Aug 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102658; cv=none; b=Uj1usTjisAe6CLntBlKAs4zV5DHvfWBbMntH/sVTrReWgcSP0c4YN6z+SvuBddCvw8tYPGEnkR1O5586UQwJQ3F57Yo1fD9rXpsafrBDu7Go+X7ayIKrNuAm+tGVl0S/Z1P+6x7rdlj9rwRf5smn0Lp/vRAqh70MlerDRfwY4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102658; c=relaxed/simple;
	bh=o+aySaL7w/0qvTUTmTKr4PdL//PX2C9y7fl4H4AiQnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+jGF1T8bCMzd8mTzjRupsBFTTQDtPuuhNXYvCErMg+zVbs9JnEeH9nzyTpetdRSd89Jl3MaqEnwfLjHkIh+xQZ3b4CVz6ySm3xb+H/mXXzOgVSeFKxYauCQyTyZoko4gaL5dZqDFhwO044b2tBZ+cwl85Unyz189k/N3Tn+NW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCS1ylG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184D2C4CEC0;
	Sat, 31 Aug 2024 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725102658;
	bh=o+aySaL7w/0qvTUTmTKr4PdL//PX2C9y7fl4H4AiQnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCS1ylG/9h9cbIEWYjsDw7CkXk/d0CGO6MvG5TU8RtZbjpABTgjHmM78tjxN0PwVq
	 D9b9RV+IWQ4oanQXrXsCZ3mZJTk0W0DefGsnf4bwEDkik6fHCaaKOFxqFCjVv/HbLN
	 pqmBIpxx6YCJowVQONdODz4aBFTZdlXqtkamtaqjfP3ZU5NygwEsNwFqFDywlpe1+S
	 nX0bmPm5+5xiy07p8E+f8XAv4pxfrfESSPsuVgsmKxauKUPTyyh7R0zLHRiUjFw3qV
	 qOZqsKqRacnJu83H+e5dp1zKbILwLViFcLkV0Ebgr8s+m1DQN8Rqi1TBjxdTCIAGLm
	 pnOhGY6TJR3Qg==
Date: Sat, 31 Aug 2024 12:10:49 +0100
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
Subject: Re: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
Message-ID: <20240831121049.517c95f7@jic23-huawei>
In-Reply-To: <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
	<20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Minor stuff inline.

I'll fix up whilst applying.

Jonathan

> diff --git a/drivers/iio/adc/sophgo-cv1800b-adc.c b/drivers/iio/adc/sophgo-cv1800b-adc.c
> new file mode 100644
> index 000000000000..f4cdec966694
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-cv1800b-adc.c
> @@ -0,0 +1,218 @@

> +static int cv1800b_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct cv1800b_adc *saradc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:{
> +		u32 sample;
> +
> +		scoped_guard(mutex, &saradc->lock) {
> +			int ret;
> +
> +			cv1800b_adc_start_measurement(saradc, chan->scan_index);
> +			ret = cv1800b_adc_wait(saradc);
> +			if (ret < 0)
> +				return ret;
> +
> +			sample = readl(saradc->regs + CV1800B_ADC_CH_RESULT_REG(chan->scan_index));
> +		}
> +		if (!(sample & CV1800B_ADC_CH_VALID))
> +			return -ENODATA;
> +
> +		*val = sample & CV1800B_ADC_CH_RESULT;
> +		return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:

This needs  {} as per the build bot.
If nothing major comes up, I'll tweak whilst applying.

> +		u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);
> +		int clk_div = (1 + FIELD_GET(CV1800B_MASK_CLKDIV, status_reg));
> +		int freq = clk_get_rate(saradc->clk) / clk_div;
> +		int nb_startup_cycle = 1 + FIELD_GET(CV1800B_MASK_STARTUP_CYCLE, status_reg);
> +		int nb_sample_cycle = 1 + FIELD_GET(CV1800B_MASK_SAMPLE_WINDOW, status_reg);
> +		int nb_compare_cycle = 1 + FIELD_GET(CV1800B_MASK_COMPARE_CYCLE, status_reg);
> +
> +		*val = freq / (nb_startup_cycle + nb_sample_cycle + nb_compare_cycle);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int cv1800b_adc_probe(struct platform_device *pdev)
> +{
> +	struct cv1800b_adc *saradc;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	saradc = iio_priv(indio_dev);
> +	indio_dev->name = "sophgo-cv1800b-adc";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &cv1800b_adc_info;
> +	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
> +	indio_dev->channels = sophgo_channels;
> +
> +	saradc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(saradc->clk))
> +		return PTR_ERR(saradc->clk);
> +
> +	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(saradc->regs))
> +		return PTR_ERR(saradc->regs);
> +
> +	saradc->irq = platform_get_irq_optional(pdev, 0);
> +	if (saradc->irq >= 0) {
> +		init_completion(&saradc->completion);
> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> +				       cv1800b_adc_interrupt_handler, 0,
> +				       dev_name(&pdev->dev), saradc);
> +		if (ret)
> +			return ret;
> +
> +		writel(1, saradc->regs + CV1800B_ADC_INTR_EN_REG);
> +	}
> +
> +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
> +	if (ret)
> +		return ret;

Blank line here slightly helps readability as two unrelated blocks of code.

> +	writel(FIELD_PREP(CV1800B_MASK_STARTUP_CYCLE, 15) |
> +	       FIELD_PREP(CV1800B_MASK_SAMPLE_WINDOW, 15) |
> +	       FIELD_PREP(CV1800B_MASK_CLKDIV, 1) |
> +	       FIELD_PREP(CV1800B_MASK_COMPARE_CYCLE, 15),
> +	       saradc->regs + CV1800B_ADC_CYC_SET_REG);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}


