Return-Path: <linux-iio+bounces-19341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D914AB0364
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE003B621E
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCC4288C96;
	Thu,  8 May 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C06H33rL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAB4B1E7A;
	Thu,  8 May 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731386; cv=none; b=IXRk/g0ZxM5MJYLJQotEvUyrPX13J9jIH8KKJlVV/xu1FW4pNQx6jgVhXrfXqD/gMNDP8skXlI6I2LgY45AsqU1SFGL8MYo9KVuBDDqRuCQxXoWmbcdcRHv6UdheE25Kykms9+A79d9XKExOEg9nDQLDRsY8VktFIfNJYiYmzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731386; c=relaxed/simple;
	bh=me6txw57vhs5SsbfAubqX6TYDea8ZDjc37uBING6fJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDf6ltnkzLmwBf8oikdNpxTKfvbCZQmhoz2aJlpb8CjlbfTfji6Q0O4zmu1VOBlQuRX9G36YFQeMmtIJ7fnft7Oe8UYPmnRJlxTmtpTU+p1Gnr1xiZxFoZufTVr1hV/gAmApCTfQHxv3yT5+3Mbbs0eFWD1NycWPSJJ801D3Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C06H33rL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1CC4CEE7;
	Thu,  8 May 2025 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731383;
	bh=me6txw57vhs5SsbfAubqX6TYDea8ZDjc37uBING6fJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C06H33rLlOoM4MMRXNqpurLteNidCyO7g2KSbZZv8gpUv3gbWQPJphmVV2h7BgZtA
	 zEkS9VT7o+j9TB+1TjLY8aBBBbb3LVb9+3TUK0+1ffBG7yHpfCwU83CN6ww9e9cjBm
	 D397oyRg0Fbq3KvaAN2quAE9XFnu/fCshZxhSy1YmTKyu5tNMSfUlf+JikWYRwyPsb
	 CCgR8NwaDhL2n1YfCXmieINf3UWvpJckLFKLxjtgxCPSznwL/QZb+mwevK92ssMRWT
	 zuoWho2URHV/VI7B8JHGSykTxSxCgo5W14NWdYmUin7KOtVDcKAy7jm7Pk/05j674d
	 9WXy5rHAVrIKg==
Date: Thu, 8 May 2025 20:09:33 +0100
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
Subject: Re: [PATCH v6 0/7] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250508200933.5b1ad6af@jic23-huawei>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 May 2025 15:42:39 -0500
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
> 
Seems better.  Applied and pushed out as testing to see if any other
compiler versions don't like it!

J
> ---
> Changes in v6:
> - Rework IIO_DMA_MINALIGN to work around clang compiler issue.
> - Link to v5: https://lore.kernel.org/r/20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com
> 
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
>  drivers/iio/accel/sca3300.c        | 18 ++---------------
>  drivers/iio/adc/ad4695.c           | 11 +++++-----
>  drivers/iio/adc/ad7380.c           |  3 +--
>  drivers/iio/adc/at91-sama5d2_adc.c | 13 ++----------
>  include/linux/iio/iio.h            | 41 +++++++++++++++++++++++++++++++++++++-
>  5 files changed, 50 insertions(+), 36 deletions(-)
> ---
> base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
> change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
> 
> Best regards,


