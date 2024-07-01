Return-Path: <linux-iio+bounces-7092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 928CC91D936
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184531F22319
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B668002A;
	Mon,  1 Jul 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS49lQEP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F36482D8
	for <linux-iio@vger.kernel.org>; Mon,  1 Jul 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819669; cv=none; b=jvORGn3I53muZhI2WZLrTxDAZ3h4By4VHac7gLBHanLb4WbdCBs5Wjl5BL/w5FeXLWEiIudbUc29PccYN5BMLdUAaJ6j0qN0XSqYpwVpzrCW+a7WtFeKLOk3svq0M7RNekqeO64rHFAagOBzsMYSjtXcEHTsh7Zp+JAgPSKvn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819669; c=relaxed/simple;
	bh=oTiwMhaaeoH5tbCv6JkQxiWBwEjlIzERTEn46lx2DBM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SrPME/Mb4Io2m3iQUArxoPXlzEH+Si5GSsTX/qQkGSpUH6JWZPMrVUhesv7csGwXDvDxRNoAVgXOoX5XolE3lipi6NbxcRvKrOQ1lZj80uCEgjtPISgTCs5x6HC3xemU1vQk6KbLbXZyZtb5hc0iNBzssECgcXUTDysUxwSWIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iS49lQEP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso26041141fa.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jul 2024 00:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719819665; x=1720424465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luwhpQx8+Zob3V/T6YJ1851XBEZCKognBMDo82oxZaA=;
        b=iS49lQEPiNTUdiblK35IKLEZIqAhv8lkJnJXxTsBn4YcSAp6LPUOJTcpiJ7zcbgpSU
         smfoaSusQraig9INV4BO5oAZdPu6nK6wfQCpzK2PPiSqwdhviH/Lv6B6AwZBEk3ieRFF
         VKPiBXvwipYfRjMOEvs7uAMifBiuMM08i3vNpubeH+43pBgm+qhwGrQLiSm7ZRToQVZ/
         e50oCl9UxizuCkGOFMfvqUmaKPVXOvbAg3HqPousjAKjlS9nQAVShB6+UQXbQnimR1uY
         31PC7/IBQ9dax1+bUCZooFAzO3Pve5TEsf5JRGfwAVUT9a8HetCx9UsdqVYNIvTN7ISj
         AuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819665; x=1720424465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luwhpQx8+Zob3V/T6YJ1851XBEZCKognBMDo82oxZaA=;
        b=hprdrgBUMrUmfzM8yDo5e7mWPG90B6k7fJMcgF3bbmTkxOBrzhY9HxTnR1OZ4+LG/U
         xeckV3Nv95/b0ZJbbM2qRkIzXE5Vska+cMkarlbWSYqdcUtS1iYEYYzDr5R8qCoOchF1
         4H7VMzOjvf+Gv0bq+rlz6E2VFqY74HCYCSIobIl9MVXuMqssQKNARtiQLbgcWUHwqjrw
         8+ry2IWHIxILtMOttA8WkBbciTvNzZLVsnFs+VIO2G/IdiV7oW8OH5571lcT++sm0NI1
         hcCF7fOqtWHkZFJ1cCZH87KX4KIAHcvGfKJB4Xkq429j2k4kghl8Kw4QScSi8pW2MLB2
         4KoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhHSiVcra+68Zzu3a4L5gS3WKhCfMZS9rVYLxbQOVf+2ImKyvRf/DwWNe2Bj1API96ZDbHHFR2agpSVYX0FIUzDV73LByrbMUY
X-Gm-Message-State: AOJu0YyQc7pXkTZdvdgloWNbY1smYWxtYSzJagHib6nbUjTBvJySUvN9
	3TYYKAJrG4RAPBpi0eqSCF461QvpaR3EqvCDFUmzkJf/XNIRvBeTkyDb6phF17k=
X-Google-Smtp-Source: AGHT+IEzuhMJAz/Pv97Qfz0wibA0VR4rH3uoXhjLiD7kH/3hRTfrPLFrntMsa8P9YcyF+7GW5WzXcQ==
X-Received: by 2002:a2e:96c6:0:b0:2ec:5644:8f85 with SMTP id 38308e7fff4ca-2ee5e3b37bdmr32247581fa.27.1719819664229;
        Mon, 01 Jul 2024 00:41:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4719:99ea:652b:10d0? ([2a01:e0a:982:cbb0:4719:99ea:652b:10d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf90sm140024045e9.5.2024.07.01.00.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:41:03 -0700 (PDT)
Message-ID: <5da26c0e-75a7-4d5a-9eca-f88ecf369996@linaro.org>
Date: Mon, 1 Jul 2024 09:41:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock
 measure
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
 <52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org>
 <1jzfr9gxh4.fsf@starbuckisacylon.baylibre.com>
 <c092ec67-e384-411d-8885-665597547523@linaro.org>
 <1jv81xgmfc.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <1jv81xgmfc.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2024 15:51, Jerome Brunet wrote:
> On Tue 25 Jun 2024 at 15:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 25/06/2024 11:53, Jerome Brunet wrote:
>>> On Tue 25 Jun 2024 at 11:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> [+cc people from linux-msm]
>>>>
>>>> On 24/06/2024 19:31, Jerome Brunet wrote:
>>>>> Add support for the HW found in most Amlogic SoC dedicated to measure
>>>>> system clocks.
>>>>> This drivers aims to replace the one found in
>>>>> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
>>>>> * Access to the measurements through the IIO API:
>>>>>      Easier re-use of the results in userspace and other drivers
>>>>> * Controllable scale with raw measurements
>>>>> * Higher precision with processed measurements
>>>>> Jerome Brunet (2):
>>>>>      dt-bindings: iio: frequency: add clock measure support
>>>>>      iio: frequency: add amlogic clock measure support
>>>>>     .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
>>>>>     drivers/iio/frequency/Kconfig                 |  15 +
>>>>>     drivers/iio/frequency/Makefile                |   1 +
>>>>>     drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
>>>>>     4 files changed, 868 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
>>>>>     create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c
>>>>>
>>>>
>>>> While I really appreciate the effort, and the code looks cool, the clkmsr is really
>>>> a debug tool, and I'm not sure IIO is the right place for such debug tool ?
>>> The reason why I went through the trouble of doing an IIO port is
>>> because I need that for other purposes than debug. I need to to be able
>>> to check a frequency from another driver. I don't see a reason to invent
>>> another API when IIO provide a perfectly good one.
>>> The HW does measurements. IIO seems like the best place for it.
>>> For the record, I need this for a eARC support.
>>> eARC has a PLL that locks on incoming stream. eARC registers show wether
>>> the PLL is locked or not, but not at which rate. That information is
>>> needed in ASoC. Fortunately the eARC PLL is one of measured clock, which
>>> is a life saver in that case.
>>
>> This is a very interesting use-case, and quite weird nothing is provided
>> on the eARC side.
> 
> Indeed.
> 
>>
>> So yes it's definitely a valid use-case, but:
>> - we should keep the debugfs interface, perhaps move it in the iio driver ?
> 
> I considered this initially but it would add a lot of boiler plate
> code to provide over debugfs exactly what iio already provides over
> sysfs. As you pointed out, the previous driver only provided debug
> information, the debugfs interface it provided is hardly a
> critical/stable one.

I still don't see why it could add so much boilerplate, all the tables and
calculation fonction would be shared, only the debugfs clk_msr_show() and
clk_msr_summary_show() would be kept, all the rest would be common.

I insist, please keep the debugfs interface for debug purposes. You don't
want to mess with IIO when you bring up new platforms with bare minimum
kernels.

> 
>> - we should keep a single compatible, so simply update the current bindings with iio cells
> 
> Using a new compatible allows to split the memory region, making the
> interface between DT and driver a lot easier to implement seemlessly
> between old and new SoCs. Eventually it may allow to implement the duty
> part too.

It's a problem for new platforms, you can introduce the split only for the
new ones, the impact on code won't high enough to justify new bindings.

Neil

> 
>> - for s4 & c3, it's ok to either add a second reg entry in the bindings
> 
> Doing that for s4 and c3 only would still make a mess of offset handling
> the region because duty prepend the region on old SoC. The goal is to
> have an interface that seemlessly support both old and new SoCs.
> 
>>
>> Neil
>>
>>> Everything that was available through the old driver still is, with more
>>> precision and more control.
>>>
>>>>
>>>> There's almost the same interface on qcom SoCs (https://github.com/linux-msm/debugcc) but
>>>> they chose to keep it in userspace until we find an appropriate way to expose
>>>> this from the kernel the right way.
>>>>
>>>> If it enabled us to monitor a frequency input for a product use-case, IIO would be
>>>> the appropriate interface, but AFAIK it's only internal clocks and thus I'm worried
>>>> it's not the best way to expose those clocks.
>>>>
>>>> Neil
>>>
> 


