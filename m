Return-Path: <linux-iio+bounces-16699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C3CA5A486
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F9A16725C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665C1E0DD1;
	Mon, 10 Mar 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxA8UZ2h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5691DF97A;
	Mon, 10 Mar 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637599; cv=none; b=f/ihDOjv20W0uNrqaDa3+MRxuy89G8uldw2REFG9OkHrB59Ff0ntOBS8MDtZ7B2PrO5XOSMn1ZWuZYoPZdmSkjxkWmxaSQfUD6gTz+7l+kxn+F/5xyQmI2ZYl8EkXt5jzxsuG4sq1HUkOpAWK3qJ6qnJWjifb4kCWTfXwZhQq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637599; c=relaxed/simple;
	bh=gtJuGx2pDYIwW9VlUcPfXfeo5t97Lj14Q+23BqsZas4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWY2G/eidw6a+POOjDrF0/d7nW5aqGQZhqz+e2KqTB31ZjH+d/iZH6A0SXAqMRpgwg4dw4kqCiQdKsyUSeWwEy06SGXu9ynpFmyYrrghCD0Z4pGTItFQ91rjvCEzE6l/CfKP0udnZUgY608PMQYk+eC2mBKdgCC1fYXy8Fayq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxA8UZ2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F098C4CEED;
	Mon, 10 Mar 2025 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637598;
	bh=gtJuGx2pDYIwW9VlUcPfXfeo5t97Lj14Q+23BqsZas4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uxA8UZ2hSzGB/6zTtZMwQ4gjJbUQ6uJKooCmVZcRv2mNqKRQzlkCsolKDUBvW7nIJ
	 Qd8jzBRAGbA4HXKmwfgaTwh043r42xnDyK1o34D2RBG2b/wWIqoMzayg7jDUn4NqVv
	 ciqKw04wxxW9DvbxSqBzr1HfuvPIztOOvn6BYCbZ8AiDQpE2NUtyPzWJ2do9X6ZRIt
	 A5edK1XHbL2hwdrHqRP125c0nhr/eyGRt9a3dznJp+IeOwDMCPST3vzUxN3WNF0toc
	 NcA2NMpK//GnUr1WmtcjvDGkTeCj0YOOxKKtpXTbUzaw0A1xWjgdNxmTpFys7kRaNR
	 vmkyxs+h98XJw==
Date: Mon, 10 Mar 2025 20:13:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: ad7380: add SPI offload support
Message-ID: <20250310201311.04b56522@jic23-huawei>
In-Reply-To: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
References: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 18:39:51 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Add SPI offload support for the ad7380 ADC.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
I've applied this to the togreg branch of iio.git and pushed
out as testing for 0-day to take a very brief look.

This might well be the last series to make it this cycle depending
on how busy the rest of my week ends up.

Jonathan

> ---
> Changes in v2:
> - fix return value on offload probe,
> - add documentation patch 2/2.
> 
> Changes in v3:
> - fix tabs erroneously added,
> - fix documentation syntax error,
> - add a note for the 4 channels ADC variants.
> - Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com
> 
> Changes in v4:
> - add offload support to adaq4381-4.
> - Link to v3: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com
> 
> ---
> Angelo Dureghello (2):
>       iio: ad7380: add support for SPI offload
>       doc: iio: ad7380: describe offload support
> 
>  Documentation/iio/ad7380.rst |  18 ++
>  drivers/iio/adc/Kconfig      |   2 +
>  drivers/iio/adc/ad7380.c     | 511 ++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 495 insertions(+), 36 deletions(-)
> ---
> base-commit: 73b788d05b5bd82c40193165583a9dcad2d8410e
> change-id: 20250220-wip-bl-spi-offload-ad7380-6f1c27cd815d
> 
> Best regards,


