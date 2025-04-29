Return-Path: <linux-iio+bounces-18858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F93AA1191
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514961B64D47
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089024467F;
	Tue, 29 Apr 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ELlwHHls"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC522A7EB
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944345; cv=none; b=KQKBLRrEhNWsPOAcDPDHCASl/sDIYVaFt6xeQc+sOufxnbBzMO6sL5cbiqpB40zQ7yilLGppvUs2xaP7o5QAhFnV6ctq7kE6YGTnUBjPM2S29d6jQ+vQY8TEg079lEotwzaHilIzfHV0Ux1tPmNzdOhHY59SY6N3Ikp5vH/KBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944345; c=relaxed/simple;
	bh=kxJijwJOOpyMIXcfCls3QqWyToNqydz2DXvZT0qcO1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6Tv1TlCTgD/iRoWuaYkKgdhAes5pI4EvNQVew5owkq7fI5it5TNs3SRaCvuSQ6gKNxv9lePr/6u8i0yYFY41yeiSc29+d+ca2VEe1nvB635dpYTidbdBVvZQYFUrIfuINdUNoq62T3VfQVcfr+T6MqM5bMsxc4YK8mwbAbTQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ELlwHHls; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-401f6513cb2so16421b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745944342; x=1746549142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlzV3aC3Ajcd4WwT0NS/l9ibLgDyq3ihO7Tsirhk0II=;
        b=ELlwHHlsrW4x6siALslx2SQSxA7l8//pnnn/r1cacg4Kp8Q0AQNXaXrbSf3ZBBtZ/3
         3L4dHQ5n40xTkPUBXHg1/eBR9k9ZvcPm6rkqk8xY/utc/aUw/JA/7wEQ3k0QgT5MGeTI
         6V2d9iZNAnfZLOWkumB35RahyHKZHYWfuws+Ml/rsrrtVSduWe4YjUn2kiCo4GnqEIEu
         QzbtP8TJkDFUa7cU1kCZevOyOFBB++REcnfhAaTVIjn/FoVVuYflKgBCUMY1hDrkH9Ek
         V+zpPoBAr43pC9qnJa9xkuXyJja30QtwgDo6c27ACc4ToMl5dGZv69nFXgdE5FH7zC1R
         AAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944342; x=1746549142;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlzV3aC3Ajcd4WwT0NS/l9ibLgDyq3ihO7Tsirhk0II=;
        b=hvaX3BJDn9Ky0Yb3EuYORRWoF3hfPz/6iStsTwhinmTjDZbD3vPutATnXQYdWHra0i
         V4GJhBhErKBJxbjWWv0MFghGMr34zPtNK8mIkyjb0GK6NXkJX10dpQXoOnOvWsYTgp6n
         SXPMRAWaXBGr8dn7qGB7usUfxCSsUjBRQ3dHNBP//DO3f5fYPT5q1cuvwFmBPcrfZJHP
         rKeHLWNexjIuG5FT3Yg+sc+zfjPsOJc6KL5o69NwmhDkzPpVAyhUS3h/2TxfrnUhttIj
         V4Q1JqKCTJ6Ejh3+T/dTT/R5yauVqEdH6PACq4/YtYNWLrbr56rmE+FyHgwhralt4s99
         enig==
X-Gm-Message-State: AOJu0Yypmn2qkkCcktbZsJbWuQHBUFH562eFuVQR1+Ndc9+IIbfPBRyv
	Xdyf98XAL0ucuraVd0deXkbJ22HHL4tKpSto2DRceGcsjpMOt4uF5ZVbfsEFLQc=
X-Gm-Gg: ASbGncucSPXO01Et9jltCRZqIh2T2aO+L5FsyK1qmEuT+iqc+1cGxxH9PjoKceuvNRn
	T0LXBKIGvSi7J7l4y1yNqYu8+sN1WsltLlQsDi+zNqE71VFgdVJSumKIaiyhOgcBoIATreQphjf
	7eDyTlBKd4VnTFR+Lm5MHHNTeZX+OLspUMeus+ZAmxJwDoGF/8fugiCSsWRdAC8xY8ORAQFzxJ9
	WENg22+hOK9gHw+AiJhQEMu2snXOI9I60KrKGyWmsCFB6XnLWR59C8JunyUEPWXjk+dJp50aTzt
	ZPOtIjUjZomz26xKzTDmQoL2Sp2oyGvvtlGfmJQDYNjSrN/syKNQGB57ZDgAnI/pQcQIRgLUwMi
	s1khsplkaSQBtC3cyPA==
X-Google-Smtp-Source: AGHT+IECXLQfMw4IHoT8sY1k3B5PGYoLM8POTBaiM9WXU5IhYjgdUCA4tjARzeoztfzPvG3hb3MlHw==
X-Received: by 2002:a05:6808:22a9:b0:3f4:11b3:206b with SMTP id 5614622812f47-4021103ccb9mr2215175b6e.17.1745944342109;
        Tue, 29 Apr 2025 09:32:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6? ([2600:8803:e7e4:1d00:dc17:157d:e8b2:3ad6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40212c4dbe6sm315201b6e.49.2025.04.29.09.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 09:32:20 -0700 (PDT)
Message-ID: <ad489cc7-8c89-44fa-bcec-5c4b9cbcab74@baylibre.com>
Date: Tue, 29 Apr 2025 11:32:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: adc: add support for Nuvoton NCT7201
To: Eason Yang <j2anfernee@gmail.com>, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, tgamblin@baylibre.com,
 olivier.moysan@foss.st.com, alisadariana@gmail.com, gstols@baylibre.com,
 antoniu.miclaus@analog.com, eblanc@baylibre.com,
 andriy.shevchenko@linux.intel.com, matteomartelli3@gmail.com,
 marcelo.schmitt@analog.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429025505.3278016-1-j2anfernee@gmail.com>
 <20250429025505.3278016-3-j2anfernee@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250429025505.3278016-3-j2anfernee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/25 9:55 PM, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 

...

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	struct device *dev = regmap_get_device(chip->regmap);
> +	__le16 data = cpu_to_le16(GENMASK(chip->num_vin_channels - 1, 0));
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			   NCT7201_BIT_CONFIGURATION_RESET);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to reset chip\n");
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then the power-up
> +	 * bit will be set to 1. If not, wait for it.
> +	 */
> +	fsleep(25 * USEC_PER_MSEC);
> +
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to read busy status\n");
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(dev, -EIO, "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8)
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +				   GENMASK(chip->num_vin_channels - 1, 0));
> +	else
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +					&data, sizeof(data));

Why does this use little-endian format for data but the later bulk_read of the
same register uses CPU-endian?

> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable channel\n");
> +
> +	err = regmap_bulk_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +			       &chip->vin_mask, sizeof(chip->vin_mask));
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Failed to read channel enable register\n");
> +
> +	/* Start monitoring if needed */
> +	err = regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			      NCT7201_BIT_CONFIGURATION_START);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to start monitoring\n");
> +
> +	return 0;
> +}
> +

