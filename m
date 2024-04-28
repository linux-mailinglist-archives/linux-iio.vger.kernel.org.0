Return-Path: <linux-iio+bounces-4574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70E8B4C03
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E079128157C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81842AA3;
	Sun, 28 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssj8or9w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06E1E534
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311626; cv=none; b=CyEHuJPg8jQNueWtcz12QwEDRp+07YYAJhBNbcay+4G6elMDytVK3Dcq80Ld6VJonNPrUHMwxAJp9V8lk5MCnUj0AgY1oN7TqMROSb2g6Q/6SfHuDmdsTkmPiG6EqB7m1Jdw5kbNbAVNntfP7m3gPBXkbShDzQMeR/sAkLSgMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311626; c=relaxed/simple;
	bh=VvLWyiBVgY9sM1vVOn7SgYyNoJ8xd5Nyy0rY8D0vWLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXh/9LnTqkcuXTPKq8oZvBdU+Zww6aaf6V+KZjhb2Z7sVMZyH9mcJDKSKsOLn5n7ZPzuhCuo9p4fcNOD0ZmXfCLzEgT3yLW2aoK8PWES7IGVANwm1bPZZ7Kg5M3z9Ooqna2f0woKd8OZe2+MXvEnbNCv6lKjRf6DEMU6V5qBfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssj8or9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDE4C113CC;
	Sun, 28 Apr 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714311626;
	bh=VvLWyiBVgY9sM1vVOn7SgYyNoJ8xd5Nyy0rY8D0vWLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ssj8or9wyZsq4IwPIe9ZN4OnyzAqRuo3rgNeMQ1gyLJJhT/8lJ2RmjXQbz1qbtoPo
	 hP3LTlBx7XTY16BxwMmx9RKH1sf5q9pBEsdVW0OV2BZ8NExHJS9yxFmIjc4sX2Qaxi
	 x00EueYOXSGEGPXoyc0mY6FSX2nSKqpJIjB+xGLAmGLoLBHqXIRglMCrb8Pj+t5tTY
	 cnMj5EqgvOUiVQEkx4/KhGQKbdTIXlcz1dXFY6utFo+gqelA0F0KBtJQ6jhyLmFa5a
	 haFibnf3xdJ4w+JRiXVS9FaDngYipqHXwG7eCZNHGgrw6T6te5R7iKEDERaJZtG1Vz
	 WVm3bFwNGOHoA==
Date: Sun, 28 Apr 2024 14:40:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adam Rizkalla <ajarizzo@gmail.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Angel
 Iglesias <ang.iglesiasg@gmail.com>
Subject: Re: [PATCH] iio: pressure: bmp280: Fix BMP580 temperature reading
Message-ID: <20240428144015.4f0e6681@jic23-huawei>
In-Reply-To: <Zin2udkXRD0+GrML@adam-asahi.lan>
References: <Zin2udkXRD0+GrML@adam-asahi.lan>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 01:22:49 -0500
Adam Rizkalla <ajarizzo@gmail.com> wrote:

> Fix overflow issue when storing BMP580 temperature reading and
> properly preserve sign of 24-bit data.
> 
> Signed-off-by: Adam Rizkalla <ajarizzo@gmail.com>
Hi Adam,

Looks like a correct fix to me, but leaving on list a little longer
for Angel to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe8734468ed3..e79c9715bb28 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1393,12 +1393,12 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
>  
>  	/*
>  	 * Temperature is returned in Celsius degrees in fractional
> -	 * form down 2^16. We rescale by x1000 to return milli Celsius
> -	 * to respect IIO ABI.
> +	 * form down 2^16. We rescale by x1000 to return millidegrees
> +	 * Celsius to respect IIO ABI.
>  	 */
> -	*val = raw_temp * 1000;
> -	*val2 = 16;
> -	return IIO_VAL_FRACTIONAL_LOG2;
> +	raw_temp = sign_extend32(raw_temp, 23);
> +	*val = ((s64)raw_temp * 1000) / (1 << 16);
> +	return IIO_VAL_INT;
>  }
>  
>  static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)


