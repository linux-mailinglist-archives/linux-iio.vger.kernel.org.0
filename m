Return-Path: <linux-iio+bounces-13678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B032B9F8282
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77810163482
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF01A08AF;
	Thu, 19 Dec 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq8QcRNX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724F19AD5C;
	Thu, 19 Dec 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630561; cv=none; b=jMO5t8xnp19lW8iDaBr2stC11Jw4nY21Kep2V7+H3W+BXI4SOPIc11axj0MjkEUrGMEWadBDuddPjhbXDrOaP7cjBp+/CfGjNsRQd8tHuGPpLoemCgh9B3402AIOM9PR18cvb9CgIdF33vJmtyM+xhCd8dHandJ6dUAJ0/nCPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630561; c=relaxed/simple;
	bh=Kryu+nffy6YaWltwLOac+acLYFPRpLMb+M5nbxeWsSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QALi7I9cQaJ75c6lP3YOGD2AFB+sdW7w9q7441Kb0QSX7wR5xYoYQpWsC1oJ5Pf4b+dsWfeDjEK1F6BoacgFhpgnPsW3XRS7/rZTTuq6Ph1xHOLRK4anCrcYhWFvlF15kgEPjEFF1NXRgzUWieIIpyOFPJ5R4RKjSPE/wMm9aWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq8QcRNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8792C4CED4;
	Thu, 19 Dec 2024 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630560;
	bh=Kryu+nffy6YaWltwLOac+acLYFPRpLMb+M5nbxeWsSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mq8QcRNXrHN6l2jFYHMhqC3T3q/FvgCyXjGGlOpJwNPI0D0KZgH7zu/2DOPUofb1j
	 0pyG4WADFFVedGavrWU13nFYNrSoEYMskDEjOek06k3gEYncm00eJAhWNQu054KV9Z
	 Nzg/6SzGDfQJVM+qx6rG0FChNFKTluDjKPX5+YsGJhOiAA71EW3iYdEYDLISANlNgX
	 n1TlMO3jSb5DEUvluVQ4VROyuAQvDySXXxWfrjQhxYy1i4s5vvyVPLwXfdJAg2/xtm
	 EDbL4S5/TzQRhhL0W6CbWQBjlXd5d3FgZQVWpJhSNHiLJ9o7JE0YXOqRQsVMsnLqw2
	 TlctucD9JawRw==
Date: Thu, 19 Dec 2024 17:49:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, jackoalan@gmail.com,
 k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: core: mark scan_timestamp as __private
Message-ID: <20241219174909.5d03e529@jic23-huawei>
In-Reply-To: <20241214191421.94172-5-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
	<20241214191421.94172-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:14:21 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Since there are no more direct accesses to the indio_dev->scan_timestamp
> value, it can be marked as __private and use the macro ACCESS_PRIVATE()
> in order to access it. Like this, static checkers will be able to inform
> in case someone tries to either write to the value, or read its value
> directly.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.  Thanks

I'll push this out as testing shortly and we can see if 0-day finds
any problems with it.

Jonathan



> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  include/linux/iio/buffer.h        | 2 +-
>  include/linux/iio/iio.h           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2708f87df719..a80f7cc25a27 100644
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
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 418b1307d3f2..3b8d618bb3df 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -37,7 +37,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
>  static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>  	void *data, int64_t timestamp)
>  {
> -	if (indio_dev->scan_timestamp) {
> +	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
>  		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
>  		((int64_t *)data)[ts_offset] = timestamp;
>  	}
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ae65890d4567..56161e02f002 100644
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


