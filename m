Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401BF37BFBE
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhELOUd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhELOUc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:20:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B5E8611BE;
        Wed, 12 May 2021 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620829164;
        bh=vrgO5y/1+UQCGdRb32dc7Ds63m0NMnwUoQlDMhELXlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RQtatVDk+E+LVd7nkqFnUvr3slWwGzjPzOagwQlBpk2lozUlFHfZ4R/rWpXJqbty+
         MqGx71lNUA53kenf7gNZEZSSknZ8AnaEImxXTacLiRX4nqIwcgZ+2DWpC/iAe1xytw
         WR3AjCdE2cEdO6MStCg6atDc0F4B/GCxc75ISrGG2EWEhCoPhA+PuwoKxEwiPAWPw7
         WlEDTs0jKMfRX0n8zN/zEsazJ1Va9ctljokr3pBlJiyBvMgPv3ViBZNGUg+pD23P4z
         1duVUOlq4o6q+LiD1wpX+ZoIFrm4bS7c+9oV0S+LRQ2TN3aTj466zzNOpOCdPZYZif
         zsvIeEMA6MH5w==
Date:   Wed, 12 May 2021 16:19:19 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 15/28] iio: adc: stm32-dfsdm: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512161919.1a38419f@coco.lan>
In-Reply-To: <20210509113354.660190-16-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-16-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:41 +0100
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
>  drivers/iio/adc/stm32-dfsdm-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index bb925a11c8ae..a627af9a825e 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -135,11 +135,9 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  	int ret;
>  
>  	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0) {
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
>  			goto error_ret;
> -		}
>  
>  		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
>  		clk_src = priv->aclk ? 1 : 0;



Thanks,
Mauro
