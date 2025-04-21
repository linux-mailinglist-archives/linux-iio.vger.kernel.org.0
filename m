Return-Path: <linux-iio+bounces-18457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF08A95272
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FAB3A87E7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CA64A8F;
	Mon, 21 Apr 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSRS0ar7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9121770FE;
	Mon, 21 Apr 2025 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244337; cv=none; b=EHG+Bb4HkLmusoeIPBjUeDHIanM+3AW9JO4ofckzHGHioYslm4xwCCRpQ9gLgE3W+/8ny/UpzIMUmgeJbyzj8Yo/l9jhm/IOmuP4kuKcWkiRGIvzp0D4f8nl/+Sqa4tE5P/QnpCBNeFnl2bb0uKCj/6GwBq8CC7r/WotE9vAjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244337; c=relaxed/simple;
	bh=rnmnAG8BImf0XNJhy1LVT5Y3AaNUQMi5NOwLSRLyoeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDR9cQ6nmlMYYAirxVE9IzRhncHIY0M86NZKfd6KsSjoV8FbTnycIS2O3V0lR/gS5deHpQZDVFYU8ExUM431R8ZfBxrDbLIErBIHrgyN3af6omUe59Hx2wnUGu7y77Lp/wHJ95HvVX2lEYC/yuv9nEZYhxW7JUwyOOnqph/W328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSRS0ar7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9528AC4CEE4;
	Mon, 21 Apr 2025 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745244336;
	bh=rnmnAG8BImf0XNJhy1LVT5Y3AaNUQMi5NOwLSRLyoeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSRS0ar74bDsV1wm2D0qCSKOLKlNuFTS0+Nh50rqDZOfwJKTY7ocVXxjuv6j0fzYB
	 EKY62rcug4s6j2gtMka8sEcOIhxIvEWNcUGR9nJxNqA7R392+yYIQ40r7bKTSw0wSX
	 j49sUIk8WSMDs135sJRNvsH6WGU5Um7MTZuchxA74Pzejuwr8lPGKGlICSuGkO+xEC
	 FF9VZm9JNDm299tcKkrW8QnfQTC3h+vL7m61uA23EuyIeMvgsnXUxmBbepJ4I5MvoF
	 r3e4wEU/X+MnFIr8nT6cmNTxwtCwVvW0MnXXnTsEiVk0ux8JZODzsgbKxvQw07zFDU
	 LwQzrF9vvCBLA==
Date: Mon, 21 Apr 2025 15:05:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@suse.de, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adis16201: Use IIO_VAL_INT for temperature
 scale
Message-ID: <20250421150451.118e9c95@jic23-huawei>
In-Reply-To: <20250421122819.907735-1-gshahrouzi@gmail.com>
References: <20250421122819.907735-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 08:28:19 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> This is a leftover from the patch: commit cf96ffd8c2ed
> ("staging:iio:accel:adis16201 move to chan_spec based setup.").
> Initially *val = 0 and *val2 = -470000.  However, they were later
> changed to -470 and 0 respectively but their return type was not
> updated.
> 
> Use correct type as -470 is an integer in the base units.

It's not a fix as such. 

We'll get a string that is -470.000000
 
There was no need to print the .000000 but it also does no harm and
generic userspace will always treat this as a float anyway as most
scale values are.

I don't mind this as a minor improvement patch however.
One comment inline.

Jonathan



> 
> Fixes: cf96ffd8c2ed ("staging:iio:accel:adis16201 move to chan_spec based setup.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index dcc8d9f2ee0f1..1f27386edcc4e 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -125,7 +125,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		case IIO_TEMP:
>  			*val = -470;
>  			*val2 = 0;
If we are returning IIO_VAL_INT there is no need to set *val2 as it
is never used.


> -			return IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_VAL_INT;
>  		case IIO_ACCEL:
>  			/*
>  			 * IIO base unit for sensitivity of accelerometer


