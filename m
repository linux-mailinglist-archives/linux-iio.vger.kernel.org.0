Return-Path: <linux-iio+bounces-1365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E548213D3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80841C20AA6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965F23CE;
	Mon,  1 Jan 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1DqkqV/"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5953C32
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704115465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oyc257aE1sCvh0XKjFg9KgjQXoxqPeigT7iy1fdU6v8=;
	b=Y1DqkqV/FkJ9oRNOUAl3h4BbQx7VkzdwZOP9RirrHe03Erdu43uOQibHNFElY8OgTvFoAY
	dmJJCQd+MKNug4D26LTEnNC22FOO1VDlUWdwrTK6VAOt+K4LzahSC4gflO6DTFnInnCrUr
	Jt8R6l/Eugv2G62jRczzHRX01p14sL8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-iTtwQVzbMNWqSF6vACAjmg-1; Mon, 01 Jan 2024 08:24:24 -0500
X-MC-Unique: iTtwQVzbMNWqSF6vACAjmg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a28264afbd7so9435166b.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2024 05:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704115463; x=1704720263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyc257aE1sCvh0XKjFg9KgjQXoxqPeigT7iy1fdU6v8=;
        b=wec6qq3BEGL34H4LUIagat17P9LVo1x1nMjr2yysOPkxiz9rDJSNxjwhZD2jrHGHuG
         NV9m5oAtz0IR75ChmJrtsdSMDs3FXH5Xx2SEF9iGkk7thbStVZqX3/zzX+VZwldalG+D
         MLaPd0SDOpiLZCPrNjzYdqHKRhvpDpLjp2vdkeM8m6t18VGF3kMqbYXBluXRq+0+R3tq
         rwHFB50/OFTIE1kqkeoSUWqrqjIcbCkhL9fbEYelDtQLdy2fyl3SZISp2byfaAYDvBQU
         6C+aSmzIepGWyxQ2qvndvMDTlmuJGieqSDxXZ69RwBsw5uj1yjEZFhhkLvdro1nEDUju
         t0gw==
X-Gm-Message-State: AOJu0YyeRAn0b6xg+fhBADVUE6Gyfn0MvmqdzrYbITD4Co6S58kbHhFs
	RkwYoFUFDtSP6wqpar97NSFgjix5mo6vgZBRExJkkjnvDNCKgRKBFx9ynldlU9fy+kRShFG8NAg
	EdgKybowPFumeqWQMIIm78eMcLT8+
X-Received: by 2002:a17:906:f297:b0:a27:de45:6af4 with SMTP id gu23-20020a170906f29700b00a27de456af4mr1263112ejb.76.1704115463381;
        Mon, 01 Jan 2024 05:24:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4mKayfXbMz+45ICP63XuJ5Hn3wiIwidrnYZEU+ZQ5dkvZh213JKj7kdIbvR1Dp/ImQRjQVw==
X-Received: by 2002:a17:906:f297:b0:a27:de45:6af4 with SMTP id gu23-20020a170906f29700b00a27de456af4mr1263111ejb.76.1704115463127;
        Mon, 01 Jan 2024 05:24:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b00a26a5f80d07sm4425951ejd.14.2024.01.01.05.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 05:24:22 -0800 (PST)
Message-ID: <30535e5d-568a-47b6-84d6-3f4d570fa45a@redhat.com>
Date: Mon, 1 Jan 2024 14:24:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] iio: accel: da280: Stop using ACPI_PTR()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 kernel test robot <lkp@intel.com>
References: <20231231183514.566609-1-jic23@kernel.org>
 <20231231183514.566609-2-jic23@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231231183514.566609-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/31/23 19:34, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In general using ACPI_PTR() leads to more fragile code for a very
> minor saving in storage in the case of !CONFIG_ACPI so in IIO we
> prefer not to use it if the only ACPI specific code is the acpi_device_id
> table.
> 
> In this case will also suppress a unused variable warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302142222.vVU0E4eu-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/da280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 572bfe9694b0..d792d2d20344 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -186,7 +186,7 @@ MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
>  static struct i2c_driver da280_driver = {
>  	.driver = {
>  		.name = "da280",
> -		.acpi_match_table = ACPI_PTR(da280_acpi_match),
> +		.acpi_match_table = da280_acpi_match,
>  		.pm = pm_sleep_ptr(&da280_pm_ops),
>  	},
>  	.probe		= da280_probe,


