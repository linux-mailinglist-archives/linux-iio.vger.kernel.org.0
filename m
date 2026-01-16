Return-Path: <linux-iio+bounces-27887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B26D38766
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C40D93026FDB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD843A785B;
	Fri, 16 Jan 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJn7PKf6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA73A4AAF;
	Fri, 16 Jan 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594739; cv=none; b=emnUJTwKI66lV4IetG10LuEGes8W34INZ3YVW6awwMj6na10Xc2AN1yGUE9jIbVf8gyYpbftUx7nJPZ3DhLKjE2jHCo9v9gjP1tQ/70P6pRwiwYojoGeU2enAoykWyIMUZNY3TUviiMZLvYplC8WUH0PvYaq7B3xRQ9ZZIxgxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594739; c=relaxed/simple;
	bh=FdKqZ6ZSUrS2whE11MZTAsTR0xEG9d46ZjxxsQnWxL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvtJg/sG7ERQn/cCoOtcLmG8C898Y3r/ijor9MFMveswCD/Sjhm94Ru/7iNutd3vIO4Th7WYo84mj4jwfF55H8gUUpE2YCkh5i9JFuDovrpdVc5AAsRSkE1VirPbZf6edmCunmDR4r/9HE+y4Xssf7DT4fjCV/rUA8U/t0KGJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJn7PKf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C7EC116C6;
	Fri, 16 Jan 2026 20:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768594738;
	bh=FdKqZ6ZSUrS2whE11MZTAsTR0xEG9d46ZjxxsQnWxL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJn7PKf6wkWlVTSUa1OX/xs21PnxV6Nh73AFBVojEmjaF/Ngpl5I2QZeivmEkQzOS
	 k7GxYIUcAtJZx+vc6R3I06FH6yMUBfk3sQkdFU//HxUtY31uKb1AsWQPfusQGFJ7/H
	 3lYzbp9rpPGtUnZ56895fuRr/yOLjqTHNCwZYFR4BwlI+VWD4mRmI3BKzzebpBbZAV
	 QJj8RwskDWeHoKyWMyjhC/143TSuNNjtg1JSsjMAsBOHgzU1TERCVRNh5NgYAkX13W
	 PHz5q/jh80r6Q/nBHXjP+N/up/ZRcqZtV9EUeMyeB8679TconU79/3ErJoKxn5DwJ0
	 T2ddKdrfKOl/g==
Date: Fri, 16 Jan 2026 20:18:47 +0000
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
Subject: Re: [PATCH v3 1/7] iio: core: Add and export __iio_dev_mode_lock()
Message-ID: <20260116201847.3560a2e2@jic23-huawei>
In-Reply-To: <20260106-lock-impr-v3-1-1db909b192c0@gmail.com>
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
	<20260106-lock-impr-v3-1-1db909b192c0@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Jan 2026 03:06:56 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add unconditional wrappers around the internal IIO mode lock.
> 
> As mentioned in the documentation, this is not meant to be used by
> drivers, instead this will aid in the eventual addition of cleanup
> classes around conditional locks.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Hi Kurt,

I'm being a bit conservative in looking to apply this so apologies
if it seems like I'm ignoring you! I wanted to give plenty of time
for others to take a look.

A few comments, but if we go with this version I'll tweak the
punctuation if I remember whilst applying.

Jonathan


> ---
>  drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  3 +++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f69deefcfb6f..34867a860a84 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
> +/**
> + * __iio_dev_mode_lock - Locks the current IIO device mode
> + * @indio_dev: the iio_dev associated with the device
> + *
> + * If the device is either in direct or buffer mode, it's guaranteed to stay
> + * that way until __iio_dev_mode_unlock() is called.
> + *
> + * This function is not meant to be used directly by drivers to protect internal
> + * state, a driver should have it's own mechanisms for that matter.

Nitpick, shouldn't be a comma.  Either

 * This function is not meant to be used directly by drivers to protect internal
 * state. A driver should have it's own mechanisms for that matter.

or if you like fancy uses of the semi colon.

 * This function is not meant to be used directly by drivers to protect internal
 * state; a driver should have it's own mechanisms for that matter.

> + *
> + * There are very few cases where a driver actually needs to lock the current
> + * mode unconditionally. It's recommended to use iio_device_claim_direct() or
> + * iio_device_claim_buffer_mode() pairs or related helpers instead.
> + */
> +void __iio_dev_mode_lock(struct iio_dev *indio_dev)
> +{
> +	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_dev_mode_lock);
> +
> +/**
> + * __iio_dev_mode_unlock - Unlocks the current IIO device mode
> + * @indio_dev: the iio_dev associated with the device
> + */
> +void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
> +{
> +	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
> +
>  /**
>   * __iio_device_claim_direct - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 872ebdf0dd77..aecda887d833 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  			       struct module *this_mod);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> +
> +void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
> +void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
This is an interesting notation choice as there are several locks embedded
in iio_devs but I think it is the only one we want to expose so fair enough
if we don't see any false warnings from this!

Jonathan

>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
> 


