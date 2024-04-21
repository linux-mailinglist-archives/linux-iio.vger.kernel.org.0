Return-Path: <linux-iio+bounces-4414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2128AC055
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7011F2156F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4A29422;
	Sun, 21 Apr 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVBFKgpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FAD1401C
	for <linux-iio@vger.kernel.org>; Sun, 21 Apr 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721414; cv=none; b=pBtR61m4oanXoIYRMnTB/JXfGl0j2oFAmsKSt7IaprdUl+3qCB+V09S9FZ+udz4tCNrAQolf03EOnnB3zRxxB17boJ6OpnKnRcXLG8mAbbahZKumP8/O/VbgnD83tD/zXTuOo17hI3oeO9tm2MDh31bmW7x+hrbadMztDvZjxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721414; c=relaxed/simple;
	bh=ez0xqvpb3Ya7mYSSQT2T5CsAwpZmQDDjq7pGzKoJNDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koxWYWb7n3AHF5+kmeOMlksZJRxfz7Rf768Yh4zFM1Y8/KjWnnCk9yfuOBTEkPcnoeQpldnDhZZIjmy72jX7W4JX7gOLMiLURB66izO/rc7nqUgGqdKnY3gYXqJph4QT9asagrtTtImK1XxbMWr7UATf4IfzcK2Bh39iol2dkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVBFKgpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1173C2BD11;
	Sun, 21 Apr 2024 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713721414;
	bh=ez0xqvpb3Ya7mYSSQT2T5CsAwpZmQDDjq7pGzKoJNDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tVBFKgpxduxvkAs/buNFS6/12tPjen/mX9VwepfWshAjVeolLnh8nlkg+EkbO2KAJ
	 LjRlIerg3kD9f+SCkSVMCwogc5KLIPBNw1UeYPCOGX4EkIRtAOsEPMAybNfitKCaVF
	 rTACnLbYxhPehgQLuVtPQ1z+LZ6OZrzcq9NsIFntN8IkHqCdwOFM3zme3j/s9Cr25v
	 K0qwxff17yHWcumVi1v075JjWjAv551aeD4Jz2pxLHhCs8oDEBHlE27SoL8wh/QasL
	 ySxCeIgvVq2+iomkW7BCGfw/h+bMd2E0haLihsHOW1TN2UfTKq2CHgeJQTE73NF5Tv
	 VSMqYfF1h8EgA==
Date: Sun, 21 Apr 2024 18:43:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bertin Salvador <lorenzobs@usp.br>
Cc: Briza Mel Dias de Sousa <brizamel.dias@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131e08: Use
 device_for_each_child_node_scoped() to simplify error paths.
Message-ID: <20240421184323.68b710e2@jic23-huawei>
In-Reply-To: <20240420182744.153184-2-lorenzobs@usp.br>
References: <20240420182744.153184-1-lorenzobs@usp.br>
	<20240420182744.153184-2-lorenzobs@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 15:27:43 -0300
Lorenzo Bertin Salvador <lorenzobs@usp.br> wrote:

> This loop definition automatically releases the handle on early exit
> reducing the chance of bugs that cause resource leaks.
> 
> Co-developed-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
> Signed-off-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
> Signed-off-by: Lorenzo Bertin Salvador <lorenzobs@usp.br>
Good patch.
Applied to the togreg branch of iio.git, but I'll only push it out
as testing today so that 0-day (an autobuilder) can see if it can
find anything that we have missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads131e08.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index fcfc46254..cb04a29b3 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -694,7 +694,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  	struct ads131e08_channel_config *channel_config;
>  	struct device *dev = &st->spi->dev;
>  	struct iio_chan_spec *channels;
> -	struct fwnode_handle *node;
>  	unsigned int channel, tmp;
>  	int num_channels, i, ret;
>  
> @@ -736,10 +735,10 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  
>  	i = 0;
> -	device_for_each_child_node(dev, node) {
> +	device_for_each_child_node_scoped(dev, node) {
>  		ret = fwnode_property_read_u32(node, "reg", &channel);
>  		if (ret)
> -			goto err_child_out;
> +			return ret;
>  
>  		ret = fwnode_property_read_u32(node, "ti,gain", &tmp);
>  		if (ret) {
> @@ -747,7 +746,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  		} else {
>  			ret = ads131e08_pga_gain_to_field_value(st, tmp);
>  			if (ret < 0)
> -				goto err_child_out;
> +				return ret;
>  
>  			channel_config[i].pga_gain = tmp;
>  		}
> @@ -758,7 +757,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  		} else {
>  			ret = ads131e08_validate_channel_mux(st, tmp);
>  			if (ret)
> -				goto err_child_out;
> +				return ret;
>  
>  			channel_config[i].mux = tmp;
>  		}
> @@ -785,9 +784,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
>  
>  	return 0;
>  
> -err_child_out:
> -	fwnode_handle_put(node);
> -	return ret;
>  }
>  
>  static void ads131e08_regulator_disable(void *data)


