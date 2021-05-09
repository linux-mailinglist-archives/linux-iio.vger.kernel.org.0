Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF93776D5
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhEINyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 09:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhEINyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 09:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620568385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpSm9E+GplsyBJode3gAUjo4Po94JQPYl0QTnbMmyDA=;
        b=JlR7/6Zlz4sszdM9QM6CQKP/MUM+I3iGfp3PbtMXUFlYCaZ3WWznE5IOErrUF+OMC74lyd
        GTT7YV6MzgEF08EUNpfC6lvloaXmrePpKWDW2nDrhliq3joThv9aargQ3JCxJf4Kql37Xn
        mB2UC6hcwPsKfbyTpgLfpZhWdOOeyZ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-E36qvwApO8aF7n-8QKC5vQ-1; Sun, 09 May 2021 09:53:03 -0400
X-MC-Unique: E36qvwApO8aF7n-8QKC5vQ-1
Received: by mail-ed1-f72.google.com with SMTP id g19-20020a0564021813b029038811907178so7523259edy.14
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 06:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dpSm9E+GplsyBJode3gAUjo4Po94JQPYl0QTnbMmyDA=;
        b=r825NjEcro2R5SfK+SDLdU0aptupcBhISEjcx+wWd+3SH9AdJoAPqsgQSrQokz1sTQ
         AAZ9nIbtocTtOzTrg3MIGrXmy16aIX3wrxTULr2WWXYMzas39GyXVlpTsnKZ86UM83Hn
         d8AAu6dCsA9xVV8lv2SWjAXtjFhXzvwp7H/Ai9qwM8P17E5xKAbEfxo3C4AaPVwWVDzX
         N7m+NflNTLR9p5MxQ8fjQfl90IGiewySEoSzP9bO+a7h7VJpm53WiJLXmqdaof7OaB0m
         ux+GzEW+rs3fki8bVl4Rdy+OKmzHEBYLppyfcausfjbY7ruakDdzdeKdPQnuDWStTrMb
         y/hg==
X-Gm-Message-State: AOAM532jufoUMmG8JKb5Hm6mNpfrUVBHrjo1YhVhAiREpXB2lGsRQ6qO
        d/nG7SNmSezypweIPd/4OQ9RF6HeQ67NBHcGNoaTKPsBEyY4EqFdIkw7HC1BdbpG4cxueqYyqRy
        oFc9zvgQnaMIZIDWs6UPk
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr24299017eds.166.1620568382346;
        Sun, 09 May 2021 06:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmYmrlTEkdNpuoIMwgqZ3rQwlahyMYuqsQtefCUh9qMSyRITZDIlWB2WntZCbFqPIhfc1wDA==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr24299008eds.166.1620568382223;
        Sun, 09 May 2021 06:53:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v23sm8659186eda.8.2021.05.09.06.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 06:53:01 -0700 (PDT)
Subject: Re: [PATCH 07/28] iio: accel: kxcjk-1013: Balance runtime pm + use
 pm_runtime_resume_and_get()
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-8-jic23@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b29e7255-a4d0-a008-04ca-95037faa54c0@redhat.com>
Date:   Sun, 9 May 2021 15:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509113354.660190-8-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver alls pm_runtime_put_noidle() in it's remove function, but there
> is no matching get call.  This isn't a bug as runtime pm will not allow
> the reference counter to go negative, but it is missleading so lets remove
> it.
> 
> Whilst here use pm_runtime_resume_and_get() to tidy up some boilerplate.
> The coccicheck script didn't get this one due to the less obvious
> structure. Found by inspection.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/kxcjk-1013.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 283e6a3feffc..a9e3dae43ac5 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -478,7 +478,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	int ret;
>  
>  	if (on)
> -		ret = pm_runtime_get_sync(&data->client->dev);
> +		ret = pm_runtime_resume_and_get(&data->client->dev);
>  	else {
>  		pm_runtime_mark_last_busy(&data->client->dev);
>  		ret = pm_runtime_put_autosuspend(&data->client->dev);
> @@ -486,8 +486,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"Failed: %s for %d\n", __func__, on);
> -		if (on)
> -			pm_runtime_put_noidle(&data->client->dev);
>  		return ret;
>  	}
>  #endif
> @@ -1485,7 +1483,6 @@ static int kxcjk1013_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -	pm_runtime_put_noidle(&client->dev);
>  
>  	if (data->dready_trig) {
>  		iio_triggered_buffer_cleanup(indio_dev);
> 

