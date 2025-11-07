Return-Path: <linux-iio+bounces-26018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B47C402BF
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28024EEC50
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024E2F5321;
	Fri,  7 Nov 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgloT27L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191E231A32
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523048; cv=none; b=Gf9ltOxpV/uow7dQsaJBXpMqol2NUzo1gES6RsVdsSR1+mWfI4D1ZzFi4KWXN0OXYuzeiD+0yoQq++rw191NevvKWMVlVYtn9xLxyvOd1p4nkWvhRr6D/Rkfn1SqiCCqs3NLFN+WQHokZXzbX1hbgZu/Mg0Oqg2b1mPw7oxkbho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523048; c=relaxed/simple;
	bh=Kek2ni9K7tlXAKMV2yxnaJRcPVXhJP6mmBKqRazXcxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRmsmTy8tyGixO6b0sB/Ayvqt+0hyK5h93Z2PPH2WsKTnPgn4MQprTKD9zzawoeBTTQAa4Oe7uSV/IWVaaPl9ukyFIj8DXGcUHlMWDQfS6lVW3BIjYp5vTQptA9fzIqsDszeSQrHuaTvb8KAJZRC/xR8lgB9Cnuu5ede07rPAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgloT27L; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297d4a56f97so3031905ad.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523044; x=1763127844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T51sKGmzO5ESwXBqJuoshtIPtbH/U8t3k8P6xn6hgWk=;
        b=fgloT27LOWI0lrnwCSZ+TPo2ysIgzhsaJe7atO6MROOjr8STMdpBxA6hROblRwatJ1
         PzATAik3H8QnSO3I7nLYMRQFZ6OrlP5PHC2LUBqj8YBGPgMu+QSOvUKZkWlDc0eZI+Eu
         yAeXuoKv3zoibimpL6mBZMbOloF6dqLKNFeQCaA6291WUxD4iMe66JiO1XYm6czim2kq
         jTFv4Y7Cx3rBTim5W/GElrvU1eD7hrix7CX+QSSi3T9tyRZSyBgEsSeLXD3q5ESO4Wmx
         5brnhV/GAFs1TUyPJoCzoi0rG+dIt5fMt1FTqsvZRsAURbhYQfFxiKkSx9nhBD5OXhAt
         9lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523044; x=1763127844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T51sKGmzO5ESwXBqJuoshtIPtbH/U8t3k8P6xn6hgWk=;
        b=BbvMK77ntxrMT6Hx+yi3RhonDL5bEpGXUb4qETZMV9KRQKnhZrBtwTTmeH3LEfYQT5
         74nZA7ku96ilGYi9XtoxtUQ0y9TU3ZLgqknOO1kAmIbLXuWGg7TBtzzbF7IJjMPBr3+O
         CApaezttDQzPygHDTaH777nZlIBJPsJkV7BjrlmG92ojeT1kjHAolPH4Gy5psBOShhiV
         EWR7Ru7ZN5UHIIfjmRiix4Nct8aqshjRLXYSZxBL2QMleGqtq01bEH5vFUvnskYMFqFX
         vBzv0y150DGv2rb0u0jdl+bKLdSrgf+ikZLHJMhndZ4yr1Xqy4AKC61RuzOYBPxmrGGF
         7sAQ==
X-Gm-Message-State: AOJu0Yyug3oRthWpiMstlLk/X7qG2n9ln0j1jd2ecW/cj1JORB3jDNDZ
	OLKtTeMeKnqEJt2msCvac3wTl1YhUfNUvqNXuob5ZPk8IYIRMnRinKvb
X-Gm-Gg: ASbGnctfoxC8mULDaz8xxU8l28F3qarOZ0l5jh5UgfuY0tvJh4ydZqQrwitJ7ZeNdvu
	D2kLdmybKkXZ1aBCUScOMlTlKolyWke6n7CJbB2FTesjM2n7HDsVZbkn0LR3iEXyf8trkGisl2/
	PwO3MHNK4ki7TK47AC8+vGRQYq0tTnA2zBPsRN1DF9zW6xlRhn9u5D12EBh/h7amk/NbHqCh3Yo
	M7+0AFQQN7YrwEweK+Y3lvlmM0q8xWRI1MfzgX1/Qv/7+p9yoKTFrT36AZFsGMbL6gENmfwVNjt
	jiBEt5SlIolQLHxtkYlt5GKVQ9GgNGEaLjIYUDRWifYWQ7WoaRb0b4I+Ua1L2jU2jgnyFo4cKL9
	oi4FPMGmYbBrkzd9GtIeWnkFCCj20hBToYbpbwYbCrqd2ifFpYNWoVJQ2qB56apBGa3uEc78Fv8
	IUG/1rOgHvo6moroEwk6/HaOBqtPfryqm+Og12cxd6ZLBTgfsdJJKWyk3ITPLUnbBP66Db4wqtc
	BBAaKayy3aGU4HC8yaInNzGm4dET22KLUtN8YxLntI7275PZFN8dIsU9ScQlvTlIpAZ8jllK32l
	Qsmac/SI
X-Google-Smtp-Source: AGHT+IEQTc9ird2Of3/UqLYc19J1u7EOVDH6cqhobpLuQc6M3Vc5JPZ+PlHeMA3ePxLyPNMmC8Ej7w==
X-Received: by 2002:a17:903:287:b0:292:dca8:c140 with SMTP id d9443c01a7336-297c047a762mr40598415ad.44.1762523043769;
        Fri, 07 Nov 2025 05:44:03 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:b586:93ae:6db3:2abb? ([2402:e280:21d3:2:b586:93ae:6db3:2abb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509683easm61055775ad.15.2025.11.07.05.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 05:44:03 -0800 (PST)
Message-ID: <8ab11fa8-defa-47f5-a9cb-e3e95b5b32ca@gmail.com>
Date: Fri, 7 Nov 2025 19:13:56 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] MAINTAINERS: Add entry for TI ADS1120 ADC driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-4-ajithanandhan0406@gmail.com>
 <20251030175510.00005af8@huawei.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <20251030175510.00005af8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 11:25 PM, Jonathan Cameron wrote:
> On Thu, 30 Oct 2025 22:04:11 +0530
> Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
>
>> Add a new MAINTAINERS entry for the Texas Instruments ADS1120
>> ADC driver and its device tree binding.
> blank line before tag block.
Noted.
>> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
> Just bring this in along with the code, it doesn't need a separate
> commit.
>
> Thanks,
>
> Jonathan

I will add along with the code.

>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3da2c26a7..1efe88fc9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -25613,6 +25613,13 @@ S:	Maintained
>>   F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>>   F:	drivers/iio/adc/ti-ads1119.c
>>   
>> +TI ADS1120 ADC DRIVER
>> +M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
>> +L:	linux-iio@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>> +F:	drivers/iio/adc/ti-ads1120.c
>> +
>>   TI ADS7924 ADC DRIVER
>>   M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>   L:	linux-iio@vger.kernel.org



