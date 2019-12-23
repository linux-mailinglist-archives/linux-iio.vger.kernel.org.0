Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89612999B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLWRxh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRxh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:53:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF8F20663;
        Mon, 23 Dec 2019 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577123616;
        bh=VOI+cU6VEbOCWsLd0qZ7LaCPaalpOyC+SxcnzLJU7+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JNS0O+Fs8s47C5wTjt2RPsiPt+fKoC0Haokgo6XB3YDEZNdXkSFw2G7cti7ZqWnBt
         9clHk+lJ6cgEsxjQanBmAmCKEYm8qxkoKilXv/C5dOWRiRAMAda3eL9b/EDPo/yMqp
         F+r7dyDkNHislAhnfDcb+uNTcg+/sfgjcPbcN6Z0=
Date:   Mon, 23 Dec 2019 17:53:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dmaengine: Report buffer length
 requirements
Message-ID: <20191223175332.4638562e@archlinux>
In-Reply-To: <20191211115615.9660-1-alexandru.ardelean@analog.com>
References: <20191211115615.9660-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 13:56:15 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> The dmaengine buffer has some length alignment requirements that can differ
> from platform to platform. If the length alignment requirements are not met
> unexpected behavior like dropping of samples can occur.
> 
> Currently these requirements are not reported and applications need to know
> the requirements of the platform by some out-of-band means.
> 
> Add a new buffer attribute that reports the length alignment requirements
> called `length_align_bytes`. The reported length alignment is in bytes that
> means the buffer length alignment in sample sets depends on the number of
> enabled channels and the bytes per channel. Applications using this
> attribute to determine the buffer size requirements need to consider this.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Seems like a sensible and well defined change to me, so applied to the togreg
branch of iio.git with the minor tweak mentioned below.


> ---
>  .../ABI/testing/sysfs-bus-iio-dma-buffer      | 19 +++++++++++++++++
>  .../buffer/industrialio-buffer-dmaengine.c    | 21 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> new file mode 100644
> index 000000000000..999de481de82
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
> @@ -0,0 +1,19 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/buffer/length_align_bytes
> +KernelVersion:	5.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		DMA buffers tend to have a alignment requirement for the
> +		buffers. If this alignment requirement is not met samples might
> +		be dropped from the buffer.
> +
> +		This property reports the alignment requirements in bytes. This means
> +		that the buffer size in bytes needs to be a integer multiple of the
> +		number reported by this file.
> +
> +		The alignment requirements in number of sample sets will depend on the
> +		enabled channels and the bytes per channel. This means that the
> +		alignment requirement in samples sets might change depending on which
> +		and how many channels are enabled. Whereas the alignment requirement
> +		reported in bytes by this property will remain static and does not
> +		depend on which channels are

Odd line wrapping. I'll fix that.  Whole block is a bit wide, so I'll rewrap it.

Jonathan

> +		enabled.
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 7d298aaff1f0..b129693af0fd 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
>  #include <linux/iio/buffer-dma.h>
> @@ -126,6 +127,24 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
>  	.abort = iio_dmaengine_buffer_abort,
>  };
>  
> +static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct dmaengine_buffer *dmaengine_buffer =
> +		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
> +
> +	return sprintf(buf, "%u\n", dmaengine_buffer->align);
> +}
> +
> +static IIO_DEVICE_ATTR(length_align_bytes, 0444,
> +		       iio_dmaengine_buffer_get_length_align, NULL, 0);
> +
> +static const struct attribute *iio_dmaengine_buffer_attrs[] = {
> +	&iio_dev_attr_length_align_bytes.dev_attr.attr,
> +	NULL,
> +};
> +
>  /**
>   * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
>   * @dev: Parent device for the buffer
> @@ -179,6 +198,8 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
>  
>  	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
>  		&iio_dmaengine_default_ops);
> +	iio_buffer_set_attrs(&dmaengine_buffer->queue.buffer,
> +		iio_dmaengine_buffer_attrs);
>  
>  	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;
>  

