Return-Path: <linux-iio+bounces-19894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A10AC350A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B259B7AA888
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358921F3BA2;
	Sun, 25 May 2025 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh1RPu1B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37453363;
	Sun, 25 May 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748181697; cv=none; b=rBwHYe8osSCNMBDzMSODpt9IaT1ehpHULrzWTMZQYuafPJPe1LdT5ZsfN0F2xuHyi8g9sypmB3KBolHUC5OyVvd6GvpkpXuzX0GUOZmrgxT2oLXt+cvGEV97sYWwZrHR1LXueCR7MzQTZJHLP5alwciyCpWZ/krBAMUxlj8u6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748181697; c=relaxed/simple;
	bh=SkIw3WwEbCi0cU99eKP+Kc3jABnQlnqBtxNaBATWIj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k30NfbLPjBfNrvMuqztRqepX3ZirQuOf4fVKpx25T9CSSbwJYw0/ZVgLnZaIGZLG9LwIuz2F3klbkmPaEuT2sJJnZ/pBje3ZbWjeaJr/7VWepz0iIQvqXb46Svc0+aDqzI3V3Mj4y1zBpiwYIe2sBapEHPAcSqDeT0V/cqriA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh1RPu1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4535C4CEEA;
	Sun, 25 May 2025 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748181696;
	bh=SkIw3WwEbCi0cU99eKP+Kc3jABnQlnqBtxNaBATWIj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fh1RPu1BhsukJSmg7VMRA49YQtBQkflAhkjFr/IV/YS/Jg3P4q473NUlI/9Jia4c0
	 526a4vGMNXaAEPpVkjL6rYk2/h0+7Yjm1FKZckeGZkffFtCxuB+v3eiFsgJw3Kyukf
	 MWsgVsXgix80ZO9fgWGjsRgolCSgudvQtRZ5HNmyI9e6JcIa7Mr3GMV1hW6DlHoQTd
	 wT5ZCuiFq/Ei0r5dcrPWRgzXwf2lgY4pcKMjjy9xHIgTMt8sKdden/IRpQpl0p4O2p
	 acYeVlzJjRTomRRxWIHxSOO23miFRU5M06wDVGnDYYoAbGCJ5FUsovptvX1oSBPZWc
	 M8Zo7Cp+xzEEA==
Date: Sun, 25 May 2025 15:01:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 5/6] iio: adc: ad7606: exit for invalid fdt dt_schema
 properties
Message-ID: <20250525150126.0f38696f@jic23-huawei>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-5-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
	<20250522-wip-bl-ad7606-calibration-v6-5-487b90433da0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 15:27:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix ad7606_get_chan_config() fdt parsing function to exit for error in
> case of invalid dt_schema values.
> 
> Idea is to not allowing to proceed over when there are values that are
> not allowed from the dt_schema.

"Idea is to not proceed when there are values that are not allowed
under the dt_shema."

> 
> Fixes: f3838e934dff ("iio: adc: ad7606: add support for AD7606C-{16,18} parts")

I'm in favour of consistency but it's only a 'fix' in the sense of blocking
bad DT cleanly.  So I don't think the Fixes tag is appropriate here.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

> ---
>  drivers/iio/adc/ad7606.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index bb0c89fc618874f4a5948d8e537716f87127bc92..f832fd0daf50a69a892636018bda2e43f73d1570 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -319,15 +319,13 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
>  
>  		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret)
> -			continue;
> +			return ret;
>  
>  		/* channel number (here) is from 1 to num_channels */
> -		if (reg < 1 || reg > num_channels) {
> -			dev_warn(dev,
> -				 "Invalid channel number (ignoring): %d\n", reg);
> -			continue;
> -		}
> +		if (reg < 1 || reg > num_channels)
> +			return -EINVAL;
>  
> +		/* Loop until we are in the right channel. */
>  		if (reg != (ch + 1))
>  			continue;
>  
> 


