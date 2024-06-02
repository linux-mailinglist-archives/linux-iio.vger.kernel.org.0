Return-Path: <linux-iio+bounces-5603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA88D74CF
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9311F210DD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5821376E9;
	Sun,  2 Jun 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6Ic5bkQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129863B8;
	Sun,  2 Jun 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717325928; cv=none; b=dtelx1gk6APVXLF8uwbD8wRswZ1JANizTkCQRGqFxAX1OKiOJm5eoG20H1plP+O99EZlned20GARbd0zIb1OrJJsUVklOgglMk4ynhDQQ7+yxJV6wu7jhimwBnAKNDwTxgzn+HKvCaVuYgL+0gXIZwkrEHIemkSENDbAarrVgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717325928; c=relaxed/simple;
	bh=edmopG2nKKEj3s8G6DghlmkQQsp68ky39kA51QfZ4uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvoFj/x8YSpB+RQUHSUKHTwy0gVsFbSnvwwj+0Q0ADfvE2Ai0bp66o3kgJx/Zqulv3r/mP0ReacodpAEgTr/qwq6sW9W65BzVrvQYFNUEh8zFikxlXMQr6lnYH604K/q1+CzkkBIcEa9OqjEYUQ3fxbzP4QmSHaNoJ5Wa5RsSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6Ic5bkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895F7C2BBFC;
	Sun,  2 Jun 2024 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717325928;
	bh=edmopG2nKKEj3s8G6DghlmkQQsp68ky39kA51QfZ4uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6Ic5bkQhfvl2qlAclUmPaJa8iHDLIPs7JqjcICWvuJwQ5paNd6Vjqhgm7l4Flx41
	 FEXwFQtzNh+E9xZ1bQv9i92jhdd6NUKyWr9MuwlcXk1Pzs2ZXlzZ5+54hMMxGc6LAv
	 6fSAGKJ1Uk9gdGh4CRv88lPWUS9MRjA/Z1yg37NozeIJ206EhelGAG0T2sgnAaca+x
	 sFMKpnqs2NEiS2nc/1ha8vnD1VHZKyqsYK3/V3MuOxRlqO9bVzKuXjy9KgX5aaaKup
	 4OrSjj8avHkX3XJPh/IbSs7oT/9slPRnaODyQuYdR92Z707n6OeGggyX8i6SsPNqYH
	 NZiCO4/7E0JcA==
Date: Sun, 2 Jun 2024 11:58:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: stabilized timestamp in
 interrupt
Message-ID: <20240602115836.43066c41@jic23-huawei>
In-Reply-To: <20240529154717.651863-1-inv.git-commit@tdk.com>
References: <20240529154717.651863-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 15:47:17 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Use IRQ_ONESHOT flag to ensure the timestamp is not updated in the
IRQF_ONESHOT

I fixed that up whilst applying.
> hard handler during the thread handler. And compute and use the
> effective watermark value that correspond to this first timestamp.
> 
> This way we can ensure the timestamp is always corresponding to the
> value used by the timestamping mechanism. Otherwise, it is possible
> that between FIFO count read and FIFO processing the timestamp is
> overwritten in the hard handler.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git

Jonathan

> ---
>  .../imu/inv_icm42600/inv_icm42600_buffer.c    | 19 +++++++++++++++++--
>  .../imu/inv_icm42600/inv_icm42600_buffer.h    |  2 ++
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 63b85ec88c13..a8cf74c84c3c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -222,10 +222,15 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>  	latency_accel = period_accel * wm_accel;
>  
>  	/* 0 value for watermark means that the sensor is turned off */
> +	if (wm_gyro == 0 && wm_accel == 0)
> +		return 0;
> +
>  	if (latency_gyro == 0) {
>  		watermark = wm_accel;
> +		st->fifo.watermark.eff_accel = wm_accel;
>  	} else if (latency_accel == 0) {
>  		watermark = wm_gyro;
> +		st->fifo.watermark.eff_gyro = wm_gyro;
>  	} else {
>  		/* compute the smallest latency that is a multiple of both */
>  		if (latency_gyro <= latency_accel)
> @@ -241,6 +246,13 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
>  		watermark = latency / period;
>  		if (watermark < 1)
>  			watermark = 1;
> +		/* update effective watermark */
> +		st->fifo.watermark.eff_gyro = latency / period_gyro;
> +		if (st->fifo.watermark.eff_gyro < 1)
> +			st->fifo.watermark.eff_gyro = 1;
> +		st->fifo.watermark.eff_accel = latency / period_accel;
> +		if (st->fifo.watermark.eff_accel < 1)
> +			st->fifo.watermark.eff_accel = 1;
>  	}
>  
>  	/* compute watermark value in bytes */
> @@ -514,7 +526,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  	/* handle gyroscope timestamp and FIFO data parsing */
>  	if (st->fifo.nb.gyro > 0) {
>  		ts = &gyro_st->ts;
> -		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.gyro,
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_gyro,
>  						st->timestamp.gyro);
>  		ret = inv_icm42600_gyro_parse_fifo(st->indio_gyro);
>  		if (ret)
> @@ -524,7 +536,7 @@ int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
>  	/* handle accelerometer timestamp and FIFO data parsing */
>  	if (st->fifo.nb.accel > 0) {
>  		ts = &accel_st->ts;
> -		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel,
> +		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
>  						st->timestamp.accel);
>  		ret = inv_icm42600_accel_parse_fifo(st->indio_accel);
>  		if (ret)
> @@ -577,6 +589,9 @@ int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
>  	unsigned int val;
>  	int ret;
>  
> +	st->fifo.watermark.eff_gyro = 1;
> +	st->fifo.watermark.eff_accel = 1;
> +
>  	/*
>  	 * Default FIFO configuration (bits 7 to 5)
>  	 * - use invalid value
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> index 8b85ee333bf8..f6c85daf42b0 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> @@ -32,6 +32,8 @@ struct inv_icm42600_fifo {
>  	struct {
>  		unsigned int gyro;
>  		unsigned int accel;
> +		unsigned int eff_gyro;
> +		unsigned int eff_accel;
>  	} watermark;
>  	size_t count;
>  	struct {
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 96116a68ab29..62fdae530334 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -537,6 +537,7 @@ static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
>  	if (ret)
>  		return ret;
>  
> +	irq_type |= IRQF_ONESHOT;
>  	return devm_request_threaded_irq(dev, irq, inv_icm42600_irq_timestamp,
>  					 inv_icm42600_irq_handler, irq_type,
>  					 "inv_icm42600", st);


