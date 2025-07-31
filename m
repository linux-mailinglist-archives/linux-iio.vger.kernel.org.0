Return-Path: <linux-iio+bounces-22169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6983BB17270
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 15:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D504E7B8516
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FABC2D3A7B;
	Thu, 31 Jul 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEin94r9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4A2D3A80
	for <linux-iio@vger.kernel.org>; Thu, 31 Jul 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969834; cv=none; b=DgjWy1APbzcts8K47SJlgm6xPBbCvMSl3d3/TaYPZswVNpZJ5/2cYZ0VfAv0mYe7JhHr23hZJyFGRGHhakfjLlK7Z2gRe2ZDjOX2nnPzR762MuXl88QlwZpICGEa5Xc4hMoIriBp06aoKkEsjn/bYZbzAdppZpMR+0K02Cp1VRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969834; c=relaxed/simple;
	bh=5lxg9xauO3MeUewoXkq0nnjCyipVEFYu1QiDLPz8HQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/i1CY6XlmzoY/z6/8EPBJszNlYiUy1PuhYThHJu/Tdv+mrevBKHSXTKLL79HIaVleVv73/mDYPZNOuKu4lDfT+DMc4ewgc3r/L0TR10Uu3bHpzT2EfWh+Yw14CgQUNvK7h/1CaxURbhj67TureBkiH84afAOIViUtDnAoz3Kq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEin94r9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7825e2775so402543f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 31 Jul 2025 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753969831; x=1754574631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttbP0UASnXnUPdgY4WsQTV6ycnU/sxDT3VHkXEkJ2WI=;
        b=EEin94r9Pn844Zyh73bk8QooVaAByAK/ZD/7zPUUo+j7284Sfrxmx30l9IGYkMmcSb
         V/xHfU0EN0r1W0tX3NDWz9JMR4nHg63LYcY1B6ImfiwbxQIe/z0IURemAQb/gXI0CQZ8
         qCJ01GRVsTdovMWPmd59wET10HDK++ut8KYh2DWNiAYZvyttrdak/Z1c5OOjXpxHzt7u
         neru5XrEb/gK8iMxnNfzg1SGXss5o+Kpj8f6BrGJoreJf8YbDi4wCuNkzoK4RVC/KQvo
         4YOCScHhGPPhJiAUlBQdgUBa2OADaVnXzIQGgS+TMyJspSAoPNoSfD+JZ8YCCxJopYjI
         vMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969831; x=1754574631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttbP0UASnXnUPdgY4WsQTV6ycnU/sxDT3VHkXEkJ2WI=;
        b=ry1VUtFrTYAkORhdW8C5/ngjVFF+4xjC+AHHLG6UwMBkyaVSBQnYzjgXlEQpMiT1Rr
         oVSBwSTRFK0gcYI6KU/6AiLcUnMmvx9K2uQGJUGJU/4DDHlDAr62hFuceZETD+qUcfCh
         8XyuEYscwru1Dujezs8sDTrEX/QC3YNEdeABb2H7FQrTSmjhZOwCvzuAvs0GwYgV6vUK
         Jim5nTRmVt9vmx/yHoNQ6NGPXurrITl1OIE8yKbgC+Z75rXtVUexNIdAx+5iYngqRSZE
         Eww5qDGbcfA0htY80ZbX22dX6ltTeiCrhPW6mnDwuRqHN662ewU4MNuSaRndy3otEiHB
         weFg==
X-Forwarded-Encrypted: i=1; AJvYcCUKrGt5Lq6feZ6yLnhp2uIi5rMbhDe+mpF3GrfexJtyb0Pg3JTpfBsVACV/dZy5WCOVDvTJbcIceSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjlCgq5NIPrSTKsgfj1v7XAOSBoJjnQt3BFePecoNIwdHyXOLg
	K/6IF1S88DomG1J6v9boUoodM6VxN6HIIaFnpGQhQsRJT9ceaQ5fni0NV5FjrUXy/Vs=
X-Gm-Gg: ASbGncuRSw7+NGm4rcWlyyyrSsfLt9Sr1kRnCWYJCNDeDiNIvZRIu7EbcXv4MUcGhM0
	01Zj0IK4EvcW48S2aSlp0yrymwx7WQytWDj2I92bH18385HpeVkLYUIzjtBVmdqQVzUbZuThQ1o
	ncN21oOcUuTsqV5WQoGF0qATofzO6yltMyH8+rJ40bgSUL95E8pt1hAT8Uxr8Uh1wItQrMXwYVb
	e4umvYtKc0I3Ks3MF7RcsAa8QR8xDrCh4e+K0cO0+4gTPJYARNryrjkDwkPz/ryS2idf4HAreCi
	Pb5FKO93G+IZ0eFgt+5yeU4PCNnoS7xGa6EraIWAw9QjMZw843U9X6pFIQ4MWBs6avzkcQt5kh2
	Tb/mblJjEyA1uBrTvlZSmjLH5vqXNOOFTwPlXEG0wghMbcAYn2Mdq495Z+rUknA==
X-Google-Smtp-Source: AGHT+IHe5lAzWjWDvJCFogBIEALW5gpfBqEkMqvYFQycFRK8V9Sj7RWuB+XR82yqOPaZ8o9Y1wrxQA==
X-Received: by 2002:a05:6000:290a:b0:3b8:d082:41e with SMTP id ffacd0b85a97d-3b8d082070amr978411f8f.57.1753969831203;
        Thu, 31 Jul 2025 06:50:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm2657408f8f.46.2025.07.31.06.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 06:50:30 -0700 (PDT)
Message-ID: <b9e7954b-442f-459c-860f-909decd87979@linaro.org>
Date: Thu, 31 Jul 2025 15:50:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
 <fmn3mrcbih3oq6hgl45jipdofko46ur2sux5p4lf3nzlpahklr@3tm5molhdfdx>
 <n4ivjvd6hq7phwkzbmvg2tqtejc6ufcybslnyh62kegjkhdvoj@cvfjwstrhlwh>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <n4ivjvd6hq7phwkzbmvg2tqtejc6ufcybslnyh62kegjkhdvoj@cvfjwstrhlwh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/07/2025 11:41, Uwe Kleine-König wrote:
> Hello Daniel,
> 
> On Mon, Jun 16, 2025 at 03:08:41PM +0200, Uwe Kleine-König wrote:
>> On Tue, May 27, 2025 at 10:58:22PM +0200, Uwe Kleine-König wrote:
>>> With the goal to unify all PWM bindings to use #pwm-cells = <3> update
>>> the renesas,rz-mtu3 binding accordingly. Keep <2> documented as a
>>> deprecated value at least until the in-tree device trees are fixed
>>> accordingly.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>
>> I would expect that with the positive feedback by Biju Das and Rob
>> Herring it's on you to pick up this patch. Or would you prefer that I
>> take it via PWM?
> 
> I understood your silence as "Please pick that patch up via your PWM
> tree" and did that now.

Yep, sorry missed it.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

