Return-Path: <linux-iio+bounces-787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C980BA68
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA46B280C88
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD74E8820;
	Sun, 10 Dec 2023 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWl2qu3h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD71FAA
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 11:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AC1C433C8;
	Sun, 10 Dec 2023 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702208199;
	bh=qTvsFMMpkPo9pL5ZTU/DKytaWYt9qAeOfVXyFFr6Hew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PWl2qu3hMy9jm82HEngDDyto7e6Mjm0EOFNs3fnJDkJLCXy/ujUPYwCVFa6w3+FLi
	 JZWcgA2J9fNrDad0aj6JIGBS9Kh1jbGqW6XPTp3y3GgISVNa9WcIdFSsAy51gD2XoV
	 /gQY5CvysuN4TZgeCvHJMpraGIm6BURtq70CzOs+vHWiCIiZQ1ARu+DY4MtWuxoc9F
	 sgShShmF5vEbc0Mwj51EspOiejc3vhymeNRn2AsklbedBXahFHvowuLgtyFYaRQQzx
	 4q6N55HoLvE0+guECg5XN2JCJWTdZz8oBkwRyOataM7J0bz8GKDC2KwtiS5eMBtnCg
	 E0UCzv2pD9tVA==
Date: Sun, 10 Dec 2023 11:36:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231210113632.7880e730@jic23-huawei>
In-Reply-To: <20231206-mcp3911-guard-v4-1-30c3c5d4340f@gmail.com>
References: <20231206-mcp3911-guard-v4-1-30c3c5d4340f@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 Dec 2023 19:39:04 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Various changes inline - most are focused around simplifying the
path for any given flow through the code.

Rather than going for a v5 - I've applied this with the following diff on top
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index dfcb6cb7570f..7a32e7a1be9d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -317,7 +317,7 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
                            int *val2, long mask)
 {
        struct mcp3911 *adc = iio_priv(indio_dev);
-       int ret = -EINVAL;
+       int ret;
 
        guard(mutex)(&adc->lock);
        switch (mask) {
@@ -331,17 +331,23 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
                return IIO_VAL_INT;
        case IIO_CHAN_INFO_OFFSET:
                ret = adc->chip->get_offset(adc, channel->channel, val);
-               return (ret) ? ret : IIO_VAL_INT;
+               if (ret)
+                       return ret;
+
+               return IIO_VAL_INT;
        case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
                ret = adc->chip->get_osr(adc, val);
-               return (ret) ? ret : IIO_VAL_INT;
+               if (ret)
+                       return ret;
+
+               return IIO_VAL_INT;
        case IIO_CHAN_INFO_SCALE:
                *val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
                *val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
                return IIO_VAL_INT_PLUS_NANO;
+       default:
+               return -EINVAL;
        }
-
-       return ret;
 }
 
 static int mcp3911_write_raw(struct iio_dev *indio_dev,
@@ -361,7 +367,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
                                return adc->chip->set_scale(adc, channel->channel, i);
                        }
                }
-               break;
+               return -EINVAL;
        case IIO_CHAN_INFO_OFFSET:
                if (val2 != 0)
                        return -EINVAL;
@@ -373,9 +379,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
                                return adc->chip->set_osr(adc, i);
                        }
                }
-               break;
+               return -EINVAL;
+       default:
+               return -EINVAL;
        }
-       return -EINVAL;
 }

hope that's ok with you!

Jonathan
> ---
> Changes in v4:
> - Remove unreachable breaks
> - Link to v3: https://lore.kernel.org/r/20231205-mcp3911-guard-v3-1-df83e956d1e9@gmail.com
> 
> Changes in v3:
> - Return early in good paths as well
> - Rebase against master
> - Link to v2: https://lore.kernel.org/r/20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com
> 
> Changes in v2:
> - Return directly instead of goto label
> - Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
> ---
>  drivers/iio/adc/mcp3911.c | 55 +++++++++++++----------------------------------
>  1 file changed, 15 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index d864558bc087..dfcb6cb7570f 100644
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
> @@ -318,44 +319,28 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  	struct mcp3911 *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = mcp3911_read(adc,
>  				   MCP3911_CHANNEL(channel->channel), val, 3);
>  		if (ret)
> -			goto out;
> +			return ret;
>  
>  		*val = sign_extend32(*val, 23);
> -
> -		ret = IIO_VAL_INT;
> -		break;
> -
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_OFFSET:
> -
>  		ret = adc->chip->get_offset(adc, channel->channel, val);
> -		if (ret)
> -			goto out;
> -
> -		ret = IIO_VAL_INT;
> -		break;
> +		return (ret) ? ret : IIO_VAL_INT;

Don't do this. The ternary just makes it harder to read.

		if (ret)
			return ret;

		return IIO_VAL_INT;

+ the brackets around (ret) are unnecessary.

>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		ret = adc->chip->get_osr(adc, val);
> -		if (ret)
> -			goto out;
> -
> -		ret = IIO_VAL_INT;
> -		break;
> -
> +		return (ret) ? ret : IIO_VAL_INT;

here as well

>  	case IIO_CHAN_INFO_SCALE:
>  		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
>  		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
> -		ret = IIO_VAL_INT_PLUS_NANO;
> -		break;
> +		return IIO_VAL_INT_PLUS_NANO;
>  	}
>  
> -out:
> -	mutex_unlock(&adc->lock);
>  	return ret;

This ret is only reachable if we don't hit any of the switch entries so
better to add add a default and return -EINVAL to make that apparent and
let the compiler detect if we are missing a return earlier.

>  }
>  
> @@ -364,9 +349,8 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  			     int val2, long mask)
>  {
>  	struct mcp3911 *adc = iio_priv(indio_dev);
> -	int ret = -EINVAL;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> @@ -374,32 +358,24 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  			    val2 == mcp3911_scale_table[i][1]) {
>  
>  				adc->gain[channel->channel] = BIT(i);
> -				ret = adc->chip->set_scale(adc, channel->channel, i);
> +				return adc->chip->set_scale(adc, channel->channel, i);
>  			}
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		if (val2 != 0) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -
> -		ret = adc->chip->set_offset(adc, channel->channel, val);
> -		break;
> +		if (val2 != 0)
> +			return -EINVAL;
>  
> +		return adc->chip->set_offset(adc, channel->channel, val);
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
>  			if (val == mcp3911_osr_table[i]) {
> -				ret = adc->chip->set_osr(adc, i);
> -				break;
> +				return adc->chip->set_osr(adc, i);
>  			}
>  		}
>  		break;

return -INVAL; here and similar above to simplify the flow.

>  	}
> -
> -out:
> -	mutex_unlock(&adc->lock);
> -	return ret;
> +	return -EINVAL;

Move this to a default.

>  }
>  
>  static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> @@ -532,7 +508,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	int i = 0;
>  	int ret;
>  
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
>  	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
>  	if (ret < 0) {
> @@ -549,7 +525,6 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
>  	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
>  					   iio_get_time_ns(indio_dev));
>  out:
> -	mutex_unlock(&adc->lock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
> change-id: 20231125-mcp3911-guard-866591e2c947
> 
> Best regards,


