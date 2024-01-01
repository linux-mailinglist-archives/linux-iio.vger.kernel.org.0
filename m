Return-Path: <linux-iio+bounces-1366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE88213D4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 14:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233BE1F2137C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411223CE;
	Mon,  1 Jan 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYMP1g5b"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D33C28
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704115502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRZrJFbr3Dd/xeW2Mkwtk7Xcdee1MBYOVe6KE4SeXCc=;
	b=cYMP1g5bD65XxvcySwmDfSq+fKW8LooHo8RHDdx4PBJplcfRwNVaMLGd1uMTY51ypKLE1y
	x9obd5V0ywnxfyW3rzsJScfColFQwh9z9W4mzgVq4FwAeGvrcbyo1K+ez+NCkCQSVd+hNz
	djwjIb2zERT+eqZmXBApfRvfI54HKcc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-amn6spwRPlumHUfWgLHfuQ-1; Mon, 01 Jan 2024 08:25:01 -0500
X-MC-Unique: amn6spwRPlumHUfWgLHfuQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a26a0952fc5so455670166b.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2024 05:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704115500; x=1704720300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRZrJFbr3Dd/xeW2Mkwtk7Xcdee1MBYOVe6KE4SeXCc=;
        b=ZG9L+mw8QOPsgymqIDd9koxaM+9/JSsXeAWrer9Or/J3mSJEbapnYe/eY6ZUcxXoP2
         NycV6UhwixeVf1NNyaGKRFROwLsQJwtg6c3hP84tvyJU2esDJp2HzgzHWlGBugLK46P1
         9s+WSKR8O15gdyQ41F8xI4Aoc0cCOn1kIbmK4b2p5KHzRxSdT5UFe6v354K2xvVerrd2
         qDQ6Yz1euIdeuyeH5ZqPBOwTAQq6LKOy5gQSb2hntJ7lzuOLu9UkAg4/8WAFLHPtzNwP
         TdXJBB0OoaUkKYA4Muw52jq8Fw+Pd4vqB9Edo40S0lB+Q/RhpXmjbWm6uoz85vixe+fu
         PYuA==
X-Gm-Message-State: AOJu0Yy7Pr/RHBmWNCmk+Qjk8tIktplHtCe8+qdU/K9zE6n0yi+B/zxh
	R5Rvzhxpu41k6qWMcMzwhjohDCQ+aokUXW9fXIOeEu7vI+n7MoXNouOG+7I3LYeQ7Umt0XikeuN
	A5nxA+bLTpCnUEZ6Vp+1IyW7nd3XO
X-Received: by 2002:a17:906:f595:b0:a27:f465:298c with SMTP id cm21-20020a170906f59500b00a27f465298cmr1153269ejd.124.1704115500303;
        Mon, 01 Jan 2024 05:25:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpYZC0ZYxJ4u/XTMJJQqXo46DLvowKsdJdrMdyNwUw0c2GCOrzlFiyhT1qfOEF+sdHUv3lnA==
X-Received: by 2002:a17:906:f595:b0:a27:f465:298c with SMTP id cm21-20020a170906f59500b00a27f465298cmr1153267ejd.124.1704115500127;
        Mon, 01 Jan 2024 05:25:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b00a26a5f80d07sm4425951ejd.14.2024.01.01.05.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 05:24:59 -0800 (PST)
Message-ID: <e4a9f412-0fe9-49a7-8b05-fd7a62af4130@redhat.com>
Date: Mon, 1 Jan 2024 14:24:59 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] iio: accel: kxcjk-1013: Move acpi_device_id table
 under ifdef CONFIG_ACPI
Content-Language: en-US, nl
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231231183514.566609-1-jic23@kernel.org>
 <20231231183514.566609-3-jic23@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231231183514.566609-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/31/23 19:34, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This avoids a build warning due to the use of ACPI_PTR().
> Given the driver already has APCI specific code under CONFIG_ACPI move
> the table rather than removing the ACPI_PTR() call as we already
> have the complexity of CONFIG_ACPI.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/kxcjk-1013.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 894709286b0c..7f084f73da84 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -422,6 +422,23 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
>  	ACPI_FREE(obj);
>  	return 0;
>  }
> +
> +static const struct acpi_device_id kx_acpi_match[] = {
> +	{"KXCJ1013", KXCJK1013},
> +	{"KXCJ1008", KXCJ91008},
> +	{"KXCJ9000", KXCJ91008},
> +	{"KIOX0008", KXCJ91008},
> +	{"KIOX0009", KXTJ21009},
> +	{"KIOX000A", KXCJ91008},
> +	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
> +	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
> +	{"KXTJ1009", KXTJ21009},
> +	{"KXJ2109",  KXTJ21009},
> +	{"SMO8500",  KXCJ91008},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> +
>  #endif
>  
>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
> @@ -1687,22 +1704,6 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
>  			   kxcjk1013_runtime_resume, NULL)
>  };
>  
> -static const struct acpi_device_id kx_acpi_match[] = {
> -	{"KXCJ1013", KXCJK1013},
> -	{"KXCJ1008", KXCJ91008},
> -	{"KXCJ9000", KXCJ91008},
> -	{"KIOX0008", KXCJ91008},
> -	{"KIOX0009", KXTJ21009},
> -	{"KIOX000A", KXCJ91008},
> -	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
> -	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
> -	{"KXTJ1009", KXTJ21009},
> -	{"KXJ2109",  KXTJ21009},
> -	{"SMO8500",  KXCJ91008},
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> -
>  static const struct i2c_device_id kxcjk1013_id[] = {
>  	{"kxcjk1013", KXCJK1013},
>  	{"kxcj91008", KXCJ91008},


