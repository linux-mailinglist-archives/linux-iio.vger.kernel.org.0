Return-Path: <linux-iio+bounces-22059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E0B130A6
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D46A3B5E32
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877021C9F2;
	Sun, 27 Jul 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUwNkUhy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF6217654;
	Sun, 27 Jul 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634149; cv=none; b=Vbk7iBkDZk+SJIgvqOeDMCcnGwo4eH0JRsTlMwg1vntGAnZR3SdNKXPqhsL1MtiCbMBigHzRXbrk2VJ0P6GDy3b2hhRMEZaGPUr/70zppqPYH9RadSb+iZXiT6PfsZYkE1z/l3pH5J/vh/uLv51SE0Y0glm1a8B1LBDbommwzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634149; c=relaxed/simple;
	bh=Q55FI8Tt8Kr7umjcKD3pA+4CQ6dnrVZGnUz670qXJEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swhfEwUwG4AVpmiJ67AmOv5XGjUFHNutn9uo4/TXS1usHYMzAjVJhnlItF0TTBudtnbZuJYQN6bIIjAN5xnaBncdquGMdMj0NjdJek+iDjSoIczM1nSle8UpgpaeYGXRJ6j7neDpIbOfvi/zeOmETJj4MiWc04KcEj+JpLwBs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUwNkUhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0D6C4CEEB;
	Sun, 27 Jul 2025 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753634148;
	bh=Q55FI8Tt8Kr7umjcKD3pA+4CQ6dnrVZGnUz670qXJEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUwNkUhyHuBNUzwcGE0SE4xTTXmcCrFT9ExXx2oo7rxgMMzqNkt3Ejotsqt1KyGsx
	 i8TXeUxCFSHxaQp4B3bS3jDuaYB+u+8S1a9y5gaLz+MBuSNxvADrTtMSYae00vnPuY
	 Z8p8ogFdYXRi56JdJ71sFAl/dh6pnbayxJi6CXnHefcgJ3km2PGtq77zg3RO4JtlwX
	 trlRHglZNElp0Xo/3iU7twlBNpuxiOQJCvr0XfSNXzLZHcjxRntvsXcoQAyxqAyi9k
	 dsj4gF1nzfGQ5XXHMeQlSw+VolvaH68IRC0ZjANzP98Xc9+KuYGYftiQ/nTn4BpaBy
	 HOY4GFy1tNBqw==
Date: Sun, 27 Jul 2025 17:35:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
Message-ID: <20250727173542.46680071@jic23-huawei>
In-Reply-To: <20250715012023.2050178-7-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-7-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 21:20:22 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Add support for minimum/maximum attributes. Like the _input attribute,
> we just need to call into the IIO API.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Similar comments to previous. I'm not keen on the blend of allocation of
attributes and registration.  If we can break that link I think it will give
cleaner code.

>  static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
>  			   ssize_t (*show)(struct device *dev,
>  					   struct device_attribute *attr,
> @@ -123,6 +171,40 @@ static int add_device_attr(struct device *dev, struct iio_hwmon_state *st,
>  	return 0;
>  }
>  
> +static int add_event_attr(struct device *dev, struct iio_hwmon_state *st,
> +			  int i, enum iio_event_direction dir,
> +			  const char *fmt, ...)
> +{
> +	struct sensor_device_attribute_2 *a;
> +	umode_t mode;
> +	va_list ap;
> +
> +	mode = iio_event_mode(&st->channels[i], IIO_EV_TYPE_THRESH, dir,
> +			      IIO_EV_INFO_VALUE);
> +	if (!mode)
> +		return 0;
> +
> +	a = devm_kzalloc(dev, sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	sysfs_attr_init(&a->dev_attr.attr);
> +	va_start(ap, fmt);
> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
> +	va_end(ap);
> +	if (!a->dev_attr.attr.name)
> +		return -ENOMEM;
> +
> +	a->dev_attr.show = iio_hwmon_read_event;
> +	a->dev_attr.store = iio_hwmon_write_event;
> +	a->dev_attr.attr.mode = mode;
> +	a->index = i;
> +	a->nr = dir;
> +
> +	st->attrs[st->num_attrs++] = &a->dev_attr.attr;
similar comment to the previous, though here I think we'd
need to pass in the channel to an iio_hwmon_alloc_event_attr() as ideally we'd
not be messing with st at all in here.  So maybe it doesn't work out.

> +	return 0;
> +}



