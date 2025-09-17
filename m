Return-Path: <linux-iio+bounces-24212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF7B7F434
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD16481EF5
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219922A813;
	Wed, 17 Sep 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qj/Thras"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA91E25EF
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115507; cv=none; b=vCtTku7no1gbjoLL65/Uq6BRQimQa8WPDDIlILphVECpeV7CFArlWr1xmUHJHxL6sHl3oM26m/v19/6HtaFKGo1fWR7KZlwd/ptDnDO+FsOmOKgUuPSZkHTBwzlWGzhJpjAhk1/mlGmZuT3XA+093Gav+svRli85CbAPaJksU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115507; c=relaxed/simple;
	bh=3MD+nT2bAWZX72DWsoioTXhieL+ehQibl5aVvtcfd8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msNZfEVlu8CWJ2WuKWQjD6C+vTTj8sB+GNPJdLTzyNwLx+w3edoIOfT1bfCM83DoTsWzfkipqQTxaULdTOnAV5nh41kZ81Y025P72uDkIQJ/rai9UHkSSP+kpLSP64i8VxcIb6Ua/Y9mcHBNLLux7w+IoGP2YZF4veF42kVffkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qj/Thras; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-750c5378b96so520566a34.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758115505; x=1758720305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8q4pnZHASLYPEvExV/oNTuEhXYw8/V1jtaAGiihTOE=;
        b=qj/Thras62q71BoSmqFuRq/MyGzFTGo3cT5wIdlDOoW1c7GYAD2yKZGNgrvY5JYUXp
         0Ob/hPo2ztE6IX0SR2FdyI6UjfwV5QGDNa+9GbsyFkx9Hgm+X2UDLZZtVvruIVtPZyuC
         xLLHpOiryhE78S4MZanvRXB3WpfoS8mY8mNSBWcFdvbGEIym5cUkNlrvf46GhBB35hpy
         5S1UfzupAl89Lb4NvsI2beTSyKhee5tmtVqmioEFaN2gtU9otvqr/DhqRzm6yTbnamVH
         0zYpKBoOjHWb8qHV05kqzNyZ7pc/6QRWUOmmIlKNKAE7XIxbp1A6VPP+77yFWDucqtjt
         94DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115505; x=1758720305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8q4pnZHASLYPEvExV/oNTuEhXYw8/V1jtaAGiihTOE=;
        b=RsD94LzYILxHtX2RI3vhuu5CPr4E1cZuAxEYuPhrjTG1oCyOAEmfzuH4GZXbbXnrWj
         6fSTbC/T5/FN7E+/vqin4KdJ+8dNWLmUH1zB9j9wgYU3er1fLIOSAruh6OTM3e9mOr2y
         nLVfy6DQXxumvmiOtDXI85pNYS+9GJ18A9KVhG2RaAlBGYOdiaMkO3jWvo6uUEArMlci
         BDnoWtUsErxMaqlGfZUYgkuoYVohmh1awlfGiUfEGQAq+nETMn2fnVcd42Rg9c3gVM2O
         J5xzC/FXS494plw3qRO8duEVGLXsJxEPj3RdrERrr6+mIg2SbI9PccnFNdMlRSQMZ7Ir
         znsg==
X-Gm-Message-State: AOJu0Yxd+3gzoKHaLyGNqOAXVVNsm6UKHR9/AB7jGo3SlJwa78GviIo8
	m94mfD1goLZDI4oDSzGmjVQeBO7GcXshw+O6nEZ2noyaSiq4JlLeEdBCsJEf9CWcrTo=
X-Gm-Gg: ASbGnctd/i3h7ebXk8Kk8gMt7STY2tQX6+8UAbhaNxo+sZBv3B+t+e61lU5nYQqA5S+
	ZDy3KCOQv/39x9/ADHQiAtlWuqydFMOgVCp4wNwypDXKGKA9qPiAPjzgFTqYaPiZ7PdjCtgApeB
	sWJipUyfvBVua09IgdBjzoiwVqd9NxslbrbdtiXW99L1vyUqXaL6cEWp1rdbxWn+YQMhBMizEtX
	4XyhgILBI4avqmm8THFKPIlmsUAX7aW2quc24sWgcIywebz8C83q5JbAYdLgLzMP7+7MmIa5ij6
	Rp1O2Eg2vug7nvulVPPmI6ltdkriEaYt/MTW0jg37r2la+XI33PAdngKg9v4R619B1GTGR1DrVn
	nBsAba1IgB8ybUXTaiIueeXHK9VUGF4v8uygftOhZrqpxM/XuaU+MijIe//kJn8kIjNRpVpcBRz
	Sl4nPNvQA=
X-Google-Smtp-Source: AGHT+IG1u7fASL/1WA75d1Wor2F1IZmchDq7YS6/itsUAj9zXiSwllVgUQzVye0hFI5oYPpcXOy4nQ==
X-Received: by 2002:a05:6830:3c8c:b0:745:9769:ea51 with SMTP id 46e09a7af769-76368fc2105mr1455163a34.9.1758115505093;
        Wed, 17 Sep 2025 06:25:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:72c:cb37:521d:46e2? ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-758d8131976sm2894436a34.3.2025.09.17.06.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:25:03 -0700 (PDT)
Message-ID: <e9379a2f-be0e-4f8a-b464-df7382338107@baylibre.com>
Date: Wed, 17 Sep 2025 08:25:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
To: Marius Cristea <marius.cristea@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 7:21 AM, Marius Cristea wrote:
> This is the iio driver for EMC1812/13/14/15/33 multichannel Low-Voltage
> Remote Diode Sensor Family. The chips in the family have one internal
> and different numbers of external channels, ranging from 1 (EMC1812) to
> 4 channels (EMC1815).
> Reading diodes in anti-parallel connection is supported by EMC1814, EMC1815
> and EMC1833.
> 
> Current version of driver does not support interrupts, events and data
> buffering.
> 
> Differences related to previous patch:

This is confusing. I think this version is v1, so there is
no previous patch. So why does this say "previous patch"?
Is this actually v2?

> 
> v1:
> - initial version.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
> Marius Cristea (2):
>       dt-bindings: iio: temperature: add support for EMC1812
>       iio: temperature: add support for EMC1812
> 
>  .../iio/temperature/microchip,emc1812.yaml         | 223 ++++++
>  MAINTAINERS                                        |   7 +
>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/emc1812.c                  | 792 +++++++++++++++++++++
>  5 files changed, 1033 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250805-iio-emc1812-e666183b07b5
> 
> Best regards,


