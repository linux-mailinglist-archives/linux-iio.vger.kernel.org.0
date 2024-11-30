Return-Path: <linux-iio+bounces-12854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44329DF11F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7578C1619EB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7A018CC15;
	Sat, 30 Nov 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHT5/OCq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE522066;
	Sat, 30 Nov 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732976404; cv=none; b=T0QXQqVXZHIoENo3GTkQGMOe8rKnKEJPAw/K/mf7BAS+EsMpP+K6Tykcyrgq7H1LEbOzVigxiiS3F3vW//wf+ip9DOwuVC8IjwvSoIqI0t7WhOtdNouoo0wafX1ZODEm3Oqb64Wp0PXSRAFsl2xo3uALEUZYYzMi+8jXUgxfm/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732976404; c=relaxed/simple;
	bh=HgZd1scOEwk7QysjmxPkMJUdRci6tSyTKVgBkXSDKjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC/8EytFcYE0WMQjsQz2Uw8XIwK9XHKAtzf6eXN2K/GEvSQE77qEjZyAvQ20O5yGrNZDCBOiJChot4wNqSDS8yNwLwiJPJfyqOXqt1UbrQSZ02FJeS7PiQg+DVCYCvBKf+DiIi3K7c40ssaLY9OZbXHgoAS+sVs06T9XujNQzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHT5/OCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9426DC4CECC;
	Sat, 30 Nov 2024 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732976404;
	bh=HgZd1scOEwk7QysjmxPkMJUdRci6tSyTKVgBkXSDKjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YHT5/OCqUTAqWhh9zQsB87RkFBMWv9eMpODcujFTvwQHJ65XeIlT8eNRWvz7/ylhv
	 qseGMsq7pabPERWjRfugK46/3mU9f9HrTICNEegHOmRkQl17YwcaUUBcdBGfHedBPw
	 L39z9vwiUTTzq5DnNGzs0+0f+L3yVYPornTV9yi6DFHI9v/NRGDA5aJ2nHRvR5ptbT
	 URb15jBroLtnjCxEUeq4DR8o2lao1KkSVvmdh1BwDWdysPBsNDx4HuA1M6Te5hOWt8
	 ZFaWFrmGLQ06OW6vHXoxlRdK4Y2fQbVivmf1+Qv0GkJ5qQsv0OyeNsP1uBTqOf+DtQ
	 Gd5LcIOnuIxCw==
Date: Sat, 30 Nov 2024 14:19:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/6] iio: core: mark scan_timestamp as __private
Message-ID: <20241130141954.07423793@jic23-huawei>
In-Reply-To: <20241130002710.18615-7-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
	<20241130002710.18615-7-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:27:10 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Since there are no more direct accesses to the indio_dev->scan_timestamp
> value, it can be marked as __private and use the macro ACCESS_PRIVATE()
> in order to access it. Like this, static checkers will be able to inform
> in case someone tries to either write to the value, or read its value
> directly.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  include/linux/iio/iio.h           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 8104696cd475..c332741f3cf4 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1137,7 +1137,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	indio_dev->active_scan_mask = config->scan_mask;
> -	indio_dev->scan_timestamp = config->scan_timestamp;
> +	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
>  	indio_dev->scan_bytes = config->scan_bytes;
>  	iio_dev_opaque->currentmode = config->mode;
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 5661794d1127..669b4ef1280d 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -611,7 +611,7 @@ struct iio_dev {
>  	const unsigned long		*available_scan_masks;
>  	unsigned int			__private masklength;
>  	const unsigned long		*active_scan_mask;
> -	bool				scan_timestamp;
> +	bool				__private scan_timestamp;
>  	struct iio_trigger		*trig;
>  	struct iio_poll_func		*pollfunc;
>  	struct iio_poll_func		*pollfunc_event;
> @@ -908,7 +908,7 @@ int iio_active_scan_mask_index(struct iio_dev *indio_dev);
>   */
>  static inline bool iio_is_soft_ts_enabled(const struct iio_dev *indio_dev)
>  {
> -	return indio_dev->scan_timestamp;
> +	return ACCESS_PRIVATE(indio_dev, scan_timestamp);
If we only end up with one use of this (based on feedback on other drivers)
I'd tempted to deliberately not provide this convenience function and instead
just use ACCESS_PRIVATE() directly in iio_push_to_buffers_with_timestamp()

Nice work. Particularly by highlighting some 'odd corners' in drivers that
probably make no real sense to keep ;)

Jonathan


>  }
>  
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);


