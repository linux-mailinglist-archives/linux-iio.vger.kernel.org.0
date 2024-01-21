Return-Path: <linux-iio+bounces-1791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D21835692
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25E11F21CFD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCB37703;
	Sun, 21 Jan 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjlIBKBt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9592376F2
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853533; cv=none; b=fqbErDehPgP2B+UyVt1IJei+5SOCnUx0VNZozzkX2nf4hDrZWP5YVUxsxnbcowdaI3/uc6CggMbzDzdcu751fHhLqTY7QSOhUmt6oirxpuSmySen6r/P8vTYhVHoBnUOrM/14SL2kZ7kWe5DS67b/LJpp6VBSsPIp884cflFhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853533; c=relaxed/simple;
	bh=SCPTRJFZclDziM+4ljEYPSJeRxwP7CArqs2lgjn+AMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZStbH92UniPpFEOXJctDufBSe1RCJ+TObnstEdDQH1DjgByqU6+29wZXXpm+HhvG1cipEH0E8yokCi9qgUE0Xuo9dYyfK24CquGbKCAqzewSeLajbWiPW2MfnXJdKRTRh3rw7f6YMZ1Mej4U9MH2OmzD2fzi52Efg8WfGaVIqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjlIBKBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B98CC433C7;
	Sun, 21 Jan 2024 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705853533;
	bh=SCPTRJFZclDziM+4ljEYPSJeRxwP7CArqs2lgjn+AMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjlIBKBtrvFsy1S67wpOqjRpXZif2QgUMfSE9RnCGFvcSCi8fPbaxtkFhFkeHFFgD
	 ceYJxWDhAX7IZJER+Hh5ll0u5OG0DKlQVlPWCz+PhW8YeyE7SjRpz/Al39ykSXKFsV
	 SSrbc9DqpUI2Pl+yMImevQ6N1Ycm8RjloEOPZIzPwq8VK9Dp1hJClY8sqXsprtZxlX
	 pldVcwBTHKm634tErUnmdPL28khAzxqn0s+rE/LCeuWh5tISA5oWzKViQrh8zCe0lG
	 4nmeP9u5SOVzrSY65pD55QYvmJjj5/jMWHM6XUZF5UY1u2Ki3HpptOVW16L4q8W5iF
	 uc+aXBsCyvjgg==
Date: Sun, 21 Jan 2024 16:12:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] iio: imu: adis: ensure proper DMA alignment
Message-ID: <20240121161201.1d5c5e7f@jic23-huawei>
In-Reply-To: <20240117-adis-improv-v1-1-7f90e9fad200@analog.com>
References: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
	<20240117-adis-improv-v1-1-7f90e9fad200@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 14:10:49 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Aligning the buffer to the L1 cache is not sufficient in some platforms
> as they might have larger cacheline sizes for caches after L1 and thus,
> we can't guarantee DMA safety.
> 
> That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
> for the sigma_delta ADCs.
> 
> [1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/
> 
> Fixes: ccd2b52f4ac6 ("staging:iio: Add common ADIS library")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Guess I didn't look in the main headers :(

Anyhow good to clean this straggler up.  I'll apply it to the fixes-togreg
branch of iio.git and mark it for stable.
I 'think' the definition of IIO_DMA_MINALIGN long got picked up by stable.

Jonathan

> ---
>  include/linux/iio/imu/adis.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index dc9ea299e088..8898966bc0f0 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/spi/spi.h>
>  #include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
>  
>  #define ADIS_WRITE_REG(reg) ((0x80 | (reg)))
> @@ -131,7 +132,7 @@ struct adis {
>  	unsigned long		irq_flag;
>  	void			*buffer;
>  
> -	u8			tx[10] ____cacheline_aligned;
> +	u8			tx[10] __aligned(IIO_DMA_MINALIGN);
>  	u8			rx[4];
>  };
>  
> 


