Return-Path: <linux-iio+bounces-18269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669EA93A45
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC611B60373
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31F32144CE;
	Fri, 18 Apr 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9s1orij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4813FD86;
	Fri, 18 Apr 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992193; cv=none; b=PQM+YqgQIDSd3TfisvKd0AmJ+QeBAqE0a69DmgLbbuzz+6A2GUqfrt5mZyAncOfu2kU8TYMs8mJvfNweex6QhoOJNxCGbP5dCFITdrV4ilU5+UVSxbGRz3j6LugQ6GWXYjt+hHx36ClOhZnyelGl/1Q9DZlTiKkvPzJpVSFNx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992193; c=relaxed/simple;
	bh=/LA7vUXrPtMNDgc3KGNGasHazkFHhPDx2AIfeBrixOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnDYRntwRueUOHdeqtMj1OWkdGhe+Pr9K/l2Zazz4QN4hIzwqZphiav5X1dOZ2x6uTMmTufmZlZzdfhHrcUJmZghSXINgWNNEjAPUdybuhhcH/t1b41ielRPc5LDmhWA0z+tsnzea28Ya5/WCr/IXBydC1S2JdP9jGNUrUQDUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9s1orij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FADC4CEEA;
	Fri, 18 Apr 2025 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744992193;
	bh=/LA7vUXrPtMNDgc3KGNGasHazkFHhPDx2AIfeBrixOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9s1orij+EPupf1XRsOw7yRk6tPsIWpo1YpYq9IYLMDYwFIZAa9JqaIjVDPPhh/R8
	 xjo+yc4loFBxSt3kVu2aEm8MIDA1YTqq6C8yEJGw2QIb2JFxIQ77P+QgnwrQWHsBxm
	 0dDTJrgLtWMSYZVyhQdGvBuREU0hFuAP/HTi1rfxk1gKx+oxbuJMjOz3jkM5bCWJGE
	 wLKVT6iCToFJVIIRjMpHtLCVQj5nFm3EZ4uuO9lHmxVKmBGFUFddT5pus9yewn62eo
	 6MfQqdhqyac80jssrA2bHjsls2ayY7YSG8h0GbVV2qc/CR2QnN06VqI7+Zg/uNpWDU
	 c9GGXDeE9r+Ig==
Date: Fri, 18 Apr 2025 17:03:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: dac: ad5592r: Delete stray unlock in
 ad5592r_write_raw()
Message-ID: <20250418170304.7a7efb8d@jic23-huawei>
In-Reply-To: <Z_-P7bsD3KL5K25R@stanley.mountain>
References: <Z_-P7bsD3KL5K25R@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 14:09:33 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This code was converted to use guard locks but one of the unlocks was
> accidentally overlooked.  Delete it.
> 
> Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Applied. Thanks.

> ---
>  drivers/iio/dac/ad5592r-base.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 217a8a88818d..5f2cd51723f6 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -324,10 +324,8 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  
>  			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
>  						&st->cached_gp_ctrl);
> -			if (ret < 0) {
> -				mutex_unlock(&st->lock);
> +			if (ret < 0)
>  				return ret;
> -			}
>  
>  			if (chan->output) {
>  				if (gain)


