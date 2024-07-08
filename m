Return-Path: <linux-iio+bounces-7438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AF92A317
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 14:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48451C21072
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE5823CD;
	Mon,  8 Jul 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtwQDajp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40F281211;
	Mon,  8 Jul 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442615; cv=none; b=JixMjr3dpF183ijIOnxVvA7uHC+867PJJF4pn3IkU/4VpBsP8xeot81aAAj4YeCUk94pdBu1pg43Qysy9Q4P514emJB+gtaLQBBzvGW1QOn0DzpTbhUzPhr6W12ube8TdMx0OMq3o8LTfuuUpg4ZqomD7edvIWn1Q/3LsQOW1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442615; c=relaxed/simple;
	bh=BI28wz5XInTgMXnFdy8HZ6+ujkFpibqozOzg9QsIMI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeGE7/PWKuNzA8WxyqbV7pT47ig4ycvP6PxdgajqhqvD+7rMpDkSJEeeDC6fMLTICRDv0KDZfOoKyKcUcH+1tXAVX4i1qqZUzmzvKpVQtasEj7nMOWx0NwyiMhUiYPwAXrD2arK1nkE4Gvw/1c82+aYERmQxASVJ7AieGE7v4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtwQDajp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e9fe05354so5657360e87.1;
        Mon, 08 Jul 2024 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720442612; x=1721047412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tE4/Xw/cTAW7KhMX9aTxF+9g4e51k+vLuUCkv+6bpaI=;
        b=PtwQDajpW9YriSdltVhsOZo8EtXVyXm1UF6m7I0EXWbTYl7lW57mkWALIp2VY0Taty
         bgx5bg3DVQ9sZhQahU9jVo7hR7K27O402Hn9Tj+2fOu4uYWStlB03wg/LMBwhzvf2I1X
         jsL7KsL8IAojdOI4GgYsjEyhLDltThrfZpJc/he2Kkzr01mv8lc3c2ecGUdhymN8xOM3
         LMR2oU+irvGUJh7uX+iO1Va9y1dGxYfNHSL2t9FzK8Pv/Ovgn36obgHPhX+h09mEEx8p
         jAduzkGfiTAyyIyOl0oAQWHCpJImYq140kTArOOCo7Jzcax6yPVfOkRKc/cgC1QDZ3qu
         D8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442612; x=1721047412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tE4/Xw/cTAW7KhMX9aTxF+9g4e51k+vLuUCkv+6bpaI=;
        b=bPTUG37651Z1a3SL/D57ycSvu1iPgRWwTZV80StbFU7e9CmVWLqEOh0z5J1Xnb58uN
         CtiEbFeiVefGpfs8jS6jPdPWIUwBHdzEAcl20EpbeMv9vR7da50I6hZ+oolWVUPq/D24
         KkfFe3H22QlRHmvzM1KSXe8/Jxl+bjsyzOSUe7P3EDDBq7OGOFALLo2dqYgpNAJA2BBD
         FA4YXA35IECBOnZhI4+FNrH0lkkc1UxprbRlogF9g8q18lSG5e5Mj0jeTnf2fwEwPYMJ
         w8pOmLK8CpJKUgM/96OSdJN0waIEA1DuAJR2FixdUyPcclJs1xlK71kVUmwi1L+s65sB
         bTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlG5Ls+4TqR+dJ1UU/+nDb/Go4gdXuYOp4diBflknEK84phh9JRLHTQlgl6GsrSJMLG7sBH/QAqLUxC2WFEybKBmV+wXuJkDHmIqC8T5N9oooQPKTDgs1L7AF3uu+H8Z3YTnJoYJ8dha9kIVxyKSrWjedN9WF6cIhGQhoieQV+KvRDSQ==
X-Gm-Message-State: AOJu0Yy63JdclNuykdJ+Z6wYt1VX6EASJ7R6f1HrEBaqTarkF37WBkVj
	chBoW4TcMjT43SQD+iupHj+9uSd2L8kgTU9SxfDrAsRi/gM/+k6b
X-Google-Smtp-Source: AGHT+IFxhmAI/t2baGo+8FHPDAJctn5KhZOEAfWFa+hD/m+yvpkjzx7stU+T+XnzM4iZBgNF6eESyA==
X-Received: by 2002:a19:7702:0:b0:52c:dba6:b4c8 with SMTP id 2adb3069b0e04-52ea0619e3cmr9176706e87.13.1720442611240;
        Mon, 08 Jul 2024 05:43:31 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea90ba285sm723630e87.127.2024.07.08.05.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:43:30 -0700 (PDT)
Message-ID: <622f5382-10c9-4bd5-84ab-544d7c16f1fe@gmail.com>
Date: Mon, 8 Jul 2024 15:43:29 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: BU27034 => BU27034ANUC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1720176341.git.mazziesaccount@gmail.com>
 <c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>
 <20240707140536.1dbb989b@jic23-huawei>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240707140536.1dbb989b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/24 16:05, Jonathan Cameron wrote:
> On Fri, 5 Jul 2024 13:54:12 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The BU27034NUC was cancelled before it entered mass production. It was
>> replaced by a new variant BU27034ANUC (note, added 'A'). The new
>> variant gained a few significant changes, like removal of the 3.rd data
>> channel and dropping some of the gain settings. This means that, from
>> software point of view these ICs are incompatible. Lux calculation based
>> on the data from the sensors needs to be done differently, and on the
>> BU27034ANUC the channel 3 data is missing. Also, the gain setting
>> differencies matter.
>>
>> Unfortunately, the identification register was not changed so there is no
>> safe way for the software to distinguish the variants.
>>
>> According to the ROHM HQ engineers, the old BU27034NUC should not be
>> encountered in the wild. Hence it makes sense to remove the support for
>> the old BU27034NUC and add support for the new BU27034ANUC. Change the
>> compatible in order to not load the incompatible old driver for new sensor
>> (or, if someone had the old sensor, the new driver for it).
>>
>> Drop the compatible for old sensor which should not be in the wild and
>> add a new compatible for the new model with accurate model suffix
>> 'anuc'.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Rename indeed makes sense.  One minor, 'whilst you are here' comment inline.
> 
>>
>> ---
>> A patch renaming the file according to the new compatible will follow.
>> If renaming is not needed or appropriate, that patch can be dropped.
>>
>> Revision history:
>> v2: New patch
>> ---
>>   .../devicetree/bindings/iio/light/rohm,bu27034.yaml      | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
>> index 30a109a1bf3b..535bd18348ac 100644
>> --- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
>> @@ -4,20 +4,19 @@
>>   $id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: ROHM BU27034 ambient light sensor
>> +title: ROHM BU27034ANUC ambient light sensor
>>   
>>   maintainers:
>>     - Matti Vaittinen <mazziesaccount@gmail.com>
>>   
>>   description: |
>> -  ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
>> +  ROHM BU27034ANUC is an ambient light sesnor with 2 channels and 2 photo diodes
> 
>   sensor

Thanks Jonathan!

I won't re-spin this unless you ask me to because you wrote you can fix 
it whilist applying... Please, let me know if you wish me to fix and 
re-spin :)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


