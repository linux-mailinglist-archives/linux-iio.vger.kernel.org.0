Return-Path: <linux-iio+bounces-26042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449CC41C1B
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 22:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6627E3AB151
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAA3093CA;
	Fri,  7 Nov 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gfRyHloZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F41245014
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550050; cv=none; b=L8IjpfXOAOQ1Nv6oEYLiGeA3pUyGdjTujrZXARYghZy5rT3bDYiqKH65cur6SGNIkgNO379CFtzEGQYDQjDUC0z7X8L8aPoIIEGddXb5Bg66JiT4XmW6g46EgBB0HbgGtpiBhfAAlqbJFoLzccAW2e19KSxklv2SCicooYDsF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550050; c=relaxed/simple;
	bh=UV51qyXzYtxwGuB0zES4FqkBW93FAxvKUjuQF+mTpr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gGgxNm7UVt7VdEPU34K6mJ8qz8QLBWQxhmoio25jiBLRz30AFEG6WiUErLckkzzXGffojiy7Ts87OYN9SV3lF3u1RdNegLYn9z9AarqNCsDVHcRH0MOx9W+QO4vd7EWixkN9oUxt5Bp2102ypngPHZHZGNS9SnxlIhdy3y8yCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gfRyHloZ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-656c665749dso248439eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 13:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762550048; x=1763154848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=gfRyHloZ8hHEZSlMb20dAUZruZQMPz3LxKyzsL2eEEpk4ZUChE2sBNNmMVyZ+K61ll
         h+9drTxHRX1LZoamY204Uae1mtOj8FQ4NfmHqcxxyhlAGgjZRa/bpkSO6ADVhlsmzsjJ
         HB0TZETIZ+IeToO6xrB8EkR9OJCZTXHefip1KB2bdzDq5rJNctmpifpbSQK3m5S41Ev+
         JDLRxHSDCSFlJQ9D8FozcvyFaG4I8X+p14VC+LEIfmokliiDRGUofTLTAAuDPEyw/jGj
         wjZpTP585I/gKPSgnjG8oJu2A/SovYmyl1im3cALpJcPM8SUSRfp9nIfYITaD8mA5PMk
         zxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762550048; x=1763154848;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo2b5stOOMkheFTgFZGlOEGzsHrk4gEITKRM/xPVOlg=;
        b=CkXnOX48CWsq1jnax5HlptBRdjPn66vq3T60Hv7tlBhF5o04xawamUb//g4/LEBpc0
         8owF6mmdlt2yBdEzJZI3pX3MOYKPiz1GmbCTX1L1uTMAAGFUQ2EQwqrEAJs8dsTwERNM
         b0C2P0GmuHnhJbCp5rjlsP/ALkj4c8rogNqvg7HPFqlRwq5gZxAorNi0h4/c/z+Mt0pl
         SC7/FN26scijHicrKxcg5GiGOUhSPDHqomhhDiKlHws+UwkxvtSUOrJLQVSXjdZRQdgY
         ySi+nKYVhrYE0SsFCoxHN7tFucY4thbvqtdq7NSPLG5O2nMewaSiEM1wkp69QUqyNBx5
         UKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj4m9IwVek5wZ1klwGJ4Eug4bfv6PJCLWPNwR06MUeKOLB8feWYZ+qL8ypWBQsqMPHVJ8UpYmoekA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9ngNiXB+cNc6H6hW6gUCGEMrRnYwFABLKF+wR8HiGQ6IeGeY
	fr5Y0fUK3eGrYv9wUqMPdqcggIwQ0rzzfCRe5GreBWo+Bnzts1qy2Jy8OEjoIBnAOmE=
X-Gm-Gg: ASbGncsH+CAJqu4+5wFP5fapR1o8e/KC0IC3SY85nCclLF5QRHZIdDo/vN8wVjVIZ9p
	Oaw5X0zi9kutuFnex2AqFrtbw7bXpZxu64TZkyTzhATUCCWzB3wrzCbwj7RyzB0852Fv+Lpsgtj
	sGRh9ZWTpgsgddBg9G7Wx6VKDIbppCQ90Mz0+xv7/8KKaVztx5Myx/IkhucKUAh+b3FP71WOSia
	j/PbzY8xtVb7euoumSDiAJiK3yaaJqzF8MLtEzFaV3y4wdGRKb31OnwcX1/d1uz3X2kDmxLdxEq
	4Tc4G7PEMRATll+qWGvks/LFhWMsPpQY1RI+9AxbLsHYE1AG3NOBnvaRTEl/J5jIqbn/YnJFNcn
	BX0E+ZOPdgidKJg5npu/l5kXgdGKwjygQY/sgCU1nD7ufznsILD6slGmGqulSdZkwmsNOLM23DU
	gLmFqk2r77m7/0IzS1v45rANfSyAq0rV0sKQoB3uLczcisPjzvFs2sB/9QcPgp8tvwG17ntDg=
X-Google-Smtp-Source: AGHT+IH58JNXTTmu6lPkALuS59F00c00c+agrganN7d8UEB0Nzs1Gj/HxCtytEXComYXlhKlM//Npw==
X-Received: by 2002:a05:6808:80c6:b0:44d:aa05:ce74 with SMTP id 5614622812f47-4502a1be72amr387091b6e.19.1762550047721;
        Fri, 07 Nov 2025 13:14:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450027f640esm2781467b6e.23.2025.11.07.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 13:14:06 -0800 (PST)
Message-ID: <45bf8a0c-0491-4356-ad54-79c25079ad19@baylibre.com>
Date: Fri, 7 Nov 2025 15:14:04 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2/6=5D_units=3A_Add_32-_and_64-bit_sign?=
 =?UTF-8?Q?ed_values_of_=CF=80?=
From: David Lechner <dlechner@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
 <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Language: en-US
In-Reply-To: <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 3:09 PM, David Lechner wrote:
> On 11/7/25 2:03 PM, Andy Shevchenko wrote:
>> There are a few drivers that want to have these values, and
>> one more known to come soon. Let's define the values for them.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  include/linux/units.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/units.h b/include/linux/units.h
>> index f626e212d4ca..5b3293bce04c 100644
>> --- a/include/linux/units.h
>> +++ b/include/linux/units.h
>> @@ -21,6 +21,12 @@
>>  #define PICO	1000000000000ULL
>>  #define FEMTO	1000000000000000ULL
>>  
>> +/* Value of π * 10⁸ (fits s32 or signed int) */
>> +#define PI	314159265
> 
> It isn't clear to me at all in the other patches that e.g.
> DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest

Typo. Should be DIV_ROUND_UP(PI, 10000) or  DIV_ROUND_UP(PI, 10 * KILO).

> integer, of course).
> 
> Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
> would help to clear that up.
> 
>> +
>> +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
>> +#define PI_LL	3141592653589793238LL
>> +
>>  /* Hz based multipliers */
>>  #define NANOHZ_PER_HZ		1000000000UL
>>  #define MICROHZ_PER_HZ		1000000UL
> 


