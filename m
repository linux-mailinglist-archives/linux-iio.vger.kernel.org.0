Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF81A5E8B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 14:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLMdX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 08:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLMdW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 08:33:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794E7206E9;
        Sun, 12 Apr 2020 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586694803;
        bh=JkdgX/y7FIUkEBOLqeCAcdgsFvu3yBTH17Nw0NDaD8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f3YpeLVlNttH2XiykWDBc60WgGMJO2NoPag8Jh3q3/rauq9ILR7vUYGoKv67e9fCZ
         bhoppGwV1baoaZHv6uj5uFZSAA26LrOv3ajALhGU1vNQD3P2AbontUt8V255H40lXT
         XDEqw9hWOI5ryR3m8iyuQCJ24yyT0DMz4etOxtHU=
Date:   Sun, 12 Apr 2020 13:33:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] iio: core: drop devm_iio_triggered_buffer_cleanup()
 API call
Message-ID: <20200412133319.49a205ff@archlinux>
In-Reply-To: <20200227135227.12433-2-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:21 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

J
> ---
>  Documentation/driver-api/driver-model/devres.rst   |  1 -
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 11 -----------
>  include/linux/iio/triggered_buffer.h               |  2 --
>  3 files changed, 14 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 0580c64ebdfd..1431d5e44abc 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -289,7 +289,6 @@ IIO
>    devm_iio_kfifo_allocate()
>    devm_iio_kfifo_free()
>    devm_iio_triggered_buffer_setup()
> -  devm_iio_triggered_buffer_cleanup()
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_free()
>    devm_iio_trigger_register()
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index cb322b2f09cd..e8046c1ecd6b 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -126,17 +126,6 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup);
>  
> -void devm_iio_triggered_buffer_cleanup(struct device *dev,
> -				       struct iio_dev *indio_dev)
> -{
> -	int rc;
> -
> -	rc = devres_release(dev, devm_iio_triggered_buffer_clean,
> -			    devm_iio_device_match, indio_dev);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_cleanup);
> -
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
> index 238ad30ce166..e99c91799359 100644
> --- a/include/linux/iio/triggered_buffer.h
> +++ b/include/linux/iio/triggered_buffer.h
> @@ -18,7 +18,5 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
>  				    irqreturn_t (*h)(int irq, void *p),
>  				    irqreturn_t (*thread)(int irq, void *p),
>  				    const struct iio_buffer_setup_ops *ops);
> -void devm_iio_triggered_buffer_cleanup(struct device *dev,
> -				       struct iio_dev *indio_dev);
>  
>  #endif

