Return-Path: <linux-iio+bounces-9157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043D96C8AC
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7536E1C25545
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560431487D5;
	Wed,  4 Sep 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hDyX45ku"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52C1EBFEC;
	Wed,  4 Sep 2024 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482309; cv=none; b=FJzaaRaM7GrjGW2FviAU7E/uRfz21E/yLEZ33/Z+OmB0jxCqfkuvMsfPvxzEnj0RLQUpO43lwg/TsWjiw6aMf16QgJeTFwhfuKcj4WoxKguEKxL8yZUrYctypPt+IZL+c/4CwntGhBoTqvvgdGGURBLTOgYzDtH8316Lm455gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482309; c=relaxed/simple;
	bh=fb++RZOclHuyJv8Cvo2Mncb1oUjSopSg8sCCDhGKtZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fILsp3h+VhRSNPG8+ChyhXgTiteXzDoREep1T9FZNnTCstqWAJEV2lou17A6pnbvG+JLGBbwut2l/shu/RV+hChj+E6dJ0sourHck7pRu528zDS8wCryXIaBSSh0pwHw1aQYqDrCgTO+syH5B+rmScA6LTM9l9iqPDiY/43v27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hDyX45ku; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D16A1BF203;
	Wed,  4 Sep 2024 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725482304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIswLtOfZtf2hkYmMprySdT0sIt7a6+fv7isRSExRY8=;
	b=hDyX45kuNseqYmR1xNb2I+QSwtW32sZzTAu0n79JH5zh02JZAigAOLaZ6wAMwC45sdsXEF
	l2z6nfx3DR08UlCNKXOo8yAViMitC0yih7g0juMcxUVT2h0QuSxznqa1PL5NpDOqgeZl0a
	i+PnbUUINAUJ/LBLMyJ5Z58fIhm1pPqQjBZo6Q9Vn914dTZVAdpdzwF2hOrvQS+zA0k9fD
	Nq+ESIaGYc8rr+6wW/h1AjD8NjzWLPlhxEbFgBzmORdpLgNR/l8vaQ9kjtIdwkNyo6Mibn
	Tb+MFIntj8BKRvubKT+31bHe193VEBveBrBON6ZPh7GDBlon9bcmlMRpw3k7mw==
Message-ID: <b0849f3a-ddd3-4e6a-9f1f-1c5c9ab3e613@bootlin.com>
Date: Wed, 4 Sep 2024 22:38:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV1800B SARADC
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
 <20240829-sg2002-adc-v5-2-aacb381e869b@bootlin.com>
 <ZtYh6xUcP8zo3xMj@surfacebook.localdomain>
 <20240903200526.0734945b@jic23-huawei>
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Content-Language: fr, en-US
In-Reply-To: <20240903200526.0734945b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello, thank you for these fixes, I just wanted to add something below.

Le 03/09/2024 à 9:05 PM, Jonathan Cameron a écrit :
> On Mon, 2 Sep 2024 23:36:59 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>> Thu, Aug 29, 2024 at 02:31:51PM +0200, Thomas Bonnefille kirjoitti:
>>> This adds a driver for the Sophgo CV1800B SARADC.

...

>>> +		init_completion(&saradc->completion);
>>> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
>>> +				       cv1800b_adc_interrupt_handler, 0,
>>> +				       dev_name(&pdev->dev), saradc);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		writel(1, saradc->regs + CV1800B_ADC_INTR_EN_REG);
>>
>> BIT(0)
> 
> Maybe on that - would need to compare with datasheet to know how it's
> described. In theory that might not be a mask.

Indeed, in this case "CV1800B_ADC_INTR_EN_REG" is the register that 
enables the interrupts.
So here what I dis is to set this register to 1 (ON).

> 
>>
>>> +	}
>>> +
>>> +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
>>> +	if (ret)
>>> +		return ret;
>>
>> + blank line?
> That one I'd done already.
> Anyhow tweaked and pushed out again.
> 
> 
> Jonathan
> 
>>
>>> +	writel(FIELD_PREP(CV1800B_MASK_STARTUP_CYCLE, 15) |
>>> +	       FIELD_PREP(CV1800B_MASK_SAMPLE_WINDOW, 15) |
>>> +	       FIELD_PREP(CV1800B_MASK_CLKDIV, 1) |
>>> +	       FIELD_PREP(CV1800B_MASK_COMPARE_CYCLE, 15),
>>> +	       saradc->regs + CV1800B_ADC_CYC_SET_REG);
>>> +
>>> +	return devm_iio_device_register(&pdev->dev, indio_dev);
>>> +}
>>
> 
Thomas

