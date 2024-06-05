Return-Path: <linux-iio+bounces-5802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C598FC3FA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D8285AA5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A418C344;
	Wed,  5 Jun 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coLt6arf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0019046E;
	Wed,  5 Jun 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570478; cv=none; b=BAMGxlc0/c4eDjWWhglIbb2OODWXZN8+g5qHKZzayxkCf0fdd9X10UBTMPm5KfUDGJrjhIblLs03V4GhYc+XBwDaibZKBQWHyKN9QJrY7L8cQeHiHJKd5nuDZ8sfMSkwa2UXQEY0eBxKWOR1YwzO7s2NaPo5gotuwNZaAlHh6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570478; c=relaxed/simple;
	bh=MMAbmLj+mJvb9CsqcjBb49/Y/hX2GCJmekXXMYUgIvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqSbtZw3tS7vB9AXM4xD5I6EonrNcZDOsjb60nbjIboWZ2ZTXUtvZv32d8eeLa+/YD9vl5ty4yhLzCVhfyMAWyl3mP8TSj4Wh1Gxxdb7v3am6Wqb24iqBavqXOjzOrj/DJy+OsgxTOE2UIeZxb0oRX7jD+agiFcG1x+xLAhivzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coLt6arf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43fecdecd32so9728921cf.1;
        Tue, 04 Jun 2024 23:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717570476; x=1718175276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDWOB7EBv5B2WKho7wJPzVpyx/+ujpqfMRZlXIkWYkE=;
        b=coLt6arfVVwgJVR17B/WXbHcurRTVB8G5d3X4JIIQl/DB1HzfUQM9BG2+toSwLTeI8
         CwudSwMTfw8tm0kV3+cJXOZ28fQIL2q3J8eGvVVvYyaQz0VwstXA4uuPwiIkGMrvarSm
         ++0kOx9M6x3SJ7QNHK1qfR+FQEfQoF8t9UZ8E17VAUIBcpyqwXRXVgVcQw+T2ZNe41aj
         SLzV4FO0MHgWIPxBd861dEsr3tIzew3eQSBikJWe8p0xPpnc5fMywLAdpKQa08HAR6ha
         dp+0YmFis+F7dEU2NHwR9dE4Q4pH8JskrJ0CKNCY6aafNhyflNrBx/wfCdkNiuor1tT3
         cr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570476; x=1718175276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDWOB7EBv5B2WKho7wJPzVpyx/+ujpqfMRZlXIkWYkE=;
        b=BQqk2GMDFO2kIAT/B59RR9hto1ZJ/ktS67f/sWeEHhh6TfVBVKaZ5+BaTxENkkFbQA
         D0nhQXkk9uWmGC+rvU7hrPt7cRw8BlHEMFjfdev/o5eRBO98f1lAkRzlD3zTyFhwGsfI
         kl/QoZxRIIA7TxTZpVYd3CiuSCw6AvT7cZovyy/Kw1s855lms8MEEP5IykOKtM/aaZcL
         q2pKhsh8CCHTCURbEPldxIRk0BbMFbGU7JM99LJSC2IJBrdVnF7NapA2zF7rynAaHSVS
         27Pg0UwMQd35WF+AWqtfzspLiPRk8Cna2jWA6FsItNFIPuy0OVeR3BJ836fODJJ7g2A2
         x8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfL4c3tqaglcylsEOYZna3/e1H4BofndaL6bGU7IkjTC0neMA74Rwmqzl3bIldrurR4MSROdKL+be6Ov2or0r465iyHXoqeOKGZdKAot+z94RKGfYLBt8ZZjZCzCAJ9Mg+GZFA2lYeWmj0vcg3dShaoJWecFZ4IEIzCu21+AZJLYYfBQ==
X-Gm-Message-State: AOJu0YxPANxa9byM+kqCDtRtnHfEJaXWM+EnV1s0YTayHCA/2YVHSaas
	A7Pr7WUtywNPoK0yIiacC9O8msyZEpcMBK05lCkfrwaNHm0AZXkE
X-Google-Smtp-Source: AGHT+IFGv0q5OpSFQouNN2F7eL9OTgKRrrso+8qxuwnp9407a1Xvutj4kmMWUjWKrYDieoDXl1VxSA==
X-Received: by 2002:a05:622a:1aa1:b0:43a:d386:f8eb with SMTP id d75a77b69052e-4402b598409mr18241661cf.22.1717570475629;
        Tue, 04 Jun 2024 23:54:35 -0700 (PDT)
Received: from [10.76.84.176] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23c2520sm56574731cf.32.2024.06.04.23.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 23:54:35 -0700 (PDT)
Message-ID: <0f0c0b92-af0d-4e68-9880-bacfd53d726f@gmail.com>
Date: Wed, 5 Jun 2024 09:54:31 +0300
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
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240603210014.6258134d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2024 23:00, Jonathan Cameron wrote:
> On Mon, 3 Jun 2024 12:46:10 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 01/06/2024 21:35, Jonathan Cameron wrote:
>>> On Fri, 31 May 2024 22:42:27 +0300
>>> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>   
>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>

...

>>>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>>>> +            19: ((AVDD1 − AVSS)/5)+
>>>> +            20: ((AVDD1 − AVSS)/5)−  
>>>
>>> That's what it says on the datasheet (so fine to copy that here) but I'm curious, what does
>>> that mean in practice?  How can we have negative and postive signals of the difference
>>> between two power supply voltages where I'm fairly sure AVDD1 always greater than AVSS.
>>>  
>>
>> I have not tested that as I do not have a model that supports this wired up.
>> If I had to guess they are the same signal but one should be connected to the
>> positive input, one to the negative input...but I could be wrong.
> 
> If they are, then as far as I we are concerned is this one channel with two
> representations depending on whether it is 1st or 2nd in the list?
> Can we use one number and hide that detail in the driver?
> 
> Seems odd though if that is the case.
> 
> I guess if we find out later this is the case we can tighten the binding to
> enforce the right one instead of squashing them to one value, but that
> is a bit ugly.  Any chance of digging out the info?  If not we can go ahead
> but ideally answering things like this make a our life easier in the long run.
> 
> Jonathan
> 

"(Avdd1/Avss)/5+ as positive input and (Avdd/Avss)/5- as negative
  this is used for monitoring power supplies, the inputs must be selected in pair"
Perhaps it's an internal voltage divider...? I dunno

So it seems like this cannot be used as a common mode voltage input.
I'll restrict the driver to only allow these inputs paired together
and rename the define for these selections.




