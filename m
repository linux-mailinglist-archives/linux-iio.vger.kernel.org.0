Return-Path: <linux-iio+bounces-12674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F19D9374
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 09:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61181655FF
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF391B218F;
	Tue, 26 Nov 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3VzyJhP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB8194A75;
	Tue, 26 Nov 2024 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610442; cv=none; b=NkAnIB9wS/OAG5o134/5VF5QK2WYlmGEXSaLvLA9Cd3+/UWc9GoBIQjKoj3O2oQX5Ac/XGICDL0OIR9yct8/4SQRkYchvywHLk+P3k3fYm9krhQp6HnmoYppXaj+CkztlF5MqjXJUw3GDoOG1TzsIDq/vPOem4xjNeta7zWvaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610442; c=relaxed/simple;
	bh=4/jGPyL/3u3yhDTB4NpPx6N/Pb9fNOscghgs7DOlaEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xcj2QDbl6J6x+SuE2plRlaPWVMhyPeH+whJoMIMHBzgurgDpkle76+HqpnqqWy6NP35msQXQFumAj1OQz+4CslHuA2PlZpcGhBNPezGzTyjkY3/iYgp4K7fbpj3y4JVAMAfge/XKGtz/wv3wUSunTBuPYUPqfNVlkE+FwFIuX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3VzyJhP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e9ed2dbfc8so930622a91.1;
        Tue, 26 Nov 2024 00:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732610440; x=1733215240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZbkyUg3DJojK6s7+U9GX4KB3joCQxD93TIhVy5Jp/Q=;
        b=d3VzyJhP3lYvpZ9lz93D8jeWIPcW3YaxkX7p9qIFx6epNUgWcewWVOCeOvWLdmZ0w8
         ltMdvpJYtuSfvj7jnOdyfKHjZVVgHYMJQIRxTktdUhzlmmQtW19oYJ6zBIyrUTtT1NMO
         pFM9XmkFRKAcX7DU0N6UQe6CDv5SrxyZc4J+kzrhqXtCZlF/TyKy5XuKlaFRHqY4NCch
         ML/HY3faxHS9kkbaqjafqAq5d3zuwV2wqSazefe0uOyHD9/asMx5VmvXNVh6rJMBgR9I
         ww8mYYRxR1qr9RUn3CVejjOFnfKhhofnZ6hMIPvFSL16Nki7rKFeW3Hxy5oCV+eARkwz
         B6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732610440; x=1733215240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZbkyUg3DJojK6s7+U9GX4KB3joCQxD93TIhVy5Jp/Q=;
        b=qKZzMlwzh4oA+LLF2g1WAxqU2/yhwUVQBCwbKH4IEb8VxldA6ZdB/3gxnKpbEIyAj4
         RRXL+rt5umZHwmDKFLoqnMbI1lbGpe4TUa5lY22X+vyKzmI4KCcYT+t1IaINSHayJUki
         1+cxhYb/1GglwvhxnsCUiviUX/0YITbLfNnN3YpBd2uCQr4s8yWLGia+/WMEiqZ8Rcxc
         pZ1ywXGdPBcOPHm3GioW/YeHL7CDlLy1eRvA839wZ6m/GVnKHQoBK6vuP0IquCrCMc5B
         Tk51BiCIUc8g/akuZ2HUjygYvMMPqVjBpDZ5dOPmKHC8CcI00QaKMzGgSTcp05zX9SZS
         /QKA==
X-Forwarded-Encrypted: i=1; AJvYcCULzWBVhSWAQx/QdaDhWJ2hNNNHJQQoK3QEQdpdJFj2MTBe844eladVeRwPNJakEIxsazsAnaM5lC19@vger.kernel.org, AJvYcCVlAfWcRWsX2Vl/Gd3zHPUQbqY8elTWe6gp0GTV+RstNWT1a3cTkOsmYIjjo1ro+kgXl27Bkis/wSACfZvW@vger.kernel.org, AJvYcCWsDq2X3CnPzOgQoGkw2q9WKKpAWikK+pCMWnaeqXFXE1XSZSqah7HIvcMiJ1KuTF96QR/bYZUpLR1I@vger.kernel.org
X-Gm-Message-State: AOJu0YywVAb+juFQUevCAqvsGFSi8vOUViw1EXaEvl+jhKz2LWQQSRna
	yMqOmSTAbvfspFF+hANxIwzvhPie5OI7Ji/gBk6XTrJHf+/UXNbE
X-Gm-Gg: ASbGncuXq1jowuTr6q3KHwmxku074K46ixJPpYq9zQ2fpyAyvVqt9Vl9w1U/CrwNpac
	bXSJRD52AAXlM9iMd1ax2qgOiUqsGs/oi+nrfFjzRff1HW/3u7AApS4NmvXkpiTvNwOxQMKpI6h
	b0T4d/J9jvXovip5QZl2EuGilW70pyVJlbQVXx/WQG2qp/cvx8ypxEh7pPUsskfCP3Naml4SugA
	Ll0iIW1mHP61fY6ZuO6MYabhxgbDubEVF4yF64YDWIXs/02TFJrNOeXFw==
X-Google-Smtp-Source: AGHT+IF73PAhzAjUuYL9DhFf8aYaTBl/YTsoSJ+wi/AHDobSA/YfTuwlQrt5I17R1mJE9tAyni/nlA==
X-Received: by 2002:a17:90b:4c45:b0:2ea:853a:99e0 with SMTP id 98e67ed59e1d1-2ede7e40e93mr1800169a91.5.1732610440452;
        Tue, 26 Nov 2024 00:40:40 -0800 (PST)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02eca46sm11706500a91.7.2024.11.26.00.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:40:39 -0800 (PST)
Message-ID: <ea141f1f-b0b0-4bcd-ac30-8ee533860f5d@gmail.com>
Date: Tue, 26 Nov 2024 16:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
 <20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
 <20241020140638.127a9dbf@jic23-huawei>
 <b59f6933-e1f1-49e9-be61-3e3b4323da87@gmail.com>
 <20241123132110.15570171@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20241123132110.15570171@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/23/24 21:21, Jonathan Cameron wrote:
> On Thu, 14 Nov 2024 23:16:51 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> On 10/20/24 21:06, Jonathan Cameron wrote:
>>> On Thu, 17 Oct 2024 18:36:44 +0800
>>> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>>>   
>>>> When hardware design introduces significant sensor data noise,
>>>> performance can be improved by adjusting register settings.
>>> Questions inline. Mostly around why these controls belong in DT.
>>> What do they have to do with hardware / wiring etc rather than being
>>> appropriate for userspace controls.
>>>
>>> So almost all are definite no to being suitable for device tree bindings.
>>>
>>> Jonathan
>>>   
>> Hi Jonathan,
>>
>> Thank you for the suggestions in your recent email. Following your
>> advice, I discussed these configurations in detail with engineers from
>> the HX9023S supplier. Based on their feedback, these settings are not
>> intended to be exposed to end-users. Typically, these configurations are
>> adjusted during the DVT phase of the end product by the supplier to
>> optimize performance, after which they are finalized and not meant to be
>> modified dynamically at the user level.
>>
>> Given this approach, it seems more appropriate to provide these settings
>> as part of a firmware file, allowing the configuration to be kept
>> internal and managed without user-level access. If this approach aligns
>> with your thoughts, I can prepare and submit a new patch focused on
>> firmware parsing and handling for these configurations.
> Whilst I agree that a typical user may well not modify these settings
> that doesn't necessarily make them suitable for control from the
> Device Tree. Some may be but settings like ODR are about use case
> not physical hardware. Average and OSR are normally a question of
> trading off noise against data rate - that's policy not a fundamental
> characteristic of the hardware. Filter controls are similar.
>
> For other such as Dither, there may hardware configurations where it
> doesn't need to be turned, only but does it do any harm? I'd be
> somewhat surprised if the right thing to do there isn't to just hard
> code it to turned on.
>
> The enabling of dataready interrupt is entirely down to how the
> device is being used, not the platform.
>
> If these devices are being used in embedded platforms for a specific
> purpose, then a simple udev rule or similar can configure the
> defaults whilst still allowing them to be easily tweaked.
> If you are dealing with standardized software it will already understand
> many of the userspace ABI calls and have appropriate configuration files.
>
> That is the appropriate level for such control, not device
> tree.
>
> If you have a strong case why a setting is never a policy decision
> but rather a hard characteristic of the system, then that one may
> be appropriate for DT.  Examples of this in the past have been things
> like output voltage ranges for DACs because the hardware beyond
> this device may only cope with some settings.
>
> Jonathan
>
Hi Jonathan,

Thank you for your detailed explanation and insights. I fully agree with 
your point that settings such as ODR, Average, OSR, and filter-related 
configurations, being policy-driven, should not be included in the 
Device Tree.

As you mentioned, the dither setting is typically left disabled in most 
cases. This device is indeed used for specific purposes in embedded 
platforms, and there is no requirement for runtime flexibility in 
adjusting these configurations.

Given this, I have decided to drop this submission. Moving forward, I 
plan to address varying hardware requirements by adapting these 
configurations using a firmware-based approach.

Thank you again for your guidance and support!

Best regards,
Yasin Lee
>
>> Thank you again for your valuable guidance, and I look forward to your
>> feedback.
>>
>> Best regards,
>> Yasin Lee
>>
>>

