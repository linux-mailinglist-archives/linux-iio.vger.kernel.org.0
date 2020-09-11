Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A01266873
	for <lists+linux-iio@lfdr.de>; Fri, 11 Sep 2020 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKS7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Sep 2020 14:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgIKS7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Sep 2020 14:59:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1CC061757
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2020 11:59:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n18so8741339qtw.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2020 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtFkcRSfpEtZt+cz8ege3q6PVFBsfAVY0Avp5iD1800=;
        b=Djxi747G1E2VEhJLqSrXZBRk9BWsnExpasX9n7PBBueSuqy2dzKrBMQbnmSkxazfwU
         FM6kiZS43IOBcjuIUN3BXv7nXzm8M4Jma0QktASCL/0Y34iBvWoHbhKX43Lh+2G1KTSs
         MK8FcyIa+mxOsffpJxGRQDIWeruhbNFzC7pQ08Iqwi0TbRvtkDEjBWTNkYrAuo92LBaU
         1jGlUg7rkTEP25o1zmJvQRa3UpUPl/ryiOxvqvlh8g50QWTCaldwqq/0OXrjCTTVwYZy
         rhOqaax57fn6X7FWK9/3bo2Bht1cYF0NwxzXHh1q2K3kE0IOy0Q9SYO/vlQGMs8NM4zS
         qlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtFkcRSfpEtZt+cz8ege3q6PVFBsfAVY0Avp5iD1800=;
        b=UZyPcbtJK2p+IzF9yB18icNhAQCE8VIZ38Ug/tZRTY4PSrW4qAlNyVSzOo9wdbMFbz
         I2xxDU+bWFTv3Rk3swjs2K7Z633uPdUAv4PZ4e90WaqbWAVXRtVK3nizfQ7k3EbjSWqi
         vMmrurCWJly7ioz6piwiPeyjtOY6Rhpl3bVmGmaCeKCdPpuEwdeX4qaG2TXTMOh0u+KG
         5cdfxaRLGSlvSei2vtQB04Oacbj9dLeQfGUOt5rJobRLtJGMixedv4xWVF49Y1dC77Ci
         pta5CCDOL5qGSsMVilJraKCQ+fAZNBz/hX5GyhOZnDv/v91AYUu/YKYqqai990Vqe70V
         Pu5g==
X-Gm-Message-State: AOAM530r4+6llj7Xc8OO6XRdyg87Z690R12HHSrFCTe82slTfAF4B/fJ
        0Uw2B3FUlhiW+oU2njh1h8k0kdt4TaK3DQ==
X-Google-Smtp-Source: ABdhPJxbfgCKyJac/wTqrG5RYjeGm+EKkoWsQA0YfxqSjAUdp91ix3L+iZpwJjg81N3z/kaaDKiwAA==
X-Received: by 2002:ac8:3704:: with SMTP id o4mr3061362qtb.330.1599850782949;
        Fri, 11 Sep 2020 11:59:42 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id k6sm3669119qti.23.2020.09.11.11.59.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 11:59:42 -0700 (PDT)
Date:   Fri, 11 Sep 2020 20:59:31 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 34/38] iio:magn:ak8975: Drop of_match_ptr and ACPI_PTR
 protections.
Message-ID: <20200911185931.GA18362@ict14-OptiPlex-980>
References: <20200910173242.621168-1-jic23@kernel.org>
 <20200910173242.621168-35-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910173242.621168-35-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 06:32:38PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Both would result in only a small size saving.  For simplicity it
> is best to remove them.  I also wish to remove both these antipatterns
> from IIO.
>

Hi Jonathan and thank you!

I compiled and tested this patch on ak09911 so, for what is worth,

Acked-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Tested-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>

Best regards,
Jonathan

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 03d71f796177..0141ef3b6476 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> @@ -17,7 +18,6 @@
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <linux/gpio/consumer.h>
> -#include <linux/acpi.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -773,7 +773,6 @@ static const struct iio_info ak8975_info = {
>  	.read_raw = &ak8975_read_raw,
>  };
>  
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id ak_acpi_match[] = {
>  	{"AK8975", AK8975},
>  	{"AK8963", AK8963},
> @@ -785,7 +784,6 @@ static const struct acpi_device_id ak_acpi_match[] = {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
> -#endif
>  
>  static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  {
> @@ -1075,8 +1073,8 @@ static struct i2c_driver ak8975_driver = {
>  	.driver = {
>  		.name	= "ak8975",
>  		.pm = &ak8975_dev_pm_ops,
> -		.of_match_table = of_match_ptr(ak8975_of_match),
> -		.acpi_match_table = ACPI_PTR(ak_acpi_match),
> +		.of_match_table = ak8975_of_match,
> +		.acpi_match_table = ak_acpi_match,
>  	},
>  	.probe		= ak8975_probe,
>  	.remove		= ak8975_remove,
> -- 
> 2.28.0
> 
