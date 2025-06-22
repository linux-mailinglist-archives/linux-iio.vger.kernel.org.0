Return-Path: <linux-iio+bounces-20863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C24AE3061
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A326116F1AF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1E01E1A05;
	Sun, 22 Jun 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpE10SOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3811C2437;
	Sun, 22 Jun 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602313; cv=none; b=rQ9cW0mHae6q8nilE8EoNVi7DRaikAt4gAA0hPQSmL3mD0l5F5JaSFybKkWyaCHIkel+gZHd43GPoidJ/bIhrKUZIO8MrWII1wUI5jbO+xPQBGLX2usfy4vLyVEN7nQ6usFq8s2hd11pvPuXAO/LEr2mVRWys1+wAjoZxBE64Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602313; c=relaxed/simple;
	bh=QSQaZsnP68Zha4a81cibwIVx+6+SJAUtmzxExMzQ96g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYyjfmxETNUJ7mjcmz9/dAASBNp+In+YC3gtympTBxU28c0XO0dyzmTtxzhSuk3AB9lryKjuk4NYALEjD3XTOQ9gJ8N+HxrhNzEmAgGzl1QmSUnrqktIcS17uZoZqsfp9X0ziZEbsfflm5hRLtJmDViURdXdU5gyPI2k5fOx5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpE10SOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A93C4CEED;
	Sun, 22 Jun 2025 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602313;
	bh=QSQaZsnP68Zha4a81cibwIVx+6+SJAUtmzxExMzQ96g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpE10SOf33qnwtH6ssPIYl/K6KoHlFdDl6mABMsgoRy8YTQtfxgROMxPtHD9JW2pA
	 912Z4oYw9Z33B/qqsN0PzvpM6fxncmWwhaKXWgZdvHtzLK/d6jmpSljSSO5b2tTYOm
	 DB4Ha+TUoHFAeVCYujTKDtI4J9YB/Wc5Jxqv1XZcGFQZc4Furdh92iTc/gWLu+v1Qc
	 GFihyPwvF2FI/SpqMNeap+38BV+S/Tqedj+KX73vAU1FJ/v1KhkirphLpY86INYK6A
	 5KDH64kZMOT/Ez0JgpOglLZfZELEMvWgG7Sw2zmhnRHgnKVc4f2idYy5YE9T32XgCE
	 YZ3BvZlK8ymEQ==
Date: Sun, 22 Jun 2025 15:25:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Julien Stephan
 <jstephan@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: fix adi,gain-milli property parsing
Message-ID: <20250622152506.238c1322@jic23-huawei>
In-Reply-To: <20250619-iio-adc-ad7380-fix-adi-gain-milli-parsing-v1-1-4c27fb426860@baylibre.com>
References: <20250619-iio-adc-ad7380-fix-adi-gain-milli-parsing-v1-1-4c27fb426860@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 10:24:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the data type of the "adi,gain-milli" property from u32 to u16.
> The devicetree binding specifies it as uint16, so we need to read it as
> such to avoid an -EOVERFLOW error when parsing the property.
> 
> Fixes: c904e6dcf402 ("iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
> ---
>  drivers/iio/adc/ad7380.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index aef85093eb16cbe9cc062f8cb4239e955c8a21b6..fd17e28e279191c2603537a9bddc7eb9976c144c 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -1920,8 +1920,9 @@ static int ad7380_probe(struct spi_device *spi)
>  
>  	if (st->chip_info->has_hardware_gain) {
>  		device_for_each_child_node_scoped(dev, node) {
> -			unsigned int channel, gain;
> +			unsigned int channel;
>  			int gain_idx;
> +			u16 gain;
>  
>  			ret = fwnode_property_read_u32(node, "reg", &channel);
>  			if (ret)
> @@ -1933,7 +1934,7 @@ static int ad7380_probe(struct spi_device *spi)
>  						     "Invalid channel number %i\n",
>  						     channel);
>  
> -			ret = fwnode_property_read_u32(node, "adi,gain-milli",
> +			ret = fwnode_property_read_u16(node, "adi,gain-milli",
>  						       &gain);
>  			if (ret && ret != -EINVAL)
>  				return dev_err_probe(dev, ret,
> 
> ---
> base-commit: a3245ebdfac846ce0b563a3ed474be2e15381f9f
> change-id: 20250619-iio-adc-ad7380-fix-adi-gain-milli-parsing-8df01280f493
> 
> Best regards,


