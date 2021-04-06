Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE2354ED9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 10:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbhDFIoE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 04:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhDFIoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 04:44:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726CD613C0;
        Tue,  6 Apr 2021 08:43:55 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:44:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] iio:cdc:ad7150: Fix use of uninitialized ret
Message-ID: <20210406094405.148dacea@jic23-huawei>
In-Reply-To: <20210406083244.649984-1-jic23@kernel.org>
References: <20210406083244.649984-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  6 Apr 2021 09:32:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This doesn't appear to generate a warning on all versions of GCC, but
> 0-day reported it and the report looks valid.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>

For this one, it's the sort of thing I'd normally just roll into the original
patch, but there is a merge in my tree after this, so in the interests of
simplicity I've applied it on top.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to take another look at it and see what I got wrong this time :)

Jonathan

> ---
>  drivers/iio/cdc/ad7150.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
> index f9cce1a64586..ebe112b4618b 100644
> --- a/drivers/iio/cdc/ad7150.c
> +++ b/drivers/iio/cdc/ad7150.c
> @@ -235,7 +235,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  				     enum iio_event_direction dir, int state)
>  {
>  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * There is only a single shared control and no on chip

