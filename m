Return-Path: <linux-iio+bounces-21582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389AB02255
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B63BA98B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922F82EF9AD;
	Fri, 11 Jul 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vCqprmGl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4832E7165
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253780; cv=none; b=RJQzR9F118sgRD7AFWiev6dkJjAw65i2O3kttdiqwqe6Vl9q3XXRpxKKWndfiZ8ACV4+7amH3igkeypbiLZW1uRkxwNoXPIso1MHscW/rfYBHoZcefjEmX+f7X3tOeslg0FniN/ymwLINGcvc+LTQd38IkYd3anNRqyzjb0G7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253780; c=relaxed/simple;
	bh=rGIy1pkQYmtcAjyatutqLQoQqkLBz360GZ85LcsduN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SRxwPI4dNvnH45dc8Y1fADZlLbTPSjATGhusAFJ8EssZBmapc+QzRauqvv6QWrXbJzPIauwprxcmOB7thvZAROJgQOQoKdthvO0yMgh8maF+5U0lb0eZ5HuNpofXYL8k9ahKbivkTbA9+qDE5vluyW8cLAQavbtCDcX3ptPkHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vCqprmGl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60be827f2b7so1738116eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752253777; x=1752858577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYyuRDB/HktfRyE467qi37bT7tU4zkVraiVc+sdSSt8=;
        b=vCqprmGlXjms3AGz+b4XdOxZdviQbawh3gfkugdX0zlZLY0SVKUUFhfTypAtjc9tdi
         K2D9XA/dUrayq10YH9TKW+HWYk1e0BHSOjS5Z9FzKZyKSVQ0uXp/d4eDdshhavPiaXuL
         cocG1dV09DEVqQVjXgduFP9R09gRg/QxlMyy36FK80N99heCbYjWh68se+dyD7jueW6G
         HWROD5ZHDayFjKbE55L9uN/3PBi9WLB1KI8+ydEQlgQ7+GeQcxdnQuB7AHUMYfUqK85N
         L/8yXXUQZ4Y8/Bde9namDCeDLKwn/xsJpLA0EjJGIfYNpDUM9LaZ6MdbbyavWt2CcfCp
         CVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253777; x=1752858577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYyuRDB/HktfRyE467qi37bT7tU4zkVraiVc+sdSSt8=;
        b=GD/ZUNAOMC36xaeLEnHuzJg1PUxQCk1VyYwViQI0pVi/kFSh4HA8FLB6TQzb8cuWD9
         fg6wMgKJDe0pjZ1PwrLlfyMDcWpeewyyznUBwgZG+GG26l+4pNA7h+dI6DYbLRvn8Z10
         UNRfmi4ZPeW9NoLgRA9dci9KBCVLVDpZg5yifzj7bAqzgVfJjKGZd5HoaBO+gzcjn1KT
         ToEVFMDIuc94zN6O71mjNDAeNeY86BY7PmJperCstADJZbIkHnBvom4ofNhzluMi0KZa
         I7N5pSC7UmajWECi083fNtSjxcVs79TMs9bWAvZD0c1liE27NiPQEy8nbw0sR/Vzs50C
         DNSA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3yjnzlqnNdKpWrVCEdhP2ka9eyK7LohNBmFRS2kO4eTFQpFcs83PcfvdUCwwuPkTTVGt1iyWXw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMcjwVb2ZPcZAORBBxzzE4EOWtqAAE99Q0W7SF1w25jLlQMnbS
	w0lyou8BpOu7XhtiWudyDp1Y1o85YY8+XQ+qhcAPjZzSbott0xPIDHn9vF2Lapc3W9s=
X-Gm-Gg: ASbGncuyAYGC6NrCwC9tNFVelKH8pxB/u44cpEaqTO0sLWtrZ1Yl8zrJOwRZaSWQ59s
	W+Nu+HpvMJE9m0qIFxO98sTZ2sNVyc3eYXvR+qDrMlpaxgVgFSfzOcKflWW0zHryigm8wkf9nal
	/B5wzNGTTq/6oHvcMaf2UYgqX+QJO81agRtiOX5bD8uaQk9DRJnW2+jJAZDmpRKiVD2f7E2BPwN
	wjnl46Q0AF6VvtJ0oRDawiXkmtGchBVUeEiZgUwfj9eqYhr4Re37OVxq5eu5yLhT4apqmtOVsaG
	/RXMZ7ZUnNiQX3lkL5bpWETUWsUq1OQDmnBryOtWaNnsLavt3IVWQplPCVbpVFjq2Ej30N4g3SR
	q9XHRBaoXK3kiqP1KYMNlRaox4cFolUcHzfflulojkqxYzrDu2ObIvoP+Ubf4EDX1uBD4tV/YCm
	w=
X-Google-Smtp-Source: AGHT+IGm4hiu469Vc3JSD1AOTjQdQx2W5sxcZJhYPSfhyP8P2MO+kMPBaRS60lXTzmvnR86pVPsFTQ==
X-Received: by 2002:a05:6820:4b05:b0:613:c8c2:a08e with SMTP id 006d021491bc7-613e5964d97mr3100119eaf.2.1752253777324;
        Fri, 11 Jul 2025 10:09:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9f26c1esm542425eaf.35.2025.07.11.10.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:09:36 -0700 (PDT)
Message-ID: <5025b191-c5ba-488c-a7cd-6f2bfde47bd2@baylibre.com>
Date: Fri, 11 Jul 2025 12:09:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: adc: add support for ADE9000 Energy Monitoring
 IC
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250711130241.159143-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
> This patch series adds support for the Analog Devices ADE9000, a highly
> accurate, fully integrated, multiphase energy and power quality monitoring
> device. The ADE9000 is capable of measuring energy consumption and power
> quality parameters in industrial and commercial applications.
> 
> The series includes:
> 
> 1. New IIO modifiers for power and energy measurement devices, including
>    support for active/reactive/apparent power, energy accumulation, RMS
>    measurements, and power quality indicators (swell/dip detection).
> 
> 2. Device tree bindings for the ADE9000, supporting waveform buffer
>    configuration, phase configuration, and trigger settings.
> 
> 3. Complete driver implementation supporting:

You will get much better review if we can spread this out across
multiple series instead of trying to do everything all at once.
At a minimum, each of these should be a separate patch. 2000 lines
in one patch is just way too much to grok at once.

>    - Multi-phase energy measurement (3-phase support)
>    - Power quality monitoring (voltage swell/dip detection)
>    - Waveform buffer capture with configurable triggering
>    - Energy accumulation with configurable time windows
>    - IIO buffer interface for continuous data streaming
>    - Event-based notifications for power quality events
> 
> The driver provides a comprehensive interface for energy monitoring
> applications through the IIO framework, enabling userspace applications
> to monitor power consumption, quality, and waveform data.
> 
> The driver will be extended in the future to support multiple parts such as
> ade9039.
> 
> Antoniu Miclaus (3):
>   iio: add power and energy measurement modifiers

It looks like [PATCH 1/3] didn't get sent out.

>   dt-bindings: iio: adc: add ade9000
>   iio: adc: add ade9000 support
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   19 +
>  .../bindings/iio/adc/adi,ade9000.yaml         |  157 ++
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ade9000.c                     | 2187 +++++++++++++++++
>  drivers/iio/industrialio-core.c               |   11 +
>  include/uapi/linux/iio/types.h                |   11 +
>  7 files changed, 2399 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
>  create mode 100644 drivers/iio/adc/ade9000.c
> 


