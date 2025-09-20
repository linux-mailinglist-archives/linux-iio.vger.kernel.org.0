Return-Path: <linux-iio+bounces-24323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2347B8C748
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D5A568114
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B62FF151;
	Sat, 20 Sep 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tILdfglO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE018BBB9;
	Sat, 20 Sep 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369588; cv=none; b=qkH0Ga3dIkWoIpQ4np2zmDoUkJHJjZA4MA6zbd30Yakkqj64JajQmqLKgRi2GC9KkQ2wN76ggfhzongKpBiNTIY0V0L8X5fk8P2S3LQfKYBcF2/lPCK6QVyG4lquNHEmvdDyZnBI1fD0e3ljVurmbJSPAFaO01Fltwy2VxfZ6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369588; c=relaxed/simple;
	bh=rbObJhdeNOcwdobNhZVe9zNTg1foi8NxuqvXyPkUk90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhmX0uXclC/xvnzKo7V5BkrJjCGiF1dSKkF015afQp8nIwdhz3HOJIG8RMv0+IpDhufTCbf9184OegkWuxKvdCTNhbqfvngBUzcM39SsyJ/KtPdaVojqIWg8+t6zW0TCqBnLHEkqXsmCf615xscjruch/hXSBRX23bfW15d7GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tILdfglO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882E7C4CEEB;
	Sat, 20 Sep 2025 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758369588;
	bh=rbObJhdeNOcwdobNhZVe9zNTg1foi8NxuqvXyPkUk90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tILdfglOTc1Ih+Frq4vQGSZ9xRBHXJGjpG4EW1/dsNy331zoRQTi7Ocyzcwu3bO2i
	 TJ8jnrshiXxC7Ag4TwT/farylFSxhftEh3uEVrr2bHT60wWooywnhKXxsAvW3oBCph
	 rr9U9JvqKpJ2nr/Ig2/6i1wQNtHoAzZaOJzZFpx3aUNmLi3r2kM/rpAxxK7KKl/DWo
	 MbiYGL+3xdqCep4GiWB7cer3Wj0F4wB27PgulRPEUzQg7+51pkiHmD1+SI3LVAiTzx
	 +txE88UV3rD6ZaQQvIYK4rGA511BFV0IVqoQFT82wyE3aD3X/+F6/2tcpLZu8eSBS/
	 OJL0IKw/XKfsg==
Date: Sat, 20 Sep 2025 12:59:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/7] iio: buffer: document calling context when
 pushing to buffers
Message-ID: <20250920125940.275c597c@jic23-huawei>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 16:02:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> It came up in a recent discussion [1] that we need to be careful about
> the calling context for various iio_push_to_buffer*() functions. Here is
> a series that adds some documentation in a number of places to make this
> a bit more visible.
> 
> [1]: https://lore.kernel.org/linux-iio/CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com/
> 
Great, thanks for doing this.

Applied to the testing branch of iio.git

Jonathan

> ---
> Changes in v2:
> - Picked up a review tag (PATCH 1)
> - Clarified comment about scan buffer size (PATCH 3)
> - Use DEPRECATED to signal function deprecation (PATCH 4)
> - Link to v1: https://lore.kernel.org/r/20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com
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
> base-commit: 671b9b6d7f4fe17a174c410397e72253877ca64e
> change-id: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df
> 
> Best regards,


