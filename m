Return-Path: <linux-iio+bounces-14000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BBA04D91
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ACE166243
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923C21F2361;
	Tue,  7 Jan 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q2e/oNEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37F1DF97A
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292803; cv=none; b=dLeouqdekkb1HDnQ3pM9uG72sF/tpfCfRyaXK4zL0/iBFZWgFPhKxZ3O7WHNr7rPYlrVJmZW43UzhsuCiWPDD9Mxp1b5yaiOV385qJduEEDI7E3PNOdvjhDVbwInIPt1Il1sOaUBmIIQMB24f4u0v9Cqx4vOSH2cRzbfabK/hoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292803; c=relaxed/simple;
	bh=0b79uZgF06lCBq7nAEImvDd81CILid35SQmTDGoJDik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqZNu3lBiFW8ge1suJX2Wj/BCWg0l+qxGpvNzU+FrqHKxidFG1McCUQ+ClGoObiL5E+EKHy3ZebbkeVrXvtKf5zgh684tMBY2dYuh+CNYG2r3TROUy5hqc17OllBkF0V9CYDpms+jNytwIhrTvdU0j/Aij/2O7VDfyey3fGIhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q2e/oNEy; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e15717a2dso8604256a34.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736292799; x=1736897599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Es/rzdlo/5s0yZtlCeIF9RUEz3jMUulvwPjffSuYiH8=;
        b=Q2e/oNEyecoFEJcvMkF1Dihjhdiq2SfRNd//B/+uK1gA6Ul5ZV9qLJKAaqcZgOx8LD
         Ap2hG6bNPiq0izATPhY1POK3xXmdB1E9SBt4gNNaTJ1mAgXw7AMJvi4UHjP37BdCjJ1H
         60jamsZt1Y0fsXwAOK/q5DJt+nV7Ja5yYsuphB09Gy1fPYxk46tHDpe0Sc2EIDIhj0hr
         EPtaykRy4TfgNe9N5aMFV3wFal8HOlXSKzuHcmvUpczpm1K0tXZoSoIDKjf62Wyx59wc
         zeaTlcRqrnSPjCaL2SZ5KNKW+3ogDu92K5pJDUgsUJTiGfJRrZAHKogRwDsZ8vDcEGUe
         PZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736292799; x=1736897599;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Es/rzdlo/5s0yZtlCeIF9RUEz3jMUulvwPjffSuYiH8=;
        b=L7SE9Dcr8M/V/JvUV9+LimOESHInt8h12nRBLtvVky9pZ/L93oFdYvvVRMkn0iCkwO
         PzllzbOfAxRLEIhnNbXTdI4FDL4Ywt0qRvTc4KGg2xQDqE4e0dzFzr/fPX8knQoduejF
         gJ1BmMhWiJRxgoJQy10HfG0bg/11uubFCHvmk3v8Sq56Te1aZ9TLg7nv5rwuZ7B3kfej
         np+n32EF8VajAfOOq3SkbieVfVxofvqVUp/BKDjSatIWwIJQm7/YUGau5wsFD+DFd7h2
         Fqz5iRXJzImxgUmQ0gAfQ1qls/km9stJEE95ThSAsEKqhNQyUpZ24EC2xpFaQxI3sMx+
         esUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNMjMJ7KbPT0Bbx7o/i/BwsVhQxyeB78fHuFmNMpzbkpP89PXuW09ykcjYuvwMey0gsoOY9DEY+oA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8xdC17NdzCv+sMWnDM8Y9xePWa/Uv5hKGB5wVQ2Rd5QReKvk
	i9tnDcB6lHO6Nfb+3bslTCIwJT7Pxkk0vbaf7ONYrS6yA3MmoUU/pDKVObD/f+g=
X-Gm-Gg: ASbGnctOIIItmCZnFqNs9aTjiG453nuC5/7fNrOc2uigIooD8p+nDvTZTQ0FSiLdc04
	+PNH7mS/3RY6eYCUWR6xak8I/wTGk2GP+4Am0xGJGuSFR9M0bPANFRwi6e8AbO2Jkbz/YqPPm74
	SHaqAqVx+A47geHPc2UXx4dxeV/85fmLvgQws6lRLIqfkSRHYDwoInmmBlV1iSvo8r7+qtyu3Xa
	uCpxhX2ePWOTTB7VZgBAUEKsAmKMM1dOthvY7Wg+IQFgQP/ePRXBnmFzlFy1XmguKubs8aF9e1R
	MJWs3sd5iZGAkFgxKQ==
X-Google-Smtp-Source: AGHT+IEsJMmE3nlDHsTIoi88s4mPahk5lFhIxoSGWe/m88EFqzspclWb76glFB3QXFAjFCJ+uz6bbA==
X-Received: by 2002:a05:6830:6381:b0:71e:1568:9411 with SMTP id 46e09a7af769-721e2de97admr440339a34.1.1736292798755;
        Tue, 07 Jan 2025 15:33:18 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db5d8ad3sm9812250eaf.17.2025.01.07.15.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:33:18 -0800 (PST)
Message-ID: <eeea054d-ebe8-4917-85c6-ff001cef50c5@baylibre.com>
Date: Tue, 7 Jan 2025 17:33:16 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] iio: adc: ad7768-1: Add features, improvements,
 and fixes
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:23 AM, Jonathan Santos wrote:
> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver. 
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage 
> configuration and GPIO support. Additionally, this includes fixes 
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.

It looks like some of the patches also have to do with a sync trigger for one
or more chips. There was a recent discussion about this for another ADC that
seems relevant:

[1]: https://lore.kernel.org/linux-iio/20241128125811.11913-1-alisa.roman@analog.com/

> 
> Jonathan Santos (8):
>   dt-bindings: iio: adc: ad7768-1: add synchronization over SPI property
>   Documentation: ABI: add wideband filter type to  sysfs-bus-iio
>   Documentation: ABI: testing: ad7768-1: Add device specific ABI
>     documentation.
>   iio: adc: ad7768-1: set MOSI idle state to high
>   iio: adc: ad7768-1: use guard(mutex) to simplify code
>   iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
>   iio: adc: ad7768-1: add support for Synchronization over SPI
>   iio: adc: ad7768-1: add filter type and decimation rate attributes
> 
> Sergiu Cuciurean (7):
>   iio: adc: ad7768-1: Fix conversion result sign
>   iio: adc: ad7768-1: Update reg_read function
>   iio: adc: ad7768-1: Add reset gpio
>   iio: adc: ad7768-1: Move buffer allocation to a separate function
>   iio: adc: ad7768-1: Add support for variable VCM
>   iio: adc: ad7768-1: Add reg_write_masked function
>   iio: adc: ad7768-1: Add GPIO controller support
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |   2 +
>  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1    |  13 +
>  .../bindings/iio/adc/adi,ad7768-1.yaml        |  24 +-
>  drivers/iio/adc/ad7768-1.c                    | 830 +++++++++++++++---
>  4 files changed, 747 insertions(+), 122 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> 
> 
> base-commit: 5de07b8a24cf44cdb78adeab790704bf577c2c1d

What are all of these prerequisites?

> prerequisite-patch-id: 8b531bca46f7c7ea1c0f6d232d162fd05fda52f7
> prerequisite-patch-id: c8c8637cb3343097c3224a9aa315fc45dca15f45
> prerequisite-patch-id: e0baac9ef84e6e8a0a272fc6191fc1cb48143e44
> prerequisite-patch-id: 7e5cad70809fa7d37e917628147c197427c11594
> prerequisite-patch-id: 28dcdb0ebc3ca3c02713f83c94a4eedbe81095dc
> ...

