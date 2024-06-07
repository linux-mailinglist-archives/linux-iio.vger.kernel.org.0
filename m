Return-Path: <linux-iio+bounces-5971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38FB8FFD16
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535721F213E5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46A15442F;
	Fri,  7 Jun 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ+G+hwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAA19D89B;
	Fri,  7 Jun 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745381; cv=none; b=ZwdgsyPdIT0y/WQsKcFUpMcVrisp6ilvIkL0UGEiR9PXo6usp228hXpMXsfT21NQ+RPmoJ5HBuCKosdhuSmD+RJn0Vq1LYjBu7zL6bEIXm+SZYwde6XqhBzzr/EGxWh6GSzg37SvzYxv3Fivgbp4SBK7KiJBGUTL9SIBtJYca/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745381; c=relaxed/simple;
	bh=weMbjAVuFoMzFfr3Po8iOhGCl5HlwO1kTE9xRh9mM/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kd8M4h5BDm3L8j5/+Xvq/TltoG+DSuPfAmEYeDMfkVQ2vWBmdGNFzcDcEkInhNMACeB2fHxq6165i/Q510nLkkNipFN3KaSMS29Ehy7fkXzrhIVY1EnQCT19XCNzo1nIWp7Q6DGHRIQNiRksPwDdVo7ywe2mLkG0fXXsHSJmeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ+G+hwu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1880743a12.1;
        Fri, 07 Jun 2024 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717745378; x=1718350178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+bAYHtIw7hxjN1lHvR/lj9vmLxgOwdTTQ4DZlhtZa8=;
        b=CQ+G+hwuFr9kj8wPTFR2UMapC+L9SYh55B7GxxcvqiGkZAK2mkVn/VKeclA60aRRmC
         Pdq42375V1z4Xd3GZ7hiC4W9G81orbu9AHUcBrEJzPVuuDZ95kH/EsGZV4ee+JCY7l1q
         WlRR4K40sLODZ+V4rtNA7ArhUsyCd4UwoSWCiWUFL4RxbRgjX6WG2YeMPPRYbalDcGdx
         mK5S72WT3+EQxhnKR2OEOJP0qTZ4FvBU8wtG/e54CooWCo4I3PJsfQg57itv2dVEdPh0
         UQWSqukVn3wgyHiJG5ZcmN16urM4Q26GXLQUOu8yKe3HX0UAg3cilG38AXNkL2tPSHx8
         SXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717745378; x=1718350178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+bAYHtIw7hxjN1lHvR/lj9vmLxgOwdTTQ4DZlhtZa8=;
        b=J6ChZlPBWEdIQMVvnjIYyAkTcyn6hoqP1QFY1oFEQfAkyCPScCDa4knbQ6AogzaFgw
         uFobe/c+0xMykCjvoWFY10X6yn3/2jqXaSm3Hq5kb8QOU3auiEL70UebFCT9v6bLlEpa
         CFFajyoaW/cI2/DJTDlisanD+sLNvaBrv5ERfNYQbZtDxnwBusR6MVXKptMo4JEbUvTQ
         oWLnKVR99BrsIW5nfgS3Xedf29Uc+W6Uikpn3qOO1lfnH6vgbtW+Bia79KOndeWLCihL
         gywSr2Eo9F/OUAjYOB747GVnevrB+OLz1KtW90XoKQ+004FUm+7Y/8dA7I2ji1/s8mN5
         e55w==
X-Forwarded-Encrypted: i=1; AJvYcCXlJhvzo1jFCXxmclXEM1OuepCMjzYJNS/4kr/pxcRLxZlN7adxCLMdT7cVZfnYMx0sPdZmXDapoAtwFmr5h8G3ttEJafCHjHmcX/Yf6x9VFpufwsyuylcppO7xR2Sql7M7NpcMJBuva0wz/xK2mdFYng9NVEnko1YoZ0qdbf045b6c+A==
X-Gm-Message-State: AOJu0Yw4RkC2RE22ZFHkrAq4Gb8PwhzpnUCvPWoCeshatTvveyUqqaDm
	K1tBnqOmWgu3NPnvJVtSPvsKTCgnJNA4TWqbNm+9yEUNBmnIOHQU
X-Google-Smtp-Source: AGHT+IGj9GVj1bzF6WZinGCaDqFfjWPTnkAOfM5Lrw3tDB+/eO+m8Klx0LNd/lyxzbqfwxRcV2x7Sw==
X-Received: by 2002:aa7:c443:0:b0:57c:5ed0:ca65 with SMTP id 4fb4d7f45d1cf-57c5ed0ccd0mr346811a12.21.1717745377909;
        Fri, 07 Jun 2024 00:29:37 -0700 (PDT)
Received: from [192.168.0.220] ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae13faccsm2315697a12.54.2024.06.07.00.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 00:29:37 -0700 (PDT)
Message-ID: <29dfa7b1-8bf9-4996-b331-5de25bcbaa8c@gmail.com>
Date: Fri, 7 Jun 2024 10:29:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
 <20240531-ad4111-v4-1-64607301c057@analog.com>
 <20240601193512.0e17992b@jic23-huawei>
 <efa10caa-5e78-4f3f-8cca-c61d7a01e6fd@gmail.com>
 <20240603210014.6258134d@jic23-huawei>
 <0f0c0b92-af0d-4e68-9880-bacfd53d726f@gmail.com>
 <20240606205813.65b342c4@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240606205813.65b342c4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/06/2024 22:58, Jonathan Cameron wrote:
> On Wed, 5 Jun 2024 09:54:31 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 03/06/2024 23:00, Jonathan Cameron wrote:
>>> On Mon, 3 Jun 2024 12:46:10 +0300
>>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>>   
>>>> On 01/06/2024 21:35, Jonathan Cameron wrote:  
>>>>> On Fri, 31 May 2024 22:42:27 +0300
>>>>> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>>>     
>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>  
>>
>> ...
>>
>>>>>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>>>>>> +            19: ((AVDD1 − AVSS)/5)+
>>>>>> +            20: ((AVDD1 − AVSS)/5)−    
>>>>>
>>>>> That's what it says on the datasheet (so fine to copy that here) but I'm curious, what does
>>>>> that mean in practice?  How can we have negative and postive signals of the difference
>>>>> between two power supply voltages where I'm fairly sure AVDD1 always greater than AVSS.
>>>>>    
>>>>
>>>> I have not tested that as I do not have a model that supports this wired up.
>>>> If I had to guess they are the same signal but one should be connected to the
>>>> positive input, one to the negative input...but I could be wrong.  
>>>
>>> If they are, then as far as I we are concerned is this one channel with two
>>> representations depending on whether it is 1st or 2nd in the list?
>>> Can we use one number and hide that detail in the driver?
>>>
>>> Seems odd though if that is the case.
>>>
>>> I guess if we find out later this is the case we can tighten the binding to
>>> enforce the right one instead of squashing them to one value, but that
>>> is a bit ugly.  Any chance of digging out the info?  If not we can go ahead
>>> but ideally answering things like this make a our life easier in the long run.
>>>
>>> Jonathan
>>>   
>>
>> "(Avdd1/Avss)/5+ as positive input and (Avdd/Avss)/5- as negative
>>   this is used for monitoring power supplies, the inputs must be selected in pair"
>> Perhaps it's an internal voltage divider...? I dunno
>>
>> So it seems like this cannot be used as a common mode voltage input.
>> I'll restrict the driver to only allow these inputs paired together
>> and rename the define for these selections.
> Most mysterious :)  I'd be interested to know what value it reads
> back if you ever get the part.
>

My best guess now is that the reason for /5 is so that you can measure
the AVDD AVSS difference using the internal 2.5V reference.
So for AVDD 5V, AVSS 0V using the internal ref it would read 1V

I'll let you know if I test this
 
> Ah well, great to have gotten that extra detail even if it leaves
> more questions!
> 
> Jonathan
> 



