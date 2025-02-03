Return-Path: <linux-iio+bounces-14955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27830A26764
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 00:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18AC3A50C4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189B2116FF;
	Mon,  3 Feb 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TR1u7KMd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF95211487
	for <linux-iio@vger.kernel.org>; Mon,  3 Feb 2025 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623684; cv=none; b=GRl3WVVP+9qMW1BNoXVg7zsQFmLFdAFDeBbCt1jE4B3bKEwoqoTApjaCdz/U0bWLj+e6HNznUDcIy4eHyALSPVhDdLnnab+o10m25E0bNCCajRkZRAs2VCdKkYzycbiOGdu/u+HzgI1BDv65SsKs7aqBv7aUPkOGm4Pr+T7/cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623684; c=relaxed/simple;
	bh=JX6YgyI3XB5KZmwCC3kBcbBo+cVpHlL6lsPqGTgoxeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPacwnsQXRmM+IGTqE+vuF3/TOO58S6W2X9NbFLSPJrHPTFEAsKZdeEOoLQdpbbUgyu+O39xNRT29KkfgdBb5fygS/sIqmKHX4yMoQ5nlc2SoxSjTPYUKkfFk48Q7+Qr2K/FTgQk/XBGSZeJIC/tEQb8jrLGCK48J/IL4kzJMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TR1u7KMd; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29fb5257e05so1435545fac.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2025 15:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738623681; x=1739228481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q48N32/BZzAOoxhPyz3+9vdM39rBTv/9Tu2+c8AC5Nc=;
        b=TR1u7KMdbhzMYP9oF0mbItwasEVKnR3dcvon5gwbwTryxzXJxf/p6WhbNNPjyf2MA1
         cHEtllG4Z+HxCbHULwOmw3NXlrVOIAr83ucKd2YW9E8p1LnWCjwu7C9TMeZzmHZDQV4n
         qVmtqIOD8nSAdF52CtzDHMo8fQD8nh7RGVyH3VzqlMHToDtQzpATsiA3VWLF+6gEiL9j
         GyJRtYBLNLzFvw8n4re2GJwr2Zga+nv1JJDQoHan2UjMwEvhFLxWYx9DqrrQs4PO+8g+
         kMUg1dFTXHUzuhwn8dZHFXDSwlyjt8fMFcEWCVVQhPKhS1d4BDtzq3Jc+KNAxoNe32IF
         I6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738623681; x=1739228481;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q48N32/BZzAOoxhPyz3+9vdM39rBTv/9Tu2+c8AC5Nc=;
        b=dHzM2/6Woei1ijurJt80Z9tVgPtz2Lp/+aJrHx+Fv7vqkKfjYyqkxkZbJsQpeBlM77
         vUStY9E8L2SMEAEvOLxgVX83W6/DTfStTZA1AizcZArOYz4BJF/Ax8f4632Phzvd5txJ
         UsZjOhr2O2597tJLSaeIHZTnHvB50/HyDwa9KlZmKu7GW087lIcyzXZTKwpAYxNwivz0
         BSzVD7ovuYOOpd2V6cj/R7g7q7dZy3kj4gDjRBLngWo02oygC9q3R1IZM8I+/YCbaKPD
         eJVhtlbO3U8R3GG/bWfD5WlDRvAuSMJcYeZzHX8V+ZjudUrgdEqP70PmVH48oEN55MHQ
         VNMw==
X-Forwarded-Encrypted: i=1; AJvYcCUEO/kO5A1RUIOpKcyA3FJgUAi39NjUxn3fkxEzhx/UK8H7LjsY8lRBjXR37De8bU1zMXhx0xSo0Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDqovcSch32agamWHK84X6WN18/p4/4IeTgCsfEhTR0gFmkST
	0vrJbftncb2EVq5W37jfcaQgH//Ob01kc4ibdpAEYaKeMBU9ajw3E+K+4OCAxDs=
X-Gm-Gg: ASbGncsX5PbXEweVUG7zXYhnx7U1ry88TdQ2NjLbnq+B5Y3YqetyaGd5tR8klNl2HbM
	YD+b0FThoZISLiTbrm7fzrNLcoQmXsvtw16j4h6wIYMpT8Fqrt1PcYOnIh/583P0vFrSCD8Qh9e
	G2oZAb1UZoYX/dx3+HkjoAwNPisJDPqEaqdhSj8JzebK8mCYCzpX0NE+5hHK/9/k2H36oBNmQEy
	r628YOCga4pOEZw9LW2mWcxv3XskynZfmFNPypoTHzL6eM3HEazpgueF5TJgU0YOyk8zjgB5DOr
	YjOjrcoc4+j6hgm9ol0su+MXgCWF1nDoz7fIk+IiDxFvxwhzeEmJ
X-Google-Smtp-Source: AGHT+IFvQHZNew9RMVh3oMkAV8tgG3NqgZ2zFveyRCk4EzbOqbrzrj7jrDhOfm9blPA9OWsKbsUncQ==
X-Received: by 2002:a05:6870:3127:b0:29e:55ae:6170 with SMTP id 586e51a60fabf-2b32f26ff66mr16402322fac.29.1738623681468;
        Mon, 03 Feb 2025 15:01:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356196935sm3599125fac.17.2025.02.03.15.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 15:01:20 -0800 (PST)
Message-ID: <9f209ff0-e56c-47a1-8df0-603d30d36ccb@baylibre.com>
Date: Mon, 3 Feb 2025 17:01:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] docs: iio: add AD7191
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20250203133254.313106-1-alisa.roman@analog.com>
 <20250203133254.313106-4-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250203133254.313106-4-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/3/25 7:31 AM, Alisa-Dariana Roman wrote:
> Add documentation for AD7191 driver.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  Documentation/iio/ad7191.rst | 250 +++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  2 files changed, 251 insertions(+)
>  create mode 100644 Documentation/iio/ad7191.rst
> 
> diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
> new file mode 100644
> index 000000000000..b55f3c13e45a
> --- /dev/null
> +++ b/Documentation/iio/ad7191.rst
> @@ -0,0 +1,250 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==============
> +AD7191 driver
> +==============
> +
> +Device driver for Analog Devices AD7191 ADC.
> +
> +==================
> +Supported devices
> +==================
> +
> +* `AD7191 <https://www.analog.com/AD7191>`_
> +
> +The AD7191 is a high precision, low noise, 24-bit Σ-Δ ADC with integrated PGA.
> +It features two differential input channels, an internal temperature sensor, and
> +configurable sampling rates.
> +
> +=====================
> +Device Configuration
> +=====================
> +

I would call this section the `Devicetree/wiring` section since devicetree has
to do with how the chip is wired up.

The existing `Device Tree Bindings` section at the end pretty much just repeats
the DT bindings .yml doc, so we could drop that section from this doc.

What you have written in this section already covers it very well.

> +--------------------
> +Pin Configuration
> +--------------------

I think it looks the nicest when the --- exactly line up with the text and I
think that is the usual kernel style as well.

Example:

-----------------
Pin Configuration
-----------------

Same applies to the rest of the doc.


> +===================
> +Device Attributes
> +===================

There isn't really anything unusual about attributes on this chip compared to
typical ADCs, so I would be OK if we left out this section. If we do keep it
though, I think we should write out the full attribute name since some are
separate, some shared_by_type and some shared_by_all, so they have different
prefixes.

> +
> +The AD7191 provides several attributes through the IIO sysfs interface:
> +
> +-----------------------------------
> +Voltage Input Differential Channels
> +-----------------------------------
> +
> ++-------------------+----------------------------------------------------------+
> +| Attribute         | Description                                              |
> ++===================+==========================================================+
> +| raw               | Raw ADC output value                                     |
> ++-------------------+----------------------------------------------------------+
> +| scale             | Scale factor to convert raw value to voltage             |
> ++-------------------+----------------------------------------------------------+
> +| offset            | Voltage offset                                           |
> ++-------------------+----------------------------------------------------------+
> +| sampling_frequency| Current sampling frequency setting                       |
> ++-------------------+----------------------------------------------------------+
> +
> +--------------------
> +Temperature Sensor
> +--------------------
> +
> ++-------------------+----------------------------------------------------------+
> +| Attribute         | Description                                              |
> ++===================+==========================================================+
> +| raw               | Raw temperature sensor output value                      |
> ++-------------------+----------------------------------------------------------+
> +| scale             | Scale factor to convert raw value to temperature         |
> ++-------------------+----------------------------------------------------------+
> +| offset            | Temperature calibration offset                           |
> ++-------------------+----------------------------------------------------------+
> +
> +--------------------
> +Available Attributes
> +--------------------
> +
> +The following attributes show available configuration options:
> +
> +- sampling_frequency_available: List of supported sampling frequencies
> +- scale_available: List of supported scale factors (based on PGA settings)
> +

One of these days, we should probably write a generic page on the common
attributes raw/scale/offset and somewhat common sampling_frequency/
oversampling_ratio (probably a few more that I'm forgetting). :-)

