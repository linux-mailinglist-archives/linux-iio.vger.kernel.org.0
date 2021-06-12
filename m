Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC773A4EA7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jun 2021 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFLMaH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Jun 2021 08:30:07 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37376 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLMaG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Jun 2021 08:30:06 -0400
Received: by mail-oi1-f175.google.com with SMTP id h9so8932712oih.4;
        Sat, 12 Jun 2021 05:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HE18N15sbHAWuCNxwS8MJ4Z91CDwDRXGuQ4CjcS6FYc=;
        b=u3IF3pA1zyTsfE3c6bWThAeN7o3zmBIDV3cyNZPQGKpPS7pIuyFjkO5en3QYwlGtSS
         +3WJVXCjgcBkPTt0sM+hFBDQX5lsnH3P9H80c7nzCOrHwDO8APIxhakWHu41n9ew20xh
         r0CAhNjmuObaOLISWMfpBV7QbCn7mvwqI4n/QvXln25mlN4v/cTUsCspDC/dEoQcg6Yu
         LD2lfOHcWLgZKBJ67q7J5pBOSPLaBR0/oLLftXCvXeZgiqO/vhbs1ihO+71cxUSTZ/Mh
         tNKHSDVGMgypnUWC1eAWLyZsr3cigJwFkzSguFwQZgsUJI4eCGzpGaonVdrA06kfdxsE
         lw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HE18N15sbHAWuCNxwS8MJ4Z91CDwDRXGuQ4CjcS6FYc=;
        b=g9zP1sgAgLb0Yv7zZRHurxOVmV7Yvs22DpxR2jP662A6T+dAM2poW4Vlw4CCP95vzc
         DQeaGI/BQVgmWp/NtycUGThvjG6TzKxSkjcDwvdblFgCZtHzPgs4aK4YZSSWtfqKco0P
         WWqyyeJ+QUKsYNIhmQEfQ9zqZTPDK6eHAyshl03e/jDvVR5rvyf7MSJ5VqSksuw5x/Pa
         iwfKYjJVhlkrBuO5GohKp2activ1usoHx0OyL8KXwV9S2FlusAgnGVhbzbF5wY6T62WH
         2Kakb1fZrVjwEhDQQ3fS3XQRsNub2rGeaFG6docYHgK6s8MGBF82pLCKPXe+EWck/rTO
         MMtA==
X-Gm-Message-State: AOAM5311Sr7E67PLpBydyX3uKVYYaZzVIS5eiVsewfZDiVrCveBrbZ6A
        GWeXPc+a8YWlhGbH4iZnXcA=
X-Google-Smtp-Source: ABdhPJzQBf1fp5rBJ0YZfU6ENkp4jGsM8qGr9gsTZ84SduUWFNi0VKNMbqNdZJsu9ERNH6CfQZdPkA==
X-Received: by 2002:aca:4482:: with SMTP id r124mr5355527oia.153.1623500811604;
        Sat, 12 Jun 2021 05:26:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k18sm2017730otj.42.2021.06.12.05.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:26:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 12 Jun 2021 05:26:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] hwmon: (ntc_thermistor) Drop unused headers.
Message-ID: <20210612122649.GA318728@roeck-us.net>
References: <20210611142257.103094-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611142257.103094-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 03:22:57PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The IIO usage in this driver is purely consumer so it should only
> be including linux/iio/consumer.h  Whilst here drop pm_runtime.h
> as there is no runtime power management in the driver.
> 
> Found using include-what-you-use and manual inspection of the
> suggestions.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ntc_thermistor.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 8587189c7f15..18fd6f12ca16 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -8,7 +8,6 @@
>  
>  #include <linux/slab.h>
>  #include <linux/module.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/math64.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> @@ -17,9 +16,6 @@
>  
>  #include <linux/platform_data/ntc_thermistor.h>
>  
> -#include <linux/iio/iio.h>
> -#include <linux/iio/machine.h>
> -#include <linux/iio/driver.h>
>  #include <linux/iio/consumer.h>
>  
>  #include <linux/hwmon.h>
