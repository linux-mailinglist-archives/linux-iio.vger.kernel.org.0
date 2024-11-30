Return-Path: <linux-iio+bounces-12899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD479DF32B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED64B20F91
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07AE1AAE1A;
	Sat, 30 Nov 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvDKwViU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E891AA1CD;
	Sat, 30 Nov 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999977; cv=none; b=ZpIP4bJZTrFdPgxSaNTzlGQo/BNh4kIrvlV+9VZgwa4SwZIk54UKmXlT+4vB2GpEDreWG7Rum6etIdR3CZ8EW9O+Z5uwD4qi0mDVRfsI82Pmb3PIkfdo10GMWxB+e5BpAMmLm3ekwE5L4CArxyiVpxbFEOqjUTWtNblH8vdIZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999977; c=relaxed/simple;
	bh=NJdHgflC2NKTlcdODsmVPYVC7PaaKkCbhNPvkoeOhEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj+ji+ks7SSrLqHA64C/6b5tfSqAJZ8LQcl3tbXLQdGFbniXtfCMCQYHew3QwlBC/wHJDQ24TUlvbxyqnlxJ7oIpPYAy/JFUPvvtr4iR2ieuHAIrISfYqnBDTJ47j2pkQMwm9XqI0+a1RPaxZjKZF00hQAyPpoLnMMMhRmBoLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvDKwViU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB914C4CECC;
	Sat, 30 Nov 2024 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999977;
	bh=NJdHgflC2NKTlcdODsmVPYVC7PaaKkCbhNPvkoeOhEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvDKwViUENU1P9S5Ed/dB0FxNemFHwBnTCzuX7hopQk3apMlcL9SPcwD6t05uDCLO
	 NsjokIpwbZkeEOBQHlqEz1ULj0HW/lesZbddLP5RzX77s8cvb5mAc8Mn91wmGawdWV
	 H8F50+v3Im7hKESy3Tirw3jMy/i1M8rXjDO9FqAx6HrqatfMqotVTQDafcf1jZ9wJJ
	 QamkVzU3t8dhHmvdui4tv33pveVY1Oqy8HqF8g6F1MC/0mtrgnofB3zRnrZ0cNfa3v
	 4Lwx0A52QtO/buOf9Uqs4QEFRYrmn0u19sFKh1K+FJ2krHVgjj/+F90G2mkDHkIOOv
	 b+oEjPE21HhpA==
Date: Sat, 30 Nov 2024 20:52:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH 08/11] iio: adc: ti-ads8688: fix information leak in
 triggered buffer
Message-ID: <20241130205247.47780c89@jic23-huawei>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-8-0cb6e98d895c@gmail.com>
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
	<20241125-iio_memset_scan_holes-v1-8-0cb6e98d895c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 22:16:16 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'buffer' local array is used to push data to user space from a
> triggered buffer, but it does not set values for inactive channels, as
> it only uses iio_for_each_active_channel() to assign new values.
> 
> Initialize the array to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 61fa5dfa5f52 ("iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.
> ---
>  drivers/iio/adc/ti-ads8688.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 9b1814f1965a..a31658b760a4 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -381,7 +381,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	/* Ensure naturally aligned timestamp */
> -	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
> +	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8) = { };
>  	int i, j = 0;
>  
>  	iio_for_each_active_channel(indio_dev, i) {
> 


