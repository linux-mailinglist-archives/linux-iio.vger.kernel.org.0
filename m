Return-Path: <linux-iio+bounces-22516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0DB1FB64
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 19:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F2C7AAAD5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C77267B89;
	Sun, 10 Aug 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jtrxiA0A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDB1DDA15;
	Sun, 10 Aug 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847395; cv=none; b=LUEEqav40hseyVDBotLdHmDz+wL0ztriPqlcjrAg4Oy+yRMcJe7evEf4FAYn2MWhuRo9C4789b3XVM+ta1NWXm3+v/HexR1va7maUXpgr4XMDWeYOQpRfA3o4oX6ExfycKNGExBk7SxzmCv7KEjeyYpXSOCDMD1jNAdGGra8WYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847395; c=relaxed/simple;
	bh=TFw3Jt4Nf6T+M/9R2NIHl5Pu487SyK04JZQm86A00rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SyHwD8a6K9m9hlzKKq0yOrgqSZBF48caLu73jTQMjtT+FbCApf4wTKWXbyVtA15ETFpBhAMQqsC8PMCviwHAAK63cyuDmNnaT+yk9ZEQsjqDDA+fnhXOQwytbrTe3DAJXYJeiI/6ienkGlOFRVpe6nt+VqkJ4+bGyZ9qYM3sB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jtrxiA0A; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id l9x1upD4iPUh5l9x1uh8r7; Sun, 10 Aug 2025 19:35:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754847320;
	bh=97gR4svqUgNl2V2IPUV7h4EF2W6dzUtZbbMTKvsvGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jtrxiA0ANe71GcesZsKA2kxMQ4ACEfK6q4ZRnmBry5SHvBrjKu6FhdNIj7BXFWx+q
	 eX1nDJdAXMtHKUDoF65/5p9Z/VCDij46cWq84HCqvPyuDvnJlma1AuvabGo1fYRrod
	 kAuHZOI43NTi/dQw8F47LG4NN7zVxTH10DcezeILXn+auDfcfbdSHQJgc3FUmU2xkP
	 HnDFSYol8Y7vVJT1bs9RrncqV3CEEcX4rOdNE+7g1u2J4WlID7stBgMul6YCIfo8I2
	 T04TLA7H5qULZHV72JRO+rWFRTgCaRMELmCBurBRwNwKDAg7O/trqwq2rvgF/uhayO
	 jLw2qoiv334oA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 10 Aug 2025 19:35:20 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <d19e7b07-369f-4909-b931-af881a2a4425@wanadoo.fr>
Date: Sun, 10 Aug 2025 19:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: add ade9000 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-4-antoniu.miclaus@analog.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250808141020.4384-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2025 à 16:10, Antoniu Miclaus a écrit :
> Add driver support for the ade9000. highly accurate,
> fully integrated, multiphase energy and power quality
> monitoring device.

Hi,
...

> +static int ade9000_clkout_prepare(struct clk_hw *hw)
> +{
> +	return 0;
> +}
> +
> +static void ade9000_clkout_unprepare(struct clk_hw *hw)
> +{
> +}

Is it really needed to have these 2 empty functions?
clk core seems to accept NULL for .prepare and .unprepare.

> +
> +static unsigned long ade9000_clkout_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	/* CLKOUT provides the same frequency as the crystal/external clock */
> +	return parent_rate ? parent_rate : 24576000; /* Default 24.576 MHz */
> +}
> +
> +static const struct clk_ops ade9000_clkout_ops = {
> +	.prepare = ade9000_clkout_prepare,
> +	.unprepare = ade9000_clkout_unprepare,
> +	.recalc_rate = ade9000_clkout_recalc_rate,
> +};

...

> +static irqreturn_t ade9000_irq0_thread(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ade9000_state *st = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	u32 handled_irq = 0;
> +	u32 interrupts;
> +	u32 status;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_STATUS0, &status);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(st->regmap, ADE9000_REG_MASK0, &interrupts);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "IRQ0 read status fail");

s/status/interrupts/ maybe?

> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & ADE9000_ST0_PAGE_FULL_BIT) &&
> +	    (interrupts & ADE9000_ST0_PAGE_FULL_BIT)) {
> +		/* Always use streaming mode */
> +		ret = ade9000_iio_push_streaming(indio_dev);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		handled_irq |= ADE9000_ST0_PAGE_FULL_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_WFB_TRIG_BIT) &&
> +	    (interrupts & ADE9000_ST0_WFB_TRIG_BIT)) {
> +		ret = ade9000_waveform_buffer_en(st, false);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 WFB fail");
> +			return IRQ_HANDLED;
> +		}
> +
> +		ret = ade9000_iio_push_buffer(indio_dev);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "IRQ0 IIO push fail @ WFB TRIG");
> +			return IRQ_HANDLED;
> +		}
> +
> +		handled_irq |= ADE9000_ST0_WFB_TRIG_BIT;
> +	}
> +
> +	if ((status & ADE9000_ST0_EGYRDY) &&
> +	    (interrupts & ADE9000_ST0_EGYRDY)) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ENERGY,
> +						    ADE9000_ST0_EGYRDY,
> +						    IIO_EV_TYPE_MAG,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +		handled_irq |= ADE9000_ST0_EGYRDY;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADE9000_REG_STATUS0, handled_irq);
> +	if (ret)
> +		dev_err(&st->spi->dev, "IRQ0 write status fail");
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int ade9000_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ade9000_state *st;
> +	struct regmap *regmap;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "Unable to allocate ADE9000 IIO");
> +	st = iio_priv(indio_dev);
> +
> +	regmap = devm_regmap_init(dev, NULL, spi, &ade9000_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to allocate ADE9000 regmap");
> +	spi_set_drvdata(spi, st);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "irq0");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find irq0");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_irq0_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "irq1");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find irq1");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_irq1_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);
> +
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "dready");
> +	if (irq < 0)
> +		return dev_err_probe(dev, -EINVAL, "Unable to find dready");
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					ade9000_dready_thread,
> +					IRQF_ONESHOT,
> +					KBUILD_MODNAME, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request threaded irq: %d", ret);
> +
> +	st->spi = spi;
> +
> +	/* Optional external clock input */
> +	st->clkin = devm_clk_get_optional_enabled(dev, "clkin");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(dev, PTR_ERR(st->clkin), "Failed to get and enable clkin: %ld", PTR_ERR(st->clkin));

No need to dupliacte PTR_ERR(clkin) in the error message. Same for 
several messages above.

> +
> +	/* Register clock output provider */
> +	if (device_property_present(dev, "#clock-cells")) {
> +		struct clk_init_data clk_init = {};
> +		struct clk *clkout;
> +		unsigned long parent_rate = 24576000; /* Default crystal frequency */
> +
> +		if (st->clkin)
> +			parent_rate = clk_get_rate(st->clkin);

parent_rate seems to be unused.

> +
> +		clk_init.name = "clkout";
> +		clk_init.ops = &ade9000_clkout_ops;
> +		clk_init.flags = CLK_GET_RATE_NOCACHE;
> +		clk_init.num_parents = 0;

Would it make sense to have clk_init a "static const struct 
clk_init_data" defined outside of the probe to have the code be less 
verbose?

> +
> +		st->clkout_hw.init = &clk_init;
> +
> +		clkout = devm_clk_register(dev, &st->clkout_hw);
> +		if (IS_ERR(clkout))
> +			return dev_err_probe(dev, PTR_ERR(clkout), "Failed to register clkout: %ld", PTR_ERR(clkout));

No need to dupliacte PTR_ERR(clkout) in the error message.

> +
> +		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &st->clkout_hw);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to add clock provider: %d", ret);

No need to dupliacte ret in the error message.

> +	}
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &st->spi->dev;
> +	indio_dev->info = &ade9000_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops = &ade9000_buffer_ops;
> +
> +	st->regmap = regmap;
> +
> +	ret = devm_regulator_get_enable(&spi->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to get and enable vdd regulator\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +
> +	/* Configure reference selection based on vref regulator availability */
> +	if (ret != -ENODEV) {
> +		ret = regmap_update_bits(st->regmap, ADE9000_REG_CONFIG1,
> +					 ADE9000_EXT_REF_MASK,
> +					 ADE9000_EXT_REF_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->channels = ade9000_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);
> +	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> +					  &ade9000_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup IIO buffer");
> +
> +	ret = ade9000_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "ADE9000 reset failed");
> +
> +	ret = ade9000_setup(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to setup ADE9000");

Missing \n at the end of the message. Same for some other messages above 
using dev_err_probe() or dev_err().

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +};

...

CJ


