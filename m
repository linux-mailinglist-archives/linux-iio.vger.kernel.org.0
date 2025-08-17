Return-Path: <linux-iio+bounces-22870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54037B29447
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 18:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9937AC108
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AC2FF646;
	Sun, 17 Aug 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EPiyHYJA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BC29D26E
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755449488; cv=none; b=DUlG30yg2YDi6E93KspFg6F8P8tyJBLkvfiOsjU9cTu9uk/yzpYhS1naxZBQkMy1iRuYT2EuzKRqGhj+wmXjRy2g1pRd/69K1QIsTAyHz0xiH6L45PSfcYwHLSstz+D0pwgG5bbGV1FB3EKLLmyRw9Ft2+UuMaDxkmcFemE9SAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755449488; c=relaxed/simple;
	bh=mg9G1GrczvFU5RkdMi7X+2IDftbj0oeSDe+aPw5yECo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rOkE3TD389f3zmqQrGmRljlArZFQshaU4qBj+tGHyWFgzjtpiTTZGIQxWOodxUB7Gfkijt/5c5ifB25VHTNJY7jvctbMZCWBKHHj5DKuiy1aRahDU4+Qf94GjRggMRGURwJ3vXH5TQ/6FW1au1xZFmZGGxCrgtWMo1m7GeYtsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EPiyHYJA; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61c044ff13dso133284eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755449485; x=1756054285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOShuqoDRF3qNIrD82l+4By1/XWbaXr8sdy7PQ1Fw2E=;
        b=EPiyHYJAdc4q4zs5Cpr/ujY7QAwZqeojGZk721sUIZRT/SKmGLDKXyZNRBoDF1Tf0/
         n10TL/9En11MhQnUT9lUHojjMcJQKRS4ie/4qnyZhHXyJUA4v2ckP5KkpXGdsKfjf8U0
         Vw0G4Pb/DHH/Q8jBKhXXGyUZ/5Dg042O0snwsORrzCh+m2BlBk0t9pkKYvCgsK3nw81h
         DsKPBYblwEUgySmEIQedZ7avCZZ4SLxBQDCtEL3A9JGjlUwZWMvzZaP261WdMOV03Aij
         ukt/XjUvBhFdhP+woJNej6gKM6FPwSyHqC5zKeU8iRcxFDv/rZHCjt9/TPxinz41MdLw
         QGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755449485; x=1756054285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOShuqoDRF3qNIrD82l+4By1/XWbaXr8sdy7PQ1Fw2E=;
        b=mHTIEouzd1Qo1cQXaIbGQsvvtfL6Tm4PcKE93BTB1QScVc5jc9Q+ncaVrS/UiexcJZ
         AvhgwYFseKGqQ4ixreKII7nqSpvUoc9pPYrIaFmSxyNVVkYGYzgn3vdxNeWydh6MRsEH
         HVthApu00iCur7VtqPeKjdmYUyGjwCj8EtomZBBuY1ljLFI5dkO4hBVlKJ1vtowmVbal
         pjLTuRsFt/RIW4o+bwFdbVl7GFK7FXC+InglVlClUDP+O/F9eF0CP1pwk0dIavZw6pRJ
         5yOCkXB+LKVd46dXPljVJrpSuZ8yxvd2fxGnpE/V8taAe2tDNZzv8zGEs4w0pdS2mPZY
         zopg==
X-Forwarded-Encrypted: i=1; AJvYcCVduk1x4ALZytj+EDyuPaYJfjB73u+U8B2cQgz2NX0DcePS6uxsz4wZNhgmWJRA5rwbXb8ieZgF+3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmmuPin05MOMSNCaow0AFGxz0SkVtB3qWO/S4apBXyy9aGYJx
	/MvbHY58yEOCHjmhm10yt2ZOvYoA3/wTGqXyp3K3+ED/0W1m2yaD+ZGcX3GKCpNFbUQ=
X-Gm-Gg: ASbGncs2CVs8ZvJ/oOP8jUR8xz1U7qF1EwBw3LDhLK7RUs2YB7++05BqFHMGdYOLzhQ
	o9njGhdpeoMFDBJO0TUEo0dKqbrvlPNsOy5AT/VCCOxTtMv8O0sNalJeiqRVXS4uQhzsHHaHikh
	Be0BYNz7O0EYO2B7Fk/9SsHaMS9yPrkA+TJnQDyK3lyHVdzHHvnW749PeJFxnqXz6FmlOfahsK7
	G4sWyeJM5b+zzcHzNa2SO87X9ANFp8MV0u1IAdXqnNFsRd7KhQdVGXSVuuEidrvllTkQBPLM7CH
	poqjelPnHpW0c/x31afT4Q5av8Wm5ppbuHUlmwUekIlFhYeE+RJfTTj32VtBmaczNhQwhntoWHd
	7w43op289+unvf0ugtZrLzYArxRGmJA+fEDl/YYJYfS5BZ6Og7VqVjDHpevMtoOqKTQXCh2umCs
	w=
X-Google-Smtp-Source: AGHT+IHEHGCIqwCnGfFIsenBNXcfcUHPcRSF4zc4J/GNqwgo1/8d2p7odCKgdZCjhOtzdbOmvx212g==
X-Received: by 2002:a05:6820:5106:b0:61b:fa44:2318 with SMTP id 006d021491bc7-61bfa443307mr1755652eaf.0.1755449485031;
        Sun, 17 Aug 2025 09:51:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:7648:43db:38fd:de4a? ([2600:8803:e7e4:1d00:7648:43db:38fd:de4a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebf8d16dsm671683eaf.1.2025.08.17.09.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 09:51:24 -0700 (PDT)
Message-ID: <8e228d2d-d22f-4092-8c6d-94ce989b4a84@baylibre.com>
Date: Sun, 17 Aug 2025 11:51:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
 <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
 <2025081711-coral-aardwark-9f061b@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081711-coral-aardwark-9f061b@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/25 11:37 AM, Ben Collins wrote:
> On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
>> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
>>> On Fri, 15 Aug 2025 16:46:03 +0000
>>> Ben Collins <bcollins@watter.com> wrote:
>>>
>>>> The mcp9600 driver supports the mcp9601 chip, but complains about not
>>>> recognizing the device id on probe. A separate patch...
>>>>
>>>> 	iio: mcp9600: Recognize chip id for mcp9601
>>>>
>>>> ...addresses this. This patch updates the dt-bindings for this chip to
>>>> reflect the change to allow explicitly setting microchip,mcp9601 as
>>>> the expected chip type.
>>>>
>>>> The mcp9601 also supports features not found on the mcp9600, so this
>>>> will also allow the driver to differentiate the support of these
>>>> features.
>>>
>>> If it's additional features only then you can still use a fallback
>>> compatible.  Intent being that a new DT vs old kernel still 'works'.
>>>
>>> Then for the driver on new kernels we match on the new compatible and
>>> support those new features.  Old kernel users get to keep the ID
>>> mismatch warning - they can upgrade if they want that to go away ;)
>>>
>>> Krzysztof raised the same point on v2 but I'm not seeing it addressed
>>> in that discussion.
>>
>> One could make the argument that these are not entirely fallback
>> compatible since bit 4 of the STATUS register has a different
>> meaning depending on if the chip is MCP9601/L01/RL01 or not.
> 
> There are some nuances to this register between the two, but it can be
> used generically as "not in range" for both.
> 
> My understanding from the docs is if VSENSE is connected on mcp9601,
> then it is explicitly open-circuit detection vs. short-circuit, which
> is bit 5.
> 
>> Interestingly, the existing bindings include interrupts for
>> open circuit and short circuit alert pins. But these pins
>> also only exist on MCP9601/L01/RL01. If we decide these aren't
>> fallback compatible, then those properties should have the
>> proper constraints added as well.
> 
> In my v4 patch, I'm going to remove the short/open circuit interrupts
> since they are not implemented, yet.

Don't remove them from the devicetree bindings. Even if the Linux driver
doesn't use it, the bindings should be as complete as possible.

https://docs.kernel.org/devicetree/bindings/writing-bindings.html

> 
> I have VSENSE wired on my board so I can work on those interrupts and
> register support in a later patch series.
> 


