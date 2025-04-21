Return-Path: <linux-iio+bounces-18456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601DEA9523E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D549F7A8DC2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71626659A;
	Mon, 21 Apr 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJy+Kodz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211A264FA6;
	Mon, 21 Apr 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243983; cv=none; b=PW7WCLvPo8oDxoT7eIgdLOgDwXngKj7OUH4444bgupSIMqToGvKy5a7q3lKEySv+HoxEVksZFmS54LmhVsRhn3G77NrFNEvJpeBCHoCCx3ZyFERWh0EFYhbr9peQnA+5VZZfVrOrAQdK6bGrVEBDx8UMl0FSiMOmbi4cRBN8gW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243983; c=relaxed/simple;
	bh=J7iTshs6CmOUgtoiSBVw1f3K2zMl0Vgv+zGSAmPjgtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQhbYCOlMlGU4iQZMakRoaFqfxI41DnvOlxHYDsIvYZT6Rma3EyN76mVy30Vc8nfjU1EksR3Eq9p13J7MAAyllTfwFZLybJcLpOmHBa8jgSVlLMSukEaxqy5//4/0743fF9hmI8skuTwJ/ImNBa27LTxdhQs1s2V9NdYP4fDmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJy+Kodz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73FCC4CEE4;
	Mon, 21 Apr 2025 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243982;
	bh=J7iTshs6CmOUgtoiSBVw1f3K2zMl0Vgv+zGSAmPjgtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJy+Kodz0gmjCgZ7HwUyChvh/DejzC0+EK7D/vx0CSS+wrZAwH8pf56ELPsC9e1xh
	 BMHeEHYUYv2DXUSBxd6ykFGDjveHORcfn1z5jJh0mGveXGTYkIMY6LX2AB2Tn53FY1
	 5NAzhKDW7zl+jf6od/eHRmxXdz/BVsuORt+MlfIiHzeJA3CJFpK3NMiJmFiojOl3Hd
	 VCFRo27RlpXRVHguyOPA9encVuM8XGb9CdfoXDqqRhVNFQl9uQI+hjvLPymfMDQ2gw
	 ckn8Yh5/nQFkZbqjGFSyUjUnT8CTHZVThfINCgm3IJO26r8J0pREDGjaH415s+VCE9
	 x6cdUMKRBcaig==
Date: Mon, 21 Apr 2025 14:59:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 marcelo.schmitt1@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <20250421145931.605df588@jic23-huawei>
In-Reply-To: <20250421131539.912966-1-gshahrouzi@gmail.com>
References: <20250421124915.32a18d36@jic23-huawei>
	<20250421131539.912966-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 09:15:39 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The inclinometer channels were previously defined with 14 realbits.
> However, the ADIS16201 datasheet states the resolution for these output
> channels is 12 bits (Page 14, text description; Page 15, table 7).
> 
> Correct the realbits value to 12 to accurately reflect the hardware.
> 
> Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
If you post a new version, always add the version number.

Anyhow, I was just asking for the fixes tag, but this is fine.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

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


