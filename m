Return-Path: <linux-iio+bounces-806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E880BBA8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7D6280E89
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E914A92;
	Sun, 10 Dec 2023 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACchFlJA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0257125DE;
	Sun, 10 Dec 2023 14:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58007C433C7;
	Sun, 10 Dec 2023 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702218273;
	bh=o4VcbGl2o15sohYm+WN/3yzkhadZaVO+BDbrRh4orN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ACchFlJA4CNaqDz5O+p4W6KioMebWeOIxQHK2yGqKZ7GziNTf5VcT/BmAwTNG9bvW
	 RNYQAp3faebmDuvfO30qZL7u14/IigUir8z2cWio6uoyAnzQ9Wo5VVna3tpoOQNV0N
	 ZVle7/7sKLQvZwr4Sz6Qa9FGmvL7nn+KKWDHH/3pwMHHji64vn9DWRjwrPPtntIgpO
	 19cc2OkZIlxOA/IF8mzMNJ991ng86lX6hfE60xaPN/NzDvEwYC6WMxUaWYv4UZUAGn
	 3uSP107wBOsPm2FYLAOUUMmyvlXl+TE0Mdf/8voOdzUltzgm9FPz5+8PSXsS4yrram
	 4pFep7BL9wH6Q==
Date: Sun, 10 Dec 2023 14:24:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2 5/8] iio: buffer-dmaengine: export buffer alloc and
 free functions
Message-ID: <20231210142425.338a39f2@jic23-huawei>
In-Reply-To: <20231208-dev-iio-backend-v2-5-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	<20231208-dev-iio-backend-v2-5-5450951895e1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Dec 2023 16:14:12 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Export iio_dmaengine_buffer_free() and iio_dmaengine_buffer_alloc().
> This is in preparation of introducing IIO backends support. This will
> allow us to allocate a buffer and control it's lifetime from a device
> different from the one holding the DMA firmware properties. Effectively,
> in this case the struct device holding the firmware information about
> the DMA channels is not the same as iio_dev->dev.parent (typical case).
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Probably a good idea to namespace these and existing exports related
to buffer-dmaengine whilst you are at it.

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++++--
>  include/linux/iio/buffer-dmaengine.h               | 4 +++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 5f85ba38e6f6..5bf8c5eb1853 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -159,7 +159,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
>   * Once done using the buffer iio_dmaengine_buffer_free() should be used to
>   * release it.
>   */
> -static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> +struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  	const char *channel)
>  {
>  	struct dmaengine_buffer *dmaengine_buffer;
> @@ -210,6 +210,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  	kfree(dmaengine_buffer);
>  	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_alloc);
>  
>  /**
>   * iio_dmaengine_buffer_free() - Free dmaengine buffer
> @@ -217,7 +218,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>   *
>   * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
>   */
> -static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
> +void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  {
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(buffer);
> @@ -227,6 +228,7 @@ static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  
>  	iio_buffer_put(buffer);
>  }
> +EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
>  
>  static void __devm_iio_dmaengine_buffer_free(void *buffer)
>  {
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index 5c355be89814..6c44da550b2c 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -10,8 +10,10 @@
>  struct iio_dev;
>  struct device;
>  
> +struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> +					      const char *channel);
> +void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
>  int devm_iio_dmaengine_buffer_setup(struct device *dev,
>  				    struct iio_dev *indio_dev,
>  				    const char *channel);
> -
Unrelated change.

>  #endif
> 


