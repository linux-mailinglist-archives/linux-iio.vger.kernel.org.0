Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA0410808
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 20:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhIRSKw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 14:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhIRSKw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:10:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D3661100;
        Sat, 18 Sep 2021 18:09:26 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:13:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: fix error code in
 ssp_print_mcu_debug()
Message-ID: <20210918191306.5999b1cc@jic23-huawei>
In-Reply-To: <20210914105333.GA11657@kili>
References: <20210914105333.GA11657@kili>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Sep 2021 13:53:33 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The ssp_print_mcu_debug() function should return negative error codes on
> error.  Returning "length" is meaningless.  This change does not affect
> runtime because the callers only care about zero/non-zero.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 4864c38b8d1c..77449b4f3df5 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -137,7 +137,7 @@ static int ssp_print_mcu_debug(char *data_frame, int *data_index,
>  	if (length > received_len - *data_index || length <= 0) {
>  		ssp_dbg("[SSP]: MSG From MCU-invalid debug length(%d/%d)\n",
>  			length, received_len);
> -		return length ? length : -EPROTO;
> +		return -EPROTO;
>  	}
>  
>  	ssp_dbg("[SSP]: MSG From MCU - %s\n", &data_frame[*data_index]);

