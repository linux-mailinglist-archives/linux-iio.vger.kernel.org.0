Return-Path: <linux-iio+bounces-22138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CAB15323
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F4318A2AD0
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D8B251795;
	Tue, 29 Jul 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eWoWvQgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9C24DD00
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753815112; cv=none; b=dtKENhU1jnCInL+1zt0KCAaYUskTkWy2iptTNIZh3GkyQV31eaqH0rvzPxQAQJVVcdAi5Hq4/YoStKfDxLKfR+0JRuWND7lTBH0BkGwxikcBauIBU29fYbz84e0Ku6T+27lK6Ta+3R4POPjNEQp01Kt2bW9cFb1OvlLJOTEdW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753815112; c=relaxed/simple;
	bh=tkYPqG6hSoExZpavosByUWQQZFauHqgD4v+3OLU6+vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RczZEdrA26Cb2t2lwPxoHIV/R2dB+0sm8uPUQmV/tHQXiK6+yH5mBeO8zxBXd3I8ce63Xr5UJUc2Ai02pcg3MdAnaYko0KH1z/dDhARB5lwkiiKlwJSLFJgZEUefzlaoSlEOvjR2ZmnaeUYCwOOX4+TFIkqqKjezKhWxzK0PGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eWoWvQgG; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6195f7f9b67so8136eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753815109; x=1754419909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nW9OX3dqh3cJ18q/aTepV16/WtzibItMr8FPMWEaO5Q=;
        b=eWoWvQgGmSw/LedIqS0RAsjf2f96H6SXm2qrV1E3YImdwNYrC4KL+OaFYJ/ORBlB4Z
         vXJAfpn/Hy6wUJS1fhjg8oziAM1n66uvow67qTii0vibNkggNBug/8UvyZyrOiOZTIsC
         nz3YqjR2hZ+Nm8j3kfpHI4uJw7uJKj1TW1oLIQ5619ERq81Qib8qP/XWUEcVe0GkZ5E7
         s/WUN9SqY5lShafbzTNvaq0vaiUu3aovD9qUnbDe8g/asgURbbYFTa6mDmidKakmnacJ
         PWnH7g9H0PzYBsxihcwfyscBJkiPCHWepWio2ETipmp5ZVaLO1RZZ46bc9SezrH3MEIs
         i9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753815109; x=1754419909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nW9OX3dqh3cJ18q/aTepV16/WtzibItMr8FPMWEaO5Q=;
        b=Rj1dJxhtt6P5Tvql0qe4o4FDym1qLIvsOa0Brbvd+Tpnd8goL6KAPXHhFKheSbfCIK
         WrVLCwUVay+2lFQLJvSLYorgHStbW08D2i+Cf1huFJ4OJqrHztQa4VdlZ9bLxq503zhl
         6tVMjvYyALqUSU/AwxEYYKjxBehtOyI/8739KTAABniZui+uPhibDdt1JbqXy1U3+BL6
         wSkAn1lqDipVUS+XcvS8Qe6Q3l28xHfx2GS8EkjSBocaqScOCDoxE2hMWAHSDuTk4E3K
         snoGoj8rpHrKfdQtahGCfRIrp/S0/uHxbuYaLa2FC9eR1/83MjI7G3G4Xq7fVgop4gCn
         MjQg==
X-Forwarded-Encrypted: i=1; AJvYcCXTmmv5M4fS7ymnyrIm0/SK5bZWJIiDkC4IjWvsLn+p1CHEeVITsUycBi8rvhssi64aqM/ueolXo6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YytplFTZymQmn6g1Xcb0R2CsXzP5dgrZzVGpZ6wXiQrTAcAn9Xg
	G3vAbGFOc+eYk+F+VIvFO3xbjEYLWkLPSjHcyU+ENswkMoHtTnjhmRstFff+3hfscEE=
X-Gm-Gg: ASbGncuvsGyrKt4vNMvsR/IVTh4GOI4dWzm5Mj7vBFpXM7ZIun6wrkUzxxK1sZR2Mgf
	NqnNYD7FcnEE3yMWHP0eRxXQZ5hP4AUDfmtiM23BeuVp+ittxVYXcEKj8ZZYI+uSmIoyttnjgBi
	p8JMBHf+cCxvNZ9bdjVyZCFAjTmYOGBVGP5VNL7etswCa8Q3JtmHFJjGI6iLrqPtLFnB31EDOPH
	F0nGpEBMVv6W1+KWn6rRi87irR/14AS6Me4z+F+y6ZHp4e+2xwELSLtI2uFuI4hn4SN+DipEL5c
	7PkJwdowtnTqzvLo25qAYfPD/11UbpuYIyqTKMOwDJLjO+Tq+kvZ+yFjhwYJOGqIOzS3reuKPSa
	O20S6VuwzLjGzVuoWWDO38OAzotyiu3Ppvn90c+kzNa/u3ZnEjMOZ4A9Nd5VeHZ+SGFsEtdcOdL
	w=
X-Google-Smtp-Source: AGHT+IEk1VUBACKAVfd3nk/GnuDKx7Ws203xpDX0qSmk0ah3tw52EhxFHTI+yXJat0ciadah+dzUgQ==
X-Received: by 2002:a05:6808:2393:b0:40b:3530:98bb with SMTP id 5614622812f47-43199d7a01cmr506635b6e.9.1753815109508;
        Tue, 29 Jul 2025 11:51:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7b843b74sm1634782b6e.16.2025.07.29.11.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 11:51:49 -0700 (PDT)
Message-ID: <f5b46109-ad53-4d03-937e-ac4fc868755f@baylibre.com>
Date: Tue, 29 Jul 2025 13:51:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
 <20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
 <141967ee-22f4-4b15-a8da-e8cef25828b4@baylibre.com> <aIg_SClXq0pO69iH@dixit>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aIg_SClXq0pO69iH@dixit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/25 10:26 PM, Dixit Parmar wrote:

...

>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		switch (chan->type) {
>>> +		case IIO_MAGN:
>>> +			/*
>>> +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 µT)
>>> +			 * Expressed as fractional: 98/10 = 9.8 µT.
>>> +			 */
>>> +			*val = 98;
>>> +			*val2 = 10;
>> We use SI units, so this needs to be gauss, not tesela.
>>
> Sure, Is there any documentation/reference this details are mentioned?
>>> +			return IIO_VAL_FRACTIONAL;


Most of the sysfs attribute documentation is in 
Documentation/ABI/testing/sysfs-bus-iio. Specifically for this
case, it says:


What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_raw
KernelVersion:	2.6.35
Contact:	linux-iio@vger.kernel.org
Description:
		Magnetic field along axis x, y or z (may be arbitrarily
		assigned).  Data converted by application of offset
		then scale to Gauss.

