Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56E237BFB7
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhELOS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhELOS4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:18:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20DF9613E6;
        Wed, 12 May 2021 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620829067;
        bh=JiVqj5aw40nCa1sG3cLVj7uAJsPE1R/0p6ZOWx4IkCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VAOyYp33qD0k8RFnKuS/qi3layWezR8fIkXIe4tJNzYR2KocmAkFPDnxazGU35RDd
         vVg85/+NLJjatdw+bEM6NF3TgPC2LLYsPoQjCaZ9g7ttTSOZgGmO1ZQrQiJE9FKLYP
         AKdJsfaqq7eqPJTXvNXDYxBc4t2JiCZ3BWoluC7rtY82knKBWD/gCM9sQJdhLDaMqJ
         ICB5mdiN49S7sstkkfQw9VZ6xZvyantuh8Sd9aKt2k6pg7jCWFMOqGSZXEr2citG88
         agsfgX1NAdrrULxKPoNgNIU4LazzNaMB0wqK2QEMaBkheYO6RmWM24DJ5RGHZgpHnd
         qtlbfArnSu2WA==
Date:   Wed, 12 May 2021 16:17:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 14/28] iio: adc: stm32-adc: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512161742.0c35d0d2@coco.lan>
In-Reply-To: <20210509113354.660190-15-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-15-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:40 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/adc/stm32-adc.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index c9d36c88ee6a..5088de835bb1 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1158,11 +1158,9 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  
>  	adc->bufi = 0;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/* Apply sampling time settings */
>  	stm32_adc_writel(adc, regs->smpr[0], adc->smpr_val[0]);
> @@ -1364,11 +1362,9 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
>  
> @@ -1413,11 +1409,9 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	if (!readval)
>  		stm32_adc_writel(adc, reg, writeval);
> @@ -1537,11 +1531,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
>  	if (ret) {



Thanks,
Mauro
