Return-Path: <linux-iio+bounces-19309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014CAAFF2F
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8A3AB59F
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F427815E;
	Thu,  8 May 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xtI/eprv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D42750FB
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717978; cv=none; b=dzxudx1NDNXSwSjRITgIoAKOmPF3Vdz91QmU63A33jlBQklpUGU2VQeg2ejLwO3wLuhRo0QoNZn3TEl67WOMroBhBbE6pLybPGqi2VJoq3KgzMOwDBHTLq7yT9/IS6MMnKiVOfyhcsQb2s4sCA0Ih0KWENNslYJbBKHcJ7OoFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717978; c=relaxed/simple;
	bh=tURl+tqmW8IFifp8JcV+tFaZyMpc3PdC/Qhg5W9UnpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6bBi0tXpgQL6HNmYHeYMsd7wbkJAS43AHmMzzvsszw/zseibT2yRKmK18pXMh7OzPXar4It379WZ5+ORjkmPJuQXzwDo5LtPQ7jGz7tiZ3BCeZPOc9Y1QkMRPNMSMTkgK/WS7GixkKbP72YcqabAfydrToZh7622892HfbMa9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xtI/eprv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c2ada8264aso1015586fac.2
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746717975; x=1747322775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVI2JCzK/Honr6c714s7LjAw1g2LwnFaGSDmVmMruzc=;
        b=xtI/eprvFwlQwXQCpfpyDAtyNs+gVhs3/Si95YWSVEOB3cUZQqUeN9YJBE86ZeNGJ5
         +yuab4QYmwASvY9MAeQsNnSzc3rKYPbzX2oRLjAJHAHRQ5cikUUKG+H2dJ+/niST1rq6
         i8Dd1J/N1Thf9OdGP+cfjTNf/rza1VzbZYWIjN7U1y6SSbDalS+UQwNEjwijjQzlJGbw
         ZGJMQMiJ8hlV8Z7A3ytQyXkKPcY4BGkgZh9iO6DC/gbHSzVlbklQcFiyLBODZvzsCAba
         dV8DfMpo8FKDaCuYLFHYUmU557SSDRjyfNrrqCnhukOBkSHMOe9gB08bwuTDNtOriy4g
         mb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746717975; x=1747322775;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVI2JCzK/Honr6c714s7LjAw1g2LwnFaGSDmVmMruzc=;
        b=cSqJTjRXL8No1knXWkBxs/j0AmgWNr3mQ+g0bWr+UJP0rcyKENdlwCm7JctnYHq1aO
         6Gm+R8m4+cEob4Ii8cLA2++jO5goD/xkyqOgybjBWo/A6L+mnd87xFuT6G9orn+LYFMM
         ybnmyqo5bCq2lDXikEf/4am2QhQ484SJklzjLPdsYIwZ8IhHOENQ7viKNaVgvHXjsFOg
         jnLgHIq2ccqPfnaqSHkpcKkgmiPOL9tEkdxuNtHAasqWHWLPDUHoGO3wNBwzIvEwrRXZ
         EnxhQr/jDkb0DaEOSwr109DlO/kMHyrjqYccWljWRJ1ruFfCV2tQs+8Ac5Urzaiugj9i
         5FIg==
X-Forwarded-Encrypted: i=1; AJvYcCVmd9RKvdJDiTc89zASIhySuUDzUB+BGMNeMDox2FOTD7ffuPcsQY7F4ehnbH2Q7G7E99ustSEA6Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSUJqpOC1ZJekr8BO8moG+9WiL6gFNJASoE/eMUsl1whrodUu
	ew7Ykgu0tkf4ViGgllk6Im+BdijQbhObwzO6JRgxWA0g1pJoiOY7U5EO6vdvEfQ=
X-Gm-Gg: ASbGnctXQ9D9KypPqMxjaIk8LnhtTwH3i//d4B8pKHgtMeymoCkElsu5BRAWeNXxoYc
	xJr44j5uYYhiDEYGSXdSubtH3EFdotD5ni77LLZxpJ5dimsxqx3dfp10tvTJc5xPN9Nc2NDiz/G
	+s0Qz9f+D41zhBGqi0+fVNnOJ8FXWpHzImRTMKuZzIK9/lWZLUsKa7RRYFv9a9lynRtlcoMai5j
	K4DawtI1qWASI48FN7/LgN0hGfwCtQXDUNREqTx4eRHnt4yybJE5q3AvPcP/H1EeHPwqwxmHkng
	IlxOxZI+iTnJ/H2Vvl4N5DZFARZaxAVrjXk2IjqEtF32I3mbDQzCHVg+8BDdU/623/wTe4Xqx17
	E/mdQUR+SP7DddhDQdg==
X-Google-Smtp-Source: AGHT+IGj0MmV5mLbPBP0RWrxkG7fe3E5MPXh+/Rsosqd2Ao091UEuoKROB29QW8ZCVx98W2znSajqw==
X-Received: by 2002:a05:6870:ec92:b0:2b8:e4b9:47a3 with SMTP id 586e51a60fabf-2db814c6076mr2410897fac.22.1746717974798;
        Thu, 08 May 2025 08:26:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba077a498sm79086fac.23.2025.05.08.08.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:26:14 -0700 (PDT)
Message-ID: <a0b305dd-8eb5-412c-b9c8-d2b274707f66@baylibre.com>
Date: Thu, 8 May 2025 10:26:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] iio: magnetometer: Add QMC5883L driver support
To: Brajesh Patil <brajeshpatil11@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
References: <20250508120822.114060-1-brajeshpatil11@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508120822.114060-1-brajeshpatil11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/25 7:08 AM, Brajesh Patil wrote:
> This series introduces support for the QST QMC5883L 3-axis magnetometer,
> a magnetic sensor with I2C interface.
> 
> The implementation follows standard IIO conventions and includes:
> 
> Patch 1/5: dt-bindings: vendor-prefixes
> - Adds 'qst' prefix for QST Corporation
> 
> Patch 2/5: dt-bindings: iio: magnetometer - Adds QMC5883L bindings
> - Adds compatible string and required properties
> - Includes example device tree node
> 
> Patch 3/5: iio: magnetometer - Base driver implementation
> - Basic register access via regmap
> - X/Y/Z axis and temperature readings
> - Triggered buffer support
> - Initialization and core functionality
> 
> Patch 4/5: Extended sysfs attributes and configuration
> - ODR (10-200Hz) and FSR (±2G/±8G) control
> - Mode selection (standby/continuous)
> - Oversampling ratio configuration (512-64)
> - Status monitoring (DRDY/OVL flags)
> - Available scale and sampling frequency attributes
> 
> Patch 5/5: Advanced features and power management
> - Mount matrix support for orientation compensation
> - Power management (suspend/resume)
> - Control register features (soft reset, pointer rollover)

This sort of information should be in the descriptions of the individual patches,
not in the cover letter.

> 
> The driver has been tested on a Raspberry Pi 5 and all features have been verified.

This info is good to have in the cover letter. Even better though would be to
explain a bit about the actual methodology of how you tested it.

Also, a v2 should have a link to v1 and describe the changes made since then.

It look like v2 was sent the same day as v1. Generally, you should wait a week
(or at least a few days) to give others time to review before sending a new
version. 

> 
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>


