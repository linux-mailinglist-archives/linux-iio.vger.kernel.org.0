Return-Path: <linux-iio+bounces-27822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7AD23ECD
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54919308E99F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A493624A3;
	Thu, 15 Jan 2026 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJpFJjBU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB6535502E
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472660; cv=none; b=CM+F1eejVxyppJSWvE2x6ELL4bei4fA7nuKdgj8lIS23b79WWzJy3IPEs6mtLo2MEpBd1LroH8mixG9hVFCB07WCZO1ITc/gQTPZ0Xgu8jzuJcZLEsuJev/WSI1oK/ocCj/KSiE7ca1PFetLtQEJhIJPOfs1VLd74VSzOMRPzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472660; c=relaxed/simple;
	bh=LnL8PEILXOHYUFOavVHmQg3bEM1znin2GHQAseAU4rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aip/aiQRGyZjomzTPZ+VQ+QAK8OuvR6fUvUA9TAh3TFWKAHupUJN9UpdCvxiv+vD4f6LklsV2OYqb62UU8JI2QBGS8nnZbPglbXQ6V5ZHG9G2kUmsS+X+Kkr5bJTQ2O/xH8MxcFdsfdvTddAKmsur0Xl448oAqI8Xw/jWrd6ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJpFJjBU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d256c2e6so610695f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 02:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768472657; x=1769077457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnL8PEILXOHYUFOavVHmQg3bEM1znin2GHQAseAU4rg=;
        b=NJpFJjBU3/XqtxVRr3RKFfQ16T9hVyIFJbV3/rWMI9sttdJgyh+GfoLix4B+3/7ijX
         VP/uknAJhXlX8sg354swG7hAhAEsBjlmWwCliL/rkvnWTnqMXHDrzz6YmEZjPX4Wd2ea
         AQBRKS8GpOQut4BCrfS+hyeNA88E/pmTqy1/yGU4jbzWDEn4r/BjVo2GDcbd/ug7Bttg
         pJK8OTEUV1RkRV56rUfkBmLvIto05mmj/qgE3n+FRHPsODOThQXGDsPEK6tn+vLbAE5R
         gjmLd6pimTEiU/ntiQig322ehmKuTDMBZpSOxsQgJTCW3XzvDGhKgv6GzkWHC9RoCjI9
         RqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472657; x=1769077457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnL8PEILXOHYUFOavVHmQg3bEM1znin2GHQAseAU4rg=;
        b=evRNV0aZ82yVK00+lsHGiEoNQZmVPUHHnOYaOslq/cRgqrG+3etlU25grU7fADCzoj
         Qhh2LctxSBeF/d+cJ2KY60eKgBXUyZCCUcZMFxU50ynlurpX2pTq7NScNwsF4If4zt2q
         o9OQY7N6W07z14mXxMoFPEWsZGrqpZwuXsg8nLGMzjrFxE5Fr6D7rUcKDUyrfNTPaFwb
         iYcZUc6UkYs6T+uaI3t5I5SgWOdimo/URKGEvGnzPiTxJDMsOGRTKqVavUIHShlVDztz
         H4fJtSc9C+fu9JKjRiX/bKZwk9vBea1zTjCTbpYIF0avPcWRdwFqhCv3o+ft2Bj9PPKW
         2vng==
X-Forwarded-Encrypted: i=1; AJvYcCU+2V3UXmUizOnZ+j0B9EpI63S9TW3Hg16DbWKvQ/csxBl9dA+t1FC8kWqObln5ncz47aOcn9kUxPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rO+DIRR7jG6rA5eShrpMcKiIVQ1nh+S/R+sfyaoXxLiQYgX9
	9dSUxpo8EZGgeVGKxlWvZy/uwIq5hS1wE1SfOuitR0attot6XcAKhwWG
X-Gm-Gg: AY/fxX55vwBU6zA3VO4cV1WJlqbQm4SJ+WVMkKwDNqPsVNIhUil0xK7zBaFeK1Z8S64
	Dz7PvxfVrHAEXXmx6pZT0TuJnputRztWiIneNe2w8IWGI2Zm/syHHHnQggJmwKGimXJzxVUxazY
	grgvuVii+zShCyt/7H0b4N4BFC2i5cz3oDVqoDMjVM3q8q6Ame+3mLQTSWjhaI2i2pBYZBxwTzd
	JkpLfdYjpAsUj4QZr9k7m3XlFd9Ya8YuAqXlpjIrvQNwhftMbAUtVQkxqv+1lnReRXP5C40q4ZU
	cXHpOxAsRh3U3UJZvFQjLl56L0iqD/VnCtwjcH+K7YALl2rtMOGaeUeYGQbjNjoM64lm1NeTnJa
	TqnWbJKFkYiR2ZC75eU/gdzLnCguTRfsoqu5X+ToZW4dPvF+BMQR2p6cp6PoIa5vWGEj/DhDqTF
	7oxfPXuNUMXeAwhn3Ec8TSY4IYAQ==
X-Received: by 2002:a5d:5f49:0:b0:42f:bab5:953b with SMTP id ffacd0b85a97d-4342c5010f2mr6772659f8f.16.1768472656687;
        Thu, 15 Jan 2026 02:24:16 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b29b7sm5062627f8f.23.2026.01.15.02.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:24:16 -0800 (PST)
Message-ID: <5b3cc813-9244-4ff2-b00a-cc8dbab7e144@gmail.com>
Date: Thu, 15 Jan 2026 11:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add max22007
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gastmaier@gmail.com
References: <20260114-max22007-patch-v3-0-769298f50b8a@analog.com>
 <20260114-max22007-patch-v3-1-769298f50b8a@analog.com>
 <20260115-elegant-hopping-kangaroo-6cd32b@quoll>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260115-elegant-hopping-kangaroo-6cd32b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 1/15/26 10:24, Krzysztof Kozlowski wrote:
> On Wed, Jan 14, 2026 at 05:17:01PM +0100, Janani Sunil wrote:
>> Devicetree bindings for MAX22007 4-channel
>> 12-bit DAC that drives a voltage or current
>> output on each channel
> What is happening with this patchset - why are you making somehow
> unrelated, different, unexpected and incorrect changes like ones above?
>
> You are supposed to work with Git e.g. on dedicated branch, so you
> clearly see what you did. Why doing such changes?

Apologies for the confusion- this was my mistake.

I picked up V1 of the patch by accident. I'll rework it to address the incorrect changes and will resend the corrected version.

Regards,
Janani Sunil


