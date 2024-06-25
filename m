Return-Path: <linux-iio+bounces-6885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F489162C7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FEF1F21634
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8A149E0B;
	Tue, 25 Jun 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VktyD21u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCA149DF7;
	Tue, 25 Jun 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308362; cv=none; b=oQOqgH37q3kQw+fW8iH9NsZxTpV0NtlC1AkyVev9dtNgtuZs7iaQQLubnGOctAXshXFzLrQ4mflFzBRKZhy1xost25Iwe2s5ST95GaPEJoat+YSNpWobMvVgn5aiQGooa87U0y5DnURQOUsoL9Q8q52qq3Z+O/ZlAmZniigNWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308362; c=relaxed/simple;
	bh=qSt8uxSH0xIE8XfLl8qKGnMneG5V2yXlT9AiL+782YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ndaugy0jVt3Ka7KO8IFzI/jW8PErAG7Vqf0VndwUdy+KsKhk1NDyux6XReIFAo7eeYDJN4qm//IGq7oLoYFL/eINQV2FKsPPs464Bvy9C8QI3Ub7p3E5cJfzSmXgQSDnvKfnEPsO5rFo4dKhOf65xB4p2PVDqlYQoh0OgyqLoQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VktyD21u; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706680d3a25so2019977b3a.0;
        Tue, 25 Jun 2024 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719308360; x=1719913160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBEHgMYq3/MriOx4WCBxMBdBffUVzqTsY+wD/cCZLes=;
        b=VktyD21ujomd27px4bFNjSoyszyXUwpJtL6d08fe8PPrPH0hvtiQaK6BvMUbv1XaFn
         UAytSaSj9wS1B85PjGTiIXjBBGB19MOBZ8Q4XYtMGAnpJutqn+n9RuSjPzd1HfuUv1bm
         6Q28cll5Ku/lb8beg6viSBWNmISXWy4BdV6VFNMoWpHe7x3SNXMPcROrcYpXUPu6b5G3
         ABKPaozKOW+Xr62km6dBaA4RKozVv7yGwa8/j74uSkk8Sie+X+0gHn2605RDoUQoeFun
         DwdmjN2gcyvFemABF/z0pawRP1OFatcyIXcvrpJ8J0nE/99EpgdBOe0SEOQf2ltwTVeb
         H8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308360; x=1719913160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBEHgMYq3/MriOx4WCBxMBdBffUVzqTsY+wD/cCZLes=;
        b=ENwgGw6wzKYm/81jWaOxuWb7HobhmZis/InkMNT7MbImClDhp5177ixg7MS5dt+tjR
         SU8ELZssOTt7MfiOPFhUv6M9/6X4i1nh5KQy6Fazt+gftwm6afgBtRGE+av+XVvTLTJ+
         UkMPQGO//sF1lGOCNfhVwsZ1r5yRBGc94HQIYBpb3O0ku0AbzxbCcPW/rK+nyaD/Lcis
         HL5Cdag2idOGKdxf6iR4KUY1q3NPdhsgpXz5sNxTZXcEpA1yxeYAD3VFZr52vT9zmVJO
         lJ67CEU52QxQR29U2Sax/motqp2lXOyFtbkhezA131ojJsoK1VvytEsYBT8eJxEMYmfW
         c/mg==
X-Forwarded-Encrypted: i=1; AJvYcCUsrlgnAo9vhZGygB2fPidzTzABQxAWt03NJDmWFTs9Ny6ZkuummZQpjN2LkZVN7g46s3nix7+WdR5tASdnGr6CUngAMgMgH2QN3xW3kPdIQ0NGfikOEyG4y308m7ZXfFA4HRhx5oEv
X-Gm-Message-State: AOJu0YyTsrl2UsavfkTx0i0fBx6N54M1cwbZir8FetVRG0MuN+vaGzJU
	NCd1C1Z1MUCNCbMVKxVOYK1+ffvWXuEWkPFQoyBKsIauMmqVZDTp
X-Google-Smtp-Source: AGHT+IHBIQ/jNCFsutzz2Km9gbzxtDowez1M80OZk71j438LwHlAL4TN5vGsgDhCvKPPmGh/MLiG8w==
X-Received: by 2002:a05:6a21:6282:b0:1bd:260e:be97 with SMTP id adf61e73a8af0-1bd260ec538mr141746637.53.1719308360214;
        Tue, 25 Jun 2024 02:39:20 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819a7ec09sm8234396a91.16.2024.06.25.02.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:39:18 -0700 (PDT)
Message-ID: <f6368aee-98fc-4159-b87e-bc42f0f660d1@gmail.com>
Date: Tue, 25 Jun 2024 17:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: vendor-prefixes: add tyhx
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-1-b1d65b221811@gmail.com>
 <8ce23bc6-e742-4851-9a26-ca2ab947005d@kernel.org>
 <30600f33-71bf-4abd-9de6-1c7c07e94d77@gmail.com>
 <1a3e5503-8087-41de-84b4-8db533d0ad5f@linaro.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <1a3e5503-8087-41de-84b4-8db533d0ad5f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/25 17:15, Krzysztof Kozlowski wrote:
> On 25/06/2024 10:31, Yasin Lee wrote:
>> On 2024/6/25 13:50, Krzysztof Kozlowski wrote:
>>> On 25/06/2024 04:15, Yasin Lee wrote:
>>>> Add vendor prefix for NanjingTianyihexin Electronics Ltd.
>>>> http://www.tianyihexin.com
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> This is the only one which could actually happen, but still after 15
>>> fake tags I don't trust you. Where was it given?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Sorry, I think I misunderstood the meaning of these tags. I will remove
>> all of them.
> Hm, this one could actually happen, so did you receive it or not?
>
> Best regards,
> Krzysztof


No, I didn't receive tags from others. I think I only received the one 
explicit response from you.

Thank you!


Best regards,

Yasin

>

