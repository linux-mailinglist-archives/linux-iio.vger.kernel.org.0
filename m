Return-Path: <linux-iio+bounces-3009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3865862602
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783A51F2190E
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1D147A7C;
	Sat, 24 Feb 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJt6ln4+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0072E653;
	Sat, 24 Feb 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708792055; cv=none; b=nHxXM8RYC8VlV+Iu0mjzYUQe1RI3Zu56qBm9aeAgZ3aP+71qGF20zgFDbdzzXKOPPz8+Qa6opCAvTHsq7b4PLDlwoxYzc1P7fpbj4wug+LEKc9DJcXh2sYye+O2eLDxQC74SD4TISTDs93apDgRgq8Z6k7XI/pj0TwpktT30R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708792055; c=relaxed/simple;
	bh=yvwQmfXFaHT1e1P/CfKXVblwVNcWpXfeCqfPApZkPdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGMukBYCeUZ3aEEXkLgOYdfFqhJy0sJtRYBp3aIbenZxH0KCxN/ujakExr1Foq3hL/ifWYvoL++/leJeDBAynm/qpHll5fdYkWtzc+bYBarXZRbwXpmWWt0W319redICli95yuRpieXAXkdvPS5vwDPbI5eYANH6QChI7DKtCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJt6ln4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D608C433F1;
	Sat, 24 Feb 2024 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708792054;
	bh=yvwQmfXFaHT1e1P/CfKXVblwVNcWpXfeCqfPApZkPdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rJt6ln4+KIKxwL/ZB7G9Gy9xwTREhUdBg4Z08Qz08PjsXuN10Q6LNri9XnqhGz1tS
	 2ArDxiLJQhrefsErqTt0KVOvjWcDyqFNKcqstPDJKnY+pu08tcaSjak0BgxL1iOerP
	 H4SKhY70fDWqshEcvpBZMLtYyodkdFaxCMxIIOu2LQuOmLQu4x7vZ/wiDs9qCQ81lU
	 YvZRSzHqjy0WcDY9JWqFHhcdZwnSX594ozp2a6Hnuj3Pyd4soFdounn5XC5XhWp01k
	 LlbBx10qlpaVCr/VKktBar+BYCxbTPn8ImgHD1ZuFafhUc2zvupVHbEueqdtyddmEW
	 6KtTe5KL5/59w==
Date: Sat, 24 Feb 2024 16:27:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix FIFO parsing when empty
Message-ID: <20240224162723.1e41d4ed@jic23-huawei>
In-Reply-To: <20240219154825.90656-1-inv.git-commit@tdk.com>
References: <20240219154825.90656-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 15:48:25 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Now that we are reading the full FIFO in the interrupt handler,
> it is possible to have an emply FIFO since we are still receiving
> 1 interrupt per data. Handle correctly this case instead of having
> an error causing a reset of the FIFO.
> 
> Fixes: 0829edc43e0a ("iio: imu: inv_mpu6050: read the full fifo when processing data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Would have been nice to call out that the error comes from a zero length
read (I think!).

Anyhow, applied to the fixes-togreg branch of iio.git.

I might pull this into my queue for the next merge window as we are getting close
to the end of the cycle.

Jonathan

> ---
> V2: add missing stable tag
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 66d4ba088e70..d4f9b5d8d28d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -109,6 +109,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	/* compute and process only all complete datum */
>  	nb = fifo_count / bytes_per_datum;
>  	fifo_count = nb * bytes_per_datum;
> +	if (nb == 0)
> +		goto end_session;
>  	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
>  	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
>  	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
> --
> 2.34.1
> 


