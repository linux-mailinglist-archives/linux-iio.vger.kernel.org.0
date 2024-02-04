Return-Path: <linux-iio+bounces-2165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA528848F46
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4631F213C2
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F822F00;
	Sun,  4 Feb 2024 16:29:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336122374C
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064170; cv=none; b=H7RvD9c4obKUs7WUt+A0W7lkl7hPAoCZWngtsnmXE8QUJvlFEnmT54UPpAEekw2NmaOK8jiLSng2Hk3r+Sk5sVNwzIqzo+hQBWpjxCUVNExd5cPlOcXnDzTrNNuByKExfgCmFmwJ3+Xxvwy+ulsiOz+5LRXq8AyXq7jGQWeRtG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064170; c=relaxed/simple;
	bh=KXFDc/u6k/TjEHu/HDIB1T89cjhCnLLCNidJmNfeFRM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mclemobMfxYSt+kWQp5JzBfwv8Xhh+5Y8972T7LzMdBzbgxcvoP6dkwKk3/156Aw8sx3W71+hZ5eBnFPvonpdeNzs7M4Ul2GnnvILomwBY4My8ofU80icXXvdTUkbnh7mqfd4snqA5odZMMA6UoFmIabbgPmMmqIHGJRI5/pn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 8f5aafb2-c37a-11ee-b972-005056bdfda7;
	Sun, 04 Feb 2024 18:29:25 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:29:25 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode
 cleanup.
Message-ID: <Zb-7ZUbZ65G-LoNW@surfacebook.localdomain>
References: <20240128150537.44592-1-jic23@kernel.org>
 <20240128150537.44592-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128150537.44592-3-jic23@kernel.org>

Sun, Jan 28, 2024 at 03:05:29PM +0000, Jonathan Cameron kirjoitti:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Given we now have iio_device_claim_direct_scoped() to perform automatic
> releasing of direct mode at exit from the scope that follows it, this can
> be used in conjunction with guard(mutex) etc remove a lot of special case
> handling.
> 
> Note that in this particular example code, there is no real reason you can't
> read channels via sysfs at the same time as filling the software buffer.
> To make it look more like a real driver constrain raw and processed
> channel reads from occurring whilst the buffer is in use.

...

> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			guard(mutex)(&st->lock);
> +			switch (chan->type) {
> +			case IIO_VOLTAGE:
> +				if (chan->output) {
> +					/* Set integer part to cached value */
> +					*val = st->dac_val;
> +					return IIO_VAL_INT;
> +				} else if (chan->differential) {
> +					if (chan->channel == 1)
> +						*val = st->differential_adc_val[0];
> +					else
> +						*val = st->differential_adc_val[1];
> +					return IIO_VAL_INT;
> +				} else {
> +					*val = st->single_ended_adc_val;
> +					return IIO_VAL_INT;
> +				}

Now you may go further and use only single return statement here.

> +			case IIO_ACCEL:
> +				*val = st->accel_val;
> +				return IIO_VAL_INT;
> +			default:
> +				return -EINVAL;
>  			}

...

> +		unreachable();

Hmm... Is it really required? Why?

...

P.S> I hope you are using --histogram diff algo when preparing patches.

-- 
With Best Regards,
Andy Shevchenko



