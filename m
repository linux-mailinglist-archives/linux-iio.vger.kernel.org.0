Return-Path: <linux-iio+bounces-9917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E08989D54
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F681C21BA5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58B17E473;
	Mon, 30 Sep 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZeFsIR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682917C9B8;
	Mon, 30 Sep 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686504; cv=none; b=MCUtwoIdVGPqfqj1cNPZdrecolnp/iOGlxu3gTNxB74a3HqIX4KCciTKpoOviD7lBUVphalWTKq7EkuM0vU3yDzP3uHY1nVyMBlnDJVPFAWoKBx57tHMEZ2o7AYr1QZuwi9AXIwVF3M5n/Hw78NsWjlSzBdMgjG53HrGkp7QuuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686504; c=relaxed/simple;
	bh=27bQt2MBk0WS6W2n5eBGFAv/vCkI1cxlIhRE7Zkjij0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEXp1Gj0ZptzPQFD69gMS6LKBLbAKHkU7UpMlv85IimQZiOZxVrWUh3Wn7TfrxPo9qVTvaBvUgnGSMdYWo2WSirbr7x3Y3p2J/rDp49BJg2XzKxLSpiNuZqQIG8695wyLy9fh/BxpSl2slVK03nsQmIOnH0Zxn79hVjCWJl4knM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZeFsIR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3215FC4CEC7;
	Mon, 30 Sep 2024 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727686503;
	bh=27bQt2MBk0WS6W2n5eBGFAv/vCkI1cxlIhRE7Zkjij0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZeFsIR+Gf2HUQMsmIFXzCOodBfy9ka9swr/fbAo7Oa6xLZzaEj7K6qPD6zUJR6Mv
	 7iCQJBJjMpfYZ3+DMVG630St9kc3I8UqzrvPyUxED20spsrLOkIH6BU+NWEKzE7vFH
	 pGnqDOiE7o6ezQuJsFHKqnYW1Dl/ugb1QgMFHtnBFIGfu568s/gbsP0rpvJGgydiln
	 FF4K17i19Yx2+pTe3GBquTWFACRN8/5iERuSdAwyrGUN+9P7R7cCKO8YeD6GzQnGIl
	 B6ieA00vzqxtKHFXGFfUHoVLJ47aK5UcuJGSUVJIdnvWmTtXOA5Gn35czsClyV4pEE
	 C8ZPCRhMRd8Nw==
Date: Mon, 30 Sep 2024 09:54:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: bmp280: Use char instead of s32
 for data buffer
Message-ID: <20240930095456.599f2304@jic23-huawei>
In-Reply-To: <20240929182655.GB213331@vamoiridPC>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
	<20240929112511.100292-3-vassilisamir@gmail.com>
	<20240929181003.26abf543@jic23-huawei>
	<20240929182655.GB213331@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > -	s32 sensor_data[6] __aligned(8);
> > > +	struct {
> > > +		u8 buf[12];
> > > +		aligned_s64 ts;  
> > 
> > I'd missed that this depends on the number of channels.  It makes no functional
> > difference because the core code will happily write over the end of buf, but
> > from a representation point of view this might be
> > 
> > 		u8 buf[8];
> > 		aligned_s64 ts;
> > or
> > 		u8 buf[12];
> > 		aligned_s64 ts;
> > 
> > So given we can't actually fix on one or the other normal convention is
> > to just use something that forces a large enough aligned u8 buffer like
> > 		u8 buf[ALIGN(sizeof(s32) * BMP280_MAX_CHANNELS, 8) + sizeof(s64)]
> > 			__aligned(sizeof(s64));
> > 
> > Sorry for leading you astray on this!
> > 
> > Jonathan
> > 
> >   
> 
> I see your point. I can fix it in next version!
> 
> This is a neat issue here that requires indeed extra attention since
> this type of buffers is used basically by the majority of the drivers.
> Some type of runtime check in those registers would have been very
> very helpful, but I can't see of an easy way of doing it in the core
> code..
Adding size description has been on my todo list for a while so as to allow
the kernel to check the buffer is big enough and get rid of subtle overrun
bugs due to that oddity of the buffer needing to include the timestamp
space even though it's not obvious it will be written to.
That would also allow us to check alignment.  What we can't do is finer
grained checking of these structures but arguably we don't want to as this
is an elegance not correctness issue!

> 
> Thanks for the review :)
> 
> Cheers,
> Vasilis
> 
> > > +	} buffer;
> > >  
> > >  	/*
> > >  	 * DMA (thus cache coherency maintenance) may require the  
> >   


