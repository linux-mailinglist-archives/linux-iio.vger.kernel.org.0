Return-Path: <linux-iio+bounces-19140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261DEAA999F
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FB43A6ADF
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA3267703;
	Mon,  5 May 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0K23mVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5FE61FF2;
	Mon,  5 May 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463655; cv=none; b=pbWHLw8CQkF01t5T+sZqPyvoNprpJX1bI4kzBpuVawtj0rJAGXm2C8Lt6ehTO9JanU0Xbq3vFvLzGmuLaGMy/xyDlwrWt5yz2Uqce6EiyJIgxAs9Gz1FLTKIWeph+v1vk0fE1sM8MRO5jY82KsC418zFwJhhjoNqX0C6s1/gPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463655; c=relaxed/simple;
	bh=I3lVk2Q64JSR7tBffHJPKcwgPr9JNnLARrE2qnLrjzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV2NdDiHd/2PDiuyDqt624kkHadaD3AgvuitllnIqHk5lYtkgScUMi2NxvUhUaTNYBcGU60FuY52cOMx/TZfl2zbBIOlYh6/AMm7NV/G7gFqCIhhwLQjHutQzHMjqdMbhc0XCY/9GOcAxFhSlOBi2Phkm/wxFjs//b1hoGoTPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0K23mVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64C4C4CEE4;
	Mon,  5 May 2025 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463655;
	bh=I3lVk2Q64JSR7tBffHJPKcwgPr9JNnLARrE2qnLrjzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0K23mVLk8Bcnd/xrbdh38kr6sIFLw5v1Q0hf6MHZr24qlTV8MqXdHlzqj+XreFg/
	 yAOlLKB7g4inNaxoYEf05tQAkpsa9O5vnLNrMkQDl0An02hzB1a/6+/UNURHVMA+1S
	 js8JS+50+VYLeKuKPahFUuFt/BMCrbiGtoOlvki77Zd0AW/e3HDC43mZNV5QQEQwFE
	 3DD7maxQWQZohnxZeAJQUOkuqpT3kV31v8MAZAq8IV3jb599aSupsSXWk8xSs97sgs
	 FVeNDBVCe18yxTvf+EIWFV5CYdKVn6JM3IgXtjL+UyeFxrB1ZpR/0xhEJxpIPW/V0e
	 /jw5z0ZnM0SHw==
Date: Mon, 5 May 2025 17:47:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Trevor Gamblin
 <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 0/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250505174724.686d61b5@jic23-huawei>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 11:31:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Creating a buffer of the proper size and correct alignment for use with
> iio_push_to_buffers_with_ts() is commonly used and not easy to get
> right (as seen by a number of recent fixes on the mailing list).
> 
> In general, we prefer to use this pattern for creating such buffers:
> 
> struct {
>     u16 data[2];
>     aligned_s64 timestamp;
> } buffer;
> 
> However, there are many cases where a driver may have a large number of
> channels that can be optionally enabled or disabled in a scan or the
> driver might support a range of chips that have different numbers of
> channels or different storage sizes for the data. In these cases, the
> timestamp may not always be at the same place relative to the data. To
> handle these, we allocate a buffer large enough for the largest possible
> case and don't care exactly where the timestamp ends up in the buffer.
> 
> For these cases, we propose to introduce new macros to make it easier
> it easier for both the authors to get it right and for readers of the
> code to not have to do all of the math to verify that it is correct.
> 
> I have just included a few examples of drivers that can make use of this
> new macro, but there are dozens more.

Looks good to me.  I'll leave it on list for a day or two though for
everyone else to take a final look!
> 
> ---
> Changes in v5:
> - Add new patch to set minimum alignment to 8 for IIO_DMA_MINALIGN.
> - Adjust IIO_DECLARE_DMA_BUFFER_WITH_TS() macro for above change.
> - Drop one ad4695 patch that was already applied.
> - Link to v4: https://lore.kernel.org/r/20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com
> 
> Changes in v4:
> - Dropped static_assert()s from the first patch.
> - Handle case when IIO_DMA_MINALIGN < sizeof(timestamp).
> - Added one more patch for ad4695 to rename a confusing macro.
> - Link to v3: https://lore.kernel.org/r/20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com
> 
> Changes in v3:
> - Fixed a few mistakes, style issues and incorporate other feedback (see
>   individual commit message changelogs for details).
> - Link to v2: https://lore.kernel.org/r/20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com
> 
> Changes in v2:
> - Add 2nd macro for case where we need DMA alignment.
> - Add new patch for ad4695 to convert buffer from u8 to u16 before
>   making use of the new macro.
> - Drop the bmp280 patch since it was determined to have a better
>   alternative not using these macros.
> - Add a few more examples to show the non-DMA case, both in a struct and
>   stack allocated.
> - Link to v1: https://lore.kernel.org/r/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com
> 
> ---
> David Lechner (7):
>       iio: make IIO_DMA_MINALIGN minimum of 8 bytes
>       iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
>       iio: adc: ad4695: use IIO_DECLARE_DMA_BUFFER_WITH_TS
>       iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
>       iio: adc: ad7380: use IIO_DECLARE_DMA_BUFFER_WITH_TS
>       iio: accel: sca3300: use IIO_DECLARE_BUFFER_WITH_TS
>       iio: adc: at91-sama5d2: use IIO_DECLARE_BUFFER_WITH_TS
> 
>  drivers/iio/accel/sca3300.c        | 18 ++--------------
>  drivers/iio/adc/ad4695.c           | 11 +++++-----
>  drivers/iio/adc/ad7380.c           |  3 +--
>  drivers/iio/adc/at91-sama5d2_adc.c | 13 ++----------
>  include/linux/iio/iio.h            | 42 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 52 insertions(+), 35 deletions(-)
> ---
> base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
> change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
> 
> Best regards,


