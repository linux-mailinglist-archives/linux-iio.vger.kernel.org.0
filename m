Return-Path: <linux-iio+bounces-14587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B26A1D259
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E7F1886D29
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249501FC7ED;
	Mon, 27 Jan 2025 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PbgrYgy1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC181482E8
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966619; cv=none; b=hCxp0T3EkqcHfs7aWYE/gj22co2NmTE08O45yYJWj9xQzmwQVwYmq99tBWvBelcTWmquiZDhzBQBZbNj59l+jTW7DBowMenppcEF/kqmaKwAqpngAc6BHXoLMo6XgssztdzVQFBuCrIdRxYJYX3Txx8oc0ccK4aoV2UjE21pYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966619; c=relaxed/simple;
	bh=LqNebdlE143vCPVR3xrmfrvlbCZc0xwKrI1HIck2YJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxpqtlsmphEjBLZ2AID5e5FW7nq4X/dgIVDJ6BMDHEIrTY3ahbEF6jC7Cmszil8CFouwLtCiwX1M2gQx41kbyH9R16BcEEUBv9203u2zZWMUqWn5629Hfd5ghE2O4vBvs1zcPMlD1XFlHUFIMRFscTCKzFVLnoIKyraixqYNOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PbgrYgy1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de9f789cso3322200f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737966615; x=1738571415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEHFERE09Xp5Xr/uNjn8nnOWWZSs/fasi83rKdEoZsg=;
        b=PbgrYgy1WvHyiWQqabCoaAV56IB7mIhxyrP49g2z1zQcl3kFsVehcjM0AyOiAALlKt
         BxM/pIlg4H98Q+5w4DeJgcbd1XZRFZjWqnnNVjYhY8Nk4WMNDWK9KAuvoZjfzjpD4hCL
         0CEYvkl4dEN69GvKTCewY+KTyrK7z3LA/vnrUak4EjZ5kIucdFLUujzQ2CRQOQ6x0Bpk
         aOSvFe+LvICHT1Nuxf1e5r2NtI6n+zBu3XSaU8ojvPHM3qpI3Qg6HfmiaywNoEBJYC/a
         w3FBVCgb2LIz3rtlh5/+0qbytrPuL7Mfs22NQ+fIwwqKl1YfvBPfVA2rkBm0jyG254wj
         r5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737966615; x=1738571415;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEHFERE09Xp5Xr/uNjn8nnOWWZSs/fasi83rKdEoZsg=;
        b=tXhillTuG2alamNtX9nlHy/IZZ+RniOjuLDObChjYmnFxuOO5yJprzjOkrFtOi6v0V
         jIoBrV5GEFE5DYJoLezngor0D1vVqRVlRSflw3wrzo4rLBurEyEp1N7+NQgmrPSCyvbt
         Gqclj/2BFFuvGCwtsBSWNmIPnrNijMc0tfpdnXoa9Qd5sWUHEbd1rsZTJgS9RVdS+elG
         zA7StFAq595750qX4C4kq6Y1huksZLvMCczg5/E+IsUy/6Vs9Ti93bUprqP0uJNKgfSb
         JCNJHj2OwHBNAl7AXbQqQXEyq0gWYVjL+7p6l96NWq0n59VdUlKs45umZXHKEcshpqB/
         m32g==
X-Forwarded-Encrypted: i=1; AJvYcCV0DJW5SS4pJuW4tf1G2upFMl3lSk1vMcERg6Xwj2g1hhajWCuShI6cIH43r4tcMvBeKa/lzN/A3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYljE98+WxS/wnaIkhLh6OHv384vrgtMFaDtqsSzN8xZtAcxs3
	lFB4WcvyKNBBd88+57/kj2L38fGL96lfTStkSM1i6yMHBdxnBzddMvsupSbnGcg=
X-Gm-Gg: ASbGncuj+HP5/KjUPesYf+zYW1V+FmSsUowJY2vIKhkqVYb26zlJB1Brmvaet9yhOKi
	lQGqbYPxZAZHdxZ/Od6hh1yIl9Ih7Lt7caBFXZ1IZZuOD0F8QjlneVdD01peLTgdd39AVVkbXvI
	8aOuB87OhFyFdghfrhR3EDdd213VbYFgF2gzylkpXQfZOAmG/jpKSx4mk1d87JQq9+l0W2mGcWu
	/VQcPCOnFwXQhOa2uabl8OGUqQeT+HruRkxNCSjUR/7Q/tK1PkmlkAqYRDl8OdPNYADxbcrS8wt
	F0CC2sG9XTp5
X-Google-Smtp-Source: AGHT+IEr3SIjzF2zKwK7YnjcVuE8CQ97RigDsqJuf3KomFa88BVtVRDNzVZqBI3KaC1pwW/IDGpY+Q==
X-Received: by 2002:a5d:6d86:0:b0:385:faf5:eba6 with SMTP id ffacd0b85a97d-38bf5655a3dmr32506854f8f.1.1737966613598;
        Mon, 27 Jan 2025 00:30:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1764c8sm10171406f8f.3.2025.01.27.00.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:30:13 -0800 (PST)
Message-ID: <c3965aa0-252b-42c4-90d9-ac8a6f9123a7@tuxon.dev>
Date: Mon, 27 Jan 2025 10:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
 <20250104135225.2573285b@jic23-huawei>
 <44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
 <20250111131409.36bebfd3@jic23-huawei>
 <bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
 <CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
 <20250117155226.00002691@huawei.com>
 <CAPDyKFpQUMOFtA-QCbYdaeKSDGJpnjcA+tiKZ=kzmrjYRtFZdw@mail.gmail.com>
 <20250124184137.0000047a@huawei.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250124184137.0000047a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24.01.2025 20:41, Jonathan Cameron wrote:
> On Mon, 20 Jan 2025 15:59:02 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
>> On Fri, 17 Jan 2025 at 16:52, Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>>
>>> On Wed, 15 Jan 2025 16:29:15 +0100
>>> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>  
>>>> On Wed, 15 Jan 2025 at 14:37, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:  
>>>>>
>>>>> Hi, Jonathan,
>>>>>
>>>>> Thank you for your input!
>>>>>
>>>>> On 11.01.2025 15:14, Jonathan Cameron wrote:  
>>>>>> On Mon, 6 Jan 2025 11:18:41 +0200
>>>>>> Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>>>>  
>>>>>>> Hi, Jonathan,
>>>>>>>
>>>>>>>
>>>>>>> On 04.01.2025 15:52, Jonathan Cameron wrote:  
>>>>>>>> On Fri,  3 Jan 2025 16:00:41 +0200
>>>>>>>> Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>>>>  
>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>  
>>>>>>>> +CC Rafael and linux-pm
>>>>>>>>  
>>>>>>>>>
>>>>>>>>> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
>>>>>>>>> of a PM domain. The code that implements the PM domains support is in
>>>>>>>>> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
>>>>>>>>> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
>>>>>>>>> domains support is registered with GENPD_FLAG_PM_CLK which, according to
>>>>>>>>> the documentation, instructs genpd to use the PM clk framework while
>>>>>>>>> powering on/off attached devices.
>>>>>>>>>
>>>>>>>>> During probe, the ADC device is attached to the PM domain
>>>>>>>>> controlling the ADC clocks. Similarly, during removal, the ADC device is
>>>>>>>>> detached from the PM domain.
>>>>>>>>>
>>>>>>>>> The detachment call stack is as follows:
>>>>>>>>>
>>>>>>>>> device_driver_detach() ->
>>>>>>>>>   device_release_driver_internal() ->
>>>>>>>>>     __device_release_driver() ->
>>>>>>>>>       device_remove() ->
>>>>>>>>>         platform_remove() ->
>>>>>>>>>           dev_pm_domain_detach()
>>>>>>>>>
>>>>>>>>> During driver unbind, after the ADC device is detached from its PM domain,
>>>>>>>>> the device_unbind_cleanup() function is called, which subsequently invokes
>>>>>>>>> devres_release_all(). This function handles devres resource cleanup.
>>>>>>>>>
>>>>>>>>> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
>>>>>>>>> triggers the action or reset function for disabling runtime PM. This
>>>>>>>>> function is pm_runtime_disable_action(), which leads to the following call
>>>>>>>>> stack of interest when called:
>>>>>>>>>
>>>>>>>>> pm_runtime_disable_action() ->
>>>>>>>>>   pm_runtime_dont_use_autosuspend() ->  
>>>>>>>>
>>>>>>>> So is the only real difference that in the code below you disable runtime pm
>>>>>>>> before autosuspend?  
>>>>>>>
>>>>>>> No, the difference is that now, the driver specific runtime PM APIs are not
>>>>>>> called anymore (through the pointed call stack) after the ADC was removed
>>>>>>> from it's PM domain.  
>>>>>>
>>>>>> By my reading they are only not called now because you turn autosuspend off
>>>>>> after disabling runtime PM.  
>>>>>
>>>>> Sorry, I wanted to say that the runtime PM APIs are not called anymore from
>>>>> devm_action_release(), though this call stack:
>>>>>
>>>>> [   24.801195] Call trace:
>>>>> [   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
>>>>> [   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
>>>>> [   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
>>>>> [   24.818580]  __rpm_callback+0x48/0x198
>>>>> [   24.822319]  rpm_callback+0x68/0x74
>>>>> [   24.825798]  rpm_suspend+0x100/0x578
>>>>> [   24.829362]  rpm_idle+0xd0/0x17c
>>>>> [   24.832582]  update_autosuspend+0x30/0xc4
>>>>> [   24.836580]  pm_runtime_disable_action+0x40/0x64
>>>>> [   24.841184]  devm_action_release+0x14/0x20
>>>>> [   24.845274]  devres_release_all+0xa0/0x100
>>>>> [   24.849361]  device_unbind_cleanup+0x18/0x60
>>>>>
>>>>> This is because I dropped the devm_pm_runtime_enable() which registers the
>>>>> pm_runtime_disable_action(), which is called at the time the
>>>>> device_unbind_cleanup() is called, which is called when the ADC is not
>>>>> anymore part of its PM domain.
>>>>>
>>>>> If I change the order in remove function proposed in this patch, thus do:
>>>>>
>>>>> +static void rzg2l_adc_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +       struct device *dev = &pdev->dev;
>>>>> +
>>>>> +       pm_runtime_dont_use_autosuspend(dev);
>>>>> +       pm_runtime_disable(dev);
>>>>>  }
>>>>>
>>>>> nothing changes with the behavior of this patch. There will be no issue if
>>>>> the device is runtime suspended/resumed through the
>>>>> pm_runtime_dont_use_autosuspend() because at the time the
>>>>> rzg2l_adc_remove() is called the ADC is still part of the PM domain.
>>>>>
>>>>>
>>>>>  
>>>>>>  
>>>>>>>
>>>>>>>  
>>>>>>>>  Can you still do that with a devm callback just not
>>>>>>>> the standard one?  
>>>>>>>
>>>>>>> No. It doesn't matter if we call the standard devm callback or driver
>>>>>>> specific one. As long as it is devm it will impact us as long as the driver
>>>>>>> specific runtime PM APIs are called through devres_release_all() after
>>>>>>> dev_pm_domain_detach(). And at that time the PM domain may be off along
>>>>>>> with its clocks disabled.  
>>>>>>
>>>>>> As above, I think that this is only the case because of the reordering
>>>>>> of those two calls, not something more fundamental.  
>>>>>
>>>>> I tried having a local devm function (the following diff applied with this
>>>>> patch reverted) identical with pm_runtime_disable_action():
>>>>>
>>>>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>>>>> index 22a581c894f8..459cc9c67eec 100644
>>>>> --- a/drivers/iio/adc/rzg2l_adc.c
>>>>> +++ b/drivers/iio/adc/rzg2l_adc.c
>>>>> @@ -423,6 +423,12 @@ static int rzg2l_adc_hw_init(struct device *dev,
>>>>> struct rzg2l_adc *adc)
>>>>>         return ret;
>>>>>  }
>>>>>
>>>>> +static void rzg2l_pm_runtime_disable(void *data)
>>>>> +{
>>>>> +       pm_runtime_dont_use_autosuspend(data);
>>>>> +       pm_runtime_disable(data);
>>>>> +}
>>>>> +
>>>>>  static int rzg2l_adc_probe(struct platform_device *pdev)
>>>>>  {
>>>>>         struct device *dev = &pdev->dev;
>>>>> @@ -463,7 +469,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>>>>
>>>>>         pm_runtime_set_autosuspend_delay(dev, 300);
>>>>>         pm_runtime_use_autosuspend(dev);
>>>>> -       ret = devm_pm_runtime_enable(dev);
>>>>> +       pm_runtime_enable(dev);
>>>>> +
>>>>> +       ret = devm_add_action_or_reset(dev, rzg2l_pm_runtime_disable, dev);
>>>>>         if (ret)
>>>>>                 return ret;
>>>>>
>>>>> With this the issue is still reproducible.
>>>>>
>>>>> However, changing the order of functions in rzg2l_pm_runtime_disable() and
>>>>> having it like:
>>>>>
>>>>> +static void rzg2l_pm_runtime_disable(void *data)
>>>>> +{
>>>>> +       pm_runtime_disable(data);
>>>>> +       pm_runtime_dont_use_autosuspend(data);
>>>>> +}
>>>>>
>>>>>
>>>>> leads to no failure when doing unbind/bind.
>>>>>
>>>>> However, I see the pm_runtime_disable() can still call rpm_resume() under
>>>>> certain conditions. It can still lead to failures if it is called after the
>>>>> device was remove from its PM domain.
>>>>>  
>>>>>>
>>>>>> In driver remove flow, device_unbind_cleanup9() is called
>>>>>> just after device_remove() which is calling the dev->driver_remove()
>>>>>> callback. There are no runtime pm related calls in between that I can see.  
>>>>>
>>>>> On my side the device_remove() is calling dev->bus->remove() which is
>>>>> platform_remove(), which calls the dev_pm_domain_detach(). The
>>>>> dev_pm_domain_detach() detaches the ADC from it's PM domain. Because of
>>>>> this, accessing now the ADC registers after a runtime resume leads to
>>>>> failures pointed in this patch (as of my investigation) (as the ADC is not
>>>>> anymore part of its PM domain and its PM domain is not started anymore
>>>>> though runtime PM APIs).
>>>>>
>>>>> A similar issue was found while I was adding thermal support for RZ/G3S,
>>>>> explained in
>>>>> https://lore.kernel.org/all/20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com
>>>>>
>>>>>
>>>>> Jonathan, Rafael, Ulf, all,
>>>>>
>>>>> Do consider OK to change the order in pm_runtime_disable_action() to get
>>>>> rid of these issues, e.g.:
>>>>>
>>>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>>>> index 2ee45841486b..f27d311d2619 100644
>>>>> --- a/drivers/base/power/runtime.c
>>>>> +++ b/drivers/base/power/runtime.c
>>>>> @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
>>>>>
>>>>>  static void pm_runtime_disable_action(void *data)
>>>>>  {
>>>>> -       pm_runtime_dont_use_autosuspend(data);
>>>>>         pm_runtime_disable(data);
>>>>> +       pm_runtime_dont_use_autosuspend(data);
>>>>>  }
>>>>>
>>>>> though I see a rpm_resume() call is still possible though pm_runtime_disable().  
>>>>
>>>> I am still worried about keeping the device runtime enabled during a
>>>> window when we have turned off all resources for the device. Typically
>>>> we want to leave the device in a low power state after unbind.
>>>>
>>>> That said, I would rather just drop the devm_pm_runtime_enable() API
>>>> altogether and convert all users of it into
>>>> pm_runtime_enable|disable(), similar to what your patch does.  
>>>
>>> That is making a mess of a lot of automated cleanup for a strange
>>> runtime pm related path.  This is pain a driver should not have
>>> to deal with, though I'm not clear what the right solution is!
>>>
>>> Key is that drivers should not mix devm managed cleanup and not, so
>>> that means that anything that happens after runtime pm is enabled
>>> has to be torn down manually.  One solution to this might be to
>>> always enable it late assuming that is safe to do so there is
>>> never anything else done after it in the probe path of a driver.  
>>
>> The problem is that runtime PM isn't really comparable to other
>> resources that we are managing through devm* functions.
>>
>> Enabling runtime PM for a device changes the behaviour for how
>> power-mgmt is handled for the device. Enabling/disabling of runtime PM
>> really needs to be explicitly controlled by the driver for the device.
> 
> I'm sorry to say I'm not yet convinced.
> 
> Devm callbacks are explicitly registered by the driver so that they
> are unwound in a specific order.  Many other parts of driver
> registration rely on this ordering.  This does not seem different
> for runtime PM than anything else.
> 
> Superficially the issue here looks to me to be that a non devm
> cleanup is inserted by the bus->remove() callback into drivers
> that are otherwise relying on explicit ordering provided
> by managed cleanup.
> 
> I appreciate there may be no trivial solution.
> 
> Maybe we can minimize that impact by always doing runtime pm last
> in any probe() function?  Can that work here?

It will not work, AFAICT. E.g., some hardware need initialization before,
e.g., registering a device for it in the proper subsystem. Runtime PM may
help with enabling, e.g., clocks, for that hardware initialization to work.

> 
> 
>>
>> If there are cleanups to be made for runtime PM, beyond disabling
>> runtime PM, we could instead consider adding that code in
>> pm_runtime_reinit().
> 
> I'm not familiar enough to comment on this option beyond it being
> after devres_release_all() so, maybe?  It seems superficially
> a better point in the sequence.

I only need disabling runtime PM in my usecase.

One thing that I've experimented with is to drop the dev_pm_domain_detach()
call from platform_remove() and add it in device_unbind_cleanup(). I
checked with this diff:

1/

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..e658c2d642be 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -544,6 +544,7 @@ static ssize_t state_synced_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(state_synced);

+extern void dev_pm_domain_detach(struct device *dev, bool power_off);
 static void device_unbind_cleanup(struct device *dev)
 {
        devres_release_all(dev);
@@ -554,6 +555,7 @@ static void device_unbind_cleanup(struct device *dev)
        dev_set_drvdata(dev, NULL);
        if (dev->pm_domain && dev->pm_domain->dismiss)
                dev->pm_domain->dismiss(dev);
+       dev_pm_domain_detach(dev, true);
        pm_runtime_reinit(dev);
        dev_pm_set_driver_flags(dev, 0);
 }
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c52..bf2f8d39d184 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1422,7 +1422,6 @@ static void platform_remove(struct device *_dev)

        if (drv->remove)
                drv->remove(dev);
-       dev_pm_domain_detach(_dev, true);
 }

And also, with this one:

2/

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..216d765fbfcd 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -544,9 +544,11 @@ static ssize_t state_synced_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(state_synced);

+extern void dev_pm_domain_detach(struct device *dev, bool power_off);
 static void device_unbind_cleanup(struct device *dev)
 {
        devres_release_all(dev);
+       dev_pm_domain_detach(dev, true);
        arch_teardown_dma_ops(dev);
        kfree(dev->dma_range_map);
        dev->dma_range_map = NULL;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c52..bf2f8d39d184 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1422,7 +1422,6 @@ static void platform_remove(struct device *_dev)

        if (drv->remove)
                drv->remove(dev);
-       dev_pm_domain_detach(_dev, true);
 }

Both of these work on my side (when doing continuous unbind/bind) but I'm
not sure what are the implications of it. If all good, maybe we can add a
devm helper for dev_pm_domain_attach() and use it in platform_probe(). With
this it will be guaranteed that the devm_pm_domain_detach() will be the
last cleanup helper that will be called on remove for the platform bus.
What do you think?

Thank you,
Claudiu

> 
> Jonathan
>>
>> [...]
>>
>> Kind regards
>> Uffe
> 


