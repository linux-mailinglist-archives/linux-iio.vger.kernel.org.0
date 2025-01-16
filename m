Return-Path: <linux-iio+bounces-14390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB2A13913
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 12:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB8018896AA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EB1DE88B;
	Thu, 16 Jan 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="SBylZs2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CC1DE2B8
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027251; cv=none; b=MRmSennpKYUXIvgR1Srd5qEZPhu8YMiouUpxqufid1aDtenPDZ3IYHGxy2eUqBxBX9cu1t2NiBBV02QkcE1HT58Mynfkf+DrjgZXaUmKOYnSIrxjQwsBOIiTdWEwLD6f7v+o4VYPucDfxoVguAOiH5CxcLny9WfLEEQSeB4wLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027251; c=relaxed/simple;
	bh=hXneXuQ61cYntgNn/sssniG0GrUQ4hSFAcED56KHbH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0pEP2AK3SqWSNmtF2HWFa5CbQ+LxmMOb9ftJsMTPmWFHV4ixG1mhzo3F7klMoI/vTWJP8FqNCuUnqcahvF7T9pHvrAZZ+ash63ZijSvuvBzYnk5M5qAOzYaERGwAIA2hxAA6ax83ZOG0D1Kw+6LtEcYhni3SxjQ9WEU0SH5yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=SBylZs2J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso13145015ad.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1737027248; x=1737632048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YktfQbK04MmcrLOtepFIXUYlByhE6kzjeLH7SfhVzM=;
        b=SBylZs2J7hpeLVZwrZt16G7iExemqMiAuJSLkmccRPiEG9QoNUYsGVJehBMyyERSN2
         46/R66vz6hudpyjQEAT5R36uHBV53ne4UTuf5JcYEoB2HwlGlvu4H168ONvfF/Tptxfr
         5V/pMeotn8F7iAIMLdqHTQ6vwg46bq4TNUgodwmjZrdK66uvwSvTo72auwOIZQn2aop3
         JD4nFxk8nOi5MYX4QTbbEyEabaoK0+cJXBl0sEwBZ+FhEfv+FpkOolgRBWB2nm/w0xAp
         mLfEmRLHstZyJ/e/9rwzNVMkQLhyLTM02v5wpxaFWZHl40VnsPONSpL6clacJ3wX4Wb7
         KmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027248; x=1737632048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YktfQbK04MmcrLOtepFIXUYlByhE6kzjeLH7SfhVzM=;
        b=Li9cPF4LoO5U6UYBTbmmmaSHOFl+RJwGYSE8ATc8reSorWQOPTs4TxsMwWl+YgqPKq
         Ommipbp28fLdN02Zyj0BAeoecpOctYkOYj0xkv7/0m1UK82FCtBhr6jci9IrLOHmGcqu
         fB8v/AhUD4y+L9Z5XTiQZrByEzj9nAoBN3asGZ7zbZZq9kAvBC1DzsC0iqke8ukZDbgw
         HEJ2n4aRAgDjRD8kS+zKZCrcnj77KWzh8ol4H1Qo3g0V/h4GVaGC6FFWAfaorIrFf465
         B5W5ry84i+/E1WXJQZgTQAjEgp3q6fqV1rVj+bkETpP0BYk5suKaPLvcDPH9p5szbmbp
         emtg==
X-Gm-Message-State: AOJu0YyIQSkfyvJAiCltUKdAJsXLKOcEKr3qPiIpU2ZKIMihyAbKa0sR
	b1ruF/PWXAfO/O+6k5f2+pXkZujsvzur7bHO2+UensX8rvLfktlgdYAr5s/S/20=
X-Gm-Gg: ASbGncuJi/o0xj/8msOoqSSVB05CUFUwVrpOVQUTchm9p1OWhHzZJB2NlYuYm8NGcgS
	nVlI6spudIV2tiYfQM9LLQgMzkXuPjzfZhMO+RV0D8OTqjKZNv5Z5G61MciBEheqyIAs/b11481
	FlZ4xCUbM7fttIAZw9xu/vwLrOZVjm47n8EMSg7KmeiOB7GuIkOgkVjiXllzhGxIR0JHbQM7Tq3
	gEOvghDDmUaLF7e2+DUIFld4llYVvceVGHb549RRIvD0r/aG4wN3/+7BQCEicjQppoxFP+OdY1z
X-Google-Smtp-Source: AGHT+IHn0LVg8saEn8D4DZWe1zUwgh/bi1Q+v/D6XJ0zjNhEGPRiwLuR9bIWFuiS8tWZKmN8T2HC6A==
X-Received: by 2002:a05:6a00:858b:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72d21f2da93mr50495307b3a.8.1737027247871;
        Thu, 16 Jan 2025 03:34:07 -0800 (PST)
Received: from [192.168.50.161] ([180.150.112.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317b761b9asm11387383a12.12.2025.01.16.03.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:34:07 -0800 (PST)
Message-ID: <ad1b01ba-53c0-4adf-aee4-a9bc0ff88ae0@tweaklogic.com>
Date: Thu, 16 Jan 2025 22:04:01 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: fix max_scale_nano values
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
References: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/1/25 10:38, Javier Carrasco wrote:
> The two provided max_scale_nano values must be multiplied by 100 and 10
> respectively to achieve nano units. According to the comments:
> 
> Max scale for apds0306 is 16.326432 → the fractional part is 0.326432,
> which is 326432000 in NANO. The current value is 3264320.
> 
> Max scale for apds0306-065 is 14.09721 → the fractional part is 0.09712,
> which is 97120000 in NANO. The current value is 9712000.
> 
> Update max_scale_nano initialization to use the right NANO fractional
> parts.
> 
> Cc: stable@vger.kernel.org
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/iio/light/apds9306.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609cffc91cc3daba160f309f511270be385..5ed7e17f49e76206609aba83c85e8144c536d17d 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
>   	{
>   		.part_id = 0xB1,
>   		.max_scale_int = 16,
> -		.max_scale_nano = 3264320,
> +		.max_scale_nano = 326432000,
>   	}, {
>   		.part_id = 0xB3,
>   		.max_scale_int = 14,
> -		.max_scale_nano = 9712000,
> +		.max_scale_nano = 97120000,
>   	},
>   };
>   
> 
> ---
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> change-id: 20241218-apds9306_nano_vals-d880219a82f2
> 
> Best regards,
Hi Javier,

You are correct.
  From iio_gts_linearize() function in industrialio-gts-helper.c
*lin_scale = (u64)scale_whole * (u64)scaler + (u64)(scale_nano / (NANO / scaler));
where "scaler" equals NANO (1000000000UL)

I tested it, no issues. The values did not deviate much as this is nano scale.

Tested-by: subhajit.ghosh@tweaklogic.com

Regards,
Subhajit Ghosh


