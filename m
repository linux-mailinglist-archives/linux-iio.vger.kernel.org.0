Return-Path: <linux-iio+bounces-24056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043EB5614B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA6583758
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B552EFD86;
	Sat, 13 Sep 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiFit0yF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951363D81;
	Sat, 13 Sep 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771651; cv=none; b=dcoJOtC1+taX9g4736P/Z0v4gvHKaXBuQLSzGrekkb2fbcVzXVpquenDpa2u39mqQPFfC0uCbEHuXwScR+IDK3/bbKb/ng+bxlo/dx1uN9QpbdSOzcdqaxrK2l0iin1X8z6R3fk5djjl/grHSA0J2SO5HrTtNhto9zeprdKuDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771651; c=relaxed/simple;
	bh=whKi2UMf5nIAfra3uI48bpwUgAp4ncR7cemem7miOeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWDoLqGVWL+cxKfwOZQ5vBT4FK1gz7cKzt/hDSFRZIHrpmzh5jgnTSfaZIFIjx6mkD9PzsdtE2q7dS2Q7Y2Aq8mfe2H0jLXDuGkKzpqe7KevzV/cAbnefgkZ1k0QgBri+XfV7I5BYRRRQ4NuHeqHaK+Q2e52oHX/5GdAU8Zit4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiFit0yF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B123EC4CEEB;
	Sat, 13 Sep 2025 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757771651;
	bh=whKi2UMf5nIAfra3uI48bpwUgAp4ncR7cemem7miOeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SiFit0yFbAPqbEqg4sfTBfPV2CY/YiLKymj/8ThTyhwI1JL3r9sgUYQ4/W00e8PLD
	 rnCzHTSJ3NoyHEwm/pR0w+mDaTBbr34KVs3KpNrYQWTwubpJoyOmcj/eUl10X2L6kA
	 RCkF8l5HAGvLqsdncqCNoLGJP3EZV1+a/TzTXz1ylL1PqBZacAqpH4ZizAijMeaRJo
	 DIAplYmPhU0qdE/Uujum2OzDLkb0MEgpd9U7GhAuBLRF2fLdpbr7gl+/m2/79y7FaL
	 iykqbKwd0/CG2YbaDWdEi5lspLTQri28XwbaX/bFHKXika2zC9QrWuiNKUri1j0Rws
	 SlDn/uVvgX4fw==
Date: Sat, 13 Sep 2025 14:54:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/7] iio: buffer: document iio_push_to_buffers_with_ts()
Message-ID: <20250913145403.6e07d7a9@jic23-huawei>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-3-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
	<20250912-iio-doc-push-to-buffers-context-v1-3-c4aad013d96e@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 11:05:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Document the iio_push_to_buffers_with_ts() function.
> 
> This is copied and slightly cleaned up from
> iio_push_to_buffers_with_timestamp().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  include/linux/iio/buffer.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 5c84ec4a981001dfba3b369f811368bab70a3117..47f23bc0470eaf308fc3a739faaf9b56cac0ef67 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -45,6 +45,22 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>  	return iio_push_to_buffers(indio_dev, data);
>  }
>  
> +/**
> + * iio_push_to_buffers_with_ts() - push data and timestamp to buffers
> + * @indio_dev:		iio_dev structure for device.
> + * @data:		Pointer to sample data buffer.
> + * @data_total_len:	The size of @data in bytes.
> + * @timestamp:		Timestamp for the sample data.
> + *
> + * Pushes data to the IIO device's buffers. If timestamps are enabled for the
> + * device the function will store the supplied timestamp as the last element in
> + * the sample data buffer before pushing it to the device buffers. The sample
> + * data buffer needs to be large enough to hold the additional timestamp
> + * (usually the buffer should be indio->scan_bytes bytes large).
usually the buffer should be at least indio->scan_bytes bytes large)

It is really common for it to be bigger and don't want people thinking the
need to dynamically resize it!

> + *
> + * Context: Any context.
> + * Return: 0 on success, a negative error code otherwise.
> + */
>  static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
>  					      void *data, size_t data_total_len,
>  					      s64 timestamp)
> 


