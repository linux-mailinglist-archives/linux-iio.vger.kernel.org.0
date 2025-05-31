Return-Path: <linux-iio+bounces-20089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE31AC9C29
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1242917F8C0
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AD7260A;
	Sat, 31 May 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJr++5aH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE4645;
	Sat, 31 May 2025 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748714490; cv=none; b=YwHaicY7brWzbOaCDHwLj78Ioeal3GZ7MDGpJOolDxKNsrfmexmDWX3HJFhwC14rkUBXNXYHCgYJBUR/VgOiTwLhfz27jS8nx7YaQn0SdhUqBm4VP+FTv57MTZZJDVo/FGn7fh3mw8QH0xfSCHHdxN6v0+SVNBEgU5O82z0TcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748714490; c=relaxed/simple;
	bh=3f5z1sc5+Pgcw89xps+F1E5eYIZX9QvaPM8JVy0CBG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXGei8tZ0Od19twH72pYV7iDAt8nrmclB3C/GHdpoXnCs6pTStnddW1lrYMMM7E/9Ty6pWinZzPsTpdze38kaPlracvjAL9QMNqjX3LL7WRraSADcvL8hA6uydjZ2wM3ZX8/G+lvM2aKfJy761J5sCYuhDc9HNe+fXqtiCzWu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJr++5aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1760C4CEEA;
	Sat, 31 May 2025 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748714489;
	bh=3f5z1sc5+Pgcw89xps+F1E5eYIZX9QvaPM8JVy0CBG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJr++5aH7UJJjE0f90S3etJRSC5oJu8UkgXzrGT2Ri/wcXOGXBr0fMKO23d5mLk2O
	 MatmIbDbHcuMiyAEK/DuzTEaxNQEMIFZYysnJfwJdI/fg5S1O+A2I9J0P6yNtPy1PI
	 njapoMUaUV87WAHvlK1E76M/4OPYspyWv67nZENVWqLMX9/d0e82fGFl3n/Pb3Tsg3
	 Qtsdr//+iboafqJop1GIpzUzX3RvcJ94f6jj0wrONd3Yy8a5sewRJCkz+/6OJ/iBrm
	 R3bOyuFAhhV8uL7JXTYfU29Dm+SMGNKlgLOqZwI+7KlHMeLfZIv5HmUtfJrwWoyUKP
	 aJcOUQRslvJ2A==
Date: Sat, 31 May 2025 19:01:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] iio: consumer: Define timestamp-related
 structures and constants
Message-ID: <20250531190124.30704d19@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-2-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-2-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:25:54 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Define the required constants and structures on the consumer side.
> 
> The `timestamp_enabled` indicates whether a timestamp is grabbed or not.
> This is passed to `iio_triggered_buffer_setup_new()` as an argument.
> 
> The `timestamp_type` indicates which handler grabs the timestamp.
> This value is set by `iio_poll_func_register()`.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  include/linux/iio/trigger_consumer.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 2c05dfad88d7..5e6ff8738386 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -13,6 +13,13 @@
>  struct iio_dev;
>  struct iio_trigger;
>  
> +enum iio_timestamp_type {
> +	IIO_TIMESTAMP_TYPE_NONE,
> +	IIO_TIMESTAMP_TYPE_CONSUMER_TOP_HALF,
> +	IIO_TIMESTAMP_TYPE_CONSUMER_BOTTOM_HALF,
> +	IIO_TIMESTAMP_TYPE_TRIGGER,
> +};

This needs documentation. I'm struggling even with the series in front of me
to understand what each of these means. The comment below helps somewhat
but we should have it alongside the enum.

> +
>  /**
>   * struct iio_poll_func - poll function pair
>   *
> @@ -26,7 +33,10 @@ struct iio_trigger;
>   * @timestamp:			some devices need a timestamp grabbed as soon
>   *				as possible after the trigger - hence handler
>   *				passes it via here.
> + * @timestamp_type:		indicates which handler grabs the timestamp.
> + * @timestamp_enabled:		if true, automatically grabs the timestamp.
>   **/
> +
>  struct iio_poll_func {
>  	struct iio_dev *indio_dev;
>  	irqreturn_t (*h)(int irq, void *p);
> @@ -35,6 +45,9 @@ struct iio_poll_func {
>  	char *name;
>  	int irq;
>  	s64 timestamp;
> +
> +	enum iio_timestamp_type timestamp_type;
> +	bool timestamp_enabled;
>  };
>  
>  
> 


