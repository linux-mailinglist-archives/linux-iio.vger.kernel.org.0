Return-Path: <linux-iio+bounces-27280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27479CD43A6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9290C300500B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B387301012;
	Sun, 21 Dec 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1wqOHu+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375AC2222BF;
	Sun, 21 Dec 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340318; cv=none; b=CI0wwH5Zcmzle9+V2UT6MEJaqQHOmzFNZpZk2oPojavgq4KNBSr4zt4GiDjYKOwfl+Qk+poAkjIz2eC8tgYyBQFo0G8yUPeg155FP26aggxzCKmKFy8kG0uSBMVCZzDo/tIAEpKI+nSiL+KJfRRFzYvfgPRI9sKBeWP9uQzWISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340318; c=relaxed/simple;
	bh=Ee9bgrHgV3gktxPhDdHa5EtEy60W6M3Sk1vVhixBGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW65SSELOaueULTxwRTQTabYRrqeJZljZzUedA/A3sOTO+lHwvIrAFAu2JAYIArQYw09R4rvHmKaOwAeVQIVREqsUZ80KqACPo9CjWnXsWJuxhcmITju5042RsRU+BxBiPDRevBRIXtYnoqMu0DCYAMqZBKUQVyZ3F+sZxu5HwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1wqOHu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73A2C4CEFB;
	Sun, 21 Dec 2025 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766340317;
	bh=Ee9bgrHgV3gktxPhDdHa5EtEy60W6M3Sk1vVhixBGhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1wqOHu+78QX5OEVrg5YzvDj5POaoqipE8lGpw6hABTfKnYgeUhy3wPq7z7/yVoZD
	 UZndXXs4l/QI/YEYeP/IkToFa/OwvT3SCICRzyL407CKg5i+Y00VijvUE4CCMivifw
	 +Z2EanLZkBn6HJuQNQuenWTUsfm1r3dwJh4fI46gn2rSoKPsxRDXKEV/uKliYLHvG0
	 ukgy0lNPfUqnu4zOSvVSxefARg6Lw6xlGFp7PuZb9EpcNfoSqcBj8QLwguigiw+s9d
	 8PJRHy8nk2hfF6f6wDoCH7tr3sZv+LAPSFYbTGfVPbUXQBLOD4MRHk9aoDRkKqpz7J
	 uKHwGJvjXG/ag==
Date: Sun, 21 Dec 2025 18:05:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: Roan van Dijk <roan@protonic.nl>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: scd4x: expose timestamp channel
Message-ID: <20251221180508.252bd6d9@jic23-huawei>
In-Reply-To: <20251218151205.1301792-1-fiona.klute@gmx.de>
References: <20251218151205.1301792-1-fiona.klute@gmx.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 16:12:05 +0100
Fiona Klute <fiona.klute@gmx.de> wrote:

> Timestamps were already written to the buffer in
> scd4x_trigger_handler(), this patch makes them available as a channel.
> 
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Applied to the togreg branch of iio.git. Initially pushed out as testing
to let 0-day have a brief look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/scd4x.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index 0fd839176e264..23a326fb62a7e 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -59,6 +59,8 @@ enum scd4x_channel_idx {
>  	SCD4X_CO2,
>  	SCD4X_TEMP,
>  	SCD4X_HR,
> +	/* kernel timestamp, at the end of buffer */
> +	SCD4X_TS,
>  };
>  
>  struct scd4x_state {
> @@ -615,6 +617,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
>  			.endianness = IIO_CPU,
>  		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(SCD4X_TS),
>  };
>  
>  static int scd4x_suspend(struct device *dev)


