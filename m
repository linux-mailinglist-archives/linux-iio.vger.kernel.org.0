Return-Path: <linux-iio+bounces-9088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1350896A714
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB80285BEA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208E1D5CCA;
	Tue,  3 Sep 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcE43Wa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90D1D5CC6;
	Tue,  3 Sep 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390337; cv=none; b=aUTO2X2Z2FNgYLHLyeBehIRbwbO7XeGTIC62uennLutJClTUE2eiFZe68pyAbMmNvNc0E7Zy2zwndZBU3Ypjub4+//YUv5TfIQg128f6SYz2zZTYo5gUgLnWYTfx/HSQ3BXxE3E49jjolH/RmzxkWS1QrTJ/saxJ5gPYV6/jRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390337; c=relaxed/simple;
	bh=BUy2TeYt7ETGBxQbUva9x1TfE8cMBg2J+5DRllp421s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POumpXin83uz95jmtGAbu8fCGdk2jX5967+6B3cFCsJ9TflPMPYjZ9KG0yACWwZvN9c63JIFJZWqdlo/8H9MPAtL5JAWun9A+hLRkcw7vPt+1Z2OB+MR93odxB29yRsFqoTzQ7255R+CN8i5mBgUEokWUeHDOWDK6cNBmhl4VPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcE43Wa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED2DC4CEC4;
	Tue,  3 Sep 2024 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390337;
	bh=BUy2TeYt7ETGBxQbUva9x1TfE8cMBg2J+5DRllp421s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AcE43Wa2dnsTIBchrXXkdMITdQHXIIHY6JcBdMTfPcuzctY2b+nopsm1/HXNooQA2
	 VNc4AFSG5gmY/m84mdjd/t5XNHaUt+vcIQOa5tCVNvb9ywCb6dP7j+9MXV1x7muAR8
	 iUoTrP1TOtgaa+ALWv54jbScn3MDUMmAuzJ8ZxYOJb3ZzHdv8JwyAIpBmHjIZRmCxt
	 tyM5QmU5eqGYymt1CDwxZA8tF2Xpton0y9c9k4Vh5R0uPagCxV23XBjsnf6RA8Y7Uc
	 TScvuMvL6fcf8xsIxl8iKLNmENUmpxUvtC0Dw1IUctVEGAMnFt7IoLnnmSkjpll+IB
	 LjEaW+cfujizg==
Date: Tue, 3 Sep 2024 20:05:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
Message-ID: <20240903200526.0734945b@jic23-huawei>
In-Reply-To: <ZtYh6xUcP8zo3xMj@surfacebook.localdomain>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
	<20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
	<ZtYh6xUcP8zo3xMj@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 23:36:59 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Aug 29, 2024 at 02:31:51PM +0200, Thomas Bonnefille kirjoitti:
> > This adds a driver for the Sophgo CV1800B SARADC.  
> 
> Jonathan, please consider the below improvements to be folded in as well.
> 
> ...
> 
> + array_size.h
> 
> > +#include <linux/bitfield.h>  
> 
> + bits.h
> + cleanup.h
> 
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>  
> 
> + err.h
> 
> > +#include <linux/interrupt.h>  
> 
> > +#include <linux/iio/iio.h>  
> 
> I would split it into a separate group already.
> 
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/platform_device.h>  
> 
> + types.h
Added. 

> 
> ...
> 
> > +#define CV1800B_READ_TIMEOUT_MS				1000
> > +#define CV1800B_READ_TIMEOUT_US				(CV1800B_READ_TIMEOUT_MS * 1000)  
> 
> Effectively these may be written as
> 
> (1 * MSEC_PER_SEC)
> (1 * USEC_PER_SEC)
> 
> ...
I'm not going to make this one.  Sure good feedback but not worth fixing
and chance I mess it up.

> 
> > +static int cv1800b_adc_wait(struct cv1800b_adc *saradc)
> > +{
> > +	if (saradc->irq < 0) {
> > +		u32 reg;
> > +
> > +		return readl_poll_timeout(saradc->regs + CV1800B_ADC_STATUS_REG,
> > +					  reg, !(reg & CV1800B_ADC_BUSY),
> > +					  500, CV1800B_READ_TIMEOUT_US);
> > +	}
> > +
> > +	return wait_for_completion_timeout(&saradc->completion,
> > +					  msecs_to_jiffies(CV1800B_READ_TIMEOUT_MS)) > 0
> > +					  ? 0 : -ETIMEDOUT;  
> 
> Usually we leave "?" part on the previous line.
Moved.
Also the line above is one space short of alignment.

> 
> > +}
> > +
> > +static int cv1800b_adc_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val, int *val2, long mask)
> > +{
> > +	struct cv1800b_adc *saradc = iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:{  
> 
> Missing space
I'd already fixed that one.
> 
> > +		u32 sample;
> > +
> > +		scoped_guard(mutex, &saradc->lock) {
> > +			int ret;
> > +
> > +			cv1800b_adc_start_measurement(saradc, chan->scan_index);
> > +			ret = cv1800b_adc_wait(saradc);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			sample = readl(saradc->regs + CV1800B_ADC_CH_RESULT_REG(chan->scan_index));
> > +		}
> > +		if (!(sample & CV1800B_ADC_CH_VALID))
> > +			return -ENODATA;
> > +
> > +		*val = sample & CV1800B_ADC_CH_RESULT;
> > +		return IIO_VAL_INT;
> > +		}  
> 
> This should be indented as 'c' in the above 'case'.
True. Fixed up.

> 
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 3300;
> > +		*val2 = 12;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);  
> 
> > +		int clk_div = (1 + FIELD_GET(CV1800B_MASK_CLKDIV, status_reg));
> > +		int freq = clk_get_rate(saradc->clk) / clk_div;  
> 
> Why are these signed?
Made them unsigned. Seems safe enough

> 
> > +		int nb_startup_cycle = 1 + FIELD_GET(CV1800B_MASK_STARTUP_CYCLE, status_reg);
> > +		int nb_sample_cycle = 1 + FIELD_GET(CV1800B_MASK_SAMPLE_WINDOW, status_reg);
> > +		int nb_compare_cycle = 1 + FIELD_GET(CV1800B_MASK_COMPARE_CYCLE, status_reg);
> > +
> > +		*val = freq / (nb_startup_cycle + nb_sample_cycle + nb_compare_cycle);
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}  
> 
> ...
> 
> > +static int cv1800b_adc_probe(struct platform_device *pdev)
> > +{  
> 
> Having
> 
> 	struct device *dev = &pdev->dev;
> 
> here helps making below code neater.
sure. modified.

> 
> > +	struct cv1800b_adc *saradc;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	saradc = iio_priv(indio_dev);
> > +	indio_dev->name = "sophgo-cv1800b-adc";
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &cv1800b_adc_info;
> > +	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
> > +	indio_dev->channels = sophgo_channels;
> > +
> > +	saradc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(saradc->clk))
> > +		return PTR_ERR(saradc->clk);
> > +
> > +	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(saradc->regs))
> > +		return PTR_ERR(saradc->regs);
> > +
> > +	saradc->irq = platform_get_irq_optional(pdev, 0);
> > +	if (saradc->irq >= 0) {  
> 
> '=' is redundant
removed.
> 
> > +		init_completion(&saradc->completion);
> > +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> > +				       cv1800b_adc_interrupt_handler, 0,
> > +				       dev_name(&pdev->dev), saradc);
> > +		if (ret)
> > +			return ret;
> > +
> > +		writel(1, saradc->regs + CV1800B_ADC_INTR_EN_REG);  
> 
> BIT(0)

Maybe on that - would need to compare with datasheet to know how it's
described. In theory that might not be a mask.

> 
> > +	}
> > +
> > +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
> > +	if (ret)
> > +		return ret;  
> 
> + blank line?
That one I'd done already.
Anyhow tweaked and pushed out again.


Jonathan

> 
> > +	writel(FIELD_PREP(CV1800B_MASK_STARTUP_CYCLE, 15) |
> > +	       FIELD_PREP(CV1800B_MASK_SAMPLE_WINDOW, 15) |
> > +	       FIELD_PREP(CV1800B_MASK_CLKDIV, 1) |
> > +	       FIELD_PREP(CV1800B_MASK_COMPARE_CYCLE, 15),
> > +	       saradc->regs + CV1800B_ADC_CYC_SET_REG);
> > +
> > +	return devm_iio_device_register(&pdev->dev, indio_dev);
> > +}  
> 


