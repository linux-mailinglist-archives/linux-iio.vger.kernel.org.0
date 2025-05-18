Return-Path: <linux-iio+bounces-19633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F166CABB100
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116A8189397D
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB321D3D2;
	Sun, 18 May 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN4rRZzv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B917BCE;
	Sun, 18 May 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747587841; cv=none; b=HD6Gmev8WSOs4y+4oVJzusbTg694n237MeAttks+9FFD8+d5y0OsvjURbJvK1XMLrcsciVrhIgd+6WSRhOhhV04VEZgYdZs4rQx92An/+1ZlYWU5L655T+LXXYqhwqWOiBFOFeEO5MnhU3Ch3b2gNIkD+Umt5Y7E4STsaVSfeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747587841; c=relaxed/simple;
	bh=VZyATrG8dI2kKuzr8sjYNP2XjYxIguTB75/oIwMWeME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOKkcf3sSqc55RceRKoPJ51e8x3gXszSSIqZkjoBYGrF3oPai2dZ+pBNA5YawERGn7uOYdm5SN8o6QDlJJkO6vCAn9bL1aE3VK57O4bRfYPrlgLppuMoKx4SZCM82ZC1rUHeq55jbTAKZDI//sIsa+YFpSZ1fUKQjRvrfAmmp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN4rRZzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2035C4CEE7;
	Sun, 18 May 2025 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747587840;
	bh=VZyATrG8dI2kKuzr8sjYNP2XjYxIguTB75/oIwMWeME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oN4rRZzvoIWK11dRtMO4f89WBEo2r6ETdeyX6jrv9qoAYhseXkyweyQD1YTBuGAJi
	 gN0ZvcCyPtGtbTPEu0DWoY6WHzJc09VeFXtgaAdOjDZeIZ4BEftwEDp2Ht1XAGQfLe
	 RNaL9PhDGCWkEHRu2dmXZ5Zqz97qCJkRJ26X5E9ehlSFiPfJUzJk4UaBunnYQWTwU4
	 +HPtmYd5LD3U9h/yNfYOgnbbsHHVk23HOKBRK0cjfgaKB52FPkClPfg4k1+K8NCkWl
	 iLwj+gHJFJQYJA0zYFjJmQSZ6ZbkpPyfNyGnayugKjA5vR7cN54D1Seq8DVIW/jvy1
	 79SQrcrq28tbQ==
Date: Sun, 18 May 2025 18:03:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>, "Pop
 Paul" <paul.pop@analog.com>
Subject: Re: [PATCH v8 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250518180349.6fb308be@jic23-huawei>
In-Reply-To: <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
	<1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -326,11 +337,37 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
>  
>  static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
>  {
> -	unsigned int i;
> +	unsigned int i, samp_freq_avail, freq_filtered, len = 0;

If you are spinning again, please split the len = 0 onto it's own
unsigned int len = 0;
to avoid mixing assigning and non assigning declarations
as they are a little hard to spot when mixed up!

> +
> +	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
> +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +		samp_freq_avail = DIV_ROUND_CLOSEST(freq_filtered, ad7768_mclk_div_rates[i]);
> +		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> +		if (samp_freq_avail < 50)
> +			continue;
> +
> +		st->samp_freq_avail[len++] = samp_freq_avail;
> +	}
> +
> +	st->samp_freq_avail_len = len;
> +}


