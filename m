Return-Path: <linux-iio+bounces-18421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D9A95067
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D618937F4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09204261575;
	Mon, 21 Apr 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzCnhf4N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB04C85;
	Mon, 21 Apr 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236163; cv=none; b=iBBYdK158KsxYVaWC5+J/flMQIuMMg5s6DN6pSfMraCpM7Zrf5P2cwoHaRbQvN4BZw8UqS7ogUY82EWKT/CHqYTlNHZdVjqn9V/2eBFHvh3NNwZqDUdb38TvsMd7/e2c2FciYNTzievgTfxblBetgDk4FOHoaMHQdo+z64IVO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236163; c=relaxed/simple;
	bh=o5jpVjh6M95IwHo0cOnF2XWauP9xFFq5pREq0Q+F/3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5yzSjsVBxkcOe/JPlhK/SowrPJSiK/8dhmghVLn9iSV7ebJDC4godA1Hm6F4aEtMwef57MgMVPFpbki4HVkKKkg1FZG4DM4ZDOb5AaEoWv7EMtBKwODcqrt0BWrZKp14GTyBEMMSc/cB0ksKKlZd7ViPrwzvQLBpQQ4Y7tnEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzCnhf4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3596CC4CEE4;
	Mon, 21 Apr 2025 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745236163;
	bh=o5jpVjh6M95IwHo0cOnF2XWauP9xFFq5pREq0Q+F/3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qzCnhf4N18HXKHEhnXVoW+xMCdKcTNPeSyNHMvpR30Cc7dwhkvm1qU8PNOpbrVPAR
	 QG9yrLEIWKOHvFI1oLf9v0CDmaAO5MK6r+qv1B7Fp+7WIhldS4+NsBd4PGKIpCQbnB
	 b1zkBpSC+NbjN28EnKsco8pGvj0tD/xWh9JK+yYA1iXwbxS0uuizj+u+oqy0Eiw65/
	 uhVGDWUi+TqscR/FMGM6+qfcFaQtKSS/dYRutkjT8LqSDW+R79arEMcGWkNJ17Nd/W
	 wfMW0xFl92ZX96Zt4qbBKNeRWW1IrPERydIOhgQiv69+fkt6cReI+orXE/Efx0ytAi
	 dCDp9ODSSPLag==
Date: Mon, 21 Apr 2025 12:49:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <20250421124915.32a18d36@jic23-huawei>
In-Reply-To: <20250419144520.815198-1-gshahrouzi@gmail.com>
References: <20250419144520.815198-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 10:45:20 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The inclinometer channels were previously defined with 14 realbits.
> However, the ADIS16201 datasheet states the resolution for these output
> channels is 12 bits (Page 14, text description; Page 15, table 7).
> 
> Correct the realbits value to 12 to accurately reflect the hardware.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
> Omit fixes tag because it targets driver before it moved out of staging.

Why does that matter?  Should have a fixes tag.  Whether we chose
to backport the fix is a different matter.

Otherwise looks fine to me. Reply to this thread with a fixes tag
and I can pick it up without needing a v2.


> ---
>  drivers/iio/accel/adis16201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 982b33f6eccac..dcc8d9f2ee0f1 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>  	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
>  	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
>  	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
>  


