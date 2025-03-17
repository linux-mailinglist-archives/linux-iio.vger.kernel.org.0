Return-Path: <linux-iio+bounces-16935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FFBA645A0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85C43A7F40
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347F21D5B7;
	Mon, 17 Mar 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDfDr+xP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56821D3FE;
	Mon, 17 Mar 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200422; cv=none; b=CWhz2oR3Q6luJZcxCCwiQ9fkQI0TNopQqlELbqTnu/vWG83pztBxoYMi672Xi0omdKMS3ux2NH7GagfHQN2mfpnSAQ4H5JC3dGoM7uNRxObwpjStZU4kqRtvErILIgefjT5kWw2DKfDF0xEdw/FZQVHwyeBsE75lKc7FnMhfK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200422; c=relaxed/simple;
	bh=RdNs7rkgFIcJVRakde4fYesyLt8wyxFsakAQzXEu2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW7uPWSXmJOegCPdCO2uzJf3h6Y/doNJDLLRVurIyu4DfXpl7xK0k9JxAPCZhWsMNKk4fGbSZgDUVUXr9WDrbmrnyQziQ34YSIRPtPO2HIw1hXXtqneJHas14v33V8V2KkTKYk8NIEcMgwrRi8ozGWu8G8MZy55k7t129mowiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDfDr+xP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54943bb8006so3835650e87.0;
        Mon, 17 Mar 2025 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742200418; x=1742805218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uvt66o4qqe9aHifIiONRpFOWyas2jZv/gh0Si3C+ehU=;
        b=PDfDr+xP1REt2doMActslinRQCfx1qx7LhvYy4435cbMi5KaCIJxv+LULGcMMHy6Rv
         7tp0FMN3lAebTEzAobofKsdCOUR+ywYdPZA7rs2DR63StOkIj41x+rpd4SCBgmpbHCsx
         y3FHwxnJ+gAgXTbWAS+iS7g+c3pK3m4Ke93IJuyN8aGL01vjO2scgd7fzpamHt+4Ns3x
         +t78BFUqwTyDeie0L5D5WSy0G4Al4tqrW97xXcHAzR1SgonbM9fFgQweSaM0B0ZfIAZK
         CJZ9ulbTECmdsjKNxu5uddmJLFqJqfcxgZZ0FYzvu5SlQeSOy8XR+FzJ2yoiJPqQ+Cfn
         mujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200418; x=1742805218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvt66o4qqe9aHifIiONRpFOWyas2jZv/gh0Si3C+ehU=;
        b=TNysFnNScO5l8EC9XEizD7VCnQY52n8tBQ8EdbwKTNsg/tLYYllzjAXsH9uVEo92sF
         eIK0EOjOR/0j6OA+3GT+XQTA1ByFc6t65U68MWKVT2OjTFDPEA1gMMCDkAjkxpLU5zZS
         pdKDqdJYAxJtOprhhu/NnoOcvDhCte30b6C/+aZpqWYLmeX5mi5l9CGbh7EgMBH3+eM2
         f4kp6HeJYKi+6OUAMcZW4HmeAULHNZ8PtaS2UFfSqTuuA8md92/aCCk6efSC7qnrS6Jz
         aguJZ/NARLYop7SnlirVMn3RGgAqkQSgp8UAOXien9bH4JT2lhbBUE0Adb+Vmy4QbYCC
         OB1g==
X-Forwarded-Encrypted: i=1; AJvYcCUwLCv+rv+ifw83ckUXIZu4Vsvt44U9a1Z9DFQESnEvXL3FqfiiEZSu6rRJMxPpGuMlJe4CPQjZ6TD6ZwFf@vger.kernel.org, AJvYcCVFrTMZLXSvkVqnNw3c7q+VzlwgmC1QSEaS+I/xuBfBWEYO+Y/V5KJnVqC+XBiHMyQdt4vvsNS2Xjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1beIM7jGdJHx+Mi3Zjt9al3WTUnAyHflVx8KM3xRKdCBvdS1m
	C+yES2DFVbvBMArh5gY7ytPOAyEmSJk+BcIpx/szwRFyFeZePpKz
X-Gm-Gg: ASbGncuBmef+48FfFwttc1Ll7soMVFwn3Moq0p4Y14lTCXKAUl5Jt9+4szLWjhAeWZm
	AI5x+jQm/QWGQbGqwNF95pZz+fbjpGi+KHGo4gqrzfbD0WCSOpbfMWfqfs9jGJyzV/Jn1YblyxZ
	ZvgLTnp6XMgsDQncHxjL8KES0g0MUiU/09uhMl2/K0aHYKIb3fHXK7aYC71z/eFDMpSbqe/bU1V
	bZD3TpWgA/wTkU3+sHAULqg7HOjWNMv1oFcSdQ693jTLO1cZqDZnUQA+3Vs35ZaZ6J+1VAO5j3V
	Ty9FqKtwGSxbAbV3CYdRE59/lEuitReNEzpU7pxxUDx0UO3X1DKfTdB8bNixlzKzXcfxB8AwaXM
	3AbLuMpHrJFfZrslBx5INuK7wMA==
X-Google-Smtp-Source: AGHT+IHnNysA7xfWnafyu0CHbf8gLVJlMGB8ZFa6CNGOf4eK0zgg1hkPSu7O9V9Gwlipd/Uyjkhs/Q==
X-Received: by 2002:a05:6512:15a9:b0:549:918f:eaf6 with SMTP id 2adb3069b0e04-549c38d3c4amr7107022e87.3.1742200418300;
        Mon, 17 Mar 2025 01:33:38 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864f9bsm1261696e87.153.2025.03.17.01.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:33:37 -0700 (PDT)
Message-ID: <cd3d2404-2fbd-4775-a970-b43ba8eacc27@gmail.com>
Date: Mon, 17 Mar 2025 10:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
 <0d7b37fd-be93-42d7-9610-d2184c601981@gmail.com>
 <Z9Q_GK0_4J6ga1or@smile.fi.intel.com>
 <fb0cee75-30aa-4175-b518-cbf9f3b7d46c@gmail.com>
 <Z9fV_lNgLaXXG2-j@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9fV_lNgLaXXG2-j@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 09:57, Andy Shevchenko wrote:
> On Mon, Mar 17, 2025 at 09:07:30AM +0200, Matti Vaittinen wrote:
>> On 14/03/2025 16:37, Andy Shevchenko wrote:
>>> On Fri, Mar 14, 2025 at 11:22:37AM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>> Okay, it seems I misinterpreted the values you have in regmap configuration,
>>> I was under the impression that regmap is 16-bit data, but it is about address.
>>>
>>> So, we need to know why the heck HW has sparse registers
>>
>> We don't know. And we really don't even need to know it. We can just use
>> this device knowing there are some.
> 
> Don't you have a channel to ask HW engineers about this?

Let's just say that ROHM is, while not huge, still rather large company. 
I'm located far away from the HQ, I speak different language and I am 
from very different cultural background. So, while there are some 
channels, it is not always easy, clever of possible to ask (not to 
mention getting answers to) "why this way" - questions :)

>>> for what is supposed
>>> to be sequential. This needs a good comment.
>>
>> I think it is quite usual that devices contain undocumented registers. Not
>> sure having a comment that this device also has some, adds much of value? I
>> suppose I can add a comment that we can't use bulk_write because registers
>> aren't in subsequent addresses - but having just removed bunch of
>> unnecessary comments from the code (as requested), I'm not sure adding this
>> one really improves situation... When one sees separate reads/writes for
>> data spread to multiple registers, he is likely to assume addresses aren't
>> subsequent.
> 
>  From HW design perspective it's silly to sparse hi and lo part of
> the semantically same entity. So, either the (undocumented) register
> is also part of the soup, or the registers have different semantics.

Or, the designer has not thought how software would be doing the reads. 
Or, this design has originated from a design done for a very specific 
purpose, which, we don't know of.

> This what needs to be commented in my opinion.

Yours,
	-- Matti


