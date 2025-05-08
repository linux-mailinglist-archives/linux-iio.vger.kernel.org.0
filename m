Return-Path: <linux-iio+bounces-19314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B960CAB0088
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D44E4E4256
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDD28314E;
	Thu,  8 May 2025 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fKvAWwIO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF9283151
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722128; cv=none; b=aRVPB+/ji5OkGj9lymtpV19gkuY104IyU24SSyMdT9c3iSg2KGFPblm8VyDCuaj/VR95y65KR5Ztx/2X4o+poJbHz+mRFzbkl27zRBi2MlSe87rosEDzoRg6l6Tcw0KAAOUZ35vLcHFsTVhM5eUuzqgcTxpvLkPuYYMfgpFJAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722128; c=relaxed/simple;
	bh=98vXnldu3BmiisoGoWmdX4HwE8ZPCtGTXfUCtn6cp48=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hMPUoG9Ph9MYZnep7z+Z2tWnLblSSz+F7g9jsOqFFrWSjB2wY6qRUeHk8Lo+pWArl0YxwcBOyBNHfthembn0gFJnxSKUUWLtWfjx+VWfpFCdc9GaLRAv8lnrQ9Kf/iQ7b4RDS+g/4B5JT/l5eLnPJXQxO0CXCdLGtGOxeU6+EMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fKvAWwIO; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d54b936ad9so600536fac.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746722125; x=1747326925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EJL2JF8HNdUlPHdXe0fsgW/lJ8QcVwXtjShT1s+tRu0=;
        b=fKvAWwIOZZXRVUYNSStzOi3BJw7A8E4OtUrMjA1D2/a6J+AvWACIt6t3gjQ+IxoPzA
         D82zXoyT6RpMz6hdqiA6YYMep2sbswh6ZfzVpGK6ZFBs4jdd1DCKEplDP0JhUevPdhEK
         nRVRlG10kCbnIZDAOjCYUynrO0D6RqbmOoiHXyVcApWzv+zUtzP15kC5zQOiFG9/ng/Z
         IMtmr18jvmI8WyuT3J+BYeDcn95ZIt11vKPoikVOrujIz3w4+BJDsNDRTO6E2+Ho39jg
         /1adCX+Z6CAklpNdGowy0crFodCpBtTh4FWz5AjgMuo7/NaDMnf4DXc3zlKc0Tnjerqf
         0Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722125; x=1747326925;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJL2JF8HNdUlPHdXe0fsgW/lJ8QcVwXtjShT1s+tRu0=;
        b=VHt/ma6m0pT2vi4JdVw10hKldsw2RboEn+V/myLdyVvkAgkyzfBlqGiRAFHr6HMQzr
         sffvCdgruDaiF8JmiAVp/BK6R1w5/AAkuq/Vj1rvltGEi7sBWWL+OcJFF/mByIboKbuB
         7uWjlwH3vSFT8QYq52B3oNOm7htwHn7TFyiyGH9xCABghLTJBWtiBtffOJoWH1MGPPX9
         3nAg9fal2HvZZUoWXFnkYuLNdJMggFd7MN6Ygh9lc4+pOLjUDjn7J1xqP7jsE0XqS5zd
         k1FeA80YC8uOCAu4QLNzg+Ltb47ufBsJoGzwdJGc7MeIvxnYhpwfU7m6IVE15YS4yAd7
         JDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWvGDP8A2Sx0hXjuAKtdG5PVG6BSxvNPjjPJ5ExA8PXgkouJcdWXXMvBktINToFWvjmTehjYskFlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnZxSUTZHscFTTBKDPqLkwgYFP6N6GDr/MpyFEsRTZ5aY5ioX
	wYIkcoYsdZEqzVgmZ/SBqYUI4qE11q1YiwY5Xf6Opz43GjVyoD+6YSgwTvd+8kjaJXCeYeIPQ2q
	4
X-Gm-Gg: ASbGncvQQxQ9/IZiB08FQJZsoa9LuF6etZtD67q6n/vgSaT4ZZlURnteXUHNZfUkq7o
	DW09k8zuL5GUJ4LPdTnKj8OnC9mmGQwirGnnEbmg9Vb9r9Pas9dhRtBy36a0yLpb/tfgKBQU+Db
	KUQtSPYMWh1fgci6/muGaHSD2Ch6TnumGr/UJHH+SW2PL1B+1l9CCkTKqp1IlH4646ZfPTeqpSX
	N9lzf0c13fKpA9+JdGWP/cXQOAdvIpnUp3Y9hlmLsk4QBM9btsDyyjLExqAFFPS+MVZfXZO+pfs
	s1bwSzB/S3/Jtw8F0J0eOqGHtmbqQ8IDNVTEH6FM2XA7SSFuIhvZ4f9tI35ZpYck6i3KJJiaNMt
	LvbmdgR7shtVZ6A5wTA==
X-Google-Smtp-Source: AGHT+IHIJ0BuysYAybBvMTuPTyGsG2tzFb1OdQsBPE+ejZhEIUsRr/4qjoRxA88gOpIuEzDtbtwoxA==
X-Received: by 2002:a05:6871:648:b0:2c1:ae41:6b5e with SMTP id 586e51a60fabf-2dba42aff39mr110953fac.16.1746722125260;
        Thu, 08 May 2025 09:35:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba07912fbsm129204fac.25.2025.05.08.09.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:35:23 -0700 (PDT)
Message-ID: <d2cdf491-d6d2-49d6-8ab1-34118023f279@baylibre.com>
Date: Thu, 8 May 2025 11:35:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
From: David Lechner <dlechner@baylibre.com>
To: Angelo Dureghello <adureghello@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
 <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
 <c999800bb5f6c1f2687ff9b257079dcf719dd084.camel@gmail.com>
 <qaiqdak4pieewavl2ff4mpr2ywhw2bvnoob55buiinkisacar5@q6jhlb5klcf6>
 <7f5f75c1-7750-4966-9362-2a46c5e5ba3e@baylibre.com>
 <720e300f-f6e0-4c47-8e72-b3ab0a50fbed@baylibre.com>
Content-Language: en-US
In-Reply-To: <720e300f-f6e0-4c47-8e72-b3ab0a50fbed@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/25 11:27 AM, David Lechner wrote:
> On 5/8/25 8:50 AM, David Lechner wrote:
>> On 5/8/25 4:16 AM, Angelo Dureghello wrote:
>>> Hi all,
>>> On 07.05.2025 07:14, Nuno Sá wrote:
>>>> On Tue, 2025-05-06 at 23:03 +0200, Angelo Dureghello wrote:
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
> 
> ...
> 
>>>>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +
>>>>> +		/* channel number (here) is from 1 to num_channels */
>>>>> +		if (reg < 1 || reg > num_channels) {
>>>>> +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
>>>>> +			continue;
>>>>> +		}
>>>>> +
>>>>
>>>> Sorry Angelo, just realized this now. Any reason for not treating the above as a real
>>>> invalid argument? It's minor and not a big deal but odd enough...
>>>>
> Ah, I see what you fixed now in v4. All is OK.
> 


Oops, trimmed too much, that was in reply to my own comment not Nuno's.

>> Why is this not correct? Each input could have an amplifier with different
>> series resistor value so this seems correct to me.

