Return-Path: <linux-iio+bounces-27406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8266CE54E1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48149300A1CA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Dec 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D05215F7D;
	Sun, 28 Dec 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIwdCNnU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94813B58A
	for <linux-iio@vger.kernel.org>; Sun, 28 Dec 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766943447; cv=none; b=ixLKLzDXdhdAL4R762H7q510/Ki2d1KPrh0Ll9XwsVHdHtZ8D9rTLi0TAk1RmMyDGgbEps45YRCA93rcvsc2S7NR7HQG8f9to5u/xAoFgIPBQ13sBLla4Y4lIGdgtwHD//dtmplieTS3Lv6he4ArI3Ow5u9Tlr6dsJJguNn2HPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766943447; c=relaxed/simple;
	bh=IU3oFTJZ5OOm1UjlmbTgSas+pHivq/znUw+5jxL3u2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn7lE0BmbgSY/dOVE6oFx3m2iOTqCUIVdyEeajRhovnwoKCYeOEYsUGx5Z0qUz0PfAlLgwn0C2GvVkFwAjzoQavQZWvmdWb3h0e/X+VSzMEhqhdlDznfucEfA+0sYNreGHthv+CHxNBYMwIYleTJkLFSEst5U17P8E5amsFEfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZIwdCNnU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so3928760f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Dec 2025 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766943444; x=1767548244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVpE42Nm/eglv4AuJiF24kJ0VOC6iIK2FSatfzsCK7c=;
        b=ZIwdCNnU8FvfehJyjFTeKa9IFWr+KQ/tHMYfw0Q5ZpAozEmJWcVoKaUSSZKgKm+9Xy
         klppD3twneWKRFAdTqlE+QgxGGILM0f6p+X8EPCWWjax6VVjwtYUiH158wINp9pYdCrU
         ymOQeDG6pipxQTwHTU7/AiPULjx36CQSUqoAR03/HLYedK5R0goR0fCe/uGkVTS6qu4J
         jHJ5cmt/uSYcBmkADTFDox61thT7MaMLwr05bfJ3X4eOS7trGlM65Vs+ye40qY583gqz
         oL2nLdDbwIETIzd7tXRL0+UZ768DVAPuwvpN/woePldjOuThpPkKhkYI8ZHmlBb1w6A/
         eHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766943444; x=1767548244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVpE42Nm/eglv4AuJiF24kJ0VOC6iIK2FSatfzsCK7c=;
        b=jtRr6izUTpLwaddyEjOhb6m30rtAS0EfCVH5QEuG9Ezx1wxmaTXSFKlxjKV9n9N0h2
         RBfbuPxC4QOru/c2i/4D/q44YdHLr+8i+9OQ7xLnHpizO0DLzDoglDWebU4jgwAOE320
         av7oMd5edj44Wwz0+swwk0CIYxhKHq6PNhDupGlhPFYNu/A0uqOjnm3nhK7Nv4ztY5Kg
         1UYbepa3540PRfhpFH1sonYy8SX+pp0vkrP8UUBKKWhfgbcKNfQRoBjbVOdq/eKPjgqg
         wqeHcYjuAOy6BvHm64WukUNOfcPT/HxwRf8FfhKdCZJ14L5J6Zy4baNpWEPGXFFkULSF
         2CqA==
X-Forwarded-Encrypted: i=1; AJvYcCVM4IS8oLvFbYuurXgVz/BKIs90PRKkIg7hCodaDFUol+KloXalR0fb8kVTu47bs1yEDIujd4T/Pkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8qORyBQm7juQenCCdk+4pdehApPph05zTYr74zbkxUrdcthb
	QR9e/BkvftlxkFeoo2KiIri2oYxGUnurNBdzdX2KXtdf+Jjz5BO+jRVbhfWkp5H6h2k=
X-Gm-Gg: AY/fxX7pLLCO3DUdU0cG6DvVmkW89uKgyvuDT+RrKm012pF9B7UlWLNUiNycM+thkGc
	6g2ytAYlDXKilJGN6wkCcUbNPdzX5QkLyMUYYMWUZ2SHbOrUkB2Bel3n4Uvu51vhYUoWUo+8lO7
	VPisrxrUcqvcOLT3uFQY02vYwX0DXDeXYmCgJGIg/UEQX21+RL1vbvPx6LUZIDfvz4yaZrv/Q8r
	wU3G4o+S96GoDZnZDYGpJod4fZq/RPB6jm3VKJ0eT0RNHhXZrGFN6O5iK25ShK3myhgIUYwrg+A
	zxmj/PPQL9Hnv8AJhm0/wtVB639qImljRNBrRq1iJAYBIn+9/UdOSd5FEa84Fu624kYYMyR8Qmo
	It+5AmnAPZOKCS9edPLxvd/ai/8TChbGFwSAVxjckZrjR3AelnkRjXeDuk7KYH52OPLgbooGnBs
	fw/jE/fPRYsGIhtLHYLzF6jeHKPgD1H+38foZGpw4oRNYjMspWY1sLMCmt/zrX97KX8ifdpNCUk
	uVy
X-Google-Smtp-Source: AGHT+IHE0OkFcwTNOw8wEuwIrfhr0vrnj+ENYFnmwQiktK0vMMBBeGZzt5Tqu1ud08sB+J6NZr+fHw==
X-Received: by 2002:a05:6000:2c0e:b0:42b:3afa:5e1d with SMTP id ffacd0b85a97d-4324e4c9d89mr38116918f8f.20.1766943443689;
        Sun, 28 Dec 2025 09:37:23 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:37e6:ed62:3c8b:2621? ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm56716550f8f.22.2025.12.28.09.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 09:37:23 -0800 (PST)
Message-ID: <ba28863a-a5fe-498f-92a0-d71c356e7189@linaro.org>
Date: Sun, 28 Dec 2025 18:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] counter: Add STM based counter
To: William Breathitt Gray <wbg@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, s32@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20251217075000.2592966-4-daniel.lezcano@linaro.org>
 <20251228065241.21144-1-wbg@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251228065241.21144-1-wbg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi William,

On 12/28/25 07:52, William Breathitt Gray wrote:
> On Wed, Dec 17, 2025 at 08:49:57AM +0100, Daniel Lezcano wrote:
>> The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
>> three Cortex-M7 cores, along with a large number of timers and
>> counters. These hardware blocks can be used as clocksources or
>> clockevents, or as timestamp counters shared across the various
>> subsystems running alongside the Linux kernel, such as firmware
>> components. Their actual usage depends on the overall platform
>> software design.
>>
>> In a Linux-based system, the kernel controls the counter, which is a
>> read-only shared resource for the other subsystems. One of its primary
>> purposes is to act as a common timestamp source for messages or
>> traces, allowing correlation of events occurring in different
>> operating system contexts.
>>
>> These changes introduce a basic counter driver that can start, stop,
>> and reset the counter. It also handles overflow accounting and
>> configures the prescaler value.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Hi Daniel,
> 
> It sounds like you're trying to implement a clock for timestamping.

Well no, it is a counter which is used for timestamping. It is an 
automotive design.

> Although the Generic Counter interface is flexible enough to shoehorn a
> a clock into its representation, I don't believe it's the right
> abstraction for this particular device.
 >
> Perhaps reimplementing this
> driver under the Linux common clock framework would be a better approach
> to achieve what you want.

The common clock framework ? Sorry I may have misunderstood the CCF but 
how a counter exported and controlled by the userspace can be managed by 
the CCF. Can you elaborate ?

> Regardless, if you do pursue a Counter driver you'll need to follow the
> Generic Counter paradigm[^1] and define at least three core components:
> a Signal, a Synapse, and a Count. Resetting the Count is typically
> implemented by defining a struct counter_ops counter_write()
> callback[^2], while overflows are typically implemented by pushing
> COUNTER_EVENT_OVERFLOW Counter events[^3] that can be watched by
> userspace.

Yes, I think the Generic counter makes sense here for the goal to be 
achieved. Thanks for the pointers, I'll see how the counter fits with 
the paradigm.

   -- Daniel


> William Breathitt Gray
> 
> [^1] https://docs.kernel.org/driver-api/generic-counter.html#paradigm
> [^2] https://docs.kernel.org/driver-api/generic-counter.html#c.counter_ops
> [^3] https://docs.kernel.org/driver-api/generic-counter.html#counter-events


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

