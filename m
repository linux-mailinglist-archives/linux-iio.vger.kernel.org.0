Return-Path: <linux-iio+bounces-14187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1309A0A910
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D37B3A0FF6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187A1B1D65;
	Sun, 12 Jan 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3W+nn0R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E972A1B2;
	Sun, 12 Jan 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684575; cv=none; b=kWXd6kdBpO7TG7ddV9CWF91CpGkSqMUbPD0DpwT/GjTascUW5sdxEFBeV0HX6UtqCxuTmjn4u/hfNNnnukjfvhFTnvnsQZIFdiL6ScpDlwcIuY/VgjS6Kxi8R/lG2wBrPDJUeC3EXZIbPvZOW6EXLGp3vRxprEDG4IP9MEDVjNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684575; c=relaxed/simple;
	bh=ZG6H6oLVG7h62MhTeYE0o89LwcZAQn3ZwdnRUwiaBMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbcE7xfYxXWF6CcLzbVbbfueEx9+0Uo7jsaFn4gECKRX25VgwVkUvEs4uJ2OPR0MnSlDyx/sfJTeZr8rXt6katdy1VA7jO+2tFm5Mil32+1P94c0A7Gw0ZXYblNheo76yQUNpDlgVLPPZf/d76cCpMVTwoWD6RsyIUIm4UtJRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3W+nn0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6CC4CEDF;
	Sun, 12 Jan 2025 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684574;
	bh=ZG6H6oLVG7h62MhTeYE0o89LwcZAQn3ZwdnRUwiaBMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3W+nn0R9mG4wN2CG5JvvcmFZYnGWq9fQRg7s48sm2RFpM5MqdHWTYwnh4n1IYzEz
	 3R/qGiILCdLdYKKPtF6ufeIgBhyltFJYVXVK2saBiglzmKf57RkHrrtd9Z00ee4HXW
	 irMbg7ufT0hOUmDcYKNfZZJkftjZWUShf+NRT8M4pq2A56NXT0CN3ke5Yx6OvIJcIi
	 iZROKJuYkoFnlMiXecb8Xi9TIoCv+77J2YgV09fQn947VQYuXxOyMU+zDlWHulfvh6
	 hwlLnoXEvb+z4b+Yq9aYztaSqI5YVv5M2Js+XXSCtlk6NMTX/u/hH7CTdV03EStioc
	 5pALyxMzI1tcQ==
Date: Sun, 12 Jan 2025 12:22:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 04/15] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <20250112122249.3bc9dfe0@jic23-huawei>
In-Reply-To: <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 12:25:07 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 is a fully differential ADC, meaning that the voltage
> conversion result is a signed value. Since the value is a 24 bit one,
> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Looks good, but for v2, please pull fixes to the start of the patch set.

Whilst it doesn't matter here as the earlier patches are all docs,
it is still good practice as anyone looking for fixes tends to look 
there.

Jonathan

> ---
>  drivers/iio/adc/ad7768-1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 113703fb7245..c3cf04311c40 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.channel = 0,
>  		.scan_index = 0,
>  		.scan_type = {
> -			.sign = 'u',
> +			.sign = 's',
>  			.realbits = 24,
>  			.storagebits = 32,
>  			.shift = 8,
> @@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ad7768_scan_direct(indio_dev);
>  		if (ret >= 0)
> -			*val = ret;
> +			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
>  
>  		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)


