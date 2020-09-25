Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294FF278744
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIYMbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYMbg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:31:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AECE121D7A;
        Fri, 25 Sep 2020 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601037095;
        bh=gA/llG8ZDnCPysu9y18Wmt5ZUsCKpX4v4Y6BgcdLJhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qq+nWOcsLIInFcWFnxfLZFBCbvt3PRcGFPC6a29e+yQr5Aiel65XsnSuSJUADWE2O
         9gDBInnKyYLuAFPWbgea33cm05RDxpetFcvwTBtwia96p83/ctWXicTIYs+IVB+6+1
         fWJFXnU+Ol8skKkyJ9dC0851XiVzvE7xxHKwrfrI=
Date:   Fri, 25 Sep 2020 13:31:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dmaengine: remove non managed alloc/free
Message-ID: <20200925133130.46f795ab@archlinux>
In-Reply-To: <20200923121810.944075-1-alexandru.ardelean@analog.com>
References: <20200923121810.944075-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Sep 2020 15:18:10 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is to encourage the use of devm_iio_dmaengine_buffer_alloc().
> Currently the managed version of the DMAEngine buffer alloc is the only
> function used from this part of the framework.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Make sense. We can bring it back again if a strong usecase
shows up.

Applied to the togreg branch of iio.git and pushed out as testing
as normal.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++----
>  include/linux/iio/buffer-dmaengine.h               | 4 ----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 5789bda0745b..93b4e9e6bb55 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -159,7 +159,7 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
>   * Once done using the buffer iio_dmaengine_buffer_free() should be used to
>   * release it.
>   */
> -struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> +static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  	const char *channel)
>  {
>  	struct dmaengine_buffer *dmaengine_buffer;
> @@ -211,7 +211,6 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  	kfree(dmaengine_buffer);
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL(iio_dmaengine_buffer_alloc);
>  
>  /**
>   * iio_dmaengine_buffer_free() - Free dmaengine buffer
> @@ -219,7 +218,7 @@ EXPORT_SYMBOL(iio_dmaengine_buffer_alloc);
>   *
>   * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
>   */
> -void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
> +static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  {
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(buffer);
> @@ -229,7 +228,6 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  
>  	iio_buffer_put(buffer);
>  }
> -EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
>  
>  static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
>  {
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index 0e503db71289..5b502291d6a4 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -10,10 +10,6 @@
>  struct iio_buffer;
>  struct device;
>  
> -struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
> -	const char *channel);
> -void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
> -
>  struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
>  						   const char *channel);
>  

