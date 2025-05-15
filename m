Return-Path: <linux-iio+bounces-19555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64388AB8D51
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03F11611AF
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFC254874;
	Thu, 15 May 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOqj+eyH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA15253F17;
	Thu, 15 May 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329234; cv=none; b=bpyfwGAC91Nb3DjI2KszRyiv6j5KHOxa0LBIgEgVwnTcT6GWZNo2rVQ4o2FAmPkjHwWujokVBrWC6DP1vWYHkRL46xqxuxLmvjLLPbOevLRb2/llMpVde0/DzE4K+RsDuVrMF2ed6t0a8cjH6YuLOCYlHhak1n04uspI1euV2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329234; c=relaxed/simple;
	bh=s+w59KNDaZNiOoDU5/q0UldHUVQeIBR1e/UnvwS/GPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVME9YVoNmEW514PngCOQFWYR2/5k+gvRcNLMh42YYbY1O/ODSgujVf4vzmIuA4CIKmXXTf+ltBOCT9pLNvbm4lLFzqPyIhL60L95bZqQ01H4RuluSHS3nvK1fMyxnWGfI7a86XJpnsw7ydSfnKN1pcyMiIgzGr+EW9PKaB51oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOqj+eyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BEC4CEE7;
	Thu, 15 May 2025 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747329233;
	bh=s+w59KNDaZNiOoDU5/q0UldHUVQeIBR1e/UnvwS/GPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GOqj+eyHYtGdpVurCumeppr4T1Laoo42tzXHTWNtnXwwQpjFB27BNaJ5Wz0kpDl+n
	 aOSWMSQYZenW3j80+uQ2B5QbTOpBvUI5IY8s9fdBvSrO9FIqnXMbAVlTe7h38/5ceU
	 6qw+kSN+wVh1PNtsKw/al2TPEYXi8Xl1vLeW8ZCnckltjYflA2vUXLJiFUdcJIlE4O
	 WaFGaT8QO1dW9/nsioLIbQTmcO9ta8D44CsJnkkBQbxVGotNmtdAikAakArq1RU55m
	 SgYlXoAQPLYBvVVynQ1eXovYOy6OvOvx9k3NVz8UKlDE53yziJBCTia76f36QkKEP7
	 okiYw8afp2ztw==
Date: Thu, 15 May 2025 18:13:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Soponar <asoponar@taladin.ro>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 pavel@ucw.cz, lee@kernel.org, baocheng.su@siemens.com,
 wim@linux-watchdog.org, tobias.schaffner@siemens.com,
 angelogioacchino.delregno@collabora.com, benedikt.niedermayr@siemens.com,
 matthias.bgg@gmail.com, aardelean@baylibre.com, contact@sopy.one
Subject: Re: [PATCH 10/16] iio: ad7606: Fix type incompatibility with
 non-macro find_closest
Message-ID: <20250515181344.504143ff@jic23-huawei>
In-Reply-To: <20250515081332.151250-11-asoponar@taladin.ro>
References: <20250515081332.151250-1-asoponar@taladin.ro>
	<20250515081332.151250-11-asoponar@taladin.ro>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 11:13:26 +0300
Alexandru Soponar <asoponar@taladin.ro> wrote:

> The ad7606_oversampling_avail and ad7616_oversampling_avail arrays were
> previously declared as unsigned int but used with find_closest(). With
> find_closest() now implemented as a function taking signed int parameters
> instead of a macro, passing unsigned arrays causes type incompatibility
> errors. This patch changes the arrays type from unsigned int to int to
> ensure compatibility with the function signature and prevent compilation
> errors.
> 
> Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
Assuming overall approach is fine, this change is fine wrt to ranges
etc.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ad7606.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d8e3c7a43678..41b477ea386d 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -81,11 +81,11 @@ static const unsigned int ad7609_hw_scale_avail[2][2] = {
>  	{ 0, 152588 }, { 0, 305176 }
>  };
>  
> -static const unsigned int ad7606_oversampling_avail[7] = {
> +static const int ad7606_oversampling_avail[7] = {
>  	1, 2, 4, 8, 16, 32, 64,
>  };
>  
> -static const unsigned int ad7616_oversampling_avail[8] = {
> +static const int ad7616_oversampling_avail[8] = {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  };
>  
> @@ -835,7 +835,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned int scale_avail_uv[AD760X_MAX_SCALES];
> +	int scale_avail_uv[AD760X_MAX_SCALES];
>  	struct ad7606_chan_scale *cs;
>  	int i, ret, ch = 0;
>  
> @@ -884,7 +884,7 @@ static ssize_t ad7606_oversampling_ratio_avail(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	const unsigned int *vals = st->oversampling_avail;
> +	const int *vals = st->oversampling_avail;
>  	unsigned int i;
>  	size_t len = 0;
>  


