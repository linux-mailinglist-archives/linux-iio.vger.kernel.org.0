Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7D380466
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhENHg2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 03:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhENHg2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 May 2021 03:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E38761363;
        Fri, 14 May 2021 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620977717;
        bh=g3ZTG8KQaBRUidovS4sQMo9c0K3leSEtVjaeoUNmQjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dM96gbhk0zxNHmNqGeJFxLqXZswy6HZkeHZVWcFoSXybgiXFR72p0g1himeh41fFA
         8SWaNbsRypI25xPxGCBwxqll7fkvIsJGIviIqxysX9DJUbGa82GTKEV51imTfEZcg4
         FjUnExRz3cxAS1KUzNw9oJz9cMsr8p1zCQbPYW0dMJRDeMHlxsc9XHmtrLe47hu+VK
         5OTAY5A3pcwXYtbvnDV8ZO6FbJcbAiX3lRXm9v3CUFV65mpNE4yCJOPa3H9jBiuG1i
         EUxTOEEZByKj2FQHO+LeLIi6BToFFEIIBZC1fx8GyA0azIdfF8pTZcX2QFwy/wE4XF
         F0uqSBg7LepKA==
Date:   Fri, 14 May 2021 09:35:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 19/28] iio: light: pa12203001: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210514093513.1d973db5@coco.lan>
In-Reply-To: <20210509113354.660190-20-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-20-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:45 +0100
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
>  drivers/iio/light/pa12203001.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index bfade6577a38..a52b2c788540 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -186,9 +186,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
>  	}
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(&data->client->dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  
>  	} else {
>  		pm_runtime_mark_last_busy(&data->client->dev);



Thanks,
Mauro
