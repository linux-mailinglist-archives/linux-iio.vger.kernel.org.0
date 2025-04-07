Return-Path: <linux-iio+bounces-17716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD7A7D35B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 07:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798497A42BB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 05:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DA221F11;
	Mon,  7 Apr 2025 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/qn1esx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22B38FA3;
	Mon,  7 Apr 2025 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002727; cv=none; b=Vq3Yez0jbqVz0e73NP8nzhcH7N8Slk7z+hAzero53j0ynKybX/tY6LDrD5TToHSP+us6G6kcQDYDOmTR9vEAzN+7mUSrspfgtxqBF3cZTEnfw6VD4p/41l/wswxHJzna8Zeh3fR20QekMwv25M01UFAvxzz6kryvcdqXZIj9Oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002727; c=relaxed/simple;
	bh=QaBsiaRQOjWtXaA81fyL42VtV0lP2uT41YRIkX74bKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1lWCEqouJFacvrsxX5WBsjC6mL10gnQRhGocSUbqJWHWvP8oZiyWHbTgk0bnaC8K1eBb8o/++ZUthmxMcYSJZAYi0BAw6DXVSHDLzQCUplB5ntBeDC6Buc+Cdl+xfm3UIeFojTvzhN8+YhDA/bFQzBxAovPjzvBwti/dMJKciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/qn1esx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549946c5346so4662744e87.2;
        Sun, 06 Apr 2025 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744002724; x=1744607524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvKDzlFyoKpEFPzUMWqfy2uX/HPiJporHZaSe0I1Tv8=;
        b=f/qn1esxn6wW16bo8ZTKhvKjDXcST4Hh/FGhveejASlBPvrmWY27s/QRczSc4ULujJ
         c5ApaAy7Q6zerbZ7hKDpJcjzNa9b7KNm2Jr9UHRLcyd+cOKUJX62fMnyIbkWbdbuC0xk
         Ebh4YtlwseAJ3MiT4TUJe8lEosz9RcI5OGcTMPe1kRpkU6B7D87zKRg5t+iE0B8xAANW
         jrE3JAf/8JatN9HK8Zf6swLBqAJMlOYFoD/0BU90IEOxl3YOdiOyW7BIeOSlw9XC5HOy
         njYGs/KCzwzMim7YzIKCQFP2StajrJpjpeYyLDaGXdPdkilAV4ENoOAb3lYuRihSWAxq
         YJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002724; x=1744607524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvKDzlFyoKpEFPzUMWqfy2uX/HPiJporHZaSe0I1Tv8=;
        b=eVN0Pz7tyOMIQSIIDuthDbJ5rLsIHSdzD+ObM9ZitasF3pxCNnd3MNZHq8AhmkDLTE
         RPQ9SrjJwIXXkQPZL4MAHtems6hrtxfTVFuUFplWQP/gwbjr0uNN+nHLP8x8/978IaZh
         /AnlVG7qlbBzaUeAHUnB/kJfcC6KquuWzw0eIMSgqBP7g9iaxMkSe/qz2bJZIdKxtErt
         ufFLs35dWwRNL5aWDpYV1u80nfLamlIxq46b6Fivg6pLxJDO3czE4yt0uIr0pI93qvgY
         b59h7bvKWPpe4f3SvG16BeN2znMhRRu54Ze3BjZOi3OnRa1EGyNY57vq5fpTAiXM71cn
         SRvw==
X-Forwarded-Encrypted: i=1; AJvYcCVaxE2OXZnzYRc+L83mML1joZlLF0JeSfCuBFX1oGaNI/dMXSDFCwVx3oFUQ07iFw4zHQshUbPTOq62cbuq@vger.kernel.org, AJvYcCWg6LDJSPyZSYgZpx3Y+5MQdMJbBdbKdQykrAL6/dyZD8vpenECEeRww0odrcTVGTS4NyXfxLKmJOu/@vger.kernel.org, AJvYcCXogD5CYoLAfJSX6FHX2tm7Om6btig54y0jB4vubZAYesguh0vygEZgXP+jib38sgJ2l7ooZP5ZQOd+@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXRcRmIeR+lTRrJ3NvoQ4P0JGAesuEXft4ZHHURBDJ1q3iX5r
	LTWNxhh3/yVyQ8cDFR31UtYvU6KCgJBs7ELWSEKjVRjBc2rrmCdU
X-Gm-Gg: ASbGncvxyH+iEXnQA5yaJQx0s08YRWIV6T8dWp01m93Sq+nSeb7rrebZJLW2/QzeH4K
	j31xVjDUZqGnrd24drs4gcwfcT9VSrnoE5UWByjdCf8sYQoGGRs9PlNEWzVg2EkIK9WnqA78Ny7
	TABgAbW/ZDcdY14CYystxIK6GEBbu3TURQRoYCnn8yAQcPEd46+EtF40rGnWnaMwnMJvKwfE+fM
	lBy/35QfXSx+NAZCj3NiPHdDhj4Pg2o2/3Q7BfRVjTEipsRRMpGZwnW3GwpcUfMgGEhi54Nh2Rh
	G1msyZA7qr+hrmabDMLfsBduR60HFZIFaiNGZgE3/XIe/3Pjwsum6rLNrZmSZ4xwAwUgYLvj9u/
	i9DLGWAJQunExoq9UGdu9RmhOLA==
X-Google-Smtp-Source: AGHT+IEZdkpm+GH6ymlGVCC0K5uFHI5UN/7NCy5b6FhS0dRNmLedbbGhMNo2qMGwv5dW4mUctXfQnw==
X-Received: by 2002:a05:6512:2316:b0:545:1082:918d with SMTP id 2adb3069b0e04-54c227dc802mr3418200e87.41.1744002723669;
        Sun, 06 Apr 2025 22:12:03 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e65db99sm1134600e87.207.2025.04.06.22.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 22:12:03 -0700 (PDT)
Message-ID: <b77155e4-9f60-42f5-94db-1d2e4c0aed55@gmail.com>
Date: Mon, 7 Apr 2025 08:12:02 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Support ROHM BD797xx DACs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743576022.git.mazziesaccount@gmail.com>
 <20250405181838.1498be04@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250405181838.1498be04@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/04/2025 20:18, Jonathan Cameron wrote:
> On Wed, 2 Apr 2025 09:44:20 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support ROHM BD797xx DACs
>>
>> ROHM BD79700, BD79701 and BD79702 are very similar to the already
>> sipported BD79703. Main difference is the reduced number of channels.
> supported.
>> Also, the *00 and *01 variants lack of the separate Vfs pin.
>>
>> This series adds support for the BD79700, BD79701 and BD79702.
> 
> Series was nearly perfect but I tweaked one thing...
>>
>> ---
>>
>> Matti Vaittinen (5):
>>    dt-bindings: Add ROHM BD7970x variants
>>    iio: dac: bd79703 Store device address to 'address'
>>    dac: bd79703: Add chip data
>>    iio: bd79703: Support BD79700 and BD79701
>>    iio: dac: bd79703: Support ROHM BD79702
> Made the last 4 patch titles all start with
> iio: dac: bd79703:
> rather than this random mixture of prefixes.

Oh! Thanks! "iio: dac:" is obviously the right prefix for all of them!

> Applied to the testing branch of iio.git which will get rebase
> on rc1 sometime in next few days.

Yours,
	-- Matti

