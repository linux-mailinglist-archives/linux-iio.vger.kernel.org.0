Return-Path: <linux-iio+bounces-4962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF38C31BA
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBACCB20F74
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E65339D;
	Sat, 11 May 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnPAO4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3C53373;
	Sat, 11 May 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436179; cv=none; b=nfeF/Pj6zXaLwz+9lGjMVjeUsbQ4CTWKRDT5m+0ecTrdOeIIedz49pdeRj4kakMnp4A3Y5/l1nlAUpEeXPEeMxOMnFmEqgpjk59ezNWybtcWyRBzwUNdPzcacZmgREsy52FTKsIke+aoRlIQTBfHm9tSf1RYVNoT4AeS1iDUW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436179; c=relaxed/simple;
	bh=KfW1rOY3mEYWH/WH5+wtO4RDSJth0BxELiZwxso/nB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMa/dITLIzjJQwe/Y1qWTK4jl3d0Q4rYdAxV5FlNkGJnaiX6egpVUZ7Bc2d7LuFgUzpW1T8FzZ0NrRGf3eowCD9Tz+9nxjUazyzUZ+qlc4LHUmGK/4gohjMBaL3VVxmdwOMUWbXcY1KdaR5np5Lue9UJXKj/uKGTXTRQ2Cb/8cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnPAO4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DDFC2BBFC;
	Sat, 11 May 2024 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715436178;
	bh=KfW1rOY3mEYWH/WH5+wtO4RDSJth0BxELiZwxso/nB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERnPAO4K4JiZyUiLCyZt/YJIP/0RMtB7Yqhi/gig6TfMXqws/MYjAcxCLKwAHuMrg
	 CL1q4+5yCviRhTy5KUDmo2BjSR3et8V2mK+dz2tbDQSJgNrC2j1tvJv7re5Y8uHxxR
	 CMuPE8Sbz8EoXjCWQNOhBFdWxPBcF2AuEcf54OAZVM6xJq4NmqEwotoHZzhY5c649A
	 8CgVmmcoxbgftxkOYJO+u5S7Pn/E2P3w1yINu7ZO4v/YPY9yXjPXRwTBCtLzSalyWS
	 +EPzEgCt1VlXxxKVv7RmtHaEVgg/VCxNnYsk5QIVFSzedg3mK75KaoyhmTv/qoKd6V
	 Svp9LZmh75wsw==
Date: Sat, 11 May 2024 15:02:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, jagathjog1996@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: Fix trigger notification in case of
 error
Message-ID: <20240511150247.07a06f6a@jic23-huawei>
In-Reply-To: <20240508155407.139805-1-vassilisamir@gmail.com>
References: <20240508155407.139805-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 17:54:07 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> In case of error in the bmi323_trigger_handler() function, the
> function exits without calling the iio_trigger_notify_done()
> which is responsible for informing the attached trigger that
> the process is done and in case there is a .reenable(), to
> call it.
> 
> Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
I've applied this to a temporary fixes-for-6.10-rc1 that will get rebased
on top of an update char-misc-linus once the Linus picks up a pull request
from Greg during the coming merge window.

I've done this for other patches that may be dependent on stuff that is
only in char-misc-next.

Jonathan


> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 5d42ab9b176a..67d74a1a1b26 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -1391,7 +1391,7 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
>  				       &data->buffer.channels,
>  				       ARRAY_SIZE(data->buffer.channels));
>  		if (ret)
> -			return IRQ_NONE;
> +			goto out;
>  	} else {
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 BMI323_CHAN_MAX) {
> @@ -1400,13 +1400,14 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
>  					      &data->buffer.channels[index++],
>  					      BMI323_BYTES_PER_SAMPLE);
>  			if (ret)
> -				return IRQ_NONE;
> +				goto out;
>  		}
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
> +out:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803


