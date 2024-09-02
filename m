Return-Path: <linux-iio+bounces-9029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A561F968EE4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071B0B22350
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828441428E0;
	Mon,  2 Sep 2024 20:37:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D01A4E7F
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725309431; cv=none; b=kZx4Q9Q/fG6lk/5Z3WIh0cpbuSmH+Pln+ckc9ejYPsSIUfaiT4nt1BT461Uns7ZZ2v7SFO9fByvAO1Q1MUqKdYLZqqcJl441cDwMIOLExyDpx1CpweQyGcNzTAgIHVfEnk0/D2qC2jYMxU2IV1zHHoetUmGL8gzbYUbFc96JK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725309431; c=relaxed/simple;
	bh=kfH2+W1R2W5ZJM+H60zVdLSui4KadwG9+9YnszFJ9F0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocd1jcKaK69q+uIdb04gJS1uum2hTsm+ub/6joWct6D33TnSl+fBv0l3TGHC0z4BhUNXcpRpjd9UIxhNzmfyGC4MkWNPf8t02D1AKficcl8aSaBezvYydnnFc6/uOaYBPfWp48v7JF3Abp89HUE3+ig+A9Vkv/12TPkqXHT6xZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 1a2ba198-696b-11ef-8256-005056bdfda7;
	Mon, 02 Sep 2024 23:37:01 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Sep 2024 23:36:59 +0300
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
Message-ID: <ZtYh6xUcP8zo3xMj@surfacebook.localdomain>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
 <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>

Thu, Aug 29, 2024 at 02:31:51PM +0200, Thomas Bonnefille kirjoitti:
> This adds a driver for the Sophgo CV1800B SARADC.

Jonathan, please consider the below improvements to be folded in as well.

...

+ array_size.h

> +#include <linux/bitfield.h>

+ bits.h
+ cleanup.h

> +#include <linux/clk.h>
> +#include <linux/completion.h>

+ err.h

> +#include <linux/interrupt.h>

> +#include <linux/iio/iio.h>

I would split it into a separate group already.

> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>

+ types.h

...

> +#define CV1800B_READ_TIMEOUT_MS				1000
> +#define CV1800B_READ_TIMEOUT_US				(CV1800B_READ_TIMEOUT_MS * 1000)

Effectively these may be written as

(1 * MSEC_PER_SEC)
(1 * USEC_PER_SEC)

...

> +static int cv1800b_adc_wait(struct cv1800b_adc *saradc)
> +{
> +	if (saradc->irq < 0) {
> +		u32 reg;
> +
> +		return readl_poll_timeout(saradc->regs + CV1800B_ADC_STATUS_REG,
> +					  reg, !(reg & CV1800B_ADC_BUSY),
> +					  500, CV1800B_READ_TIMEOUT_US);
> +	}
> +
> +	return wait_for_completion_timeout(&saradc->completion,
> +					  msecs_to_jiffies(CV1800B_READ_TIMEOUT_MS)) > 0
> +					  ? 0 : -ETIMEDOUT;

Usually we leave "?" part on the previous line.

> +}
> +
> +static int cv1800b_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct cv1800b_adc *saradc = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:{

Missing space

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

This should be indented as 'c' in the above 'case'.

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		u32 status_reg = readl(saradc->regs + CV1800B_ADC_CYC_SET_REG);

> +		int clk_div = (1 + FIELD_GET(CV1800B_MASK_CLKDIV, status_reg));
> +		int freq = clk_get_rate(saradc->clk) / clk_div;

Why are these signed?

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

...

> +static int cv1800b_adc_probe(struct platform_device *pdev)
> +{

Having

	struct device *dev = &pdev->dev;

here helps making below code neater.

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

'=' is redundant

> +		init_completion(&saradc->completion);
> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> +				       cv1800b_adc_interrupt_handler, 0,
> +				       dev_name(&pdev->dev), saradc);
> +		if (ret)
> +			return ret;
> +
> +		writel(1, saradc->regs + CV1800B_ADC_INTR_EN_REG);

BIT(0)

> +	}
> +
> +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
> +	if (ret)
> +		return ret;

+ blank line?

> +	writel(FIELD_PREP(CV1800B_MASK_STARTUP_CYCLE, 15) |
> +	       FIELD_PREP(CV1800B_MASK_SAMPLE_WINDOW, 15) |
> +	       FIELD_PREP(CV1800B_MASK_CLKDIV, 1) |
> +	       FIELD_PREP(CV1800B_MASK_COMPARE_CYCLE, 15),
> +	       saradc->regs + CV1800B_ADC_CYC_SET_REG);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



