Return-Path: <linux-iio+bounces-8943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E4967706
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6223F1F2173B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B48181317;
	Sun,  1 Sep 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0eL2dQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862E14A4FF;
	Sun,  1 Sep 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725199916; cv=none; b=KZ4S0kGULB+8nr0gCyddpXJ9vLrAECT8Nn4AyEooURIN7K8+D5iVwpiWg4+zKL9m9VuN9J4RA1W0yGIsS1HkbzkXqL+NfqGejADVLovGxm/1hJSt1y7TVR06HfdknENOUFKBXcYHQ5syPuJv1U9jEZ4bJwWODu2jgH5PAyEW07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725199916; c=relaxed/simple;
	bh=3H4i0cRPu+Vs153nk1TgyG+ojiCviPxu3EpTq+9mrLc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC0EKZClXzL67GhSqqFHs3FGfpwA9B70zfJr10atV3opwoGnMa7DcljaXNw02qEJ3smx7vl6l7WFtVZ9yJFnU/dJux/NviDhHBJEAJY8A5vpoXhWlfY4uSk7kHLF+j7ul14+r9ze73tTYB30FIXu+esMR9XBC4LxrdvSLqYPLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0eL2dQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A0C4CEC3;
	Sun,  1 Sep 2024 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725199916;
	bh=3H4i0cRPu+Vs153nk1TgyG+ojiCviPxu3EpTq+9mrLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0eL2dQgetZrGSNDzj26UTUYLSaN4XgMfDfzJ39n3+xyZeELt15faKx1c3YJGjEBM
	 5IORkGltO9AT0cxKVHHCBN5MAQ47C2SDk3gc9T39rbeZ5oE7QPEdFr/EQwKcBBDtW4
	 TPMXvirPhrfsvi5o35Z8q6ZfZe1SD8c96MzKS0pwtLoL7UDZvZANT6plKSQSgA8n2s
	 r994HsbhZbAF62im0GTa06VA2Dpem1PAzFrWesc3pap0Qrms2yvIyJgNBi/g2LuNKY
	 ezxYcGuGv4ysgmcFCXaKZiDzpg9L4lvqCWyvzqdaiSw7pY3+gq0H5Ytq6SnyWA4MNk
	 ouXDcv1jlJRgQ==
Date: Sun, 1 Sep 2024 15:11:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: lars@metafoo.de, jean-baptiste.maneyrol@tdk.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between
 labels
Message-ID: <20240901151150.77074133@jic23-huawei>
In-Reply-To: <20240901120839.9274-1-gye976@gmail.com>
References: <20240901120839.9274-1-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Sep 2024 21:08:39 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> 'flush_fifo' label performs same task as 'endsession' label
> immediately after calling 'env_reset_fifo' function.
> So i remove that duplication.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Ok. This doesn't greatly affect readability and the code
ends up a bit shorter.

Applied

Jonathan

> ---
> I worked on the wrong branch in v1, and reworked on the latest branch.
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 3d3b27f28c9d..4753016d6ee0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -121,15 +121,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
>  	}
>  
> -end_session:
> -	mutex_unlock(&st->lock);
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;
>  
>  flush_fifo:
>  	/* Flush HW and SW FIFOs. */
>  	inv_reset_fifo(indio_dev);
> +
> +end_session:
>  	mutex_unlock(&st->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  


