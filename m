Return-Path: <linux-iio+bounces-26250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3CC60A29
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862293B9939
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B5302CD8;
	Sat, 15 Nov 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj7XvpJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC771DC997;
	Sat, 15 Nov 2025 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232608; cv=none; b=FIDd3f3ubbZpvwNT2vcc12NmJoHSI9ggbfabzlbMm9hzCvu8v6LLTsogQOryoJDzOEOdnys/9BBIncoNboM6/8NWJ5ooLDDIrGDxVR+b/Lwqudc+A7HeouXJBIlCN5J5TiBSZGEtAmGd6honW8Khi4AW6NO71mNP/TWdGLJZ0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232608; c=relaxed/simple;
	bh=mSE8HFpTSvN7yzT8f1YqABOW1qNupIYA9ec9LR0K20U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KG3AVwyxpG4kZoS1kR7DQOjzey5tuYT/emw+nhs1sZi2b9icKFyZR9knKfNbSdjZ97YkFXcyrabaTI22lhac89RL2vAZUvhF8x1CKhGP3//+uvybH8tOxSSewKh56dUsvhhDYWccdeHBoKvnWcrOu3qKv0V3BuoIi9/mPsN1qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj7XvpJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CA8C4CEF5;
	Sat, 15 Nov 2025 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763232608;
	bh=mSE8HFpTSvN7yzT8f1YqABOW1qNupIYA9ec9LR0K20U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qj7XvpJzI9KzYds0bMS9UVOZq89TUUxNt6OxI+1ATrV+4qQA4WrnG8HmOsmkZhdCK
	 poK7OwfrP1oACWqh8RVWrs3eayOcpPoC5xny23E9cVzOKdDegKUrX/cRd3Z9AKJm9Q
	 VAXat53VgivKTK8NloAobRAafr9XjC7hZdPpNe0FHd1X2KcHvDnOjXf1mGO7+uuEig
	 GTnb3j7kebpS/WxaIuU8AlDs7lMbsdAeiPAhC3PmdgpLjD9IQ7+SwJFWdEnl9hXmz5
	 MXWZXXOCFL1Ih/VFec5qh8EQrrAhcVMfHkaPZwxtOs4MAwKoh9huh04gW+BIuLekiI
	 duQrwUBBx0xuA==
Date: Sat, 15 Nov 2025 18:50:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <20251115185001.01f2b148@jic23-huawei>
In-Reply-To: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
References: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 20:24:36 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The driver code is full of intXX_t and uintXX_t types which is
> not the pattern we use in the IIO subsystem. Switch the driver
> to use kernel internal types for that. No functional changes.
No problem with the change but this description made me think
that this was going to be a huge patch touching lots of instances.

Probably needs a rewrite to not say 'full of' :)
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Jonathan, what is the status of fixing the type for
> iio_push_to_buffers_with_timestamp()? This patch doesn't do that
> as I see no API has been fixed (and it seems the only one that uses
> the *intXX_t parameter).
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 54760d8f92a2..9be5ade24501 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -1209,7 +1209,7 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
>  	ssize_t i, size;
>  	unsigned int no;
>  	const void *accel, *gyro, *timestamp;
> -	const int8_t *temp;
> +	const s8 *temp;
>  	unsigned int odr;
>  	int64_t ts_val;
>  	/* buffer is copied to userspace, zeroing it to avoid any data leak */


