Return-Path: <linux-iio+bounces-26257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50EC61769
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34634E5F32
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045142D8376;
	Sun, 16 Nov 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMTIVO5G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33047A6B;
	Sun, 16 Nov 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763306567; cv=none; b=X6uZJqwNYlywKFuwdAx44Y2CcfBDXBctJDW4yH31dnb0Fp4PhW4EVgeBkI9GVWjHKlpwOm4od9v+ibFCa8i++CGaxB95CI+YC2GaZ1sIxheEIxvr31OmQUvf5ivkx2ZS4Vg8RiQCSkA1VJX5nX/bGL9edvgKwfSmv/Vr5KZQNuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763306567; c=relaxed/simple;
	bh=WaUOV2B9i+rt3+r1xIYxePt5b41KoZX8WCm6xRRZ0V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy0S7/mUM7n6zO7tNz0l4Xo29BOqvGEbULqQXumJtfvcyeX5B3RREnmmnv8ifZua8rB94SqW3PDw31oB56cP/RNvchmb/j+/ei771/T17FSmAsvfOT6u/KwW8GooQh0/ZbSYARHlXp11Oex7uu9uyp1hbattb1pAko1AL9MGalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMTIVO5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE9DC4AF09;
	Sun, 16 Nov 2025 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763306567;
	bh=WaUOV2B9i+rt3+r1xIYxePt5b41KoZX8WCm6xRRZ0V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMTIVO5G/UIF6tpTVDuUm7Pq4GcpurQKBXuCMaBFMtXBRV1TvY/GPG5OPDbyQ/ICX
	 ymUXp7xIapPgEBWAuNU+n1C8DrXOWiactxSbRFW5PVD7fRxwktgUuClbk8IbExM+pU
	 NrPDmealI5pWODQ7N4gOvXbDN6KmK3okTNXdRSfzjBGsJJFgL8mlbn92GxwASmQXcQ
	 7Q/fuT6+gEopmNlqRq+3eHGQMqfiLI2YUiQX+x4MrYUzz5QyEij0vO/vLVG5cahx5g
	 H3gLDJr1jLKUcxl6Q/SWzNVJueHZivo3aOlgRUm45vd+F8gpsd67zkdCrKtdn8+SKm
	 rX6ZfDjrXDyyQ==
Date: Sun, 16 Nov 2025 15:22:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: pressure: Arrange Makefile alphabetically
Message-ID: <20251116152242.48032558@jic23-huawei>
In-Reply-To: <20251116-61849-3277029@bhairav-test.ee.iitb.ac.in>
References: <20251116-61849-3277029@bhairav-test.ee.iitb.ac.in>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Nov 2025 11:48:49 +0530
Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

> Fix hp206c and st_pressure_* entries in pressure Makefiles to follow
> alphabetical order as per guideline mentioned in iio/pressure/Makefile.
> 
> Fixes: 217494e5b780 ("iio:pressure: Add STMicroelectronics pressures driver")
> Fixes: fa4c9c93e93f ("hp206c: Initial support for reading sensor values")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Definitely not a fix, so fixes tags are not appropriate.

I'll drop those and apply.

Thanks,

Jonathan


> ---
> This is the follow up patch from action item on:
> Link: https://lore.kernel.org/lkml/20251023182721.00002112@huawei.com/
> This is on top of linux-next
> 
>  drivers/iio/pressure/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 47bf7656f975..a21443e992b9 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_HP03) += hp03.o
> +obj-$(CONFIG_HP206C) += hp206c.o
>  obj-$(CONFIG_HSC030PA) += hsc030pa.o
>  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
>  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> @@ -35,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
>  obj-$(CONFIG_T5403) += t5403.o
> -obj-$(CONFIG_HP206C) += hp206c.o
>  obj-$(CONFIG_ZPA2326) += zpa2326.o
>  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
>  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> -
> -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o


