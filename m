Return-Path: <linux-iio+bounces-13222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78F9E862E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FC218836E3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7CC159209;
	Sun,  8 Dec 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkSbf4EZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E613B2B6;
	Sun,  8 Dec 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733674284; cv=none; b=bLY6EhB+Lb/Xepe9vAPsS+xf+TI3sqJONEeTgQ7SZXUnhuefWjFlDEo94qYyvF2Diy8XKyV1rmxx/OEtilB3MrX5sAujT0/45xRy701ihpL/ysOy4e+9Eb8ZfUhKPP9i06MtZ2vxiLwqGfSgJEhvC41+7VnCRRGwuo6s6lyu7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733674284; c=relaxed/simple;
	bh=30yXLnHhtopFcKkDCWFHVmDRTU+Ly8pTdHjAfA8tUFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/zgt98tgJCj6LKGMIKeXzWNrrw3ZTChMQkWF1eY3qhyg7ynoYGfS0b2b0CWBeIKDQ4jcnsRA2YMqdn9PahkMmifJzjSS5WK4ox2nLnF9jnyZQIbMPNRhi5ICEgj3m9DeWIg2Hl61XDbS42Be6pNK0vwBeJxOo8d4Lq8FudpRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkSbf4EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08191C4CED2;
	Sun,  8 Dec 2024 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733674284;
	bh=30yXLnHhtopFcKkDCWFHVmDRTU+Ly8pTdHjAfA8tUFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkSbf4EZnkGbQKEn1BU/IXnSUybublY6sCIYhTEzZJseVwE/UnTueHq18lUW/b8ei
	 3qNT1W7bAVfDvD7XnaUFIkHkZQrff+Z6msAh+/JM8hsREtBBx1kHkINaP65zHbu8CY
	 zFMveMFALFFzlMTxiHXplSHPCFdD4gsR1AEI8EMDrauogFzfMNSr40GoNNu1E+rjkC
	 /fWyBKQVjXeRSHOfuylXqOiD+zzZlxhcl14rQlqpW+TRIg2bizzVW5LRuTUeTIYnno
	 f+q6L4lBlfR4MtskNHmMCYcBPhiWQArJHQR1FysaXvpwvRBzZFMsfzOHFfnTZPwlI6
	 oDhdkJHamlDTQ==
Date: Sun, 8 Dec 2024 16:11:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 05/10] iio: accel: adxl345: complete list of defines
Message-ID: <20241208161114.2891b783@jic23-huawei>
In-Reply-To: <20241205171343.308963-6-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-6-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Extend the list of constants. Keep them the header file for readability.
> The defines allow the implementation of events like watermark, single
> tap, double tap, freefall, etc.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h | 89 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 3d5c8719db3..ed81d5cf445 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -9,37 +9,102 @@
>  #define _ADXL345_H_
>  
>  #define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_THRESH_TAP	0x1D
>  #define ADXL345_REG_OFSX		0x1E
>  #define ADXL345_REG_OFSY		0x1F
>  #define ADXL345_REG_OFSZ		0x20
> -#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> +/* Tap duration */
> +#define ADXL345_REG_DUR		0x21
> +/* Tap latency */
> +#define ADXL345_REG_LATENT		0x22
> +/* Tap window */
> +#define ADXL345_REG_WINDOW		0x23
> +/* Activity threshold */
> +#define ADXL345_REG_THRESH_ACT		0x24
> +/* Inactivity threshold */
> +#define ADXL345_REG_THRESH_INACT	0x25
> +/* Inactivity time */
> +#define ADXL345_REG_TIME_INACT	0x26
> +/* Axis enable control for activity and inactivity detection */
> +#define ADXL345_REG_ACT_INACT_CTRL	0x27
> +/* Free-fall threshold */
> +#define ADXL345_REG_THRESH_FF		0x28
> +/* Free-fall time */
> +#define ADXL345_REG_TIME_FF		0x29
> +/* Axis control for single tap or double tap */
> +#define ADXL345_REG_TAP_AXIS		0x2A
> +/* Source of single tap or double tap */
> +#define ADXL345_REG_ACT_TAP_STATUS	0x2B
> +/* Data rate and power mode control */
>  #define ADXL345_REG_BW_RATE		0x2C
>  #define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_INT_ENABLE		0x2E
> +#define ADXL345_REG_INT_MAP		0x2F
> +#define ADXL345_REG_INT_SOURCE		0x30
>  #define ADXL345_REG_DATA_FORMAT		0x31
> -#define ADXL345_REG_DATAX0		0x32
> -#define ADXL345_REG_DATAY0		0x34
> -#define ADXL345_REG_DATAZ0		0x36
> -#define ADXL345_REG_DATA_AXIS(index)	\
> -	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> +#define ADXL345_REG_XYZ_BASE		0x32
> +#define ADXL345_REG_DATA_AXIS(index)				\
> +	(ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
> +
> +#define ADXL345_REG_FIFO_CTL		0x38
> +#define ADXL345_REG_FIFO_STATUS		0x39
> +
> +#define ADXL345_DEVID			0xE5
> +
> +#define ADXL345_FIFO_CTL_SAMLPES(x)	(0x1f & (x))

SAMPLES?

> +#define ADXL345_FIFO_CTL_TRIGGER(x)	(0x20 & ((x) << 5)) /* 0: INT1, 1: INT2 */
> +#define ADXL345_FIFO_CTL_MODE(x)	(0xc0 & ((x) << 6))

Supply the mask only and use FIELD_PREP() for these.


>  
> +#define ADXL345_INT_DATA_READY		BIT(7)
> +#define ADXL345_INT_SINGLE_TAP		BIT(6)
> +#define ADXL345_INT_DOUBLE_TAP		BIT(5)
> +#define ADXL345_INT_ACTIVITY		BIT(4)
> +#define ADXL345_INT_INACTIVITY		BIT(3)
> +#define ADXL345_INT_FREE_FALL		BIT(2)
> +#define ADXL345_INT_WATERMARK		BIT(1)
> +#define ADXL345_INT_OVERRUN		BIT(0)
> +
> +#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
> +#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
> +
> +#define ADXL345_INT1			0
> +#define ADXL345_INT2			1
> +
> +/*
> + * BW_RATE bits - Bandwidth and output data rate. The default value is
> + * 0x0A, which translates to a 100 Hz output data rate
> + */
>  #define ADXL345_BW_RATE			GENMASK(3, 0)
> +#define ADXL345_BW_LOW_POWER	BIT(4)
>  #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
>  
> -#define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
> +#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
> +#define ADXL345_POWER_CTL_SLEEP	BIT(2)
> +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
> +#define ADXL345_POWER_CTL_LINK	BIT(5)
>  
>  #define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
> -#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
> +#define ADXL345_DATA_FORMAT_IS_LEFT_JUSTIFIED	BIT(2)
>  #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
> -#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
> -#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
> -
> +#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
> +#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
>  #define ADXL345_DATA_FORMAT_2G		0
>  #define ADXL345_DATA_FORMAT_4G		1
>  #define ADXL345_DATA_FORMAT_8G		2
>  #define ADXL345_DATA_FORMAT_16G		3
>  
> -#define ADXL345_DEVID			0xE5
> +#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
I'm not sure on logic of moving this to the end. Seems fine next
to the definitions of the individual axis to me.

> +
> +/*
> + * FIFO stores a maximum of 32 entries, which equates to a maximum of 33 entries
> + * available at any given time because an additional entry is available at the
> + * output filter of the device.
> + *
> + * (see datasheet FIFO_STATUS description on "Entries Bits")
> + */
> +#define ADXL345_FIFO_SIZE  33
>  
>  /*
>   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB


