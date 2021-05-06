Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E53750E0
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 10:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhEFIaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 04:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232944AbhEFIai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 04:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620289779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtZ7qBsYn9UJRqFBOkbORC2kcFJZhHHEnMfX/8FBqCo=;
        b=KMS9fmEi6I9KIFTfQBAjNqgAnUl3IQ30Gb/ibaEiwC6yk6KN5n3u8gWjuJxFR9CVUW4Ane
        eD/1LT4xm6INihyO4Spx24xUIZMBwUZJn17sjse53jUnnohgZO+/EHnli1lk8gVpDkO2On
        DRI26KAksfhhfmSNggWzTHAsW75YjAc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-DGgJhH10ObyGeVJnwkyCsw-1; Thu, 06 May 2021 04:29:38 -0400
X-MC-Unique: DGgJhH10ObyGeVJnwkyCsw-1
Received: by mail-ed1-f69.google.com with SMTP id y15-20020aa7d50f0000b02903885ee98723so2226844edq.16
        for <linux-iio@vger.kernel.org>; Thu, 06 May 2021 01:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtZ7qBsYn9UJRqFBOkbORC2kcFJZhHHEnMfX/8FBqCo=;
        b=U3k+TPU0t9RWp50KR7ENlrx99XBIfe7z6ROirzZwfmTkTeFJRVxfkG91MtJjDPE5zg
         st3OsRBQsegOB5mImnKYziiQWG3jHvDBG2OM234rPZmP9RPKKCFOSBE+sR36PXN82/fI
         hl7X96OLietKtXyDel5Rkd83dnp01lRC839DY8sf2sE+MCTt15JXL8eYXqxJ8S1XJCoR
         IwKTotroKj1nk7kvwKfHU/ilFhzmiKdkK+sN8kUUWfYCEahH/QBakfvDa7VfoudO3Qby
         bRW8txrsx4cTyiAAaKPstLkzrLYFGhspCGFzfWqwSItl3AkzcDVIkLDBtOJv0wKFYaJy
         pcJg==
X-Gm-Message-State: AOAM533Gyy09ln6H5S7jctKixSLy1/1hXuBp1la3kSspRh7zyVVwhLsA
        jbHsZG+2NaIbzcN1Lo2XbHoCcjOrCe+m3MRA15lYeXYiemqQyn1cNrXjxqecGEfqW+klWiXqYjd
        B+3906bw9eg3RwVyOqHDp
X-Received: by 2002:a05:6402:280d:: with SMTP id h13mr3770537ede.105.1620289777207;
        Thu, 06 May 2021 01:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRY+zDPr2936QLfmsMOiSXAcMW56m7+2daofSuLClVVMlnjTPvG+S2fir+sYfiNd5n2G1NIA==
X-Received: by 2002:a05:6402:280d:: with SMTP id h13mr3770521ede.105.1620289777018;
        Thu, 06 May 2021 01:29:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id da25sm1105840edb.38.2021.05.06.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 01:29:36 -0700 (PDT)
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
To:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba228717-ef0f-1568-bf7e-3cfac454ba1f@redhat.com>
Date:   Thu, 6 May 2021 10:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506034332.752263-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/6/21 5:43 AM, Guenter Roeck wrote:
> With CONFIG_ACPI=n and -Werror, 0-day reports:
> 
> drivers/iio/chemical/bme680_i2c.c:46:36: error:
> 	'bme680_acpi_match' defined but not used
> 
> Apparently BME0680 is not a valid ACPI ID. Remove it and with it
> ACPI support from the bme680_i2c driver.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Instead of making bme680_acpi_match conditional,
>     remove ACPI support entirely since the ACPI ID is
>     not valid.

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>  drivers/iio/chemical/bme680_i2c.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 29c0dfa4702b..74cf89c82c0a 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -11,7 +11,6 @@
>   * Note: SDO pin cannot be left floating otherwise I2C address
>   *	 will be undefined.
>   */
> -#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> @@ -42,12 +41,6 @@ static const struct i2c_device_id bme680_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
>  
> -static const struct acpi_device_id bme680_acpi_match[] = {
> -	{"BME0680", 0},
> -	{},
> -};
> -MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> -
>  static const struct of_device_id bme680_of_i2c_match[] = {
>  	{ .compatible = "bosch,bme680", },
>  	{},
> @@ -57,7 +50,6 @@ MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
>  static struct i2c_driver bme680_i2c_driver = {
>  	.driver = {
>  		.name			= "bme680_i2c",
> -		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
>  		.of_match_table		= bme680_of_i2c_match,
>  	},
>  	.probe = bme680_i2c_probe,
> 

