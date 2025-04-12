Return-Path: <linux-iio+bounces-18034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED51A86F15
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 21:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141FA8A8212
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD821A42F;
	Sat, 12 Apr 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HONt0O0r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B2201035;
	Sat, 12 Apr 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744485245; cv=none; b=M1TxlZG3WEMzHPH9mtnKY6Cj8L3c8Axm1pli+dMhpk0Wu96+fBxgIrNy13jQYlO1e4oF5kPC9hD82K0I+80GsjdvKBhwlTNTptTcatxg457OHrrNWSDwDGy4Lb3QMQpr50KzPaJ1zlM3VMAx2OeWQYevIZ8TLQaKHiiDlfcyYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744485245; c=relaxed/simple;
	bh=phbbwr4PicjD/f6kmtd1pzGQUUlvydQ8+1fjj6lloC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxQokBQ3AzaBtQlTVrXajAfKJU0iVHDWeq9p9HeKzLCzLAuXmgAKkP8iLORc2fD9ZADandAqwo7ve+vfJZs7lpt3KQ39HESv/yo6LXFbL31CVVzSn5XyMsE4/6Diah/YvbYf1kg8dtTNoofF34QnfgzWBvYmYmBngXy2zDgk4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HONt0O0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B7CC4CEE3;
	Sat, 12 Apr 2025 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744485244;
	bh=phbbwr4PicjD/f6kmtd1pzGQUUlvydQ8+1fjj6lloC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HONt0O0rczcb66w61a4NnSZl/0mCxFwqlv1UbmHmyKGx1WWChZSSnxKLLksU2tEF9
	 i+zMIYKeOwRouaZT04hV0NNmnoCHNKSSbrKGPMWWMxcDa0ohda7/vqUj5QWVMmf2b5
	 xzoOi0tUvtlJTB228RoTWLx1kAr1zenB6gFdSU5zGbjRBfoqJf5VDkXcgN8UTNlaLj
	 wjZJ8zz6gDca1mKGwfahBZGbbqk3AKDx8Mh5zHR/bXK+CtMn7A+p3nbDdoVH9Y5Ha3
	 ME25VGPBJmkQkWFMHpx5AV40E61fJLvwJK/dFEzd3ziJrjGCWoBxd5TvWJfaBQCnhC
	 fXv5UYTTupc2Q==
Date: Sat, 12 Apr 2025 20:13:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/8] iio: imu: inv_icm45600: add buffer support in iio
 devices
Message-ID: <20250412201354.45eb4dd2@jic23-huawei>
In-Reply-To: <20250411-add_newport_driver-v1-5-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
	<20250411-add_newport_driver-v1-5-15082160b019@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 13:28:37 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add all FIFO parsing and reading functions. Add accel and gyro
> kfifo buffer and FIFO data parsing. Use device interrupt for
> reading data FIFO and launching accel and gyro parsing.
> 
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
I'm out of time and energy today. So just one trivial thing inline.
I'll look more closely at v2 after the patches have been reorganized
to build up features as you go.

Thanks,

Jonathan

> +
> +/**
> + * inv_icm45600_buffer_update_watermark - update watermark FIFO threshold
> + * @st:	driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * FIFO watermark threshold is computed based on the required watermark values
> + * set for gyro and accel sensors. Since watermark is all about acceptable data
> + * latency, use the smallest setting between the 2. It means choosing the
> + * smallest latency but this is not as simple as choosing the smallest watermark
> + * value. Latency depends on watermark and ODR. It requires several steps:
> + * 1) compute gyro and accel latencies and choose the smallest value.
> + * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
> + *    ones. Otherwise it is possible that you don't meet a requirement. (for
> + *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
> + *    value of 4 will not meet accel latency requirement because 6 is not a
> + *    multiple of 4. You need to use the value 2.)
> + * 3) Since all periods are multiple of each others, watermark is computed by
> + *    dividing this computed latency by the smallest period, which corresponds
> + *    to the FIFO frequency.
> + */
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
> +{

> +	raw_wm = INV_ICM45600_FIFO_WATERMARK_VAL(watermark);
> +	memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> +	ret = regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
> +				st->buffer, sizeof(raw_wm));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
trivial but return regmap_bulk_write()

> +}


