Return-Path: <linux-iio+bounces-2161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B54848F1D
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35C2283100
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A8225CD;
	Sun,  4 Feb 2024 16:04:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6822611
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062680; cv=none; b=uvdN9sTZcccFWY6D38v2qYbePlozc5mHKXABzjqy/Z9kcXvOnzuSLVNvcbrF6NFf+tnznlRVrx4FrqT9uyhwL1lT3lbtkS6gCecpvNQ9uaJfic0UfWWYkdF0kSrmui3wFR1sCA1y2YbQ+C8MMiisVO8cDvIxw+p4MSLCcREhnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062680; c=relaxed/simple;
	bh=84hkzMnb4d0qSNlDJzg77SjZalzYwkJt2ttpNlkHAS0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljYwwZoCDjwnossALYIrq+NkPxUZv4pY2ibrigYOF+Ehe193Lqd2YB2R9/HcjmP+hwrmVKh+a/PjE1+u/B3rXySJYSREwx375Ggr40ZZgUUPPOU3YmmPrkhJ3F8fWe6ZMD+2zOsx7K1ZGTlcvMtdExJZjCDxTwqa3N7iO6ZOdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id ef68d8fc-c376-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 18:03:28 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:03:28 +0200
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <Zb-1UGJt27OV-vjc@surfacebook.localdomain>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
 <20240127160405.19696-5-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127160405.19696-5-petre.rodan@subdimension.ro>

Sat, Jan 27, 2024 at 06:03:58PM +0200, Petre Rodan kirjoitti:
> Add triggered buffer feature.

...

> +static irqreturn_t hsc_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hsc_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = hsc_get_measurement(data);
> +	if (ret)
> +		goto error;

> +	memcpy(&data->scan.chan[0], &data->buffer, 2);

You probably wanted here &data->buffer[0] as currently you use pointer to
the poiner.

> +	memcpy(&data->scan.chan[1], &data->buffer[2], 2);

Hmm... We don't have fixed-size memcpy() :-(

> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +error:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko



