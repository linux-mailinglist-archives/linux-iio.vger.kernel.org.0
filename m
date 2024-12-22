Return-Path: <linux-iio+bounces-13745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E89FA4FC
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FC818884D5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C12188580;
	Sun, 22 Dec 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUNBo21B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4580846F;
	Sun, 22 Dec 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734859470; cv=none; b=qRLFkY17JURtp6ToSKVMUtDjKR1rJ+mGhwJ9/uSu8WVhO6S4DeaEM3nG6tRDgUCf6m5e4i2P4VKAIKOJAIsvLUMMNIVFBcnH5vSDb1OmSGm2I05J0kbF+VBBHdSVuXVwVo3PDM7GCO0hIXnzoNoBuXnpmXoTJuduACURfKICbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734859470; c=relaxed/simple;
	bh=3zCjNO/4ahAqw+nu3e7LDm5hqSWxSILFyLT0Gl7nkDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhdb/2tCKmP4/KQrghlaSgKXKNsn+HWyu71uafZH4MApSYPXZ75rkuZakiNBMnpyMxMpbz0ICmkJ76kCPWAQqYNqYQDQ4wAbdjM6aQmR2ITYy/nkPEaMFzJpdH/ILIAlCC6onNvfWg3aTLYwrq+XYbml5gjD4J7HGTOy8lYYHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUNBo21B; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so3416073e87.0;
        Sun, 22 Dec 2024 01:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734859467; x=1735464267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDpa0WTWstSle1qGQEMQTYiwvUNTU9YMZE3bT/Erfh4=;
        b=mUNBo21BNGYqRC4uP9sf/uoL2U/ZYYmrZLNaeXukDcJ9FRqC5sMv/pxFRTpF1BREnm
         m6L1FTXVJC8/CXNuvceCP5D/SgAOgWk1QTDeB3QA71DGHcjLgSJuF/kXw955UHJFZ8JK
         BJLuZd6sCxmHv0KD778rxyLQX3ZvVd0GaBB9APSzh4+LKOR9kX96VOYfw3MGbfIE5l1G
         Pqp9p2X1zsbkW7yGCbuF6zWds4auA6kkJVJgVijf4efCshEO3inEjsVcb4cO8b++FkiS
         1vhsVKXZTf+ZWMl7ZMFxhuN7gI8CsaM00S85Q/dAoc36tQJQPMhKg2ggT1TU5fZp5h9Y
         bkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734859467; x=1735464267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDpa0WTWstSle1qGQEMQTYiwvUNTU9YMZE3bT/Erfh4=;
        b=fSKTyqReGMf/bdgkhbbaE2Qlojn1LwVZcv5Rt+07c4cNGnrtZ6oVWu3VzC2aQFQkKS
         hR9XNnvBh83XxKzJeQ9vbgocP0JCrKEHaGmgjpce/LTCOnWbqHibt4ZqQgyobA9qVrsf
         tfg1CaFUTU/phg/bhWrvGQY5ytJEJp9migDR9OA0NvUvp75UjyvP5WpNCBNo2qMFoDIv
         5VulG7eY1ljCjZx5s1bNbytqxqCxOJ1thoC+tS6OZAg2ch+m4h0V4rI0MebxxhBtte5L
         01FOhfBGzn80IKkrSH5MgfPSpTKT97co+QEUefB67fNIS2e2SbBRAoAXVv/jYkkUfr4l
         YzCg==
X-Forwarded-Encrypted: i=1; AJvYcCUoY/mBQx6X7q++48QzB0n4ri3a7aSNExhbeQNQSB3HU9tpA+APNapyvYsqz7Q/yWb1RyZHvMhl0mTBZAdE@vger.kernel.org, AJvYcCVZgtyVr1MsK69fkl79RzUFbSY30VWzTByFTgUA2BzDjhdiL8PKb/7lEeL8AbW4zQfDFJ0YY8zNlcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TB3qXGCoLSDU9il63QxpYBy2a92Q57D3bJM3wuTZPOeV842J
	8qXFz48wMnaF+3cXhnlpkPja4YwTtLiQshPU8jufFPmTL3tER9xZ
X-Gm-Gg: ASbGnct45eCVqzQMDqdVjqxk4O6yk+O5H9/ko3UvcsxLmmttCKc4DTvNryHaPepReOz
	KU/kz4Lfprf2F1U84XWVKaJtS7bUAMfalUym+b+e5ZgIWphUFS1aNBgKySKS+HGRx+wGPo7x/rD
	nJvfqGEAaqAhCEFu8sMAEXVQK5f46o5F8uxvgeOTTJdh9IKWsLUSV44pD12awv8V1FPdcnUs5Rs
	Mj4Be5Ursbxw8bJH3vgWZXlv1upy1NqHulKxYw4fz1viJKyH9KhUJk+W+bjjUp7v5U5hUfoRNUR
	TyfXpNTYveYJ/Clii7Wn0D1cPWogG+yFooo=
X-Google-Smtp-Source: AGHT+IGj0PiN0x2o2rfgyauexfLUEhXmEc5zYdOLIyaETYDtM24sGt6HCxKdTytve1tnG0/T4PUB/A==
X-Received: by 2002:a05:6512:e88:b0:540:1d6c:f1af with SMTP id 2adb3069b0e04-54229561b18mr2306164e87.44.1734859466662;
        Sun, 22 Dec 2024 01:24:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238301bcsm930306e87.239.2024.12.22.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:24:25 -0800 (PST)
Message-ID: <9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
Date: Sun, 22 Dec 2024 11:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z1_rRXqdhxhL6wBw@mva-rohm> <20241220192118.3e9ba7f9@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241220192118.3e9ba7f9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 21:21, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 10:56:37 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Make available scale building more clear. This hurts the performance
>> quite a bit by looping throgh the scales many times instead of doing
>> everything in one loop. It however simplifies logic by:
>>   - decoupling the gain and scale allocations & computations
>>   - keeping the temporary 'per_time_gains' table inside the
>>     per_time_scales computation function.
>>   - separating building the 'all scales' table in own function and doing
>>     it based on the already computed per-time scales.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Looks good to me, but I want to leave it on list a while before applying.
> Ideal if it gets some tested-by or other tags before I pick it up.
> As always, this is fiddly code, so the more eyes the better!

Please, let it wait until the Christmas has passed. I got information we 
might be getting some testing before the year changes :)

Yours,
	-- Matti

