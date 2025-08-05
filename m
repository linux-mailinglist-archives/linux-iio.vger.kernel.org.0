Return-Path: <linux-iio+bounces-22313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC1B1B807
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC75A17FFFA
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D7291C17;
	Tue,  5 Aug 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O10D8Nvt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BF277CAB
	for <linux-iio@vger.kernel.org>; Tue,  5 Aug 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410192; cv=none; b=GSyGWcIvxCgbOK5XFyKVkkup25/m5HfUfX3yK0tqlobsN8/ADQ5ZkGbK9AEPa5XzExlfGq7xRIqiHKn+OJgoCEDQJqcEKQy4JDUapltMejXigwq45MsCpDJVRpHXxCp1cg2eZEsv5sxW9SqGMEEha2ALpRlsHECqqGfL5fXjyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410192; c=relaxed/simple;
	bh=IHc1DzoeY8tiIwvdCFRZN/h8qZQ0rCD376YJyYhIoy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDIHALC80CdGOsp2+OQukX08TRELZuXX3U6VFHJ1zFklXKhX4YBke6pg2mPI+9S4Y0PO9v29zItpJ9QxJ/Dnwx4EKRhJCNDElBEdGtv4+2zzne7gLJ3IWme8/c/XWjOfIYJWeDWqjMx3AyKNS2egxUHmDaWtrOyFyliKChq0OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O10D8Nvt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7419f3e5f9dso2272872a34.0
        for <linux-iio@vger.kernel.org>; Tue, 05 Aug 2025 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754410190; x=1755014990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXEKbExyS0skkEXVH+arwCXVHNEEnZbBOs0WtdU8mMM=;
        b=O10D8NvtV1APWaprlrJREoTbe7OyUIQaG3JPIwgNaZhaCSKAD4lK73tnCFDU9kaSzn
         Q7ECKRNaBkXILFqGQKpxpsWGPbxjz5PXdwIJJ6FuSUbZ2BbzpDYHa+FudtK5TkvIbov/
         oShAf0OvP6mb5WSfTVtXO661KOGVrN+eTUxrWf1kN1+fZECtdBiANBKDMb1QhwkmV/G5
         bWWSQPGO9a6f/oPWhNmCNymiPRGUbtUMgSuWqqf4THZyIvRxBiq99OZzDIikgdlFciyN
         BgZdFxLDlVoNixA4XoM5g2TYQfA6E3/wGDbkyC5a0npoSJJ+9DA+WRIhkkNMacSAdSQ5
         J6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410190; x=1755014990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXEKbExyS0skkEXVH+arwCXVHNEEnZbBOs0WtdU8mMM=;
        b=iCbNpjb8AdK3FVpQyF9iPD7hSnq2CMbL4/C+TOm+7U20JcmlIYJKcsV9ZclOd++opu
         yf1bMJIt1Cu+mUs009xURA3k1h8DIprNqufJ+3Cru9cIRE19+sIGQTbtsPvqyVWvUkzi
         TJSdhAZx+7+sbo9vOXdBRc4QFt8ZWqkjuxGs8YD4NGKZlHWw60FYZHmbVru5mRC2TvA6
         P2XN3rUwCudhkQ5wS2ciZ5bsrZgGajpzW/JYeSOUE1VrAPm+pcTJOjukwaZ2zwB738BG
         IFH9vsURPlyna6yMjdhR/bO4zJNFPM9nt1nalDrzx2tl9+mVbBRX+PluAWK7FTCrGldm
         3h2g==
X-Forwarded-Encrypted: i=1; AJvYcCXM+gmGA2x9/fhE1DXrLReT+xe/4NXhTbTqBRHzsqddBvhF4bl36CY8XhR66X5AlCFtHYrruJpIcBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+U9PHCkBCAQM70wqfP5wIo39M50NPghElWfp/Rl+ftiLGX7J
	SstzBIsGycpLiMfRd/a1fnFMQr7+AiBciy3PxDgTF1Lsc6jG0Y/GyYcBjHQlS0Vh0hQ=
X-Gm-Gg: ASbGncv58JG+JeIIaOC4V6CgpJAdFE22nJdGRCL5/yWjqmN4Lch/DT9viAUNUKbCdi/
	dMtjdyt0Woe3SDOavuq3Y6+ZWV4VL4WrOFN6YJCTiqLVpXSuWl3BUBc6nnbhK6MjKLM8D4NDgEK
	mrQ4C9Vkj+owjbONsweDLWXN2wTD+4Ymoc/1iimM3EjTIO1jOTHcqOW63FQOXhK63z1IsBylilz
	L5EA1hi/4WkSKqZifXnMJVt1HYF+jcOMFeIsnkC4WUk3mGWnXv6glTYTQMbhyRV2zenssKICPBV
	CTL/BNyrpTCldpFzC/fmNeLa/LU8r9WOUZWOGF7zi7gc2Dnp44wQybfH4JZ7QOYHw3YmFG5+5hM
	wu/PxyNuKArCAtWnxtotU/Cb9a5cdD+WpH21rlrm/wNiu4Gl49wJSwvkobbcgnRmM+vHfwugetx
	A=
X-Google-Smtp-Source: AGHT+IH2F+DcIiPyfz1ayoUTlMm/gX386zp+QaPhMr71GueBDVfib/TLyMCam9I3YIFWZpsNGkpCFg==
X-Received: by 2002:a05:6830:3110:b0:741:addc:ec97 with SMTP id 46e09a7af769-741addced43mr7484180a34.13.1754410189887;
        Tue, 05 Aug 2025 09:09:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a? ([2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74303b9af1dsm117792a34.38.2025.08.05.09.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:09:49 -0700 (PDT)
Message-ID: <1492897c-fe2e-4ac7-8866-595cd8dfaaf0@baylibre.com>
Date: Tue, 5 Aug 2025 11:09:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] iio: adc: ad7476: Simplify scale handling
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 5:07 AM, Matti Vaittinen wrote:
> The ad7476 driver supports variants with different amount of supply
> regulators. On some variants there is only VCC, which is used as a
> reference voltage. Others have separate VREF regulator, and some rely on
> internal VREF. Some have both internal VREF and option to connect
> external one.
> 

...

> +	if (!st->scale_mv)
> +		st->scale_mv = st->chip_info->int_vref_uv / 100;
> +

Shouldn't this be 1000 rather than 100 to go from microvolts to millivolts?

Also, I would just change the chip info to `int_vref_mv` to avoid needing
to do the division at all.

