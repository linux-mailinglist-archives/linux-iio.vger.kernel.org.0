Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BD45AE8A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhKWVkv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhKWVku (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 16:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637703461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chdi7g/NM3EqzSvk6me0/L4jVvVii6DlXiJ5engamZ8=;
        b=ZEypU7WUc9/f1tWPSjuIGPvJDa4XIMwKQaHDA560F0ywleXRhYjCp7KZUpjwUyfl5HFJ8y
        0SsBRLJcwMEti/GijBTmr5iSfneUq54C3P0lwjWWqZ6mUAieBdyJt/0C1UiE7mV+wtLqxa
        ulihUIhJ7siBEqakV27ER2MfzyiALzI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-pbcRuyYuMi2S81HMGoN5uA-1; Tue, 23 Nov 2021 16:37:40 -0500
X-MC-Unique: pbcRuyYuMi2S81HMGoN5uA-1
Received: by mail-ed1-f70.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso180246eds.12
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 13:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=chdi7g/NM3EqzSvk6me0/L4jVvVii6DlXiJ5engamZ8=;
        b=AUuILmCtkdgfbBEjAnG4j47h6dsinx7hBn121c/iw2s4I3//x8OT3jzmhS73lHftFR
         nNYWmet+Mrq45gM4HOth30fGZU6XP1OFTKdX2FwtSw0Gapkx/maRP1VZm+82GNYxZTO5
         Es/8GkC/ODtu/d/twzludkwqD614Eg6ywqr+yRfhyPFdQL4WdrjjNQJcH5o5XnTPb2KC
         FOCB7l/0xDIJuQhqmjGS1QVqLWZkHltYBzj31P3M+9Py2LyIbqAIcf+aDRlllo7t5fyt
         oUy2EoUoYCGafhm9lVcWIIhdGzr6Iujc5tMVH8OTM/x8JOM0UtK7cWFXR18CMFeTLehu
         08kg==
X-Gm-Message-State: AOAM531GQz0zvximiWqtnWkV7Pw0NY1zsvlZiTPj6GxVU5ZV8hJQdZju
        3A2T3KZdD0qhtjX71MUue5/c8SxKShxiewiUcgKPeh2o2mwQUn6F0qMstRhjJNXAawX49sR8XsM
        pNqanLecH175LGsOeE6ik
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr15066593edl.336.1637703459292;
        Tue, 23 Nov 2021 13:37:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfdtMDvqOzMTo/T61FKx5rHUHjWgxzFC04qhQmP5Uubr0YKY10+6FnIlc8b6UjD7qxAL0kGw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr15066561edl.336.1637703459152;
        Tue, 23 Nov 2021 13:37:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m6sm6928556edc.36.2021.11.23.13.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 13:37:38 -0800 (PST)
Message-ID: <4144afb4-1b8b-cbf8-0e42-27d6a010a278@redhat.com>
Date:   Tue, 23 Nov 2021 22:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 05/49] iio:accel:mc3230: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
 <20211123211019.2271440-6-jic23@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211123211019.2271440-6-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/23/21 22:09, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/mc3230.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> index 735002b716f3..139c7f6839df 100644
> --- a/drivers/iio/accel/mc3230.c
> +++ b/drivers/iio/accel/mc3230.c
> @@ -160,8 +160,7 @@ static int mc3230_remove(struct i2c_client *client)
>  	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int mc3230_suspend(struct device *dev)
> +static __maybe_unused int mc3230_suspend(struct device *dev)
>  {
>  	struct mc3230_data *data;
>  
> @@ -170,7 +169,7 @@ static int mc3230_suspend(struct device *dev)
>  	return mc3230_set_opcon(data, MC3230_MODE_OPCON_STANDBY);
>  }
>  
> -static int mc3230_resume(struct device *dev)
> +static __maybe_unused int mc3230_resume(struct device *dev)
>  {
>  	struct mc3230_data *data;
>  
> @@ -178,7 +177,6 @@ static int mc3230_resume(struct device *dev)
>  
>  	return mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
>  
> @@ -191,7 +189,7 @@ MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
>  static struct i2c_driver mc3230_driver = {
>  	.driver = {
>  		.name = "mc3230",
> -		.pm = &mc3230_pm_ops,
> +		.pm = pm_ptr(&mc3230_pm_ops),
>  	},
>  	.probe		= mc3230_probe,
>  	.remove		= mc3230_remove,
> 

