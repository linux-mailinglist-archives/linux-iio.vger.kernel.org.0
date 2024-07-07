Return-Path: <linux-iio+bounces-7413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55D09298C4
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC47D1C20A9A
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596A3B182;
	Sun,  7 Jul 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G45BwIe6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162FEDC;
	Sun,  7 Jul 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368845; cv=none; b=NhKAQ+3MqVP2MvwYgmfb4PWbVr5AIc2vHwbXzoWVTCJuuC+HxjjKgIzQG5Q4ejW//lAJV+aZdsyowkJmNgSTfzDizvmKg8rau453M0cGna5lMUrA8fah6wW3OnAWjd/W4AXuwi4hvxFEZJu+F6y8bV6Sk9J7ogSvHUXy/U0Jev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368845; c=relaxed/simple;
	bh=SGfAfotsObQDE0V5a4bD2FVMR3CwTpb3bLyNXcJBlb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/nHIS3YfHINM0cRJvndtZHNrNAQvHxgEm5EDwQa0ZoqNxzA8TW3hT6o8f4l/CXVGFb1gytNVr07xRanbW23IY0wyuV49ocQJbxH6m3jWauyYaTibGtaHJn8NMfyTjwadmV8X4+6h0PnqUgZxsxtMADZ9fJ8m1z8qSET746xnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G45BwIe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C0CC3277B;
	Sun,  7 Jul 2024 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720368844;
	bh=SGfAfotsObQDE0V5a4bD2FVMR3CwTpb3bLyNXcJBlb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G45BwIe6Ete3Uwt+tZw6Sh/F+n7FlHLrTP64/n3Wv0p1LK113RLpxT3saQxBygXRv
	 sN8iPQiKrTMI1hRiDoNWVGvcB4s6mVDmmQhA58om1ZyTqlHOI38bg/SGu1KJBKlbHz
	 M4U7gFNYWtwWET9GxFnEAE1lLb8WDl13p/9Z8xBWOi5xcMSQ1G261Ccvhr0m/W4PGf
	 3QJVrDLKlWNWxgYwIOYpKDdGtQ2xpfBUPOPf7Mmj0bHfHXoDpSN06X9+6yP/rnD6Xt
	 668LdqsnMfTZ7A5RrvvicPgubJsjtgGn3COl5eQ67OtkzkBxrApma+4JqQVsHetM9O
	 A19KLTFP9EmHQ==
Date: Sun, 7 Jul 2024 17:13:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9960: Add proximity and gesture offset
 calibration
Message-ID: <20240707171357.709d9e35@jic23-huawei>
In-Reply-To: <20240702115648.160511-1-abhashkumarjha123@gmail.com>
References: <20240702115648.160511-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 17:26:48 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Proximity and gesture offset registers perform offset correction to improve
> cross-talk performance. Add support for reading from and writing to
> proximity and gesture offset registers. Create sysfs attributes for
> them via iio to expose them to userspace.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

All custom ABI needs documentation in
Documentation/ABI/testing/sysfs-bus-iio-* 
where * is appropriate scoped - here probably device.

Key thing is that custom documentation == custom userspace code ==
never used by 99% of users.

So we need to think very hard about whether we can map it to standard
ABI, or if it deserves new standard ABI (which will eventually make it
into userspace tools).

That's a hard discussion to have without documentation

Consider in particular if calibbias can work for these as it sounds
superficially similar to what the datasheet is talking about.



> ---
>  drivers/iio/light/apds9960.c | 245 +++++++++++++++++++++++++++++++++++
>  1 file changed, 245 insertions(+)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 1065a340b..bccf9a8c7 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -101,6 +101,10 @@
>  #define APDS9960_MAX_ALS_THRES_VAL	0xffff
>  #define APDS9960_MAX_INT_TIME_IN_US	1000000
>  
> +/* MIN and MAX offset from pg: 26 of the datasheet */
> +#define MIN_OFFSET -127
> +#define MAX_OFFSET 127
S8_MIN, S8_MAX
probably appropriate here.



> +static IIO_DEVICE_ATTR(proximity_offset_ur, S_IRUGO | S_IWUSR, apds9960_proximity_offset_ur_show, apds9960_proximity_offset_ur_store, 0);
> +static IIO_DEVICE_ATTR(proximity_offset_dl, S_IRUGO | S_IWUSR, apds9960_proximity_offset_dl_show, apds9960_proximity_offset_dl_store, 0);
> +static IIO_DEVICE_ATTR(gesture_offset_u, S_IRUGO | S_IWUSR, apds9960_gesture_offset_u_show, apds9960_gesture_offset_u_store, 0);
> +static IIO_DEVICE_ATTR(gesture_offset_d, S_IRUGO | S_IWUSR, apds9960_gesture_offset_d_show, apds9960_gesture_offset_d_store, 0);
> +static IIO_DEVICE_ATTR(gesture_offset_l, S_IRUGO | S_IWUSR, apds9960_gesture_offset_l_show, apds9960_gesture_offset_l_store, 0);
> +static IIO_DEVICE_ATTR(gesture_offset_r, S_IRUGO | S_IWUSR, apds9960_gesture_offset_r_show, apds9960_gesture_offset_r_store, 0);
Very long lines.  Try to keep under 80 chars unless there is a good reason
(readability mainly).  here I'm not seeing one.

Also, the kernel is moving away from symbols for permissions as
checkpatch would I think have told you..

> +
>  static struct attribute *apds9960_attributes[] = {
>  	&iio_const_attr_proximity_scale_available.dev_attr.attr,
>  	&iio_const_attr_intensity_scale_available.dev_attr.attr,
>  	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	&iio_dev_attr_proximity_offset_ur.dev_attr.attr,
> +	&iio_dev_attr_proximity_offset_dl.dev_attr.attr,
> +	&iio_dev_attr_gesture_offset_u.dev_attr.attr,
> +	&iio_dev_attr_gesture_offset_d.dev_attr.attr,
> +	&iio_dev_attr_gesture_offset_l.dev_attr.attr,
> +	&iio_dev_attr_gesture_offset_r.dev_attr.attr,
>  	NULL,
>  };
>  


