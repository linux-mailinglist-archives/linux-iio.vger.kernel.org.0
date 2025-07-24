Return-Path: <linux-iio+bounces-21972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4449B10B14
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF857A9F34
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF72D5425;
	Thu, 24 Jul 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4PaeJpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F092BE643;
	Thu, 24 Jul 2025 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362742; cv=none; b=vDHak8HF57c8ZS80X5s2sEU9T21otm5gSkMLYmRTr2voRHDfDJbVHodXqRXeI+3u/jaT1yQLg33/wv675SRqMxXsTMvSC8zQj91Dn+Xalbb4jGYz27WY4cDN22bvgeshNDwaVg2IZ4wr9VvjLa3aZ53QiJhtbyva/PlYQcAeyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362742; c=relaxed/simple;
	bh=OkPRL57kOfmY931OTFdFQJUDqRwpx+07WG3VjlUybmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWPMIQM9AN63uzalsOq/kMaPYHfoeTt+n6oryePS+9MW8dugPYgs5ytrZUiW9rCtZZ7PWpo8cW3TZTXFIQmgq2Lq5m/9LPh98liZX5MlA5Oi+sla3JU/CRXhRjZXVqFkBUhuY4oAw1amiYzN5e0tzYTNSvW5M3dovruygogV4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4PaeJpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D640C4CEED;
	Thu, 24 Jul 2025 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362742;
	bh=OkPRL57kOfmY931OTFdFQJUDqRwpx+07WG3VjlUybmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4PaeJpxE6uMFL1q2YUVr2cgXRWLbbkoYrXYlb8yzhRfzMNSrj0WlzLvnn6R+YzX2
	 WAye9TZdsnJqZV41ogGMSnrJ+4HzCn6/iA0rqJi3WVBiIOIzWbHeGsXpyZwi7GwBjj
	 xZFyVApBaVjKEEZsdCm9ZhDUhFYHfRN4z4y89Z92KSX7M3ZWdJVTUQBERHM+Jw0QE6
	 nEhX7CsrCXR3lhyD7HXeGPP04z/FO7pURMf/a2P3a6ACc/nAIw4nBZzB+FPB0Prfu2
	 UVxQ6vhfolxh9YsdSD1NdWQfVSktIqAWSJiAz88TJlmgWpNe1LIWklhuI8k1D9BMIr
	 A8BbPpHI18C+Q==
Date: Thu, 24 Jul 2025 14:12:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] iio: adc: ad7173: add SPI offload support
Message-ID: <20250724141215.07319298@jic23-huawei>
In-Reply-To: <20250710-iio-adc-ad7173-add-spi-offload-support-v4-1-536857c4e043@baylibre.com>
References: <20250710-iio-adc-ad7173-add-spi-offload-support-v4-1-536857c4e043@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:22:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Enable SPI offload support for the AD7173 ADC driver.
> 
> The scan_type used for SPI offload is assuming that we are using the
> ad411x_ad717x HDL project [1] which always stores data words in 32-bits.
> 
> Link: https://analogdevicesinc.github.io/hdl/projects/ad411x_ad717x/index.html [1]
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I'm going to be optimistic that we don't have any clashes in this new feature
patches with the fix I just queued up.

Applied to the testing branch of iio.git.

thanks,

Jonathan

> ---
> v3 was applied, but then we had to drop the final patch due to a
> conflicting fix. Here is that patch again with the changes needed to
> adjust it to the changes in the fix.
> 
> We'll have to wait for the fix to make it's way back into iio/testing
> before we can apply this patch, so it will have to sit for a while.
> 
> v4 changes:
> - Add one more instance of .supports_spi_offload = true,.
> - Picked up Andy's Reviewed-by tag.
> ---
>  drivers/iio/adc/ad7173.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 9730fda56186afc45f589899e669c41eb538af6b..3886d2f751d0370994ababf72409f4dcb328641d 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -747,6 +747,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
>  	.set_mode = ad7173_set_mode,
>  	.has_registers = true,
>  	.has_named_irqs = true,
> +	.supports_spi_offload = true,
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
>  	.status_ch_mask = GENMASK(3, 0),
> @@ -763,6 +764,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
>  	.set_mode = ad7173_set_mode,
>  	.has_registers = true,
>  	.has_named_irqs = true,
> +	.supports_spi_offload = true,
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
>  	.status_ch_mask = GENMASK(3, 0),
> @@ -779,6 +781,7 @@ static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
>  	.set_mode = ad7173_set_mode,
>  	.has_registers = true,
>  	.has_named_irqs = true,
> +	.supports_spi_offload = true,
>  	.addr_shift = 0,
>  	.read_mask = BIT(6),
>  	.status_ch_mask = GENMASK(3, 0),
> @@ -1595,6 +1598,11 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		if (st->info->data_reg_only_16bit)
>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
>  
> +		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
> +			chan_arr[chan_index].scan_type.storagebits = 32;
> +			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
> +		}
> +
>  		chan_index++;
>  	}
>  
> @@ -1685,6 +1693,12 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		if (st->info->data_reg_only_16bit)
>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
>  
> +		/* Assuming SPI offload is ad411x_ad717x HDL project. */
> +		if (ad_sigma_delta_has_spi_offload(&st->sd)) {
> +			chan_arr[chan_index].scan_type.storagebits = 32;
> +			chan_arr[chan_index].scan_type.endianness = IIO_CPU;
> +		}
> +
>  		chan_index++;
>  	}
>  	return 0;
> 
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250620-iio-adc-ad7173-add-spi-offload-support-32a178b666a3
> prerequisite-change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1:v3
> prerequisite-patch-id: 350fb675f3e0fe494e0ce4ddf5685d9369ffa11a
> 
> Best regards,


