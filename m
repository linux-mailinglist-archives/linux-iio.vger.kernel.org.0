Return-Path: <linux-iio+bounces-24520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B832ABA6E11
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 11:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7561898F57
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA32D9EE0;
	Sun, 28 Sep 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMDDxxwq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6D2D97BC
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052522; cv=none; b=UQ575h6aKCnwX+2gIRu8QW/JqH2JkWrHzNV5MPIhZlvwaxRrHazMa+t4BRxcx4/h4Jx/s44CkHaZwSwMEW5WR2tBH+kJ2MzbzZVqsz2iv0uoK7QTyzA7R9ATS0Cxr2M2jxZGv0Kj8J9kYMdbJSWhrVkEc0E0s2uGebw7vbnnfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052522; c=relaxed/simple;
	bh=DUAM4seh+KWwKZYjI00J3MrOycPvJM/Yvq2EBdgrc+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZOSE08dPYfjqX2AXv3CsHARjNaHUv5Kx71pDUpm4DER4Vsyy6dKxn2ATKfq0HYsKweuOJr3mFX1NxoLGvwKlJgWHgbj4EO1l6N5yTk7QcjIeJEQrOi4oSm/B6BpwmegGKo4oAr8mbT5Uf+Dl1/Tsdf5wAYl+ZQSrOxqy+yzubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMDDxxwq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e29d65728so24059525e9.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759052519; x=1759657319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu/NJXREHp33yMgG701EQxLa0NQPuBp7Lu8J6U+lM+Q=;
        b=nMDDxxwq2vsIMdluyzS4ENXcPyHcYClrIdCIDbmg1vGRzfCOoC7/poUEOIFN6U576h
         3AMI/L34Zw367tvX+hHNbjSLBrAK7hCnwefD5PeTDZSf0ZXt7HdRxwfslGLLKejvZzdz
         JlQxdaqQbCP68n3w899iuOUhqEyLJMrKd1Ulb/HhxP+zqZBCEGowGtgs86N1OzkupW/Y
         OglNHPj32M0nYnlo21YLdpj5KlriNUqEYuc1QARbn231t0WCch5QTggmQkUZl8nTO4ef
         2ZgV1P8ZyZsbrfYMq+YvkAtIv11gV+kBynjCO1c0s/K1+l3CgS6cf/c3VTWJOgER9B62
         Zlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759052519; x=1759657319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu/NJXREHp33yMgG701EQxLa0NQPuBp7Lu8J6U+lM+Q=;
        b=Chyn1om2dGOa9b3GxLE9uBAF1I+5H2vvCzHExVNRlfwsKjYOFF9byMH7qxXYvmpcVb
         IzHoxX1uCacNSrNrDhuXa9p7H3gKbKMsO7rbYH+VFfdcE9v0QPxWsS8IP0bIA5B1VM6R
         Utq0SLYSXXYRDqkkD/Ibr5nLkzU2VicRnVcMUM/B5W6p8rkPkNATp2mlmVV5YXpaLplB
         H2+n15AK6CIPWWeozdTtbg0J+gvaVkQvFycQStBZj3hFX1OYQ7IfPKJcrEWa9xZEXvGo
         Es0nBvlxT61tRY5pFsPnmPRcB3bVWHm303vP2vw+76D4eCeyvkVLkX2iy2tp4ti+vrN1
         QLyA==
X-Forwarded-Encrypted: i=1; AJvYcCW4aFmn9tCb8EFj9Y0EsZ294VCJYwBJV7QgxC8CrrtfRxqWab173mfyuI2k1cFjADZnzSihyoVd+YA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbi6SxlnSR4OA52bTpdcGpZlNJQXRnrHwE6jpcP6f3CHSUkYi8
	GXwutTumhPkaX+TaSPtaNi0Ro0UuAdTBP+21pDzYieGtyPGiXktJeSR1
X-Gm-Gg: ASbGncsJ7eZdq7TxCS+CMbe7Hb3x6w69XrD963ub8IB7hcfOr8cc4U+21Zf+kY0iwZG
	c6wfCBBZomWv5iMZ1QPPFUs4fQKQyOU+P3ULSY6K37fJEozWZMcC/hI8N61BiDZxigVjkFCHjXR
	/mtznx3eOrctdMYWW1By3NXodI8nDoalGCVZp5cbVoofR5MQoU7wDYym14RWJXZ1VN527m9h6Yi
	tU9uoAWVMjqwdr0nTw/GuC8xyZFIwczRg66XQyPjG31TU/6SKWgOnshFHEwXzJXQcagbzXeaWOz
	RSpn7ql2EkqA+KHGz+GF7MqjVbjaXeDifIOUip9YJWVXA/wha/pSOvwx5MqVwGOPMmCkwJF9I4R
	KSC36SEPHfBWUkluVEb5oo5sg7wReFbfBySnbjA3zMLpdj81FYbF80sZ9ZEunLXOJOmk=
X-Google-Smtp-Source: AGHT+IHX9VUoLygHmYlslyIRXdrJkzsw8xckiiAqyMLWxmDpD0d2AnjicSPbtMBF6XJqzI1b2bjK8A==
X-Received: by 2002:a05:600c:a08c:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46e37a74bc9mr96431435e9.34.1759052518976;
        Sun, 28 Sep 2025 02:41:58 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.212.233.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm185108715e9.1.2025.09.28.02.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 02:41:58 -0700 (PDT)
Date: Sun, 28 Sep 2025 11:41:48 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@roeck-us.net, rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com, michal.simek@amd.com,
	grantpeltier93@gmail.com, farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 2/4] iio: mpl3115: use guards from cleanup.h
Message-ID: <20250928094148.yid75l5jwywpvfei@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
 <20250926220150.22560-3-apokusinski01@gmail.com>
 <20250927173621.09bc9f39@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927173621.09bc9f39@jic23-huawei>

On Sat, Sep 27, 2025 at 05:36:21PM +0100, Jonathan Cameron wrote:
> On Sat, 27 Sep 2025 00:01:48 +0200
> Antoni Pokusinski <apokusinski01@gmail.com> wrote:
> 
> > Include linux/cleanup.h and use the scoped_guard() to simplify the code.
> See below. I'm not sure this is in general a good idea in this driver, but
> see the comments below.  I think more traditional factoring out of the code
> under the lock into a helper function should be the main change here.
> That might or might not make sense combined with a scoped_guard().
> 
> 
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  drivers/iio/pressure/mpl3115.c | 42 +++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > index 579da60ef441..80af672f65c6 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
> > @@ -10,14 +10,16 @@
> >   * interrupts, user offset correction, raw mode
> >   */
> >  
> > -#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/module.h>
> > +
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > -#include <linux/delay.h>
> >  
> >  #define MPL3115_STATUS 0x00
> >  #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
> > @@ -163,32 +165,26 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
> >  	u8 buffer[16] __aligned(8) = { };
> >  	int ret, pos = 0;
> >  
> > -	mutex_lock(&data->lock);
> > -	ret = mpl3115_request(data);
> > -	if (ret < 0) {
> > -		mutex_unlock(&data->lock);
> > -		goto done;
> > -	}
> > -
> > -	if (test_bit(0, indio_dev->active_scan_mask)) {
> > -		ret = i2c_smbus_read_i2c_block_data(data->client,
> > -			MPL3115_OUT_PRESS, 3, &buffer[pos]);
> > -		if (ret < 0) {
> > -			mutex_unlock(&data->lock);
> > +	scoped_guard(mutex, &data->lock) {
> > +		ret = mpl3115_request(data);
> > +		if (ret < 0)
> >  			goto done;
> Read the guidance in cleanup.h.  Whilst what you have here is actually not
> a bug, it is considered fragile to combine gotos and scoped cleanup in a function.
> Sometimes that means that if we are using guards() we need to also duplicate
> some error handling.
> 
> So, the way to avoid that is to factor out the stuff under the goto to a helper
> function.  That function than then return directly on errors like this.
> 
> Looks something like
> 
> 	scoped_guard(mutex, &data->lock) {
> 		ret = mpl3115_fill_buffer(data, buffer);
> 		if (ret) {
> 			iio_trigger_notify_done(indio_dev->trig);
> 			return IRQ_HANDLED;
> 		}
> 	}
> 
> 	iio_push_to_buffers_with_ts...
> 	iio_trigger_notify_done(indio_dev->trig);
> 	return IRQ_HANDLED;
> 
> 
> However, it is also worth keeping in mind that sometimes scoped cleanup
> of which guards are a special case is not the right solution for a whole
> driver. I'm not sure if it is worth while in this case, but try the approach
> mentioned above and see how it looks.
> 
> Alternative would still be to factor out the helper, but instead just have
> 	mutex_lock(&data->lock);
> 	ret = mpl3115_fill_buffer(data, buffer);
> 	mutex_unlock(&data->lock);
> 	if (ret)
> 		goto...
> 
> 
> Jonathan
>
Thanks for the explanation, both approaches look quite neat to me.
However, if we use scoped_guard() then the iio_trigger_notify_done and
return IRQ_HANDLED are duplicated, so I'd lean slightly towards the
mutex_lock/mutex_unlock solution.

> > +
> > +		if (test_bit(0, indio_dev->active_scan_mask)) {
> > +			ret = i2c_smbus_read_i2c_block_data(data->client,
> > +				MPL3115_OUT_PRESS, 3, &buffer[pos]);
> > +			if (ret < 0)
> > +				goto done;
> > +			pos += 4;
> >  		}
> > -		pos += 4;
> > -	}
> >  
> > -	if (test_bit(1, indio_dev->active_scan_mask)) {
> > -		ret = i2c_smbus_read_i2c_block_data(data->client,
> > -			MPL3115_OUT_TEMP, 2, &buffer[pos]);
> > -		if (ret < 0) {
> > -			mutex_unlock(&data->lock);
> > -			goto done;
> > +		if (test_bit(1, indio_dev->active_scan_mask)) {
> > +			ret = i2c_smbus_read_i2c_block_data(data->client,
> > +				MPL3115_OUT_TEMP, 2, &buffer[pos]);
> > +			if (ret < 0)
> > +				goto done;
> >  		}
> >  	}
> > -	mutex_unlock(&data->lock);
> >  
> >  	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
> >  				    iio_get_time_ns(indio_dev));
> 

