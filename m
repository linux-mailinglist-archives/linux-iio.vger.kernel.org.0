Return-Path: <linux-iio+bounces-10889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FA9A7286
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31554B20FAF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C658C1FAC29;
	Mon, 21 Oct 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlvP5uRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D91DF754;
	Mon, 21 Oct 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535981; cv=none; b=OD4aIosMJDah+VDr/dE+Asz5tUVhXGMD9GmQQD2B1EFSvOt+6akxTIJArcF8dzrLBwPFBRqzK4nEJ5xNVKAmdiYUcowXTcGd1+69A8Q9Sn+XiVL54uPUiUv+PutfOCAE+D3nusRb/wsfVwlOgKf4J558Uu0v10g9rEw1b9sklU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535981; c=relaxed/simple;
	bh=gqiLiE9bKe2zKK/B0GMPEQArDkJ82dcLNkYhMn29Lhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzwOJEoCKc6KFDjlc96yW75B1Zj6p2ZxR/tCjYFCMDtCTWpjMSNIX0DP0rjxrzzpSw5s7nkxp3ELTjdGtMo0KsLc0D/tYJ7GNnQWcwo1AHtEeUfWLFdrkBHB7kLXVrruS8TDjetw3sqlAtiMfm5ylEa5KQc4CygxAq5YdWYIhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlvP5uRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE681C4CEC3;
	Mon, 21 Oct 2024 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535981;
	bh=gqiLiE9bKe2zKK/B0GMPEQArDkJ82dcLNkYhMn29Lhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IlvP5uRDNgIIDDFoRC/zKiPRfBbBPEaTMI166oIJAJ8jl8Ci4rRNogAxQUiVmK+mE
	 oFzqyWnPNjg2WxKG5LIEQgStUB8FPqqmLhjn75K4GB74g28Cv8i0e76h3RzS5VnkhT
	 QEsaSlTpv9y16BovcbncRTHdY4vERZr8GyphCS1+J4euxAoEt6RAFnuu5AkN71asJQ
	 SEQFs3Vhx1QvGy3nsO5FPTIjVORNDH/toaioJZ0i80H7kOgIMls/2NCs+sro0/yH6k
	 ssonJ+0OVoIneAYBXZHnTCS52Y4MhGW8Xes2HNtk7hB4X5MaMXhmYAdTkdjhfUinJ+
	 Ax47KKk7fTQ+A==
Date: Mon, 21 Oct 2024 19:39:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
Message-ID: <20241021193933.59c2d2b6@jic23-huawei>
In-Reply-To: <20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
	<20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 21:12:17 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Vishay veml3235 is a low-power ambient light sensor with I2C
> interface. It provides a minimum detectable intensity of
> 0.0021 lx/cnt, configurable integration time and gain, and an additional
> white channel to distinguish between different light sources.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

I missed one thing on previous review...
There is no obvious reason this driver needs to provide raw and processed
values.  Unless I'm missing something, just provide raw and let userspace
do the maths for us.

Jonathan

> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> new file mode 100644
> index 000000000000..fa2141cced8f
> --- /dev/null
> +++ b/drivers/iio/light/veml3235.c

> +static const struct iio_chan_spec veml3235_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.channel = CH_ALS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED),
Why both raw + scale and processed?

We normally only provide raw and processed for light sensors if:
1) The conversion is non linear and hard to reverse.
2) There are events that are thresholds on the raw value.

Here it is linear so just provide _RAW.

> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel = CH_WHITE,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						     BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};

