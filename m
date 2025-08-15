Return-Path: <linux-iio+bounces-22747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5120B27863
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 07:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C04162DFD
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 05:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4428724C;
	Fri, 15 Aug 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdBtJLVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492A38FB9;
	Fri, 15 Aug 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235403; cv=none; b=JQ5l8yOZLGIBci6mpjg282S3OmYgDR9MpkBalJMLCeopa0Zyc8Q/51uHtJSrliYeorkyUsSwEIk4SZpBf0xcEuESNwJHkBI8SopQ40s+fo3FpLFBwq1DLRigZmWahVWyg+JECjeNzb2GsL25uHKMYStQvXNEOL2UsVhQP8zJM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235403; c=relaxed/simple;
	bh=MTFecpPPCPbUkZL8jf5i93249tFE3tGa3UD3woMkHI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fX6kjvPpteS9wxhtk3bPmQI7WnIe70toniuPiP7wXeT05IbOfDbesliRbxIpSpAdrVI3a8PDQ3qcVdgruEzhu4i9O/3pn9/BIME26RwsyShiKuiG2gQ9ExTJSw8V7FYkJHpTdOHFgUxqyEPU1wmfy3bTa3zsEPI2ti7AD4ecfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdBtJLVI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f92a69d4so12849061fa.2;
        Thu, 14 Aug 2025 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235399; x=1755840199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Vj1KPFsbq/RlaOOlkDBH66m6Sda7aTjtiK8NBu/QXw=;
        b=hdBtJLVIojxn4KRnxp0+0ZPMeoTywDv2e2QjQ7CRgbEFgU4BRgRiGEMSYPLIPhG6t/
         TiuLsGBmhl+tzyXZEHh9yofvXrDUOBtI3NWg/0odV6R8mErZMXwol/taFCcnE/9YHscN
         RQ8zB3hgmRu7VEG+afmzzBABUra5kdqu1tOG0dyncOy5jcsFYmejKx8b0jvq5ey5LeJn
         mRSCxsKp1ltqK3Wk44gBJcoLI9ICOJm03TBqCF5/WXfGNY/lQrOddv2ZacvTDvlC/3M2
         uE851IbA+K45d3LIHt0TdxpwCtTdu+10gQgEUNJ+XI+4M+Ei3kLkqIlXP2u5UPAC7AJN
         m1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235399; x=1755840199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vj1KPFsbq/RlaOOlkDBH66m6Sda7aTjtiK8NBu/QXw=;
        b=GUVm2TMohh7JH7NSYmOTKV11KPEUsrfZKYgkcz+40KNbukmy6xku2nwZB3lVbU9/To
         pp5cuiSJMCiFvo5t3VJM+OaTJLk34a2I4O9lpVoLsve9ak+cwMdVV0KJQsKezn6Hy9nc
         Vxg5AdvQYVLESwgPhRW5H9tyG8I4WmA6Ek0swYBQSp0iOY4L4F4BorYqa1O5c9oQCK1F
         f64NXeA0u2Vt2fSYqY+g+cXlQB28PK4PVOxG1fB7N8tsrVQ/1a4Aqr/4tvLnMf377BB/
         aB+eIEges5MloipSRyVsMhrDyIyhLffyFaBrqUnKl0IiZMTtybP1t1gcQrzRTgNiTrvH
         OJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXFd54HPL/WUFsJBstraI2aH6w4zzVa+oe9X+ft7+Wt7JA/uUIS1fxzbHqmKtRuPr2mSbxL3sHYWi+@vger.kernel.org, AJvYcCVcx57/OatmDWNaVC7tSJNdmMseiMaHXLK9PfaGTMW1zkXQFgKppxPfs5qhJlbtf6BFtC8EcVuKVL4cFqia@vger.kernel.org, AJvYcCXi6XFpPP56M87yoxLv8A1Zmwlp562DA2fy3EtgleZg4blTk62iomBnVmqM6sclXpZ+HNqkd6ZzBp9B@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2v6CoiERk6Nid4TQ2dxSfEECnGvN/epfVpR7u6gkpinH+VN6
	79Eshbz1CwQfVjnYaRPF0aHCb1m/GxChNI1Acn62c2jnn9hz/xRo/WWW
X-Gm-Gg: ASbGnctTi+VNABt07LorZlKbJiUcr9g2JNxA/aozk1F5+FdJnARky8UxtaS6/mlvWfr
	IuVGraYgO+SrvZhAc8Y4OvHA0IfCopcWCfwxClEVh8FnlioedCYa2+BC0AqbnOrXChr2AfbzLRu
	bHECTCQS+zCuDV4t4K0/vB8+6pRd6INmy3v7zlvtQ1amKTaFOdN5dXdy+KJiXtjJ2QWL8bUN3DP
	z58k0uHDREOdkHZ33J0EdkwueVBmau7HqM3oDcXOWiOp8mVs9MVgtNcoZO0o7G/MnnVlXXAqBjv
	Sx1f5V8miDcHaEwMAvvbiW0Nmh4V66B8cpM2yXHgr51UDY8xO+BMQEKn9qjyjIA1+/iK/ywmVEJ
	5mVW55H2X2GuKVm2znAdAeEmUOnXWgZRBhodSem8Bcz6+qtC+7VswO9cuA4beKhp2vc1XhnpB4N
	cCxW8=
X-Google-Smtp-Source: AGHT+IH9+pyxeVQJuWJ7xU8GiuE3ts6G80OQ7UFSgxSDjeJeDwup2vWcuq9x3CeqT9yzy8Qmtkn1Mw==
X-Received: by 2002:a05:651c:4112:20b0:331:eb47:69fc with SMTP id 38308e7fff4ca-3340997aa36mr1417371fa.29.1755235399127;
        Thu, 14 Aug 2025 22:23:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a43b7b2sm1353031fa.22.2025.08.14.22.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 22:23:17 -0700 (PDT)
Message-ID: <3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
Date: Fri, 15 Aug 2025 08:23:16 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
 <014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2025 18:01, David Lechner wrote:
> On 8/14/25 3:35 AM, Matti Vaittinen wrote:
>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
>> and, based on the data sheets, they seem identical from the software
>> point-of-view.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
> 
> One small suggestion. With that:
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
>> ---
>>   drivers/iio/adc/ti-adc128s052.c | 36 +++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index 81153253529e..2f2ed438cf4e 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -122,6 +122,10 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>>   	ADC128_VOLTAGE_CHANNEL(3),
>>   };
>>   
>> +static const struct iio_chan_spec bd79100_channels[] = {
> 
> Even though the driver doesn't support it yet, there is a
> adc121s021 [1] so would be nice to use that instead of bd79100
> to keep the naming consistent.

I have to disagree on this one. For people who don't use the TI ADCs, 
the TI numbering does not bring any clarity. Furthermore, I don't like 
preparing for the support added somewhere in the future - because future 
is uncertain. It could be this TI's variant never gets added here. If 
this series gets merged now, then there is only one IC using this 
channel spec - the bd79100. Naming it after unsupported TI's IC would be 
plain confusing.

In my opinion, structs should get either named based on the IC model 
which is using them first - or based on the functionality. And actually, 
when the design of the IC is not too obscure, I would prefer naming 
based on the functionality, which should help others to re-use the 
driver. Hence, I wouldn't object someone re-naming all these channel 
structs based on functionality though - for example something like:

static const struct iio_chan_spec simple_adc_channels1 {}
static const struct iio_chan_spec simple_adc_channels2 {}
static const struct iio_chan_spec simple_adc_channels4 {}
static const struct iio_chan_spec simple_adc_channels8 {}

This which should be clear(ish) for developer no matter which of the 
supported IC(s) were used. But if we stick with the IC based naming, 
then we should use naming by supported IC.

> 
> [1]: https://www.ti.com/product/ADC121C021
> 
>> +	ADC128_VOLTAGE_CHANNEL(0),
>> +};
>> +

Yours,
	-- Matti


