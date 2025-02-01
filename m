Return-Path: <linux-iio+bounces-14825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA66A249F3
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8EA1884A43
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04011C3021;
	Sat,  1 Feb 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/16ZtlM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC7156861;
	Sat,  1 Feb 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424201; cv=none; b=EWR4/33EX+6f/XbuJnl/UAfOogNWEWWApQpCZq/SwL0dMtKj8fzqdFNNWKOr7AQC4RD0/y6bPX6xfxWXpYcS1CPuSX2Gd2Tn0Qt7bfr0FhuSanRHBVybbnuvO4+Zwlk2MoaeIy5eHHatwf4NP0dbK+G0nOSu1gBk/bPXW6CY2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424201; c=relaxed/simple;
	bh=JQwInzk4ioc+1qqV9wy/ruj5msMMzuzULv4cHNZzJwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgrBtypdbFoYuss6PU9KQfA0XXYDtvw1V4nUqAdXIJpIkCLhXOVEiPZg3o+uFD7F+dtepRfyvZAYivrWSDAK68eVM67+RTqkEoBaGIPw1xBfiHXryVfOdABu914SX2RjRS/pymRYMz3KobQW1eTOKu7WhnT5uvMc00g5I06xxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/16ZtlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F7CC4CED3;
	Sat,  1 Feb 2025 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738424200;
	bh=JQwInzk4ioc+1qqV9wy/ruj5msMMzuzULv4cHNZzJwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/16ZtlMWcxinvJS/uML2pABf1J+ZuHeQi+tQQXnUrJdL6AlrGp1Oe+KtIxqZyS/A
	 iFvJV7ZqLXCmXtGt9wNpzoPIlkaBG3iOrfK6LFxUOrVY2h0d5fpl7Q+Ruts1RRUZEH
	 lAXJe+Cn7MbHg15CFYuW/ho2w33WQih0g/nOkistOyKDw83DpB1rb3j60X+grfIL1q
	 3ck42+tWy+z5jn0kal+rbHM3EqivZgbNKbmGNU9AesusUfFgSL9vxRwrJKS9PESlli
	 A2DhcaZuqMA2n1ILD7oebfwyiNmAae6sRCUFw2IPQE57HFnoA1Rosb+SUlmZhXt0An
	 +CbJb00zHnr2A==
Date: Sat, 1 Feb 2025 15:36:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 01/16] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <20250201153630.03245bd9@jic23-huawei>
In-Reply-To: <64e32c0ac7357ca7ddea813ba932bf957cbbeca2.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<64e32c0ac7357ca7ddea813ba932bf957cbbeca2.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:11:01 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 ADC output code is two's complement, meaning that the voltage
> conversion result is a signed value.. Since the value is a 24 bit one,
> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Dropped.  Jonathan, this is missing your sign off.

> ---
> v2 Changes:
> * Patch moved to the start of the patch series.
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


