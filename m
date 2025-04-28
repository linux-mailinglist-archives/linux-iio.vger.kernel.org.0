Return-Path: <linux-iio+bounces-18764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E456A9ED21
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF303162D53
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA9267B92;
	Mon, 28 Apr 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apSgRKyn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9D267B9A;
	Mon, 28 Apr 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833518; cv=none; b=DJWlBTdFDgAHPGxfpl7dCS/BGr2hbp7FDenCuWEaOJwwMyrKAvQtveBk0B9XL/Ef/ftM1KYJ/c+3/Wa88tPhAuCXvRRvu1AIj7Um+RAqIDVu4gv5hN5ueeZGbFeqie8yy55//ymYITL+wVAXEMY5N0suNxWtmqPFikzpDXdjy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833518; c=relaxed/simple;
	bh=WK+EsohGNTYxdcNi5VgE8mKK+KAW8r6Df8DGSsedkY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkWW9Scgum/0waVs16y7SATspNooAgpFdep7714LO648O+8uF44oYkkBTB2tYGXIVUoLEEtyWZyMcl2R0HWOI4v0HMo7ZE76ysZWx6Z1c2jsP680ME8RVMbxCEh4CvzrDG8r1e5JQFYAX1E2r/bBOghp/mA2OWtTZr3xuFxEsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apSgRKyn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548409cd2a8so5534188e87.3;
        Mon, 28 Apr 2025 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745833515; x=1746438315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HH5COky35YdukfQVeHBn6FdNupiLsgWFEx9gVZuBrI=;
        b=apSgRKynNOegkxIKDEM8dItnIZM3bLmSBux6MwWDuXlS/eMsPlAyYrPiQlHCKbkNZC
         gIRZmtqPWQ0pBSVBkWT2//2CxBdWpnZhqLlcMhyckMPGI/YdwzMVfKEPFnIugMHJevui
         9+Wk1XimJxG/qab1INZPvLzmKHzLBm2+UxIXphKmneWrmdwtk8514JPAO8fO1i7lFpI7
         9NHxPKR+1nIrHkLvdP53R1lHUiQL2zmC6LhvfFAyiLB9RuEG8yQ1pBKgcTpM7a7FTJgS
         Wb9pUfD4gnxZVbKSer1/L8TNEsFhfERRpRJAWSDiykAAU7vNPTZ0NIrUtShhZ+E6x0ZV
         6T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833515; x=1746438315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HH5COky35YdukfQVeHBn6FdNupiLsgWFEx9gVZuBrI=;
        b=jqoy4gm1zRTTFcQGgKRVtbB0bvMAEzWq8eyX9B8ZwgpSFhQFvaROgMqzeqP7R+hPws
         m3Gi/TN9xg5hJJ+QaZC4ss8kiCazZM7t8wTl4wx1iun60/GAkX1ZeC21ZicVXPc3sSQA
         WcwmMGIr8EIM7gNn+nslxR79KI5nvFvAluFNl3bSRYsy/sh6ccXmHMLFMHizSy+xtqqJ
         o/qfU6xULvweOt4tyfhr9/VSd4gN/8RJZ2M/KywUe+3VXg4F/dKKhOR+e68ax2YvbEy4
         qG8WkMgBahXRdwX2cov5TIPgdHZ24EkZNlkKyOvQ7+SPKayxVTCKYVx7thjjWk2Ic5Yw
         mCmg==
X-Forwarded-Encrypted: i=1; AJvYcCWSIDG+EB103oLaY7MdcXqjnm3PJtdvpYZp2LhmDR3bSK7D34rkX4JQjg2uXSCfgT/gRlAEmSevkz3ZVb2R@vger.kernel.org, AJvYcCXXhuKY4CY/HSu9t91170LLK9ETHYOmGXmfQSej+6bEIBq6SHfrbQ8NEFKgXMvqiYUT1q9I35DmaeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCb9Ax5+5Jd5K1B3aze/vHyz9zKyOMihU+zqzzNj0rPTpOZSp1
	qXj8TBcaVzmIOVNU1JDi3aVbshVVy69AkWnRfShoQOIdWVrZ9h38
X-Gm-Gg: ASbGnct2yX9f6H+2quiciLgzO0K67X1vp2iu3WarjeUOogfFKEcEikQj5xcaqFP4Afm
	tdcZUfl/r8YrpnyYsmRvftX+FDCKDylnsuBPgwaMSMhRA9sLfh+XuNWtwoKXCqvbTIZ4OlVqEnq
	4pD22g2uZMl1GbZXS2BoboH4FiOkPw/rqCy0BiGuOwZrfeWCCFnRXragJt0+/JYr2y6caDkZDVP
	OIjX1x85iA2kPci++AWgYVDg5BaZw1ROs41/7ra/1L43TyMLXWxd5cMD3YFT4IOY2jLz0l91LpD
	j+lizWtvMTIbP5NRrREGj4XNmLDwY5ic62JM60Cz3xBWIhU+jLr2Zg==
X-Google-Smtp-Source: AGHT+IFBLylW/X7g9XH1IGDfS8dkYdjQVpujEI75t3+TTFPESsuIDI/DhDYwxENuKdWf17U0N0Tu2g==
X-Received: by 2002:a05:6512:b83:b0:545:1ce0:6407 with SMTP id 2adb3069b0e04-54e8ffdccfdmr2080031e87.27.1745833514514;
        Mon, 28 Apr 2025 02:45:14 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb2626fsm1618234e87.46.2025.04.28.02.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 02:45:13 -0700 (PDT)
Message-ID: <4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
Date: Mon, 28 Apr 2025 12:45:13 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
 <CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 10:08, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 10:02 AM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> According to Jonathan, variable reference voltages are very rare. It is
>> unlikely it is needed, and supporting it makes the code a bit more
>> complex.
>>
>> Simplify the driver and drop the variable vref support.
> 
> ...
> 
>> +       int vref_mv;
> 
> vref_mV please. And yes, I know historical and other reasons for them
> all being small, but let's try to be more scientific in these crazy
> days.

Sorry Andy but I see zero reason to use capital letters here. In my 
opinion, this is perfectly clear as it is. Capital letters in variables 
are ugly (to me) and absolutely not needed to explain the meaning.

> ...
> 
>> +       adc->vref_mv = ret / 1000;
> 
> MILLI ?

I suppose using MILLI is Ok. (Although 1000 seems still clear enough to 
me. Seeing the amount of zeroes at a glance gets troublesome for me at 
10000).

> Or actually a time to introduce MILLIVOLT_PER_VOLT in units.h ?

I really fail to see the benefit. Do you think we should add 
MILLIx_PER_x for each unit we can imagine/use?

That doesn't really scale or make sense to me. We have MILLI. It does 
not really matter if it is volts, amps, ohms or horse heads - it's still 
1000. It just gets cumbersome to search the headers to see if we have 
some fancy define for unit we have at our hands.

And, to repeat myself - for me even the 1000 is still clear as it is.

Yours,
	-- Matti

