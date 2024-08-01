Return-Path: <linux-iio+bounces-8131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350094497D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30E6282978
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B375170A3D;
	Thu,  1 Aug 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhR1bT/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E23BBE5;
	Thu,  1 Aug 2024 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508681; cv=none; b=DKV66gn6C52NDk/T7KEHwJAAcdc2E+PTaOdGHF3TuxLiKPmcLKSvw0TcBMZ8dKVEcXDlDD2l31fo13hZug3cOm+1S4mwwkba0OfwtDNZEbLm114ES/MTmDT/98l4xCJ+dy9mVfm+R8Dr2GR0L3yAvlj5f48zhSytF4HRBqI92Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508681; c=relaxed/simple;
	bh=HC/LAOMr7oeiXvzLAuHjUYrXFkJQ1pTg0sWwTGxaGxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIz9w5lfTL7vxAh/lA2ptON61+KqHUUdr4RF2Fmb6gkqRw7JQ52nwvemhofy04aUbMl2HyeFuafOkAa09HwWPayzCk/siwPJZVh64MLlN4dRREbRsQi374um7YWb714ZwXyGPhGh7pcebtT7wlwwFhdeIq3L5PgHxrAReHSJck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhR1bT/T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efaae7edfso7089495e87.2;
        Thu, 01 Aug 2024 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722508678; x=1723113478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6auF9SihaRv0NHeZgPwWgcp87LY5pPO2A6cg+JnSinA=;
        b=mhR1bT/TgbkBquW41ErqqBRF2NByflhqDwECgEMywjhKx5fI5VxyyYmE9awnHulkPJ
         VuI4E7CtH7/luqgekQEXgdfjMpavyFMFOYQhF8giYm8Tjerk1/YJ2G1h/AAnnF0+C/SY
         qZ7SMlMn06EOYrN7W97lTE+qTE7Qv6NiTAZA/BwRdBL/sw7O7ogyffYW7OHKtnKkCc/4
         wR0Uvji+54ZBz+n419zbThW+droLgtZevP1/xtPWAn1MQAQh8LrpNmkAhBT2Wh4FqKuL
         B3XYFGP1Lq0HiXe8ldRRvl97SCQ17jb0ybKQKrS+bkJtRzdGxxoA1VzmmhKHayi5udVZ
         qebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722508678; x=1723113478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6auF9SihaRv0NHeZgPwWgcp87LY5pPO2A6cg+JnSinA=;
        b=fH4EmSFZfKT26ARrTV5N3PW6DCuVlFG8a6Jp7l4813Zoqi1FuFBrpAKjglZeprLhCk
         K1tLqmSmdVWMoH2c5cPckvowudAOCmk87V53ausdAhu0wMrI6hVlL1QPgVJO0emD7vkw
         dG6CZvIGKHWuWDEGDcoYDMNX8P12xga/FMvxEzYtuICv0NLWd8mfR5zmNi8xqgd0OHdt
         DIz99Dcz9nXGEjXxycUJoWGjL6M7CivWHiv8cKAtOOkCoazLVa1MfjLvb01arLSLiSZh
         ziD6tXWaVYuPcZN/fR3tXMCG5mZogY/vgV5KA/sByvb1M4gJ80yH38vAsA92l6GDDHNx
         6HQA==
X-Forwarded-Encrypted: i=1; AJvYcCUt2/UzpKpyaP0A7dtA62Ic5s6c0e/mSwe29l1qj2GdvZsjfWUNHoFoRhdZ/GFYi+lrDoimNks1RAmobJUoSh0LfqGQtd4Uuuap5kPIOXVv9Cduwhupfv7Jg9Jw7gzyWYTAW6hBhn+zQR57LXjYtv9Ua2n3882bLx0GAlil6ktXGlLGWw==
X-Gm-Message-State: AOJu0YwbdVT3N+HYlq/FbnRYAKXd+EoWgRRa6TCxP1pml5/STP3nAJvu
	b9hShW4So7+JdUlyPtPf4Z9tS0uBNrzSJsjN2vdSCkJ+xB5TbPpP
X-Google-Smtp-Source: AGHT+IHUQDe91xXDzoxuK90Fn56g8aZCSk7RPm/BkRWjmCrRl2zyPkAPw1H4PF0CTu3AaisIzJvq9w==
X-Received: by 2002:a05:6512:b96:b0:52c:88d7:ae31 with SMTP id 2adb3069b0e04-530b61ebe2emr1506606e87.48.1722508677700;
        Thu, 01 Aug 2024 03:37:57 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad416d0sm875712766b.101.2024.08.01.03.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 03:37:57 -0700 (PDT)
Message-ID: <e7a4fdeb-e83b-4e0d-adb8-7ea58d6b1b7d@gmail.com>
Date: Thu, 1 Aug 2024 12:37:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] coresight: cti: use device_* to iterate over device
 child nodes
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
 <20240801-device_child_node_access-v1-1-ddfa21bef6f2@gmail.com>
 <381fd199-640a-4ca0-8d7e-1c4dae11ef7f@arm.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <381fd199-640a-4ca0-8d7e-1c4dae11ef7f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/08/2024 11:20, Suzuki K Poulose wrote:
> On 01/08/2024 07:13, Javier Carrasco wrote:
>> Drop the manual access to the fwnode of the device to iterate over its
>> child nodes. `device_for_each_child_node` macro provides direct access
>> to the child nodes, and given that they are only required within the
>> loop, the scoped variant of the macro can be used.
>>
>> Use the `device_for_each_child_node_scoped` macro to iterate over the
>> direct child nodes of the device.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/
>> drivers/hwtracing/coresight/coresight-cti-platform.c
>> index ccef04f27f12..d0ae10bf6128 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
>> @@ -416,20 +416,16 @@ static int
>> cti_plat_create_impdef_connections(struct device *dev,
>>                             struct cti_drvdata *drvdata)
>>   {
>>       int rc = 0;
>> -    struct fwnode_handle *fwnode = dev_fwnode(dev);
>> -    struct fwnode_handle *child = NULL;
>>   -    if (IS_ERR_OR_NULL(fwnode))
>> +    if (IS_ERR_OR_NULL(dev_fwnode(dev)))
>>           return -EINVAL;
>>   -    fwnode_for_each_child_node(fwnode, child) {
>> +    device_for_each_child_node_scoped(dev, child) {
>>           if (cti_plat_node_name_eq(child, CTI_DT_CONNS))
>> -            rc = cti_plat_create_connection(dev, drvdata,
>> -                            child);
>> +            rc = cti_plat_create_connection(dev, drvdata, child);
>>           if (rc != 0)
>>               break;
> 
> Don't we need to fwnode_handle_put(child) here, since we removed the
> outer one ?
> 
> Suzuki
> 

Hi Suzuki,

No, we don't need fwnode_handle_put(child) anymore because the scoped
variant of the macro is used.

Best regards,
Javier Carrasco

