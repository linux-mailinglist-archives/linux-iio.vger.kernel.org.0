Return-Path: <linux-iio+bounces-16950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9671A64B64
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787343A8A0F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA4233128;
	Mon, 17 Mar 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgqSfJsq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBC38B;
	Mon, 17 Mar 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208969; cv=none; b=u/rzTpve3EnjtZpm/Cyxq2UzA8gqKyMipTbI/zMEUfB3d+PjQ+gAWB3ruqEFVcwNAIViyT7Qnhth595ru77j1nHqh+PCX0qSJMj8XyjeClkhy+9ytfOchwwW8QpixDchl7JM9tUJFGUJhTRVZnwRIsOzHlKfvBuBYD3NYTbv+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208969; c=relaxed/simple;
	bh=WZDhLqcf3/jlXtuxPqvBtDZ50ZpRwYoWKtIABiDvqd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSvXbflxKeg4rgxm9J8FYXOufFPZYsKpBq1Ma/Dr1GjrdQ4jjae4Kmg2/klwSJLjFIR0UCUhx2EtE4NUtF+Ynlr7gUDdAXyYuMH1r1xPSO0memRDBa1TkHS7BOYZtoUtu2oqTB56Br4jSi455mbLbs6Kaw6W50+hgwgnh2iaciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgqSfJsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC3AC4CEE3;
	Mon, 17 Mar 2025 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742208968;
	bh=WZDhLqcf3/jlXtuxPqvBtDZ50ZpRwYoWKtIABiDvqd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgqSfJsq4P2PixZITDuCNavXJWB7M03AOC9P8sBR6cEUBliAdqgp569M3+wcQjA+o
	 bPF5+mZ1N4yHjRi6oi8RmccDfVIw06DdEjRDsd7vB7BF0DgwY6uKXF31UyRC+/6aTk
	 zWZSsr9atW1INNYAgCEMUzvjuVjHOBThoOmL7hXcr1mF0BOABrHxOrqhyvhiM2TizM
	 rGohxxKPI7jJ9l++5X9kWXkXLASi9KXwV9GWhBSPPizA3Y46VQSZThvHlsXHJMHoFk
	 myzOYRmQj5HpUsfIpbaXit6UyFahf7ZT/H6ydGmleDBwQdTZ4YFMkDLVQ1cwl8Lw6Z
	 ee428K/ZaPKqw==
Date: Mon, 17 Mar 2025 10:55:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
Message-ID: <20250317105540.4b4a586f@jic23-huawei>
In-Reply-To: <Z9ctSODRTxI53jAY@surfacebook.localdomain>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-5-l.rubusch@gmail.com>
	<Z9ctSODRTxI53jAY@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 21:58:00 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:
> > Move the fifo handling into a separate function. This is a preparation
> > for a generic handling of the interrupt status register results.
> > 
> > The interrupt status register is read into a variable int_stat. It carries
> > status for various sensor events, handling of which is added in follow up
> > patches. Evaluation of the int_stat variable is common for sensor events,
> > such as tap detection, freefall, activity,... and for fifo events, such as
> > data ready, overrun, watermark,... Also, dealing with in case error
> > returns shall be common to all events. Thus migrate fifo read-out and push
> > fifo content to iio channels into this function to be built up with
> > additional event handling.  
> 
> ...
> 
> > +static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
> > +{
> > +	struct adxl345_state *st = iio_priv(indio_dev);
> > +	int samples;
> > +	int ret = -ENOENT;
> > +
> > +	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > +		samples = adxl345_get_samples(st);
> > +		if (samples < 0)  
> 
> > +			return -EINVAL;  
> 
> In the original code it makes no difference, but if you are going to share
> this, I would expect to see
> 
> 			return samples;
> 
> here. Why the error code is shadowed? If it's trully needed, it has to be
> explained in the comment.
> 
> 
> > +		if (adxl345_fifo_push(indio_dev, samples) < 0)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}  
> 
> ...
> 
> Jonathan, I saw that you had applied it, but I guess the above needs
> a clarification.
Was right at the top of a tree I don't mind rebasing. So dropped
this patch (kept 1-3)

> 


