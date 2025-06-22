Return-Path: <linux-iio+bounces-20861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC3BAE3057
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5133B0DE5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044A1DE2BC;
	Sun, 22 Jun 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+b/j/44"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E4469D;
	Sun, 22 Jun 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750601909; cv=none; b=YseIZknZPisq5vmYTbfVTEvBdyE4EWGtyVQVoPCZ03Fo9p/uDrOARbn4GCrmN3pbyIgC6kc55ULy8hn0P4xoaXu7FhMnLv8uzZJB7pr5cwJKHRn2PaBcotnDxoie5TGJ2qp/fcYDgA8nSI65xFP4nYVd4GAJjWf/KEVAYZgylC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750601909; c=relaxed/simple;
	bh=rY2h/CN7BFrV3TlYFo6J6uVUr7UUGNKyS09qSPnCKck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao8Ez+0u4Y+0BSXz7bQwWJCAQ5itfbrGyK7dXcPVwMENAJo1WOyESnkGupIzrS5ysPWieqW1H/HMkEmc0gD7o/7iuXQD9ppPzEIOpBuph5sG0aw/LCyPs3KwSWyD3U+nLYSZ9xnAH9VxrBBkMldvT3boOOAw5bLOGwlBJ5+6knM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+b/j/44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8368CC4CEE3;
	Sun, 22 Jun 2025 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750601909;
	bh=rY2h/CN7BFrV3TlYFo6J6uVUr7UUGNKyS09qSPnCKck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+b/j/44OxmCJIMte5njvBMDoNZjPJdWxVzRkx6Bmo6awCbtdn3CYKRuKrw3/TtU9
	 KAudIEBygznkJtt7epkN/E1HrZHsBWPyeVUVGkASkw/C+Weka6DyS2dQwRK1pZrYlm
	 dPk3XFZyU4iemLWdShI6l3fYhtmI31hcbmRwjATN3U84qA7yCLEMradZbPmTkekOEx
	 Dk5oLUBeU4bvuy9GowZNxlpAtuMsOsigUSWwbUNr4fdTgY251CqhsM1j079CVfJhgF
	 XfPBuvubADGGbvLVyNUGr9cTkzzzq+FE2hM8GMa8GuSPw3Q0ELkUYuUnN/mldAV++9
	 lVT5zsiCXOZ9w==
Date: Sun, 22 Jun 2025 15:18:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 07/12] iio: adc: ad4170: Add support for buffered
 data capture
Message-ID: <20250622151817.78eef50d@jic23-huawei>
In-Reply-To: <c8a14b9cb6fd5de15c2033cfeb1df84b193941b9.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
	<c8a14b9cb6fd5de15c2033cfeb1df84b193941b9.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 14:37:30 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend the AD4170 driver to allow buffered data capture in continuous read
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks if the aforementioned
> condition is met.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

One trivial thing below.

> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index b229a24b40de..2acd4316b079 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c

>  
> +static int ad4170_trigger_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-trig%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad4170_trigger_ops;
> +	st->trig->dev.parent = dev;

devm_iio_tigger_alloc() already set this via viio_trigger_alloc()

https://elixir.bootlin.com/linux/v6.15.3/source/drivers/iio/industrialio-trigger.c#L564

> +
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register trigger\n");
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	return 0;
> +}


