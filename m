Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26AA354322
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbhDEPCr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 11:02:47 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:48436 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbhDEPCq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 11:02:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1B9AF9E004A;
        Mon,  5 Apr 2021 16:02:38 +0100 (BST)
Date:   Mon, 5 Apr 2021 16:02:57 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc: Fix trivial typo
Message-ID: <20210405160257.57a4a82e@jic23-huawei>
In-Reply-To: <20210401150810.227168-1-jic23@kernel.org>
References: <20210401150810.227168-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Apr 2021 16:08:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> "an" should be "and".
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'm not going to waste anyone's time by pestering people for a review
on this one!

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to ignore.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d20a3b574af9..87c55f7104f0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -97,7 +97,7 @@ config AD7298
>  	  module will be called ad7298.
>  
>  config AD7476
> -	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
> +	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

