Return-Path: <linux-iio+bounces-17686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA3A7CF15
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B437C16F049
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086717A2F8;
	Sun,  6 Apr 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moYH1snc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD1224FD
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743959255; cv=none; b=Mfi2sFXHhSXgOM64ZFsPLsIdmG8n3EDjH9N+B3QEFAyhlTYLQdGg+lsnOVKlnS+6z0HcS7ro0OXWwf3uCclabpb2hbRbYExY0rc/UlIe/ScqsHAdP28SROFitwhlCoUXnnLdq3KWP2Rn0d0P9wnn3EYb4/1YDpVIufq3H4jHafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743959255; c=relaxed/simple;
	bh=XQkeqrq8EEHP2eshHbau1VEFf6KgvpoLVNswJyOCcHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIhP2FyvWTCrmwlSRVoNH7IPw8mKs2CK/3w6zYIeW1i4ahb/OuN2kR4cvafsQmyUVjSRvQxUb89vBeoMOUEd8cpgQAr5JiZpQA2ZcwNAgtO0zUOLzxPPttTHGd7SS78YHVLszBe5XyVaDJgkIqXyHTL2GJNR/wddTi1YufNt1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moYH1snc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16D8C4CEE3;
	Sun,  6 Apr 2025 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743959254;
	bh=XQkeqrq8EEHP2eshHbau1VEFf6KgvpoLVNswJyOCcHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=moYH1sncWG2r49u2QM0oH6B3J4l3G8ybOSSX5aWU1JHOBhWJt+s1FZ4dz99mNcvFy
	 HVVaBLPBrCQmG7AuCK0/b86InduCfUZFYrR2Vk2AC/jO9KjDbeL+n6TYpnMA0gGw4w
	 1RaBJ7u77n4i0UyYRHsMji4iVh7kUomgHZa/01M9YXBHMLYn2B3NvRZY9OS4OLeN31
	 Q8Fq6QkPw6boHmlum+JK9pIElscSaXnrxr75mBt7wVwSTEUqxnMRNyAUdaT65xQYKc
	 dNnZXMOI37WwYMmDFhUDLdNeVosT5A85DbExR2tSA/3jPgvBK/I8nJYzJUXLKBGKUA
	 P6VrqJTxkOyaQ==
Date: Sun, 6 Apr 2025 18:07:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/16] iio: accel: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
Message-ID: <20250406180727.681c42e3@jic23-huawei>
In-Reply-To: <fa8b21c0-f3f3-4022-bef6-2e14586256cc@baylibre.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
	<20250309182100.1351128-7-jic23@kernel.org>
	<fa8b21c0-f3f3-4022-bef6-2e14586256cc@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 17:20:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new function allows us to perform debug checks in the helper to ensure
> > that the overrun does not occur.  Use it in all the simple cases where
> > either a static buffer or a structure is used in the drivers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/accel/adxl355_core.c    | 4 ++--
> >  drivers/iio/accel/bma180.c          | 3 ++-
> >  drivers/iio/accel/bma220_spi.c      | 4 ++--
> >  drivers/iio/accel/bma400_core.c     | 5 +++--
> >  drivers/iio/accel/fxls8962af-core.c | 4 ++--
> >  drivers/iio/accel/kxcjk-1013.c      | 4 ++--
> >  drivers/iio/accel/kxsd9.c           | 5 ++---
> >  drivers/iio/accel/mma7455_core.c    | 5 +++--
> >  drivers/iio/accel/mma8452.c         | 5 +++--
> >  drivers/iio/accel/msa311.c          | 4 ++--
> >  drivers/iio/accel/mxc4005.c         | 4 ++--
> >  drivers/iio/accel/sca3300.c         | 5 +++--
> >  drivers/iio/accel/stk8312.c         | 2 +-
> >  drivers/iio/accel/stk8ba50.c        | 4 ++--
> >  14 files changed, 31 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> > index e8cd21fa77a6..ae949ada6db5 100644
> > --- a/drivers/iio/accel/adxl355_core.c
> > +++ b/drivers/iio/accel/adxl355_core.c
> > @@ -666,8 +666,8 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> >  	if (ret)
> >  		goto out_unlock_notify;
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > -					   pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,  
> 
> Could also use aligned_s64 in the declaration of buffer.ts.
I think that's a bug given it might be 32 bit aligned (we love x86_32)
and the structure come up short.  

> 
> > +				    sizeof(data->buffer), pf->timestamp);
> >  
> >  out_unlock_notify:
> >  	mutex_unlock(&data->lock);  
> 
> The rest check out.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 


