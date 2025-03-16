Return-Path: <linux-iio+bounces-16919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87DA6374E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 20:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5653A188E11B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 19:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106C1EDA3F;
	Sun, 16 Mar 2025 19:58:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A3A32
	for <linux-iio@vger.kernel.org>; Sun, 16 Mar 2025 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155094; cv=none; b=nTfN+v6+uEOpp13fxYCQYOAO3EcK+7TMLcQIKRA0x0GZ9DJqKQXZ+WIwOcGq4fPmLVIRzSWEEdTurVCpz26Pom74SxToZTNOQkDNjfK0OB/0wdsNpWdAlAEU/GD4Os1++R8ypik8Piks8Z1Qg2GPWG+8mzTomb/syaaAQ0HbucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155094; c=relaxed/simple;
	bh=Lw4+WlvrhcxgmS13gAyfNa3XA8OdF/0Wds1xS0aLwZY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/cfXfeZGo3MDL+nMErASqiRdQyHw8/KkzGU2pVhKeb1AMNyIsV3Mcen9iXBjRxvU73OhvoCvfjlUhJ6jL8gM3DRX0pWPFcCc7myZeEgFTHRxTFKoiyFbysPmIdtbQV9eg1YrSUgZOEQJYwY5Yn3hfWBLhmvCQ+YF/tiuktB7Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id f6f6ba18-02a0-11f0-ab76-005056bd6ce9;
	Sun, 16 Mar 2025 21:58:01 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 16 Mar 2025 21:58:00 +0200
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
Message-ID: <Z9ctSODRTxI53jAY@surfacebook.localdomain>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
 <20250313165049.48305-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313165049.48305-5-l.rubusch@gmail.com>

Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:
> Move the fifo handling into a separate function. This is a preparation
> for a generic handling of the interrupt status register results.
> 
> The interrupt status register is read into a variable int_stat. It carries
> status for various sensor events, handling of which is added in follow up
> patches. Evaluation of the int_stat variable is common for sensor events,
> such as tap detection, freefall, activity,... and for fifo events, such as
> data ready, overrun, watermark,... Also, dealing with in case error
> returns shall be common to all events. Thus migrate fifo read-out and push
> fifo content to iio channels into this function to be built up with
> additional event handling.

...

> +static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
> +{
> +	struct adxl345_state *st = iio_priv(indio_dev);
> +	int samples;
> +	int ret = -ENOENT;
> +
> +	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> +		samples = adxl345_get_samples(st);
> +		if (samples < 0)

> +			return -EINVAL;

In the original code it makes no difference, but if you are going to share
this, I would expect to see

			return samples;

here. Why the error code is shadowed? If it's trully needed, it has to be
explained in the comment.


> +		if (adxl345_fifo_push(indio_dev, samples) < 0)
> +			return -EINVAL;
> +	}
> +
> +	return ret;
> +}

...

Jonathan, I saw that you had applied it, but I guess the above needs
a clarification.

-- 
With Best Regards,
Andy Shevchenko



