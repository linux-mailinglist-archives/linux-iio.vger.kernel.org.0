Return-Path: <linux-iio+bounces-3050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22064862A56
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67B4B20E0A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 12:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458FC2D0;
	Sun, 25 Feb 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCi52sDM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8E469E
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864572; cv=none; b=SEi0VqM6yHvpU71XxtQiYeIdg6D7425IsvK+nGLIzpK66HCuCM2TEwuEyQ+gBoWClKhS4ATwQC9fJ9YZ/bW4VweFiLirmm8MG6VSu6GrOiRAPT4XiGBHnTjT3/XIkbUXMPySl9UgUjZC0nwRc8X9tu1ekh/rHjGpQpWMiLEv6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864572; c=relaxed/simple;
	bh=CYbQtdcCc33ugbA2IFy9lOwoCEv/0KfzmVDYqww8TJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA41OVE0IeUz+WCJynf/uAJiAsuzZnFsjJRybjmtaSImrk1nCcMwlKKOnXCpVAm9WhEk8Bqmu/AqG5rUTJTHdmeNS+8mDJESSwM86BYFPl909kVsz7FWTPE4baAtb+E2NOT8PZVHBctLk8KfasYeg9LyZfe9pvxdGI+8QPkh7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCi52sDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD8EC433C7;
	Sun, 25 Feb 2024 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708864572;
	bh=CYbQtdcCc33ugbA2IFy9lOwoCEv/0KfzmVDYqww8TJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rCi52sDM7Ugwl5yQs3EiKsX4iLSVM5SG2OYH/q6PjACnRPFvQb32/7Q154DF4ZWdY
	 1hP9sV31ldKO9SYqyUrpQNMlyPFZP6j02jkoIjjmsX9/lpjviGFMSm6O4AQfJJ3LfH
	 QQDn6sFpveKE38N6HuJnTb/hm3hE/hWLB/WECutmgBKQub02z4hxh4zRd4wHOT0yhS
	 Lf3V2VxqWuLEZdy9zP5bwoWPy4+bTwHvhXrvVCJ7kJA74ug+7wbtlVHx0WR9FRgKJh
	 pC8+jfzBW+Bsb60tZfFegDZoHp5fCatVFGtArSHD3Wg2a/z2Hp77HCZqoCl7WtkuDN
	 bD5B3aRwJ9Hpg==
Date: Sun, 25 Feb 2024 12:36:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/5] iio: core: move to cleanup.h magic
Message-ID: <20240225123600.301758b0@jic23-huawei>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-1-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	<20240223-iio-use-cleanup-magic-v2-1-f6b4848c1f34@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:43:44 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Note that we keep the plain mutex calls in the
> iio_device_release|acquire() APIs since in there the macros would likely
> not help much (as we want to keep the lock acquired when he leave the
> APIs).
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---


> @@ -1808,29 +1805,22 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	struct iio_ioctl_handler *h;
>  	int ret = -ENODEV;
>  
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>  	/*
>  	 * The NULL check here is required to prevent crashing when a device
>  	 * is being removed while userspace would still have open file handles
>  	 * to try to access this device.
>  	 */
>  	if (!indio_dev->info)
> -		goto out_unlock;
> +		return ret;

return -ENODEV; and drop initialisation above.


>  
>  	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
>  		ret = h->ioctl(indio_dev, filp, cmd, arg);
>  		if (ret != IIO_IOCTL_UNHANDLED)
> -			break;
> +			return ret;
>  	}
>  
> -	if (ret == IIO_IOCTL_UNHANDLED)
> -		ret = -ENODEV;
> -
> -out_unlock:
> -	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> -
> -	return ret;
> +	return -ENODEV;
>  }



