Return-Path: <linux-iio+bounces-4960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D308C31A5
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BA5281CEB
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2851C54;
	Sat, 11 May 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtc+pgZV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E06FC6
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434258; cv=none; b=ogW68WWR1dSVcqINyRsS4vUlc1Uq9sD/dSY9YQuzLzdGdyYduodU9qL9aeftTy1pPzjBNRlaenuQMkD6yazbB3WNw5JQWJoGrMWhszQJhtjxpJ5sPAHrz4jtLBfwrbZO48JeIPSm26jJejmXr/nHWcGjXkwCEXODi83l5J+DGss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434258; c=relaxed/simple;
	bh=8VK091+aMhVVWr7ioKBYZoDqAnx2Ly+62hlVjIOnEfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDuwq1oUazuJvW1Lu1hJ2XvVXL6ZQp9Mir+rLYJQTBtzaZEZKFW8nhaWvf+clwhQuz32Gf3ahU8RTb1kVjZ+/XQQCq6lMVmY7PM5qF3Olhp4SzXZs68o+pNjLV3Oxgm56ZCQoT45YJxmVcF9uJYK0dQeeSgF6h1o0hieOEnAPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtc+pgZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B61EC2BBFC;
	Sat, 11 May 2024 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715434257;
	bh=8VK091+aMhVVWr7ioKBYZoDqAnx2Ly+62hlVjIOnEfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wtc+pgZV5Z+Yyvu3ujXbTwXWB3CrAr2zl+XEMYooCP+PXaf4E6VhIcB8OzaIZB/1D
	 JPTRxnjC421tTrxUA3ELwFcG0md/EIhzrsga59D4wF6ncxj8TYIWJTXod26jVVydfl
	 79Uk5Ioz20sVbirkZ43fSJtxjtHjpQX8iAM0qKQtqPG7MLvcRM2XCKGEZOlEtV8FhT
	 dofdaGYy+gdjX6ryy74JBTu3lhltUJ3ayW1yp4e6oqL3+xgkJ7tc2F941XslfxQ0bX
	 jmbMdXAH0yG84jVn6v2rcVtCMNpaMc2rs2yTU0OZecAbY93ke9xmwi8i4rARrquMKw
	 wUS5BrkiT5GPw==
Date: Sat, 11 May 2024 14:30:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eduardo Figueredo
 <eduardofp@usp.br>
Subject: Re: [PATCH] iio: adc: adc7266: Use iio_device_claim_direct_scoped()
Message-ID: <20240511143048.53df0ca4@jic23-huawei>
In-Reply-To: <20240508155435.183850-1-hagisf@usp.br>
References: <20240508155435.183850-1-hagisf@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 12:54:35 -0300
Fernando Yang <hagisf@usp.br> wrote:

> Switching to the _scoped() version can make the error
> handling more natural instead of delayed until direct
> mode was released.
> 
> Co-developed-by: Eduardo Figueredo <eduardofp@usp.br>
> Signed-off-by: Eduardo Figueredo <eduardofp@usp.br>
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 8b03d4469..3fc34a3a8 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
>  static int ad7266_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_wakeup(st);
>  }
>  
>  static int ad7266_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_powerdown(st);
>  }
>  
> @@ -151,15 +153,16 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
This isn't the existing code. I'm guessing you have another commit ahead
of this one on your branch?

> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  			ret = ad7266_read_single(st, val, chan->address);
Not checking ret here is a bug in the existing code.  Please fix that as
a precursor patch before making the _scoped change.

The check will have to be immediately after iio_device_release_direct_mode()
in the existing code.

>  
> -		*val = (*val >> 2) & 0xfff;
> -		if (chan->scan_type.sign == 's')
> -			*val = sign_extend32(*val,
> -						 chan->scan_type.realbits - 1);
> +			*val = (*val >> 2) & 0xfff;
> +			if (chan->scan_type.sign == 's')
> +				*val = sign_extend32(*val,
> +							 chan->scan_type.realbits - 1);
>  
> -		return IIO_VAL_INT;
> +			return IIO_VAL_INT;
> +		}
>  		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_mv = st->vref_mv;


