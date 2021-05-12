Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F7837C0E8
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhELOy7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhELOyk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 933916142E;
        Wed, 12 May 2021 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831212;
        bh=O23u1Yt8eJdl6se2oANx4PH3f+XT50RrnCm4Itvqvfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JXHz2gLf+aULkuEbjqrGu+a1VFpAeNF2xjXHK1ZjlhPqLxyhB2CXv3OtQlB0uS8Me
         5LXddvUnhyGX8tYo3h43CPpjPIahQ5to679P+yQcKooORRqNSdrCuj0LWrSY4PwxVu
         /ws9ckk1Enp1V34U2E0euiEMMcdo4SYVPoIUqgvoVPWz81fFzzpgXMUDl9LnCFLdqf
         deu4rsjeu3xxlS1ZKlE/eVwoaNfyQ7aSmjWbafi1+MJmOxFUObqHm7Rz/DBrw2Zxh3
         CHKAEC6kdAW+vxkNg0TQNLn8Tfvf+LtVIg+XBhGrRkB+SlpctovZhYfGSPdlwfotX4
         UupzMPY+u3U7Q==
Date:   Wed, 12 May 2021 16:53:26 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: Re: [PATCH 25/28] iio: proximity: srf04: Use
 pm_runtime_resume_and_get() and handle error
Message-ID: <20210512165326.12f26e74@coco.lan>
In-Reply-To: <20210509113354.660190-26-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-26-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:51 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Previously this driver used pm_runtime_sync_get() and did not handle any
> errors that occurred.  Moving to the new pm_runtime_resume_and_get() +
> handle errors.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Klinger <ak@it-klinger.de>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/proximity/srf04.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 420c37c72de4..fe88b2bb60bc 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -100,9 +100,11 @@ static int srf04_read(struct srf04_data *data)
>  	u64 dt_ns;
>  	u32 time_ns, distance_mm;
>  
> -	if (data->gpiod_power)
> -		pm_runtime_get_sync(data->dev);
> -
> +	if (data->gpiod_power) {
> +		ret = pm_runtime_resume_and_get(data->dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  	/*
>  	 * just one read-echo-cycle can take place at a time
>  	 * ==> lock against concurrent reading calls



Thanks,
Mauro
