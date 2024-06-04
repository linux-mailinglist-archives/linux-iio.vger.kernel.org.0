Return-Path: <linux-iio+bounces-5757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4EA8FB2F6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD901F215BA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A80146A99;
	Tue,  4 Jun 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoqMPFHY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D571465A8;
	Tue,  4 Jun 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505594; cv=none; b=InhZkCnvmnnUIW/6qM/mreYhac/GZI0wC1HWsWKrltuc/35g3DBaNDOczJmqJlAFTjODmX/7er/KmKwlxHDfKYAIiElxc8v2HNxV+p+TVNm7HSqiKuJs/e7XBcraO4iEm537aFRw94+ruTeb5B5zGKI5ZAFfCL6Yb6xlXRxSINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505594; c=relaxed/simple;
	bh=/0Z5do5U7FHNT8l5qEE+RkwK0432uhaqsm9lIUnKlCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feEMYve3UGqX06pH8P57u1bEcnlUDpausC7/wW1Q6ZgVq+HfeCQlFYZXgLEAKLu+/XPZlLvylZB2yU8U3k3hwpDdZ10aP940Of4CIAi1Gt5/DazxVQap62VhGbGoUP0mqwgPNeuexWCFWy07re8wENFpJNgNH7llh1FaO3jetek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoqMPFHY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so3693426a12.0;
        Tue, 04 Jun 2024 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717505591; x=1718110391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jA/3XDMRYNfFF/x22X/HxutHqnTJnzF8YXOQgaSCQAY=;
        b=UoqMPFHYxFrr6ksVLln0ZmE+PTgu7l8c04YcHBKe6sVjapKQvfIuwt0p1R1D+F5EyU
         Ocn0TlL2KUiUgX0ADnkfyYLm5qY1JG4+RQUXt/hpiJmVQiapzEzGVlABJEyVpW6xFpQP
         mbBIOYkIoICsdhrQdVCBbuQIARr0ovfSb8CS0pWAXxinUooGE6qL7boWYELTzYLn9y9C
         txmQWcNMSyR8SLwHfFwZEswROFkKNngKAj2EEdCuU39ICGh9wOzX6EJhb4xWJid0VwUQ
         vZakZLOZAoD4BTfIaYQ0pYSwlp9NVbYeaA4LBnFh1yjFTscp32dECa/U0UhBofmG+51B
         hccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505591; x=1718110391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jA/3XDMRYNfFF/x22X/HxutHqnTJnzF8YXOQgaSCQAY=;
        b=da19xVB1xO2KIretSDtoH0rPkttswWACYLC3aGe7L8KhUlhEDy/HyPsuJ5qT6J2fRN
         T2D7irjGfwNhQZXiEXceEZUjl9svl+LNm2V0pk48rXdOgpCZ/wY4+dmZwiwUjQhOpMnK
         5T7gQGBYMJLhmAfJP33Ic2kbdU/6zGHP7us7E1oGwGAy6ONEVq//dR0ZrHywP1V1ZR1E
         28IB0+tHtOBsgYcyJgULZ2Qk8icewiEig/1JdnYj79SOt4zTdFF1luBjOHOXGS4czbbG
         fViTZLVFwtmMXC14xZzt2lPxOO748vTRcZzeQSz6go8hG4Deh/ofvKF3liK2iAWemX6Y
         wQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/0q9GgrJSPYEQ4k+rQuhqPwKx9snn9QMCPe5fl7yhbz4rScHs4nfFz+qGqa+GPt8M15NcYYCwadybBXOccSvFHuWmGQfW92+I2Hl8lJBShtxFAY5BXAiruOeE+PPruiaJuXsnmg==
X-Gm-Message-State: AOJu0Yzg6uRpShwaXi1DDFycZC98wFLyWHs8PVn26eTudABuNamGk8ED
	OelZ+COGgzDvTWlBjgXAZo8AL4mg0yN1J6lqhzPzI2Q4LH20+GqO
X-Google-Smtp-Source: AGHT+IFYik7pF49ujBeIaufnGjl1TZQfJJcRHhW17ogA+Z7WUs+FmnspEYfwsKjiHnM+N/tpJSf2rQ==
X-Received: by 2002:a17:906:bd1:b0:a65:135d:2ef0 with SMTP id a640c23a62f3a-a6820901cbcmr841265466b.34.1717505590514;
        Tue, 04 Jun 2024 05:53:10 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68e9eed9b1sm393402766b.131.2024.06.04.05.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:53:10 -0700 (PDT)
Message-ID: <f241957f-6f4b-424c-9ea2-d7eb564daa4e@gmail.com>
Date: Tue, 4 Jun 2024 14:53:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
 jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
 <a628db76-a48a-4492-a3cc-f93c0f67ad04@gmail.com>
 <961fa617-a76b-4b79-956b-795a55fec959@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <961fa617-a76b-4b79-956b-795a55fec959@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/06/2024 12:44, Mudit Sharma wrote:
> On 03/06/2024 23:37, Javier Carrasco wrote:
>> On 03/06/2024 18:21, Mudit Sharma wrote:
>>> Add myself as maintainer for ROHM BH1745 colour sensor driver.
>>>
>>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>>> ---
>>> v1->v2:
>>> - No changes
>>>
>>>   MAINTAINERS | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d6c90161c7bf..945873321fef 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19407,6 +19407,13 @@ S:    Supported
>>>   F:    drivers/power/supply/bd99954-charger.c
>>>   F:    drivers/power/supply/bd99954-charger.h
>>>   +ROHM BH1745 COLOUR SENSOR
>>> +M:    Mudit Sharma <muditsharma.info@gmail.com>
>>> +L:    linux-iio@vger.kernel.org
>>> +S:    Maintained
>>> +F:    Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
>>> +F:    drivers/iio/light/bh1745.c
>>> +
>>>   ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>>>   M:    Tomasz Duszynski <tduszyns@gmail.com>
>>>   S:    Maintained
>>
>> Hi Mudit,
>>
>> is there any special reason to have a separate patch for this? The
>> addition to MAINTANERS for new drives is usually included in the patch
>> that provides the driver itself.
>>
>> Best regards,
>> Javier Carrasco
> 
> Hi Javier,
> 
> Adding this in a separate commit was just a pattern I notices with some
> other drivers, for instance 3b4e0e9.
> 
> If necessary and/or considered good practice, I can squash this in the
> patch that brings in the driver.
> 
> Best regards,
> Mudit Sharma

Although there might be some cases where it was added separately, it is
much more common that it is added to the patch that provides the driver.
Some perfectionists even include the entry in the dt-bindings patch, and
then add the link to the driver code in the driver patch. I believe that
a simple squash would be ok, though.

Best regards,
Javier Carrasco


