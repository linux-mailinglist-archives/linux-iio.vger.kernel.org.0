Return-Path: <linux-iio+bounces-21996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62697B11035
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63879189AE00
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E152EA730;
	Thu, 24 Jul 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtrt+9Or"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB81E04BD;
	Thu, 24 Jul 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376909; cv=none; b=oWl3hXNsPqPQ/toz5uKOxBitRk7iktZr08BeBBlxgLnQyNTsFuX8l5+9ezRpuQf/cBCR1wIGIME9d0F5KFIp9zl2Wy2s8CF0ztYELSTNaWYWaL39iWt1OJvzXup4M9jTGLic3jcB65fC+z2MpmdNgO+oLAw4uw2lnKRXHQi6/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376909; c=relaxed/simple;
	bh=qYSnfnL2VgMMjK8m+ljl891kemuRYs9JU2Qv0COLK9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsb5U4HOz9hr5rBqwXmZLp8Kb7gxoxtDwgLOn0btN4V0dIhj8YYizq2+cGROKwnFwoW08iMQJhtu8/2fRH8rlfyIQIWstOJ3wsqIkRMvo5tiDGPc9yLh5yM6y83G86vZ8H7QYJDN5dLdZBzW7PsQ19QFQSX+pRDOfIIdKOZuzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtrt+9Or; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso12831155ad.2;
        Thu, 24 Jul 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753376907; x=1753981707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGE95oQU+G3JZiNfJBXGaa5iowQ3KE+3XsZUyctMNlw=;
        b=mtrt+9OrFPT1hUVVtmb3yKXOi11UU7SXOWI50lys/pLral8JzyoH23n1h83W9pW5Tn
         eMu9O0ULQLRXB4FgjqI7CV/n636pjwuLNKM8Jwfy02pIAwZ02YqW9y+fbizpzWa5R8Hx
         3zYCZ57ClVNUDwg1rC3AqATnPzKzZyE36pt25rQGjQrWJvit/ohNPSWzgh7FFDfE1TuB
         ykjuNljw6iAWzhwloHnyoY5hBt+UjgjegD01Ko/ytM82FME8/3SsaZpUdowYhls34l5z
         hnsK8N5fylRPo8kzgbbqgljNuZQ5qqoz+F5hsunesMWIThHQabEWcn7rSXw7XntfvPhI
         4H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753376907; x=1753981707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGE95oQU+G3JZiNfJBXGaa5iowQ3KE+3XsZUyctMNlw=;
        b=tGcP0+1y6G8F1fxqas5O7UKYkLoqLG6ZuAau0BxjwqCoP67G699vEPBcqcAbTVKoC3
         WIYmd5eJr/B7M+dLyNVBuhs9bmfLmdNCl1bo4yRA/i8uhplKlgx8BPjI4tPudLgk74bb
         j8GPQPipDmI3baKgifsCyVKvFIeiKKWsKTUOVp8MUrAy47Sn7ozxoJ4fuB5YphHMTOW0
         +w/Ht8tdMZNKNzEdwLSIPSuHADxVVoEDZ5w5U7jRk940XwBM3sx8NKBKmK+qwEBCG8wo
         EKEeREpLBM7wF8VsqPV1KcZ298qFLLv09Eotlpkv4WXreLCVCdlI08h7wwZJVvi+fdwk
         oiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbuo9mVAu3yXrz8MVwqRwnzke6froydE33WzW0V9xdsIqaRaGKnVbHCmLCPCr9txMlyZT+m+CJ@vger.kernel.org, AJvYcCWnBDjOcIDgA7jhgQkUGqCw3wOyYauGJSUZngfB3lj8JqdEJ2+S7/2GcN+RWy/MAEY14jodBYi981VK@vger.kernel.org, AJvYcCXBkbgAHGEXF6+EZUP2fqWrFeMoJYFbssAFcR998ikWavEgTUIbRZ3dTzxcjB+PBIo/zbDkDywFkIzd@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/FcKVQ4kK3uzTbTg6Ox0Q/oOKprVLHRg5ihEnDhnXPaqKPo3
	wyKRMgacsUfuHsWb6u/K+yATIbwRjXC8soI1C3g6AgQW+z+TAf6K+TlXmnOq4liBNs4=
X-Gm-Gg: ASbGnctrtKDVZ0hKEZ/tQ+oBFh7lkTdv+4yxZbIO/1H/rXyln4SsznXjx84oOWMijT7
	/wpK3BhTxFwKcQpPHq0ihxczq3N/bC7S8ujl8H9z4EagoVb0yys1zzUdL/uI/HH2OZODdyC49DH
	J7flgs6OCmlwSvWavcQv/FjdS45isU7jpiiKKucFaQqGPF+oBe1yamz3bk9r3IX/YEXMbUkoe/J
	kCMbEix6KPFPoMfVziF9pe/9bE1d/LkL1reG8gPI6FLiciC67/J9U6Wr9lXfKw4lu0zNzMXmzKr
	ZKYhn5Oj+sh6YjLEIxadZjRJTB3DOhXMrsmZmb29PKm4mg3reAdR34nozyr17jzMLb3fYdK9Koz
	ogRtgDn3+MQGIqvHqPNYHt7mWdmRCWUKgAxEdloY=
X-Google-Smtp-Source: AGHT+IECIHPgvbnvMyXkL6JhqYISUuCy4X6A0DDs5uMshC624UH9yIdwB+tffpJsfG2tPfQ34zHI+g==
X-Received: by 2002:a17:903:3d10:b0:235:eb8d:7fff with SMTP id d9443c01a7336-23f981bb92bmr94356815ad.28.1753376907010;
        Thu, 24 Jul 2025 10:08:27 -0700 (PDT)
Received: from [192.168.1.134] ([49.207.192.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48dd816sm19783735ad.136.2025.07.24.10.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:08:26 -0700 (PDT)
Message-ID: <8f4358e8-ecd6-4d86-8326-25d21c3a4ea2@gmail.com>
Date: Thu, 24 Jul 2025 22:38:14 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
 <20250724111247.669d6955@jic23-huawei>
Content-Language: en-US
From: Sanjay Suthar <sanjaysuthar661996@gmail.com>
In-Reply-To: <20250724111247.669d6955@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/07/25 15:42, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 22:35:13 +0530
> Sanjay Suthar <sanjaysuthar661996@gmail.com> wrote:
>
>> Fix minor grammatical issues by removing duplicated "is" in two devicetree
>> binding documents:
>>
>> - net/amlogic,meson-dwmac.yaml
>> - iio/dac/ti,dac7612.yaml
>>
>> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
> I'd have no problem with the argument that this can go through either
> tree if there was any interaction between the files or the changes, but
> here there isn't. This is just causing potential mess if either tree ends
> up with other changes overlapping this for no benefit.  Please split into
> two patches, one for each subsystem.  You should be fine to keep the
> various tags given here for the new patches.

Thanks for the review. I understand your concern regarding splitting the 
changes. My intention was that, since the fix is a trivial and identical 
grammatical correction across both subsystems, it didn’t seem necessary 
to separate them.

However, I’m open to either approach — keeping it as a single patch or 
splitting it if that's preferred. As I’m still new to this process, I’ll 
defer to @krzysztof and the DT maintainers for the final call on how 
this should be handled.

Please let me know the preferred direction, and I’ll be happy to update 
accordingly.

Best regards,

Sanjay Suthar


