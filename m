Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7B637BFC4
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhELOVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhELOVk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:21:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E55F613E6;
        Wed, 12 May 2021 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620829232;
        bh=aNg98fVIvI1br03FboWK0cd/28T/jtxECuUI2R4liYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GlwixM+GeO/nQApD8HvvFgVSIchL+5339d5+HA1iXXiKABbnEm1Myhq0b17M4g+5F
         a3U+fELjesLZddOkzLUj0uXbRSo6vxtJuFa8kGH7msiKsReLAkCty+dIL1FW960Ykm
         FBAFaQmumUgqnIdfXCWYhM+iMStO+cBdpsQD80yU8zX3BOHam7pxgEDl+yZiYqd08v
         MuKZ8o8GyDM8fYA4nBkiEJVgGYuX7vrCyzXqMcUvPizl2iHjakwuvHZh4GPL0PqGZ7
         rysEQXqt/0xcYgwGeohDErTMOmVo4oLh17KB3agB5mQp3KG9PS+Mh4xxkqMPhB+lY8
         hNgp6QumGixfQ==
Date:   Wed, 12 May 2021 16:20:26 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 16/28] iio: dac: stm32-dac: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512162026.22e8bb3e@coco.lan>
In-Reply-To: <20210509113354.660190-17-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-17-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:42 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/dac/stm32-dac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index a5b0a52bf86e..dd2e306824e7 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -69,9 +69,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	}
>  
>  	if (enable) {
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  		if (ret < 0) {
> -			pm_runtime_put_noidle(dev);
>  			mutex_unlock(&dac->lock);
>  			return ret;
>  		}



Thanks,
Mauro
