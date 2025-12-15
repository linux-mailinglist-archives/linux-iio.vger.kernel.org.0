Return-Path: <linux-iio+bounces-27086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACC4CBED15
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCFEC30806AA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EC30B522;
	Mon, 15 Dec 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ycSN/2p3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EC309DDF
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814185; cv=none; b=MN74d166TjXyeDEBmOvrAqKmIixOhjqohF9TPqd2WV9fi/uT7iv+cBp6CZ5a5ekLJCNHGh76bGKeQJwucUE5ZBLd1avucIdyFqX4EDnfIQAY7VB0ulO2Dcpdq7o28AKW8nDfk9Ju5U4cZor+owWX1Z3f6aPRnyBtNPUi/q4+zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814185; c=relaxed/simple;
	bh=bfyMs48aRUZhHp+2p2EP+KEcBZbqptYqV9EgG5cDhs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7rv9X0Cj7oi5zZ8f8joy8Z7fA6yu0BSvHHXTkCc8rQzlVYOfPpTjj+cIXw031K/vneH9FhPEN0WCH0tpnUF2Bujb85v1oqCGVZ+1d2gfaJKgLB10yD9xwyVUl04YxdRdM5SohdsMgT7VXw4fKwsRjJ1CJrVqS6DxZS86tcxYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ycSN/2p3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-455bef556a8so1186846b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765814183; x=1766418983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCRI9b7b+POzYgNjDGhNkEuNpEL/SKnGbtIDl/q6ytk=;
        b=ycSN/2p3Ai+PFF62F9QxcPP3xd5jkUwHua/zMHZyY0Ky7WOrAZkzkR4b6FTeXFl+tO
         ZTPxQ9nhMhqomv8Rqaqg1XOj76MFvTvpWBKklRo+mGik2ZW8R3tBN3S5i4EKuq3yQvqk
         RK8Yich25JVNIiVcpLMRMn2UFhVIbKbvlSlozcQnVOV90y1wHNPNIWmKVOW7QilOvNHH
         5OMX21Y5ryn3L025qV9Jv/KAVAYvLkeTw3KC4PWavkih2++1J3+RVeYISPMnGyPa72Jb
         urXclUGXXaeQckd6vFEmf1X8DkrhgKsV/TNCTGlA5QN48hNKj88KxQePLechumLMnbnS
         B3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765814183; x=1766418983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCRI9b7b+POzYgNjDGhNkEuNpEL/SKnGbtIDl/q6ytk=;
        b=pyDr0ieI+sTCG1fcqS+HevjwGDXFLZS8hN3eE6Z8UF6za2uNOx41EOK8TQ7EfnAeEq
         HxSHFmzyC7m92nlRPk6l5e1TCtq3usRelQvMXcWleitqqiqM5GXzRULQBb1GuR6DfjFt
         GVNcrgXbsG68CgGucWJp39Wpash3PsjnmTVA80JO8HAOGFowgLqV6CJtIoV/9FhIf0uE
         ZtRRRUKBZciu1J+ucpyqom+GML4CENuCrUAAiD9kY83DBjVJfSCuXthVlaQ1bxlZaP9a
         gAVJCqDr+xNYgeSsZJxelZljbGE1N6LW7lixY5BBedKvwsjlzpNQYOEb0Y31AHuDQBod
         6UIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhgbm/E5XlgPQ7s+FkoiqF2AsHFE0TglJlVenx+wWV0sg8nQmEixfkHSKx+aIkQi80995yGq0TVlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEqnOcFpBRBW0qe9PHf33Wj9iuLW6QGAiCbMHPqJD4B2yHGGV
	fv8DD+VWOgfhVbmsHzMeRKyiMt+U6gBr27L18BweQp7d5ugkzaEI7TWY2EuVm4pjuOI=
X-Gm-Gg: AY/fxX5PJahUjIVj0sCTWU+Zv4R47aqqL79Mw/BSaSQG52UJKZES4VSawwHfW8mtE0f
	QRYXW5KH8hliNd6/aFRcGsxrRl+Zyy88xhmLRFmxGSDDdpv3d8L2Fi4GfYVoDmoPl918q1WAo4f
	TNn1o4yCrtUf1vemujjzO6kmt5T+sKwFmOP7I1C9qwkJC43VjqgJW2Nmk7qmk4sYccbkX5s0IvY
	6q6x69ccwLM3g9cjMAvW6fTnjVh7BqAOm8kZsZ+3rFc+yXZ+vWgzUrrRNzuoCUj0dNy8O3ntoXs
	SKXbCEDixrBSzct4/jvaNxRgUWOKqKSLvXE66o+7oxiFz3ZRR5v25ClQ5/V8/R16GIKSFFj3XvS
	drKnbilq+CR1zIHMJ4b+7ufwndQ0aXrPSXj20Clp/rX7ZQ/4R3O+iylstUrB0anu4/pB4lmXCbS
	7sXx5lolgE8xBFlQ9aoZM+ny6or/gWKw6qlzKIPwnP9CrIV0skFKPG7HsPxtpL
X-Google-Smtp-Source: AGHT+IGzE6OiEERQD4eJyqYwrvUcv4rFzKimWGDUsXwbBsx6WEQA/Zl+LJdQtKihwmZap/SSTGwdDA==
X-Received: by 2002:a05:6808:bc7:b0:450:7df:e90b with SMTP id 5614622812f47-455ac957fe4mr5222380b6e.52.1765814183225;
        Mon, 15 Dec 2025 07:56:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598b46bf4sm89470b6e.5.2025.12.15.07.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 07:56:21 -0800 (PST)
Message-ID: <9b73421e-d08b-4480-ab28-5ff5a845e264@baylibre.com>
Date: Mon, 15 Dec 2025 09:56:20 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tobias Sperling <tobias.sperling@softing.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/25 10:25 PM, Kurt Borja wrote:
> Hi,
> 
> This series adds a new driver for TI ADS1X18 SPI devices.
> 
> This is my first time contributing to the IIO subsystem and making
> dt-bindings documentation, so (don't) go easy on me :p.
> 
> As explained in Patch 2 changelog, the DRDY interrupt line is shared
> with the MOSI pin. This awkward quirk is also found on some Analog
> Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
> inspired by those.
> 
> Thank you in advance for your reviews.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---

I had a few minor comments on the driver, but nothing serious.

Reviewed-by: David Lechner <dlechner@baylibre.com>


