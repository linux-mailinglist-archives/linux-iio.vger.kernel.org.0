Return-Path: <linux-iio+bounces-11730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076059B85CB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EB228186F
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486791CCB30;
	Thu, 31 Oct 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3iws9zU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E621C8FD2;
	Thu, 31 Oct 2024 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411876; cv=none; b=HoirHvLWn2F1p8AAPV6JNlXG5rSHD4I+yeHrHNh49umsAa4aalpXa6mrjBpg1tHQ7On7Ubj6n+k8lDHhPDgKsSeYCCAJt/hxye2+yHiz3Nuwm08Aq/VlAwKcjFqgVdIqs3mBHUeKAAQMJqlzgF9foU1vHrMd13mG8hRU8AOToU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411876; c=relaxed/simple;
	bh=QxyuKNU1+vEuSJDKlSG/FG5ANonUY0fxwGCFPXgcEAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dF7tpFgZjnHYiRvURHbrSSKFTPGRLqqpHOhjF6F+QR1jOHtk5Mp8I2c3XCq07aXW6bi6LgIl5iU+d2cAR5lWzdpjvWSkCUu1zzFQnUQYT7n74lwal7dBMGv9yeCZe8JVh24WF+fQD440SF3qxl7BIvtQ+8hQSfS2gud3XBouDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3iws9zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD2CC4CECF;
	Thu, 31 Oct 2024 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730411875;
	bh=QxyuKNU1+vEuSJDKlSG/FG5ANonUY0fxwGCFPXgcEAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H3iws9zUsBHXxbVTOhSMgwyF7JoN3IuJPuIXAgfofHmBmNDCZY4hqYYtLz/myPdgD
	 t9PBMFTpFAsik6+tEEflBooEhDxBVWVLY7HjwJmbs+TfOlEAkvfIXf3H5Xt/ItFkPc
	 MBMfeBA8NGMjO4dV2YtKFyAc0wWDO4wtBfTdgE8fWr2egzfCXKpdYMrlCx+7icOQfw
	 +KqknqxE5KiSKElH/JzZtARiAe4H4y73HIvwBEFrcL99Qe6TPHun2x9KkR4pQQYe4P
	 6zsKT4nR+gNdtraixmh7k7JfnaAMcwdVGiDoi5ahwdyXuKgfJNCdE9NJxKvZwliZ3e
	 OKJC9yDN7jl9g==
Date: Thu, 31 Oct 2024 21:57:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Kalle Niemi <kaleposti@gmail.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: kx022a: Fix raw read format
Message-ID: <20241031215749.10a8dbbe@jic23-huawei>
In-Reply-To: <20241030180658.00000ac2@Huawei.com>
References: <ZyIxm_zamZfIGrnB@mva-rohm>
	<20241030180658.00000ac2@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 18:06:58 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 30 Oct 2024 15:16:11 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > The KX022A provides the accelerometer data in two subsequent registers.
> > The registers are laid out so that the value obtained via bulk-read of
> > these registers can be interpreted as signed 16-bit little endian value.
> > The read value is converted to cpu_endianes and stored into 32bit integer.
> > The le16_to_cpu() casts value to unsigned 16-bit value, and when this is
> > assigned to 32-bit integer the resulting value will always be positive.
> > 
> > This has not been a problem to users (at least not all users) of the sysfs
> > interface, who know the data format based on the scan info and who have
> > converted the read value back to 16-bit signed value.  
> They shouldn't be doing that. Scaninfo is for buffered values only
> This should indeed be signed.
I added a note saying this isn't compliant with the ABI.
Applied to the fixes-togreg branch fo iio.git and marked for stable.

> 
> > 
> > This, however, will be a problem for those who use the in-kernel
> > interfaces, especially the iio_read_channel_processed_scale().
> > 
> > The iio_read_channel_processed_scale() performs multiplications to the
> > returned (always positive) raw value, which will cause strange results
> > when the data from the sensor has been negative.
> > 
> > Fix the read_raw format by casting the result of the le_to_cpu() to
> > signed 16-bit value before assigning it to the integer. This will make
> > the negative readings to be correctly reported as negative.
> > 
> > This fix will be visible to users by changing values returned via sysfs
> > to appear in correct (negative) format.
> > 
> > Reported-by: Kalle Niemi <kaleposti@gmail.com>
> > Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Tested-by: Kalle Niemi <kaleposti@gmail.com>
> > ---
> >  drivers/iio/accel/kionix-kx022a.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index 53d59a04ae15..b6a828a6df93 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -594,7 +594,7 @@ static int kx022a_get_axis(struct kx022a_data *data,
> >  	if (ret)
> >  		return ret;
> >  
> > -	*val = le16_to_cpu(data->buffer[0]);
> > +	*val = (s16)le16_to_cpu(data->buffer[0]);  
> LGTM.
> >  
> >  	return IIO_VAL_INT;
> >  }
> > 
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e  
> 


