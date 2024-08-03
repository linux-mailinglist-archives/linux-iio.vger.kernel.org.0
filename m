Return-Path: <linux-iio+bounces-8186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CE946924
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0686F1C20DC9
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413913667E;
	Sat,  3 Aug 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5p0WVRT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC677102;
	Sat,  3 Aug 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682201; cv=none; b=ZhD3sm7pWohent+63Aw1MG6M0ZZOxy50tiTWFz3yhvXhSzh+u/xoqIiUsNRLkaZERRyAg52n5agKrbM0GQfWChy3E/tMydjgA6VVSVgadOEywjJ3U8Qx2dRzgej3v6ZBuMbjkCAsSKoKOecHJvC9ATZODUS2kaB5fRx+DF+JPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682201; c=relaxed/simple;
	bh=TUQN03HWKP9vYxExAiyYuf183tObrdAMJAm01/D8xWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dslOG4Z+jc4wx06SzmDsAqpz8O2c1vs1U3eeIPx7u+GUfToH5wym/VqK7Fb5PZIU6nBW1ijMnss3h9+p4FDBz9eaO9IvxZrSmroMaRLClvfecoDUBcYQbFCRmNe5t7sKSZUWNd/wjYLHZUGwIQxr4SdSYA5G2urbaHmt1LTvn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5p0WVRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E55C116B1;
	Sat,  3 Aug 2024 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722682201;
	bh=TUQN03HWKP9vYxExAiyYuf183tObrdAMJAm01/D8xWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5p0WVRT+QabJ6dqn7to71NjEABIewPlqFtn0Oo/aatXLNJ6l31F7G+dg6T2sQvMh
	 +p5zVOvSE+fMvEItHSUiKQsVfckQobImbWf0VemyisBAsP1vb7DRq0+XFo5ktA0dxk
	 Gc0G+UIVJkT5DoafjCVVL6o7SQBYEe4c++Fzkh2uvBwhDhSJXzEcsdLYRNxGUgiYCW
	 nSUZDNXphTzWEq4cTUKZj+OuFWY5ltPbHuRj1RAV2lb7UT7cuO3uZOCK/EaWu91xVa
	 C7zamAiKN8W7HkmioEyIVdxvUbYIphoq0YoKjCxB39eZVGIhEDWYM7cOsK1LzG0Gnp
	 jpF7r6ZJc3Q/g==
Date: Sat, 3 Aug 2024 11:49:51 +0100
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
Subject: Re: [PATCH v3 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
Message-ID: <20240803114951.6b79e86a@jic23-huawei>
In-Reply-To: <20240731-sg2002-adc-v3-2-5ac40a518c0a@bootlin.com>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
	<20240731-sg2002-adc-v3-2-5ac40a518c0a@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 14:24:15 +0200
Thomas Bonnefille <thomas.bonnefille@bootlin.com> wrote:

> This adds a driver for the common Sophgo SARADC.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

One small bug (you will return 1 on an error), and a few minor other comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/sophgo-cv18xx-adc.c b/drivers/iio/adc/sophgo-cv18xx-adc.c
> new file mode 100644
> index 000000000000..27e1aac9560f
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-cv18xx-adc.c
> @@ -0,0 +1,206 @@

> +
> +#define CV18XX_ADC_CTRL_REG			0x04
> +#define		CV18XX_ADC_EN			BIT(0)
> +#define		CV18XX_ADC_SEL(x)		BIT((x) + 4)
> +#define CV18XX_ADC_STATUS_REG			0x08
> +#define		CV18XX_ADC_BUSY			BIT(0)
> +#define CV18XX_ADC_CYC_SET_REG			0x0C
> +/* The default cycle configuration is set to maximize the accuracy */
> +#define		CV18XX_ADC_DEF_STARTUP_CYCLE	0xF
> +#define		CV18XX_ADC_DEF_SAMPLE_WINDOW	(0xF << 8)

define masks for the various fields and use FIELD_PREP()
on those with the default values - but do that inline not up here
where we should only set the masks.

> +#define		CV18XX_ADC_DEF_CLOCK_DIVIDER	(0x1 << 12)
> +#define		CV18XX_ADC_DEF_COMPARE_CYCLE	(0xF << 16)
> +#define CV18XX_ADC_CH_RESULT_REG(x)		(0x10 + 4 * (x))
> +#define		CV18XX_ADC_CH_RESULT		GENMASK(11, 0)
> +#define		CV18XX_ADC_CH_VALID		BIT(15)
> +#define CV18XX_ADC_INTR_EN_REG			0x20
> +#define CV18XX_ADC_INTR_CLR_REG			0x24
> +#define		CV18XX_ADC_INTR_CLR_BIT		BIT(0)
> +#define CV18XX_ADC_INTR_STA_REG			0x28
> +#define		CV18XX_ADC_INTR_STA_BIT		BIT(0)

> +static const struct iio_chan_spec sophgo_channels[] = {
> +	CV18XX_ADC_CHANNEL(1),

why index from 1?  We tend to use 0 as the base, though there is no ABI
requirement to do so.  Hence this is ok, just unusual.

> +	CV18XX_ADC_CHANNEL(2),
> +	CV18XX_ADC_CHANNEL(3),
> +};

> +static int cv18xx_adc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		{

I'd move { to previous line.

That will avoid need to indent another tab for the scope.

> +		struct cv18xx_adc *saradc = iio_priv(indio_dev);
> +		u32 sample;
> +		int ret;

Can move ert into scoped_guard scope.

> +
> +		scoped_guard(mutex, &saradc->lock) {
> +			cv18xx_adc_start_measurement(saradc, chan->scan_index);
> +			ret = cv18xx_adc_wait(saradc);
> +			if (ret < 0)
> +				return ret;
> +
> +			sample = readl(saradc->regs + CV18XX_ADC_CH_RESULT_REG(chan->scan_index));
> +		}
> +		if (!(sample & CV18XX_ADC_CH_VALID))
> +			return -ENODATA;
> +
> +		*val = sample & CV18XX_ADC_CH_RESULT;
> +		return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static int cv18xx_adc_probe(struct platform_device *pdev)
> +{
> +	struct cv18xx_adc *saradc;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	saradc = iio_priv(indio_dev);
> +	indio_dev->name = "sophgo-cv18xx-adc";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &cv18xx_adc_info;
> +	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
> +	indio_dev->channels = sophgo_channels;
> +
> +	ret = IS_ERR(devm_clk_get_enabled(&pdev->dev, NULL));
> +	if (ret)

PTR_ERR() not IS_ERR() for the return as you are returning a bool currently
not an error code.  Similar to what you do for the regulator below.

Better to use a local struct clk * and check that rather than convert
directly to the error value.


> +		return ret;
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
> +	writel(CV18XX_ADC_DEF_STARTUP_CYCLE |
> +	       CV18XX_ADC_DEF_SAMPLE_WINDOW |
> +	       CV18XX_ADC_DEF_CLOCK_DIVIDER |
> +	       CV18XX_ADC_DEF_COMPARE_CYCLE
> +	       , saradc->regs + CV18XX_ADC_CYC_SET_REG);

Blank line here. + that leading comma should be on end of the line above.

> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +
No blank line here.
> +}


