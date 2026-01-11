Return-Path: <linux-iio+bounces-27621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40230D0F6C4
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E487B303E0C4
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857353033E4;
	Sun, 11 Jan 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGUBS162"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C634C9B5;
	Sun, 11 Jan 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148346; cv=none; b=DDzfpepQ/Xb8UGSpevqbrMvX2QsTMT23Nx3bvAvQRn+QHVc1ihgA1WSbok3hWOLEAHvNXnEvOpVaLxPfjbn+QJHdy5VfFcOlBVfVIDe1BVN2WacdURQHjfeDfH95k5geNPQ9dLnDZflmv/2eQOfOypsW/auWiUyxNOAjPN41gO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148346; c=relaxed/simple;
	bh=e90hf7GZiLLcqRExqe1SHzftQ/RorA9s8ibnGjzJw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jfa4oob35jOw8DSYaAxONoLn7V7e7TkFiFp/ZibqT5YS4JCvDF/3jRyuAB4ANWrb4jpd3gYhdYrxrzhpKd8QddS2SilFFZbJMota4DGMXh9vAC+BBmnWHB27T3ZCrsJ5TrkD+fPeLAc9oWUsHWnUPyHG/CTZwNvXYtOXxL5U/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGUBS162; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C26C4CEF7;
	Sun, 11 Jan 2026 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768148345;
	bh=e90hf7GZiLLcqRExqe1SHzftQ/RorA9s8ibnGjzJw7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGUBS162FWEK003fKUsLS45Mfk1r+ZARXkAJnaj8ddtlYP9kLTAAoRqZFrH79vL9U
	 juOLVQSx2QM1dnLXQCBiyUSkOKuz2PiibnN9RbQnVovXiZT6DGnvmhWMHxfD+1ggRa
	 IKfM4R+acR4JGta9iTT/w8KJpadSiD6QOTsHYbHisLqx4SQ0bgACY2s5x6jC38PXwn
	 /U+R/FrM11cBRNzEhDmXl7W5V4F4w1AqkIIKyfiYeWZeRmYsAcC4P0L8kg84D4l1US
	 Z587RL8m3oVncf9l1nlFC1/b57sVC0x7+PvMCf3c1Oqq52C1Q8AGGEyAZtwAwAeEbQ
	 1y2yB9JXrjf5w==
Date: Sun, 11 Jan 2026 16:18:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency
 for accelerometer only
Message-ID: <20260111161857.4f8b4c35@jic23-huawei>
In-Reply-To: <20260109181528.154127-2-flavra@baylibre.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-2-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 19:15:26 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
> writes the buffer sampling frequency sysfs attribute, calls
> st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> `sensor->id`; since this array is only 2 entries long, an access for any
> sensor type other than accelerometer or gyroscope is an out-of-bounds
> access.
> 
> To prevent userspace from triggering an out-of-bounds array access, and to
> support the only use case for which FIFO sampling frequency values
> different from the sensor sampling frequency may be needed (which is for
> keeping FIFO data rate low while sampling acceleration data at high rates
> for accurate event detection), do not create the buffer sampling frequency
> attribute for sensor types other than the accelerometer.

I'm not following why we need to drop this attribute for the gyroscope.
Perhaps lay out what the combinations of controls are and the attributes
we end up with.

As you note in the cover letter we can change this now with ABI issues as
it is just in my tree, so I don't mind the change, just want to understand
it a little better than I currently do!

> 
> Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 55d877745575..5ac45e6230b5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -858,12 +858,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  	int i, ret;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		const struct iio_dev_attr **attrs;
> +
>  		if (!hw->iio_devs[i])
>  			continue;
>  
> +		/*
> +		 * For the accelerometer, allow setting FIFO sampling frequency
> +		 * values different from the sensor sampling frequency, which
> +		 * may be needed to keep FIFO data rate low while sampling
> +		 * acceleration data at high rates for accurate event detection.
> +		 */
> +		attrs = (i == ST_LSM6DSX_ID_ACC) ? st_lsm6dsx_buffer_attrs : NULL;
>  		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
>  						      &st_lsm6dsx_buffer_ops,
> -						      st_lsm6dsx_buffer_attrs);
> +						      attrs);
>  		if (ret)
>  			return ret;
>  	}


