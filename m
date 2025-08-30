Return-Path: <linux-iio+bounces-23481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D55B3CE25
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0E418962CA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511FD2C3251;
	Sat, 30 Aug 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="isE7FOyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D218AAB
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574868; cv=none; b=A8KkMZj/Xa8u+nGQKxC+nbsA7iYXpchZYmMO1yaCYuTobUnM7BC1hBZ1+dTGz0mz12xXM3JSCtQuMpC88kR8Jpwp0L8rwrWjUor+UuUvU6fpQJvuX4SMdT51JxMHRX3LLbnVUvGpVWwin5tOFH06vWt4Wtcph46oapZ3WO2ixbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574868; c=relaxed/simple;
	bh=1/ysBXym+F4ed535scygMvAdX/CCxBkFCgLW9wVuzJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drLbsurdj+QGVa8cVHlcnMg7TnO+Woot1RqUO5GYDdhHpxJAmlv/Y/3a/R0PefVZ57AYwDpTsT5bvRwRFiMzA5rtfoh4J/58Iz2UrwdwKIdoohVyE3Wu3gck1QFohUuKr7DzZl2EXxPhC2h05cjDvOrsaeeEHHQSwPWOO9sdpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=isE7FOyN; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30ccea8f43cso2600775fac.1
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756574865; x=1757179665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTyHRy33PmQnftPGTy/Bo7T/OCDGNcWJjyWm9Y1PPiA=;
        b=isE7FOyNdJq2dhIlADbgCS3ItFbOG8V4AeLpv/Esobi6ifxuuXz8v7mTFUOi8fjWjw
         GfBePZFHw4Y+LF3xHNjm2w8nbB1BvOoYJDbI7yW724YntpnhPi7SEhA1X9kk/EH/IFXO
         jSZDz1m04ydU6cQ8Q2RpVHGmad2NtWMkeXnRIOqbisxJZ4c42RbRCMZrmKE8LMFmXILb
         /zAwBahujtJ8QdlNPySLCwcp6A6fV4C9rYNunb7SRaTMJSmDoIg5UV9nTPkdSgPwoNyd
         /dhAa9ee+XyWydgXJpzjSr6pdH6d+fPeaji1e1uQbIsdtgsMN8mkyDLt+H8WojD9FtIf
         Sxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756574865; x=1757179665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTyHRy33PmQnftPGTy/Bo7T/OCDGNcWJjyWm9Y1PPiA=;
        b=oPIye0HRCAqcAoFxzjqHuOLOFgk9M3XFwfcHHcuq1Hhb+dAUOHqyB4eX9xZ9XcrQlW
         lodQQNYzLajCdR+q1I1Wui0t2oaYyf8kWoqbg/aHiAYlvevAlu95uCAMWr7N6uwkSVoC
         uVTOGQFB5ShaKl7ekyoXwknD6VhL6J1fPtF1jNcBNkiiQjzfllwCtoDFn6LWuAJ6XGyG
         bT5NbpKT5aAJW9zxW5KWaz+iKX1bppFwKtSzyGIHbxZRPDO/pcJ45Uyz4T5PyUPN3dQ9
         Z6G5pmjbLleCCfT87AQ3jl6PE1heOlIkYdmqEZiBeDxxQDDa0e9mn5kHJMGXnh/H8WFF
         I/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUW5fGBThVEFdB1ldg8sgkCZY3N/TMZD7wTmUQRoP73/3yEVFSkK/mh+x6JVa4+FeWDJfO6ItyGkq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLVYhXSb14FVdtf2iNkcTQXzrCTEU3OUki37Dsrf5OC+HhrrL
	x8Y4+nocBROMUWCe5MBcIw8R2C2y401s7cgSQFBZ2qlatFPCnkickqXPw/fuD8hYwKM=
X-Gm-Gg: ASbGncurgb/9/kTmBouQkEZk0c6+H+/EAQvaAV76YVpDTl9j0A9C7ZJxwwf8xTftGV/
	1JlHjHn0vrjkJ3puyofMT+tiF+sX80CqlPaSl4D1TV0zwij62Z+1noEffuUpzeeHsYlxZ3gKWnl
	29x06hYykVZghojMV6/Vx09DWEEzWBs4ciwRi4P3zs4dF+heZu98fIlMRsFqiAFRpvC0FOqMrPF
	UaayJkQmrjF4zfPoRP1pi8T94bMYO/1B+shAsqfze/0Jc0tDsBB96HhmwdDyGnXdfRWYFZbKxiU
	eHa1bvJALDaMe8IvNH06efpVaWgnxETzVXJU5jPf3OOHaSzi+qQYGh3M63nR0R6QKZLLyrUsmF/
	NEAzIR2osG1Ze1ChEySGRcopiw8pLWpScxw27cXINmNcB9EPSchpPL+k3mKW5NlPZUfOqnTwzPl
	0=
X-Google-Smtp-Source: AGHT+IFru+arWS/AceeMu4bhAm1TOj/b+D2hCYkTnV2EgYzzfyEcSXDo/b8XHFyG33V9MkQqa25uBQ==
X-Received: by 2002:a05:6871:8a7:b0:315:3453:5a1a with SMTP id 586e51a60fabf-31963386930mr1249422fac.14.1756574865348;
        Sat, 30 Aug 2025 10:27:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d24601csm373137fac.2.2025.08.30.10.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 10:27:43 -0700 (PDT)
Message-ID: <5d03a10f-5281-49a7-b578-b45d7b69209c@baylibre.com>
Date: Sat, 30 Aug 2025 12:27:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] dt-bindings: iio: adc: adi,ad4030: Add
 adi,dual-data-rate
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <e65b8b6b14c8083a48915a7bc40b7521fc246860.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e65b8b6b14c8083a48915a7bc40b7521fc246860.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:44 PM, Marcelo Schmitt wrote:
> On echo and host clock modes, AD4030 and similar devices can do two data
> bit transitions per clock cycle per active lane. Document how to specify
> dual data rate (DDR) feature for AD4030 series devices in device tree.
> 
I don't think this needs to be in the devicetree. Dual data rate doesn't
depend on wiring, it only depends on if the SPI controller supports it
or not. The core SPI code in Linux already has dtr_caps for SPI controllers
to indicate that they have DDR support. So an ADC driver can just check
this flag to see if the controller supports it. No devicetree flags required.


