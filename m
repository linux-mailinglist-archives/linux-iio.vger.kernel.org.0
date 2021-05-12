Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EA837BFD9
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELOXd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhELOXZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:23:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 845F9613E9;
        Wed, 12 May 2021 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620829337;
        bh=bHScGVAGjtJYrUi8KXsuGU1B59RWKc9rr2I4BYXmgkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RrCF8YcVd1pUm9ul2lCyhYD4b3vq/2c/Iv2O9M1Qr1ewCSwND28nlpFedEf0y9P0Z
         kLZoQ/a6GXrEhJkMKrUuiHaLV8IJ056nBMVti2UhKBpDMaFO83W3ZVrXcWlDoTizEX
         6SqbOA06t+jbZY4HL/K/LKfCdHNmKAET/gNwaJKc3wsWnuq3o8ODlrBjznn58UGi8Y
         /IbdC9ak1RB5WCgxf6GnmnMjd3lnYxQBHPNRuIxD+w5WVW7Yq0RQ7U/RFl37k1Q6Ra
         Q6iGjcdPqccFSMrRZoznAiQmyiW8DY5hX1i8hG3/zKHANoFFw1YPk/oXphpotmSFLv
         KxP1MXk8j+M1Q==
Date:   Wed, 12 May 2021 16:22:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 17/28] iio: adc: ads1015: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512162212.7f56f0c7@coco.lan>
In-Reply-To: <20210509113354.660190-18-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-18-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:43 +0100
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

This driver has an extra (unbalanced?) call to pm_runtime_put_noidle() at
ads1015_remove().

> ---
>  drivers/iio/adc/ti-ads1015.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 9fef39bcf997..4b61ee3d2501 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -323,9 +323,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);



Thanks,
Mauro
