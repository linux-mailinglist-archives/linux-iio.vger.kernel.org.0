Return-Path: <linux-iio+bounces-13485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EACA9F2380
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A7616515F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14361156871;
	Sun, 15 Dec 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s45Ltqr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3593149E13;
	Sun, 15 Dec 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734263477; cv=none; b=rOH/KvLv1WE1CzaNwecxo21Ko3ck4Bo8Aa72+FRwbUKEXtuvmFDGDb+SAZPML+c2Uh2zGX2k6+VbpOmwTzFZMst7gowwjr4UfmodNLP2Qin54q0p/7D8AsjZkoAudL1zrXlbAQPpl92qL8PVO89yPpXODcAIpK1bqaf+AE5KzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734263477; c=relaxed/simple;
	bh=0t0ZQKj/p7GAnvOKN0/2RvwC65Y0VMiw7Zr0Iborcn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1B+7temJqSNjr4vOJ858gAJDDFOV8iTofG7xv05ZGOLmZo+eC9HpIzm+CUWh+HzCvvLsAu00SOohkglsrY/0X/kSk0e/3ZaCjYSk2NBGmg9rZn9oc57upiQwGYf3kR7GE9yxuqpb/jtu/IFOBS6MQr63Toi0TG6UN7E01M1PmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s45Ltqr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD21C4CECE;
	Sun, 15 Dec 2024 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734263477;
	bh=0t0ZQKj/p7GAnvOKN0/2RvwC65Y0VMiw7Zr0Iborcn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s45Ltqr8OqH9WmvIBOjSJZpSbVXSXpGmu0Nf9nZsXE362Ve36YSUDKrU1UmeNR9Ey
	 8L8+W/HVxgE6dYAXBSFXV3JyGtiJqRFiL/KuhSag/iU7IvZR2kZ3QGgvhbOpMZr9Cn
	 OyTxcFC8VAUJrMp4R/FhQxyetFWCDiMzOH/d/+AwahNp1b3SsICBB5y5i0gjbwKA/W
	 WcxONX9W2hF3M8f/P184ynOC7fgXt0EFQNqcORUReZ/rtmAzAmkqCVGkeczpiQwx9X
	 LUaqVZn255vbz6CzX12uY9AmOxNO7v8kxsYvrwOAF9mwAsrTnq+BOBdC/6CTkPwkrm
	 UahhkkG43VaKA==
Date: Sun, 15 Dec 2024 11:51:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH v2 4/9] iio: adc: ad7606: Move software functions into
 common file
Message-ID: <20241215115108.558bb5a9@jic23-huawei>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-4-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
	<20241210-ad7606_add_iio_backend_software_mode-v2-4-6619c3e50d81@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:46:44 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since the register are always the same, whatever bus is used, moving the
> software functions into the main file avoids the code to be duplicated
> in both SPI and parallel version of the driver.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Hi Guillaume,

Patch content is fine, but I'd ideally like you to take the opportunity to
tidy up some of the really inconsistent indentation in the code you are moving.

> int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int ch_addr, mode, ch_index;
>  
> -	st->sw_mode_en = st->bops->sw_mode_config &&
> -			 device_property_present(st->dev, "adi,sw-mode");
> -	if (!st->sw_mode_en)
> -		return 0;
> +	/*
> +	 * Ad7616 has 16 channels divided in group A and group B.
> +	 * The range of channels from A are stored in registers with address 4
> +	 * while channels from B are stored in register with address 6.
> +	 * The last bit from channels determines if it is from group A or B
> +	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
> +	 */
> +	ch_index = ch >> 1;
> +
> +	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
> +
> +	if ((ch & 0x1) == 0) /* channel A */
> +		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
> +	else	/* channel B */
> +		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
> +
> +	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
> +	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
>  
> -	indio_dev->info = &ad7606_info_sw_mode;
> +	return ad7606_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
> +				     mode);

Another odd indent to fix.

> +}
> +
> +static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
> +				     AD7616_OS_MASK, val << 2);

Trivial: Odd indentation choice.

> +}
> +
> +static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return ad7606_write_mask(st,
> +				 AD7606_RANGE_CH_ADDR(ch),

In general maybe aim for more consistent indentation choice. I'd pull this time up
on the line above.

> +				 AD7606_RANGE_CH_MSK(ch),
> +				 AD7606_RANGE_CH_MODE(ch, val));
> +}
> +
> +static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	return st->bops->reg_write(st, AD7606_OS_MODE, val);
> +}
> +
> +static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * Scale can be configured individually for each channel
> +	 * in software mode.
> +	 */
> +
> +	st->write_scale = ad7616_write_scale_sw;
> +	st->write_os = &ad7616_write_os_sw;
> +
> +	ret = st->bops->sw_mode_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Activate Burst mode and SEQEN MODE */
> +	return ad7606_write_mask(st,
> +			      AD7616_CONFIGURATION_REGISTER,

Whilst moving the code, feel free to tidy up the indent for inconsistent
cases.  Align this lot just after the opening bracket etc.

> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
> +			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
> +}

Thanks,

Jonathan


