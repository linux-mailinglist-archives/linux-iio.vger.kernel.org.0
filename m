Return-Path: <linux-iio+bounces-20646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF2AD9CC1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C2D3B9EA3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28AE2C15BD;
	Sat, 14 Jun 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN1rwov5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7C1DFE8;
	Sat, 14 Jun 2025 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749905591; cv=none; b=cJVgLq/Tfj+SvnVOfs9smAp+KHiHo8ok1ql7Ise66ytIlQozveA2VV/Qedn1WBaejpr/On5Il5v2XDfmGYREmKlhIzCKrlrKXXu2D1gYKbvGLeNJQs11w2fKnNnTKObT9dymRKOD3iJdVYz5Jo03UxdBJnDhaNKPrLa8XlGF5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749905591; c=relaxed/simple;
	bh=abuQZ93iaFL1AULcyejhgQhhpoyGapLheFtvQkM1BR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsGFeRTKufcrzesdL5jItMbDzRcs6z9zNKbAFYUKG/gqqFRaVJdeNr2ZDlLDWqZkyw8cshwCi5mKPKh4egXAPbePhfZ4C2NXtq/opUF5vr0H2WvrfbeO/H+WholxTr0fgFEwUx3n3gvBEfVIQfUerYcaIUXLJ9TR0XQqo53CyK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN1rwov5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE42C4CEEB;
	Sat, 14 Jun 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749905591;
	bh=abuQZ93iaFL1AULcyejhgQhhpoyGapLheFtvQkM1BR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lN1rwov5+L6UUPH7KKgjPcA1xyBL/EKyGz3OLgzDqzgJNv3qqa2929Ou/AizkXQ8H
	 TXYnV9J6EgXHSx2TMHEIbtOfi4jsnVuZyCPG62Vlh4aScs5qR5B5RoGmMfyYt+5wDf
	 yr3QCAuv1n93juC8P5q/6F1NkMaHcCLN3k9XC6MrkQBk6Lbxdq1L0L08ITH2R8kk9d
	 r0Rf+Lk4YRoSM4dqA7St4+p/m2wX/u+v8f6nniCxwLCnCgolC0q36g7T4JERFzxEJP
	 FZnQyKtF/a0NKG4ZYlcFZRgMFMfdzHB8MxcezTmCqiUS7Fa5q8KXhsNoWNsljmiTAK
	 8a/nRqXSRf/2w==
Date: Sat, 14 Jun 2025 13:53:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250614135304.10d0fee9@jic23-huawei>
In-Reply-To: <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
	<20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 09:34:26 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM as accel roc rising x|y|z event.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste.

A couple of comments inline.
Ideally pull the movement of the timestamp struct to before the DMA safe
buffers to a precursor patch.   That is a bit subtle to have hiding in here.

The guards thing can be for next time you are doing a cleanup series on this
driver if you prefer.

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  54 +++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 289 ++++++++++++++++++++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  58 +++++
>  4 files changed, 395 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index f893dbe6996506a33eb5d3be47e6765a923665c9..413a15493bcb880dc00b20da3b3168d5addd32a9 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -135,6 +135,14 @@ struct inv_icm42600_suspended {
>  	bool temp;
>  };
>  
> +struct inv_icm42600_apex {
> +	unsigned int on;
> +	struct {
> +		uint64_t value;
> +		bool enable;
> +	} wom;
> +};
> +
>  /**
>   *  struct inv_icm42600_state - driver state variables
>   *  @lock:		lock for serializing multiple registers access.
> @@ -148,9 +156,10 @@ struct inv_icm42600_suspended {
>   *  @suspended:		suspended sensors configuration.
>   *  @indio_gyro:	gyroscope IIO device.
>   *  @indio_accel:	accelerometer IIO device.
> - *  @buffer:		data transfer buffer aligned for DMA.
> - *  @fifo:		FIFO management structure.
>   *  @timestamp:		interrupt timestamps.
> + *  @apex:		APEX (Advanced Pedometer and Event detection) management
> + *  @fifo:		FIFO management structure.
> + *  @buffer:		data transfer buffer aligned for DMA.
>   */
>  struct inv_icm42600_state {
>  	struct mutex lock;
> @@ -164,12 +173,13 @@ struct inv_icm42600_state {
>  	struct inv_icm42600_suspended suspended;
>  	struct iio_dev *indio_gyro;
>  	struct iio_dev *indio_accel;
> -	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
> -	struct inv_icm42600_fifo fifo;
>  	struct {
>  		int64_t gyro;
>  		int64_t accel;
>  	} timestamp;
This was a bit subtle and had me going for a minute.
The timestamp should never have been at this location in the structure because
it's mid way through various regions with forced alignment.  It isn't actually a bug
I think though (beyond unnecessary padding) because the fifo struct obeyed c spec rule
that anything after it must be aligned to it's largest aligned element which was
IIO_DMA_MINALIGN.

Maybe move this in a precursor patch where you can talk about whether it was a problem
or not?

> +	struct inv_icm42600_apex apex;
> +	struct inv_icm42600_fifo fifo;
> +	uint8_t buffer[3] __aligned(IIO_DMA_MINALIGN);
>  };
>
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index e6cd9dcb0687d19554e63a69dc60f065c58d70ee..9a2089527a9426b70eb796d4e9c234d8804c508b 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c



> @@ -860,6 +911,13 @@ static int inv_icm42600_resume(struct device *dev)
>  	if (ret)
>  		goto out_unlock;
>  
> +	/* restore APEX features */
> +	if (st->apex.wom.enable) {
> +		ret = inv_icm42600_enable_wom(st);
> +		if (ret)
> +			goto out_unlock;

One for another day, but this would definitely benefit from some guard() magic
and there are a few other bits of existing code that would as well.


> +	}
> +
>  	/* restore FIFO data streaming */
>  	if (st->fifo.on) {
>  		inv_sensors_timestamp_reset(&gyro_st->ts);
> 


