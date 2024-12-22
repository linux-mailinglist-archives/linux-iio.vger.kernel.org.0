Return-Path: <linux-iio+bounces-13744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC19FA4F7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3036162468
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F938188012;
	Sun, 22 Dec 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAv7e+gE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657481FDA;
	Sun, 22 Dec 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734859300; cv=none; b=Vtg6nE0q4UVa7OJYX2r3eXSnfSuxb/29ulTmjvcPGUlleWdaDnL/s4zuGvfXwuTl3TVsaFUorceBThfnb+zTPIo7lxfq2oJSLEqHYMqXwvbVOBvLfm4Fd2SuL6o7hD84VxIIwbv12/3/IFp/eeVd+fH/6qFSjalJ8DyHrndxIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734859300; c=relaxed/simple;
	bh=8IXFx9f5djAXv4ynupgH9Mp3zi4p+TUzMsb3qsXMvVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mbj7wT1v+Bi907zILLWPPNXt5slT2yHSAnaC3P4G6oQXTROsRF3/LCisD3oog+GixRDrmTzmf3oklp/nJPfBz1mTXxgoLL51YtuO81FVIw2RD0kHg6BlaaM7KGQp4ypSvVOPG3Kny7sIpOqVSx11DSJTTENPvR2JwTLxjyK315o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAv7e+gE; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54024aa9febso3547783e87.1;
        Sun, 22 Dec 2024 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734859297; x=1735464097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+qEF9u2m18UKl8A9ltKKw93eJLC0ydO++cOyp1aAY8=;
        b=XAv7e+gE8OlWmRgp8Mlsh00TrQLMOJpmM0hz/5I7ZZf2Hbn/M8Ug9X3EWGPEphyJWN
         VhbAR5bbRnXjXuvbMM632S985hcEVbtGsqSxtF1Eko6pxSUhBTktavHKaJHAFfxg1rq+
         wCRk8XCqBVCkjQnmwmXI0Dfrsbyn9MLtLKTq105O7n9nw+4pIxtY+4gB6bK0/TD6n571
         9lW3rwk0sfSqsIFs/MnKLVPkGG4sRIp+p1vMarzpre+xWM2nG6fzDEWG51eBgkHBCw2D
         8lrM4fW6eLalsbyVNkvY+HNexVCM6ROAIk/tj0UgBjEgSIa5tBQIZOfYqR0f7rTu0d6T
         Wmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734859297; x=1735464097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+qEF9u2m18UKl8A9ltKKw93eJLC0ydO++cOyp1aAY8=;
        b=rMK3sCUrti6vaX4MS2rmG5Hm/Expfwu9ejBYz7etghqA0LiwMh1Y2loFVfCsI0Zd/8
         E4ZZsRT9CKtt0vB+hJopt5VniOnrNU9xL1rf7M1DuCw2TzP30LC12S/g8epKJwDw80mk
         23Ls8EFMIuHobrE6tI//z0MQULhBIng8/LpbevEw0aT8O3CNorhd/hTSnzaqV/QzCy9y
         EqBzb6RhXEtPPpFK1EVzsMpmoZvpezKQLHKdRXWIabQq+NVgpWTrTxeq8RkHmqSat8wP
         yGfzJNGzPHH3ofPRv2G1ma9YfA0pIgMZ37FyoNgeeeLGYN7zOjylXbuy03fFZkRvoDkJ
         /0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUidRjINl94gbD8Eg1JK9JnlKvaEOvDiVcOBvyK4RwKz8WRYri8Pf3bpYvG9WHUF9o1qehsFWQlazYS@vger.kernel.org, AJvYcCV+BwtPFLjV5utPY6tXYbUeR6XFuFhE5TBwiFIx/ExFdKHs+azicv8iQxT3CXx/pnbeb1QvaakxQZTF@vger.kernel.org, AJvYcCWkyVGKCUqA8XuC9N7raHnHt/m02XjAO54DNXE97GNsyC+ZEZBN4pUlifq6kBqjmPN34vE+3hDoePR76wOp@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ55lPG8JnYfaRbwxGOjEDbowl0fsj0ZOpq/Ydvan4h2q7TRDW
	8ddEk1Ar4yKVFXHcv0MvpLzMyopMWPQQPVGR8mRm3vLAP/RDZFhSQ0aA+Q==
X-Gm-Gg: ASbGnctrQFekSTdUy3q7OfD8r2KewjcqShBH0Nckhklh6mH1IZGFifZKhjdnxQEN+pt
	gMPBvpmU56sawTy5p8THq4FLqJ0yJ+HAwKjMvUny4q2j6u5FlYKYlq+V4zXHyrGg/ioUT0L2X4k
	Y+JB39qks/FQ6kvWa166zWZgdkTmE0DU/oFYqY9hICGqHFBA8MKvbe4ne8WZtRhtKEu0raUxR5U
	AZsYMi+wvT9KuP8pGau/wvIgbZC5khkN4nTAJssN4wOLwDgC97tjGTplNnRZ1Yulnn12BL137f7
	20tQ7sy7Us3A9CgeUZmIZGzozLdFiZd6DoY=
X-Google-Smtp-Source: AGHT+IHEDnAy6zU/prQQIcIWHgx440v6Aa0a3t12fOSjF2JdsclV2jVeXWTNFNnyI7/jXdrAuYZheA==
X-Received: by 2002:a05:6512:3b0b:b0:542:2930:4376 with SMTP id 2adb3069b0e04-54229533e06mr2719775e87.20.1734859297219;
        Sun, 22 Dec 2024 01:21:37 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6073sm933699e87.27.2024.12.22.01.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:21:35 -0800 (PST)
Message-ID: <eadba2ef-9e2f-45e0-8eee-9a066faa012c@gmail.com>
Date: Sun, 22 Dec 2024 11:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Support ROHM BD79703 DAC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1734608215.git.mazziesaccount@gmail.com>
 <20241220191245.2f96a115@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241220191245.2f96a115@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 21:12, Jonathan Cameron wrote:
> On Thu, 19 Dec 2024 13:38:54 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Add support for the ROHM BD79703 DAC
>>
>> The ROHM BD79703 DAC is a 6-channel 8-bit digital to analog converter
>> which can be controlled over SPI bus. This series adds support for
>> controlling the analog channels via IIO direct mode.
> Tweaked the two trivial comments from Conor and I and applied.
> 
> Pushed out as testing for all the normal reasons plus that this was only
> on the list for a day so there may be more reviews! :)
> 
> What can I say, it's near Christmas and I was feeling impatient!

Whoah!

I think I received your comments maybe around an hour after sending the 
series. And just couple of days later the series got merged to your 
tree. I'd say this is a new record for drivers I've written! It must be 
the holiday spirits XD

Quite effective! Thanks! ;)

Yours,
	-- Matti


