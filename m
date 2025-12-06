Return-Path: <linux-iio+bounces-26855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3DBCAAD45
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 21:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E31383009288
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F312D8390;
	Sat,  6 Dec 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpFc++L8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51643B8D53;
	Sat,  6 Dec 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765052039; cv=none; b=agMIEaTrKgWgtG7rbfXfE9qLfWl4sf9EmpLAYUndcuvGTa+nq+z1exl4lt8j3RCwwp3R0c91Ob4ZQB/VRPHNItzHinZMYMYcRDD8lTlgQOi4VuAgpQOd6CS5WULE91pw/d/XhDHXoyH2B5ftxrz0YWiLD1nOl9An1U47VwSJN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765052039; c=relaxed/simple;
	bh=Ak1SyKzWO3zfOmjcFT0UUdVhVWM4EHvy/vOq3gqGhFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndb2+Kq7/b5xxpigfd09XoLJsZ/1hHrS4laTRvkzIsk+Xkfqlldpz/pFNSXbmmdN0Rt5yIBRwOr++sBJyHgaJjG4o28C48TP6NJ+qtHtqSApdjAENaMyZonIvWihn2qfPr9+u2lQBreR9KFI53Anz4LwZLc0aD+7TAm27EuVxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpFc++L8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE73C4CEF5;
	Sat,  6 Dec 2025 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765052039;
	bh=Ak1SyKzWO3zfOmjcFT0UUdVhVWM4EHvy/vOq3gqGhFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpFc++L849cRzVroVkNgSDZiq7lImfkATHqWR54ABaVRP7kw3R/VpqFSHGHoUvP+K
	 /VhHvSWxkBN+uqHlklJnDBOe4o/EP2WQlkl6OWAT1PtwjicETv7rcMCcR+nOr5S2y6
	 mZp7vECmEzRGjdya70KOEGoCfMuLclI79zTmLv7gztAVsuED/7+ltAvkm37uOTXoL2
	 EaTI+CZnJf4WuHJDq2Ud6VZyqUhdEcSZHFIVE/9RWQ2IImKg6f9HiMj3ZaK1u5x5Sh
	 kkW+YgJvPU1XgqbI1S2LeP52+yBJSz6I0VERS81/Zs6KnPJ/6vsa8XLU9e0PjFs8tW
	 ch70tMrhzYjPQ==
Date: Sat, 6 Dec 2025 20:13:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <20251206201349.12d6c5b5@jic23-huawei>
In-Reply-To: <aSRF-DL3rKjyFleg@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
	<20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
	<aSRF-DL3rKjyFleg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> ...
> 
> > +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
> > +{
> > +	int ret;
> > +	struct abp2_data *data;
> > +	struct iio_dev *indio_dev;
> > +	const char *triplet;
> > +	s64 tmp;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->dev = dev;
> > +	data->ops = ops;
> > +	data->irq = irq;
> > +
> > +	init_completion(&data->completion);
> > +
> > +	indio_dev->name = "abp2030pa";
> > +	indio_dev->info = &abp2_info;
> > +	indio_dev->channels = abp2_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(abp2_channels);  
> 
> > +	indio_dev->modes = INDIO_DIRECT_MODE;  
> 
> Doesn't IIO core take care of this?
Not currently.  We should revisit if we this ever actually proved
useful to set.  It dates back to very early in IIO where I assumed
we would want to differential devices that only do buffered capture from
those that can do that and single shot. I'm not sure we actually have
any in that category though :(

So maybe we can justify dropping this across all drivers at somepoint
or as you say just set it as a default value.

Jonathan

