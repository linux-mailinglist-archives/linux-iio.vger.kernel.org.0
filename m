Return-Path: <linux-iio+bounces-21734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C805B08757
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9DA1AA36FE
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903182356BE;
	Thu, 17 Jul 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="aT+brMJF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C012264B8
	for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738629; cv=none; b=J5hRhhilp15oLISQ2y5PCSwCRMcRSjU+V/bkkTybFKAg2+8J5JOG1jq5QozH6TaZgCIg1cJ2oDkvSJR3BR8PmvG16y2KjP/mcr7GnhK3b/3f5G4NZPW6HT2/AX9DjkGgw2Ib6f3wSvstfkOli1aO4RvTkUYXNHw0lW8rxdJAePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738629; c=relaxed/simple;
	bh=nMrU6NYNUimT87UScEDuHWw57zlwbdRRAzlVb+1V63g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhJ6IdJqL37hVlQzU/ayJvG13CCH4SK+RDPbx4i8zgRgQpdi8tWExFgznjjswaPzWRT79kdU2qKVwYnD+MQf0ELQpvUlzL69kZt/ow2ld7+mU48LKkmyh1mGgt0PVod627y9qiByLfzQ/hHC7nQGZzF1N5uxciIxiJu9h51PUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=aT+brMJF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so119423166b.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Jul 2025 00:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752738626; x=1753343426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6qWkwIoXMOFURLkX0SFtFvT3bmdGJ+VFq7CGLWRA64E=;
        b=aT+brMJFaujRYFe8gVyHuHovRKGObTDE6DFGZ9osIIs8CqbujFSsKIZKAOnU1C7g2/
         lE9PcEfv0awW8XgUs83Z3lcjPXVEeIhiWlUQVpO4cZgp5cLVsSs0zE/qNGCbDev7cyRz
         n4bn3QidaxqgnbzlbAk9Mi1cJVmE1dKBNcalytbR2rLSvD5fCuOw5CqONydH/OY3tiqL
         W9K7cJqN83CiODjXhv4BLHkv5hWr9+7gbAs0qoB8uiSGHBAKvJ1ipEc5+6xsAFIgaJI4
         Lr16GnmopwHGe4HpdKwMCUhG2aJpX4c9GfSrWE/Cmk7fGVdw6okrQAFZr1eEYQLNMpxM
         5T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738626; x=1753343426;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qWkwIoXMOFURLkX0SFtFvT3bmdGJ+VFq7CGLWRA64E=;
        b=U58d3btWuALbgYVuZxo+X+Hi5Yq3HsVGvUF9ZGPIhtS+NT9J7Fv8fN8Tb24GDDOCSv
         SMbc2JJ8OEAK3PRJoYh4LPnK+xp2yg2XmI2SV91JaNh9W0CvJAcAlQwiRDFnnxXHSjVU
         KguBB61bRMPeXJ4XOG4fBEkf8NRcnd6vYu6knR8nxiAjUDjdMVfWjCwpEBSOf+g06WYH
         DRUuRIwHNZ10OTfINmpWNRY6Tj7qGWZTNXmoaVQ1B2vMnpex2eJ64KJH36YI83dD2ogU
         Gum5JAYLDMC8v2edL267c7/CvMCQa5UrHPLqYRCZZ6DsXTbUBVNkC1FbBdIcJb35EsaG
         8+aA==
X-Gm-Message-State: AOJu0Yzk+AS1iDIPXbI0qIk/JSQGlLT+pG8BhlWC+TOq16mMd5N5RwhZ
	1Ln0C/Zk1ppjuwT0ZGTMkpy0NK5NQqvoZSqZ2d3STuxMTbggdwGFOrnYRyUkvmydvdc=
X-Gm-Gg: ASbGnctLCW7wYGXCnYy9xfQ9QICdUMaOyJWGcRo/2imQjzPRmNaqA8zqYqVwYVY6MFc
	yhMh+1mb5wAcR4DAypqHzRQpSBGDX3KX8tmVZWhNjiD2J4x+O+MNrbg3YB1Eqiguu/Ku67zZBgU
	fBKzQ0ZJxl4vkdrgIC3Qt2y6CEKbCiHBBanRGf2oV4jjWU12RRpfvy8v8MJuazBo4T/Aq6VTJiX
	otOQzSjyPIb4ysghxuW9ocWUQ4tZ0bwrH6mCDzCmrMtYAT7Hkj/XNjGklNN5oqTazZ7Uizn4Px3
	jvQt7R2xIiyfffZ3ttSjq16XSfbbB4j9CwVD2L4MgLXayxQr/zOID+dMPcBJpQPYuLizwTWd9cZ
	zfmzLcNkNgXV0ksOl02axrC74jnG6XPPUXXQeODA9+B7RGaLsLlLOyFrpEVmpPd8=
X-Google-Smtp-Source: AGHT+IErCgSB1PdH0y+PKoIyQE6hMuGK0PCXr6gNBNwnRCnflIOiPO+JGYbKfNECyR4KKDRpcUd8Ew==
X-Received: by 2002:a17:907:e984:b0:ae0:cc9c:b5e2 with SMTP id a640c23a62f3a-ae9c9b466afmr553140866b.48.1752738625345;
        Thu, 17 Jul 2025 00:50:25 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2? ([2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82deb30sm1335272066b.146.2025.07.17.00.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 00:50:24 -0700 (PDT)
Message-ID: <98b8bde7-0288-42fd-a341-a6d04db5184e@mandelbit.com>
Date: Thu, 17 Jul 2025 09:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix 64bit multiplication
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20250716192231.30337-1-antonio@mandelbit.com>
 <CAHp75Ve_geZr4+DPLD_g5ZyXF2AmKog-YShnohSAJ=qM5At12A@mail.gmail.com>
 <63b49206-5e08-4295-bc7a-cd0c54e82f15@mandelbit.com>
 <CAHp75VdU=8dOsG6U9mEZNx53Fm9EDHhQUHerNRB3em_JduhNjg@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <CAHp75VdU=8dOsG6U9mEZNx53Fm9EDHhQUHerNRB3em_JduhNjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/2025 08:21, Andy Shevchenko wrote:
> On Wed, Jul 16, 2025 at 10:44 PM Antonio Quartulli
> <antonio@mandelbit.com> wrote:
>> On 16/07/2025 21:36, Andy Shevchenko wrote:
>>> On Wed, Jul 16, 2025 at 10:22 PM Antonio Quartulli
>>> <antonio@mandelbit.com> wrote:
>>>>
>>>> In inv_icm42600_accel_convert_wom_to_roc() multiplying
>>>> `threshold` by `convert` may result in a number requiring more
>>>> than 32bit.
>>>> In this case, although `value` is 64bit wide, the result is
>>>> truncated because the multiplication is performed in the
>>>> 32bit domain, due to both operands being 32bit long.
>>>>
>>>> Cast the first operand to u64 to ensure the multiplication is
>>>> performed in the expected domain.
>>>
>>> Is this a theoretical or practical issue?
>>
>> Can't say if it's practical because I don't know how large `threshold`
>> can be.
>>
>> This said, `value` is declared as u64, therefore I assumed the result is
>> expected to be potentially larger than 32 bits.
> 
> Yeah, but can you prove the potential overflow? Can the compiler prove
> otherwise?

As David pointed out, threshold is limited to [1, 255], as returned by 
inv_icm42600_accel_convert_roc_to_wom(), therefore no real overflow is 
possible.

It's the variable types being used that didn't make that fully clear.
Maybe this could be cleaned up a little, but there is nothing to "fix".

> 
>>>> Address-Coverity-ID: 1647596 ("Integer handling issues (OVERFLOW_BEFORE_WIDEN)")
>>>
>>> Is this tag now official? I can't find where it's documented.
>>
>> I don't think it's official, but it's what I have found in the git
>> history for other bugs reported by Coverity.
>> I already used it on other accepted patches as well.
> 
> Are you an official representative from the coverity that runs against
> Linux source code? Or please explain how it keeps those numbers (e.g.,
> 1647596) unique per project. For example, you and I run coverity and
> we get let's say the very same number (ID) but for different problems
> (even if we are looking at the same project), is this scenario real?
> If not, we need to have documentation inside the Linux kernel source
> tree explaining how to run Coverity, who is eligible to do that, how
> to resolve clashes (if any), etc., etc...

There is an ("official") linux-next project in Coverity managed by 
Gustavo A. R. Silva, where all maintainers can subscribe to and then 
receive the weekly scan results:

https://scan.coverity.com/projects/linux-next-weekly-scan
https://embeddedor.com/blog/2024/09/28/one-simple-and-rewarding-way-to-contribute-to-the-linux-kernel-fix-coverity-issues/

I assumed all IDs in git are taken from that scan/project.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


