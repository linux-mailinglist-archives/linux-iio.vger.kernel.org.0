Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADB31B98F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 13:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhBOMpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 07:45:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhBOMpT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 07:45:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E6764DEC;
        Mon, 15 Feb 2021 12:44:37 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:44:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v6 15/24] iio: buffer: dmaengine: obtain buffer object
 from attribute
Message-ID: <20210215124434.537196ba@archlinux>
In-Reply-To: <20210215104043.91251-16-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-16-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 12:40:34 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The reference to the IIO buffer object is stored on the attribute object.
> So we need to unwind it to obtain it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This could have done with a little more description of 'why', but
I'm not going to hold up the series to fix it.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 9981896e1495..a64b222289be 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -132,9 +132,9 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
>  static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
>  	struct device_attribute *attr, char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>  	struct dmaengine_buffer *dmaengine_buffer =
> -		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
> +		iio_buffer_to_dmaengine_buffer(buffer);
>  
>  	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
>  }

