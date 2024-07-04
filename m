Return-Path: <linux-iio+bounces-7309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10346927354
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F612813B4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D111AB513;
	Thu,  4 Jul 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="payb6GNg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776561A01BB
	for <linux-iio@vger.kernel.org>; Thu,  4 Jul 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086569; cv=none; b=Thi0t7JtDFT+TOVyDqoJRqBCHME2IlQ/pmSle8KLrlgKur/4+ttJJNsyVOAB8i0YqiANLk9JILKjEsNm9B1UtlyHNxoiSosKqJkzJe+QF4oXgJIDx1rZ90IUsG+HX4cWy1AreeRM+0do/ewK73YRTm5pyLg6P+EDfL0mBXgVx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086569; c=relaxed/simple;
	bh=Jus/G1QYt5pW2GkfcctBOFu2WhTByPL9AV0yxHR2FHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoXgqZVvsMFzCvXGPAzN3q8OrQCKGEah2c2e8gdYbQSe0GXud5cH2K/PsBEOpGoirgZhNMwz7159F+FqoD1f0F4OGBaCPfuyLbMW9y2Sa0/Bn4JBDGZy1WdfwL30F/NzHOTjK4qTqEyv0HzSgD4nZsOm2tJqYsk/eart7mBEF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=payb6GNg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea0f18500so315872e87.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jul 2024 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720086566; x=1720691366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S8rvIrULCnR035Tkdqz8WyVCTyK2R7YGhGSnwvvSM2Y=;
        b=payb6GNgMrjJCItZWq+Z8qtQ/MyZG6p3FpgvLiWvHm/Ym4tHyzIy3L5Id+GLAWBeNY
         hJBC8lzXrBreocWvR2U1Q3GOBf9KVMgO62wbK/TMn+39aalvQsipzdcCwRIs5FMfagCi
         B/OcdECcdcl0mp7fJUAwI+3yd1+O/qjhK/Pk6ua3sa+QvK1/grwaMLRItsHhM/xrSiBN
         8e47yJ2XbY5p6wqmA1KdPpm4Y/+s8J8ZToJvmNgDKS3SrwxP4dx3JpX0NXfJRGGvff72
         d31Dwp7sqEldj+/gJ7fn6HR7lo1RgUj9as2u0UZzmQX0FUy2RrOUz6mP1tuAOP4in41B
         hLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086566; x=1720691366;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8rvIrULCnR035Tkdqz8WyVCTyK2R7YGhGSnwvvSM2Y=;
        b=KmLDFZ3sl5Wq/+iOB/MlsyGiDlTf+5s+FSCfW5uATLh3Yz197JkJNMkzVBJBOvGSFB
         9X6EeEhLz8c5+BDmzixfws3V3K0qCR/7HVyQAFV216962sddNBuTg+Vp7qY95zqkcUi8
         4nQQUf8Og8DZ4KQxBpfzjSUs9Arm6uqWAaTsy1UUqRk5mUs7MyBzyJvFBjofgEndpfqr
         OePDfmPBrTlY2dhWJujrlVPcKYnQoWeJw+R0dyQFGLRBT0wb9dZa5Et2free4MluuJhv
         WjpA1fGNUS72GTYsg0FOg4KpQJUVPhsve/UvECTq8H29bZ4f8tMeb+ZCIfDs9arc1bog
         CKoQ==
X-Gm-Message-State: AOJu0Yw2UPSSPDMWw29AvP4ZxkxCemlyWXs0yHdtl/AzZLYrg4Rq17/X
	CbpgwyQ3r7iV/qEC3MI2f/Vh0megu56UIP9icp6568mk3y9EEeuEX5JjWWP/WV8=
X-Google-Smtp-Source: AGHT+IFDsgZIA5XCVA0hy0WJu20063Iw4EiHYumlyD4TmspDV/EGAzJwVtvHSU1EkA2BUbUHNOdVpA==
X-Received: by 2002:a05:6512:716:b0:52c:dec1:4578 with SMTP id 2adb3069b0e04-52ea06ebef5mr672002e87.60.1720086565677;
        Thu, 04 Jul 2024 02:49:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1046f2sm17875224f8f.112.2024.07.04.02.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:49:25 -0700 (PDT)
Message-ID: <8d8363b4-e817-40f1-9265-16018b14497c@linaro.org>
Date: Thu, 4 Jul 2024 11:49:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
 <64fd897b-f87d-4a17-af92-5c6ffb481061@linaro.org>
 <CADFWO8FF24UyoD9cfF5NL1OzcHErx8+=bJYLrajrJNHFseK2HQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADFWO8FF24UyoD9cfF5NL1OzcHErx8+=bJYLrajrJNHFseK2HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/07/2024 09:49, Petar Stoykov wrote:
> On Tue, Jul 2, 2024 at 5:17 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
>>> From: Petar Stoykov <pd.pstoykov@gmail.com>
>>>
>>> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
>>> accessed over I2C.
>>>
>>
>> ...
>>
>>> +
>>> +static const struct of_device_id sdp500_of_match[] = {
>>> +     { .compatible = "sensirion,sdp500" },
>>> +     { .compatible = "sensirion,sdp510" },
>>
>> Devices look compatible, so express it in the bindings with fallback to
>> sdp500 (oneOf, see example-schema).
> 
> Hi Krzysztof,
> I tried to understand the explanation in the example-schema. I must say it is
> a bit confusing, but I can't offer improvement because I'm not sure I
> understand it fully yet.
> Can you verify if this is what you expect the bindings file to read?
> properties:
>   compatible:
>     oneOf:
>       - items:
>         - const: sensirion,sdp510
>         - const: sensirion,sdp500
>       - items:
>         - const: sensirion,sdp500

Almost.

    oneOf:
      - items:
          - const: sensirion,sdp510
          - const: sensirion,sdp500
      - const: sensirion,sdp500

> 
> So the device tree should have either this
>   compatible = "sensirion,sdp510", "sensirion,sdp500"
> Or
>   compatible = "sensirion,sdp500"
> The first would mean that 510 falls back to 500, right?

Yes

> 
> From what I've seen it is rare to have two strings in "compatible" so I didn't

Rare? It's everywhere in SoC and in many places for standalone
devices/hardware.

> know of this mechanism of "fallback" in the dts. I expected to just write the
> name of my device (let's say "sensirion,sdp510") and the driver would handle it.
> But I'm learning. Expectations change.



Best regards,
Krzysztof


