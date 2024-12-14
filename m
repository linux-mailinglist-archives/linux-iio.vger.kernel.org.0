Return-Path: <linux-iio+bounces-13453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A114F9F1E97
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DC316758C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A81922D7;
	Sat, 14 Dec 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLE71RCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890863CF58;
	Sat, 14 Dec 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734179975; cv=none; b=SzdwoW3zDQacv0zfO5XboeaYkF6sCg4aoi8J6W0wBH2XYkaY1LF/ActvbASqO0PIqiV7CwbxyetTnZNhpjcJ9HEza5ppTK40oe7qa0HYCyZbUw3VgFx8fc/EOe8Yg5SS0LtojApZTzKywFy8C8QJLoY5wOFA0CFa/w1EWfwFGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734179975; c=relaxed/simple;
	bh=OnTrxdOhvgux4nysU2LSezSSY4MpmjIO3lCBfQboZfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9/aUtq4wVwUC2HJ7kde2c2jlRA1CDmGxJNvgGgJ5Nxu0CnmpqcOcx5P3u5uFiUiCzSQpzA/nNcJfmxu9+sv/CueGPjg5CgtlgbDq8H8PAATdOzRf8LZGiNXSHsbOmsSzvK62rwQ81U57Nb2LP8GUhNA6GYk9PQlIudTDGW+/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLE71RCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A693C4CED1;
	Sat, 14 Dec 2024 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734179975;
	bh=OnTrxdOhvgux4nysU2LSezSSY4MpmjIO3lCBfQboZfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RLE71RCSGwBrq7YnDk369xGV/O2CpaTYI2ZKJnRyCkWOlaK2MA2bcjPkK58gRySfg
	 h9w8cMgUdhVnse0c7P/pC3t31aZbGTK29oUkMePZLZYC6OVvb2byZ9R6z1SftmDS/9
	 vGteCCW1F826G6uXsfI/p8GrFizvO+N3OfRD3VQACpP1LmISwFOwINmP+4kjfpNu9e
	 Y9ftTtx2HwwVjq0Jf/Mzx6xxXC91HmqX0ogap0QEUSrn1hmFrpz268GYoCoMVjhuau
	 Mrk34n2Q9UT3gkNtAqiwF7mhU4prqQvHogdeT6iMBB77iNWcbVo9+gdARcd5LGJhpn
	 DTJ1w86pG9VoQ==
Date: Sat, 14 Dec 2024 12:39:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 7/7] iio: accel: adxl345: complete the list of
 defines
Message-ID: <20241214123926.0b42ea59@jic23-huawei>
In-Reply-To: <20241213211909.40896-8-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:09 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Having interrupts events and FIFO available allows to evaluate the
> sensor events. Cover the list of interrupt based sensor events. Keep
> them in the header file for readability.

That makes sense for now, but longer term I'd attempt to restrict the scope
of these by moving them to the top of core.c

The two bus drivers don't use any of them that I can immediately spot
and if they do it is likely to be very few.

That may be a good first patch for your next series.

Jonathan


> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h | 57 +++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index bf9e86cff..df3977bda 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -9,10 +9,35 @@
>  #define _ADXL345_H_
>  
>  #define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_THRESH_TAP		0x1D
>  #define ADXL345_REG_OFSX		0x1E
>  #define ADXL345_REG_OFSY		0x1F
>  #define ADXL345_REG_OFSZ		0x20
>  #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> +
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
> +#define ADXL345_REG_TIME_INACT		0x26
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
>  #define ADXL345_REG_INT_ENABLE		0x2E
> @@ -34,20 +59,40 @@
>  #define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
>  
>  #define ADXL345_INT_DATA_READY		BIT(7)
> +#define ADXL345_INT_SINGLE_TAP		BIT(6)
> +#define ADXL345_INT_DOUBLE_TAP		BIT(5)
> +#define ADXL345_INT_ACTIVITY		BIT(4)
> +#define ADXL345_INT_INACTIVITY		BIT(3)
> +#define ADXL345_INT_FREE_FALL		BIT(2)
>  #define ADXL345_INT_WATERMARK		BIT(1)
>  #define ADXL345_INT_OVERRUN		BIT(0)
> +
> +#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
> +#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP
> +
> +/*
> + * BW_RATE bits - Bandwidth and output data rate. The default value is
> + * 0x0A, which translates to a 100 Hz output data rate
> + */
>  #define ADXL345_BW_RATE			GENMASK(3, 0)
> +#define ADXL345_BW_LOW_POWER		BIT(4)
>  #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
>  
>  #define ADXL345_POWER_CTL_STANDBY	0x00
> +#define ADXL345_POWER_CTL_WAKEUP	GENMASK(1, 0)
> +#define ADXL345_POWER_CTL_SLEEP	BIT(2)
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_AUTO_SLEEP	BIT(4)
> +#define ADXL345_POWER_CTL_LINK		BIT(5)
>  
> -#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
> -#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
> -#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
> -#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)	/* 3-wire SPI mode */
> -#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
> -
> +/* Set the g range */
> +#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)
> +/* Data is left justified */
> +#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)
> +/* Up to 13-bits resolution */
> +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
> +#define ADXL345_DATA_FORMAT_SPI_3WIRE	BIT(6)
> +#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)
>  #define ADXL345_DATA_FORMAT_2G		0
>  #define ADXL345_DATA_FORMAT_4G		1
>  #define ADXL345_DATA_FORMAT_8G		2


