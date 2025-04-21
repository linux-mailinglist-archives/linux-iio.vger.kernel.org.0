Return-Path: <linux-iio+bounces-18428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D796A95116
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA83A3CFA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509A264F9A;
	Mon, 21 Apr 2025 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZaWPkhE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85B20D51F;
	Mon, 21 Apr 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239079; cv=none; b=P+Oubn2UxsJ6DjRBARaABfxHCoB32+slsJBHHXILSi/ueFmP2xraTeyuKrbG965pOJ9HVdXwGdz5a+4lPiE5MHjwYaDG8DSdLl1WU9fI2FTwFu9kYol0QZ9PjB8D8+QdEDK4WXdoL/y/qvChQ87dG36ZNqHjUI2bWwaD9bOZmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239079; c=relaxed/simple;
	bh=b54HVeZaJH2l6sLxJ4aYOS+CC2PLI8L1VIFwgXcVqCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoRwV/bu+/SrxBwEE8P5YA0XGWIfuPT/WjYWdZDkiEtIePNK40PS2/Uy0uW8MGK7FtmGdDpmDqTfdjDFe1m+YccDaTMd/DXU/Zo7Od1zKg2VSJCHQY+QWxX/OVfmGvAu6M+Vja6fVIXMiQMqfzXE8Xad37g4UIUa07FJXsSjm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZaWPkhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2888CC4CEE4;
	Mon, 21 Apr 2025 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745239079;
	bh=b54HVeZaJH2l6sLxJ4aYOS+CC2PLI8L1VIFwgXcVqCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZaWPkhETrk9Xpepa5SvxfET+eYR2n02GR0CSExHMaWquoCRQ6VGBlUqIHHzOYm6q
	 uenrhUpq2b8RpLKt6Xr0N/yzIB1YCEVDZbLX1Wyfk3l+hEe2ZGaQmv7HidYerkYT/V
	 4QlGtgfv1+HbI5pugx/WseMPfaAV0v2SvLRRbawIBfPOEMRf9Keh2eeDvO4Jc8AIAu
	 wq17PyoFRAC1nPOMOcRXpa70rsGLLDocmw5Azm0Kz0gXBN4Cd/I9nhKb8SOApHGk3t
	 LWjSco6gJuTkwO9hUrcXlOXBKe2+RhEgh8nYvBmpGkwRzdwc/Ga0Iy6wI/ojccp6fz
	 9UePgPoWBA88Q==
Date: Mon, 21 Apr 2025 13:37:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5 5/5] staging: iio: adc: ad7816: Simplify channel
 validation using chip_info
Message-ID: <20250421133751.6fb5b4d4@jic23-huawei>
In-Reply-To: <20250420014910.849934-6-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
	<20250420014910.849934-6-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:49:10 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Refactor the channel validation logic within ad7816_store_channel() to
> leverage the max_channels field previously introduced in the
> ad7816_chip_info structure.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Carries forward the odd mask usage from patch 1. So fix that up and then
I think this is fine. Given you introduce max_channels just for this, ideal 
would be to only introduce it in this patch (with a better name - see
earlier comment)

Jonathan


> ---
>  drivers/staging/iio/adc/ad7816.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index ab7520a8a3da9..7a59cfbcc6e33 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -204,17 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
> +	if (data > chip->chip_info->max_channels && data != AD7816_CS_MASK) {
>  		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
> -			data, indio_dev->name);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7818.\n", data);
> -		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
> -		dev_err(&chip->spi_dev->dev,
> -			"Invalid channel id %lu for ad7816.\n", data);
> +			data, chip->chip_info->name);
>  		return -EINVAL;
>  	}
>  


