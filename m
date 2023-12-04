Return-Path: <linux-iio+bounces-572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6480327E
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A081F2100A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67DD23772;
	Mon,  4 Dec 2023 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0RqIcPP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B21EB54
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 12:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251FAC433C8;
	Mon,  4 Dec 2023 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701692597;
	bh=VoegbZtlGEE+YOCixMcNCzHVYsgNLyvCC0B36pZHRl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0RqIcPPKLUl064QkUhYGTS9EllbUb9s6eU+USIgBLOvyxCtNRBIbTV5bYKdX+52W
	 kV6+xp4A4VeL9nN8uI8oobmhex+sWPpciLjJ9tXFIYbroCUkzIeQ+kro1KPTRF5IR+
	 6d7SFCVZSSPiUGcCx3awIbGpFF5Tj7f72+vbArRj2K90M/nudyszGg4lOF15EAXCnj
	 xAqOkrMrx4ErtkEvdTwr1Ge2duUNPsUK7bSlp6qj3IpL84Or3pDZpyFeld9jniqJ4q
	 GWqpOB9i4UDFmJ/LfyGCTYiopptkhOuasnoSibCk8lPop7Pic/DV510ylmbDaPWYCH
	 ob+qIrUbla9Vw==
Date: Mon, 4 Dec 2023 12:23:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mcp3911: simplify code with guard macro
Message-ID: <20231204122309.4b1b6de7@jic23-huawei>
In-Reply-To: <20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com>
References: <20231127-mcp3911-guard-v2-1-9462630dca1e@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 08:38:22 +0100
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Use the guard(mutex) macro for handle mutex lock/unlocks.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Oddly this doesn't apply. Also some comments inline.
> ---
> Changes in v2:
> - Return directly instead of goto label
> - Link to v1: https://lore.kernel.org/r/20231125-mcp3911-guard-v1-1-2748d16a3f3f@gmail.com
> ---
>  drivers/iio/adc/mcp3911.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 974c5bd923a6..30836725ef9a 100644
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
> @@ -168,13 +169,13 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
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
This should go further.  Return early in the good paths as well
		return IIO_VAL_INT;
a few lines later than this.


