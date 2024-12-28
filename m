Return-Path: <linux-iio+bounces-13844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8F9FDB87
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A68160E08
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8AA18A6BD;
	Sat, 28 Dec 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1LgHIzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC405D8F0;
	Sat, 28 Dec 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400608; cv=none; b=pzSMJx9RIe91/ITAyADG7pFJG5OJNZIVsKpRLwk/3sY9o+Gvb35kP9q2Gfb+58cmEj5DKCvrmCCVHxtlOicxcAswzOXfo4YuD3bNcCeJajXQRPFZg/kvoObiV0vTv2BYTKtFcVpCsoMagyuFRwX8wrzgq2vDxGfOh91DCJuuwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400608; c=relaxed/simple;
	bh=t+jammYE0J/1TkMfWN+sst8IgLgLFGcFS2m0sgZhpXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+LnP4WjoboKb+h8lIde4vTV2XfI/qH5JzM4OwOQEDp8S3tmfYf1h98WKXi9DPHpMwLzGNQw/qv5NyC9dW5jb7KFhU5EqC/tp7Bb2WGfsiJQwwnMpjjBwmkGoU/Uka27ukK6jgp9BgUaQGr1JqVFP3lZWLuUoFK7j2/t9kn1P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1LgHIzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BC0C4CECD;
	Sat, 28 Dec 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735400607;
	bh=t+jammYE0J/1TkMfWN+sst8IgLgLFGcFS2m0sgZhpXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I1LgHIzxZ9t5CJh8e8644L5wfVGjz9cvU4hw93uZfc7uS+CGCBA8YidapJurFpbKE
	 X75xraAndRiKTOZzRq0hMLjhwTrg9+PjPGzaQVHYtDaA91TB0EVh0/e/axztbdISn+
	 rP6kabIdWxmsWKHAYOSJfQPWkribS/yP79NDYMdw/BDPsbg+PzPbPKDEYLXcacy5Vl
	 7tOL9sLOq2cR2p52/dHz+9fSQ61d3iCuSc1e2CBNZ35DpoCNBrdoFJaj7fblBCUe7d
	 KyEhT4rPUB/SFlI7QCpKbV9XyVeV795eK5sXiWuyP5OOnLk5H+i6JCo3z9pL+wVhkT
	 VFxLhHu3hWFhQ==
Date: Sat, 28 Dec 2024 15:43:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
Message-ID: <20241228154320.2624f2f0@jic23-huawei>
In-Reply-To: <20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
	<20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 11:59:02 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The configuration and ID registers are not volatile and are not affected
> by read operations (i.e. not precious), making them suitable to be
> cached in order to reduce the number of accesses to the device.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
This is also fine on it's own.

Applied.

> ---
>  drivers/iio/light/veml3235.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
> index fa5c7e7dfbfaec1b96428612b1dcba91ea51603f..f754980ea156a6e128ff159b816e09099197c5c7 100644
> --- a/drivers/iio/light/veml3235.c
> +++ b/drivers/iio/light/veml3235.c
> @@ -101,12 +101,43 @@ static const struct iio_chan_spec veml3235_channels[] = {
>  	},
>  };
>  
> +static const struct regmap_range veml3235_readable_ranges[] = {
> +	regmap_reg_range(VEML3235_REG_CONF, VEML3235_REG_ID),
> +};
> +
> +static const struct regmap_access_table veml3235_readable_table = {
> +	.yes_ranges = veml3235_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(veml3235_readable_ranges),
> +};
> +
> +static const struct regmap_range veml3235_writable_ranges[] = {
> +	regmap_reg_range(VEML3235_REG_CONF, VEML3235_REG_CONF),
> +};
> +
> +static const struct regmap_access_table veml3235_writable_table = {
> +	.yes_ranges = veml3235_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(veml3235_writable_ranges),
> +};
> +
> +static const struct regmap_range veml3235_volatile_ranges[] = {
> +	regmap_reg_range(VEML3235_REG_WH_DATA, VEML3235_REG_ALS_DATA),
> +};
> +
> +static const struct regmap_access_table veml3235_volatile_table = {
> +	.yes_ranges = veml3235_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(veml3235_volatile_ranges),
> +};
> +
>  static const struct regmap_config veml3235_regmap_config = {
>  	.name = "veml3235_regmap",
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = VEML3235_REG_ID,
>  	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.rd_table = &veml3235_readable_table,
> +	.wr_table = &veml3235_writable_table,
> +	.volatile_table = &veml3235_volatile_table,
> +	.cache_type = REGCACHE_RBTREE,
>  };
>  
>  static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
> 


