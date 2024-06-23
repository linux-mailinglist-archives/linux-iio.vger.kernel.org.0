Return-Path: <linux-iio+bounces-6772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1940B913C9D
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B221C216C7
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10761822DA;
	Sun, 23 Jun 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5dsBmBR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369F181D02
	for <linux-iio@vger.kernel.org>; Sun, 23 Jun 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158606; cv=none; b=pxGIXYOaokGFEt4+n9TNOUWCFo7Qn+5vy+BcCLLL99wSTIbIJ8tfVMdX4cgYLiTHeP1+Hvv1D2Q2fMU+D/5P6CvUQHtuN+okInVIWcWpsiATabLOnHk6p8jfnielIGkvyGK8Q+fwQJWX3IRVumvwy8njtHKJGSZBEDrz5L48eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158606; c=relaxed/simple;
	bh=NG75ipG7WqXDcqB/2YU6ukAdyXmTvVOm++KruGa4gYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM8YcZW7lPbs1Uj3vH0R1v5dWFmYxR7nZFtiDCsstZ2ZmnAdFnZRAcWtOeH076qD2fg6AGQKCYkhTgypALkVGvDciqug0/TR77VjBLic1uJepFfSrXH8ZMjbxpsMDixDY1sDpRt1TsZ4QdX9dRUdtGgLJUwMOvcgpJqcnPbZFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5dsBmBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF77C2BD10;
	Sun, 23 Jun 2024 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719158606;
	bh=NG75ipG7WqXDcqB/2YU6ukAdyXmTvVOm++KruGa4gYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5dsBmBRwXqlsdodjHzEVyuzK3XoW5kfoA/ATwsiJ7JeJKFzBF3JP1wen1z5pHGwN
	 bdk5+TBg5k2MHE2E411LPYSPy5QJ78tfuNiZLei3kdGP74FymVG+OYvfrUpG+QSztq
	 79+592KJJ3Tls9R3/QihA/AB2CmocWtzDp7BJYIVUk32ysyIrx/xGkkZnmBjc1Hcm4
	 dufgjjboySANmY/ylDRCuE6LYvKTJA8EmOOrjAbmdS9nY4eHB833xfn/4O94jelmdN
	 1sBEmioceO4n/N/Qm0ZZKRrLIt7K/UtlI3e2pkKU4+VHVSkijzjnl3FsIa0QtFTzXW
	 Da1wu25/VuXVg==
Date: Sun, 23 Jun 2024 17:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/9] iio: imu: adis_buffer: split trigger handling
Message-ID: <20240623170319.4c79bf16@jic23-huawei>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-1-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
	<20240618-dev-iio-adis-cleanup-v1-1-bd93ce7845c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 15:32:04 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Split trigger handling for devices that have paging and need to
> select the correct page to get the data. Although this actually
> introduces more LOC, it makes the code and the locking clear. It will
> also make the following move to the cleanup magic cleaner.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

Just one thing,

> +		ret = spi_sync(adis->spi, &adis->msg);
> +	if (ret)
>  		dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
> -		goto irq_done;
> -	}
> +	else
> +		iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> +						   pf->timestamp);

Keep the goto as having an indented 'good' path is not great for readability.

>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> -					   pf->timestamp);
> -
> -irq_done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 


