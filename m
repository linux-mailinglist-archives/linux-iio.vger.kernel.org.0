Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250F23754CC
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhEFNfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 09:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233993AbhEFNfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 09:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620308064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPc+W/XTdGwFLPXo+j4WvorK8DhXEDBZU8KGl987Scc=;
        b=iDz8p4MSvK1D6WP2WNOik13G373zkZ6CnEoKU/xoe2M9kszoIsGaFxA+BezckFmHCAmiP/
        pzmbdQPOaP6BZPtcxVkZscxRM7lCceh87BvkK+uNMbPzbQrf6veMUYOZ03RYNr+0G2iCsT
        qnPHRilc142qWa+1mV7nOHwWzpIaBLY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Fz8LcvhbM4S9J984_6VhwA-1; Thu, 06 May 2021 09:34:22 -0400
X-MC-Unique: Fz8LcvhbM4S9J984_6VhwA-1
Received: by mail-ed1-f72.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so2647573edc.5
        for <linux-iio@vger.kernel.org>; Thu, 06 May 2021 06:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPc+W/XTdGwFLPXo+j4WvorK8DhXEDBZU8KGl987Scc=;
        b=eHICAMPlhqngti3aAQIzzWqF9wUnqSCMPfne5KRkk0Hj4lmqqwl/yBIdbyEl0+vrs4
         mqCALu6Ro98wWpqnTbV1M2TXd+Emz4iN+V2A+aHLDBkRV1761bNj3klHhl4wvfU+y0W+
         yXd+o2c1zYZSvkyzo6GxjhBfnMMa54M8Q0O9xyUs8CMApXd0zkA7a+TAn8cMSNdhcdMi
         r56Dl/Ycd8t46xaSw7nKR/kMQ+mOCRalpYAKmGIlStSgOeskGNkvuPtTE3oQkpC7u6bb
         NA+Wj6KsLnd5B5MnTfsnF7xDKp1sDR0u7LbzjpwjB3HLKozTXzPc6fm+EH+rnjlrLRBf
         uUwA==
X-Gm-Message-State: AOAM531bQFjx8xgLgNrBvGL2ncAij6SAxdBMmkBLSlmX54VmPVfDblvX
        CoAsELpv9Ll8XDKAyLANs8LWbXeA+h7J/rKqrBUQ86Qn6ur6tTbtau4EqlVvusXOramSsBHJk7r
        JCT2TTJP1N5nM6sZaiCeT
X-Received: by 2002:a17:906:4553:: with SMTP id s19mr4437560ejq.117.1620308061619;
        Thu, 06 May 2021 06:34:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjcUafqwF3p+FEiROr7dUWC9UVn6oG30p4J15nqDKeTSU6ntNMN3NwQeZBpZpi0zPBWgAZEg==
X-Received: by 2002:a17:906:4553:: with SMTP id s19mr4437548ejq.117.1620308061481;
        Thu, 06 May 2021 06:34:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v14sm1718061edx.5.2021.05.06.06.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 06:34:20 -0700 (PDT)
Subject: Re: [PATCH] iio: bme680_spi: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210506133145.2266604-1-linux@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <034f8cbf-775c-6ee6-1c41-0a951368e998@redhat.com>
Date:   Thu, 6 May 2021 15:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506133145.2266604-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/6/21 3:31 PM, Guenter Roeck wrote:
> BME0680 is not an official ACPI ID, so let's remove it before someone
> starts using it.
> 
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/chemical/bme680_spi.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index 6f56ad48cc40..cc579a7ac5ce 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -4,7 +4,6 @@
>   *
>   * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
>   */
> -#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> @@ -145,12 +144,6 @@ static const struct spi_device_id bme680_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, bme680_spi_id);
>  
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -	{"BME0680", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_spi_match[] = {
>  	{ .compatible = "bosch,bme680", },
>  	{},
> @@ -160,7 +153,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>  static struct spi_driver bme680_spi_driver = {
>  	.driver = {
>  		.name			= "bme680_spi",
> -		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
>  		.of_match_table		= bme680_of_spi_match,
>  	},
>  	.probe = bme680_spi_probe,
> 

