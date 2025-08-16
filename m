Return-Path: <linux-iio+bounces-22793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F456B28D2A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A8B06666
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A029B206;
	Sat, 16 Aug 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Oo5RmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275029ACDE;
	Sat, 16 Aug 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341637; cv=none; b=YEFwtJAL9rRbloZ1Ang8cCHqzaQmaikf/vJhjBG8Wla1kfvCGpePK+5MfgrctF+Z6zneT2flhEK8vS++jOQ3E4w8b1dNfxfZCYj1nTlPzGXoqi9FhV3d3viLMFLCeGhNifv77qYBr9zsM7PlT7XMTL1pa8U6RorTun6jMfLOS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341637; c=relaxed/simple;
	bh=NrCkOT32NSplq8+x8pz9ZQFGUGbs5XTCGwcFwWKjxtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/HWiyQvsVqYSfx9+KSsWwRdBK4Gz2zFEL1f/Kadzt1PSX0FOfPey0Bsks8WOQbRL1BnQlvAlLN68/zxXCzBGFswUUIf6yjc5l8xXVoLUrKdtpMdKVdeCDSUuxXUYmDUKFCevuF1W3ToxNRRPl1IGCbdThPPli4zdTobP8qj18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+Oo5RmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77B0C4CEEF;
	Sat, 16 Aug 2025 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755341636;
	bh=NrCkOT32NSplq8+x8pz9ZQFGUGbs5XTCGwcFwWKjxtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q+Oo5RmAl/yPzstmUq1BFZH4pf4a3pucCoqHTD3vf5eimfltsVG4N+eflpz1V6nGS
	 j0nrO/EMJMPLFJnJyA7aiZOSi6RPEwXUZcJvz4id6feHsOlINdyqIMxwoYqt78S60v
	 PfKrmTH/vWBzR/CllclA/R2Ui//xq1dWFbJtBwlEQs/DMiP3qZGGJDS1/pdHUWd4Oz
	 ay7L+2FJ8TVaahduSvV5/0ahy8DkhwsT3F7D9adPr+PpbwuBDH8AYOksl0P0dvXB4E
	 BJS5FvVtv1kw6Z+kB/IpIExkfFhn9l/vKBUv35W12p+q2HxnmLfHP/s82R2dqhb5AZ
	 AC/rvgpuQNUWA==
Date: Sat, 16 Aug 2025 11:53:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ltc2497: reorder struct members to fix
 memory holes
Message-ID: <20250816115348.1fba0a7b@jic23-huawei>
In-Reply-To: <20250815-ltc2495-v4-3-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
	<20250815-ltc2495-v4-3-2d04e6005468@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:02:04 +0200
Yusuf Alper Bilgin <y.alperbilgin@gmail.com> wrote:

> Reorder members in the `ltc2497_chip_info` and `ltc2497core_driverdata`
> structs to eliminate memory holes identified by the `pahole` tool.
> 
> Confirm via the `bloat-o-meter` that this change has no significant
> impact on the final code size:
> 
> | Object File     | Total Size Change |
> |-----------------|-------------------|
> | ltc2497-core.o  | 0 (0.00%)         |
> | ltc2497.o       | +2 (+0.10%)       |
> | ltc2496.o       | 0 (0.00%)         |
> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>

whilst I know Andy is a fan of this stuff, I'm not convinced it is worth
the churn in this particular case. 

The driverdata is allocated via iio_priv() so has a bunch of additional
alignment rules applied and is on the end of another larger allocation.
I suspect that completely hides the advantages in closing the holes up.

The chip_info one is a bit more convincing as that's static const stuff and
maybe it ends up packing a little better.

Anyhow, let us see what Andy thinks.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ltc2497.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index dfe2d5c30017adeb3f17e57fc5bf1e0e792ff30f..48e9f74870ab489b5df6e69a39446610c6a72b93 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -5,8 +5,8 @@
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
>  
>  struct ltc2497_chip_info {
> -	u32 resolution;
>  	const char *name;
> +	u32 resolution;
>  	/*
>  	 * Represents the datasheet constant from the temperature formula:
>  	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
> @@ -20,15 +20,15 @@ struct ltc2497_chip_info {
>  };
>  
>  struct ltc2497core_driverdata {
> -	struct regulator *ref;
> -	ktime_t	time_prev;
>  	/* lock to protect against multiple access to the device */
>  	struct mutex lock;
> +	struct regulator *ref;
> +	ktime_t	time_prev;
>  	const struct ltc2497_chip_info	*chip_info;
> -	u8 addr_prev;
>  	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
>  				  u8 address, int *val);
>  	enum iio_chan_type chan_type_prev;
> +	u8 addr_prev;
>  };
>  
>  int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev);
> 


