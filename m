Return-Path: <linux-iio+bounces-21202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78676AF0534
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 22:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED27189F988
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74903302050;
	Tue,  1 Jul 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gZ0sF+XM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565302FE33C
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403447; cv=none; b=ZX3HwQhm5kemWxiPytSBAHeIFB8w5sz1TkwBiW0xHDs7w5Pa29YGuEFJoesszKEjgbB0MRuLEvFQjOeHZ6TFGOJvTihsGRsPa3g1Gwx8trMuJqSBbg2clk6nelOrYy2uZ7qir8FVFXHjN1LzL5TevE0+uHqrg0iQY2SaxpQVwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403447; c=relaxed/simple;
	bh=TJykQ/gRq/gf10TIynCQbjQP1Ab2MiEGTp6/NL4ri1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbRU3T/fCV6M2s2gNqaT9xF18EjFtXPAEDSvYRReTeQdtZEiOzXOZZqSVEaxW3SyEm9x606YRXrjXOBT8ki6swMQULYhZ38Xgorfacow1hNlDv8VxKxoWL31RvoXQ4gPLE/K3NhiD4fWN1bEnFz7MAOXMSuIt4aZPitNPkAtNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gZ0sF+XM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60be827f2b7so3946088eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751403443; x=1752008243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3FGHq0li4IAoMzOrmPNDDSYUiPqRZNOr/Yo4wW/FVs=;
        b=gZ0sF+XM1SpimnEhG/gqhiXbxEzZh6jN05bGhoYuexBbmOW8AEXXs57UjjNI2zV4i9
         9B3ewzV3wqv1v6JPgHq1L2NzmVEHTCv8nU5rUIe1Qb6iGD51fXEMA3GWNAkBRQgcCy4e
         1nrDBaQgfJfVw7AanYZwlzkew4cGgisZ+eig1/nPHCuA/KPEEm5BrZYOFQhIQP8G93X+
         ess3OEHJfLwCeOwOS8l6MCgjwtNDnIOXFey9BVmJb5dt2WRDQh54wYz3qnh8b4FFVqdA
         skS3pXdUe6E08aj+L16Y8t96HzFUpk+FKjmelnWF4iAvE0TRH6Aw647byaZQT8G9p5jP
         6bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751403443; x=1752008243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3FGHq0li4IAoMzOrmPNDDSYUiPqRZNOr/Yo4wW/FVs=;
        b=ViT7DUEHbI3qiQzDIqtMLeP27LUgLOeGVm0o1fdZyDzcKPo6zaalF7ZjKLtON6tFdp
         etfve/TMizsAQSk3w6bds0Djnat0hXb5msHQrLN9bCiLlhuO0xVP+hA/H71tUIVGoM8J
         ZDgHcYXs1LmhZd7iZSpU47khEwJbr2FfcBQbRKqaVVMU2FmzqZtgi4/SGT2vqN93AoCI
         Yw4/IALjoRSjiR0ua215WJRAUPpv3p47Q9ZAPN1O0BlCmn0CCecBPa9Y8tNUcKwX7UQp
         xnfWzbwiuEHVfrdbt8mgVVe+zhunahMX7Z6PNc+wGKED13yskBC+zzuSxaB9a0Bs4U5P
         VI/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9hkXkcP+fEDC92CboECVmf964ZOaaZFkGaoXBQXp6iYeROnDTgcMCcNIVE0Hvp3ASbJxIxAjaQqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoz5Vs5of8B+Wx4W3Mz1HBEHgTvmp46Smid/fAc28s0XKqtDpR
	0X/DQRmunc4aCnNGSCSLb2Gpjr8zOaI6Ot4p/lKWTUK5M5FgmWp37Z6zwp9xtZPKr+s=
X-Gm-Gg: ASbGncsZMV/F3ck7NrI4XF5PUGdQ8kHeUUWkiV0yak0mVSuQMYlFwJ3w5yvL11OZfhe
	q8bkc3X06pM/mEcDubDUPv15aKYQTfwf5kYJKH3Z+VpU5s/nIGQX2J9e6oeT4oeOifwI/MFE/uM
	A4SHmqQM70OHDLS5g605+k1hz5TzoiBObyp9zDVm+oB/1LgdfPSI0xs6bQYpUUcXdbUGyZ6mfOW
	Do4kkU7gdHrCjFQJP11SycfBhxIsB6xF/E+S3LH40OeuRyfdleHhBS4+a/yIurlRq1JZmE7X7+m
	6Nh6hgtM5qeK7jPugFhjkJC+/h0507605Ek9dQIOo/iNUsLd9jgWPdcYn8fLvp4XYdiH97nDh/Q
	ClgY91l4MfmX9Jpyfji1lFuhaUeNEwWiq0YrqzKw=
X-Google-Smtp-Source: AGHT+IH3mXwfNatjVX7249TuXT4mbijuHY97w9uhrbRcJoybXxQKtykU0E/lA0MVCBy0eHSWIO3Icg==
X-Received: by 2002:a05:6808:19a7:b0:406:6aa1:38d9 with SMTP id 5614622812f47-40b8a7c55c0mr82409b6e.13.1751403443339;
        Tue, 01 Jul 2025 13:57:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5? ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3240277bsm2268043b6e.23.2025.07.01.13.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 13:57:22 -0700 (PDT)
Message-ID: <d1e5f360-cf2b-4c50-bb26-64db47a78c43@baylibre.com>
Date: Tue, 1 Jul 2025 15:57:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
 <20250628160259.6f220dfd@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250628160259.6f220dfd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 10:02 AM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 18:40:05 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.
>>
>> This is used to trigger a SPI offload based on a RDY signal from an ADC
>> while masking out other signals on the same line.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David, Mark,
> 
> This looks fine to me and I'm not immediately spotting any
> build requirements to mean this (and binding in previous patch)
> need to go through IIO with the rest of the series? Shall I leave
> this for Mark to pick up through the SPI tree if he is happy with it?

Sounds reasonable to me. There is no build-time dependency.


