Return-Path: <linux-iio+bounces-27896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D95D38966
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 23:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E41303178C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930B3148D5;
	Fri, 16 Jan 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9vZc2Fh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D427700D
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603399; cv=none; b=knNLkBgsqksGCdSKzCTHFsiDmuo8KNNI+SFovLrA0BknWpHmZ0FJaZKHma8e43OIS372yuIiH/JYthTBkb3zn/cktZNX4Is8y/O5cBYDRpFqApaecei5Ykg5ZhxKAhb1TLgbRFN9G5jSc6HEilxZBQOy9qArxU9sjgOJ+MDyGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603399; c=relaxed/simple;
	bh=uOdRd7+uMwmMYF4d076SdRnju1u6c6H+tWshE6YoqhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjX/Regc4t4jvQTUcDll7OM70ZVqE25a20IEJWhtZZjsGN5Bth28CNS2hLMgnvRyhZloGkRLuq0+ORvCxYXHkJT8NJyD4VaMAO4YGzwtiyTBLbfy28fHopLCW2ROKlbhjOHiPxrdsix3FQCtG3W6nFlfFZAvNTDbHc152iafEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9vZc2Fh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfd2be567bso1609658a34.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768603395; x=1769208195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2PF8i3QyhCqQGmWWjUESbM/JH/zeGGQE1WnPk6IZFo=;
        b=c9vZc2Fhh6eidNdOD+u+hMhA2f9ka7IIzy8LbDHMIkBRCapPL/gmtNDsv2HEcuBMm/
         4KcCBTkXpjltsH9OlIHqn9tzd9YMT7kYSflHZ9bkNFve1MEy/rGPH0Ygxc19EoDcVVKs
         bh40tkHgWTURCBD0pRahxqV+SFkDCpGyec+yTLdeJ2sXIWx45TPeBUDBK5fIs08KuSnf
         vFaAc+850SpIR7d3GFInOHhYaMs0ovpo1h8YqbYpcsBXpKdO7yAI+dnTu2rSYuqGGQec
         3IvMwRqhe+NzfW/b5ebllklmYgdg1AcypETCvlW87OPYnGo7x3Fohi+chLcyFq+/eplR
         bLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768603395; x=1769208195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2PF8i3QyhCqQGmWWjUESbM/JH/zeGGQE1WnPk6IZFo=;
        b=XaTuS8ugNPdo0z/yndX5YnkOAj6aBt6YWLCXCzPkRZPcFYEbfxjqPwHZy8q7QHFlpw
         ShOzePv7ygnAB5YsA1rau88hkSHZUw4JPd26yS3RPO42uV/1yDxwHcwO0vVmM1w4ZtaS
         lCF+C8D5YhyEEFPjGPiJv/mnHCq88Gw0N/iXtEppzQYYcTjiTidBzW41N/HOq9KbSgIO
         abCMNd942OjZS+45wXczMXMmBxtfm8dNbDLxKwCvJObRFhcgitj0QKiRnAxPLMVF/xoH
         zapqd9A4nD9tvL9FMt3CUuhjodu9Ife4JhnromBdw54DUs3I25mdESciPlunoDxR1qp2
         gOzg==
X-Forwarded-Encrypted: i=1; AJvYcCUvSMmJ70hVlex8lpolyuUw8LjhJEZxptX8G8fz9TxJ2atYkaiCeDQO2bWldICWFsLnbmvqAs3IWnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASHuf0fMQdrUahIzFXIKooHjCt3+joEYKbl5+RFLN7urRtfRd
	vlVeZI5BK6DlaZTP+D9sw41dSAyd91NuHU/Ff4bkkSSFQEtPw4DIy0S5wo3qaXZBEJM=
X-Gm-Gg: AY/fxX4toedhjW6U6Hj3oSmM2lihVd5e1Dzn0EFKCqbXVYfNrKpUSNQIGneLpPJ2yIu
	RdXsUylJYkOqysFb9vLGFG4Fjk8RcJEZLCp2rhfkVDnETJ/TP2a7/dXis9cav3o03d0jYcG5Uph
	XQkvyDD63vuuX3bOr4HNXhh81cI/4mHiUpmA/Qw/1rfuXXrPlmFMOD0gb1jXAtBGzhOJyicdEnD
	STxm2OqaTahbbjYEQY4qjgc+jqtjGK0CsO1GiTbhVH3iQGJq/BKphrDtCjySnKmgRR+53qe45Is
	hCkjJIiCTwpys5Zyc/SohTJ55LjvTXka5JAtB5QSJVghJvmJZ0hNayWB4lmCNOYK7O9hH15Ap4j
	nD9Z8h/BRWW2ObIa4sRfZg838VV/MdKf0cOwG2BH9Ql6oesY7kx76QrvNNuFUKRvpPDMZyKH4N1
	5TNh774ovMyn20NSvi10OHk8+59jsxaMUumWlF0gQ0nJ3P0BkwmhjMMcY4c14c
X-Received: by 2002:a05:6830:6507:b0:7cf:d9bb:639d with SMTP id 46e09a7af769-7cfded1f1cemr2245481a34.1.1768603395110;
        Fri, 16 Jan 2026 14:43:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b57e2sm2440834a34.27.2026.01.16.14.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:43:14 -0800 (PST)
Message-ID: <ce9e2b46-58c9-4346-9e87-d5fbedd13826@baylibre.com>
Date: Fri, 16 Jan 2026 16:43:13 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-7-295f4f09f6ba@baylibre.com>
 <20260114091617.170a9757@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260114091617.170a9757@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 3:16 AM, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 11:45:25 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
>>
>> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
>> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
>> reading from simultaneous sampling ADCs that have a separate SDO line
>> for each analog channel. This allows reading all channels at the same
>> time to increase throughput.
>>
>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
> 
> I kind of hope ADI make their versions backwards compatible (or at
> least try to) so the version check might be a bit over the top.

FWIW, I was the one that actually pushed for the FPGA IP block major
version change. There wasn't a default value for the new bit fields
that worked in every case, so there wasn't a way to make it fully
backwards compatible with older drivers that don't set those bits.

> 
> Anyhow, not my problem and the code is nice and clean.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


