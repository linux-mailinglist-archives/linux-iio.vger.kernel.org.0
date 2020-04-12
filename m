Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9411A5E5C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgDLLzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLLzO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:55:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1DD20709;
        Sun, 12 Apr 2020 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586692513;
        bh=T7ow75b0ZoEqCiy/VmthNZ+rK0XXz/yyjCJeWfN2rhs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GsGQ3xeQat/zHz4njwZ/2qVXTsIBA3yidfYrjtl1p/0DVfCTbM0szmGz/2rariYXD
         nGV/ZHlZbiK04qSFfDDwgA38yUGBWA9mSFqWiXZO0sDFTU2Dv9zmttiWE5juudiqSo
         qTFsgEs43CKhPurZfMzFhmIP59xHKNPq/LNhZukQ=
Date:   Sun, 12 Apr 2020 12:55:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] iio: core: drop devm_iio_device_unregister() API
 call
Message-ID: <20200412125510.55304d4c@archlinux>
In-Reply-To: <20200227135227.12433-1-alexandru.ardelean@analog.com>
References: <20200227135227.12433-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 27 Feb 2020 15:52:20 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's unused so far, so it can't be removed. Also makes sense to remove it
> to discourage weird uses of this call during review.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Time to pick these up I think.  They've sat here a while and no
one has commented + I can't think of any disadvantages.

Hence,

Applied to the togreg  branch of iio.git and pushed out as testing for
the autobuilders to play with them.

Thanks,

Jonathan

> ---
>  .../driver-api/driver-model/devres.rst          |  1 -
>  drivers/iio/industrialio-core.c                 | 17 -----------------
>  include/linux/iio/iio.h                         |  4 ----
>  3 files changed, 22 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 46c13780994c..0580c64ebdfd 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -286,7 +286,6 @@ IIO
>    devm_iio_device_alloc()
>    devm_iio_device_free()
>    devm_iio_device_register()
> -  devm_iio_device_unregister()
>    devm_iio_kfifo_allocate()
>    devm_iio_kfifo_free()
>    devm_iio_triggered_buffer_setup()
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0b14666dff09..e4011f8431f9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1823,23 +1823,6 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
> -/**
> - * devm_iio_device_unregister - Resource-managed iio_device_unregister()
> - * @dev:	Device this iio_dev belongs to
> - * @indio_dev:	the iio_dev associated with the device
> - *
> - * Unregister iio_dev registered with devm_iio_device_register().
> - */
> -void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
> -{
> -	int rc;
> -
> -	rc = devres_release(dev, devm_iio_device_unreg,
> -			    devm_iio_device_match, indio_dev);
> -	WARN_ON(rc);
> -}
> -EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
> -
>  /**
>   * iio_device_claim_direct_mode - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 862ce0019eba..0eb9e8d7ec68 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -591,9 +591,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>   * calls iio_device_register() internally. Refer to that function for more
>   * information.
>   *
> - * If an iio_dev registered with this function needs to be unregistered
> - * separately, devm_iio_device_unregister() must be used.
> - *
>   * RETURNS:
>   * 0 on success, negative error number on failure.
>   */
> @@ -601,7 +598,6 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  			       struct module *this_mod);
> -void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);

