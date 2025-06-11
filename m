Return-Path: <linux-iio+bounces-20415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB00AD4F73
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E98F7A1CE9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2E255F25;
	Wed, 11 Jun 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kvJCsUXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7013A3F2
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633089; cv=none; b=pkZcjY2IrsyUgnX0SFENm/+zgiXu4lO5lqKcg3lCmMo3h9fv/859hFIl+CyVORS7YYh7nVO5YY3aruUPeLQVbYNsnFtJSLc1a11tymD1i+G+RGFYtBuZze8eWT1MLGzAQ52AYld8KyHUwZgULLuezQp59m8fVnh4gENwywombGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633089; c=relaxed/simple;
	bh=svnshkck4Z/6Otk3WH/zhHTAY/iPBFU71gzx4y6fQ7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BG9c2mMGWCoFAPgSjdQv108PLefFeOTVpUveRhOYPSl3TlxAVsywjuozNjdyYIKIWTPoFN+E8sGEbTi/SkcRHVSwqIJSQ+QgjxJrQCCGVP0pkq1clWH17Zjwjq9P9J47D2zXOsZx4OK78ZXbOEKXBbMMBcxAlb+AyRftQvNzRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kvJCsUXa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so447890566b.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749633085; x=1750237885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9so2D1SFcGeC3ZBssCRYBd2vbdhM7v92BxxUWR2mkU=;
        b=kvJCsUXaucvm3CkYxyGTQuYnJlVGW/P2jNgDNN77hsbMlq5r5pNusHHB8IFzCLcXui
         GrMDz4apQn8hLWohB8cGhhg2e/HaUubJ83zjpZnP0kXlzJ1sAND49EO89RSndUJz2gCy
         29Qh1Hb4yau4R5U/oKoDVLJrg2P6vrvXwdne+HAkVu8PCT25SxNd20jFrurYeq2oAOpX
         xuaNdgEaaStWaL3zUxLRjGSuJxDuOcwKBsRMkNLQOiAUGfsf2wZD93sQsBYwMTHhBHeL
         TFpny7YKZtJ3j0N9i8urFCsLbLZsujvQEF+DREzLiP+XLctZqxPJ1k5bbWBgXchtb+rH
         t9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749633085; x=1750237885;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9so2D1SFcGeC3ZBssCRYBd2vbdhM7v92BxxUWR2mkU=;
        b=hz0LWc3FoJeJQoNBGY9MKK4fgbzwGBMnj2lke4nszmlQzPmCbSL+Qe/S5WijitB2gN
         a2t0uv5gguPcWVjr8WuLGFj3rpzmEu0SwwppqHo+Z29DB28yzh5mLESGRKs7qzQWPBQ9
         zt+OKZNiAxuG6eF4mbW0cQ65ZmDwXcqnH+rhWTlTDT/jk6M5ljqVYn4AaHCvYMsbScbp
         NUCJlrbUVRxyziX4WCYr7Q/ESzhM6xzSTUr6ej/hCjbDVFh+LX96qLKVyJ8NARxng8qF
         wGrVnx8+83YMhWkFdQz5upTXslvB+VPeGZoToNrp5Zea5p4Lvp/fZJZOYPxgkK98vQEp
         Um+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8LYQMwTVl4TWHAcNnMQ4HMaxiVYpURVZey35EErTpKHbVeLa0SZbB22bthtCIsDrhcb1eN59+DVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIfspkjywhtJzPt9aT04pDtmTpV8d3rcmsg/Zldvbni7PVP/H
	cF4JdxIVTbu6xreToJ4+jA9ATc62wcMhy5XUYB5i+4RqXnT0aPDRJII5DE3sLSO0QEiItScySjS
	SbVjo
X-Gm-Gg: ASbGnct5CMlvflfgzyXiAYM7utPPkCP2iSJbm7aoVDwLVOMMgpKvTvKtFMfR8gxfYRK
	EWWuTTpk2p1aE9GHy4zTpgra/eacyaCeQ7DJYcK/ftSkOuQt958Y6zdo1CXyog9p1B+4zMzt4ad
	VBhoSHKtd7TsQfgbeDFsP97OGwk24aTng+HEca9j9Zd1IqqlbbmVefqrNJKKRgP7UtdHN2NeN+n
	CvSUk0tvFjqjF+7uP/6ZDtETzUyIXVXDbcM8wY6YDs4msbTDVNMnhMlkJXUAdsQHS+1XlItCLjh
	SHON+uppgkLgCzE7fOeW7vev2cRs1aq3OE75F1L71K/FbR4fZ548Vz2tjBggoibyoYDk3GE=
X-Google-Smtp-Source: AGHT+IEvOSlxHoXGncKzxzRqRXyipVGyqcvO/ntMV8/CABeJ/b3ILPHrv+DfGj4vZCTUe7oABVL/0w==
X-Received: by 2002:a17:907:97d1:b0:adb:413e:2a2f with SMTP id a640c23a62f3a-ade893db39fmr225242366b.9.1749633070215;
        Wed, 11 Jun 2025 02:11:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607ef848c27sm3966519a12.38.2025.06.11.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 02:11:09 -0700 (PDT)
Message-ID: <84a0e4bf-cb65-4b6e-93d7-48ac3ba06b0f@tuxon.dev>
Date: Wed, 11 Jun 2025 12:11:08 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org,
 dakr@kernel.org, len.brown@intel.com, pavel@kernel.org,
 ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com,
 geert@linux-m68k.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei>
 <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafael,

On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> On Sat, Jun 7, 2025 at 3:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Fri, 6 Jun 2025 22:01:52 +0200
>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>
>> Hi Rafael,
>>
>>> On Fri, Jun 6, 2025 at 8:55 PM Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>>>
>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
>>>>> On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>>
>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>>
>>>>>> The dev_pm_domain_attach() function is typically used in bus code alongside
>>>>>> dev_pm_domain_detach(), often following patterns like:
>>>>>>
>>>>>> static int bus_probe(struct device *_dev)
>>>>>> {
>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>     int ret;
>>>>>>
>>>>>>     // ...
>>>>>>
>>>>>>     ret = dev_pm_domain_attach(_dev, true);
>>>>>>     if (ret)
>>>>>>         return ret;
>>>>>>
>>>>>>     if (drv->probe)
>>>>>>         ret = drv->probe(dev);
>>>>>>
>>>>>>     // ...
>>>>>> }
>>>>>>
>>>>>> static void bus_remove(struct device *_dev)
>>>>>> {
>>>>>>     struct bus_driver *drv = to_bus_driver(dev->driver);
>>>>>>     struct bus_device *dev = to_bus_device(_dev);
>>>>>>
>>>>>>     if (drv->remove)
>>>>>>         drv->remove(dev);
>>>>>>     dev_pm_domain_detach(_dev);
>>>>>> }
>>>>>>
>>>>>> When the driver's probe function uses devres-managed resources that depend
>>>>>> on the power domain state, those resources are released later during
>>>>>> device_unbind_cleanup().
>>>>>>
>>>>>> Releasing devres-managed resources that depend on the power domain state
>>>>>> after detaching the device from its PM domain can cause failures.
>>>>>>
>>>>>> For example, if the driver uses devm_pm_runtime_enable() in its probe
>>>>>> function, and the device's clocks are managed by the PM domain, then
>>>>>> during removal the runtime PM is disabled in device_unbind_cleanup() after
>>>>>> the clocks have been removed from the PM domain. It may happen that the
>>>>>> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
>>>>>
>>>>> Don't use devm_pm_runtime_enable() then.
>>>>
>>>> What about other devm_ APIs? Are you suggesting that platform drivers
>>>> should not be using devm_clk*(), devm_regulator_*(),
>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
>>>> dev_pm_domain_detach() that is called by platform bus_remove() may shut
>>>> off the device too early, before cleanup code has a chance to execute
>>>> proper cleanup.
>>>>
>>>> The issue is not limited to runtime PM.
>>>>
>>>>>
>>>>>> If the driver specific runtime PM APIs access registers directly, this
>>>>>> will lead to accessing device registers without clocks being enabled.
>>>>>> Similar issues may occur with other devres actions that access device
>>>>>> registers.
>>>>>>
>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
>>>>>> device is detached from its PM domain in device_unbind_cleanup(), only
>>>>>> after all driver's devres-managed resources have been release.
>>>>>>
>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 state
>>>>>> arguments, one for the domain state on attach, one for the domain state on
>>>>>> detach.
>>>>>
>>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced at
>>>>
>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?
>>>
>>> Yes, among other things.
>>
>> Maybe naming could make abuse at least obvious to spot? e.g.
>> pm_domain_attach_with_devm_release()
> 
> If I'm not mistaken, it is not even necessary to use devres for this.
> 
> You might as well add a dev_pm_domain_detach() call to
> device_unbind_cleanup() after devres_release_all().  There is a slight
> complication related to the second argument of it, but I suppose that
> this can be determined at the attach time and stored in a new device
> PM flag, or similar.

I can try this as well.

Another option I see at the moment would be keep the code added in
drivers/base/power/common.c in drivers/base/platform.c, something like:

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 075ec1d1b73a..391d725cd4c7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1376,10 +1376,18 @@ static int platform_uevent(const struct device
*dev, struct kobj_uevent_env *env
        return 0;
 }

+static void platform_dev_pm_domain_detach(struct device *dev, void *res)
+{
+       bool *power_off = res;
+
+       dev_pm_domain_detach(dev, *power_off);
+}
+
 static int platform_probe(struct device *_dev)
 {
        struct platform_driver *drv = to_platform_driver(_dev->driver);
        struct platform_device *dev = to_platform_device(_dev);
+       bool *power_off;
        int ret;

        /*
@@ -1396,15 +1404,22 @@ static int platform_probe(struct device *_dev)
        if (ret < 0)
                return ret;

+       power_off = devres_alloc(platform_dev_pm_domain_detach,
sizeof(*power_off),
+                                GFP_KERNEL);
+       if (!power_off)
+               return -ENOMEM;
+
        ret = dev_pm_domain_attach(_dev, true);
-       if (ret)
+       if (ret) {
+               devres_free(power_off);
                goto out;
+       }

-       if (drv->probe) {
+       *power_off = true;
+       devres_add(_dev, power_off);
+
+       if (drv->probe)
                ret = drv->probe(dev);
-               if (ret)
-                       dev_pm_domain_detach(_dev, true);
-       }

 out:
        if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
@@ -1422,7 +1437,6 @@ static void platform_remove(struct device *_dev)

        if (drv->remove)
                drv->remove(dev);
-       dev_pm_domain_detach(_dev, true);
 }

but this would involve duplicating code, as, sooner or later, this would
have to be done for other busses as well.

Could you please let me know what option would you prefer so that I can go
forward with it?

Thank you for your review,
Claudiu

> 
> Note that dev->pm_domain is expected to be cleared by ->detach(), so
> this should not cause the domain to be detached twice in a row from
> the same device, but that needs to be double-checked.
> 
> Thanks!


