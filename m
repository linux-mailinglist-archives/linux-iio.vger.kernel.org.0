Return-Path: <linux-iio+bounces-10251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99995991ECB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DCF28252E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CFF4D8DA;
	Sun,  6 Oct 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3jwEJ3U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278DE545;
	Sun,  6 Oct 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224459; cv=none; b=T5WALCl6k5TyzgXf07kMdQxFpbPRiHAEtqGdXIld/G8IeSgZrqBBgIc/AEKv+DSBdrnSWjS7w3jydweuuUP0SZW3o0VhY/r1PsYociZS0GdJJXeNBzKdluL4aYEV/0IhWogaifkbYCSsUbjVXRd//ugVwt8H3JOh69SbphClQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224459; c=relaxed/simple;
	bh=OIrjK6ryenvuZ4qWmrP+SG11+voW/8AtSafAaVyly3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAoAfhr2iXWGGrIMLW/PD6McYW23U9n+/MHElxiCYeYKN+9/srE1HIOupaVeb5+xmLpvRDHDWBxE2WrTNyVFunhxTWzXFb3tI2dlbm/wD0GRRMZlzGgPWQHQQycDLJf7TCLq+97jiKKeSP7uQhwJB7h+223IzSPKfbbetA7e8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3jwEJ3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B3C4CEC5;
	Sun,  6 Oct 2024 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728224459;
	bh=OIrjK6ryenvuZ4qWmrP+SG11+voW/8AtSafAaVyly3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3jwEJ3UodHMYcs+v4q5+PkyfRMhyg7fNnPFvVbgcwhcXLImsd0ioVPYWTZ5BLYzT
	 YUAfcbLHcEv5uwqVdjUiiIoRItK7+NEXbeqjByZPJ9MBKzGvSivEAVrR/jo3tJ46Sw
	 wEKTCXgSg2BtgzdMWjuFbEbnS1iozqoA6D8ZH5PZw6fNulgS0/IPK15XUtHb+ywH+9
	 W3Cl2ytWsNA6aPaCkd9pCuW6i8THyQ6AxHmFIkp2h6v+BAAYuqKH5dk/E0X5nTA3wA
	 qSiGAcXr9y60xAU8JMX0iW8S/8Nzeg3P9tG4wX34tN9q9n+zl3FBUIfQOnGrqG4Ji+
	 U7qwJvlwFID/w==
Date: Sun, 6 Oct 2024 15:20:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: consumers: release available info buffer
 copied from producer
Message-ID: <20241006152048.30ffba1c@jic23-huawei>
In-Reply-To: <20241003-iio-read-avail-release-v1-6-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
	<20241003-iio-read-avail-release-v1-6-c70cc7d9c2e0@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:34:11 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> The iio_read_avail_channel_raw() inkern interface now allocates a copy
> of the available info buffer that must be freed after use. To do so,
> free the buffer in the consumers read_avail_relese_resource callback.
release

Otherwise fine.

J
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  drivers/iio/afe/iio-rescale.c     | 8 ++++++++
>  drivers/iio/dac/dpot-dac.c        | 8 ++++++++
>  drivers/iio/multiplexer/iio-mux.c | 8 ++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 56e5913ab82d1c045c9ca27012008a4495502cbf..78bb86c291706748b4072a484532ad20c415ff9f 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -249,9 +249,17 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static void rescale_read_avail_release_res(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   const int *vals, long mask)
> +{
> +	kfree(vals);
> +}
> +
>  static const struct iio_info rescale_info = {
>  	.read_raw = rescale_read_raw,
>  	.read_avail = rescale_read_avail,
> +	.read_avail_release_resource = rescale_read_avail_release_res,
>  };
>  
>  static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
> index 7332064d0852d979620f90066fb027f6f68f8c95..beec76247acb5170b81058d28a71ed17c831c905 100644
> --- a/drivers/iio/dac/dpot-dac.c
> +++ b/drivers/iio/dac/dpot-dac.c
> @@ -108,6 +108,13 @@ static int dpot_dac_read_avail(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> +					    struct iio_chan_spec const *chan,
> +					    const int *vals, long mask)
> +{
> +	kfree(vals);
> +}
> +
>  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
> @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
>  static const struct iio_info dpot_dac_info = {
>  	.read_raw = dpot_dac_read_raw,
>  	.read_avail = dpot_dac_read_avail,
> +	.read_avail_release_resource = dpot_dac_read_avail_release_res,
>  	.write_raw = dpot_dac_write_raw,
>  };
>  
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..31345437784b01c5d6f8ea70263f4c2574388e7a 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -142,6 +142,13 @@ static int mux_read_avail(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static void mux_read_avail_release_res(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       const int *vals, long mask)
> +{
> +	kfree(vals);
> +}
> +
>  static int mux_write_raw(struct iio_dev *indio_dev,
>  			 struct iio_chan_spec const *chan,
>  			 int val, int val2, long mask)
> @@ -171,6 +178,7 @@ static int mux_write_raw(struct iio_dev *indio_dev,
>  static const struct iio_info mux_info = {
>  	.read_raw = mux_read_raw,
>  	.read_avail = mux_read_avail,
> +	.read_avail_release_resource = mux_read_avail_release_res,
>  	.write_raw = mux_write_raw,
>  };
>  
> 


