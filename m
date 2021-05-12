Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1126837BE48
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhELNet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhELNet (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:34:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDEF6613D6;
        Wed, 12 May 2021 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620826421;
        bh=h3aafz0gKCEhf5E3T5/llYuQNmk7W8vXk+0uNk+3xQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VHvSHTss/YXO4HBT+Z7OvLuAvDSydOrBe3fobF0vdnT+Xt29El3gWUupg5SZOGvZm
         otYyUl/efqJCeNADcQYNE3IM1TVhK4Ci2gtJj1B+gOHwr2yPLb1Nzurtc3u7lFTuid
         IXvV3w3pPEThJCd/tgHyiXB30QrBT94cG52kY2a4yGsKiU7SmvGnJN6GpeMZzAne1n
         cL50/1XzAXLiRHeTeWVjOhtdB3Hz5Yr36A4K1JYYB7Oai2HFXfgvTWg7YIqLa4z3PV
         c9N83b6Bd4JOYa429dH/khQZfUgVnviwj7LUiF/u+ruZi12RPVQ50IF0oAh1Yq0OOP
         p3w0oUZvI+5Fg==
Date:   Wed, 12 May 2021 15:33:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 02/28] iio: light: isl29028: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210512153335.5acb9e3f@coco.lan>
In-Reply-To: <20210509113354.660190-3-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-3-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:28 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In remove this driver called pm_runtime_put_noidle() but there is
> no matching get operation.  This does not cause any problems because
> the reference counter will not change if already zero, but it
> does make the code harder to reason about so should be dropped.
> 
> Whilst we are here, use pm_runtime_resume_and_get() to replace open
> coded version.
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/light/isl29028.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
> index 2f8b494f3e08..9de3262aa688 100644
> --- a/drivers/iio/light/isl29028.c
> +++ b/drivers/iio/light/isl29028.c
> @@ -339,9 +339,7 @@ static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
>  	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
>  		ret = pm_runtime_put_autosuspend(dev);
> @@ -647,7 +645,6 @@ static int isl29028_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	return isl29028_clear_configure_reg(chip);
>  }



Thanks,
Mauro
