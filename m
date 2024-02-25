Return-Path: <linux-iio+bounces-3049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A5862A55
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2428A281493
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCE469E;
	Sun, 25 Feb 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bumMYu80"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D611C85
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864546; cv=none; b=klySrV9yI0mQEx1y5JP7m2Kv4VzJyQ/aj7aDFkLb9eUelPRyUQUascnqMxGcA7MMesiyQiI8lfoWJ+gTdaT8T8NKsHmEV7jbllnO2FzPVKW5nz+cqluU9crAFC7QDbwbGGOfdUP7/0cwvzGA1LTZurnTVpw1eGzbVVNBjPPdoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864546; c=relaxed/simple;
	bh=AxFa2bcZES/QFrIA2nRgOuJWNHTrexOxjA5StinI2Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5kR7uavulaWxYDzLeNcHOSd+PoS86vZiYwW5ScKok/O4hVCfA2Ojhk8AmzHgvBI8YK79u9FBbMtWds25I2261f4MR4yS0Hzgwmo2OwHr+pG2NdCW+BV/BrOiYS44ZySRsqQEEDcSrwOVvYpDVzTWiMGYz2a+NhLqHsImFX0jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bumMYu80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F82DC433C7;
	Sun, 25 Feb 2024 12:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708864546;
	bh=AxFa2bcZES/QFrIA2nRgOuJWNHTrexOxjA5StinI2Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bumMYu80yf4v4hUtDfjwTbhEP0ZT01Kjqh74UIt9BVP8nl4u2LBjDtMDv/bOzK4G/
	 Izv0H+mcYZIy52cmsBwOViCGNsqXI8EA78cla7w/Jh2P3r792HEs8CKa4zqNZknWfd
	 osbTfd6A7PRjQi0UeDCNHYAAa3mRBucahZY+T4bGT31jqHIKwAtNDXgv9+tIZ+z5Mq
	 8QCfCs4WIjPeHfXKyjxlA2igGdZRIzniSQBXBIgVDWFzZ0Y3ShfNk0/EyRhmxW5TLU
	 pOXIfpOs0Bmfnhci0KrcomZVmq0uJp9POCysME6n84X7c/h63/tX5Xstela48KRw3V
	 KcZvrYwGWvP/Q==
Date: Sun, 25 Feb 2024 12:35:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH v2 2/5] iio: events: move to the cleanup.h magic
Message-ID: <20240225123531.020e875f@jic23-huawei>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-2-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	<20240223-iio-use-cleanup-magic-v2-2-f6b4848c1f34@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:43:45 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-event.c | 42 +++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 910c1f14abd5..ef3cecbce915 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/anon_inodes.h>
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
> @@ -146,11 +147,10 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
>  				return -ENODEV;
>  		}
>  
> -		if (mutex_lock_interruptible(&ev_int->read_lock))
> -			return -ERESTARTSYS;
> -		ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
> -		mutex_unlock(&ev_int->read_lock);
> -
> +		scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
> +				  &ev_int->read_lock)
> +			ret = kfifo_to_user(&ev_int->det_events, buf, count,
> +					    &copied);

>  		if (ret)
>  			return ret;
>  
> @@ -198,28 +198,22 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
>  	if (ev_int == NULL)
>  		return -ENODEV;
>  
> -	fd = mutex_lock_interruptible(&iio_dev_opaque->mlock);
> -	if (fd)
> -		return fd;
> +	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) {

Maybe we want to wait for
	cond_guard() that Fabio has been working on to land
https://lore.kernel.org/all/20240217105904.1912368-2-fabio.maria.de.francesco@linux.intel.com/
Not sure if it will make the merge window and I don't want to hold this a whole
cycle if it doesn't.

In many cases I find the scoped version easier to read, but sometimes it makes things
a little messy and for cases like this where it's taken for nearly the whole function
(other than some input parameter checks) the guard() form is nice and
cond_guard() as similar advantages.

If I didn't have a few other requests for changes I'd just have picked this
and we could have coped with the slightly less elegant change set.


> +		if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
> +			return -EBUSY;
>  
> -	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
> -		fd = -EBUSY;
> -		goto unlock;
> +		iio_device_get(indio_dev);
> +
> +		fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
> +				      indio_dev, O_RDONLY | O_CLOEXEC);
> +		if (fd < 0) {
> +			clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> +			iio_device_put(indio_dev);
Given this is an error path, I think it would now be nicer to do
			return fd;
		}

		kfifo_reset_out(&ev_int->dev_events);
		
		return fd;

That was avoided in original code as it was nicer without the gotos
but now those are gone I think the refactor makes sense.

> +		} else {
> +			kfifo_reset_out(&ev_int->det_events);
> +		}
>  	}
>  
> -	iio_device_get(indio_dev);
> -
> -	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
> -				indio_dev, O_RDONLY | O_CLOEXEC);
> -	if (fd < 0) {
> -		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
> -		iio_device_put(indio_dev);
> -	} else {
> -		kfifo_reset_out(&ev_int->det_events);
> -	}
> -
> -unlock:
> -	mutex_unlock(&iio_dev_opaque->mlock);
>  	return fd;
>  }
>  
> 


