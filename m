Return-Path: <linux-iio+bounces-12612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E49D77E4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A269B223F6
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF813D51E;
	Sun, 24 Nov 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUZUY+FI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84F74BE1;
	Sun, 24 Nov 2024 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475133; cv=none; b=V9sf0HxhoXtvwZ6jZVEkl0cdy3m5TRKIUUXJPK4Myh2F9/akvp09Nj9inMFUNOdDGyLjoFnSwSrmRy0Dc2/+R+q+EMYTvKzfYe+DCK5kEwGbfoAeZhdmBDbpqK5iqwoPI1O63YdyZftdG6/frqKdA2i4npfiL3qHccN7FZfWNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475133; c=relaxed/simple;
	bh=gJ39YNdqVALmmIgom11PXBFoRDla3/H13dkv33g2bcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVv0JASSuFEw8sE6M46SQmzZxDsmfc4y22buCdYkpkE8I7mgX1GiO9Gk8mJzAS6uXUVol8/nqN6M5VsU1kxu+uEAO9WZYM8P4sh6lzICRVkjzg362yppArLzFnhMgrR7hl+f4tuawpbXGwSDEVGEX9++NutiPIHqxOoK+1ZmhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUZUY+FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E934C4CECC;
	Sun, 24 Nov 2024 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732475132;
	bh=gJ39YNdqVALmmIgom11PXBFoRDla3/H13dkv33g2bcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MUZUY+FIbVToph6L03X8tD6uz2HAFzgq5skkYV2gzRKhAfUzJDRJrJ2rLSUIZPooW
	 MVBVaKM9l+CSk43AqS6Nw1j1M1ZiF861ka+VpWXNqjt1NlAnEs50YuK677xsKdoLWM
	 O4rc+JE/O66gaEIO7h9axA+seiAj8rDsLqRHGo13yXJn3l84MrU8zpqr0s1xl/gwvO
	 2N0dvm2PA9IWq5u7ho4/lTe/OKQjUw3fw9Ch2BZLl+9s+DRtWx9r8+U/Q7qxvYEfL8
	 O0YkT6Kup2AHXMkdhS7pYo/JEBOsE1T9yIpAHha8w/4ZNmCFOGqVm4827GoQPFzSM4
	 BA6KgjjMeq4gQ==
Date: Sun, 24 Nov 2024 19:05:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 19/22] iio: accel: adxl345: prepare FIFO watermark
 handling
Message-ID: <20241124190525.51cc08ff@jic23-huawei>
In-Reply-To: <20241117182651.115056-20-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-20-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:48 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the feature of the adxl345 and related sensors to manage a FIFO in
> stream mode by a watermark level. Provide means to set the watermark
> through the IIO api and sysfs interface.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

> +/*
> + * NB: The buffer/hwfifo_watermark is a read-only entry to display the
> + * currently set hardware FIFO watermark. First set a value to buffer0/length.
> + * This allows to configure buffer0/watermark. After enabling buffer0/enable
> + * the hwfifo_watermark shall show the configured FIFO watermark value.
> + *
> + * ref: Documentation/ABI/testing/sysfs-bus-iio
> + */
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
> +			     __stringify(ADXL34x_FIFO_SIZE));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adxl345_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adxl345_get_fifo_enabled, NULL, 0);
> +
> +static IIO_DEVICE_ATTR_RW(watermark_en, 0);
> +
>  static const struct iio_dev_attr *adxl345_fifo_attributes[] = {
> +	&iio_dev_attr_hwfifo_watermark_min,
> +	&iio_dev_attr_hwfifo_watermark_max,
> +	&iio_dev_attr_hwfifo_watermark,
> +	&iio_dev_attr_hwfifo_enabled,
>  	NULL,
Introduce the whole array only when you bring in the entries (so here).
>  };
>  
> @@ -345,6 +434,7 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  
>  static struct attribute *adxl345_attrs[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_watermark_en.dev_attr.attr,

Non standard ABI.  This should be indirectly controlled by the
watermark on the software buffer IIRC. (it's been a while
since I last looked at that). 

If the watermark passed to hwfifo_set_watermark is 0 then turn it off.
Otherwise turn it on.


Jonathan

>  	NULL
>  };


