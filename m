Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3739FC5
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfFHNAm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfFHNAm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:00:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8427D20693;
        Sat,  8 Jun 2019 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998842;
        bh=ZarthZ+H/MP8Ok/VMwvj13eEUVAEd4IT4o3pbboQcGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LvEgjsC2VW3sAqdWQfzy9a24SenkmojBjuf3UUM0DsjpY36ubTnSmIUbyzxe8GhnB
         2Qat+MGXPtBoKH6vJ3QCbqo1aI8Jsh8Trwhhs7wEGxozkvAU9rNp66ZTj13EkZVAw4
         2Cu0HAJAt/iL+W+ZEl7LyfguRXm9CuhYRPYnPmXU=
Date:   Sat, 8 Jun 2019 14:00:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: imx7d_adc: Fit into a single line
Message-ID: <20190608140038.2b5de3c9@archlinux>
In-Reply-To: <20190603193433.6394-3-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
        <20190603193433.6394-3-festevam@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  3 Jun 2019 16:34:32 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> All the parameters of devm_request_irq() can fit into a
> single line, so place them all in a single line
> for better readability.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Applied.

Thanks,
> ---
>  drivers/iio/adc/imx7d_adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index bffc172e7635..46e88899ad74 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -527,9 +527,7 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = imx7d_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
>  
> -	ret = devm_request_irq(dev, irq,
> -			       imx7d_adc_isr, 0,
> -			       dev_name(dev), info);
> +	ret = devm_request_irq(dev, irq, imx7d_adc_isr, 0, dev_name(dev), info);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
>  		return ret;

