Return-Path: <linux-iio+bounces-13930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E5A02195
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 10:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E251885022
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1E1D7E21;
	Mon,  6 Jan 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CJU69mBi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E32AD16
	for <linux-iio@vger.kernel.org>; Mon,  6 Jan 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155127; cv=none; b=Sh3wQRyqZVw5fXM7Gywm0NcmHqAue4K70iUqZ5qJ1XIPexy79YYq0/b2n4S/tmT58vcj1nFC11/VzNiiNSllCqnEtW+rebN6s92kaPrtlQ6xw/+qaJb8i/8+NqieYFfW9KHpuo8U5RhtVTtgvbJ3zun2qqtdsRNnom1NVU0xLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155127; c=relaxed/simple;
	bh=RnTORvbm0gnQw+JAYaXlL1z80u4lpfomXvVmpfqsKWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikMwvmfU5xzxSFFrTCWI6s32aTDHAGE52lx7JbwBmm1pfdbzBnaqGRMtl3ln4vijQP/rxwnQeeDuyq9zD6mNDVMotXkoawZNWirlrCsIfcYibaEqdx/94kvLuIp3v3kGhfHi1rOTrtyRkdVJfVEr2+jv+9NQ90Ky4EEdO+QaCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CJU69mBi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4368a293339so108176455e9.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2025 01:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1736155123; x=1736759923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RytLxRZxC8L+SoHq2QUPWp7tJd9AZXXGwn4jAy0YyYg=;
        b=CJU69mBiG7V8NwDeYmoX0qJIauhfFeTyzPkSn4nS/B9u4QbZ+MqSn/caf4crkhxifD
         x8Yt6oSCf/lzY10JKzE0tQ8xRoMgTJKdRNS1QQ46Tv3HzoWEBANvhryjtnaz1A7T5AwC
         HpX1h9OkkXDFlpAEiA6JMr+mnKyHgr39N/BxjnO8tJo/SUkfCkt020wLxeBzxkS8O0Mb
         2k+9HuY58F/qVOpbeouCC2f6vkjwcUSccXMmM6ekqXF42S6M1pYGc40UsBr0nGAwN+nN
         zx9LRTVM5vi0kOOzYMUbjGOyzmb3PQ/xiIovxnAIlKGYOdiLYgnYCde2pIkjhjmXiphy
         742Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155123; x=1736759923;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RytLxRZxC8L+SoHq2QUPWp7tJd9AZXXGwn4jAy0YyYg=;
        b=jDQLQE1oPfxSSVVjKoZvvTxvgRGjTKvvKpH9SSg0PLWXKvZV03PTFg83D6p/2x+GJz
         bVEK+e7BgI/uln5NwjxrhXuN135T7pk3Vu2Z2ZNOzTT5X2ELwKWMaA0U1Oqac2oduief
         2EaZNdDvZxFBlJ3AJHhgBdsaAQDQyGq67H6beTG7EJY4tcXbDh5sauNmVY5qkWOM47T/
         8WG0nVonbrDvaEc0eqvqx7hABbUHfyW2QzWVbaAtX8ewxY1FKSBZgOZKqEV25vPKE02+
         whtLOXaGNH/yX0CUFul7QCGZordmIRDKaUwBQEiCPp/t9w5nkbNsrLCwEw6Q4hNEAcUv
         37qg==
X-Forwarded-Encrypted: i=1; AJvYcCWvFhYmTor0SlwwggaWm/3ANGgUtXOqnmOKEqmN/wXAirwPgcouVsrgN9RelJZH8TnvSyHaR6QYV/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuIbmz4zQtGJwdXDv/M+AlEhJZ00NWgnEK1VNtVW8RRKolAYP
	3zoD5gwaWeIj2tD7mCJLO0oClCmnMCA1jMGSAQ02UWb8FimdcVW0zw2c1BtTT6Q=
X-Gm-Gg: ASbGncv9WLPxlj6IpPZENAPfsdeL7ETfxJpi/fsyYq9IV/gz3oJrZwSygjwE8zZBkLG
	LHjcZa9jiuMHa0xsycQWeVRQ478hgYTt1JRquroca0frrBR0SWQFVV6MV0UkxmYT+yS9emPLkxN
	k0M2zMuFtUoghtfA6/3jfGB7r1k4ooUokX4sZjFHeVft28D7ekBuoux0mWCtnsAUZ3DmtcLQ2rT
	SPiHGi+SEbW7kBv4OctaVkHl/+wRFY8LOPaVVQPwCjv+3eaccHbWtHJhKiE9javgg==
X-Google-Smtp-Source: AGHT+IE2i/BEt1LhXm6aBI8xTYmzok77BKFnrRyh1Do/v27tAGefsSGEkvLFuko9CQOF3izyTVZFGw==
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id 5b1f17b1804b1-43668b786bamr431393875e9.25.1736155122879;
        Mon, 06 Jan 2025 01:18:42 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472b3sm47328729f8f.58.2025.01.06.01.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 01:18:42 -0800 (PST)
Message-ID: <44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
Date: Mon, 6 Jan 2025 11:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 ulf.hansson@linaro.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
 <20250104135225.2573285b@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250104135225.2573285b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,


On 04.01.2025 15:52, Jonathan Cameron wrote:
> On Fri,  3 Jan 2025 16:00:41 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> +CC Rafael and linux-pm
> 
>>
>> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
>> of a PM domain. The code that implements the PM domains support is in
>> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
>> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
>> domains support is registered with GENPD_FLAG_PM_CLK which, according to
>> the documentation, instructs genpd to use the PM clk framework while
>> powering on/off attached devices.
>>
>> During probe, the ADC device is attached to the PM domain
>> controlling the ADC clocks. Similarly, during removal, the ADC device is
>> detached from the PM domain.
>>
>> The detachment call stack is as follows:
>>
>> device_driver_detach() ->
>>   device_release_driver_internal() ->
>>     __device_release_driver() ->
>>       device_remove() ->
>>         platform_remove() ->
>>           dev_pm_domain_detach()
>>
>> During driver unbind, after the ADC device is detached from its PM domain,
>> the device_unbind_cleanup() function is called, which subsequently invokes
>> devres_release_all(). This function handles devres resource cleanup.
>>
>> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
>> triggers the action or reset function for disabling runtime PM. This
>> function is pm_runtime_disable_action(), which leads to the following call
>> stack of interest when called:
>>
>> pm_runtime_disable_action() ->
>>   pm_runtime_dont_use_autosuspend() ->
> 
> So is the only real difference that in the code below you disable runtime pm
> before autosuspend?

No, the difference is that now, the driver specific runtime PM APIs are not
called anymore (through the pointed call stack) after the ADC was removed
from it's PM domain.


>  Can you still do that with a devm callback just not
> the standard one?

No. It doesn't matter if we call the standard devm callback or driver
specific one. As long as it is devm it will impact us as long as the driver
specific runtime PM APIs are called through devres_release_all() after
dev_pm_domain_detach(). And at that time the PM domain may be off along
with its clocks disabled.

> 
> 
>>     __pm_runtime_use_autosuspend() ->
>>       update_autosuspend() ->
>>         rpm_idle()
>>
>> The rpm_idle() function attempts to runtime resume the ADC device.
> 
> Can you give a little more on that path. I'm not immediately spotting
> how rpm_idle() is causing a resume

It is not in particular about the resume. Runtime suspend/resume after
devres_release_all() will be affected.

In particular, the rpm_idle() can call rpm_suspend() (called on the out
label of rpm_idle()) and rpm_suspend() may call the driver specific
runtime_suspend API through the following code (from the rpm_suspend()
function):

        callback = RPM_GET_CALLBACK(dev, runtime_suspend);



        dev_pm_enable_wake_irq_check(dev, true);

        retval = rpm_callback(callback, dev);

        if (retval)

                goto fail;



The full stack generated when running:
# cd /sys/bus/platform/drivers/rzg2l-adc
# while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done

is as follows:

[   24.801195] Call trace:
[   24.803633]  rzg2l_adc_pm_runtime_suspend+0x18/0x54 (P)
[   24.808847]  pm_generic_runtime_suspend+0x2c/0x44 (L)
[   24.813887]  pm_generic_runtime_suspend+0x2c/0x44
[   24.818580]  __rpm_callback+0x48/0x198
[   24.822319]  rpm_callback+0x68/0x74
[   24.825798]  rpm_suspend+0x100/0x578
[   24.829362]  rpm_idle+0xd0/0x17c
[   24.832582]  update_autosuspend+0x30/0xc4
[   24.836580]  pm_runtime_disable_action+0x40/0x64
[   24.841184]  devm_action_release+0x14/0x20
[   24.845274]  devres_release_all+0xa0/0x100
[   24.849361]  device_unbind_cleanup+0x18/0x60
[   24.853618]  device_release_driver_internal+0x1ec/0x228
[   24.858828]  device_driver_detach+0x18/0x24
[   24.862998]  unbind_store+0xb4/0xb8
[   24.866478]  drv_attr_store+0x24/0x38
[   24.870135]  sysfs_kf_write+0x44/0x54
[   24.873795]  kernfs_fop_write_iter+0x118/0x1a8
[   24.878229]  vfs_write+0x2ac/0x358
[   24.881627]  ksys_write+0x68/0xfc
[   24.884934]  __arm64_sys_write+0x1c/0x28
[   24.888846]  invoke_syscall+0x48/0x110
[   24.892592]  el0_svc_common.constprop.0+0xc0/0xe0
[   24.897285]  do_el0_svc+0x1c/0x28
[   24.900593]  el0_svc+0x30/0xd0
[   24.903647]  el0t_64_sync_handler+0xc8/0xcc
[   24.907821]  el0t_64_sync+0x198/0x19c
[   24.911481] Code: 910003fd f9403c00 f941bc01 f9400020 (b9400000)


Digging it further today: on the Renesas RZ/G3S we implement the power
domain on/off and we register the PM domain with GENPD_FLAG_PM_CLK. The
on/off PM domain functionality is implemented though the clock controller
MSTOP functionality which blocks the bus access to the specific IP (in this
particular case to the ADC).

The issue is reproducible when doing:
# cd /sys/bus/platform/drivers/rzg2l-adc
# while :; do echo 10058000.adc > unbind ; echo 10058000.adc > bind; done

I noticed today that doing single manual unbind+bind doesn't always leads
to aborts. It may be related to the fact that, as I noticed, the genpd
power off is called asynchronously as a work (through
genpd_power_off_work_fn()).

I also noticed today what when there is no on/off functionality implemented
on the PM domain we have no failures (as the MSTOP is not implemented and
the bus access to the specific IP is not blocked as there is no PM domain
on/off available).



> 
>> However,
>> at the point it is called, the ADC device is no longer part of the PM
>> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
>> APIs directly modifies hardware registers, the
>> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
>> being enabled. This is because the PM domain no longer resumes along with
>> the ADC device. As a result, this leads to system aborts.
>>
>> Drop the devres API for runtime PM enable.
>>
>> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> See below. I'm doubtful in general about the sequence changes and
> specifically you can't just remove one devm callback from a driver without
> modifying a lot of other code / leaving really fragile ordering.
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
>> index 883c167c0670..f12f3daf08cc 100644
>> --- a/drivers/iio/adc/rzg2l_adc.c
>> +++ b/drivers/iio/adc/rzg2l_adc.c
>> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  
>>  	pm_runtime_set_autosuspend_delay(dev, 300);
>>  	pm_runtime_use_autosuspend(dev);
>> -	ret = devm_pm_runtime_enable(dev);
>> -	if (ret)
>> -		return ret;
>> +	pm_runtime_enable(dev);
>>  
>>  	platform_set_drvdata(pdev, indio_dev);
>>  
>>  	ret = rzg2l_adc_hw_init(dev, adc);
>> -	if (ret)
>> -		return dev_err_probe(&pdev->dev, ret,
>> -				     "failed to initialize ADC HW\n");
>> +	if (ret) {
>> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
>> +		goto rpm_disable;
>> +	}
>>  
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq < 0)
>> -		return irq;
>> +	if (irq < 0) {
>> +		ret = irq;
>> +		goto rpm_disable;
>> +	}
>>  
>>  	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>>  			       0, dev_name(dev), adc);
>>  	if (ret < 0)
>> -		return ret;
>> +		goto rpm_disable;
>>  
>>  	init_completion(&adc->completion);
>>  
>> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>>  	indio_dev->num_channels = adc->data->num_channels;
>>  
>>  	return devm_iio_device_register(dev, indio_dev);
>> +
>> +rpm_disable:
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_dont_use_autosuspend(dev);
>> +	return ret;
> If you have to move away from devm you must do it for all calls after
> the first thing that is manually cleaned up.
> As you have it here the userspace interfaces are left available at a point
> well after power down.

I see, thank you for pointing it.

And thank you for checking this,
Claudiu

> 
>> +}
>> +
>> +static void rzg2l_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_dont_use_autosuspend(dev);
>>  }
>>  
>>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
>> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
>>  
>>  static struct platform_driver rzg2l_adc_driver = {
>>  	.probe		= rzg2l_adc_probe,
>> +	.remove		= rzg2l_adc_remove,
>>  	.driver		= {
>>  		.name		= DRIVER_NAME,
>>  		.of_match_table = rzg2l_adc_match,
> 


