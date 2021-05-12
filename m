Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0409437C06C
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhELOlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhELOlI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:41:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5507E61370;
        Wed, 12 May 2021 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620830399;
        bh=aOtteczCzou62rFTw1oROE7RUG4SY1s43c0JPxnQfxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MoAe3MoxVn2kwBlhzOgpH6ZR3eVWnCP1Sy3KXt1cG055wA34rxu7uDk1h/ZZP5AhS
         nr9x+NPUFcRbln29G/hrms2DrBLfkAbu9NqllOD43Wp1JwdeoQMSswXCHgo3IZjlou
         N9Y6AwQnnLkmQWsZ3LGU1m1nFv3LdiUI5nU3WIWhBCF5iSMyvG6xZkZxNP0rIxg0Zb
         AxDzyJbf7F31TbGSDM4syR5+bTWADDmpmQHqura2vG2K4CyTdrsB1QbNurU4FDtEQr
         1RHGEmd6y7iDTm9/9GL+3ldzwcCs/5JuSeiYANUXNwo4ByEiET+UXoji4lHvYBmIVs
         win/7gW/RRaRQ==
Date:   Wed, 12 May 2021 16:39:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH 22/28] iio: light: vcnl4035: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512163954.5c5b8fc0@coco.lan>
In-Reply-To: <20210509113354.660190-23-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-23-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:48 +0100
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
> Cc: Parthiban Nallathambi <pn@denx.de>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  drivers/iio/light/vcnl4035.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 691a54b763e1..fd2f181b16db 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -144,9 +144,7 @@ static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
>  	struct device *dev = &data->client->dev;
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
