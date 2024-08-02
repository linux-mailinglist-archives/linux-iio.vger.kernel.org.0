Return-Path: <linux-iio+bounces-8138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54576945BD4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 12:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B85B21980
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A31DAC77;
	Fri,  2 Aug 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fylHyrAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC151C69D;
	Fri,  2 Aug 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593419; cv=none; b=ONRbMRaTb4Fm68oWgDqlilx7kJFzLBkiugI5KesqIts1SPreMOfRGfCWsmCGnFu5RxmENtbI3/Gws3i26kNB95MpdQdUpWuzHI4puUZ97SgtNnybhOVylaeS3zuoUHLMlPd+xl0vOem5xRsuxRlnRq5Ue5yyLL8qD4EbVHtkflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593419; c=relaxed/simple;
	bh=Nvdj6qQm9iVfu8aGE2DXopYcW7+wt4SmEat2cZ2su70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jC4lgx9/b38tltXkkBJOFvfBDVaBba50/2ebGFokh36e6xBtT32CfeN0y+bWTEaLFxtGsDdAFfkVmUe1XQ/aUrGb7xNmprCqm+QfE74LSGitxdRhup8+O+xT0li9CGHJvIJPHm1sRY+g6Xgmx/5A5kFvKVCSl/61HYFSlZzjZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fylHyrAM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7515437ff16so6027382a12.2;
        Fri, 02 Aug 2024 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722593417; x=1723198217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6htz/6NbRyXM1jme/dtQ2/m+dOMqqKo/ELlpYeQWqw=;
        b=fylHyrAMevJ+Dh/WZafFyndkLoaZNVw9zHjwzwWFMtiSl0VPd3vdQCjJMFUg+HDP2w
         09B41unoQ2e192Tv0uBHB94nkHnpwsZIbFvmUf1NApIDfp4HQhSQ3M8v+Amo/Arl3ihZ
         KiLozhSsMVtAEJfeQDR5vVR/EVXXPqd3hcIj7CSNy/wFStoqjpfeDA3/S/6sZ/1B5bLs
         e9nRT2u0Jys7qnEgzKyZaXPjQ41YHONeoYKjrigNKhKuqLoeatogKhfKcORDxExG37Ky
         SQvCLNMzfhZfLJtuToKN76iNRVApR1rvuTdLJzWqnMM/YD4m3M3Etv7jBNHrYZNX+/9E
         TtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722593417; x=1723198217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6htz/6NbRyXM1jme/dtQ2/m+dOMqqKo/ELlpYeQWqw=;
        b=CoN/+Bh7Me2rFmFCE6kTIj0a+2ibk7UcP1k9oJJ0rQm2GidcQ4pNb3DlnRWoCj98Hs
         ACGrpwPt4MofEmLMx1DOAsTly5NVuaM3NdZ4bKIFEtbeiJPxpZWL/jLCsdXvYtgwNqs+
         SMPDkU9E2Bh+GCN5Ou4dZVUkj2XjSjq+Os7rEV6tLRRBOQenZDH6TzSamSyOJxzN7pxE
         8/dozWBCR/VeTKxf1oxMhrWJ40/SgYhi2BHt4hpGNdi8G+Rp5EeVko3kW3vZjqDnFvnd
         pzfxyMUPGESz/kuDvTaXNAxlR6BqfT1Th16DVb+3D0mzheXTOSlaq8xWbLhDQvwxPKW+
         +DUA==
X-Forwarded-Encrypted: i=1; AJvYcCUOpwcSeYtahbpjRrj8U+eUz9njQ38IqJMPTsJNHnoAP9PW38hH4VgNVM8ZY8VEXbQ3duwUX7uk0CP2NTa8FMZ+azHpaDcj0YE3pHPw7oRt7XKLW+lEhABPaaq6Q9YYBTPqjDGoUYHzibMgDWVJITy5ARtwpFyeDW7psg1p+kkdrd4Xvw==
X-Gm-Message-State: AOJu0YxU/yVlWJ5dgaF64zZnFvIabedimx/3dyYCg5PAS0faAJ3AKygm
	5eWCUT5D7oFO+ddp8ZHbgUfW6bRrs/Ll6fW4DNaQcncGt5xqcPbE
X-Google-Smtp-Source: AGHT+IHlhy0cofaPaSc4QwacSyWHNvjUmMXzXi0lqVJkGBrGELs7V41EcJ/9S+LvpCq27IUZgl1Qyw==
X-Received: by 2002:a05:6a20:4312:b0:1c6:9c6d:1c42 with SMTP id adf61e73a8af0-1c69c6d2068mr3167721637.14.1722593417369;
        Fri, 02 Aug 2024 03:10:17 -0700 (PDT)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905c879sm13501265ad.148.2024.08.02.03.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 03:10:16 -0700 (PDT)
Message-ID: <a9c1bcd9-beaf-4d47-8d65-2893196fc1aa@gmail.com>
Date: Fri, 2 Aug 2024 18:10:09 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Alexandru Ardelean <aardelean@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-3-b1d65b221811@gmail.com>
 <CAHp75VfN56gPp1VVwfS715vTNUbA2p0uz9Dcq8PkehXG7bNjSw@mail.gmail.com>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <CAHp75VfN56gPp1VVwfS715vTNUbA2p0uz9Dcq8PkehXG7bNjSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/24 03:43, Andy Shevchenko wrote:
> On Tue, Jun 25, 2024 at 4:31 AM Yasin Lee <yasin.lee.x@gmail.com> wrote:
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
> ...
>
>> Reported-by： Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202405170824.uhEslLI0-lkp@intel.com/
>> Closes: https://lore.kernel.org/r/202406142001.swm6CU40-lkp@intel.com/
>> Reported-by： kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406081148.j9y5W5Ru-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405310327.5dCrF4gX-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405310010.dSPEpCuu-lkp@intel.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202405300812.jv99FywV-lkp@intel.com/
> The above shouldn't be present in a new code. This is NOT a fix-patch for sure!
>
Hi Andy,

I hope this email finds you well.

Thank you for your feedback regarding the SAR sensor patch. I appreciate 
you pointing out the inappropriate use of the Reported-by and Closes 
tags. I have already addressed these issues and removed the incorrect 
tags in the subsequent version of the patch.

I apologize for the oversight and appreciate your vigilance in 
maintaining the code quality. Your guidance has been very helpful.

Thanks again for your support.

Best regards,

Yasin Lee



