Return-Path: <linux-iio+bounces-20740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7EADD02A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A191631E8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC7218E91;
	Tue, 17 Jun 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fdWASFvk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8B20AF62
	for <linux-iio@vger.kernel.org>; Tue, 17 Jun 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171274; cv=none; b=TdsjxwAvOVfX8n0aCSIRTLVM+Sc4y54oYS/6iGlECBxv9GrMVGjs79Ce4AG0CiwGQhLTZMSAXGGwdGZcwlAl2ZevtDSiHwBdk38bjLe8jklHDSdve1mWmsIjpZH+KX9+LYceWsyhth05QhTx8gjJQ7+ozr1BOrsM1d4V5jwfFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171274; c=relaxed/simple;
	bh=KytBL3RgIELtg2bC3Sk3C2iv6mWErtVHz8v9zBmBiI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQGiDJ8jEF6EyInnZSdUaPPvj30ApvpMFq8avipnjzkencaO9tDE3xO4NDkvzWEAUK/J8c+pXaS+9xgGVWG1/YRjyiKD/r6mG5ftKBNToDXmpJxz+SUf3r0woK9GhtER1Wx7Xjxuxq4xKAicPVbiQckzMk9s2tdgmOxhQB96oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fdWASFvk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so8865382a12.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Jun 2025 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1750171269; x=1750776069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS1rvP0TIcJOf4zhH6GncBI8z7cnZ2da/ITssjAxL+Q=;
        b=fdWASFvkGQFnFqedHQ33o2r/ZyCGrFfv1lr5O/PzCIOIHIn7fuUKrRuHOj5fpfAi6e
         KXdZyLmymFcmFynLtDTcnv8vYl6nuIOHES61qRlAgqBs5uPdKbv1WuyHJfMyGfjHfHB/
         nKu0hupTHxh7UrVW8pXpLeXuM2p0nP/5WHwCPkgAFNTU21qTySGEJLbwwHB7Cvseg0On
         toZkysC2RnRCByuL/htfutrSEMZUEjtdD7/rn8sJV2c2cS4UAHvNChdy15dbHDwLlO10
         qwu87kfbzhEIzr+mFLCqDi1Vl+0DNu8SPjT/i2jdFAxEY2mjC0O9t2+Cn1dqzQ1tUGE3
         SNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171269; x=1750776069;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jS1rvP0TIcJOf4zhH6GncBI8z7cnZ2da/ITssjAxL+Q=;
        b=vV2tP+ngiDXAtrTTzhBigTJXJ3S+amFPTUB9t8QUB6NQ/X5wgg6X3CvAg09X/xDwTh
         JkIDwar8K+rkdg2MBbo93063aPRZrTCsyswn7HyiuXwh6FPMR79InInwUXrbMTzki+px
         DQIH5QWhyE1GpL3giK7Tw+g0XsvMBE5tN3NHvJC5XeRVTk6mfcJQUrWPxu4xjYdu7r3S
         dIi6TSbKEZnioF/OEwnOULfDn/1gk6hEBpojbTFXbZET1m1fwhzcCD2zVRsUKmnYiyVf
         sUO0HMPC9Se9E2v74ETpzW+/vWcx2qdWfnYMyIRnxGE3/95j4ugPC/BJVO6fyLTdh3L1
         qmzA==
X-Forwarded-Encrypted: i=1; AJvYcCUjZNPnj1735QnqT3c4Rv+5QyOzNnd363fG9SVeGRqq/dtkx4ama3yVXaWa8kthwm2AtxzD5Bnylig=@vger.kernel.org
X-Gm-Message-State: AOJu0YygzxJo6UYTLU2pHlRydS7CpqED7egZOiWMat9GViPjznFIYcUB
	4OPUBoTbWk2g3n5w/71x1rfVvqty8422kFXvstOhaSEnuvHJ6dPsdBSCPB1Q34GWR9c=
X-Gm-Gg: ASbGnctYHQW2bxM3S0Wal/dbLEtBPjvZpaSslzzdpvvvJb/UjLKP39yCswz4NxX0jO/
	HkAD30IexNvbTPJA4PHxPDKSQb+gSUbbz7+QD8hgR0VfzI2Uc36RaA0iebbf6Wosfll+2eHABuc
	eyYNjbJm/US2JKduW21z6bVU+AWe65q4ggVuvtV013xyY6i9LI9M1qSB0dPSd1x3NsBtm2ehjsl
	8k9OlUHsOrQ809BDZfFmsV0YUGVZCYA8Y98E6wbokE0StWGoj2wI5mABwgkEibiNX02GYiX9laX
	7YoA+nh3/lG13ZW+M5cEWD2WieQQASf5faxYm/zuYMaOF2lmkIbCVCVhlZ8zPdo2YylbvMsqR6p
	SyFXmTg==
X-Google-Smtp-Source: AGHT+IF+3GyIe+nHDzRNJzAEWhYWk4iX7mofrTQBbnjUzhNdEvD74l/4QWZwUnDwU3CtkbwTc3tvxQ==
X-Received: by 2002:a17:907:3c83:b0:ad2:1b0e:bfe5 with SMTP id a640c23a62f3a-adfad2a1e9bmr1449421266b.7.1750171269056;
        Tue, 17 Jun 2025 07:41:09 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adff0e8574fsm282909866b.42.2025.06.17.07.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 07:41:08 -0700 (PDT)
Message-ID: <04a6c53c-8383-4496-b502-149bd261cfdb@tuxon.dev>
Date: Tue, 17 Jun 2025 17:41:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] PM: domains: Detach on device_unbind_cleanup()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, len.brown@intel.com,
 pavel@kernel.org, ulf.hansson@linaro.org, jic23@kernel.org,
 daniel.lezcano@linaro.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 linux-i2c <linux-i2c@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
 <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafael,

On 16.06.2025 20:14, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 3:54 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The dev_pm_domain_attach() function is typically used in bus code alongside
>> dev_pm_domain_detach(), often following patterns like:
>>
>> static int bus_probe(struct device *_dev)
>> {
>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>     struct bus_device *dev = to_bus_device(_dev);
>>     int ret;
>>
>>     // ...
>>
>>     ret = dev_pm_domain_attach(_dev, true);
>>     if (ret)
>>         return ret;
>>
>>     if (drv->probe)
>>         ret = drv->probe(dev);
>>
>>     // ...
>> }
>>
>> static void bus_remove(struct device *_dev)
>> {
>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>     struct bus_device *dev = to_bus_device(_dev);
>>
>>     if (drv->remove)
>>         drv->remove(dev);
>>     dev_pm_domain_detach(_dev);
>> }
>>
>> When the driver's probe function uses devres-managed resources that depend
>> on the power domain state, those resources are released later during
>> device_unbind_cleanup().
>>
>> Releasing devres-managed resources that depend on the power domain state
>> after detaching the device from its PM domain can cause failures.
>>
>> For example, if the driver uses devm_pm_runtime_enable() in its probe
>> function, and the device's clocks are managed by the PM domain, then
>> during removal the runtime PM is disabled in device_unbind_cleanup() after
>> the clocks have been removed from the PM domain. It may happen that the
>> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
>> If the driver specific runtime PM APIs access registers directly, this
>> will lead to accessing device registers without clocks being enabled.
>> Similar issues may occur with other devres actions that access device
>> registers.
>>
>> Add detach_power_off member to struct dev_pm_info, to be used later in
>> device_unbind_cleanup() as the power_off argument for
>> dev_pm_domain_detach(). This is a preparatory step toward removing
>> dev_pm_domain_detach() calls from bus remove functions. Since the current
>> PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach())
>> already set dev->pm_domain = NULL, there should be no issues with bus
>> drivers that still call dev_pm_domain_detach() in their remove functions.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v4:
>> - save dev->power.detach_power_off in dev_pm_domain_attach() and use
>>   it in device_unbind_cleanup() when detaching
>> - adjusted patch description
>>
>> Changes in v3:
>> - dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
>>   and use a single function devm_pm_domain_detach()
>>
>> Changes in v2:
>> - none; this patch is new
>>
>>  drivers/base/dd.c           | 2 ++
>>  drivers/base/power/common.c | 3 +++
>>  include/linux/pm.h          | 1 +
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index b526e0e0f52d..13ab98e033ea 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/wait.h>
>>  #include <linux/async.h>
>> +#include <linux/pm_domain.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pinctrl/devinfo.h>
>>  #include <linux/slab.h>
>> @@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *dev)
>>         dev->dma_range_map = NULL;
>>         device_set_driver(dev, NULL);
>>         dev_set_drvdata(dev, NULL);
>> +       dev_pm_domain_detach(dev, dev->power.detach_power_off);
>>         if (dev->pm_domain && dev->pm_domain->dismiss)
>>                 dev->pm_domain->dismiss(dev);
>>         pm_runtime_reinit(dev);
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index 781968a128ff..a8f302ed27a5 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>>         if (!ret)
>>                 ret = genpd_dev_pm_attach(dev);
>>
>> +       if (dev->pm_domain)
>> +               dev->power.detach_power_off = power_on;
> 
> I'm assuming that you have checked all of the users of
> dev_pm_domain_attach() and verified that the "power off" value is the
> same as the "power on" one for all of them.

In v2 it has been discussed to just mirror the power_on acquisition.

Double checking now, all the current users of dev_pm_domain_attach() follow
this rule, except the i2c bus. i2c powers on the domain conditionally:

https://elixir.bootlin.com/linux/v6.15.2/source/drivers/i2c/i2c-core-base.c#L575

and powers it off unconditionally:
https://elixir.bootlin.com/linux/v6.15.2/source/drivers/i2c/i2c-core-base.c#L638

Should we take this into account ?

Thank you,
Claudiu


> 
>> +
>>         return ret < 0 ? ret : 0;
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index f0bd8fbae4f2..dcbe2c1ef59b 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -720,6 +720,7 @@ struct dev_pm_info {
>>         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem. */
>>         void (*set_latency_tolerance)(struct device *, s32);
>>         struct dev_pm_qos       *qos;
>> +       bool                    detach_power_off:1;
> 
> Please put the new flag under #ifdef CONFIG_PM after memalloc_noio and
> comment it as "Owned by the driver core".

OK!

Thank you for your review,
Claudiu

> 
> Otherwise LGTM.
> 
>>  };
>>
>>  extern int dev_pm_get_subsys_data(struct device *dev);
>> --
>> 2.43.0
>>


