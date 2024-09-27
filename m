Return-Path: <linux-iio+bounces-9805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8EA9889E0
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2024 20:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF184B21CB6
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB061C175B;
	Fri, 27 Sep 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5u1qA1s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120441714CA;
	Fri, 27 Sep 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460181; cv=none; b=GysMaROytMC+AQKJbldx81riYp/ZvG6USYfsGmaUxbfBwgI3+vt1Buzy2itMO6z70fk+piy2dD3Z0cWfgJptslLVAzZvvz14N9qmsOzJ5Qw1kZb9K4pltzp1Pg1Own3PAmqfnZag9xNtdbBlFc71yZ73kHuriNTMPKtwTIagh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460181; c=relaxed/simple;
	bh=rO7ILgqqCINnQGYBS5eI25H05hnIR6qPhzytv293eLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoEtts8Hlu9gnnbVCFz58pcDONrH1L9/80U8iaLTBjblZTY1eQWCGQu0XEw8e0b/aD+brjhoeIt3OCyZH9x+bzYCbugEmuQal9eW0tFBjmR7vKsLyY6RSdJJNshDUNLTkgDP1QfRMwJvgdCC264Gf20GeNSkYsYlSlgj+I9JBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5u1qA1s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso349775066b.3;
        Fri, 27 Sep 2024 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727460174; x=1728064974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZdnszJDfeatzu18HmNKBik841ueKLsxPFN9CU9wYOc=;
        b=F5u1qA1sq9lyG3oyRAzps8Ta/722vdf9xkXpgPJHwJqXxqhVKTeAmi/zR6dYMki82b
         wOCZDVgazu3IC/43tj/PXLewP/zlGqVOTr7utRFDqfvH0i2ZHykT7KnLECH9IRvE8hyw
         2mMJUlPyWhwJVFuYDzJFXCoEr1Ri+ZN39n829s/7s5fUmLNoVsFAyf6GCQnHX0EKabeQ
         HVmn8SXKW9xLEAuQYyX+5AhZ2XENFMVK6iUe9AhpnkW0u7OulZfbN8wj1oQDnIxsJGMF
         iaITayRsPf4wsZUlTR07FcCVVaDwMGsGFBEVqHb8YpH2OvoL6hVKH2pMnkcYr+yLSXE6
         /BNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460174; x=1728064974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZdnszJDfeatzu18HmNKBik841ueKLsxPFN9CU9wYOc=;
        b=CcLtQCcN+nGKQllYA/8mIjLvAWrwz861+RExTrEhJlpv3TvnGOcTvE29zQTH9Zp+Zu
         VkTbY9BzY6jyXC6mO6sNJPP1CgQOSSzVHWUyRv/EcQEpbkrPcghPXg44ewJNudPWw358
         kg0fbPTkvSnJSgrtlTSYtiezWLYj1tyKBBW5gPexDCiRpYW/sO8g8ZU254fKVHHvW7j2
         OEcHITKDr9gim+YCTbL326dxHZduEMyXq+nZCASvs0FGyD0akSZULXDXUOhV+jFeii0z
         S2Ke9eIUYT1fgndifcUn753kI8R0TToUgyn3027OMWXREWuGf2er9IpOMTUpZxCxbKsR
         0H3w==
X-Forwarded-Encrypted: i=1; AJvYcCUObTkCwaGOyLyj8Nn+5bi23O9xwM2amu7wdEw23P0rHaSzWYvgSfYvnKw0JSnHo3JWXPrbV8BJHsL7@vger.kernel.org, AJvYcCUm9NYXzjiVrxq/6pAuidm5lWgFWFw4NX0p3s8Qzmtwt3aC5d8R0vnWUwgqfHP+G+ucRuuEZpm+AkaJ880k@vger.kernel.org, AJvYcCWv9N60fRF9Dp4NQPxjW/w213JAU3DDOLRe/NSxvoQlZxCWZSewCvWw6KdJFLM6X9KBz4Rxsax9rvs3@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTj3E+cOnmeLpry99BAZ/fv69CWuUGTu9cJWIOenuwzw5UW1O
	VVGBtPrafT08zvCmrL3kjt8CPkcWeubFOwdf0Jn/4E9/ms4uwaCU
X-Google-Smtp-Source: AGHT+IHRvkXDlcJ51AemySrdaLL3w4kyV0/iF/ZaQw7Ikxt8LsBhY+cxaZG3MJ0XO5FwrLsHHsUuVg==
X-Received: by 2002:a17:907:9349:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a93c48e80b2mr476475566b.13.1727460174056;
        Fri, 27 Sep 2024 11:02:54 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:6e73:3ff7:9936:9d4d? (2a02-8389-41cf-e200-6e73-3ff7-9936-9d4d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6e73:3ff7:9936:9d4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2998cc0sm157293366b.191.2024.09.27.11.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:02:53 -0700 (PDT)
Message-ID: <9e94e94d-a970-4409-ad41-85e2effa2896@gmail.com>
Date: Fri, 27 Sep 2024 20:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] dt-bindings: iio: light: veml6030: add
 vdd-supply property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
 <20240923-veml6035-v2-4-58c72a0df31c@gmail.com>
 <s7ylc7uxh376hmessk3mnuxsmjpmgnvgnxbu7vxect3evqjsfp@ifou7lugbxae>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <s7ylc7uxh376hmessk3mnuxsmjpmgnvgnxbu7vxect3evqjsfp@ifou7lugbxae>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2024 12:06, Krzysztof Kozlowski wrote:
> On Mon, Sep 23, 2024 at 12:17:52AM +0200, Javier Carrasco wrote:
>> Add vdd-supply to account for the sensor's power source.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof
> 

I just realized that the indentation of vdd-supply is not right in the
version I sent, and dt_binding_check rightfully complains about that. I
will fix it for v3.

Best regards,
Javier Carrasco

