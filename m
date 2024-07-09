Return-Path: <linux-iio+bounces-7480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420392C352
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 20:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E401F2418E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3718003E;
	Tue,  9 Jul 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3wgpTzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA81B86E4;
	Tue,  9 Jul 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549988; cv=none; b=pATITgVXjyjWwX7Xl0/xeJW/wXV1Nzqqml3slJRleJY7mO9TaYU8o68gO/77pkBNHPPTdMCa7+nUK/kqBUyrUxWc0WQr46H8AhTlmuH6FJKh3emJEC7ezqEI7VGkOnYsWWis08XiK87BAq4PJTWVNMjGCfAF4QJNsx9/3SvGzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549988; c=relaxed/simple;
	bh=o7KezNssQ10KvpArozHaQDe0vjPmXwq+WBOthEhLB8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZZ6ldreUDJRgX+7ndyk9olQOUup7JevHeY9A8zLcNN9Qa0lXRSSVg1ff4u5rkFktyp3e2z3ifzR1wH5gG0+B/aXgI4tWJ/iysPL3nGwQc2/gjYjtPraagMln3j1l+k7W5ylNJn6S+wJcyDR0sb4ofIC1BV83epyDKlNKoPLs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3wgpTzP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e99060b41so5924461e87.2;
        Tue, 09 Jul 2024 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720549985; x=1721154785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQvoh/iNTo3TxS26T9ik+xylt2WEP99UjL3OjvGhQKQ=;
        b=f3wgpTzPyG4pT78beBhwK1NyaNHB2V1VGH51bkdGguBUnoV/T5p076l+p3r7+LdCn1
         aaglEda3dqHXakXAR2OlZ9FI3N0m18w4nQTo3R2MI7xq7+hf35SImzjZ6lrl3w9r+UoH
         BMFoprQ8Ss0IKe/tEW/URD+Y71FZcq0Df27NdS95Zg/wkwZgWgxhwoHWNdVcNYWEjece
         0d1Y4/puLW+rIVSr5hDPNLVszkXSbq0DTdiOvGPvZM9PSpYbQZzSrtBsf9eQACti9QKl
         1l8HXKK3cMZNIKILz5rplrfIlkqSqOtJAj/n69+U3LOU676dUE6xphd45ZalBCK6el9l
         lpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549985; x=1721154785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQvoh/iNTo3TxS26T9ik+xylt2WEP99UjL3OjvGhQKQ=;
        b=ZVhMhD74UOTuQE8pM797rUARTJkpAnY7+6eB7pJfH+IhgIq4Rj4REP4LqVCmKCj22j
         v7etGYBm2X8v7kRMCiI31oQGxEgObBs2/FXc+FiiQ/alXvJ8OVr731PaGX+0TodGpXUT
         tpEZCGH+v3dP5PKVdEbZgXWeIyoou8gpgHT+LLFzk5uchFcFdgw+a226t34CVfvc+f6d
         lhu/Nc/uQDsiWPwUGnRC9xTnRCNXTbITtbkouZQ3SRHYjM6pgaOehA2mOZ21fVR0295k
         8JwQqzL4RHbwO/miMQOgYcG6pOKiPiiOjl3aFHZxTMOuJ0Ku1ED2hxY3onYbm5kTlD06
         qZPw==
X-Forwarded-Encrypted: i=1; AJvYcCXgHS16Ijt86oohdMiGAWHiYcxtRjH4o074QXOTDdfJzaUg66VZpk+TyP7+qZJY9L2F28y6uJCa75AXD2HYpn8DpfQJd+AY68AMOBXzPTxAuiesQHCn+k0lQQF/502ypBewaTiidkVmtyMAo6cfe6KwgeR1yYvHIK11IIDtj2blV8B8bg==
X-Gm-Message-State: AOJu0YzBatt1r7zQ8ECVcBjc7pFy0mxh8mshslvUzT4VVcTuJpllMM0V
	MLhyVdpZOSrA67YsxuzhBcqbmgQ9qnnhvFz1OND/2pPSmiyfEpCf
X-Google-Smtp-Source: AGHT+IGdA6qBs/h5ifQa1NLYmmqBaEPCm7bXVlEOtK8ASpi7E8t7wW94TgDIp5nw4qBgiqUe1GdzHw==
X-Received: by 2002:ac2:5605:0:b0:52e:97b3:42a1 with SMTP id 2adb3069b0e04-52eb9995536mr1796703e87.24.1720549984595;
        Tue, 09 Jul 2024 11:33:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e493cdsm313069e87.85.2024.07.09.11.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 11:33:03 -0700 (PDT)
Message-ID: <2b66ea94-dd77-4e86-b09b-c00523bdbf75@gmail.com>
Date: Tue, 9 Jul 2024 21:33:02 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: rename bu27034 file
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1720176341.git.mazziesaccount@gmail.com>
 <f83cf0d6f5b0ed391703ea3908ebd65b3f6e5c87.1720176341.git.mazziesaccount@gmail.com>
 <20240708-eloquent-overdrive-092c7678f913@spud>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240708-eloquent-overdrive-092c7678f913@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 20:05, Conor Dooley wrote:
> On Fri, Jul 05, 2024 at 01:54:26PM +0300, Matti Vaittinen wrote:
>> The BU27034NUC was cancelled before it entered mass production. It was
>> replaced by a new variant BU27034ANUC (note, added 'A'). The new
>> variant gained a few significant changes, like removal of the 3.rd data
>> channel and dropping some of the gain settings. This means that, from
>> software point of view these ICs are incompatible. Lux calculation based
>> on the data from the sensors needs to be done differently, and on the
>> BU27034ANUC the channel 3 data is missing. Also, the gain setting
>> differencies matter.
>>
>> The old sensor should not be out there so the compatible was dropped and
>> a new compatible was added for the bu27034anuc. Move the yaml file so
>> the file name matches the binding and change the $id.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> v1 => v2:
>> - New patch
>> ---
>>   .../iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml}      | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>   rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml} (92%)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
>> similarity index 92%
>> rename from Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
>> rename to Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
>> index 535bd18348ac..fc3d826ed8ba 100644
>> --- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034anuc.yaml
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>   %YAML 1.2
>>   ---
>> -$id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
>> +$id: http://devicetree.org/schemas/iio/light/rohm,bu27034anuc.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
> 
> IMO this should be squashed.

I've no objections to squashing this. The main motivation of having it 
as a separate patch was to point out the file rename for reviewers and 
ask if it is Ok. Furthermore, if there was a reason not to do the 
rename, then this patch could've been just dropped while the rest of the 
series could've been applied.

Thanks for the review!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


