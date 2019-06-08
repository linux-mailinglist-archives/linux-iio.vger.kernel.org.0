Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050CB39FC0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFHM64 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfFHM64 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:58:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBD720693;
        Sat,  8 Jun 2019 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998735;
        bh=UfIVvcqM0cOfNpGajvnyTAXIejBMxZerEv439sF/hYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQFTedgIufQEX72fdtIEammBAqfszWFDSLc5YlTtzyWhdGawnBDXCCexU53NgB3cp
         z/m26dbFaz9jZaqcbAiF+PzyN1D0m4Tbdd0/L7GdIE+Pyf/qeOn3YdyFf9uUl/6Bb6
         Mg4ezF1AuE8TVVvxU+4RSIH9w0lQHfbv9BDYDiSU=
Date:   Sat, 8 Jun 2019 13:58:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: imx7d_adc: Remove unneeded error message
Message-ID: <20190608135851.48a0d7d1@archlinux>
In-Reply-To: <20190603193433.6394-1-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Jun 2019 16:34:30 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> In case of ioremap failure, the core code will take care of printing
> the error message, so there is no need for having a local error
> message in the driver.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 4fe97c2a0f43..23c7b0ee945f 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -493,11 +493,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	info->dev = dev;
>  
>  	info->regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(info->regs)) {
> -		ret = PTR_ERR(info->regs);
> -		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(info->regs))
> +		return PTR_ERR(info->regs);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {

