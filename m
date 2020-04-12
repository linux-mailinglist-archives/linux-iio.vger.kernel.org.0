Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010D61A5E8D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 14:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDLMgU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 08:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgDLMgU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 08:36:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E0F206E9;
        Sun, 12 Apr 2020 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586694979;
        bh=VP2RbN0RO2dujhhK2DazZtY8SKoEQptV2HIX3Y+OfmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5voO+/34ZiJAcjfgE6C5OTtE4cAdl5XHlXFT0ptQHwCgYI5HSMIquJmiNBA/8cTh
         i5jbUx32fCOgn3Zl+hSRQfPlM2EZUAGuKM60ivqOBcoTEZfnSsBSg1KWDjYlAP2xFZ
         DfA+8DPo+VBIIuP/TbgAEShqm2ga2CbBLlKDiDDo=
Date:   Sun, 12 Apr 2020 13:36:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] iio: core: drop devm_iio_device_free() API call
Message-ID: <20200412133612.3eb6c019@archlinux>
In-Reply-To: <20200227135227.12433-3-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
        <20200227135227.12433-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:22 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> This is the last user of 'devm_iio_device_match()', so it can be removed as
> well in this patch.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

J
> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/iio/industrialio-core.c               | 31 -------------------
>  include/linux/iio/iio.h                       |  2 --
>  3 files changed, 34 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 1431d5e44abc..6ae6c67dfec0 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -284,7 +284,6 @@ I2C
>  
>  IIO
>    devm_iio_device_alloc()
> -  devm_iio_device_free()
>    devm_iio_device_register()
>    devm_iio_kfifo_allocate()
>    devm_iio_kfifo_free()
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e4011f8431f9..ebe338a0494f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1539,17 +1539,6 @@ static void devm_iio_device_release(struct device *dev, void *res)
>  	iio_device_free(*(struct iio_dev **)res);
>  }
>  
> -int devm_iio_device_match(struct device *dev, void *res, void *data)
> -{
> -	struct iio_dev **r = res;
> -	if (!r || !*r) {
> -		WARN_ON(!r || !*r);
> -		return 0;
> -	}
> -	return *r == data;
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_device_match);
> -
>  /**
>   * devm_iio_device_alloc - Resource-managed iio_device_alloc()
>   * @dev:		Device to allocate iio_dev for
> @@ -1558,9 +1547,6 @@ EXPORT_SYMBOL_GPL(devm_iio_device_match);
>   * Managed iio_device_alloc. iio_dev allocated with this function is
>   * automatically freed on driver detach.
>   *
> - * If an iio_dev allocated with this function needs to be freed separately,
> - * devm_iio_device_free() must be used.
> - *
>   * RETURNS:
>   * Pointer to allocated iio_dev on success, NULL on failure.
>   */
> @@ -1585,23 +1571,6 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
>  
> -/**
> - * devm_iio_device_free - Resource-managed iio_device_free()
> - * @dev:		Device this iio_dev belongs to
> - * @iio_dev:		the iio_dev associated with the device
> - *
> - * Free iio_dev allocated with devm_iio_device_alloc().
> - */
> -void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev)
> -{
> -	int rc;
> -
> -	rc = devres_release(dev, devm_iio_device_release,
> -			    devm_iio_device_match, iio_dev);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_device_free);
> -
>  /**
>   * iio_chrdev_open() - chrdev file open for buffer access and ioctls
>   * @inode:	Inode structure for identifying the device in the file system
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 0eb9e8d7ec68..2920c065ab9b 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -686,9 +686,7 @@ static inline struct iio_dev *iio_priv_to_dev(void *priv)
>  }
>  
>  void iio_device_free(struct iio_dev *indio_dev);
> -int devm_iio_device_match(struct device *dev, void *res, void *data);
>  struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
> -void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
>  struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
>  						const char *fmt, ...);
>  void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);

