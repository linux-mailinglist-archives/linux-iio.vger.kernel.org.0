Return-Path: <linux-iio+bounces-6766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01F913C7A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B41A1C21218
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF461822D2;
	Sun, 23 Jun 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuF1wu0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AC63D;
	Sun, 23 Jun 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157294; cv=none; b=pMXp4zdbO/yyRYBqOodrSWy/lkbQgzLovRlF8jjtfNlSKZT/lFbz2kWnZ5sn9VtATrhiGZIzsXFlY9IS6URQ+V5VPJ7AiCApOR6/gTYO8Mlhd/NF5W7YzylTaDJ7hY3HvBPi37K2IacThI7iF7yOKe8FspnWpebz0tFiuum53cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157294; c=relaxed/simple;
	bh=/R0Zq7xYdN6DFOT650EEINjHlBn3PHVgUlePIr7ldJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd6Jf5ZC1MIBJtj1z17YAaf2jo8JFdOC+8MZQ/NOb5RJUdTOQrvLsCD98bB+PchflndfJE6RR/nJeiw6NjjLzk5k6vNppwQ5cz1x8MsC2ssHM4CbiRkCLGi9P2BzHP4bDNu/TBRc/mbOk1pa36LikaABnKmFu5Kkk9z0l+fbKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuF1wu0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F55C2BD10;
	Sun, 23 Jun 2024 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719157293;
	bh=/R0Zq7xYdN6DFOT650EEINjHlBn3PHVgUlePIr7ldJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuF1wu0BhArfGBomshio6LL1nF33ndewnlGhsXsNj6I+9ClEfr5jmuWkJdsGS6CJa
	 lJ5GMNTPYWngsw6R5XytBROXxGklOkFewWd4Vqe3/adRL3TwKiN+ejA1hTOuftPlIt
	 80qrFaerRaSYJGsErUsl7wKi2X6/3AIpwtaJ3Ht8LT5sh5oQIRZh2FjPmwAQRVj5hM
	 zN/o7G9UI27DCBx06ddr+cdSVDE6m7T2DULtBRFbLSmntCK4kpb4u0GTjaaU+t56ql
	 /7yflduz2At2F2CEGu/XfU/mdT41yTBXYL30q+uWL6jn8RdWuu/JXok/Ko/DXjxrTB
	 mYViBFjmTAwEQ==
Date: Sun, 23 Jun 2024 16:41:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 7/9] iio: adc: ad7606: switch mutexes to scoped_guard
Message-ID: <20240623164126.0cf96981@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:02:39 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Switching to scoped_guard simplifies the code and avoids to take care to
> unlock the mutex in case of premature return.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 71 ++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3a417595294f..e3426287edf6 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -69,19 +69,18 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	if (readval) {
> -		ret = st->bops->reg_read(st, reg);
> -		if (ret < 0)
> -			goto err_unlock;
> -		*readval = ret;
> -		ret = 0;
> -	} else {
> -		ret = st->bops->reg_write(st, reg, writeval);
> +	scoped_guard(mutex, &st->lock) {
> +		if (readval) {
> +			ret = st->bops->reg_read(st, reg);
> +			if (ret < 0)
> +				return ret;
> +			*readval = ret;
> +			return 0;
> +		} else {
> +			return st->bops->reg_write(st, reg, writeval);
> +		}
>  	}
> -err_unlock:
> -	mutex_unlock(&st->lock);
> -	return ret;
> +	unreachable();

Unless you are going to add more code in this function later in the series
then a
	guard(mutex)(&st->lock); is more appropriate in this function
as the scope is effectively the whole function.  Also avoids the always
ugly need for an unreachable() marking.

I'm not sure what the build bot warning means though.

Otherwise looks good to me

J

