Return-Path: <linux-iio+bounces-21730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D00B07E6C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90D95829BF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A229B20A;
	Wed, 16 Jul 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bbujboPF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745A25C713
	for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695559; cv=none; b=okvMTBOAQLZMgRpyMthbanPWgJUFTEZHqdceNV8FycEEvCPk6WYzjwFakSWUFz3oru2BZJjcb8i9Cr+A2YkpP3lvuq2KLnAZZYGnLFBIU8XwrCktJJE+qrbSQ8RmpwfJ/P+x7MCZQCK98/Q3SGOTpZ85EGDzpJudQVFMWaH9udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695559; c=relaxed/simple;
	bh=YJdnLpqpzajqUOzmpSPLRIbIr0Lze6wjN/+WUb4crgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3LLyY3G7l1PLPz4P4g/09a7wIRlMGjnZAHBLDGRFoL99fWC9mzFk/QlPmiz0oVHhg/Y0qAsiTaZJrV71Mwc0GTaEdwmcCJA6qfBTAaQx9ywVJBW1vasDelblJCAaxDkSWcywbKKhs2GAMddQcoLo2fcFmvhNaLX7K92fNjLElk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bbujboPF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73cddf31d10so137256a34.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Jul 2025 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752695554; x=1753300354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7ClJ+5SJ5PWZdRoiyTJC8Yhy+OOta4P/UZn7csc5K8=;
        b=bbujboPFoSo/vBC6oepXj4YWy0kBmEyDmXbeFfd+EiRbk9e4Yo5hTs6eJLU3qu5RMD
         ViQR85WJePSUlqxx7BAw188I8m4/5AZAbAkPmZyRXTBiEjFozQGLn/tTmt7nkJ/thQ23
         muOP18hq0LmW0MzLMwUpISKz5rsL1u0rH/7vZ1NYSX6RybOp3Wi2ZaYr41f/a3XThtrm
         S45Utq0Eyf2Jadg8eIuBaPuia3GtPr3jCHnT1V/OA6moO/JDKUcjLfzYOQZpEyCwOQM1
         N6wx5ktSA49ivMGu5y7SgOJ5PSlLc/VRC1CiQ2kUnPO1HJoEQhv0td5uGGW7dA5weYHl
         iqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695554; x=1753300354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7ClJ+5SJ5PWZdRoiyTJC8Yhy+OOta4P/UZn7csc5K8=;
        b=waFvMcB4hOuEjMSpK7QuiWl7U/oS8mImrR5zThfOdZnlZ0fjIJiTrf1JKRC8V8L91u
         lEGC3noxOj7/uRORC4GM9E9+DIH35PG9RTO2KD5cq+ChegqzNq3p6miY4X0ppmu6wsdY
         ldIk6X67VdAavojnPUqBzaojUonLVP8nDILAOq7YtCZrs5GTVYx0nrOUWKWfeyed+Un9
         NAm8zmVSFlPc3XlIhi1WDnD8SNCy560gtfvrDX7rsK11MAUwrPDTSU7LTQK4tV6wIBK3
         /3kl4LmdlgTRSYDACDEST6U2tLxomJIBnhiXu7JE8JXDCVOPrUeAMxQohFf03QRw/i3v
         Xo1g==
X-Gm-Message-State: AOJu0YwxPfi6x77kHqrKAjpH5MgMBLdSCN5yLTESFrgPmeu7XSljY7Ow
	2gZQlfPVXKR0MIYIQRn4RjUrVi2XLSB10QQV7Yecr/WQR4RKdLz7/R97mMsfHT0p+DA=
X-Gm-Gg: ASbGncu+nTmRkfwj5HNFFdz44MYONrhZM5GcYTr9WpYc2EJtHEE6Sp2ORl6WOdYL7LB
	3dOsXF/GpIpI2RUWo2bShfpu/BnKMfY97kDb7HJuyrlnVRu0XHqqFLdZ0AIyJ1Ifzh43c4Buy8D
	gGMOX6ckHz2WJ0UekoRDxgIzOnr/Z55jmMkw3LqSOdks04qN3WCTBz15b2IbekrKla7u8sfboaA
	rIsK4+SFuCQ8jIN0PM1FmWJbhh6WzvLBLMLIP6MakT02sGhx4aUSQCt7bCWzLn63N6eT26f/GB9
	j0kdshhhggGYSS8MGsrAsqX+F1bpVqR4RRlkyXC3KO1YA5w7iLDWnZoaN05D8/1m7WjK0ERwlct
	4mpkFNbe3ZGfzDUNj/XDFfMk399USt5cHz3Jo7u0kNWspGosdZzwiynrn2AZ6CGbN/cHkLv/CsG
	U=
X-Google-Smtp-Source: AGHT+IEW+HThp8KL7lzm1ZAHEzSiczXEwYg8fdd9tSzIqSDBYSLT8JBCCCwQJNIjxSjlRwObKs/VAQ==
X-Received: by 2002:a05:6830:8104:b0:73b:1efa:5f6d with SMTP id 46e09a7af769-73e661974a1mr2585090a34.16.1752695554509;
        Wed, 16 Jul 2025 12:52:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3cea:e738:91b9:726c? ([2600:8803:e7e4:1d00:3cea:e738:91b9:726c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12725d2sm3271366a34.32.2025.07.16.12.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:52:33 -0700 (PDT)
Message-ID: <c011f005-de79-4457-804a-d701f315b566@baylibre.com>
Date: Wed, 16 Jul 2025 14:52:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Antonio Quartulli <antonio@mandelbit.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20250716192231.30337-1-antonio@mandelbit.com>
 <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
 <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/25 2:44 PM, Antonio Quartulli wrote:
> On 16/07/2025 21:36, Andy Shevchenko wrote:
>> On Wed, Jul 16, 2025 at 10:22 PM Antonio Quartulli
>> <antonio@mandelbit.com> wrote:
>>>
>>> In inv_icm42600_accel_convert_wom_to_roc() multiplying
>>> `threshold` by `convert` may result in a number requiring more
>>> than 32bit.
>>> In this case, although `value` is 64bit wide, the result is
>>> truncated because the multiplication is performed in the
>>> 32bit domain, due to both operands being 32bit long.
>>>
>>> Cast the first operand to u64 to ensure the multiplication is
>>> performed in the expected domain.
>>
>> Is this a theoretical or practical issue?
> 
> Can't say if it's practical because I don't know how large `threshold` can be.


The code is clear that it is between 0 and 255 inclusive.

unsigned int inv_icm42600_accel_convert_roc_to_wom(...)
{
	...
	if (roc == 0)
		return 0;
	...
	return clamp(value, 1, 255);
}

threshold = inv_icm42600_accel_convert_roc_to_wom(value, accel_hz, accel_uhz);
value = inv_icm42600_accel_convert_wom_to_roc(threshold, accel_hz, accel_uhz)

So I would not call this a fix, just making the code more robust against
any changes in the future.

> 
> This said, `value` is declared as u64, therefore I assumed the result is expected to be potentially larger than 32 bits.
> 
>>
>>> Fixes: 50cfaa9a46c8 ("iio: imu: inv_icm42600: add WoM support")
>>
>>> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFORE_WIDEN)")
>>
>> Is this tag now official? I can't find where it's documented.
> 
> I don't think it's official, but it's what I have found in the git history for other bugs reported by Coverity.
> I already used it on other accepted patches as well.
> 
> Regards,
> 


