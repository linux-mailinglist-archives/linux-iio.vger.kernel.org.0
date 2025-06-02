Return-Path: <linux-iio+bounces-20157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D1ACB886
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CE9407B42
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637401A4F12;
	Mon,  2 Jun 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wbb/ZJN5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EFEEBD
	for <linux-iio@vger.kernel.org>; Mon,  2 Jun 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878432; cv=none; b=SvCExaqJ3psKrwyA2ihttxPLCBxA7d/S/ir39P3DYUwLobU0hYHMBiBKG/zDc1scPxTTEv9U3wvBtxcc055PR/k7mHR+bA/ftUPMgVxR7t2FOFfTV7fYb1jJx+8nxhG/l2vBylo+k69GPWmSxlWBpF8tL1BVv0p8DeukRjprzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878432; c=relaxed/simple;
	bh=8tOtsQM+x4oiZCMtV4+BcU+eJaqF5wDJFxyrlOBUziE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8480axM+lcNw/HM0jswP9KzUWqDp/joRks6KMiCJ2BWakpsRdz49nPsfUo5oYR9S8Ri+5tH/4MzY10M3MdA8R6MIoEO0ArSLi+tiD5zm/ITZWGMS2Tt8YfxwWQ82ogfJWE1XRhoBRHLFAvNsVBm/s5flwm+qDtxo3uAznTUI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wbb/ZJN5; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e812ed38d02so1622450276.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Jun 2025 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748878429; x=1749483229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNfa+WaZFsZmSiE6Z+4+/C3YChzz471UVxFf3Euk8Ps=;
        b=wbb/ZJN50FlcE2uGj0Aszlrijd191ahUF+4z02hnECkdsqRyTqO5Baqo4pdePhNiJs
         OmIAJIzHxVp3AqB87rZp6vcV8wry5sY8FYdUkJ0CgMtUB8u9wJkNslnPQIt8WEEAhYG4
         d698U7UDQI/RzH7TQc7arCOzVs30ZXv4aNNB1V8xQQMrtEeh33K84P2t7G3nyTMVuh6z
         eNhiKZgXhglM52T3c4W+hQZKFBxhRJT/QtdAPYBfBeboO/jGq3wKJ0JS/dbKLSRAZ080
         Tki1CIyMqcUHVAA/hzgqoVGO3QFGJumQ5YjOewxt+3826igkcfZI3jBdG+N421IW1LYS
         hcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878429; x=1749483229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNfa+WaZFsZmSiE6Z+4+/C3YChzz471UVxFf3Euk8Ps=;
        b=jkxasUyx575yC2B8vyqXXR++klMT7Dn4uG88xqsk5O8x3BrNacFqasxZwCFRz4VSEy
         jM4i+oJHW6lpKWx0Ebo/RrbaQABP5jygnjqhJSqNqkJ2Txnb7kmKivBsE7LHnWq8d5nW
         wpkH0OGwpa5Acih1Tn7Z1XeqgDx3G7tq3HhcRRIHieM2bEHM6jjCPbVT6KGOgYLcfWe9
         lPPWFCN4lRuA6PIEnGuMHE2S5/09H22FL5Yla7Gt+e8wmW2Fg/OI+Ru2CMEvCr47h09j
         Z7f4XAcKwBeT8m0p1rSMt0sMTX0TSpsN1hkgwHm8t3OQ/gBvASLQrIArGDj2G4ggC+jC
         H7/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGgDtOGDsqS6Ygu9YR42P6ho4jN9l/ZiKqyjhnyJaAY4C24DdweB7oK2k+EPNiojzonnUMfhUzvcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmG5DrVCH0S/g8PIwWQbIUKyoI27d3Okusms1MjJ6irZs06ko
	sKFRFS2Jz2/FEQfruhNQNZWA12HgQAJubuNFtwG2exoNlNqoBNhOAT7UmRh1qlHKviIo8P2uoex
	fwKxM
X-Gm-Gg: ASbGncuoTP8nWVIe1J2g6fZ/hg9to3CoBqR7NCpKMSzKGMfMG5TplLPz085ITyfRQ5H
	MG/Q76nlYxO/HdUaYwLXFXPV5JAPRL8iTBg7DE7rW4Y6KA1X2SUx0O1Ka4QQp9Xm0NYbUwGBDiA
	CXnjP9HE8P+DURWPs1cvazrpJvlSPuZRSGDjbYno+6vBSnFwevjDpycB9WegowMkCBSVRnY/ikR
	fXnwuZrs9Cyh3qXOPiyC4gbIW+1EGxQVNsU8SRvEUQTb0b/w6z1aT+hUeRn0NoIm8N/hP7HaREY
	DXL1d6wNMgaMtHFmn8pjLd/WDNW6to/gz1jBqHvC8WRH0WUNRMOGDcG9WGjPkXL91UCIr2aVe9C
	f6xhk/63RafV5d/UNgPP1w2wZLEfi
X-Google-Smtp-Source: AGHT+IF57uQxHGgOlzBwzxJo2Ni/WLdwC/o2d4xhErwQ5I03YvinhZUc+GTLgNq4seyU6RFMT+NPuQ==
X-Received: by 2002:a4a:ee08:0:b0:60d:63fe:2472 with SMTP id 006d021491bc7-60d63fe2755mr6583332eaf.1.1748878418793;
        Mon, 02 Jun 2025 08:33:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60c1ebb00f9sm1488625eaf.40.2025.06.02.08.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 08:33:37 -0700 (PDT)
Message-ID: <008ea5d1-52f1-44dc-8576-d8bdd5c5beda@baylibre.com>
Date: Mon, 2 Jun 2025 10:33:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
 <c82b8c53-e653-4cd3-80ef-37c5daf9314c@baylibre.com>
 <zofjbh4yvtz4sfj2t6cpdohqqlrgwqdqtiahpvalbbfv2tdqqi@g5zpdp3zn4gb>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zofjbh4yvtz4sfj2t6cpdohqqlrgwqdqtiahpvalbbfv2tdqqi@g5zpdp3zn4gb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 6:16 AM, Jorge Marques wrote:
> Hi David,
> 
> On Fri, Apr 25, 2025 at 06:13:48PM -0500, David Lechner wrote:
>> On 4/22/25 6:34 AM, Jorge Marques wrote:

...

>>> +static int ad4052_probe(struct spi_device *spi)
>>> +{
>>> +	const struct ad4052_chip_info *chip;
>>> +	struct device *dev = &spi->dev;
>>> +	struct iio_dev *indio_dev;
>>> +	struct ad4052_state *st;
>>> +	int ret = 0;
>>> +
>>> +	chip = spi_get_device_match_data(spi);
>>> +	if (!chip)
>>> +		return dev_err_probe(dev, -ENODEV,
>>> +				     "Could not find chip info data\n");
>>> +
>>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	st->spi = spi;
>>> +	spi_set_drvdata(spi, st);
>>> +	init_completion(&st->completion);
>>> +
>>> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
>>> +	if (IS_ERR(st->regmap))
>>> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
>>> +				     "Failed to initialize regmap\n");
>>> +
>>> +	st->mode = AD4052_SAMPLE_MODE;
>>> +	st->wait_event = false;
>>> +	st->chip = chip;
>>> +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
>>> +	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
>>> +	st->events_frequency = AD4052_FS_OFFSET(st->grade);
>>
>> Somewhere around here, we should be turning on the power supplies. Also, it
>> looks like we need some special handling to get the reference voltage. If there
>> is a supply connected to REF, use that, if not, use VDD which requires writing
>> to a register to let the chip know.
>>
> Yes, v3 will add regulators.
> Vref can be sourced from either REF (default) or VDD.
> So the idea is, if REF node not provided, set VDD as REF?
> 
Yes, you can do this with devm_regulator_get_enable_read_voltage() if it
returns -ENODEV, for the REF supply, then call it again on the VDD supply.

