Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91294447AB
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKCRu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 13:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231708AbhKCRtu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 13:49:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3D160EE9;
        Wed,  3 Nov 2021 17:47:12 +0000 (UTC)
Date:   Wed, 3 Nov 2021 17:51:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Mark iio_device_type as const
Message-ID: <20211103175146.159f5d3f@jic23-huawei>
In-Reply-To: <20211031080421.2086-1-lars@metafoo.de>
References: <20211031080421.2086-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 09:04:21 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The iio_device_type struct is never modified, mark it as const. This allows
> it to be placed in a read-only memory section, which will protect against
> accidental or deliberate modification.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git which will be only visible
as testing for 0-day to poke at it until after the merge window.

Thanks,

Jonathan

> ---
>  drivers/iio/iio_core.h          | 2 +-
>  drivers/iio/industrialio-core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 61e318431de9..501e286702ef 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -16,7 +16,7 @@ struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
>  
> -extern struct device_type iio_device_type;
> +extern const struct device_type iio_device_type;
>  
>  struct iio_dev_buffer_pair {
>  	struct iio_dev		*indio_dev;
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 463a63d5bf56..737518efa38f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1619,7 +1619,7 @@ static void iio_dev_release(struct device *device)
>  	kfree(iio_dev_opaque);
>  }
>  
> -struct device_type iio_device_type = {
> +const struct device_type iio_device_type = {
>  	.name = "iio_device",
>  	.release = iio_dev_release,
>  };

