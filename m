Return-Path: <linux-iio+bounces-16936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F1A645F6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA0F3AFC7A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466621E098;
	Mon, 17 Mar 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiXYk3/U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE121CC64;
	Mon, 17 Mar 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200933; cv=none; b=GEhVdpeugRRdtkGTN2rpJ34iI98uJpBswErtnwG0bgvqIoNfBByVVUbGwiw3cAJ1gluvMwToScjF2Nz4eJIahh0QXeX3v3fXrVNL0fk3xjW7M8AY/FK7AwdrE9+i6N+XOdqGDdYpmCkBuMlcMiN7joyF+xpO/LwU8sAKJGyiJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200933; c=relaxed/simple;
	bh=lKHWj9V8Nq6zT3iZ1PBCgGEfS1g71F1u7pC1RxEH4jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRP6aqxoqivMN9Pj3nTO1ESSu414P1f4tS6ZTmLY42cr+1u9HMPvM5f/v/tZIu17ALLBqZyMoI/PQVV1t+v9t5f3gJkpCPO5QGr99BxF61rTp6oTindZYuF83hQnSr3U2aAUjFVaq7Hk13vjoksogPbIIFJ1oSVbkvZoumDX2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiXYk3/U; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54996d30bfbso3745388e87.2;
        Mon, 17 Mar 2025 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742200930; x=1742805730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpO3HnxuMJXBU+70F/zOGGDYlbCQDeNotNwoR3G8/gw=;
        b=jiXYk3/ULVWd8KC0GyiPwBmnW9GkQlazLMqyHmJUdQZBMMs5yiQ7ObePPOGR8rwEFA
         gcKp6nUKUxJh/eqwoKihBRcXhaTI6h+sjPS0vt1SJwbr3eDxLCXeLVcVu7fxBJ2OJXQL
         VWyhQMZ0BBL5YhqpUwyYl03DCAFALJpTBl+Wynff0qf8QnOAe6b4W7AtH4cT05Em2LO1
         y/nJY6tFxsyj0JjPbhTcNSkUNNemvoqh7k4+H/iz7jfIH5EBzRNetB/YIJI7cF5bbrQE
         g3H8zhn0eWdqa9w28yvrb/b6VOEDarLSWMOJgipniI+oCQhhYKbEz1z3t8AXGZmMPijn
         CW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200930; x=1742805730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpO3HnxuMJXBU+70F/zOGGDYlbCQDeNotNwoR3G8/gw=;
        b=s7ThjNSvXQu6MzQui6NLw+xRQVKl+vV5FpKzgjaaAad3D7nttOdSADn30/hg/LLJPG
         +ZMc6DSb7wYK86OoAxx4+z6s22QpVAC1pGJiDhj53APISVuGtJRG1/9kg7dbl8d/FsMj
         8Cz9p9KjX/PX3Q7iTsRNtWXHK6qEDjghfq2a8r48bPyeGGgI3/3mpfKas4P8JEuEbrIi
         J7yvdve3RPoasqX8WjMPLERdvhc9ekkvCV0MrgtRYpY8UHW31btBPgRYlVFrECTqtGXH
         hd48S7ukhJD45PGplIZjEGvluWreNsP3PVyqhAIe590Y+AU1EBcv00XQIEQjVYy3l6c7
         J+zg==
X-Forwarded-Encrypted: i=1; AJvYcCWqFOs6j7/n+b201mdTRXjJjlQM9pvYTv8WLyC9rReMD+dxkZ01BMEMYqizW8do81YF9DuHvn0GTAQ=@vger.kernel.org, AJvYcCX1aBtYPcGZl9quG2JPZnGraHaG5KBxHk/TNNQi3HxhYPLZvGDsFikqEWs+2PK2CQKxsywLUnBTfMPL+MjT@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJF1Jbz9ubbX7NSzTnb8IZptuUBCPDik54l/2UHfnCgEgCg4+
	wuh2bN8NgBM1a6y76RMDS3A4soGEQTrJcnVYtUBzUjzm0DKTSkZn
X-Gm-Gg: ASbGncudPr/hlclj9elqW5IEn108hM7dVPjDkTmgaqSVDTkF8zn/iTxPE7T8T5ZoC6v
	EAoOxdylJEVGYBe/IzHXZ2dWjqV2NrO6qftJohr4SssonRIQjWJQwsck8tYGs7/DRtlXU61Xsdp
	gJV2JiY0rAKpn4kZ/wanKCWVK9htNQdGG2pugboNX8fZy+iERpu+f0F59KI4IkMT7Cd2N9wqcTa
	+4Ysc0KbK2BDsC/k1WPtuKV4xAkMzVH6BjewYNyWHAnVTkKdUY9+u/RfEAG9Jd7ORj8bbXQpiU7
	bP05dFdQTEbcfg4qCwGTOvcmUzueS0Oo+WWCeM3mnUus0Oih0A7Lu7A95sO2VyeWjhkxIvT+XQ2
	licVlGw7nXUFtnDxEJyV0KB/OvQ==
X-Google-Smtp-Source: AGHT+IEaEugzJ+pYBfCBL4Vt0JndH1mF1+5wo43FEa3qzrXwIQyPae9SAqetesylNstTDl/wwv+/dQ==
X-Received: by 2002:a05:6512:1286:b0:545:10eb:1ab2 with SMTP id 2adb3069b0e04-549c398d167mr5642074e87.33.1742200929794;
        Mon, 17 Mar 2025 01:42:09 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7bfea4sm1224769e87.67.2025.03.17.01.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:42:09 -0700 (PDT)
Message-ID: <0db2a42f-d393-4e75-afbf-cf30c0e06cce@gmail.com>
Date: Mon, 17 Mar 2025 10:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
 <Z9LQ0O34EUM8WZku@smile.fi.intel.com> <20250316094112.6731bd01@jic23-huawei>
 <50b126c5-248e-4694-9782-4f28d6db5fce@gmail.com>
 <Z9fUmo5wp3EcNWzm@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z9fUmo5wp3EcNWzm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 09:51, Andy Shevchenko wrote:
> On Mon, Mar 17, 2025 at 09:11:08AM +0200, Matti Vaittinen wrote:
>> On 16/03/2025 11:41, Jonathan Cameron wrote:
>>> On Thu, 13 Mar 2025 14:34:24 +0200
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>>> +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
>>>>> +				&sun20i_gpadc_chan_template, -1, &channels);
>>>>> +	if (num_channels < 0)
>>>>> +		return num_channels;
>>>>> +
>>>>>    	if (num_channels == 0)
>>>>>    		return dev_err_probe(dev, -ENODEV, "no channel children\n");
>>>>
>>>> Note, this what I would expected in your helper to see, i.e. separated cases
>>>> for < 0 (error code) and == 0, no channels.
>>>>
>>>> Also, are all users going to have this check? Usually in other similar APIs
>>>> we return -ENOENT. And user won't need to have an additional check in case of
>>>> 0 being considered as an error case too.
>>> In a few cases we'll need to do the dance the other way in the caller.
>>> So specifically check for -ENOENT and not treat it as an error.
>>>
>>> That stems from channel nodes being optionally added to drivers after
>>> they have been around a while (usually to add more specific configuration)
>>> and needing to maintain old behaviour of presenting all channels with default
>>> settings.
>>>
>>> I agree that returning -ENOENT is a reasonable way to handle this.
>>
>> I agree - but I'm going to use -ENODEV instead of -ENOENT because that's
>> what the current callers return if they find no channels. That way the
>> drivers can return the value directly without converting -ENOENT to -ENODEV.
> 
> ENODEV can be easily clashed with other irrelevant cases,

Can you please explain what cases?

> ENOENT is the correct
> error code.

I kind of agree if we look this from the fwnode perspective. But, when 
we look this from the intended user's perspective, I can very well 
understand the -ENODEV. Returning -ENODEV from ADC driver's probe which 
can't find any of the channels feels correct to me.

> If drivers return this instead of another error code, nothing bad
> happen, it's not an ABI path, correct?

I don't know if failure returned from a probe is an ABI. I still feel 
-ENODEV is correct value, and I don't want to change it for existing 
users - and I think also new ADC drivers should use -ENODEV if they find 
no channels at all.

Besides that I think -ENODEV to be right, changing it to -ENOENT for 
existing callers requires a buy-in from Jonathan (and/or) the driver 
maintainers.

Yours,
	-- Matti

