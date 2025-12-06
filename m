Return-Path: <linux-iio+bounces-26846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2ACCAAC17
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739F93056788
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A922C0293;
	Sat,  6 Dec 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsSqw3S8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873D2BE64A;
	Sat,  6 Dec 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765045268; cv=none; b=eU4wdwwvBITepbsKZyHkkdT6gPRexr81oo9CbhVP7bckHMQCBZXV+C+8szCy+zoXk/aSEAdS0MQJ/FP+9qJv7F8nKdPLGgxco9Vdx7pec3eh1TU5HQ38pMGjVDh7b20YljRhneSGp59fmNJJDu+3FX/HqvYuWKXjN5q5t8Z15NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765045268; c=relaxed/simple;
	bh=b9k7n4qUakXX4lKC0g4WXg+qPRxBAClJnXuxeXtcp0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZ3t6xVSKojaNee8qqQ27wXRyvhHeou7Wf1/VwmQjt664s5ds0llv8L4aIaWUZszfvaSKYqShUfL6NEiQtSpxd4rKcTqlHpGzvxoBcnqF05cIUUEDwWIguPqXdeGxECi+CwKdRhLOMlf9a4VdSX/DPdvgRP88GvrdnFMHltuJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsSqw3S8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3B1C4CEF5;
	Sat,  6 Dec 2025 18:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765045267;
	bh=b9k7n4qUakXX4lKC0g4WXg+qPRxBAClJnXuxeXtcp0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IsSqw3S84LfoJt3/UZuSsAS7yFCyPKicB/o36wfnP1cTfDAV4jEC+P8OEroiT4JUW
	 SAbGhSK+cMrDjlvZor5SMobzA7gExRrWdhdIkfULZy8QubDdBbbNawIZQp1bpMRPHk
	 so8IZPxhipYqepoGqPbsZuNL8kdoudzG25fuT124IuJyBt8h2G43SciIbhjNDozjaO
	 hGTiYsld5/7YEFLRMgHKSyJF8Na0Yr/hOMGbvjQ1+4kyqLxIWeXd8xC0UUIjpFCBrS
	 418mnf5VzK7ELTRfXCFEv0xWps2iucBPfeQqe2DiP37p/OxlxWsPrlHtINztnZXp5j
	 tSb2POWyHTZVw==
Date: Sat, 6 Dec 2025 18:20:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Benson
 Leung <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Message-ID: <20251206182057.40402e66@jic23-huawei>
In-Reply-To: <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Dec 2025 14:18:17 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add guard() and ACQUIRE() support for iio_device_claim_*() lock.
> 
> This involves exporting iio_device_{claim, release}() wrappers to define
> a general GUARD class, and then defining the _direct and _buffer
> conditional ones.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

I'd like some documentation (alongside the DEFINE_GUARD() stuff)
- particularly warn people that using the non conditional variant
is very much the unusual one.

Perhaps add examples of usage for the other two and ignore that one
on basis alarm bells will ring whenever we see it in code.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 12 ++++++++++++
>  include/linux/iio/iio.h         | 20 ++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index adf0142d0300..da090c993fe8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2171,6 +2171,18 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
> +void __iio_device_claim(struct iio_dev *indio_dev)
> +{
> +	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_device_claim);
> +
> +void __iio_device_release(struct iio_dev *indio_dev)
> +{
> +	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_device_release);
> +
>  /**
>   * __iio_device_claim_direct - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 27da9af67c47..472b13ec28d3 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,6 +10,7 @@
>  #include <linux/align.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
>  #include <linux/minmax.h>
>  #include <linux/slab.h>
> @@ -661,9 +662,23 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  			       struct module *this_mod);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> +void __iio_device_claim(struct iio_dev *indio_dev);
> +void __iio_device_release(struct iio_dev *indio_dev);
>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
> +static inline void iio_device_claim(struct iio_dev *indio_dev)
> +	__acquires(indio_dev)
> +{
> +	__iio_device_claim(indio_dev);
> +}
> +
> +static inline void iio_device_release(struct iio_dev *indio_dev)
> +	__releases(indio_dev)
> +{
> +	__iio_device_release(indio_dev);
> +}
> +
>  /*
>   * Helper functions that allow claim and release of direct mode
>   * in a fashion that doesn't generate many false positives from sparse.
> @@ -690,6 +705,11 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
>  bool iio_device_claim_buffer(struct iio_dev *indio_dev);
>  void iio_device_release_buffer(struct iio_dev *indio_dev);
>  
> +DEFINE_GUARD(iio_device_claim, struct iio_dev *, iio_device_claim(_T),
> +	     iio_device_release(_T));
> +DEFINE_GUARD_COND(iio_device_claim, _buffer, iio_device_claim_buffer(_T));
> +DEFINE_GUARD_COND(iio_device_claim, _direct, iio_device_claim_direct(_T));
> +
>  extern const struct bus_type iio_bus_type;
>  
>  /**
> 


