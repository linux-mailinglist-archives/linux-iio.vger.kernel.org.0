Return-Path: <linux-iio+bounces-5577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DF8D6FF0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED3E281B7E
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901511509AC;
	Sat,  1 Jun 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2FfuuiJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D349150999;
	Sat,  1 Jun 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247413; cv=none; b=VYuCWBFcczbiTmuvpUMZ9VZM9iReHLfqtIV/OOEz1F5RvK40OWee6ANNt7vK0JwI1r41daAFcoMZLjeKqjnFxZ/oYx/WusrBT3nqlCmnq7LWPYUJrIm0KSoGiSU98LX2UeOYCvacYxRFmIG8P6Cdj6qJLbqaHVZyaO2gymLBxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247413; c=relaxed/simple;
	bh=cmYJLVQl+Qry+6f6LAERNQqL7BdGsF9DLbL1THduZ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ/IlNVKJ8k1DWo+s7EGEN5O6n8KlbVB1e/ujutZPCl0yjpjVWI0lD0jwCqtN+SMtQqg7Hr6VCp4mmVMHz1NaNFecFud++sup2+xe7SEw+RL1aviBUn5k4fzkc0pDOqhS5OAPYN4ydujnjh0aSveD9FOzbT2BCtbpe+eZ9kMhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2FfuuiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41C9C116B1;
	Sat,  1 Jun 2024 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717247412;
	bh=cmYJLVQl+Qry+6f6LAERNQqL7BdGsF9DLbL1THduZ/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2FfuuiJV4tyPgty+6Xvx9jXJ3zaxnnm+Q2zUc2ZVz+f+bIOeieWyXRIZ3bgxrvzs
	 PWdpGuGwkdFMksqk1yj/Yx8cN7ojv7xCzekMFfz+a+41YVGyImgOd6tYYhR298bOCO
	 mYG6sfm5z7dPXdL3WZ7Xos2hHQnezB6ElI10DJolFxvzn3KzW8MhkWBRLKx4Z9CcQ3
	 p+1VNPbq4c9FK6UWnlL2F/qep1A4xvHCwjL0QFSohDTg4WgtWMl5bYoL4TA4OQaQvW
	 +8XujjgAtp9es2AoJcl4Nn7ystUDMgXX1w5PyDGjfCvVzbe/YWtE8kPb/ieJPlqAKt
	 15v0Bx6/Qy55Q==
Date: Sat, 1 Jun 2024 14:10:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: frequency: adrf6780: rm clk provider include
Message-ID: <20240601141001.3ebcc289@jic23-huawei>
In-Reply-To: <20240530092835.36892-1-antoniu.miclaus@analog.com>
References: <20240530092835.36892-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 12:28:34 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The driver has no clock provider implementation, therefore remove the
> include.
> 
> Fixes: 63aaf6d06d87 ("iio: frequency: adrf6780: add support for ADRF6780")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied
> ---
>  drivers/iio/frequency/adrf6780.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
> index b4defb82f37e..3f46032c9275 100644
> --- a/drivers/iio/frequency/adrf6780.c
> +++ b/drivers/iio/frequency/adrf6780.c
> @@ -9,7 +9,6 @@
>  #include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> -#include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/iio/iio.h>


