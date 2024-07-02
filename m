Return-Path: <linux-iio+bounces-7170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B492440A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73ED7B246BA
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E91BE228;
	Tue,  2 Jul 2024 17:01:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD97846D;
	Tue,  2 Jul 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939668; cv=none; b=ZCUakdlYRMRQ1jxyxqcCpBiq8xW/NJC702+T+YNLJ1mEyEhH/auCKq3gKwLAkeU3UYQdV1vdaRiUutzcAow9jdtVHxGJc3KVomiU0d+nzMGz14b4qPsfWWQjMB4u17e9fIrnKJ5idCnL7ki9i3+fc6v9rqSRSMvJcGFb4VcyYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939668; c=relaxed/simple;
	bh=x6hoXqZu+BosSGk5H6p2sJSp9PRIANrlzXxvUPWGeAE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4Bm8b4lk/on4E0HItHuZRo1XndtamAzhtUFFl61+QPN/AUaI6+FkZ5mdmwuQvt/2MZrysNnuDEtv7QsAiXzCMl/VmzjIJodek2SlaFKi11HaZuJjX0ixRBNcogpqWaS9fZV6GLo7+vUuMT9KvpcpIAliVzcJyU6jS0hiewBxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD8L16KJDz6JBcC;
	Wed,  3 Jul 2024 01:00:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 148D8140A08;
	Wed,  3 Jul 2024 01:01:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 18:01:01 +0100
Date: Tue, 2 Jul 2024 18:01:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, "Paul Walmsley"
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
Message-ID: <20240702180100.00000096@Huawei.com>
In-Reply-To: <20240702-sg2002-adc-v1-2-ac66e076a756@bootlin.com>
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
	<20240702-sg2002-adc-v1-2-ac66e076a756@bootlin.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 02 Jul 2024 13:52:22 +0200
Thomas Bonnefille <thomas.bonnefille@bootlin.com> wrote:

> This adds a driver for the common Sophgo SARADC.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Hi Thomas,

Welcome to IIO.

Various comments inline

Thanks,

Jonathan
> diff --git a/drivers/iio/adc/sophgo-adc.c b/drivers/iio/adc/sophgo-adc.c
> new file mode 100644
> index 000000000000..a94d839d40ec
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-adc.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Sophgo SARADC Driver
> + *
> + *  Copyright (C) Bootlin 2024
> + *  Author: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
probably want mod_devicetable.h instead.

> +#include <linux/platform_device.h>
> +
> +#define SOPHGO_SARADC_CTRL_REG			0x04
> +#define		SOPHGO_SARADC_EN		BIT(0)
> +#define		SOPHGO_SARADC_SEL(x)		BIT((x)+4)
> +#define SOPHGO_SARADC_STATUS_REG		0x08
> +#define		SOPHGO_SARADC_BUSY		BIT(0)
> +#define SOPHGO_SARADC_CYC_SET_REG		0x0C
> +#define		SOPHGO_SARADC_DEF_CYC_SETTINGS	0xF1F0F
> +#define SOPHGO_SARADC_CH_RESULT_REG(x)		(0x10+4*(x))
> +#define		SARADC_CH_RESULT(x)		((x) & 0xfff)
> +#define		SARADC_CH_VALID(x)		((x) & BIT(15))

Prefer defined masks and FIELD_GET() to actually get the values.
Also use consistent prefix for defines.


> +#define SOPHGO_SARADC_INTR_EN_REG		0x20
> +#define SOPHGO_SARADC_INTR_CLR_REG		0x24
> +
> +#define SOPHGO_SARADC_CHANNEL(index)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = index,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 12,					\

No need to define these if not providing buffered capture.


> +		},							\
> +	}
> +
> +struct sophgo_saradc {
> +	struct completion completion;
> +	struct iio_info info;
> +	void __iomem *regs;
> +	struct mutex lock;

Add a comment on what data this lock protects.  

> +	struct clk *clk;
After changes below, probably don't need to hang on to the clk.
> +	int irq;
Rarely need to keep hold of the irq after probe. Use a local variable for
it in instead.

> +};
> +
> +static const struct iio_chan_spec sophgo_channels[] = {
> +	SOPHGO_SARADC_CHANNEL(1),
> +	SOPHGO_SARADC_CHANNEL(2),
> +	SOPHGO_SARADC_CHANNEL(3),
> +};
> +
> +static void sophgo_saradc_start_measurement(struct sophgo_saradc *saradc,
> +					    int channel)
> +{
> +	writel(0, saradc->regs + SOPHGO_SARADC_CTRL_REG);
> +	writel(SOPHGO_SARADC_SEL(channel) | SOPHGO_SARADC_EN,
> +	       saradc->regs + SOPHGO_SARADC_CTRL_REG);
> +}
> +
> +static int sophgo_saradc_wait(struct sophgo_saradc *saradc)
> +{
> +	if (saradc->irq < 0) {
> +		u32 reg;
> +
> +		return readl_poll_timeout(saradc->regs + SOPHGO_SARADC_STATUS_REG,
> +					  reg, !(reg & SOPHGO_SARADC_BUSY),
> +					  500, 1000000);
> +	} else {

Returned above, so no need for else which helps with indent.


> +		int ret;
> +
> +		ret = wait_for_completion_timeout(&saradc->completion,
> +						  msecs_to_jiffies(1000)) > 0
> +						  ? 0 : -ETIMEDOUT;
> +		return ret;
return wait_for_completion.
> +	}
> +}
> +
> +static int sophgo_saradc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		struct sophgo_saradc *saradc = iio_priv(indio_dev);
> +		u32 sample;
> +		int ret;
> +
> +		mutex_lock(&saradc->lock);

Use scoped_guard() here so you can return directly on error.

> +		sophgo_saradc_start_measurement(saradc, chan->scan_index);
> +		ret = sophgo_saradc_wait(saradc);
> +		if (ret < 0) {
> +			mutex_unlock(&saradc->lock);
> +			return ret;
> +		}
> +
> +		sample = readl(saradc->regs + SOPHGO_SARADC_CH_RESULT_REG(chan->scan_index));
> +		mutex_unlock(&saradc->lock);
> +
> +		if (SARADC_CH_VALID(sample)) {
> +			*val = SARADC_CH_RESULT(sample);
> +			return IIO_VAL_INT;
> +		}
errors out of line preferred.
		if (!SARADC_CH_VALID(sample))
			return -ENODATA;

		*val...

> +		return -ENODATA;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t sophgo_saradc_interrupt_handler(int irq, void *dev_id)
> +{
> +	struct sophgo_saradc *saradc = dev_id;

dev_id is an odd name for something that isn't an id.

No register to confirm the interupt status?  Fine if not, but relatively
unusual.

> +
> +	writel(1, saradc->regs + SOPHGO_SARADC_INTR_CLR_REG);
> +	complete(&saradc->completion);
> +	return IRQ_HANDLED;
> +}
> +

Single blank line

> +
> +static const struct of_device_id sophgo_saradc_match[] = {
> +	{ .compatible = "sophgo,cv18xx-saradc", },
> +	{ },
No comma needed on 'null' terminators like this as we won't
ever add anything after them.

> +};
> +MODULE_DEVICE_TABLE(of, sophgo_saradc_match);
> +
> +static int sophgo_saradc_probe(struct platform_device *pdev)
> +{
> +	struct sophgo_saradc *saradc;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	saradc = iio_priv(indio_dev);
> +	indio_dev->name = "Sophgo SARADC";

Hmm. Whilst the ABI docs don't say it, I don't think we have names with
either capitals or spaces.  sophgo-saradc or similar preferred.

> +	indio_dev->info = &saradc->info;

This is making some static const data dynamic. I can't see why you'd do this

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = 3;

ARRAY_SIZE(sophgo_channels)

> +	indio_dev->channels = sophgo_channels;
> +
> +	saradc->clk = devm_clk_get(&pdev->dev, NULL);

If it's optional, then use dev_clk_get_optional()

> +	if (IS_ERR(saradc->clk)) {
> +		dev_dbg(&pdev->dev, "Can't get clock from device tree, using No-Die domain");
> +	} else {
> +		ret = clk_prepare_enable(saradc->clk);

Perhaps devm_clk_get_optional_enabled() is appropriate, then
you can use null return to detect that it wasn't present - vs an ERR_PTR() for
it was but didn't enable.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(saradc->regs)) {
> +		ret = PTR_ERR(saradc->regs);
> +		goto error_disable_clock;
> +	}
> +
> +	saradc->irq = platform_get_irq_optional(pdev, 0);
> +	if (saradc->irq >= 0) {
> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> +				sophgo_saradc_interrupt_handler, 0,
> +				dev_name(&pdev->dev), saradc);
> +		if (ret)
> +			goto error_disable_clock;
> +
> +		writel(1, saradc->regs + SOPHGO_SARADC_INTR_EN_REG);
> +
> +		init_completion(&saradc->completion);
Usually best to init a completion that is irq related before requesting
the irq. Avoids any possible races.

> +	}
> +
> +	saradc->info.read_raw = &sophgo_saradc_read_raw;
Why?  
> +
> +	mutex_init(&saradc->lock);
> +	platform_set_drvdata(pdev, indio_dev);
> +	writel(SOPHGO_SARADC_DEF_CYC_SETTINGS, saradc->regs + SOPHGO_SARADC_CYC_SET_REG);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret)
> +		goto error_disable_clock;
> +
> +	return 0;
> +
> +error_disable_clock:
> +	if (!IS_ERR(saradc->clk))
Don't mix and match devm and non devm management.
As above, I think you can just use devm_clk_get_optional_enabled()

> +		clk_disable_unprepare(saradc->clk);
> +	return ret;
> +}
> +
> +static void sophgo_saradc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct sophgo_saradc *saradc = iio_priv(indio_dev);
> +
> +	if (!IS_ERR(saradc->clk))
> +		clk_disable_unprepare(saradc->clk);
> +}
> +

Single blank line is enough.

> +
> +static struct platform_driver sophgo_saradc_driver = {
> +	.driver	= {
> +		.name		= "sophgo-saradc",
> +		.of_match_table	= sophgo_saradc_match,
> +	},
> +	.probe = sophgo_saradc_probe,
> +	.remove_new = sophgo_saradc_remove,
> +};
> +module_platform_driver(sophgo_saradc_driver);
> +
> +MODULE_AUTHOR("Thomas Bonnefille <thomas.bonnefille@bootlin.com>");
> +MODULE_DESCRIPTION("Sophgo SARADC driver");
> +MODULE_LICENSE("GPL");
> 


