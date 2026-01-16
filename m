Return-Path: <linux-iio+bounces-27879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73648D3861F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C0E300EB82
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCD3A1A3A;
	Fri, 16 Jan 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V982/aPm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518A3939A4;
	Fri, 16 Jan 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592552; cv=none; b=aNmRCoO40BMWkah34jXWUj+tKBnRMmrHi2/Nxy72eu+lTqNB1qpVMSPQklcLBXi5V0W96T+bHNHulAAINcGARHRVr8my+ftnaSCWWCraRBuDXibsnPtES+cnTi4aGfxgUJLb2EgZtlLrYj0PztZ1Y2/2uEN5WacQojxMSeTni6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592552; c=relaxed/simple;
	bh=jTaPZXq/b2MsUDUpeTgcDZDqVHtPxWj09BW3spN+D+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f42eybPhLlVGkS+E4S+oBT7+LZ3Woz2eGN6PzmkC2WXwV4eaCpzb0tkpPSNjx6fYrsPO3gM6yoedHg6uXcOjBE/plqyDsIdLlEsk2zWaJRI2fxAH/OXX5nsStZSp6y63Ex3/ppS8lrm93qGD6Al6vgd/3KzjX3eIe+MBIaqtP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V982/aPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F37C116C6;
	Fri, 16 Jan 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592551;
	bh=jTaPZXq/b2MsUDUpeTgcDZDqVHtPxWj09BW3spN+D+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V982/aPm7s87aRIzfYF9MtkwJRUz0sO1eufNTTd9VQImu9N9VoChUQXWFx6k1Av9G
	 ADbk/JduW7/ZGMm7iG6akYENAatRNjY9VMx8YAccHpxSOtlSVQdFgpKmrP7unopD3H
	 9MEZ6OCmgDW0CQV8k+b5SajECav3l12L4Qd8LwNBl55qZwpScNmhalew5S+BHM30DE
	 4FvV4qQdPr/9KsynXOnk/P55Azmod5z3Ytr76O7IYH8PrDkBmJM5B/l7X3IrPLCKHF
	 e4BJuep689kzUl5BDBbT1xzNY8EqtvORRDjq/bdPx1YqpllUqRxdcPQFDcxtahwSAO
	 uElfx0ABp/dAw==
Date: Fri, 16 Jan 2026 19:42:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: adxl380: Add support for 1 kHz
 sampling frequency
Message-ID: <20260116194222.0723324a@jic23-huawei>
In-Reply-To: <20260115175350.1045887-4-flavra@baylibre.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
	<20260115175350.1045887-4-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 18:53:50 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In sensor variants (such as ADXL380 and ADXL382) that support low-power
> mode, the SAR signal path allows sampling acceleration data at lower rates;
> more specifically, when the sensor operates in VLP mode, the sampling
> frequency is 1 kHz.
> To add support for the 1kHz sampling frequency value, modify the operating
> mode selection logic to take into account the sampling frequency, and
> configure the decimation filters only when applicable (i.e. when using a
> sampling frequency that relies on the DSM signal path); in addition,
> constrain the available sampling frequency values based on whether the
> sensor is operating in low-power mode.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Hi Francesco,

A similar case to the one Andy pointed out in the earlier patch plus
a trivial comment.  Given how trivial they are and where we are in the
cycle, I'll make them whilst applying.


Thanks,

Jonathan

>  
> +static int adxl380_samp_freq_avail(struct adxl380_state *st, const int **vals,
> +				   int *length)
> +{
> +	bool act_inact_enabled;
> +	int ret;
> +
> +	if (!st->chip_info->has_low_power) {
> +		*vals = st->chip_info->samp_freq_tbl + ADXL380_ODR_DSM;
> +		*length = ADXL380_ODR_MAX - ADXL380_ODR_DSM;
> +		return 0;
> +	}
> +
> +	ret = adxl380_act_inact_enabled(st, &act_inact_enabled);
> +	if (!ret) {
	if (ret)
		return ret;

	/*
	 * Motion detection is only functional in low-power mode, and this 
	 * affects the available sampling frequencies.
	 */
	*vals = st->chip_info->samp_freq_tbl;
	*length = act_inact_enabled ? ADXL380_ODR_DSM : ADXL380_ODR_MAX;

	return 0;
	
> +		/*
> +		 * Motion detection is only functional in low-power mode, and
> +		 * this affects the available sampling frequencies.
> +		 */
> +		*vals = st->chip_info->samp_freq_tbl;
> +		*length = act_inact_enabled ? ADXL380_ODR_DSM : ADXL380_ODR_MAX;
> +	}
> +
> +	return ret;
> +}

> @@ -1261,12 +1296,18 @@ static int adxl380_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long info)
>  {
>  	struct adxl380_state *st = iio_priv(indio_dev);
> +	const int *freq_vals;
> +	int freq_count;
>  	int odr_index, lpf_index, hpf_index, range_index;
> +	int ret;
Might as well combine the new variables on one line or even

  	int odr_index, lpf_index, hpf_index, range_index, freq_count, ret; 



