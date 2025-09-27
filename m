Return-Path: <linux-iio+bounces-24497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B548BA619D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2E61B21F3D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95A225390;
	Sat, 27 Sep 2025 16:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRTPELkh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D291B142D;
	Sat, 27 Sep 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990993; cv=none; b=f47upRQA2A7bGZcDRQLRRpe2STyuuNl18eIBfUNOFvD9yfsZGSV5J6cFT7qonBOfW2vVn3nAz/DBueOjz7pEYwpX5fDfrSIV0knQz/Ljw0tt9nXMVcl38xhQCTCkM7J3xlBkqsmc3p2wrhoYsUK9GMl8R8JXKYSv5LyCOp5Zqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990993; c=relaxed/simple;
	bh=HBHqSbj/2VsZ/FuyQs0IMKv8sKplDwSrsam+S3YiAxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9yupjC/rpkAWhJFcouUimNaLesL/gzwkq+ODoiBXNtTPNqDdgpR9vuyO7RH1M52CFrGok+h1hMTN3ABmPupI1+Dcqf/dNBiuNGDAU0CDNkTY2Q++TSl6UpQT7wUeXvbeRBE6FIYgGJmOa7IJzBLAr3HPFJtdld1ea/6AyacoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRTPELkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F958C4CEE7;
	Sat, 27 Sep 2025 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758990992;
	bh=HBHqSbj/2VsZ/FuyQs0IMKv8sKplDwSrsam+S3YiAxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRTPELkh2z5LKjiKp3Jd4bSsDPsuFRy+G2xHlQPHl/3c61V1Nc0FnFJ6wtonCkcla
	 zcPqNPAg32mEjnvgN3gSztqHATRhIaoSRMpqGh3tR3sC69NwiVB0Yu2D4Vy4ou7bSS
	 jmANxIHiruIGp9osMfRdS3qbz55VR7gI08CFf7H9lgtAILRmyeyp54U+1II2Rlr9fx
	 3XwL7gaw6ZBRqQ5opn60oG1snOx7c4KuSReiurYUtlxPXyFtruLCrZPAgvvbIGOQWY
	 OQ9hoQiZDIStVb5pSLjgBcGFUVmhjcWQzAk+18nHQd4rToDhM306g2wCiBk6R++lLl
	 o4Fz56Tl4/CFA==
Date: Sat, 27 Sep 2025 17:36:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
 naresh.solanki@9elements.com, michal.simek@amd.com,
 grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 2/4] iio: mpl3115: use guards from cleanup.h
Message-ID: <20250927173621.09bc9f39@jic23-huawei>
In-Reply-To: <20250926220150.22560-3-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
	<20250926220150.22560-3-apokusinski01@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Sep 2025 00:01:48 +0200
Antoni Pokusinski <apokusinski01@gmail.com> wrote:

> Include linux/cleanup.h and use the scoped_guard() to simplify the code.
See below. I'm not sure this is in general a good idea in this driver, but
see the comments below.  I think more traditional factoring out of the code
under the lock into a helper function should be the main change here.
That might or might not make sense combined with a scoped_guard().


> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 42 +++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 579da60ef441..80af672f65c6 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -10,14 +10,16 @@
>   * interrupts, user offset correction, raw mode
>   */
>  
> -#include <linux/module.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/module.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/delay.h>
>  
>  #define MPL3115_STATUS 0x00
>  #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
> @@ -163,32 +165,26 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>  	u8 buffer[16] __aligned(8) = { };
>  	int ret, pos = 0;
>  
> -	mutex_lock(&data->lock);
> -	ret = mpl3115_request(data);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> -		goto done;
> -	}
> -
> -	if (test_bit(0, indio_dev->active_scan_mask)) {
> -		ret = i2c_smbus_read_i2c_block_data(data->client,
> -			MPL3115_OUT_PRESS, 3, &buffer[pos]);
> -		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> +	scoped_guard(mutex, &data->lock) {
> +		ret = mpl3115_request(data);
> +		if (ret < 0)
>  			goto done;
Read the guidance in cleanup.h.  Whilst what you have here is actually not
a bug, it is considered fragile to combine gotos and scoped cleanup in a function.
Sometimes that means that if we are using guards() we need to also duplicate
some error handling.

So, the way to avoid that is to factor out the stuff under the goto to a helper
function.  That function than then return directly on errors like this.

Looks something like

	scoped_guard(mutex, &data->lock) {
		ret = mpl3115_fill_buffer(data, buffer);
		if (ret) {
			iio_trigger_notify_done(indio_dev->trig);
			return IRQ_HANDLED;
		}
	}

	iio_push_to_buffers_with_ts...
	iio_trigger_notify_done(indio_dev->trig);
	return IRQ_HANDLED;


However, it is also worth keeping in mind that sometimes scoped cleanup
of which guards are a special case is not the right solution for a whole
driver. I'm not sure if it is worth while in this case, but try the approach
mentioned above and see how it looks.

Alternative would still be to factor out the helper, but instead just have
	mutex_lock(&data->lock);
	ret = mpl3115_fill_buffer(data, buffer);
	mutex_unlock(&data->lock);
	if (ret)
		goto...


Jonathan

> +
> +		if (test_bit(0, indio_dev->active_scan_mask)) {
> +			ret = i2c_smbus_read_i2c_block_data(data->client,
> +				MPL3115_OUT_PRESS, 3, &buffer[pos]);
> +			if (ret < 0)
> +				goto done;
> +			pos += 4;
>  		}
> -		pos += 4;
> -	}
>  
> -	if (test_bit(1, indio_dev->active_scan_mask)) {
> -		ret = i2c_smbus_read_i2c_block_data(data->client,
> -			MPL3115_OUT_TEMP, 2, &buffer[pos]);
> -		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			goto done;
> +		if (test_bit(1, indio_dev->active_scan_mask)) {
> +			ret = i2c_smbus_read_i2c_block_data(data->client,
> +				MPL3115_OUT_TEMP, 2, &buffer[pos]);
> +			if (ret < 0)
> +				goto done;
>  		}
>  	}
> -	mutex_unlock(&data->lock);
>  
>  	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
>  				    iio_get_time_ns(indio_dev));


