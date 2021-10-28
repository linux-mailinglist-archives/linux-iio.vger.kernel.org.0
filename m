Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71843E5B2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJ1QEi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 12:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhJ1QEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 12:04:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71A260551;
        Thu, 28 Oct 2021 16:02:08 +0000 (UTC)
Date:   Thu, 28 Oct 2021 17:06:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ina2xx: Make use of the helper macro
 kthread_run()
Message-ID: <20211028170634.4e815890@jic23-huawei>
In-Reply-To: <20211021124254.3247-1-caihuoqing@baidu.com>
References: <20211021124254.3247-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Oct 2021 20:42:53 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Series applied to the togreg branch of iio.git which is pushed out initially
as testing for 0-day to see if it can find any problems we missed.

Thanks,

Jonathan

> ---
> v1->v2: Sort with [2/2] patch as a series.
> 
>  drivers/iio/adc/ina2xx-adc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index a4b2ff9e0dd5..360d7a00f60d 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -842,15 +842,14 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
>  	dev_dbg(&indio_dev->dev, "Async readout mode: %d\n",
>  		chip->allow_async_readout);
>  
> -	task = kthread_create(ina2xx_capture_thread, (void *)indio_dev,
> -			      "%s:%d-%uus", indio_dev->name,
> -			      iio_device_id(indio_dev),
> -			      sampling_us);
> +	task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
> +			   "%s:%d-%uus", indio_dev->name,
> +			   iio_device_id(indio_dev),
> +			   sampling_us);
>  	if (IS_ERR(task))
>  		return PTR_ERR(task);
>  
>  	get_task_struct(task);
> -	wake_up_process(task);
>  	chip->task = task;
>  
>  	return 0;

