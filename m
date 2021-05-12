Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A937C03D
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhELOgr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhELOgr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CFF4613B5;
        Wed, 12 May 2021 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620830139;
        bh=TNVTGEak4k0xlH0EBZHL74AhSyvJRGFWdGfuOzVAwH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sUDmhnvIYKfB4ph/T4yrJZ8kipvn1VfAFGXpxO484/XV3tdvKD1+fEMWwTddRLXKM
         yKpcP+ZqQNZ79ZJelhraUXmHBgkvUhP9coUd8ELBK7sYxJ099G7/bxckxG0UePb3RA
         WNtXDfRIH6Xx46K4t/hAc1pm92UwEDD0fdEwuCu8iFa9Qo8qMf5tYhLaoM/h6Vy80c
         CxH6rMBJdC7s2YvaYuUaEsVyuv3T/ijf3QVy18IejNrelXkESFi6Y8/ioTDC3kN5un
         zBOlwrhF5GP1/gFkoATb2hXiWQ83ZSI8okJ5hE0XEPCeT6QJZwL8yyLXKpMBipWer0
         md/hq07MpcxTA==
Date:   Wed, 12 May 2021 16:35:33 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 20/28] iio: light: us5182: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210512163533.2039253e@coco.lan>
In-Reply-To: <20210509113354.660190-21-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-21-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:46 +0100
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

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  drivers/iio/light/us5182d.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index 393f27b75c75..96e4a66ddf28 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -367,9 +367,7 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
>  		return 0;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&data->client->dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);



Thanks,
Mauro
