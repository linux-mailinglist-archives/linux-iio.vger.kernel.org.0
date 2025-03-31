Return-Path: <linux-iio+bounces-17392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A4A75E96
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B11666C1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA656158DAC;
	Mon, 31 Mar 2025 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY4OSTr7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB0BE67;
	Mon, 31 Mar 2025 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743399583; cv=none; b=MEdF4Kd1w0ZwHhOgepeqw88+dIMkUv900YD9Qg9QrRn5XewoKP6cersaWnNfU9xhTSRguaPpNxkl2NCMiaKCPkTkpetX/rOnG0G928u8M3m7iDkm4AmjbGPWu8Q3fLJulbwqrNABVA/eFKDdQZZWz/ZMbj/BGFPu71w9BPZ7Vhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743399583; c=relaxed/simple;
	bh=IeA4lf0PVKOwd3spaqPGr7Zxq2RRfIFFLFhFKVVuUcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIksl1ugw3oPC7wIeUTeI9BDW51xHMERSQfOXzlmS+L4QVdnVEhpzsRM6X9+Bt6nC+C4fzPWuKI+UFq77soCPI4lm9gFw0ULrfjNLh1jEfAHBiM8aWSvJ7ogIUR8UXbfaH6q59WXqoGWAXN9M2SfENg89ANK0e9siy0bQmnlVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY4OSTr7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so23491061fa.0;
        Sun, 30 Mar 2025 22:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743399580; x=1744004380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AaMaaA3HgI5ZgkbFyIrsVuNy6uPjPTFn+suKBrfMsc=;
        b=ZY4OSTr72WzdjJeJvP0suomh0HCPqGDkURJ9VgF5eFfbGuBc8n3/kc+SLlGZ+y5dOz
         xud+2ysgtOUbMhc7Q+9IzKtG/G6Ei1502AodJH4tS9js+amMeM2PgSnNbjKdqV3SJZdI
         kiokw/+F4QYD9FXyC5ziqYwV/hVRPOGHHUIrQMND0vnnnH/Yj84a9cN9RDGFSvdW44LE
         wQTeBzi+fmq/1VK11sEfeAv2k4u4TTjv9WJkmhCJQdDXJ6fJ2+gpNNo2GxgjMWSwZY8K
         nJ6L8Qf06A1a93YxIamofc4rNLzAp+KIxiDOJoMb4mJEnY7oxJyYp2snIu6JRkzTXEK0
         9mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743399580; x=1744004380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AaMaaA3HgI5ZgkbFyIrsVuNy6uPjPTFn+suKBrfMsc=;
        b=BpX/2toMHoBfOE47Ws+uJl4qw5EbrTntBT40HkT+HyF07EHBksKsQ6DIh8a4R4ZHKP
         VGo8TxJxN/dzcFWHNsNB7IIKPC6Jws9mvOA/VNfdTxVDNSIHKz0+ciqIF5fP/rtHM449
         jYfOKjTCoWh2BMGNibbg89v0SiIrmsfURLmF68r3wnoDfzvWZaVpa6fFsqhsEKMOHrTg
         r4TODRYDrnFYFr+qrMJcJbT3L25baDjgsHzZM0xrStSlDQe8f6jwa83Oz4oX5N69YgBV
         /CbM4le2ltj8lXwzk6UYQht7tXCQBZQPCwDCkywYn8E8QaXv1lbXy4HkP/7pHkrjFyUJ
         yW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVN7Wl44qdLb02feQ6LMfKgH/9CUyXpY3wByIjZQTPW9ecNkunpQDwiK1QGYtgg5zrgbwi/A0ZMrji7@vger.kernel.org, AJvYcCVPG+5dpr+ov/BoyKewwloBdnPtQnP/MWnKv70UIobzwauuLKUetGJjELwAS+BrWfBh6Tq86aRHaZKkxmts@vger.kernel.org, AJvYcCW9CFZhraHSvU/TIg2xxFgvPBb/aqjV07rByAQrhVdhSCiXOsK30k7YNkvbR8ggBamBqBbqI7QpZswK3pGle5bjHY8=@vger.kernel.org, AJvYcCWtVrDzWloN1TWnWCY1MQzse1q57SmtXFBuU2fxPTbb24zfGBnnhlJcrN46zi8owFe+ZC5wa0Hnzyk09g==@vger.kernel.org, AJvYcCXG6b3ipXy1JySOkLEkCwg569GiKL1V4MmdrYG89cO+D0d2sESRS51uS/pyikb94X0eX2syvHCIzVkE@vger.kernel.org
X-Gm-Message-State: AOJu0YyUu64qcpESBT4wHZxTPef69NmNythEyverB3MWk1jZ/ErVX5xU
	ezPRyvg1t7LoPGbV/h40DwoNVCfhOfpvGkJFge/ZzoSmvQgRITkf7q6CXQ==
X-Gm-Gg: ASbGncuiD8XdpvJRCg5wEllFaRs72UpEVuNMP4MjBk8J1MOlV2CQ73N4jYducPWB9OC
	nSd0A6s49R/mzMBMb7GCpR+bw3iYrq96GbWjdSAVKuCM0ZNY64S3B5mCFQxt8cABGWT7FmjDn3X
	XpNIhrWa7YBuqRWyrnfQSsREMxQcnRodjVH6xcbaQZtQQeigX2GybPUI3d+3hqn1o9vVaLl+ZVm
	Z1I97/zqd9Pw78/VlEIUAp8WRPqYdcwSwB0dPEoYQxqYB2ur6mvSOsUY0mTJInBylMNVXOyHaXp
	oF4OGK5mSl2Uafu6WLTIY6mGBwywUxCNJKAqxOfocUJjJvQGqt9RO+uK5/5cK1hjKztsiKuOAQO
	hBEC0IdswqWSKk9CJOU4A9SkSwFQ5AxM2VSQZ
X-Google-Smtp-Source: AGHT+IEax/bYtDNpsnoS8lp2/Xv0SOwDw+X/Qx+Fp6+LfV4yGOljFnL11rqq5UXPyHcC3DYhadI4bQ==
X-Received: by 2002:a05:651c:1590:b0:30b:b132:43e5 with SMTP id 38308e7fff4ca-30de0278988mr32677431fa.19.1743399579629;
        Sun, 30 Mar 2025 22:39:39 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b4ccdesm12941591fa.67.2025.03.30.22.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 22:39:37 -0700 (PDT)
Message-ID: <4d66b3b5-bfcb-42f0-9096-7c448c863dfc@gmail.com>
Date: Mon, 31 Mar 2025 08:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] iio: adc: add helpers for parsing ADC nodes
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com>
 <Z-mnNtYLkwsTYjMh@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z-mnNtYLkwsTYjMh@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcelo,

Thanks for the review!

On 30/03/2025 23:19, Marcelo Schmitt wrote:
> Hi Matti,
> 
> The new helpers for ADC drivers look good to me.
> I am now very late to complain about anything but am leaving some minor comments
> below that can be completely ignored.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> Thanks,
> Marcelo
> 
> On 03/24, Matti Vaittinen wrote:
>> There are ADC ICs which may have some of the AIN pins usable for other
>> functions. These ICs may have some of the AIN pins wired so that they
>> should not be used for ADC.
>>
>> (Preferred?) way for marking pins which can be used as ADC inputs is to
>> add corresponding channels@N nodes in the device tree as described in
>> the ADC binding yaml.
> Not sure it's preferred to have ADC channels always declared in dt. That
> question was somewhat also raised during ADC doc review [1].

I had missed that doc and the review. Interesting read, thanks for 
pointing it :)

We did also do a bit discussion about this during the review of the 
earlier versions. I am not sure if we found an ultimate common consensus 
though :)

A recap as seen through my eyes:

- It is preferred to have either _all_ or _none_ of the channels 
described in the device tree.
https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/

- This, however, is not _always_ required to be followed, and it may be 
impractical in some cases:
https://lore.kernel.org/linux-iio/6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com/#t

- We do have bunch of existing drivers which we need to support. With 
some very different approaches to bindings.
https://lore.kernel.org/linux-iio/20250302032054.1fb8a011@jic23-huawei/


My _personal_ thinking is that:

This means that we can't hide the binding parsing in the IIO-core. We 
can't go and change the channels in existing drivers.

But, we can provide helpers (like this one) for drivers to use. I also 
believe we should still try to have common (and preferred!) approach for 
the _new_ drivers. Eventually, the new ones will be majority. Some of 
the old ones die, and if we keep same practices for new ones, the old 
ones will become rare exceptions while majority follows same principles ;)

> In short, ADC
> channel may and may not be declared under ADC dt node. ADC bindings often don't
> enforce channels to be declared. On IIO side of things, many ADC drivers just
> populate channels even if they are not declared in dt.
> The ADCs you are supporting in the other patches of this series seem to require
> dt declared channels though.
> 
> [1]: https://lore.kernel.org/linux-iio/20250118155153.2574dbe5@jic23-huawei/
> 
> Would something like
> 
> A common way of marking pins that can be used as ADC inputs is to add
> corresponding channel@N nodes in the device tree as described in the ADC
> binding yaml.
> 
> be a good rephrasing of the above paragraph?

Yes, if we don't want to guide new drivers to either have all usable 
channels, or no channels in the device tree.

I think Jonathan said he'll be rebasing this to rc1. I am a newcomer and 
I should not enforce my view over more experienced ones ;) So, feel free 
to reword the description as Marcelo suggests if you don't think we 
should prefer one direction or the other.

>>
>> Add couple of helper functions which can be used to retrieve the channel
>> information from the device node.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
> ...
>> +static inline int iio_adc_device_num_channels(struct device *dev)
>> +{
>> +	return device_get_named_child_node_count(dev, "channel");
>> +}
> I wonder if this function name can eventually become misleading.
> 
> In Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml we have
> temperature sensor with channel nodes named after external hardware connected to
> the sensor, leading to channels having different node names. Can anything like
> that ever be accepted for ADC bindings?

My initial thinking is that the hardware which is connected to the ADC 
should have it's own node - and there should be only a reference from 
the ADC to the other hardware's description. I think the connected 
hardware should not be a property of the ADC channel.

Anyways, the current ADC binding (bindings/iio/adc/adc.yaml) says the 
node name must be channel[@xxx] (which, I believe makes sense as it 
makes it easier to understand device-trees for ICs which may provide 
other nodes but ADC channels too).

properties:
   $nodename:
     pattern: "^channel(@[0-9a-f]+)?$"
     description:
       A channel index should match reg.

Yours,
	-- Matti

