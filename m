Return-Path: <linux-iio+bounces-20076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D316AC9BAE
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB1D17C182
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B65185E4A;
	Sat, 31 May 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+CRmwRm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02117A31D;
	Sat, 31 May 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708324; cv=none; b=DSwXZWzekZb2ISc88T7+esSANWodto0QUkXF4bcpGpVTXVOQ49vdBhw02/+FvuacqTzk1eOUz7VnjA3drSMCEnJQFrG1wxiPyeNtj+jpe2khPmqNlNcDHpGmn81ejld41dxLyvCivMFJENYFOXuftnZepnU8zVqTVibs8jfDoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708324; c=relaxed/simple;
	bh=6XW6rvHYYe6NmPi1aP+xp49GhLfblEpiI49g8P2fQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbc01hiSYuyMcEuDYY3PmblwFW6dzogW42UMgxtlNIxRUa22qLNcRy/THk6cZDr9KY6RNBU0LXnseXwPVbyQxVUQCwOILZLhQG0PqneUToLKVhBHUZ1FfXKjPlWmubwHSdVlvUK6K1eLD9veDT45X/S7rTCPE+T5qCJJ/y8YNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+CRmwRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D69C4CEE3;
	Sat, 31 May 2025 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748708324;
	bh=6XW6rvHYYe6NmPi1aP+xp49GhLfblEpiI49g8P2fQCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+CRmwRmFU8uaIsjGDgRT3CVvlci4orRZbUsCVLLv/nq+AVeNNNXsXNA32r+/UoLr
	 leYRBoJYCcVYBNrUO2eQ/u5nNwemPFAOtf12IdRAZZqFAtdFg2oHc5juFotn7OZUXI
	 7rSwyC8ui515g9fTbBUmsKJKK954HwLPS6qVp8ebF7gJIqXU2AbDrFkUkNnp/BZOYk
	 K3FsuRC88S+mQuzUID9CbeclTTtz9PV0okK+Z0jOJYJPzcLeFYK8UHxb3UazFy5MLl
	 27Mt8gc1pcU6dOjPM8sQwY9+PK8k2HfCM7+2T6ugxAnPpRaU9igsmcgNwYflAcm8mD
	 9AFu3YnX7iWEA==
Date: Sat, 31 May 2025 17:18:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Guillaume Stols <gstols@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
Message-ID: <20250531171837.1490051a@jic23-huawei>
In-Reply-To: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v2-1-ad2dfc0694ce@baylibre.com>
References: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v2-1-ad2dfc0694ce@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 16:50:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Mask the value read before returning it. The value read over the
> parallel bus via the AXI ADC IP block contains both the address and
> the data, but callers expect val to only contain the data.
> 
> axi_adc_raw_write() takes a u32 parameter, so addr was the wrong type.
> This wasn't causing any issues but is corrected anyway since we are
> touching the same line to add a new variable.
> 
> Cc: stable@vger.kernel.org
> Fixes: 79c47485e438 ("iio: adc: adi-axi-adc: add support for AD7606 register writing")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I've applied this to my temporary fixes-togreg-for-6.16 branch for now.
That will get rebased on rc1 once available.  As such I'm fine adding
tags or indeed dropping it again if others have feedback!

Jonathan

> ---
> Changes in v2:
> - Use ADI_AXI_REG_VALUE_MASK instead of hard-coding 0xFF.
> - Introduce local variable and use FIELD_PREP() instead of modifying val.
> - Link to v1: https://lore.kernel.org/r/20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v1-1-ce8f7cb4d663@baylibre.com
> ---
>  drivers/iio/adc/adi-axi-adc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index cf942c043457ccea49207c3900153ee371b3774f..fc745297bcb82cf2cf7f30c7fcf9bba2d861a48c 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -445,7 +445,7 @@ static int axi_adc_raw_read(struct iio_backend *back, u32 *val)
>  static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
>  {
>  	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> -	int addr;
> +	u32 addr, reg_val;
>  
>  	guard(mutex)(&st->lock);
>  
> @@ -455,7 +455,9 @@ static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
>  	 */
>  	addr = FIELD_PREP(ADI_AXI_REG_ADDRESS_MASK, reg) | ADI_AXI_REG_READ_BIT;
>  	axi_adc_raw_write(back, addr);
> -	axi_adc_raw_read(back, val);
> +	axi_adc_raw_read(back, &reg_val);
> +
> +	*val = FIELD_GET(ADI_AXI_REG_VALUE_MASK, reg_val);
>  
>  	/* Write 0x0 on the bus to get back to ADC mode */
>  	axi_adc_raw_write(back, 0);
> 
> ---
> base-commit: 7cdfbc0113d087348b8e65dd79276d0f57b89a10
> change-id: 20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-f2bbb503db8b
> 
> Best regards,


