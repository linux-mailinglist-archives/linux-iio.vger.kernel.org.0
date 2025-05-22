Return-Path: <linux-iio+bounces-19785-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F69AC08FF
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765283B2386
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB33287504;
	Thu, 22 May 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dgm6F4R3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79C280321
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907339; cv=none; b=j7gzg2/yINf6GtFiuPDz7lBSfuAIkufzV+cJEmhpvpKR31B3kM02FyDUEn+issZ710JQAu9i1yMQo2FG/RQ8G5IjUxfzOVyzigK8rPU2YgNLfBvddBiXzo6g+E9zVmoZf/mFoznu5lpJBehtKG9mjPm22m+uCHUhkfJ0PtkHj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907339; c=relaxed/simple;
	bh=qdGgntxIIjfcvQxUD7MkNPywpqkarEzTXwYkWCvLQjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RizuwVwhPO8wHQqUxsZGXo5Nt2eMPy8+Tu/LRLCmfcRcFr7rNfERQ5V+2ba7zzemmwz9tSQ4W39YMzEUc7NarnUKW0JPIE2EBRbWjmPSRiMZVexrFlwmFj4U/keYpzlF1GLmNZsuERJw+VEmaGxpMEfEzW7wc7FJFScJF1PRhb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dgm6F4R3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad563b69908so746678166b.3
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747907336; x=1748512136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klE7E1sXnfwhBGRUczKqI9pMXJRo0twyYdkymVqjNqM=;
        b=dgm6F4R3vfZWOv//68H/pqtnnjo3/wP4hmTqw8WMXYHhgRkPedDTEtsmq2LHi0b6iy
         wEWmsCIOcTsRPH/2Jv7XLk+HCmFSj9rIiyvzndkrEni9fZWevgzlgW9U/W6HfDqMgh6F
         PesVYmrcufFJ7Dtvp0mRcavRZmvFufYsDFej8kiVbd91IOPiTgjyLDIJdOT7YVqoIyYD
         wW5j8RRo/v7ck6/dV24VLYuxLm44U2GWqOUrIjAJDLY99SjbmXfX70CXwNdoY6KUJBQf
         OxRQ15e3KNG8caw/UZsaELvEqnRpnjeY2Ip1pxUQWPXWrI5C1xSb4cptUOn0FYTLXdhZ
         Y8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747907336; x=1748512136;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klE7E1sXnfwhBGRUczKqI9pMXJRo0twyYdkymVqjNqM=;
        b=jXYcJvhxPu57mnYjJpeFkKIkI/g9pFBDsqsnYKE1qFHqxdOdOHnzySzEiSpjekd5K0
         swCL6emI5ee2E+ZMnjRhvTLoTj8Tp+KjppbsQnNczcR47c7+H0KS2s01Zgc8g4NAvYDd
         8oOKC7JYcrqon7nPS3rwjSYnzZRK9SylA65/VCxnO427ZH0Q4V+qpP2yFRQUtUFCqcDn
         U/DDvWQ3MtqiamIKxiTqUuFYMRJMDba5ZkbCDQO/xQYvqH8a8vOF7tOejAePzWI7jgr5
         eXcE30qQ+GYN/4gNtpKKq6PKK4xMgpUvYNGad6XuDyUUkiVMAmf2chiPMuG+dRh6HpPq
         9+8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/IrDMHLneQSUt5QgBc7DuBpbeZ7oWh5L2lKM3zT31XMx9Wf0OgLcJ/An//VuRjYP4vjpaWbBu7NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHaYg2rBpSpZqdlm/esUaQEmD5lOpv3iZqm/NyvtAICC0HXBA
	BS/stpNXaVqquIWMNqattt6m1w7i/8oe+l6qzIkZXoe5eXB09im8LCrWj+mcQxBICfo=
X-Gm-Gg: ASbGnctrhIJ04/nPJ1fpkDAf+69k/L4bKaw7hW3e2gpgOPQKX5G6b3Kuy5h4rItor1K
	A04tl3btdV7+7QIgdblx6DFe6DW/wlqeTkSGbqa4SO+mkNi9jwRbKLSeIczAzxzyoW0/9uYbeLb
	J2ZsnKHDpXk20Jz8hpONg6zV955Obk+wWKmY7cCu8Uj+UxYRw63FrygjIYYp0zN12U8/MT2ZSQ4
	Sqa3bsZ135DKPFyMo1ptCVcbWM40/2IGhIP6gadYNeQsfLrVI3JwAAx05RK8jHQmsJPEx0Qa+wI
	uR1mmgFa1d9oIJXQV7i94coPD2F9DkB4eiL0PSmUGqrPLFCtR+qhAU+Xsy8=
X-Google-Smtp-Source: AGHT+IGR5u6qykqEC57e3nACLD+fywuUN8Jcwlf4E/4zcXLVu7BeLHKEwlYarei9wxiFcWeh77KjeA==
X-Received: by 2002:a17:906:230a:b0:ad4:f6d2:431b with SMTP id a640c23a62f3a-ad536dce6cfmr1624516166b.44.1747907335489;
        Thu, 22 May 2025 02:48:55 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d438403sm1040645066b.123.2025.05.22.02.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 02:48:55 -0700 (PDT)
Message-ID: <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev>
Date: Thu, 22 May 2025 12:48:53 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 dakr@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 bhelgaas@google.com
References: <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 21.05.2025 17:57, Dmitry Torokhov wrote:
> On Wed, May 21, 2025 at 02:37:08PM +0200, Ulf Hansson wrote:
>> On Wed, 21 May 2025 at 07:41, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>>>
>>> Hi, Ulf,
>>>
>>> On 20.05.2025 15:09, Ulf Hansson wrote:
>>>> For example, even if the order is made correctly, suppose a driver's
>>>> ->remove() callback completes by turning off the resources for its
>>>> device and leaves runtime PM enabled, as it relies on devres to do it
>>>> some point later. Beyond this point, nothing would prevent userspace
>>>> for runtime resuming/suspending the device via sysfs.
>>>
>>> If I'm not wrong, that can't happen? The driver_sysfs_remove() is called
>>> before device_remove() (which calls the driver remove) is called, this
>>> being the call path:
>>>
>>> device_driver_detach() ->
>>>   device_release_driver_internal() ->
>>>     __device_release_driver() ->
>>>       driver_sysfs_remove()
>>>       // ...
>>>       device_remove()
>>>
>>> And the driver_sysfs_remove() calls in the end __kernfs_remove() which
>>> looks to me like the place that actually drops the entries from sysfs, this
>>> being a call path for it:
>>>
>>> driver_sysfs_remove() ->
>>>   sysfs_remove_link() ->
>>>     kernfs_remove_by_name() ->
>>>       kernfs_remove_by_name_ns() ->
>>>         __kernfs_remove() ->
>>>
>>> activating the following line in __kernfs_remove():
>>>
>>> pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
>>>
>>> leads to the following prints when unbinding the watchdog device from its
>>> watchdog driver (attached to platform bus) on my board:
>>> https://p.fr33tux.org/935252
>>
>> Indeed this is a very good point you make! I completely overlooked
>> this fact, thanks a lot for clarifying this!
>>
>> However, my main point still stands.
>>
>> In the end, there is nothing preventing rpm_suspend|resume|idle() in
>> drivers/base/power/runtime.c from running (don't forget runtime PM is
>> asynchronous too) for the device in question. This could lead to that
>> a ->runtime_suspend|resume|idle() callback becomes executed at any
>> point in time, as long as we haven't called pm_runtime_disable() for
>> the device.
> 
> So exactly the same may happen if you enter driver->remove() and
> something calls runtime API before pm_runtime_disable() is called.
> The driver has (as they should be doing currently) be prepared for this.

I took the time and tried to do a comparison of the current solutions
(describing the bad and good things I see), trying to understand your
concerns with regards to RPM suspend|resume|idle while unbinding a device
from its driver.

I see the following cases:

Case 1/ the current approach when devm_pm_runtime_enable() is used in
driver's ->probe() with the current code base:

- right after driver ->remove() finish its execution clocks are detached
  from the PM domain, through dev_pm_domain_detach() call in
  platform_remove()

- any subsequent RPM resume|suspend|idle will lead to failure if the driver
  specific RPM APIs access directly registers and counts on PM domain to
  enable/disable the clocks

- at this point, if the IRQs are shared (but not only) and devm requested
  the driver's IRQ handler can still be called asynchronously; driver
  should be prepared for such events and should be written to work for such
  scenarios; but as the clocks are not in the PM domain anymore and RPM is
  still enabled at this point, if the driver don't run runtime suspend on
  probe (and runtime resume/suspend on runtime), I think (because I haven't
  investigated this yet) it can't rely on pm_runtime_active()/
  pm_runtime_suspended() checks in interrupt handlers
  and can't decide if it can interrogate registers or not; interrogating
  should lead to failure at this stage as the clocks are disabled; drivers
  should work in such scenario and the CONFIG_DEBUG_SHIRQ is a way to check
  they can; I previously debugged a similar issue on drivers/net/ethernet/
  renesas/ravb driver where using devm_pm_runtime_enable() in probe and
  pm_runtime_suspended() checks in IRQ handlers was the way to make this
  scenario happy; at that time I wasn't able to find that
  dev_pm_domain_detach() have the impact discussed in this thread

Case 2/ What is proposed in this patch: devm_pm_runtime_enable() used +
open devres group after dev_pm_domain_attach() (in probe) and close the
devres group before dev_pm_domain_attach() (in remove):

- right after the driver ->remove() is executed only the driver allocated
  devres resources are freed; this happens before dev_pm_domain_deattach()
  is called, though the proposed devres_release_group() call in this patch

- while doing this, driver can still get async RPM suspend|resume|idle
  requests; is like the execution is in the driver ->remove()
  but the pm_runtime_disable() hasn't been called yet

- as the runtime PM is enabled in driver's ->probe() mostly after the HW is
  prepared to take requests and all the other devm resources are allocated,
  the RPM disable is going to be among the first things to be called by the
  devres_release_group()

- then, after RPM disable, all the devres resources allocated only in the
  driver's ->probe() are cleaned up in reverse order, just like
  device_unbind_cleanup() -> devres_release_all() call in
  __device_release_driver() is doing, but limited only to the resources
  allocated by the driver itself; I personally see this like manually
  allocating and freeing resources in the driver itself w/o relying on
  devres

- then it comes the turn of dev_pm_domain_detach() call in
  platform_remove(): at the time dev_pm_domain_detach() is executed the
  runtime PM is disabled and all the devres resources allocated by driver
  are freed as well

- after the dev_pm_domain_detach() is executed all the driver resources
  are cleaned up, the driver can't get IRQs as it's handler was already
  unregistered, no other user can execute rpm suspend|resume|idle
  as the RPM is disabled at this time

Case 3/ devm_pm_runtime_enabled() dropped and replaced by manual cleanup:
- the driver code is going be complicated, difficult to maintain and error
  prone

I may have missed considering things when describing the case 2 (which is
what is proposed by this patch) as I don't have the full picture behind the
dev_pm_domain_detach() call in platform bus remove. If so, please correct me.

Thank you,
Claudiu

> 
>>
>> That's why the devm_pm_runtime_enable() should be avoided as it simply
>> introduces a race-condition. Drivers need to be more careful and use
>> pm_runtime_enable|disable() explicitly to control the behaviour.
> 
> You make it sound like we are dealing with some non-deterministic
> process, like garbage collector, where runtime disable done by devm
> happens at some unspecified point in the future. However we are dealing
> with very well defined order of operations, all happening within
> __device_release_driver() call. It is the same scope as when using
> manual pm_runtime_disable(). Just the order is wrong, that is it.
> 
> Thanks.
> 


