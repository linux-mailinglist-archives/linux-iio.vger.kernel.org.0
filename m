Return-Path: <linux-iio+bounces-4923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF78C2192
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E9E28361E
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF4E165FBF;
	Fri, 10 May 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHzdP4Vw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80D1635B5;
	Fri, 10 May 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335538; cv=none; b=Lf+G9gfyG6ca2eu5ox6S60yvJlg1AuR4YGNRiZZX+GMeMoWhzeDfgQTcTZWHv/XUB3g1o6C5JCiXoZ+1PFa2nkA8VOm7RsqNm32zoOkbpCFJ/eqIll4eAflo8y51VJuxN+vZVm4QQJAZXlu7gXK2khO/Ob6J4w2Oebnt1vu+mRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335538; c=relaxed/simple;
	bh=bNxY+o7w/EluTDohpX6Vmx9RgZAOBzGsaVfZ2SgYTKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OehfXSDRRPIuM+7JEJXWc1Y5jwavGKT1RBoY1/efh3xjI5OJy8RWufd7KyMF800dGbH+i0ow7Rtz/6k/MYkXsVviBoCX0yBKzMa04C2rVR1xNrnFHCSsJfz+qM16cQPIGGeB05Lt62Yi+zHxu64nAUjtuEEDfqL0lkyCqB1qfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHzdP4Vw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a64db066so464919266b.3;
        Fri, 10 May 2024 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335535; x=1715940335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvyJt6mXT3ke3TNec2g3jJkXUKl8h7wFAhJ349b/sWE=;
        b=DHzdP4VwUq5QXS9O4PdsB9psOZy1DfGXfKm+JVu/tL/rDHeJcLNHChP8JhDL8+fExC
         /bct8r71jAK/zQ2hAw6S/EfNvQ749sA/HvtZUekCrGudhWX73SJGDbWLTrCC/ceBxKQl
         gPeD9CzaApk/ZyOtvIvUyuzdXTGnHxIIxt4T1aOCa8oTRy+infabTgSu8+OvBzzGBwwq
         YJdM41qk669eP0kidZQzvqVHltt6jCJcGwx0T9vYgBy4sWx0pbk2SzVWXAFcPmSQ8BfX
         lSZhOxSqJwdTNR+1SRNlkw7VG3AFNtN1L+DNrWWcggmnv2pcloIbJe383snBZii6roZF
         mssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335535; x=1715940335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvyJt6mXT3ke3TNec2g3jJkXUKl8h7wFAhJ349b/sWE=;
        b=H7OSC55fj4Iz5bPicXkwabwU/puzti0jXeSPDG9nMqAiH+BWRPppQvN5typyjfpvpS
         S4NCnZkT2/xHWzaP1i5VDhjv/hG8DdncD4wjbuV2RMtTS0a+by7yH6s3Tyen1A2jP6ql
         r8L0I8Pdac3OvrV2Ge2MjsrtKT+fMu4VNQj0XJTBDs/iVnS9KlWuQbt7f0zzLWWE+Zd5
         uUEdFrTzCEpYDt3vVyDof+dfc0/plIN/zid9j7HL3HV0a9Agg95Bj9dtWtmWYDiE24uJ
         sggeSarWyw/TmMHh9s1VXLWY7XDmoWlOoCAxKSJo7YARMRsEb6nWgs2Z0j94u92xY7PH
         s/dw==
X-Forwarded-Encrypted: i=1; AJvYcCUz/Ml2JKHiw5Fq7x/CEHPr+UJZ5ECedWfp/Cp3sTHzfJ4KIDT0e6Xs4E/8Yw0n+B0Fbkxk/Xf2moGeJ7IGo1wR+S261lKegEF6AOWAqqmhaPjTTb9qhBzrIuPu4wy0rzRXXIhSo65QcB4wDxScqmdNnCaxe0IoCcT8XOgkcfpW5GZ+7w==
X-Gm-Message-State: AOJu0YzCZsfegC3w0ZPGnN2Yfl5P6PlCfvV0mMH4YyhZ/IW9q6Dpx6V3
	Q6tZeXmNDOByl+e/Yp3ZpMS3zq90GcOOOlX1iQiLBFPgbgE5GOuP
X-Google-Smtp-Source: AGHT+IGa90M9SKT4W839DqYKUjMyqadXlmKJvXXAnlyhf9gjRGzZ+Yt9tUAVrfALpDcuKwCII9ApPw==
X-Received: by 2002:a50:baeb:0:b0:56e:2ebc:5c4 with SMTP id 4fb4d7f45d1cf-5734d5ceae0mr1478379a12.20.1715335535307;
        Fri, 10 May 2024 03:05:35 -0700 (PDT)
Received: from [192.168.0.105] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7d3esm1655178a12.73.2024.05.10.03.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 03:05:34 -0700 (PDT)
Message-ID: <73365049-670b-4068-a159-fbdd0539f5a9@gmail.com>
Date: Fri, 10 May 2024 13:05:32 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Conor Dooley <conor@kernel.org>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
References: <20240430162946.589423-1-alisa.roman@analog.com>
 <20240430162946.589423-6-alisa.roman@analog.com>
 <20240430-winnings-wrongness-32328ccfe3b5@spud>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20240430-winnings-wrongness-32328ccfe3b5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.2024 20:21, Conor Dooley wrote:
> On Tue, Apr 30, 2024 at 07:29:45PM +0300, Alisa-Dariana Roman wrote:
>> +      diff-channels:
>> +        description:
>> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
>> +          appropriate value from 1 to 16.
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
>> +
>> +      single-channel:
>> +        description:
>> +          Positive input can be connected to pins AIN1 to AIN16 by choosing the
>> +          appropriate value from 1 to 16. Negative input is connected to AINCOM.
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
> 
> Up to 16 differential channels and 16 single-ended channels, but only 16
> pins? Would the number of differential channels not max out at 8?

Hello, Conor! I really appreciate the feedback!

The way I thought about it, the only thing constraining the number of 
channels is the reg number (minimum: 0, maximum: 271). 272 channels 
cover all possible combinations (16*16 differential and 16 single ended) 
and I thought there is no need for anything stricter. I added items: 
minimum:1 maximum:16 to make sure the numbers are from 1 to 16, 
corresponding to AIN1-AIN16.

Please let me know what should be improved!

Kind regards,
Alisa-Dariana Roman.


