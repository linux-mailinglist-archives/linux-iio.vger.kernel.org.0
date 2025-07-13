Return-Path: <linux-iio+bounces-21607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95CB03155
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202CE17BB9F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66538202F9C;
	Sun, 13 Jul 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPBIczLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E113AA20;
	Sun, 13 Jul 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415493; cv=none; b=lO+Jjhb7ySdpfQxwZ3Dr+ERSq855+GMG7kx5end14g2tCxxZ58abz4xqf63EH8W+clFTyCoO/mtbnpbyKlngYvZ5jC9uAT2EBA6r3jxP3dyCIKq0I7aUi9mi5wNl0oZ3ubQj3j4wC0h6TQCvEI0LkR8UdtGZpIv+mj0MlZ0abPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415493; c=relaxed/simple;
	bh=+FYv13QyM3Qc66a/klwxzfTKs0B5TwplrY1FdwFpn+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAWSj11xfkxyH4p9gPYhtFcb4QXqyqVVGCTFMShVQBex6tMD/xz/KMwO81Xs7/U49dwXZBJ+i3yGh0xO4c10sbFJQrsgISJpXKxISonr0cA86YvJsnUW5SjkCa6TjSU90RVLJ3WU2SlD1DRc7hYUgemxw9SQx1VnSc/XpueK/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPBIczLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55948C4CEE3;
	Sun, 13 Jul 2025 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415492;
	bh=+FYv13QyM3Qc66a/klwxzfTKs0B5TwplrY1FdwFpn+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uPBIczLihuHl1PbCKDG/eOKxiBo2dGDuuxa8fklhbfkhN2KYTaqTkesvF0tMlpHtJ
	 kMLMbTDXVWUwRiQvgCIXeSz2T2+BGNt1PGcF6Eqa4011hZjxd/zs2qPr961OxQqbJx
	 fEY3eMPTK+FN+McuD1h+Me5KJFWm8NUib/kL8o5uWukAGxRV3eBk7IiCjB12a5xdhC
	 /FhEb9B8h1mrFD5FArtgxGGY44jdwx4l8T1R86LTt3bKPUENS/292jsZDozpHV/kxl
	 WoItoPIA7Z/+/pmXeYiQpV3zdwHtOm3+MB8xwRFtmd0fc8QhTpTocQLTlX/6RZAVp4
	 Mcv3QBaKvq8Vg==
Date: Sun, 13 Jul 2025 15:04:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: isl29501: use scan struct instead of
 array
Message-ID: <20250713150445.3965931c@jic23-huawei>
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:18:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Replace the scan buffer array with a struct that contains a single u32
> for the data and an aligned_s64 for the timestamp. This makes it easier
> to see the intended layout of the buffer and avoids the need to manually
> calculate the number of extra elements needed for an aligned timestamp.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Why are we using a u32 here?  It's a 16 bit
read in that isl29501_register_read() call
and storagebits = 16 in the chan spec.

So to me looks like you found a bug for big endian platforms.
> ---
>  drivers/iio/proximity/isl29501.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> index d1510fe2405088adc0998e28aa9f36e0186fafae..0eed14f66ab700473af10414b25a56458335b381 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -938,12 +938,15 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct isl29501_private *isl29501 = iio_priv(indio_dev);
>  	const unsigned long *active_mask = indio_dev->active_scan_mask;
> -	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
> +	struct {
> +		u32 data;
> +		aligned_s64 ts;
> +	} scan;
>  
>  	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
> -		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
> +		isl29501_register_read(isl29501, REG_DISTANCE, &scan.data);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
> 
> Best regards,


