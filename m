Return-Path: <linux-iio+bounces-6773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0560913CA6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0421C214E2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1B181D08;
	Sun, 23 Jun 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URGdtT+R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BFBA41
	for <linux-iio@vger.kernel.org>; Sun, 23 Jun 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159321; cv=none; b=Ys1zw23rCaPOo0k1BHoFIYJEJ5BEodaDtSeKdOF2CWrCSWAlCgjDgoEfE7ZJLFVYdo/2ChmXIv8+0gFvG/blJW85s6XHmLB7RbMnqjZ2I42CoaiC8jyNK9Ke48hbEYnb9ff1snmuVBIJWU4sr8/A1SJAgjQmQrSX99T1oybc06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159321; c=relaxed/simple;
	bh=QkmxQ9f3c0aGYj5f8b7yhylxAEDMKT+HBd7pBvj3Sno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAZ35WbUu8bzBNZCTnk7zL7kT9NcMgp0wjv8pZ324tjuifyM8W830aWNjcO6izV1ncxEXNswAVKiul58kSA00k04+I1PCXJz7oqa158aUEoZbT0gB3s00eaEMwmV6rUaxV/jeWXgcfRLyiAXBGLoKKI22JdwTcXp2EH4XFsRocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URGdtT+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A771C2BD10;
	Sun, 23 Jun 2024 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159321;
	bh=QkmxQ9f3c0aGYj5f8b7yhylxAEDMKT+HBd7pBvj3Sno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=URGdtT+R6am7zvpPoUn56RG2xmGUgWJPqGl3CQREzGlbgCEF0KdkQRd3O8t2u1mAU
	 WD112yNnDNajX5uvTcmZtXUqwfA1CGl0E9kipK14AGhTK61D8qJWYulwwbBkJHxBKk
	 X4bwrF+KQ0r5c6TYzzmIq/VKDMPOJ8FF+kkBJc+GjrOmHo9coZ94XbzkC0g54xeqOR
	 VqnVu1NKP5mlroERC8vFMtJ+oeDAwtX4q5CYHSO362fpoFQmgYNaLQBxG0Gf7ofWcr
	 NcjfK5mJI0vBJ3KM4AJkV0rp43X2tYNeaDi2PBPr0IyBRZ7X71jXBzygSng4qCgROM
	 4HT05VtHtjhog==
Date: Sun, 23 Jun 2024 17:15:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/9] iio: imu: adis_buffer: split trigger handling
Message-ID: <20240623171347.52998cc4@jic23-huawei>
In-Reply-To: <20240623170319.4c79bf16@jic23-huawei>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
	<20240618-dev-iio-adis-cleanup-v1-1-bd93ce7845c7@analog.com>
	<20240623170319.4c79bf16@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 17:03:19 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 18 Jun 2024 15:32:04 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
> 
> > Split trigger handling for devices that have paging and need to
> > select the correct page to get the data. Although this actually
> > introduces more LOC, it makes the code and the locking clear. It will
> > also make the following move to the cleanup magic cleaner.
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>  
> Hi Nuno,
> 
> Just one thing,
> 
> > +		ret = spi_sync(adis->spi, &adis->msg);
> > +	if (ret)
> >  		dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
> > -		goto irq_done;
> > -	}
> > +	else
> > +		iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> > +						   pf->timestamp);  
> 
> Keep the goto as having an indented 'good' path is not great for readability.
> 
Meh. That was (almost) all I found to comment on so I changed it back whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> > -					   pf->timestamp);
> > -
> > -irq_done:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> >  	return IRQ_HANDLED;
> >   
> 
> 


