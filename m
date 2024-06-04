Return-Path: <linux-iio+bounces-5779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E846C8FBC04
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D2AB21C77
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D0714A633;
	Tue,  4 Jun 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvaw5Idf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACC1474D8
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527680; cv=none; b=C4Ok5obYYo38Eb/MHOfXg/dr+ioS2CL10g0oUaI+kg9SckOl4rdFDekIDY5VY2qeEHRX3GkT6gxWM/6vSQKnAdWYizn1bOswsjE+nXQprfpFmELJXzJ19+EYWfXmpHESnodlioDRTvTfxkJe9Z7ZL/yayhPMmBP+JfwLEUXPIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527680; c=relaxed/simple;
	bh=lK9xMMSJ5zSRRo/ybgQaKrbf/8Iqc7juMtDeuGEfUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoR2wHbRbL58G2ItWifghLlnSp24xEN6HiCTWjtd6RdBe2zKbBih/s2kBpBhwTgZSGtZGdXo5aoj+PodVDfm2PwdUkQH9erzSQAOTqs9UTIAoN1YtfTi4MGXCLtFN1qS3j08rmKw8k5iCQLjJiB1TLZvLa2VSOSlNBZX60FZ4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvaw5Idf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB19C2BBFC;
	Tue,  4 Jun 2024 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717527679;
	bh=lK9xMMSJ5zSRRo/ybgQaKrbf/8Iqc7juMtDeuGEfUYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fvaw5IdfyTMxDkXYWHygiDOCrmQycgbhcl2cD/fwugS8NneVCDzKJCaESGaeiLs6I
	 8Pl81+Lb9YwmW4it7dVmP1ms9qVneKU/ocY8HnDTA8VZEP/v5Tye+5kVWDenPWB9sC
	 Cj4U4Je3jVN+zXgVKm0ih0EZJZTSQ3R1ZRIQ/nBx2zWJKIRWyf7dkGMF9OPwm8WaUb
	 1c3P69PMa470c8nS1espcOj2K00/+ucjhTSKj/sC3u3KciJMSZQrJnicPLnJP7shqx
	 /4Idd/5a3QJiVhOd83ECCDgcVMB0k3MSLGXrfkya3lCnN6ceS8eS57ULz2XWetEIl8
	 6aryUYodxIbig==
Date: Tue, 4 Jun 2024 20:01:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adam Rizkalla <ajarizzo@gmail.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix bmp580 temp read
Message-ID: <20240604200107.7f68dbf4@jic23-huawei>
In-Reply-To: <20240602201200.30418-1-ajarizzo@gmail.com>
References: <20240602201200.30418-1-ajarizzo@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Jun 2024 15:12:01 -0500
Adam Rizkalla <ajarizzo@gmail.com> wrote:

> Fix overflow when storing bmp580 temperature reading and preserve sign.
> 
> This patch re-applies the fix in [1] after the merge conflict resolution
> mentioned in [2].
> 
> [1] https://lore.kernel.org/all/Zin2udkXRD0+GrML@adam-asahi.lan/
> [2] https://lore.kernel.org/linux-kernel/20240531140621.264f0848@canb.auug.org.au/
> 
> Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>

Thanks! I was just about to email about this fix currently being lost in
linux-next.

Rather than dance around this, I'm going to pull the later part of Vasielios'
series off the togreg tree for now then reapply later once I have the fix
in my upstream.

It's a shame that we need to do the maths in driver to keep within range.
Maybe we can be cheeky and avoid doing the division?
I believe the IIO core formatting code should be fine with that as it
already casts up to 64 bits to do the maths.

(s64)*raw_temp * 250);

bmp580_temp_coeffs = {1, 18}

Anyhow, I've dropped (for now) the following patches from my togreg tree
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
  iio: pressure: bmp280: Add triggered buffer support

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 95c88b0e1c49..3a003843c79c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1752,6 +1752,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
>  		dev_err(data->dev, "reading temperature skipped\n");
>  		return -EIO;
>  	}
> +	*raw_temp = sign_extend32(*raw_temp, 23);
> +	*raw_temp = ((s64)*raw_temp * 1000) / (1 << 16);
>  
>  	return 0;
>  }
> @@ -2154,7 +2156,7 @@ static irqreturn_t bmp580_buffer_handler(int irq, void *p)
>  
>  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
>  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> -static const int bmp580_temp_coeffs[] = { 1000, 16 };
> +static const int bmp580_temp_coeffs[] = { 1, 0 };
>  static const int bmp580_press_coeffs[] = { 1, 64000};
>  
>  const struct bmp280_chip_info bmp580_chip_info = {
> @@ -2184,7 +2186,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
>  	.iir_filter_coeff_default = 2,
>  
>  	.temp_coeffs = bmp580_temp_coeffs,
> -	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
> +	.temp_coeffs_type = IIO_VAL_INT,
>  	.press_coeffs = bmp580_press_coeffs,
>  	.press_coeffs_type = IIO_VAL_FRACTIONAL,
>  


