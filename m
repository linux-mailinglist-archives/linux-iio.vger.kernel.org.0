Return-Path: <linux-iio+bounces-27125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B171ECC5370
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 22:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546C730C3BA2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 21:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6731329E;
	Tue, 16 Dec 2025 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3U3BWsqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339331C56F
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920442; cv=none; b=Y6Wa9XP0gxxPEAYuYnuFkVsFg3dmVWnopLfWjbbUoNziMNmc7VZeKhsuKP6JtU+F0azads2vW/WtfymkH3pFByX9TUnKLOlkiCK3qjYSnyhRvYdIVxFIATx7fGxgdZHVK5OyuUAak8mSQ2YYzHP79peKBniSRFy2Bau1SJAIY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920442; c=relaxed/simple;
	bh=AyjXpC1hUTJHEa6bRyW1YG9funV5m658zLjNygfzbbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuiyPWGXBJ1i/5/bBaXu9cK7LuDdQYVEUUp11z3zgLsfyej1H74kYiqE06RstQo6CRk62du8Nc+6SysrLes2hMIwEl6/yjJmEAlAlC1hq1rPI2BxLMuvddbBlzclgUxyteQ5QOhb2uX5FbrPr3gmnAZpVatya7bXNMCWDAnaK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3U3BWsqy; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-656d9230cf2so2893002eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765920439; x=1766525239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaoC5YzDktysd0rOrECc3X1FcjOwO2cqvUXpVGPXGPs=;
        b=3U3BWsqyXJlh7GTVSgTd7vmjdnnbu3sJYb5mb7itOfXQ7yja9ymASq3X/b48s2RFG8
         IcQClTMHKFvYtJK75YnxFJKgvYZZfP3rRT6XUSa6rqV+LTQFYlPf0Ozc8jxC99ltzawn
         JkpRisayCl/eM2Dbl+V+WRrgsAwVfk3s33d1zZlZ/jnydqVaoN7zqJZB4atAdKqvxLUJ
         JU7ftOyaDh8XDW/OiLfRKyrjbbxz0UJNCZkE/C74Pxn6RvGpGNJD16lFjXQdyeb1ePp7
         zzdYMOhEqoKl75kaq6mVMXAC0Q4OgnksCVJg0FL0j3MkgrwOYbcPAVgXnHf28bnVZp5J
         ldNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920439; x=1766525239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaoC5YzDktysd0rOrECc3X1FcjOwO2cqvUXpVGPXGPs=;
        b=q68REZBs/CVVwQQs3VVU2/lcCNzbv/UoYTFSHXYDDSxs2icGqypIsQpcU+asXU8YuE
         OMhBSx9cpgafhRibODE+I9RuM0xlqQzNXmUgFvNfrb88G4k9Q1lVlv1XAW7FNFsFSsi0
         S6fA/eleqy7W66i2ATMgLH6OEw9w31vwO9ENT+LYFHDF5x9Nz96RBcgIdjcdMOjw8vIt
         YYKIHjk85gOGCzgp1y8hFz5GLmI22/ymhNXHoYCvl+eAF2PYCRwN/7mIVZmwHc6AIEKJ
         sgm119K5Nv7mb8VlRjoxjQ6OdxXQe6Rfz5GTfoanWoYsajr3CftHbfz10n0kFgcTpqcO
         U8/g==
X-Gm-Message-State: AOJu0YxDtkCQmOJShVFgB1taEEuoprq3wqbPRRS6LAUR9oLa9YoysHHG
	/bwX8gqPqVObHtpqBzdVoL0CMSbulrQ8UBLfyca6QbxaXxcoJsa6oB+F6rH3YsIEsMs=
X-Gm-Gg: AY/fxX7kgbpZCfo7aQ/CXoa+NKxs7DBcWqHcY83DXGsNk5D43hG4YJ2uXxbCShBK8P6
	k9Xsla1bB9fIj05HspkAPO6x35hiq7qDFKpzYEVNGZBgInGqZrVbfzY/ZM4X+mmWtOrX6wCIsfg
	jD712rrjBmWyRdOE5pGZD6lc44b1mJeD/aR6IToLNaFbiaKrPJN5Ta1sg1lg/kEA22GNBYkAsg7
	8+KTR/vXiOPCLluXqUnHzLdgNMA4o2wxoSvpZXWucF74dpVui7BLZALv3oIMKfOroETXI5vAOkc
	79YqqjA4JKsBlZ/xlubL/U7aPIIhhvhl0uslARmLGS/dvNztbn73I+CJeanx48ZdNbfheimpiyM
	kLWp+nhESP5BcnxqomFdtimZen31tpwPAjLBTUlL6K+DCtD6oGJ9qv5SBLdkmCjdTCf1rmshxHk
	XxFET2lnOo2bwKy7dQAZuswkx9IVG6M0vX/5/8cGrrRqZ4msSkKuBF6u3sFLcV01h4Ku3P
X-Google-Smtp-Source: AGHT+IEwDevcniDW6Qi+dzgr9nkzUn3zx0yYj0JbPCW43D0E93Ue1HoLnhoPBmvm3XAVZcUGfAKIbA==
X-Received: by 2002:a05:6820:180b:b0:65b:250c:70e9 with SMTP id 006d021491bc7-65b451b736amr7146441eaf.27.1765920438873;
        Tue, 16 Dec 2025 13:27:18 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:11a:676d:852f:9349? ([2600:8803:e7e4:500:11a:676d:852f:9349])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360ab0c7sm10276381eaf.11.2025.12.16.13.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 13:27:18 -0800 (PST)
Message-ID: <2f45fdbd-44a3-41a2-9fc0-7c446bd7ca35@baylibre.com>
Date: Tue, 16 Dec 2025 15:27:16 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
To: Tomas Melin <tomas.melin@vaisala.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/16/25 9:39 AM, Tomas Melin wrote:
> Hi,
> 
> On 16/12/2025 14:56, Nuno Sá wrote:
>> On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
>>> Not all users can or want to use the device with an iio-backend.
>>> For these users, let the driver work in standalone mode, not coupled
>>> to the backend or the services it provides.
>>>
>>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>>> ---
>>
>> Which users? The only usecases (for all the supported devices) we have require
>> the FPGA backend. So do you have a specific usecase for a specific device? If so, I would
>> prefer an explicit boolean in the chip_info struture for the device(s) we know this
>> can happen (unless you have a usecase for all :)).
> 
> This is generically for all the devices supported by the ad9467, not
> only a specific device. So it's about how this is used as part of the
> design.
> 
> This is aimed at users that do not use the ADI HDL reference backend
> with these devices, but instead have custom backends suited for their
> own needs.

If you have your own backend, why would it not use the IIO backend
framework?

I can understand if this custom backend sends the data somewhere else
besides an IIO buffer and we don't want to create the buffer for the IIO
device. But I would still think that there needs to be some sort of
communication between the IIO device and the backend.

Maybe you could explain more how this custom backend is intended to work?

> In that case, we need to be able to skip the backend registration and
> register device as a standalone iio device.
> 
> Hopefully this made the use case clearer?
> 
> Thanks,
> Tomas
> 
> 
>>
>> - Nuno Sá
>>
> 


