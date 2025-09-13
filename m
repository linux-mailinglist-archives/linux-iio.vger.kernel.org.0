Return-Path: <linux-iio+bounces-24057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77069B5614E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38074485301
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36B2EFD89;
	Sat, 13 Sep 2025 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sieooh8H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD5134BD;
	Sat, 13 Sep 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771836; cv=none; b=hoCFTtGCGFAwdX6Wf0swQyRrXwRiqWslthbOIr3Q5N7DiNKewZdP+4XBODKIgxDtWsikiPd1XcUDvcHS+kNCrcVdqFYOqNjsyNydyO2vlgG/Rm9G+KQ4mXbZf1lV3PvPN8D381kXBMa1dEVcRtf0FR27f1QbaZHUKHFDfY0vG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771836; c=relaxed/simple;
	bh=Hq33pKQBlDo40Z45GgzAh+CujESukr+426evEZ9vEA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vo9RpoChOunngn6A2hNbeUgfRefgHaFpUE56Oc3BBSdB3ixhLNZQgAawOum8IMaO+mwSV+YHt7A9pu3f02cnwnIpqQma/ZeycljH9wph+f5hWNhGuc47A1kDhXAKjqY8Us4CTtwgD0oV7r/2nYVCD8nP7ELWwbFBbK+P875CAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sieooh8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A7AC4CEEB;
	Sat, 13 Sep 2025 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757771836;
	bh=Hq33pKQBlDo40Z45GgzAh+CujESukr+426evEZ9vEA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sieooh8HLOepv0+djlbziXmbiLQT2IFJsd7qPzpI08ReMBwrT+NW8pnYf6IW4YLmo
	 v3voeZZHGZcU695fRHnsZrO4kqwZFoTsrh2GszWhRvhTpg3TWBAcDTx9iy48sL4mIX
	 9styh8IMkGB+1dV2Be9IWQXhjfc48/TtRMMhVVNWODlNFrAsPs3OAXUg681Tym/VEG
	 TbPd+LSrqSpkvVojkKNUdj7c9eqTV7hCidiItoXLWTQ3lOaIqE1S1Sv+H4b4LQLTTJ
	 Nym7ltX7qULDOmhmav6HTawXYlU6SPALmLp2nyXXuoPLCdqWInGGixQJiAFXneEoVE
	 qtYwTQRKlFokA==
Date: Sat, 13 Sep 2025 14:57:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/7] iio: buffer: document calling context when pushing
 to buffers
Message-ID: <20250913145709.7950f975@jic23-huawei>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 11:05:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> It came up in a recent discussion [1] that we need to be careful about
> the calling context for various iio_push_to_buffer*() functions. Here is
> a series that adds some documentation in a number of places to make this
> a bit more visible.
> 
> [1]: https://lore.kernel.org/linux-iio/CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com/
> 
> ---
> David Lechner (7):
>       iio: buffer: document iio_push_to_buffers_with_ts_unaligned() may sleep
>       iio: buffer: iio_push_to_buffers_with_ts_unaligned() might_sleep()
>       iio: buffer: document iio_push_to_buffers_with_ts()
>       iio: buffer: deprecated iio_push_to_buffers_with_timestamp()
>       iio: buffer: document iio_push_to_buffers() calling context
>       iio: buffer: document store_to() callback may be called in any context
>       iio: buffer: document that buffer callback must be context safe
> 
>  drivers/iio/buffer/industrialio-buffer-cb.c |  1 +
>  drivers/iio/industrialio-buffer.c           |  8 ++++++++
>  include/linux/iio/buffer.h                  | 22 +++++++++++++++++-----
>  include/linux/iio/buffer_impl.h             |  3 ++-
>  include/linux/iio/consumer.h                |  3 ++-
>  5 files changed, 30 insertions(+), 7 deletions(-)
> ---
> base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
> change-id: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df
> 
> Best regards,

Whilst this is very nearly good to go (assuming the might_sleep() discussion
is done), I'm going to be lazy and ask for a v2 to resolve that DEPRECATED
comment style thing and the tiny change I asked for.

Thanks for doing this and I'm a bit embarrassed that I didn't document
the with_ts() function when introducing it :( 

Jonathan
 

