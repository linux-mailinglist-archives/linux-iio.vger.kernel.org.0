Return-Path: <linux-iio+bounces-18424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76039A950E8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD0416ED54
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B8264A96;
	Mon, 21 Apr 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQfhxBMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033B264A77;
	Mon, 21 Apr 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238564; cv=none; b=dIhOfR+/ey9Jb3xz+YG9V7JPRvISAgFzOum/ALN4cAh23oNp6dy4uQ4XdYSPpzOSiV1bfgWG5KaT6/wghbXZOJT0hg445kI1AyDSPXlz2iOrG6PwWJBTLU3KqdBx0RIVgYoTb6P7rTIdYUD7aW1HBeIQKE9mHenv8jTAkTCPwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238564; c=relaxed/simple;
	bh=a4mG/AcamjUGOjuPHpCrzRiY4gqqnB5bypmobsfll8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1/P0Mzu7oYUjRw68+ZX8glGK0Zj20ToyaAmdR4lsFKjTp0I/QLZg3rE6aRIkWgeJOSSjM4POOYtrDJOj2Gm53I0hVh91j0ZRbMmajkHFGn6zY86nAUyhrb7pWN9y2r3FFjb8dZcxBQVDPaNCMen8+yZ0yPLckhbiaTWQXwVjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQfhxBMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A32BC4CEE4;
	Mon, 21 Apr 2025 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745238563;
	bh=a4mG/AcamjUGOjuPHpCrzRiY4gqqnB5bypmobsfll8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQfhxBMVtKQOx6JV5m/XqoB2GmmquSJluCneDYYoJLRqr8/nPzW22A8zSUTTcZjGn
	 1ff4COTbUlLe3wf4j0toSvLPBssKXAdwKPCvGI+4vwV7GGmwOrwKsynU7mqX/RvJRL
	 ctwQCQ2Mwtu1w9IhkRyKVFo1ecb76H5zilU3GB2/Xy6aBoMLysM2ve6ABX/fj95rqw
	 OUlzT445HfS/CYS7LizuNAiOK9bfBmFb3LAmRrkx6R/CTRV5oF1B8Z4WKiWWgMh/2F
	 JmidIjkXGSB8ga6RJZV6/uJWIjwd5AMITwKMNcWoNZnR3YfBc4T1E+SLgyzyWvjsu1
	 6XcDA8EL2bxPg==
Date: Mon, 21 Apr 2025 13:29:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 1/5] staging: iio: adc: ad7816: Allow channel 7 for
 all devices
Message-ID: <20250421132914.7a456dac@jic23-huawei>
In-Reply-To: <20250420014910.849934-2-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
	<20250420014910.849934-2-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:49:06 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> According to the datasheet on page 9 under the channel selection table,
> all devices (AD7816/7/8) are able to use the channel marked as 7. This
> channel is used for diagnostic purposes by routing the internal 1.23V
> bandgap source through the MUX to the input of the ADC.
> 
> Modify the channel validation logic to permit channel 7 for all
> supported device types.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")

Adding a missing channel is not a fix.  It is a feature enhancement.
Not appropriate for backporting in general (though obviously someone wanting
to use it might do so).

> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 6c14d7bcdd675..a44b0c8c82b12 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -190,11 +190,11 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
>  			data, indio_dev->name);
>  		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
> +	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1 && data != AD7816_CS_MASK) {

Why use the mask?  I think this is something entirely unrelated that just happens to have
the value 7.

>  		dev_err(&chip->spi_dev->dev,
>  			"Invalid channel id %lu for ad7818.\n", data);
>  		return -EINVAL;
> -	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
> +	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0 && data != AD7816_CS_MASK) {
>  		dev_err(&chip->spi_dev->dev,
>  			"Invalid channel id %lu for ad7816.\n", data);
>  		return -EINVAL;


