Return-Path: <linux-iio+bounces-13992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A4A04893
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5B83A6B0C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D361898F8;
	Tue,  7 Jan 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sNyu+2MQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4D15D1
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272110; cv=none; b=Gy9zhlkS0g1gNyZ56oOFV2kgL5Ph2Te93Hb78abmrpK//+9sw6BANdjDK8Ay/Op4rxnHak8+GLv5Qvz4jN+YP5dT8f055RyKYca6wrNSWt65DqOmjyz4dzR6A070Vs2UhhFdDcT7SNgAy4WllAvIjATGml4wecF1VEkqZ6DW5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272110; c=relaxed/simple;
	bh=PRdChHXTzrOIncjlNdIVWlvFB9ZCcteMmHGaQ3Bcx3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol+hhKhoAYig/HJanafr4uVQYoDRJnnc/9G6GVTT4xF4u2TP6wu+wBIjTudVEoQuq9eM2m5yVENA5RwNbFV99b1DVfGMHjIzDMZIPya1JU4w4askGylOk1DexiinD4ANJjHiwdz7jn7XXX/LRPrl62/rSmaPWURkC9NUaw7S/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sNyu+2MQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e1d7130a5so7788883a34.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 09:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736272107; x=1736876907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUC4u6frWyy1b4AX7BqVShgjsSZ2S6mzSRMnQKxJJNQ=;
        b=sNyu+2MQNDav5LP8UkwJ8LqnDm4Pvfih2DQui+fTocCHjEmQ6ALwzr9T3QwpxPcQeX
         bGQwZwOkSY+7R1N38L44l7UyxuLrVkwlUIOxTcIRYqXzq1HzhKKMq6MTWbT3WWJ1chNn
         wsOzOx182DYqC3trvP2dx0wyaM3jOaMuHVDoYiZPZq0YWOYQFUken/SxaG8cZiV3G0rh
         elUokpRJSp3HwELse8RLPTHLl0281irdrG4oBfWvLV6dpFOtBzeGlnVHrTTjHGqUO6Z4
         Z66BUMIiQGx4DrmzgJJ7rdV8lWhfbmgg7+5uoB1N+emHo2KGsW+d4Rq7KGKCPaz5+7hs
         DBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736272107; x=1736876907;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUC4u6frWyy1b4AX7BqVShgjsSZ2S6mzSRMnQKxJJNQ=;
        b=I9LKcfNxnQ3DJBIoYvEOOBjXqLLanPRdacw6cDmyBpu/4g8G5hnH+oA41MbKkv/1lN
         ljVSoxzytjNb3mfl8z7d2IDUdWzjc9ub5QYIMioOUnuAoJkAu2neBbrXogc650GQ6F9Q
         cC9W3vwLfjieye/sh4U2nQKIZQGGShWUduLQfeK/Kxtec9bmmVmuNzI9zrp6HrBUKGpO
         HTDE+boM7rYySDfU0xtGhxdYfqwxmFmyod/dLnRYPMd59XFw0LH7TMK6i83GIUpDZQX9
         z14wfuxRKQ6zVi0aKUZ4u7ZrK6uHhSmHH9VtTJLt3CTOcm81fjiEf/aLC3bXf6pbQiiD
         LBQw==
X-Forwarded-Encrypted: i=1; AJvYcCXcgu0Li0m2DcNj76enVk4+AjIlbtoNpFFWry+3XHrmCPsBTkhsEreRB4GVMBvyo3/ZKt6rr4rKhuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVkNw1a7gcDo8ei2kCbs3cXUX6YUnlwEZPrGSB8MNpIsYtVu0
	6OBwJdusM4//brmo5JEI1VVKnN0TqR86r+8pl0UPo2WBxq5X6VK5vgqEpyi4Ng0=
X-Gm-Gg: ASbGncvfTtqtxswYS0r99XkmwX5OHVH5Ya7zIO0lO6+pWMxrUxPy54IitwVMVm2GAo3
	uvLfsks7pBtD0Ydydrt85fT2Oxy5B+UouRhF7pXf56dziCaVqhS6UJsW2oHwdIWPHRkeBv7kliR
	+0FUy3+jJOPxUKjBIaUFlMXzmD1A9DLNMM2McM/2uI4XKleHE+F33sTRq69D0NVdcHrHm2o0pm8
	oCEOUu40pgKbpZWSqGRN8zJHiqycpWTHHfgjawzGXReCEuHQK/70+WZL5xn9jPKKsoVV+vP2kfl
	b/wrAlR1LfX/qWg0EQ==
X-Google-Smtp-Source: AGHT+IG1jra2jnZ+Zh2oP6xTdVi/uAv4vxBStS/AXNs20POcFFy1D5rV0s4z/KfY+x62ku+OQtDHfg==
X-Received: by 2002:a05:6830:618b:b0:71e:2310:7c7 with SMTP id 46e09a7af769-720ff999b1dmr35253663a34.29.1736272106909;
        Tue, 07 Jan 2025 09:48:26 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-720fe883c3csm10240493a34.25.2025.01.07.09.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:48:26 -0800 (PST)
Message-ID: <e7e9266f-082a-4bb4-931c-505c7ff20d47@baylibre.com>
Date: Tue, 7 Jan 2025 11:48:25 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Re-add filter_type/filter_mode
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com, jic23@kernel.org,
 lars@metafoo.de, granquet@baylibre.com, u.kleine-koenig@baylibre.com
References: <cover.1736261047.git.marcelo.schmitt@analog.com>
 <8db7c0f5-449c-44ab-b92e-590dc697baf0@baylibre.com>
 <Z31n9C8FwgzV0hs0@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z31n9C8FwgzV0hs0@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 11:44 AM, Marcelo Schmitt wrote:
> On 01/07, David Lechner wrote:
>> On 1/7/25 9:11 AM, Marcelo Schmitt wrote:
>>> Better document sysfs ABI for ADC digital filter configuration.
>>>
>>> Change log v1 -> v2
>>> - Split into 3 patches.
>>> - Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
>>
>> If ad7779 is the only driver with filter_type{,available} attributes while
>> ad4130 and admv8818 both have filter_mode{,available} attributes, shouldn't we
>> be deprecating filter_type and promoting filter_mode?
> 
> Oh, I had only grepped the adc dir and I didn't noticed admv8818 also had
> filter_mode.
> Hmm, don't know, though still biased towards filter_type.
> 
> - The admv8818 filter_mode_available ABI exports different values (auto,
>   manual, bypass).

Ah, I didn't look that far, so yes, I agree this is a good reason to standardize
on filter_type instead.

> - AD7768-1, ADAQ7768-1, AD7768/AD7768-4, AD7124-4, and AD4170 datasheets
>   refer to sinc filters as filter types (though not all of those designs are
>   supported in IIO or have filter attributes).
> - The AD4130 datasheets also refers to the digital filter as filter type in
>   some occasions.
> 
> But some datasheets seem to use filter mode and filter type interchangeably
> so I don't know. The admv8818 use case is valid and is both low and high-pass
> filtering while the ADCs sinc digital filters act like low-pass filter.
> Maybe even provide a different name for ADC digital filtering?
> digital_filter_type (or digital_filter_mode)?.
> 
> Thanks for pointing that out.


