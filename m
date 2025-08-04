Return-Path: <linux-iio+bounces-22246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D86B19B13
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B83A65DC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 05:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B6226863;
	Mon,  4 Aug 2025 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqm60fpj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B12E3700;
	Mon,  4 Aug 2025 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285356; cv=none; b=XhL5V1IgqXSBwFjrBEh4MdyjZLU1St2ZnTfELStvPHMaNv7zH+BR/ME6W6gxFZFCjc5YJS8qcHDHpMfTM6siv/uYCm4pDCPnR7ObZ2LWof7IIkodjG/KRIKx4LyNCTxngE9+WhP64FAJAsjAhonJs4S70sxOJ2/iEyvJLFqWLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285356; c=relaxed/simple;
	bh=RL3SJKmPf+L8Wx57L2EoEtH7/VrKksjzk9FxGArOtEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzlhsWbjQxKKtcmVEFgS9za5iPrwI+U+vvzXPfM9+hyMHsGenNqNjz71FyatMYM9Yhzhlu9lnF9zyez/evU3x6DHEwfHJKB+wxkXOFrZVXo9PL/cF4AmuOeWdF+q6HzHOeOthD3BG1EhwhtcaH8IGUJZkwg3ms7wwiPBF9wfx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqm60fpj; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3322d1dded6so36933461fa.2;
        Sun, 03 Aug 2025 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754285352; x=1754890152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RE9BJL4ktdONUkIjvpy6MvnIArnKj004Qc+Uytd4IBg=;
        b=Rqm60fpjhqz/ibb7sAz6SI/MJFLEYuQBIcQEJytg40S2qaYAHMaAjKygvfqN772FGM
         0ohwbtQA+xq2y6Sr1I/JaZ+dC6kORci7WlLHwTclH3esOuB6GHEGqLXPK1Yg9e7q3reP
         yFKeCLpNK5SumWPvo0CScxQHN1twL0l4v/8DkuQyx4b3vZNktUgPzqCpawQJ0rXaU80a
         KVfaElogOpKwU6KLlLGdDs3xsG7yUCRu0+VkIPrdE7cIfCB9DBG6CA0LPpssN9mXu9Oa
         9/mW6l88HAHlz8xJt0Mo+IM106YCwDb471KU5QUbdQmi7kUj8VEpZfP04jjIAjw7iDHL
         MrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285352; x=1754890152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE9BJL4ktdONUkIjvpy6MvnIArnKj004Qc+Uytd4IBg=;
        b=rfMWWvgal4OSLdpRNzXcvHdvlKo/1JS+Xe4B1bLuI+S8+B8dc+m/us1bqgZfHpmQGU
         pjBQs0sofY5IRlvL6E/9Qsx3pYi38qqsI9IiOei25xPSIVXfXwy14vKyUU6mLBCmEQVJ
         eMJGvZnNojHoDHwfg05Bo5VmuqguQv8Tp+3SFxQ0qkG3QAF2uSXVEVFcxNG/E2unvJ3d
         bwwpdkhnAjVhQbJO3utqo7eiP878n1WsDpbVl9nscIKwAVzeVeK6pE1UJ1Qo4AVv6yqZ
         D4tbLz1IdEHgFwydGAkGkMlpT4Jp3el5SbseIoQw8nUrS5DTpMubjEfgkH69DgIiZGe0
         TLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGJJwJCoujQoox9RiSbY7TysYUXzXPia1ZZkIYlM7xmEoRaNcsI1W/tHD3aaeKkVxJRFivoSYbVbbCgAl@vger.kernel.org, AJvYcCV8zLZhZPVd5PgIYiYTNuY2bn8siGG1S4otsl5DV3J5KQc93zNkx6fhXf9fworFx8R3gHcQyYRKLkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAP/hd+3LCRlLurkr/Vvq9xCysPc1QPgrQg/a0GC7QDqo5bqq
	u4TckY4jWKZGL/baD/ldwz5XlQE5QYCo3tJ1Us+YEcB6Yn8WSZXu+/dE
X-Gm-Gg: ASbGncvsoUklhkLbV91E+n/i/Kf07L4JK0jfKmfUEPYV2xbPypZLlYe+GYSOzJ6FseG
	PszmqpyXtoQ48U3Yag4vpRnlKKI640/Hej+LfaKKGgUGGZY3qXIlSArRKKWdQMFnyc2AYDI3/Zs
	h9FWvclz4ZDVXBsjgIwhRF3iF9P8WTq2Md0mary/7//fgtAu/biaaw7deBv4GrHA7zAeFbTOh0P
	wbJW1WZGwsH3vhVkKTq4oZ4SywErWJ53ZgQXH+3hnk9aW4RLsxWcrGQm1ZcdGns+XeTr+LTDOlF
	Aux4qSLhGNfveEcqlodVW715hGWyodr5KPzMKvM1RFCa0TFaMhfCighgfCxwIPOLpu3wGgW05a7
	TklIX9+R8xo1C+xdLUL6n8yTrnNypBa+wZusRiUgfpUpOeNBrBliBR/jj0NN+R2tMazcDUf8v2m
	92oJs=
X-Google-Smtp-Source: AGHT+IHpAHczIZFqJEVpLxrm5aAJVswqdQwdXPCQ9I1y6hQnfH9Hco1+rg8sd/wFrCNZwiQHQRD/+g==
X-Received: by 2002:a05:651c:2156:b0:32a:7610:ccdb with SMTP id 38308e7fff4ca-3325681c4b6mr6933891fa.40.1754285352068;
        Sun, 03 Aug 2025 22:29:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3324473be9csm12455531fa.50.2025.08.03.22.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 22:29:09 -0700 (PDT)
Message-ID: <0795e107-1b63-4656-be3e-3ea7034876ae@gmail.com>
Date: Mon, 4 Aug 2025 08:29:06 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] iio: adc: ad7476: Simplifications
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <20250802115923.4521fa9d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802115923.4521fa9d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 13:59, Jonathan Cameron wrote:
> On Fri, 1 Aug 2025 13:06:46 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> This series suggests some simplifications to the ad7476 ADC. It is
>> currently 100% untested, and shouldn't be merged as is. I'd like to hear
>> opinions on these changes before adding support to the ROHM BD79105 ADC.
>>
>> Intention of the patch 1 is pretty trivial. I'd just like to hear if
>> people think the enum + ID table approach is preferred over direct
>> pointers to IC specific structs in SPI device's driver_data.
> 
> Definitely prefer direct pointers as you have here.
> 
>>
>> Real reason for the RFC version is the patch 2. It aims to clear the
>> supply handling logic. I did also an alternate version which requires
>> the names of the regulators to be provided in the chip_data:
>> https://github.com/M-Vaittinen/linux/commit/cf5b3078
>>
>> I believe the version in the link --^
>> is clearer, but it can potentially help people to add issues with supply
>> enable ordering.
>>
>> I can't still say if the patch 2 contained in this series is better, or
>> if the one behind the link is better way to go. So, RFC it is :)
> 
> I missed this (who reads cover letters?) in first look.  Anyhow, having
> taken a quick look at that alternative I slightly prefer the one you have here.

I need to ask if the "here" refers to the patch contained in this series 
(let's say it's version 1)

or the
https://github.com/M-Vaittinen/linux/commit/cf5b3078
(which I shall call version 2 from now on).

> Even if we have supply ordering issues, it seems like they are unlikely to
> vary randomly across supported parts so should be easy to incorporate those
> rules with the approach here if needed.

Reason why I mentioned the supply ordering is, that (AFAIK) enabling the 
supplies in wrong order may silently damage IC's in the long run. Nasty 
problems which may randomly manifest themselves only after a longer 
period of time - breaking the hardware with seemingly no reason.

As far as I know, the usual case is that the VCC (or VDD or 
whatchamacallit) should be enabled prior V_IO (Vdrive or 
whatchamacallit) or Vref. The version 1 (as well as the currently merged 
driver) do always enable VCC first. The version 2 does first bulk-enable 
to non VREF supplies and only then enables the VREF. Some ICs use VCC as 
VREF, which might result the VCC being enabled only after other 
supplies, but I didn't notice any in-tree supported ICs having both the 
VCC as VREF and separate Vdrive. Also, I have no proper information 
regarding _how_ unsafe it is to do enabling at wrong order. I suppose 
different ICs can be more or less tolerant towards this.

Hence, I assume this is rather safe. Problem being "assume" and "rather" 
- which is why I wanted to have another opinion as well :)

Thanks for the feedback all!

Yours,
	-- Matti

PS. Anyone planning to attend the ELCE at Amsterdam this autumn?


