Return-Path: <linux-iio+bounces-4857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4F8BDB35
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE531F2522E
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529846EB7D;
	Tue,  7 May 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPWR4mPQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66C6EB5C;
	Tue,  7 May 2024 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062461; cv=none; b=SosBfxTJfPa6esifNmIXiBD2j795v8f6faqivEXhih0rpsa0umL8cg1SULmFTzwqB5MR9eVp8ZV10m8kZZSlcnGuLleH7fpGDY9gLBvY06hDc9dXfkaDe1CgDqssEA+W1hURouw8EW99ybDOq9ougbpihUQyTKzaZdkidwmJlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062461; c=relaxed/simple;
	bh=EmVKuHIG1qVj2sl/trhl0C36sPde+5ySI5j8DvJuNRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DB4XuiF1moxEGggB5yIEOsIOm+66klEUmazSFaBRJ9G/7ltJ7fcCtWmSocd6yfo1J9zvFZhj1XxVOOFt5hiCqopn9lkMqafk3fE3WarrAfLWiW25x8vhIktGyiJ4DTtIa7xwe3uJAATDohsuMFuR+Kh/5q/YNtuCXgQJlVBsU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPWR4mPQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so3232683e87.2;
        Mon, 06 May 2024 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715062458; x=1715667258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZE+J4EECA+d/Zj0mE5FgYZ0iAZh5ZeMzHClQWAKGuI=;
        b=kPWR4mPQQugxCjjEwcnpT8cPKuOgbiQPHrtPrlTRmkQRU/eCPB/b0CqWtP+iAdyew7
         c5HTfBdgwc6uu0pGblDREa53aAat07zumn9fT74/SuNbaNCYhkQ/OrHleZwkpzDFyeeV
         hPcS51OPpNiRq5ZNcbWMfwkVUa3GPKcMz23HpR98yJ/fJWTTfWq3zPLiFMJ2+4eodHrB
         o30lPlvqGMK9jgzea2Q9FbpJWc1QaG17dzhayZ0vmNq3TBkqY3JTVLEkmNHb4bKVOn1X
         gEHWopFNPcFsVRYUX272vEvSukGDp3vzVoaYpEUPZPJ4uhM8P8VM95jkg3ICwe5kcUU3
         Mb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715062458; x=1715667258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZE+J4EECA+d/Zj0mE5FgYZ0iAZh5ZeMzHClQWAKGuI=;
        b=ZFg+q7YwlDXKkrLMmIxHEwfeZQzMkCcpHJvOWtBgAs0gTI8E5haJ99dexPFdTvl3ed
         b+hGTiXFu6zIGvm/X000ozU5gx1NvU9S3INyyl8M4cB7EyKw/B6lIKgKPKTdhdWhXjPj
         NKhYNBLuN/v6EcFuYARHxVgx+p19tFTqc7zf1nKDNJ5BdjGB+td+zycKSCdc7m7wHO/+
         bcph4FId10W/bY3l6iDO/GMksZRN1+xl88uH7ebINwa3qvysPc1txRB+tBrtyYpGntc0
         jJX6+HIaI2sPQ4Z2iGvw0QvS0DRP6osgoJEMi3MfyMzLw+XjQZ42N7B9Ktf17KZ2COzw
         kSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzj3iasC73wDfv8mw5mguFRBwHCEeCTbqNFMcovbPD1uYhiia7X7DQW7/Dhp1wyPOLBEjDNjZV3l+IDrqA6m0zqYLV28IuG7ARW/w3hLyrPBPWjov8s0vWOryhstujXTtETPxAP5cP
X-Gm-Message-State: AOJu0YwgLjTMwowbdaju0C/KMs/E5xZbqm+Fh68stHhLbA3BnsQD0BD6
	PWNH5aA1DeMykF4jnWOt2Je44zheEtDt+jsHTRXR+3DbPArLh3RQ
X-Google-Smtp-Source: AGHT+IE4hKBngpalF7FA7kUYM9A2AplAqSDEVTUEwbrmYQ7f2oQmGqbzcgAu32InHfQd01pk2PKh5Q==
X-Received: by 2002:a19:7704:0:b0:51f:d790:2462 with SMTP id s4-20020a197704000000b0051fd7902462mr5847044lfc.39.1715062457324;
        Mon, 06 May 2024 23:14:17 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id f13-20020a05651232cd00b005214c195501sm22003lfg.277.2024.05.06.23.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 23:14:16 -0700 (PDT)
Message-ID: <f5215081-c993-4147-8c50-fba1f56279b4@gmail.com>
Date: Tue, 7 May 2024 09:14:15 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
 <20240505185027.18809bfd@jic23-huawei>
 <11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
 <20240506135356.7babe20f@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240506135356.7babe20f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 15:53, Jonathan Cameron wrote:
> On Mon, 6 May 2024 08:09:27 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 5/5/24 20:50, Jonathan Cameron wrote:
>>> On Tue, 30 Apr 2024 15:44:26 +0300
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> Fix the available times table sorting in iio-gts-helpers
>>>>
>>>> This series contains a fix and test for the sorting of the available times in
>>>> IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.
>>>>
>>>> Revision history:
>>>> 	v1 => v2:
>>>> 	  - Fix the sender for patch 1/2 (Sic!)
>>>> 	  - Fix Co-Developed-by tag (drop this from Chenyuan who
>>>> 	    is the original author)
>>>> 	  - Fix the From: tag as instructed in:
>>>> 	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>>
>>> Am I right in thinking this doesn't matter for existing drivers?
>>
>> I think this is right. Only couple of in-tree drivers are using these
>> helpers for now, and all of them sorted the tables already in driver.
>>
>>> As such not high priority for back porting?
>>
>> The bug is pretty nasty as it causes invalid memory accesses. Hence I'd
>> like to see this landing in the longterm kernels. It seems to me the GTS
>> helpers got merged in 6.4, so getting the fix backported to 6.6 might
>> make sense.
>>
>>> I'll assume that and queue it up for 6.11. If someone shouts I can pull the fix
>>> forwards, but then we have the mess of chasing the testing in later.
>>
>> I am sorry Jonathan but I'm not quite sure what you mean by "pulling fix
>> forward", or what is the "mess of chasing the testing in later" :)
> 
> Hmm. That was an odd choice of words :)  I just meant that I could send
> the fix in the first set of fixes after 6.10-rc1 rather than waiting for 6.11.

Oh, right :)

> For now I'll leave it queued for 6.11 on the basis there are a lot of ways
> a driver writer can cause similar out of bounds accesses and they should
> notice it not working during testing.  So it 'should' not be a problem to
> not rush this in.
> 

I guess this means the 6.10 won't have the fix? I believe this is fine - 
assuming the 6.10 is not going to be an LTS. Thanks for taking care of 
this! :)

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


