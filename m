Return-Path: <linux-iio+bounces-24933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AADCBCE919
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 348F64E6E04
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA712264A83;
	Fri, 10 Oct 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iFLkQlRf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD3258ECC
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129796; cv=none; b=soZAGF7MAsefIofjhAryMmb/dSxkCToVCpegYdF7XqHsPJ42Zbsa/4q53IOyvUeI+CUrKb0y6xq4/pOOP0U88KcuBBHf8hNsmcqwPq7oKat2fUzo2VktqLOCS01ZaZEr6fMw7YhLnssarx/JutFTTDIMauhQ9NQ0wHAkiXXeIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129796; c=relaxed/simple;
	bh=CCuYNuIIVsY7FaNQiEz2s+18rwWUhIG0BCeJOEXr7Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qM8jbcwHHfOmVn0AqD/nc0/mjnT6J07mNl/MTd0dKJZdZcRHYiNrPIQhZsdo+CdmWAsiUiJz8Zu7lxgJZpGAotUwNAPxAXadzC8gebf7aaZ9S9mx9IPQ3JDM0aKuXs93e60MO9hZ3Qiv/kawds/9z3b8TYVGtLAyd4SehouyD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iFLkQlRf; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43fac2df7d4so1199363b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760129794; x=1760734594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=iFLkQlRfKAxRQ6MLGsgDryfgmis9DO4UmlLwTj6IOitWDT2N6udOwDK2I/b8wr4h3z
         6NCYAIBWqfrZL3cFwJRP+F0xb6t0r/HpWQcAvdhMaOK6jo+1+NvLyLkqN3iSv/WjATSl
         qPX3xdlR1sT23/gRer7D0dis1yu1iw02luV8hQSgmAs6N9SmykQpZLEv4PPuXoj3sb8m
         NZ+8x1dvsyafeR0GyvVLlB5AjsQhwfPP21eRS5CZLVywWn3PmNxq2WG4wxaIu+sJdoph
         y/FV8l9+RSWWLv3/rmRArBgB2LBfvhCh2vwTr1YuPPlynT0oVzaE4k/TmVCNMpUMOf2Y
         3lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760129794; x=1760734594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpaXFAs8jrvhj5Iwajcw+7el/YiNtrh4pH3E6yC24YI=;
        b=DKHY+UoVIK2e5NoVOwsHq5Pab7sWE9KByIlpUDEqGm2ULS0AF+UJRpFpQ1Lb/R1X8C
         VyX/yHEK5yH7uDv1M1MU+q9j7v/4lI4eXrX11ESlJG0ucDJDQIlu1yJRIi1XIbmQUGC2
         2P9u96xc5/l5iTc1RvHnXBVrJ410lwqUZpQS47EVbEPDrI1E/cKNriendIZxH/2ShCc1
         ll4q7BslHTv97yeM2IXPpjuQ9OmptkkLgdHBT28dif8yLnUOjOzBCooY9rq3kgZIZV2V
         0+EpSziSRnOwMqzy4DP3oWUPneyF6q0h92nWv5xa3wWrIm7R3xY4VfX+qBc0v1tGaMP8
         /wVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZMJC4CYJ1htiUxyB/MZRH0MEIE/GC/fLoG5kJOZ+w0XgQnmIPfh0fHxF3d63eNbdTIif8FRvgmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Tb1z7PrZUgaYr4fDLV2qJbNRXGyEhoYpzjxn/XFLt+bKe3Iz
	qyVIi+FCOVAXyAp0NZR/LLdwpXbCej3EskL89Iy95l+UftKf/Nc8AroO2gagm5k6wOc=
X-Gm-Gg: ASbGncuxGxDdtcQHyGBGhm/lNm03cZEqwdprc1f6ol7siio9pkzwPT4v8d31kYaAqaK
	rQJAMhOXf8398x+cCgED10WQFBOcByXbL9vBqStB6S8q2Rxa9tlwYrXDlIMSwG4EJys1fKKrXbh
	MiQlLzO7VCnLCTatsFtRZvQv9v5Kbh6vv+RKGRWZQxEH0uCxqjgFhvD4tqt6m/+F1t5qa2yZAgU
	tFqUdLYD/NSdoQGfRGIXjSATDwfll2ohDVt8AoSv+5Iq/jtVtd3OOr7KnNqtALXPm2ItZVilVmj
	mjQ/ec/kw6q3jkiwuAYMr9H5um8OvkNpXKkmHe9oyDVtbS+inK+FdHvMxLXKHNa0eclMG2lGSSb
	io4YG8qiIIjPAQ55ynq0Y0vIONbmVciWFXPWvPtfSyFFQMj3V4KrqN1JHUa5RannwCsSe8a2qKC
	vqJoGKOwmeRxkmPsc7Alwm05N+gg==
X-Google-Smtp-Source: AGHT+IFDRZYD0tvp0ZMbppnD3D1rHut3LIprbR5X32btFAwVwdld60PTV7/IdSY1ynz2HldpOFeF3Q==
X-Received: by 2002:a05:6808:4f4f:b0:43f:7940:69bf with SMTP id 5614622812f47-4417b3acf95mr6013690b6e.26.1760129793687;
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f? ([2600:8803:e7e4:500:8a0c:c02d:81d3:2e7f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65018200761sm952285eaf.19.2025.10.10.13.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:56:33 -0700 (PDT)
Message-ID: <c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
Date: Fri, 10 Oct 2025 15:56:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
To: Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/25 6:21 AM, Luca Weiss wrote:
> This is an RFC which implements a potential solution to get battery
> temperature readings working on for example smartphones with Qualcomm
> SoCs.
> 

...

> 3. Add temperature-lookup-table as property to simple-battery
> 
> Since the NTC is a part of the battery pack, adding a
> temperature-lookup-table property to simple-battery would make sense
> instead of having this lookup table be standalone in the
> generic-adc-thermal node. However being able to re-use the existing code
> in generic-adc-thermal lead me to the current proposal.
> 
Did you consider creating a specific compatible string for the battery pack?
Then the battery node could have the io-channels property for the ADC
connected to the temperature sensor. Then a specific battery driver could
handle the conversion as needed rather than filling the devicetree with
conversion tables.

The simple-battery bindings are already far from simple! So I would not
be inclined to add more to it.

