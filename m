Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F19F18E33E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 18:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCURWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 13:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCURWr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 13:22:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA3C20724;
        Sat, 21 Mar 2020 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584811365;
        bh=67yo53l8YwtMWwNWAy+tA53iXmxmvO1ytA8Oae/NKpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0JvPwUGxliFKt5qR45AK3f3wIS+QIdgsDFisAOe25BOMv0MAJiNLCvpHDp4KRe/J
         4L0djjUkk0kPf5S12K4RN+JHVbXoU88XZrZc6r5B6woZ743Z/iTYr2JCYCnT2qGQIH
         rCB30biwm6s9qBovH7bzHrKcuCw7inGHDKLUWG/g=
Date:   Sat, 21 Mar 2020 17:22:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <Laszlo.Nagy@analog.com>, <Andrei.Grozav@analog.com>,
        <Michael.Hennerich@analog.com>, <Istvan.Csomortani@analog.com>,
        <Adrian.Costina@analog.com>, <Dragos.Bogdan@analog.com>
Subject: Re: [PATCH v11 4/8] iio: buffer-dmaengine: add dev-managed calls
 for buffer alloc
Message-ID: <20200321172240.098de03f@archlinux>
In-Reply-To: <20200321085315.11030-5-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
        <20200321085315.11030-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:53:11 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Currently, when using a 'iio_dmaengine_buffer_alloc()', an matching call to
> 'iio_dmaengine_buffer_free()' must be made.
> 
> With this change, this can be avoided by using
> 'devm_iio_dmaengine_buffer_alloc()'. The buffer will get free'd via the
> device's devres handling.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  .../buffer/industrialio-buffer-dmaengine.c    | 39 +++++++++++++++++++
>  include/linux/iio/buffer-dmaengine.h          |  3 ++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 94da3b1ca3a2..6dedf12b69a4 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -229,6 +229,45 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
>  
> +static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
> +{
> +	iio_dmaengine_buffer_free(*(struct iio_buffer **)res);
> +}
> +
> +/**
> + * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
> + * @dev: Parent device for the buffer
> + * @channel: DMA channel name, typically "rx".
> + *
> + * This allocates a new IIO buffer which internally uses the DMAengine framework
> + * to perform its transfers. The parent device will be used to request the DMA
> + * channel.
> + *
> + * The buffer will be automatically de-allocated once the device gets destroyed.
> + */
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +	const char *channel)
> +{
> +	struct iio_buffer **bufferp, *buffer;
> +
> +	bufferp = devres_alloc(__devm_iio_dmaengine_buffer_free,
> +			       sizeof(*bufferp), GFP_KERNEL);
> +	if (!bufferp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	buffer = iio_dmaengine_buffer_alloc(dev, channel);
> +	if (IS_ERR(buffer)) {
> +		devres_free(bufferp);
> +		return buffer;
> +	}
> +
> +	*bufferp = buffer;
> +	devres_add(dev, bufferp);
> +
> +	return buffer;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
> +
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("DMA buffer for the IIO framework");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
> index b3a57444a886..0e503db71289 100644
> --- a/include/linux/iio/buffer-dmaengine.h
> +++ b/include/linux/iio/buffer-dmaengine.h
> @@ -14,4 +14,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  	const char *channel);
>  void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
>  
> +struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
> +						   const char *channel);
> +
>  #endif

