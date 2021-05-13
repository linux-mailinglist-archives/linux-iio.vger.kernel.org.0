Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9F37FAF5
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhEMPnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 11:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhEMPnK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 11:43:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3D46101B;
        Thu, 13 May 2021 15:41:58 +0000 (UTC)
Date:   Thu, 13 May 2021 16:43:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-iio@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] iio: adc: Add missing MODULE_DEVICE_TABLE
Message-ID: <20210513164307.5e22ee4b@jic23-huawei>
In-Reply-To: <20210512093844.243245-1-zhang.lyra@gmail.com>
References: <20210512093844.243245-1-zhang.lyra@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 17:38:44 +0800
Chunyan Zhang <zhang.lyra@gmail.com> wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> MODULE_DEVICE_TABLE is used to extract the device information out of the
> driver and builds a table when being compiled. If using this macro,
> kernel can find the driver if available when the device is plugged in,
> and then loads that driver and initializes the device.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Applied to the togreg branch of iio.git and pushed out as testing to see
if 0-day can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 301cf66de695..00098caf6d9e 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -549,6 +549,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
>  	{ .compatible = "sprd,sc2731-adc", },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
>  
>  static struct platform_driver sc27xx_adc_driver = {
>  	.probe = sc27xx_adc_probe,

