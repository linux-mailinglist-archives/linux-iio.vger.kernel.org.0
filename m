Return-Path: <linux-iio+bounces-15599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D308A37643
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE2B3B0D8B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F119D07A;
	Sun, 16 Feb 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPpvNsNK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678C18DB21;
	Sun, 16 Feb 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726598; cv=none; b=jo5OsPcbfeIxk10R5R1hhse/1pgXm6YSuXfZlV5mCVfpqr+wCKk/ejYzK2kqKStLprW2yuUQeOjLOLHU94Sn5wS5/p7h3fQgY4KcIPbv3ncw0w1HMj8wma2Q8elAV7GVDftz1pIz3N7FVLtiyouOKyVy12E3kii3rCrcbmNc2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726598; c=relaxed/simple;
	bh=EzkwvjYBF/gF4oH+KNyU4qu6XNtV5u8kaYcnXPP9HrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCjHcxQPidWS1b0dBzT72aS4cMyUUD0Nk10kciVumglA5h0Ast1LWyehqwj16x4ak0/7N+MEqGrolI4kl9ukhAIy2j6ZojCjLjxwycBSwmfn6exzcAqiuQJTQasagvXnsSoiSrc5+8acFU0wVQirhMjDdHmA44fIVCxKQ4Pva5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPpvNsNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85ACC4CEDD;
	Sun, 16 Feb 2025 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739726597;
	bh=EzkwvjYBF/gF4oH+KNyU4qu6XNtV5u8kaYcnXPP9HrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gPpvNsNKE7F8OwKbdbK9Trx/TUjYk9tYqTPzGeVodBsyb3s9DX8E7NEYN0G5487kJ
	 gRvEBWKavlbdYVZ+xpudmLH/ppMOwWbacAUPr0m0Q+CElZK2TWBW0f68VzNJTaX/lg
	 ruBOwRVSrq9miTOZB/XftfX70MJSpaE2rqkntTgvgMQQwC4KGJwMvfOCLlDLkDjg6/
	 z5GuAjVwnatWIQIFsNIvJRRyZnKPMFtXi7u6Wp0+A5NHF3ljsNjP2ehQZGR3uvuFsA
	 QoI66oQqE9Ltgv4BtcOZ7H86xaBHWVRoTDM/ZjckrLi/522G7a3SwPXAQ58o7L+HhM
	 Pi73jBq29hi4Q==
Date: Sun, 16 Feb 2025 17:23:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 06/14] iio: accel: adxl345: add double tap feature
Message-ID: <20250216172309.6c57d160@jic23-huawei>
In-Reply-To: <20250210110119.260858-7-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:11 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the double tap feature of the sensor. The interrupt handler needs
> to catch and forward the event to the IIO channel. The single tap
> implementation now is extended to deal with double tap as well.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 102 ++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 304147a4ca60..cf35a8f9f432 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -46,17 +46,23 @@ enum adxl345_axis {
>  /* single/double tap */
>  enum adxl345_tap_type {
>  	ADXL345_SINGLE_TAP,
> +	ADXL345_DOUBLE_TAP,
>  };
>  
>  static const unsigned int adxl345_tap_int_reg[2] = {

Ah. Here comes the rest.  Just use [] so no need to update.
This size should only matter the other way around where you
are doing an ARRAY_SIZE() or similar (might not even need that!)

>  	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
> +	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
>  };
>  
>  enum adxl345_tap_time_type {
> +	ADXL345_TAP_TIME_LATENT,
> +	ADXL345_TAP_TIME_WINDOW,
>  	ADXL345_TAP_TIME_DUR,
>  };
>  
>  static const unsigned int adxl345_tap_time_reg[3] = {
> +	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
> +	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
>  	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
>  };
>  
> @@ -73,6 +79,8 @@ struct adxl345_state {
>  	u32 tap_axis_ctrl;
>  	u8 tap_threshold;
>  	u32 tap_duration_us;
> +	u32 tap_latent_us;
> +	u32 tap_window_us;
>  
>  	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -86,6 +94,14 @@ static struct iio_event_spec adxl345_events[] = {
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>  			BIT(IIO_EV_INFO_TIMEOUT),
>  	},
> +	{
> +		/* double tap */

Kind of obvious comment given the dir, so could just not mention it.

> +		.type = IIO_EV_TYPE_GESTURE,
> +		.dir = IIO_EV_DIR_DOUBLETAP,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> +			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> +	},
>  };

> +

