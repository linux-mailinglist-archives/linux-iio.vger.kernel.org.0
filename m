Return-Path: <linux-iio+bounces-11139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D99AEA0A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CC4B2222A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54561EBFF8;
	Thu, 24 Oct 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ueD47rt8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891A1D5176
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782811; cv=none; b=bi0ooL+2CpxE4YS3d20tlHIIA1IdFoKtlzkQGPK2jJNGjM5UjWxjhdp7+BUGYe6XjPDPmTge96SHgYIONliwZv9bJbtdJ/GXLpmkjWlBNrgdKzVMYLJ4UEiwFj5mb7f96CFTV2/NcSyOc72Gqk7lDLWapgQzRilByi+q6WYU++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782811; c=relaxed/simple;
	bh=8OXMHfKwXNFd7LmH/a4GndUZUNcRvsUGK8/koqLYQo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIeHZZRLVf+6PCVzZ8P/OByOUjd/dH6y2cVafq2rh6vOmm4C9nIp4u3gfE9SygS2eHGAzgm04rHCGo4Tp7poRnqFk4QKd2ZQJABpBt9XYeRv4804+xB+xHW6wVza5HbHldwVY54CF6655H9F81Em/Z9uO2elLfXc4uh7UsVYmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ueD47rt8; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-28847f4207dso476544fac.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729782808; x=1730387608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd0iDovBJ0d/hwyt9t5TzW4nj1RKDhGA9pl/sSbDpIc=;
        b=ueD47rt8B/4+gxN6LBiwcWmIZW7wWuCfC4TxB05lwWIxEG1nneqalZPaOOUzRa6Va/
         Zunp9gxyiEJMIOXEtqsIXriyzH0cUrpr0gksUEyeCMhdTGXdyFokx2oR/wY2qNNdFLKG
         FjcAhlPB59boWF+9s0Fd2Q5oNNcisHGNfyVilKKSyYhXtJux5csCk2fM/yYySpxlo2m8
         +sjOrvAqSonmc6LkQNKOtPG2am1y+BOcg+zVTzEGTh8O2UV0MeKIqrn63LDORh0ltsEd
         awMJwnibc2rkDaVtptV7JeBNI3rOkFd0aJCGiIgNa3aR2ZPo8xc8aEwgJukCk4zA+kiJ
         rmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782808; x=1730387608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd0iDovBJ0d/hwyt9t5TzW4nj1RKDhGA9pl/sSbDpIc=;
        b=Xkm3UbeWytBK89DBnec6pj5BxsOQq9YjtMoG5Rlvzj4YljYpLBPST3TWwlJiKEwByL
         DcHY5WjCA7u0n7zXWmZN1rtgHdUq3K09/8BZSEEJc4xlKdzm+NjYpu1w4DGVPTLrnc3t
         VPtb+ObZoiCHFAWdUUK2ic1V7TR/ixGczjWR4wj82iHArtfHGZ7jOIXy1AIYSpwAxZca
         R7z7/yP7Uh3AipYObNvxKZdshdQK/bxMD6PnEKplWc7ioPZxwLbubvK6PKD/lBWkjP2N
         bYZKONWZ/fD+FzBuukhy/I61nUyFrL5IjhRVVvdnlAf5VLuhFJ+g4pQ/zw1Wz+ux2T+P
         Y7IA==
X-Forwarded-Encrypted: i=1; AJvYcCXq8DTqmbQGAVZvQvCOoIXTNLhSY00q9nf11S3bZ/p4m7oNGINKgMp32nUlxFBeBkl6g4hDDHRey3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLbcOQ+YgEsOueqsAy/FGbgtFzdcDknc+o5St856jXgDwXFx2
	09uOjiQrhVXxfpctzEcgUCtLGxSJnFsL+pwhEqSpVPyaf4Ks0cIvzOwfYG3p2MA=
X-Google-Smtp-Source: AGHT+IHUs1ILvEchERhevtw0FSAS8U+VdD9+RUaorNqTllSmxFejVAbBw/+53oLTFljWYCql6cMVEw==
X-Received: by 2002:a05:6870:1cf:b0:277:d360:8971 with SMTP id 586e51a60fabf-28ccb6a104amr6491523fac.43.1729782808158;
        Thu, 24 Oct 2024 08:13:28 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb3df52sm2157342a34.18.2024.10.24.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:13:26 -0700 (PDT)
Message-ID: <f70854c2-8006-4278-b149-6d8c3e76b30d@baylibre.com>
Date: Thu, 24 Oct 2024 10:13:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
To: Angelo Dureghello <adureghello@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
 <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
 <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
 <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
 <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/24 10:02 AM, Angelo Dureghello wrote:
> Hi Nuno,
> 
> On 24.10.2024 15:05, Nuno Sá wrote:
>> On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote:
>>> Hi Nuno,
>>>
>>> On 22.10.2024 14:28, Nuno Sá wrote:
>>>> On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
>>>>> Add High Speed ad3552r platform driver.

...

>>>>> +	switch (mask) {
>>>>> +	case IIO_CHAN_INFO_RAW:
>>>>> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>>>>> +			return st->data->bus_reg_write(st->back,
>>>>> +				    AD3552R_REG_ADDR_CH_DAC_16B(chan-
>>>>>> channel),
>>>>> +				    val, 2);
>>>>> +		}
>>>>
>>>> Maybe we'll get the new stuff in time for this :)
>>>>
> This is not clear, sorry.
> 

Probably this :-)

https://lore.kernel.org/all/20241023105757.GA9767@noisy.programming.kicks-ass.net/

But it hasn't reached the stable tree yet.

