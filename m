Return-Path: <linux-iio+bounces-7308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE492734D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A631C2189D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD21AB8EF;
	Thu,  4 Jul 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQj7lbb7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BF1A38CC
	for <linux-iio@vger.kernel.org>; Thu,  4 Jul 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086454; cv=none; b=d4jP4jcOe9oAbIQWniIA8E1dbLTKBEty64wrMacZt61WJpR+GZ4FuQMs3cms7wYA21uKa5YxDWWxTFdet9Pcoi0EY86KTA5OyxJvotIqUtHkWTjGfBkUGaTR98j64+Kz0GhPtUHuXkkhC5kgtlcBwqTgusPKolup5gqD9uFWiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086454; c=relaxed/simple;
	bh=sVucWpRVBLp1clOrRh/7/Lt/dpYnbx9sKyCTapn87hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8JBrO7rdcfW4h2/6jT24AzMXhZj5e60dFewRbPMK1Ymebix9699Qnqc8rGJGmAtTNyGlVCbpgPpBGBzgwWw1FO4tDCBqDVB2xeaFeMShoqyUFJc9Q/yHKJwkX4ZTz51a6laAVbrUWoKRns5BnvCoO/UUu/3f1oUBAUgUcQbRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQj7lbb7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso3598005e9.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jul 2024 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720086451; x=1720691251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yR6kRQQKjewLkDjLijbJzzsuJ3lxVXMiYewMcAXio90=;
        b=eQj7lbb7vXzMC43rbyb3lY0PCEpgVCuZ0TVN45SLkV2XextwyBOsKQOkQ220XY8LAC
         ZqNxwxfozMqUjorl+ttBWFm9DQs3nxN9WV5Od/jO3AKk7qD+V1AL2ZTQb/zrMPvFp2tW
         2zqMz/KKMYb3pS7LnD9WjNaVCeP/gYqq5WgwS6KPo1uzmJ0GTi4cHF9CtalTNUF7FcCf
         hdaAS/rM8oSu4jlvXfpyXpaaxsx3L2XQsx9nFQpOCaFdEMyFofwZUCfwpCNKptnjMH0/
         IrAovgHwt3lKsgb1mZg7NwclrQ0jLQhD6UKno1cW22XZQA+7JXdklboEA15iUe6rHBKA
         t1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086451; x=1720691251;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR6kRQQKjewLkDjLijbJzzsuJ3lxVXMiYewMcAXio90=;
        b=EAThbGFHj12gH/ZrNA/U54alr2vjLs/3vRJTuNXay6zcNU70E0feAbgXXA0MZt8d4u
         G/Ay1hJN5MZVbs0fmtuQMPYGQZPOEoC+S7fzOpnjB7Ce+NDZv67ry25mcaEkKCqJ2TwV
         FycadYztg9pNlk4J4adzX5MldfHJeobBZn4172WkFOK8eTF8dq3u3X51T3cxmswvpGgc
         NtympW71AwS4ddz++ez0xD7fp7tkUpxb/uwbfjwNrZ/joeonVdEkTB/YLNBGayKPvinv
         agn9ait+KrFt2MLOYA/4j/+lA4TjmqgVKveWjmbxtmre4uC2MmEq86tCOXe8nI6JWN5I
         JtWQ==
X-Gm-Message-State: AOJu0YwQNESooTU8NW7++g8nbv/qqbivOZfDHqeNCZ3CIj4q1xWkfl6u
	vE0PUVo02zEdUgb4D0pSPzsmlU7P7rFohsfjIoAsgUwIAszLG7A5d/5BMh82uqA=
X-Google-Smtp-Source: AGHT+IFyfxLASOlrAPH3tgC6z/yeFU+pbhU3C0jOJo7QuZpSlz7bRnjuHQG33VjES/lVTu8owPI+wA==
X-Received: by 2002:a05:600c:3b0f:b0:425:63b9:ae2c with SMTP id 5b1f17b1804b1-4264a3f3080mr10799465e9.27.1720086451090;
        Thu, 04 Jul 2024 02:47:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50c3sm16984105e9.2.2024.07.04.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:47:30 -0700 (PDT)
Message-ID: <38979dfa-ba9d-497b-b0c9-2ab7d79e1251@linaro.org>
Date: Thu, 4 Jul 2024 11:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
 <51563155-c53f-47ce-bf68-5a6da72f8655@linaro.org>
 <CADFWO8GWZzwuV_CSue9_GcBre2OdY4uBs8CiCtUePy4PW9BCuw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADFWO8GWZzwuV_CSue9_GcBre2OdY4uBs8CiCtUePy4PW9BCuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/07/2024 10:18, Petar Stoykov wrote:
> On Tue, Jul 2, 2024 at 5:15 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
>>> From: Petar Stoykov <pd.pstoykov@gmail.com>
>>>
>>> Sensirion SDP500 is a digital differential pressure sensor. It provides
>>> a digital I2C output. Add devicetree bindings requiring the compatible
>>> string and I2C slave address (reg).
>>>
>>
>> You did not test your code before sending.
> 
> I tested the driver for sdp500 on our system and it worked well.
> I must admit that I forgot to change the dts to sdp510 and retest.
> 
>>
>> Please respond to existing feedback from v1 and v2, thus confirm that
>> you understood it and you are or are not going to implement it.
>>
> 
> I tried to reply to all previous comments. Sorry if I missed something.
> 
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>> Maybe you need to update your dtschema and yamllint.
> 
> I didn't know about that dt_binding_check. Then I spent a few hours
> yesterday fighting with dependencies to get it running.

It's just one command:
pipx install dtschema yamllint
(or pip, depending on your system)

Best regards,
Krzysztof


