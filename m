Return-Path: <linux-iio+bounces-6288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E859097CC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACAAB21328
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775D22097;
	Sat, 15 Jun 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTaWOIK5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B4376E1
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718449002; cv=none; b=Nc9o3BxCUdltuMIrFNpm3mW/6OJk02Yd4M1MkRdP/zUDWGTQlVokMXxBi1j9YQsw8VACz0+WkBfu8bvElFVcAHh1NOKTomyOC1GOhwNQeFZbrBAsYRog0crOnZkdsSi4Sc09bWTE5Ds1jbmGy74X7lGS93sEqC8GGj+VlLkAZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718449002; c=relaxed/simple;
	bh=zbogLXU3+aniDekEtFgebioqjN4DObtwjI1oANgbe68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnFnRRk5skpFlTQngMkwBQ7YSqtrmYdZ3kOXWcbtwzqhXFiia+314lQg0ZXRLrVsL7pkaWxm6o8KGul8XIN0/i7yStu+wyPiawC5fKPvoe87P0QydwgEjCV3t1mmlXaE/QuSv4Mbgk88gwn9MgQDRASij2r+nprzfIRx2EqU17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTaWOIK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D93AC116B1;
	Sat, 15 Jun 2024 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718449001;
	bh=zbogLXU3+aniDekEtFgebioqjN4DObtwjI1oANgbe68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HTaWOIK5PdxW/FfI9gPIXYfTCSIKz9akKB/72S6qaruVJtrUiH1zTMJq9LANqxEV8
	 nJbdRD50HwIU7pZo4J8Pn7E8DvCQRelMm1RQJ7sp/25pmlDfcmo/+yU906ULta9sF2
	 AVW+meY1ahH7rGv7SAUBarmhqibrDtln709z1qfbty7umqqEBs+RhtkmJzlkELvNGc
	 yBu2IBm8Vtj+bIlDzD6cppv20Mlq0DoXQ750LKSR9JaVV0mNZD0vs6i0l0xHHGl7js
	 4y3mlRjFIW7ncsj71SUL61xFtuVPWtJoYE1zUAD3lGfXd7g+4wJ2hK8ca1jUSPj5rY
	 4A9o6dxyiW11Q==
Date: Sat, 15 Jun 2024 11:56:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eduardo Figueredo
 <eduardofp@usp.br>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: ad7266: Fix codestyle error
Message-ID: <20240615115634.2f106c13@jic23-huawei>
In-Reply-To: <20240613153920.14647-4-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
	<20240613153920.14647-4-hagisf@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 12:39:20 -0300
Fernando Yang <hagisf@usp.br> wrote:

> Fix some codestyle errors indicated by checkpatch.pl
> 
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 356c2fe07..5a2f1bb27 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
>  static int ad7266_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_wakeup(st);
>  }
>  
>  static int ad7266_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_powerdown(st);
>  }
>  
> @@ -153,7 +155,7 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  			ret = ad7266_read_single(st, val, chan->address);
> -			
> +
This is fixing and error from your previous patch.  Fix it there so this
is never needed!

>  			if (ret < 0)
>  				return ret;
>  			*val = (*val >> 2) & 0xfff;


