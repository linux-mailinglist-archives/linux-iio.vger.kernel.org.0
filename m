Return-Path: <linux-iio+bounces-4847-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812B78BD063
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FB71F2148F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67D152500;
	Mon,  6 May 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMQJ5wAC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1DF3613D;
	Mon,  6 May 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006140; cv=none; b=QCOyUuvz3Sh9iwGNpcIXSRhZBaVjB6JkwHDgeWYXWLJLrsU906MVvdLBH/jnBKyEpqSVKhwbNpyOmjd4zfHwfOStvAOdvXOTiJJ5Bgt8l5PR8xJdLwpYu5irUvkcs/s2P4muqUDOn8jc9XTLd1TVtFPSsLhCsPPjbVQABen1J9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006140; c=relaxed/simple;
	bh=Holytb9LI9/E5M3PKa+GSC5j9DzW8jErOK36mBSw64s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X34eYmSmUxNvQApBQK/Fqi8tPtCQaC2VtOa7IzWtlcFoszLOSa/SOq8qhDmFBLBtwUxgqJxPYCgOuKbgmtU5oeA659y4gtr7PsbifzvUKd1w/n7w7NNK9Z+ZNj1PGx+znG+D+A0q8pfmGZG87f+ZuDz2kA36AUj+Xp9LK6Lg8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMQJ5wAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E4C4AF63;
	Mon,  6 May 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715006139;
	bh=Holytb9LI9/E5M3PKa+GSC5j9DzW8jErOK36mBSw64s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bMQJ5wACI3bbtA1T/pInSGitQPQIFJU1egDf/vV7R5rtCMbqW+OsEdO02dROIjB0J
	 UiK5E/3bbvYReFq7MhwWDKdUjcQGA/iIr3VVXVyaAJs7tqAlMpPZJS6xK8GD1Y6+2e
	 ZRZFxz2LJtuTUGUhJtdyb5XaEJfUQyWBv5dz9IIhjifkrtAHphhdJ2htgoMbWKy5hj
	 YZRgHrLSi0Nm8KTSniRG3V66b7zvhrU5hy1AMeUHi8d9Cg1t3vvMJPuEBHqEWm3/fI
	 nzf5jPDRBo4QShdBMuTdgK97S37GL3+iLtXIjpo5/dfl2yNITojKsxKbVz1y7tlH7T
	 uHlugMzmPRr2g==
Date: Mon, 6 May 2024 15:35:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: marc.ferland@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Ferland
 <marc.ferland@sonatest.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: dac: ad5592r: fix temperature channel scaling
 value
Message-ID: <20240506153528.148d9b18@jic23-huawei>
In-Reply-To: <20240501150554.1871390-1-marc.ferland@sonatest.com>
References: <20240501150554.1871390-1-marc.ferland@sonatest.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 11:05:54 -0400
marc.ferland@gmail.com wrote:

> From: Marc Ferland <marc.ferland@sonatest.com>
> 
> The scale value for the temperature channel is (assuming Vref=2.5 and
> the datasheet):
> 
>     376.7897513
> 
> When calculating both val and val2 for the temperature scale we
> use (3767897513/25) and multiply it by Vref (here I assume 2500mV) to
> obtain:
> 
>   2500 * (3767897513/25) ==> 376789751300
> 
> Finally we divide with remainder by 10^9 to get:
> 
>     val = 376
>     val2 = 789751300
> 
> However, we return IIO_VAL_INT_PLUS_MICRO (should have been NANO) as
> the scale type. So when converting the raw temperature value to the
> 'processed' temperature value we will get (assuming raw=810,
> offset=-753):
> 
>     processed = (raw + offset) * scale_val
>               = (810 + -753) * 376
> 	      = 21432
> 
>     processed += div((raw + offset) * scale_val2, 10^6)
>               += div((810 + -753) * 789751300, 10^6)
> 	      += 45015
>     ==> 66447
>     ==> 66.4 Celcius  
> 
> instead of the expected 21.5 Celsius.
> 
> Fix this issue by changing IIO_VAL_INT_PLUS_MICRO to
> IIO_VAL_INT_PLUS_NANO.
> 
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
+CC Nuno.

Seems obviously correct to me so I'll apply it to the fixes-togreg
branch of iio.git.  I've been wrong before though so ideally would like
one of the ADI team to sanity check this.

I'll add the fixes tag as well and mark it for stable. This goes all the
way back.

Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")


> ---
> Change in v2:
>  - Improve commit message as suggested by Jonathan.
> 
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 076bc9ecfb49..4763402dbcd6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  			s64 tmp = *val * (3767897513LL / 25LL);
>  			*val = div_s64_rem(tmp, 1000000000LL, val2);
>  
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_VAL_INT_PLUS_NANO;
>  		}
>  
>  		mutex_lock(&st->lock);
> 
> base-commit: 98369dccd2f8e16bf4c6621053af7aa4821dcf8e


