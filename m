Return-Path: <linux-iio+bounces-1794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B683569E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABA9AB22A4D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250A37710;
	Sun, 21 Jan 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbf8Nw/6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64289381A1
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705853986; cv=none; b=LN7XFL3jz4JOpFtIFOHX7HgaEb8nOYvvipmlYzgtQb6OG6Y2afGAx3gKPCofxlVWASEVaUdsNbjVjl9arvmbeO2/q4kKLWaIpQZanIP5R4GwJMmYmZ3w2C9xMdwzw8uVv+POcOG04J/kCEUsutbmNakqasbytXw47nU1WmNxWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705853986; c=relaxed/simple;
	bh=jz1lf0ncYa+FQhRo9d99sLKHP7qJ79EPxtSCceoo2D0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWb/COeNUZI8FxkL+htFyTVyIS+yoI9tm9E+rWZY7V2oBqSmRg1xfqZE7lujoQC6cQVMH4dxxH/oPcFzwFCN8C1r9h08HVQTYaHV5T1XiP+uhht9MRdxWC6hFruke5i9CY6DYTm2o0lgYRNy+JtMZUvdJ9BlZcqG3/rYh0G0KB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbf8Nw/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6773C433C7;
	Sun, 21 Jan 2024 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705853985;
	bh=jz1lf0ncYa+FQhRo9d99sLKHP7qJ79EPxtSCceoo2D0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sbf8Nw/6jD+tT1oLCrsElgoHkiC7P9FnG6VVKDMYgKYupywdKAA+dckbSR4vgzblW
	 ijRGNl5pXbrPp7/0dA6/Igx3eZfkPYcSAD/VFMrnu6a66flOxvjtdnpWSgy9KFlhBx
	 R2ZSGIWlKh0/kBoDBVDBmOzupu6F/1BSVcYWze8obP/eZ9tf6OLoDuEGC1zihZOqul
	 xfa6OAVDjD08qK864AlP/TFlS4MzH6H1LBjhIdGLc/TELgctd8E3Wqa9bWAD4StCeY
	 /MUY3p9VEVd8divr+1SDFdMcgqvDYaVMzbPXM1kVj0S251NzcUurkZcdAi+S4YkBQY
	 WyBynlzslXaJA==
Date: Sun, 21 Jan 2024 16:19:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, "Renato Lui Geh"
 <renatogeh@gmail.com>, Fabrizio Lamarque <fl.scratchpad@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad_sigma_delta: ensure proper DMA
 alignment
Message-ID: <20240121161934.4d71ebab@jic23-huawei>
In-Reply-To: <20240117-dev_sigma_delta_no_irq_flags-v1-1-db39261592cf@analog.com>
References: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
	<20240117-dev_sigma_delta_no_irq_flags-v1-1-db39261592cf@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 13:41:03 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Aligning the buffer to the L1 cache is not sufficient in some platforms
> as they might have larger cacheline sizes for caches after L1 and thus,
> we can't guarantee DMA safety.
> 
> That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
> for the sigma_delta ADCs.
> 
> [1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/
> Fixes: 0fb6ee8d0b5e ("iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  include/linux/iio/adc/ad_sigma_delta.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 7852f6c9a714..719cf9cc6e1a 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -8,6 +8,8 @@
>  #ifndef __AD_SIGMA_DELTA_H__
>  #define __AD_SIGMA_DELTA_H__
>  
> +#include <linux/iio/iio.h>
> +
>  enum ad_sigma_delta_mode {
>  	AD_SD_MODE_CONTINUOUS = 0,
>  	AD_SD_MODE_SINGLE = 1,
> @@ -99,7 +101,7 @@ struct ad_sigma_delta {
>  	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
>  	 * rounded to 16 bytes to take into account padding.
>  	 */
> -	uint8_t				tx_buf[4] ____cacheline_aligned;
> +	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
>  	uint8_t				rx_buf[16] __aligned(8);
>  };
>  
> 


