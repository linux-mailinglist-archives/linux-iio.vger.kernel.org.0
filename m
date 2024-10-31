Return-Path: <linux-iio+bounces-11719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E002C9B8344
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6AB1C21ECD
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD61CB53C;
	Thu, 31 Oct 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/rEIjVU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2861CB339;
	Thu, 31 Oct 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402527; cv=none; b=jdq8cWXjvRs9gARb/Os3YjqE+v3kH7/woXF85abtoLfqBSrxV2pnOkbWcFD4j1Jbhg5vawlAQowX7XWjV7v3rEZd0w2QjoZC0VwCfu2Bo9mQ8fNUsGLeDwRJOO+Hkge5KU5gcV0WcI9wOt1iI3D5dlj1TrMoKZKY5YtKeZRzOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402527; c=relaxed/simple;
	bh=NQExuNwmSmnXRwubYNqVJYHcQFwZjkDDNWdIBUCeMCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AngPJzhFsSeC+lYHhQEAD/YIpU9h577ZfxuY3aLSgNVEPbhbJU1h9VuYdCKI0IJVwTeN+BGUMF2Wicbo0ZSI5wbOkkgn0DPG+KBRaXNWw537dnkcOKe1XHkVecJp51zkru1do/bRlAu1sd6QKwS4mzHXGtg1W2tIMKP80un+Qp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/rEIjVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E470CC4CEC3;
	Thu, 31 Oct 2024 19:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402527;
	bh=NQExuNwmSmnXRwubYNqVJYHcQFwZjkDDNWdIBUCeMCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/rEIjVUGk4yDusxok4rBAzll+GAHu1NW97ceZQmsC2p/XP9sr71iBcwY4OIlxWSb
	 4PYx+BFRntiOpNKLjinj5i/tz84ZNp6EYV4dM0MdrolulKkFhG0+8JLnuYZMX041IJ
	 ewVlmv4dl+v7cpnBQqRDgf7uBiixX35ClkJU1zfjNO/2OGSKdGMUQeXLu4ACZMBI6w
	 x3MkNgXpztahPSTeJwssquBK6ZGPfRBJlKR5apeRUftPtvrHIlUkSR+SmXfckjA7ee
	 qqKrQz/azcyMKfi14o/Y3L7FCPUkU4vdp+HKyiAKW2XIcxLNHTAQ01TMp2AuibLir8
	 dR9hlLVMJuGpg==
Date: Thu, 31 Oct 2024 19:22:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: chemical: bme680: use s16 variable for temp
 value to avoid casting
Message-ID: <20241031192200.649a0ea1@jic23-huawei>
In-Reply-To: <20241030235424.214935-2-vassilisamir@gmail.com>
References: <20241030235424.214935-1-vassilisamir@gmail.com>
	<20241030235424.214935-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 00:54:24 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Use local s16 variable for the temperature channel to avoid casting it
> later before passing it to the bme680_read_temp() function. This way,
> possible endianness and initialization issues are avoided.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Applied.

> ---
>  drivers/iio/chemical/bme680_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 871921d81e70..6d11f9188367 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -741,6 +741,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct bme680_data *data = iio_priv(indio_dev);
>  	int chan_val, ret;
> +	s16 temp_chan_val;
>  
>  	guard(mutex)(&data->lock);
>  
> @@ -757,11 +758,11 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			ret = bme680_read_temp(data, (s16 *)&chan_val);
> +			ret = bme680_read_temp(data, &temp_chan_val);
>  			if (ret)
>  				return ret;
>  
> -			*val = chan_val * 10;
> +			*val = temp_chan_val * 10;
>  			return IIO_VAL_INT;
>  		case IIO_PRESSURE:
>  			ret = bme680_read_press(data, &chan_val);


