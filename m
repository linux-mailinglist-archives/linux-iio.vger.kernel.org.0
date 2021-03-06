Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906CD32F811
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 04:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCFDVY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 22:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCFDVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 22:21:01 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C490C06175F;
        Fri,  5 Mar 2021 19:21:01 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x135so311221oia.9;
        Fri, 05 Mar 2021 19:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lug5CVqa/HgmuAaBvdEm22vo14rU3gyfJ9IQJ/S2QQw=;
        b=YZe9pV16wKMx7z9Ypw1zKQkCiFt364PorS0UK/7oBbS52Gcn2bH32Sl8WpUcucgotn
         CXxmKlNe8JwJ5DwaS9+BOhQi5AFsZjOfg8g1S6g44bRmSC6+RyaSbu1Z2sz1aXd2A4r+
         rls9BMML4K5Zy/iAQ/PY/ScpoPBfmPfbkrQ4Rim3OeOr79UV3JCfqG6mkfYRVEO+0+Li
         vvevK1HCCibeMCTgBLN4JJS53Few/WujxXc0mZl1lByDxSsnezQ4+/ST+UpKUx0jFnmo
         lLGwK8CovDQ5PY+PCtJ95oUUb/iaYMpNspvOKkNYxRtI3xf6zX8p/9g1TPgOnMWwa03R
         NS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lug5CVqa/HgmuAaBvdEm22vo14rU3gyfJ9IQJ/S2QQw=;
        b=OPlJCWQ7dvnRCfmDVp4BPHFoiN6XL3mfRIjETP/Yx+s5W1SeKLQHOprMS9CEQGRZez
         TXne1cB6ZjBf+sd6f4O5GuZ5vK8hu4WLMSHaZtBEmWI9TfeszPnvkTYwzJ/mxZAgaO9q
         QmiQr7v0wU1xCV6JwveQiz4PmjoKaZk7/aQTHxxA/o6DRO6SUBo05ARtE11ipODDTe8n
         x0LgYDQeL10D+BIFV9E/1Bvw97somqCFuaUydQ2lwA7JBKVtuRov+yccEakMCbKjH6Tu
         gSeQ/gTTnt44g9lpg7i2FdpL4UtvoDN7ST9hLYnb8KFj0Akqqiwl/vhWdQ+pmufi/toG
         6PZg==
X-Gm-Message-State: AOAM533AmJzFYTTs8EzOwcElmR1LwhTIHOzoFfG+WJ1LhkB5IcNRyxuE
        YQ99Ts0zmvvMmxT1qiTSaJ0FBSpJFjc=
X-Google-Smtp-Source: ABdhPJx+nxzYVFVFfijctyDIJOaYmE8oofQzw9nOkt4QQ9Lk8Zkq+Mu40VzrG1iKxxMB3bldBnOOlQ==
X-Received: by 2002:a05:6808:f0c:: with SMTP id m12mr9504864oiw.95.1615000860501;
        Fri, 05 Mar 2021 19:21:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y28sm1157565ote.34.2021.03.05.19.20.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Mar 2021 19:20:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 5 Mar 2021 19:20:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 4/4] hwmon: acpi_power_meter: Get rid of ACPICA
 message printing
Message-ID: <20210306032058.GB192807@roeck-us.net>
References: <2775419.haJ69vZeI0@kreacher>
 <1890478.AxU35vj7Mz@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1890478.AxU35vj7Mz@kreacher>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 05, 2021 at 07:43:54PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use acpi_evaluation_failure_warn() introduced previously instead of
> the ACPICA-specific ACPI_EXCEPTION() macro to log warning messages
> regarding ACPI object evaluation failures and use dev_err() instead
> of ACPI_EXCEPTION() to log _PMC package parsing failures, which is
> consistent with the other messages printed by the code in question.
> 
> Next, drop the ACPI_MODULE_NAME() definition only used by the ACPICA
> message printing macro.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/acpi_power_meter.c |   29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/hwmon/acpi_power_meter.c
> ===================================================================
> --- linux-pm.orig/drivers/hwmon/acpi_power_meter.c
> +++ linux-pm/drivers/hwmon/acpi_power_meter.c
> @@ -20,7 +20,6 @@
>  #include <linux/acpi.h>
>  
>  #define ACPI_POWER_METER_NAME		"power_meter"
> -ACPI_MODULE_NAME(ACPI_POWER_METER_NAME);
>  #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
>  #define ACPI_POWER_METER_CLASS		"pwr_meter_resource"
>  
> @@ -114,7 +113,8 @@ static int update_avg_interval(struct ac
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_GAI",
>  				       NULL, &data);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _GAI"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_GAI",
> +					     status);
>  		return -ENODEV;
>  	}
>  
> @@ -166,7 +166,8 @@ static ssize_t set_avg_interval(struct d
>  	mutex_unlock(&resource->lock);
>  
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PAI"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PAI",
> +					     status);
>  		return -EINVAL;
>  	}
>  
> @@ -186,7 +187,8 @@ static int update_cap(struct acpi_power_
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_GHL",
>  				       NULL, &data);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _GHL"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_GHL",
> +					     status);
>  		return -ENODEV;
>  	}
>  
> @@ -237,7 +239,8 @@ static ssize_t set_cap(struct device *de
>  	mutex_unlock(&resource->lock);
>  
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _SHL"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_SHL",
> +					     status);
>  		return -EINVAL;
>  	}
>  
> @@ -270,7 +273,8 @@ static int set_acpi_trip(struct acpi_pow
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PTP",
>  				       &args, &data);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTP"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PTP",
> +					     status);
>  		return -EINVAL;
>  	}
>  
> @@ -322,7 +326,8 @@ static int update_meter(struct acpi_powe
>  	status = acpi_evaluate_integer(resource->acpi_dev->handle, "_PMM",
>  				       NULL, &data);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMM"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMM",
> +					     status);
>  		return -ENODEV;
>  	}
>  
> @@ -549,7 +554,8 @@ static int read_domain_devices(struct ac
>  	status = acpi_evaluate_object(resource->acpi_dev->handle, "_PMD", NULL,
>  				      &buffer);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMD"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMD",
> +					     status);
>  		return -ENODEV;
>  	}
>  
> @@ -745,7 +751,8 @@ static int read_capabilities(struct acpi
>  	status = acpi_evaluate_object(resource->acpi_dev->handle, "_PMC", NULL,
>  				      &buffer);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PMC"));
> +		acpi_evaluation_failure_warn(resource->acpi_dev->handle, "_PMC",
> +					     status);
>  		return -ENODEV;
>  	}
>  
> @@ -765,7 +772,9 @@ static int read_capabilities(struct acpi
>  
>  	status = acpi_extract_package(pss, &format, &state);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Invalid data"));
> +		dev_err(&resource->acpi_dev->dev, ACPI_POWER_METER_NAME
> +			"_PMC package parsing failed: %s\n",
> +			acpi_format_exception(status));
>  		res = -EFAULT;
>  		goto end;
>  	}
> 
> 
> 
