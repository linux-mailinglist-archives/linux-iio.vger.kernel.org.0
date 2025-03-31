Return-Path: <linux-iio+bounces-17426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC7A764F8
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192AE3A542F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509B155389;
	Mon, 31 Mar 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSMmXvtm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358A339A1
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420741; cv=none; b=gGYAakLCe10NE1dBxm03/2bcuu1GTT7np0SJ/3R4Ch4FHiZH7a+hHIjjwlO9MpzHNUoQQem+hwlnCEjS2+vOI7RVWm8h2iH/Xitlz+xE53I+3QIJaw9rQzWi2l0ltKQpx9rLfdezpJQAG/3lRg67oQPJlBlmU62MUVR4aUVy5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420741; c=relaxed/simple;
	bh=PbTVrr9xKo5HWta/VXMXtI25RbVU3lxSNWjoE1Yb/OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3uvwsRKOjEwyrAuXl2DVCfeu6+TML89zZ0fOrXQXA4g48hBTPi7/sqxeS6IOP75B308rQierIeU3YW2IlhWsSazHYxFYFzCFX1CZNNg6GQsmeeb3XzdRSKZeCyi/xz700yuXQrscc0IZH7cWbiZ7z/k79j30iksfbSJIn65qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSMmXvtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A6C4CEE3;
	Mon, 31 Mar 2025 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743420741;
	bh=PbTVrr9xKo5HWta/VXMXtI25RbVU3lxSNWjoE1Yb/OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSMmXvtmCZXYaWarRL1ddcrb9owQebLJVWX4nQ+W8FRe962aXOm0CaP7Nu1Ep/FNe
	 KygD3LOEAbNUVUjQor0ie8nxyutI+VtMkEDd45VKjd4ILsLb7gJ2iIoIWOkgiBBjJK
	 Xb72L2iVzzbsa4ef4zal9+VLWdEooqwzD6q7E1ceodkPJJkewkugq0kjNDxjA/6rHs
	 dXxPZ1El/uscfuOGl3LQI700brjsC4zAaLclQ0zXG00MZAtvarvnksX42HkEOk5jTp
	 VT/NBaQqdIm+vhWMoTyHQkj7nIO9FVDc6Tx7ujFztrQkqleMYvsVwrymTfel3tOV7f
	 KRnrfILKjxl5g==
Date: Mon, 31 Mar 2025 12:32:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Frank Li <Frank.Li@nxp.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marek Vasut <marex@denx.de>, Mike
 Looijmans <mike.looijmans@topic.nl>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/8] iio: adc: ti-ads1015: Use guard(mutex) and
 factor out code for INFO_RAW
Message-ID: <20250331123215.3f31f72f@jic23-huawei>
In-Reply-To: <9cd23b18-f1a9-4222-aa6a-e1453f4bad88@baylibre.com>
References: <20250309165819.1346684-1-jic23@kernel.org>
	<20250309165819.1346684-6-jic23@kernel.org>
	<9cd23b18-f1a9-4222-aa6a-e1453f4bad88@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 18:18:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 11:58 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > By use of automatic lock release and introducing a new utility
> > function to handle the core activity of reading the ADC channel,
> > many more complex code flows can be replaced by direct returns.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Marek Vasut <marex@denx.de>
> > ---  
> 
> ...
> 
> >  static int ads1015_read_event_config(struct iio_dev *indio_dev,
> > @@ -710,25 +686,19 @@ static int ads1015_read_event_config(struct iio_dev *indio_dev,
> >  	enum iio_event_direction dir)
> >  {
> >  	struct ads1015_data *data = iio_priv(indio_dev);
> > -	int ret = 0;
> >  
> > -	mutex_lock(&data->lock);
> > -	if (data->event_channel == chan->address) {
> > -		switch (dir) {
> > -		case IIO_EV_DIR_RISING:
> > -			ret = 1;
> > -			break;
> > -		case IIO_EV_DIR_EITHER:
> > -			ret = (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
> > -			break;
> > -		default:
> > -			ret = -EINVAL;
> > -			break;
> > -		}
> > -	}
> > -	mutex_unlock(&data->lock);
> > +	guard(mutex)(&data->lock);
> > +	if (data->event_channel != chan->address)
> > +		return -EBUSY;  
> 
> The old code returned 0 in this case instead of -EBUSY, so this seems like an
> unrelated or unintentional change.
> 
Good catch, not intended so I've made it return 0.

Thanks,

> >  
> > -	return ret;
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		return 1;
> > +	case IIO_EV_DIR_EITHER:
> > +		return (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
> > +	default:
> > +		return -EINVAL;
> > +	}
> >  }
> >    


