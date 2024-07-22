Return-Path: <linux-iio+bounces-7778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B199389E0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 09:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A281F2182D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7603B3A1B6;
	Mon, 22 Jul 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMbN+HKh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0E38DCC;
	Mon, 22 Jul 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632482; cv=none; b=mYkF+g8wMQZXlDnypmXAJo2kAc4zA9L96CUEFLHuaFy+UBBXBIwrT2qsjBDjZ6Il+w0TbxGXz1SUWUJXNrEly6eY+g0J0T/PTJ+JRSUvkTxyUAwooa466CF9wOfpv/q7FktPAoXb0zUSSBzZg7ymkcF2jAchtd8Zgm1AVOUIHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632482; c=relaxed/simple;
	bh=tr1O+hPwM0KJEn4ww9SJW6izyACl1EooSgjgX+2CExA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjIp+fe92I8V8j2g8xD/enOpUock3J7BONiO+fClC9xK1FE3YznvnynOC8F2k+04EaJXYxVRwht23JbYikNNLRtKbw/pjZQev5eCV2VhZWLl6O0wDuobnZruTIVxBZHgVtM5BwlI+I2kOpmWwPSbuWZMNd9vqjnpRdcTrxUJ4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMbN+HKh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44bd4920ef8so20056851cf.0;
        Mon, 22 Jul 2024 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721632479; x=1722237279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHAnK7eluryXOEPZRmaUZuOauSYKDPyEBhx9PYcGeRQ=;
        b=WMbN+HKhlSiQJmxQooP0DHOm88dXHKLDWuBxhRtQRE6kUXNua9idI75yhiQl4a6/ki
         oVFLilpGCbJn4IPJYiTzhl16k43LENErKj8ANe5U700qxP548EfpFckFMLp3RfVVX1Hp
         PepYjg/f0qcGmyORlHksSDLNR5lnbxecEpAUaS2GnTY+XYlUmC4e65NdHGbdQT4OgGuQ
         sH/BkZRXMzF83u6I35UU/Hf9fIu5j4eMLHqw8SdFJCmQ3OU4NrJeFoqFV+I9qyLgiVaI
         FMDPscdFVLFBzKoFRCgrPRUQ03crU1aEW40PEq05e7NOqrhm+lv4+7M4wVdSR3gHpp7n
         zKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632479; x=1722237279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHAnK7eluryXOEPZRmaUZuOauSYKDPyEBhx9PYcGeRQ=;
        b=W0nNRpCpKqF4ptOyZIHY9wnvmlLEf/69JTMZA3T0KwUwZu+WxDrDBp0dnmJ7SZbShn
         kOfUm/5XtO7DdJh1pqomQxrxlEV/8G5IImXkqq4cKyVxod8cQGY/T8MQtc/CpauTn6aK
         e0ncd898aHp5CIP5hqkEI3AkqiU77Rg9DYzd/Jm+ZlUm6+OUXMDKYSAPrR6B68XJXWBo
         j+Kt6w/poJU51UGi80L5/9gIdRhCNG0G6ugNJpvaBeMr/mRxsC3CNj+I27ndMnY+pPvO
         t3eorBPwKv1eLvOFIaNbGzjrybOXTNPfRM1SXu2Nj8gEEmHsUUeqzVyJyGNS3RB9jsy1
         AVBw==
X-Forwarded-Encrypted: i=1; AJvYcCWTJNeRGMbW+Q0kz/hoV6I6LOzPzQBuuh5B9dIoYSoDBhXjvLoqKki2+E9HrmL3tllJ9Po4vtgJB2+5ZfzxLBTkWpNiNdAfyxXTWrugdJR+eMlDefWKzQJWvq8Sih804Pmb6wsn2TDtckgFZTjImMjdMMqr8gb9YnzTfezHFnNF/wnGmw==
X-Gm-Message-State: AOJu0YwOsStKqhCwm1cRzYoYSzH6avHdNrpwVuKwPPOJULLSPPqNexe8
	mUhQoc6gJgJhhcb6AaNoSRPabuZWnm+xVhhPd3TUyIfloDeZbSz4
X-Google-Smtp-Source: AGHT+IFmt0kaRJkF7l1ZGUohrajnngP9LZQ7XiBkhajLauRmvkAVb+EHMoZ67DjkISZfM7G0gN2+zw==
X-Received: by 2002:a05:6214:29ea:b0:6b2:9d0b:6148 with SMTP id 6a1803df08f44-6b95a7926a4mr101278676d6.53.1721632479495;
        Mon, 22 Jul 2024 00:14:39 -0700 (PDT)
Received: from [10.76.84.172] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7b051c86csm30646556d6.116.2024.07.22.00.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 00:14:39 -0700 (PDT)
Message-ID: <6226f65a-3420-45e0-aeb9-8d31d26a070d@gmail.com>
Date: Mon, 22 Jul 2024 10:14:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
 <e48b2dee-11d2-4dbc-868d-10870e3c07dd@linaro.org>
 <68a25946-247d-4351-b847-35605220b16f@gmail.com>
 <04be66d2-de35-4190-ba9d-011b2b639f94@linaro.org>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <04be66d2-de35-4190-ba9d-011b2b639f94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2024 09:31, Krzysztof Kozlowski wrote:
> On 15/07/2024 19:17, Ceclan, Dumitru wrote:
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Then please
>>> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
>>> Some warnings can be ignored, especially from --strict run, but the code
>>> here looks like it needs a fix. Feel free to get in touch if the warning
>>> is not clear.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I do not get any warnings, only checks
>>
>> If you meant the checks:
>> - for the alignment check, i would only argue for struct_group(config_props that looks good
>> - for unnecessary parentheses the compiler warning appears without the parentheses:
>>       warning: suggest parentheses around comparison in operand of ‘!=’ [-Wparentheses]
> 
> Hm, in that case it looks like you documented some entirely different
> bindings?
> 
> Best regards,
> Krzysztof
> 

On which file checkpatch returned warnings for you?

