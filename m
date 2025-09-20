Return-Path: <linux-iio+bounces-24326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05EDB8CB2A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C9A623131
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1D2FD1B2;
	Sat, 20 Sep 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f7btD9Bc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31A29E113
	for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380744; cv=none; b=Fhur8k/tnRAmDT72U6QIvco1zPxoXpP7DX4CmU47oRSBccmyE1G/al8dEhQLhhS9Wd8s2dzO2kOBGB8eJ+CgfC45keLMokxWdBdFBoSVSYLU51pp1df7nVpHaQ9MCw+Xi5auDpX2RVOKpoV3Jg3oEZHzjQF9HXMUaaLSu8MXnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380744; c=relaxed/simple;
	bh=aWayvqL3VDfszikMhDxl8W1TgKxHXMgXHh6mTuD+Pk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRKHCAQWqviC7Dwou6IjXFOgYq/ctU/G6MxdZn70NVhioMaLxP0keS3ivR+JT5GF2fpo7Ev8dwrpfOV4aFJcRH883VXnsViWvZB3Vnz/a2xlaWlZM4Tu8DFbfOdHSMcnhLUOuYy3ioldIiwD9/CKHOd/j9hS3hPEbTwekCsXbkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f7btD9Bc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381df387fso1599049a34.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758380742; x=1758985542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApPm9TrFpXMEdiMfo67L+FcuF5N4ixQDCyPBv1VUDxI=;
        b=f7btD9Bc/p2IJpCz3JU4pDTlcwTXA7+lb+iE9Jxu+DjwQ0efBA+DFNsfR8R2261ePi
         5K+cmGUsn4emmz7hNbr6PLGTSzeXkbNKe25Bi77VaYBhVd+DKcPoa3jjMCO6o05ayQye
         iPEu83EYVxRr1gzVAxZxPmTF6WN3ieWQvuVYpQXH5HFYa89W6WUp8Ud/E3GeOTLUNInS
         DAOLfPJbMqMXHsR6owyToe8TjWcOEPl2+SMWnzzEWuXqZoPtCU5RgKy39AmLDrcVroZR
         QzXaaJfyZgJZNuJVXkXRCLMpsMZ/fuWhDYCvcECjhnBa0rig0Eh1zC9dh795vxHXr8q5
         gnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380742; x=1758985542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApPm9TrFpXMEdiMfo67L+FcuF5N4ixQDCyPBv1VUDxI=;
        b=qJuFIL7vh1uHAIIgZ82Q1sZeGTpQ9713T4eesH4Ce+qQqs+h2OMF5Fh2gm2m1P/+0i
         SfqIon1/z19AICIGX05Vfhls5q6yg/8BOgGNlloDAW5SZwW3+EeRmoc9h3GqT4jNzwNM
         +hSQ4fIPy5gIYo+QfCrpJSCiwF7C19AdUSOEK8LVGX/KuzAdHITDbTkiboSur+mtqXmb
         R21E5wcNCdMWziF3kVamVk20ptW1HPfUqAp5RhLaS3dOFSOXOrFs+GrHJdvQiu43WcM1
         FoBhsUpbgl+uASRVzASmpVk/FHPZI5HnnBl6iddr5pbbAGtgMUKYbBoOe9xXXmYYDTsK
         V59Q==
X-Forwarded-Encrypted: i=1; AJvYcCWThtkz6S+8F0pxUu7soHsRvcehUd+6m9JvTjhX+6xH2p3ntXzwwRB70a4bEaz/UJMToaQ38FENmDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN3PiPR4/z7+UsqeVqr9N0qPMXJIA94odqIUVEraOLR+UXlF+
	VZ5wWPN5kI1v+fXq5QuUFLXW0pqvyyvI3lWTXIRrKDUf71jH+yBkThC4jKMWRQKn58Y=
X-Gm-Gg: ASbGnctxsRaazs6yDFa7txqgjsx1hOOLScWuPa3X6S2m9ikJiNyrQ+5uf5A9iuPbnmc
	Mgl0JVzKMKLF/1Snh3JmN4LslxI9OYv8rUtJ4WMH2Vtam2DQwsObY1AQuz41JbrPIoy/AZfmBfN
	PamDKWLNWgBclkCl4RahzzfNJP4FwzDSBSIanUFkhifGJ0PwDjFfvqBruDbQbCEHRECTet8ZBUX
	Ynam1pgPq9kOuAaZx78iCsu2QpUTkCGnQIIBcm2ju1GTicLkEc5u8nq6eON34c7RcUDDxbd65E/
	dEglXKfVMHdEHne5nwYhPgpI9mf6gThhLDksiKPpC4PrHEs7i/Rb5ij/1IdQAlrOuJhsEqojUA1
	EhGXG4crVFMxJVGNXqLHxOe148XZKDMl4CERsRsoo/QNdL/NIkzHb/w3cMqvoM6kNocjzzHovAf
	A=
X-Google-Smtp-Source: AGHT+IF5DOCsFnmXWBk4EFUMe3TaSuHUTrmx8iC4wB7mmSr96ueHoL1IQtk8a+YwSVn8HW8dh3oXUA==
X-Received: by 2002:a05:6830:6687:b0:758:9be6:b5b9 with SMTP id 46e09a7af769-76f81bbd71emr3753044a34.32.1758380741945;
        Sat, 20 Sep 2025 08:05:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d5d22e21sm2630056eaf.0.2025.09.20.08.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 08:05:40 -0700 (PDT)
Message-ID: <5420e895-fcd4-4632-81d3-389c6439afde@baylibre.com>
Date: Sat, 20 Sep 2025 10:05:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: temperature: add support for EMC1812
To: Jonathan Cameron <jic23@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
 <20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>
 <20250920125144.41f70a1f@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920125144.41f70a1f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 6:51 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 15:21:58 +0300
> Marius Cristea <marius.cristea@microchip.com> wrote:
> 

...

>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_CONSEC_ALERT_ADDR, 0x70);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_FILTER_SEL_ADDR, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, EMC1812_HOTTEST_CFG_ADDR, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set beta1 and beta2 compensation parameters */
>> +	for (i = 0; i < ARRAY_SIZE(priv->beta_values); i++) {
>> +		ret = regmap_write(priv->regmap, EMC1812_BETA_CFG_ADDR(i),
>> +				   priv->beta_values[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* Set ideality factor for all external channels */
>> +	ret = regmap_write(priv->regmap, EMC1812_EXT1_IDEALITY_FACTOR_ADDR,
> 
> Perhaps a look up table for the registers and a loop?
> 
> 

Also see regmap_multi_reg_write() and regmap_register_patch().


