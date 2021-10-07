Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1E6425979
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbhJGRbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 13:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242353AbhJGRba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 13:31:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED31360BD3;
        Thu,  7 Oct 2021 17:29:34 +0000 (UTC)
Date:   Thu, 7 Oct 2021 18:33:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: health: afe4403: Make use of the helper
 function dev_err_probe()
Message-ID: <20211007183338.37c80008@jic23-huawei>
In-Reply-To: <20210928014403.1563-1-caihuoqing@baidu.com>
References: <20210928014403.1563-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:44:01 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Series applied and pushed out as testing for 0-day to see if it can
find anything we missed.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/health/afe4403.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index d4921385aaf7..3a8cfb669b25 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -487,10 +487,10 @@ static int afe4403_probe(struct spi_device *spi)
>  	}
>  
>  	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
> -	if (IS_ERR(afe->regulator)) {
> -		dev_err(afe->dev, "Unable to get regulator\n");
> -		return PTR_ERR(afe->regulator);
> -	}
> +	if (IS_ERR(afe->regulator))
> +		return dev_err_probe(afe->dev, PTR_ERR(afe->regulator),
> +				     "Unable to get regulator\n");
> +
>  	ret = regulator_enable(afe->regulator);
>  	if (ret) {
>  		dev_err(afe->dev, "Unable to enable regulator\n");

