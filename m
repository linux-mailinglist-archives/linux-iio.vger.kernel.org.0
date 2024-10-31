Return-Path: <linux-iio+bounces-11721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C189B84F5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A12B21346
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552A1C9EA3;
	Thu, 31 Oct 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQuNMRR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AE13A87C;
	Thu, 31 Oct 2024 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408940; cv=none; b=ipIvrSvT/UjLof7VZHHj74eWRgUwxqmA1TAut16xM/sZ0+UerE6sFGzjMg6V12e8A+8DoJDA2yVyiHrLZWmLvXc4ZzGuZR2bDqApURbWame1umsS7YDq5mzL/Li9KABUrsxUTq7TdUZWX8gTTSSRppp3ZbN3UDy7lIY8Fi+oBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408940; c=relaxed/simple;
	bh=aFoHIsTuzfvNx6QC2NqqSCC5HAnh10pMWryfTLwaeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BofI5+d5WhO2jBa0xZbz5CxSWeHlKFHLJAKqVNs82gCyWQDreQy6ok9cBh1+MXRnVu4Q9PVnVI0id+iXAdSz16mmRwfRT5UCkVHvJb6NHCzrSUfMfeeLORwE+ljE1wooQjD9r2BaBeBEAybCUzjKNH4IWYQbEb4R+C2rw25K+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQuNMRR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B8FC4CEC3;
	Thu, 31 Oct 2024 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730408940;
	bh=aFoHIsTuzfvNx6QC2NqqSCC5HAnh10pMWryfTLwaeAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQuNMRR+uJE0qZa1ddxzmmlAQ9c9VTuEFlv5oF4F2Twlau1nMkfAInxoY78xggMGi
	 5nP+LdLq4Gs2r3p2iilwgPsoAbWGtKVQTDc2EwAnWO5PSrUFuOweBQjgUSfHXXtME/
	 kiOXsugwD+fjQH5YzK1eEmDpT20IZjZbonWuaP7NVMy4CPoP53s1hspizmMQwNuCWG
	 Pysi1UdmC3Q6T2ffpNJQHOCC5yj5NNdlYwl0EM0ZfVG/vLyMpB3SCHiTGPVMZiBajC
	 lnF0t+xJYLlr36i8GaMc0HbCUfPeXO8sW32btqQyJjdaHIcbS3fuX6HW8IfK1cUbsL
	 0zReG4eJrVYHw==
Date: Thu, 31 Oct 2024 21:08:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: <Michael.Hennerich@analog.com>, <renatogeh@gmail.com>,
 <lars@metafoo.de>, <giuliano.belinassi@usp.br>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tanghui20@huawei.com>, <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
Subject: Re: [PATCH] ad7780: fix division by zero in ad7780_write_raw()
Message-ID: <20241031210853.4a0bc3a9@jic23-huawei>
In-Reply-To: <20241028142027.1032332-1-quzicheng@huawei.com>
References: <20241028142027.1032332-1-quzicheng@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:20:27 +0000
Zicheng Qu <quzicheng@huawei.com> wrote:

> In the ad7780_write_raw() , val2 can be zero, which might lead to a
> division by zero error in DIV_ROUND_CLOSEST(). The ad7780_write_raw()
> is based on iio_info's write_raw. While val is explicitly declared that
> can be zero (in read mode), val2 is not specified to be non-zero.
> 
> Fixes: 9085daa4abcc ("staging: iio: ad7780: add gain & filter gpio support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Applied to the fixes-togreg branch of iio.git.

I might end up dragging this in to my queue for the coming merge window
if I don't get time to do another fixes pull request in the next few
days.

Jonathan

> ---
>  drivers/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
> index e9b0c577c9cc..8ccb74f47030 100644
> --- a/drivers/iio/adc/ad7780.c
> +++ b/drivers/iio/adc/ad7780.c
> @@ -152,7 +152,7 @@ static int ad7780_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val != 0)
> +		if (val != 0 || val2 == 0)
>  			return -EINVAL;
>  
>  		vref = st->int_vref_mv * 1000000LL;


