Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED2048F806
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiAOQuT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 11:50:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46642 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiAOQuT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 11:50:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A547CE0022
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 16:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF65CC36AE3;
        Sat, 15 Jan 2022 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642265415;
        bh=GIEYS5YeVKFVHVRlRrDXpXOk6Dypw09ETga+1LxelsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RzxO4fkRRSDVIbdcGFDsbAuUCMa467ft3yYJnaPPbF71l45MJjzjlWKzHTutfCKTc
         eTE9ndT6JdneQTod8yq0VJde6Vwh2nQVdcOGqnhtTrxwJuMCO670+axmD3t2fiuGt4
         5z/TSL7DCGJG1n0oJkwPXxCacj9StwwppyXyngW9u2MxmXxLzlA3rBRhhky33CTzaw
         t5mAKg8xQLoK1OdNiyfMsrfEJerJKb+gWNCAVljHJquKZtAVt39hvlzPF3NESo/3EW
         xhFE66vT7EQRDLulJL1l3srTM+L+FQLr8xsu6stng0G3kvtOznyE4PnloeyCY1zguf
         jl+Jkw4LvCdfQ==
Date:   Sat, 15 Jan 2022 16:56:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 07/10] iio: core: Hide write accesses to
 iio_dev->currentmode
Message-ID: <20220115165616.48e34e52@jic23-huawei>
In-Reply-To: <20211215151344.163036-8-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-8-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Dec 2021 16:13:41 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> In order to later move this variable within the opaque structure and now
> that there is a read-only helper for it, let's create a write helper.
> 
> The idea behind these changes is to limit the temptation of using
> ->currentmode directly, and this will soon be fully addressed by making  
> the modification to this variable impossible from a device driver by
> moving it to the opaque structure. But for now, let's just do a
> transparent change and use a new helper when ->currentmode needs to be
> accessed for modifications.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

You can probably guess from my comments on the previous but I'd prefer that
we don't do this. We don't need an accessor to do the set so let's skip
doing so.

Given next patch makes the write from drivers impossible anyway we don't
need to do this step.

One more thing inline... No need to export the symbol currently (that
might change if any of the other core modules ever use it but it's not
needed at this time.

> ---
>  drivers/iio/industrialio-buffer.c |  6 +++---
>  drivers/iio/industrialio-core.c   | 11 +++++++++++
>  include/linux/iio/iio.h           |  1 +
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index f4dbab7c44fa..190f9cc5fb2c 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1065,7 +1065,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	indio_dev->active_scan_mask = config->scan_mask;
>  	indio_dev->scan_timestamp = config->scan_timestamp;
>  	indio_dev->scan_bytes = config->scan_bytes;
> -	indio_dev->currentmode = config->mode;
> +	iio_set_internal_mode(indio_dev, config->mode);
>  
>  	iio_update_demux(indio_dev);
>  
> @@ -1132,7 +1132,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	if (indio_dev->setup_ops->postdisable)
>  		indio_dev->setup_ops->postdisable(indio_dev);
>  err_undo_config:
> -	indio_dev->currentmode = INDIO_DIRECT_MODE;
> +	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
>  	indio_dev->active_scan_mask = NULL;
>  
>  	return ret;
> @@ -1181,7 +1181,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  
>  	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
>  	indio_dev->active_scan_mask = NULL;
> -	indio_dev->currentmode = INDIO_DIRECT_MODE;
> +	iio_set_internal_mode(indio_dev, INDIO_DIRECT_MODE);
>  
>  	return ret;
>  }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a1d6e30d034a..5c7e0c9e1f59 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2068,6 +2068,17 @@ int iio_get_internal_mode(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_get_internal_mode);
>  
> +/**
> + * iio_set_internal_mode() - helper function providing write-only access to the
> + *			     internal @currentmode variable
> + * @indio_dev:		IIO device structure for device
> + **/
> +void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> +{
> +	indio_dev->currentmode = mode;
> +}
> +EXPORT_SYMBOL_GPL(iio_set_internal_mode);

If we did do this, you don't need to export it as industrialio_buffer and industriaio_core
are both built into the same module.

> +
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index dcab17f44552..27551d251904 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -679,6 +679,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
>  					   const char *fmt, ...);
>  
>  int iio_get_internal_mode(struct iio_dev *indio_dev);
> +void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
>  
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled

