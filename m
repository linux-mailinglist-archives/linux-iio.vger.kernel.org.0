Return-Path: <linux-iio+bounces-408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3257F94CA
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48881F20EC6
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209AFC0D;
	Sun, 26 Nov 2023 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCtTUJfZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6824EAD6
	for <linux-iio@vger.kernel.org>; Sun, 26 Nov 2023 18:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548EEC433C7;
	Sun, 26 Nov 2023 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701022182;
	bh=SLuAs/HbMN7WsDzAJGn90eTqZkD8vv1/cK9ItXh77Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZCtTUJfZDgKAZfLHMXglWI/EFreOBt6VY3oj5Ly2RV4hT2e+ZeSieTCTHF40TK0yz
	 r/9DDlQNcn9UD7uRq6dYz5wgPO4lNU5+gvYr6z1WKH77KiFNhsIf6b3fQ7ESuv7Img
	 WQHE/yfkYMEWysyyWnf2Htrl/hZr6NMvbMPr5I5uEfK9t3eWbKLv8toHEjKQ0Iv3/M
	 C9Z6ZBal7s3kEEq9pu89LTukGhNS+cyhiJbhzxFH6UnpOWYoUSxN6wcXFaEP4mdfwa
	 Cgo8COHLTKpK0Gt1Fa8YBPIVqhWEvFWt6aYkA5JE5U+iibFBnGouIK5Zt3IbiuEvc5
	 mr87fyIc1rkTQ==
Date: Sun, 26 Nov 2023 18:09:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231126180935.0c1cc663@jic23-huawei>
In-Reply-To: <20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com>
References: <20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 19:57:24 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Hi Marcus,

Great to see this being used, but there is a little more you can do
here to take advantage fully.

> ---
>  drivers/iio/adc/mcp3911.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 974c5bd923a6..85bb13eb6f3b 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -168,7 +169,7 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = mcp3911_read(adc,
> @@ -207,7 +208,6 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  out:
> -	mutex_unlock(&adc->lock);
>  	return ret;
No point in having the label down here after the change. Just return directly
wherever you see an error.

Same for other cases.

>  }
>  
> @@ -218,7 +218,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> @@ -263,7 +263,6 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	}
>  
>  out:
> -	mutex_unlock(&adc->lock);
>  	return ret;
>  }
>  
> @@ -350,7 +349,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	int i = 0;
>  	int ret;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
>  	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
>  	if (ret < 0) {
> @@ -368,7 +367,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
>  					   iio_get_time_ns(indio_dev));
>  out:
> -	mutex_unlock(&adc->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231125-mcp3911-guard-866591e2c947
> 
> Best regards,


