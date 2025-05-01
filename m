Return-Path: <linux-iio+bounces-18938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A354DAA5FF0
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADE71739D2
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E471F1512;
	Thu,  1 May 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nHy1WXgv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA529CE6
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109575; cv=none; b=X4Cpzz6DAp/6Fx/PtwrdlL/xw9a2qsMA0C/r/17MO0O5zpzwlyb/q8wVMH2CEfvvJxCfLjDCvNPKyoyqGRcqruWwRX7LdXJZ1wxwV23sJ/fgyv73mcllH9L0YUNgEwXy4l8Z/vq6evptd3McAxo6UzwXtxM1DC5bi0xTZivpAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109575; c=relaxed/simple;
	bh=cMiSL+srh90WM/27nWsSVcw0BuDExmla9t7TYq0svc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V89dRvYLNLAMrSY4yZVQqVux23zOYzdic2/59KO4GdrTEf2dujKsjpMi3uS9VimTnBDbDCKEZwRlHIsxjmDViuRNxEjiznJX52wyhoC1kyv24WPBgQV4a3EbXVSa3WR7GBumiBmTCFWXIAemkywVvHI/aCfpHYCl4aeGXvwRutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nHy1WXgv; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7306482f958so646788a34.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746109573; x=1746714373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7i2ULSj+LVkwecy8lD/K2BewHP33IPiW3Jt5i3dqKI=;
        b=nHy1WXgvFNPHuVpfF9MEWBnP7k9atD5aPE7/Oh8vjX7ziNiEsbci/BaW3P9NWzzu1y
         ANtvU6g4Rrj8wnlR7X/zfDaVPCA8KIhW7DNkwTBF1ZqLR2KQr8RYyBr789OI7nvc+UXX
         I9VzfaR3IQXxAT5gHVEE0t//gEKVLOGuDP0gUZpOjArWhbxkv7vdo0DX30o50EYdM3oE
         dT1BTLGsG72fVEyMp4LszztRpOx7bOKt9NUI//Hi3A8mB19nHRnuY2HHMVXu9ZH31FXe
         xCVZz8fvZd9dlucpL/94y99M6IlJ9lX3Vsk3qlJwimej/LjHE2auiC08QeKI9a2dShNH
         MqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109573; x=1746714373;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7i2ULSj+LVkwecy8lD/K2BewHP33IPiW3Jt5i3dqKI=;
        b=KQqrXpB7O3HvUs4gAdNrrqTt4SG5g+6DpuUl7JWsbZCiuznHQkWBIcEYzqFjySsiNM
         qAclFnUnCiihtsETRoNpd2QyGlSjmoGZxLuyV0mX4wE+HAPEoqexImKy1C3hDPVgTE8w
         LzOQvMBPedLdySKG7Etxd7ACcvCGx61yP4I4yWNyrKjbXgrbEtB9ZIbvsup6vOWlbLMt
         PnCid1kIGdptMizu4ys4R4CnUxhZjnMCd3eoGUzG+xRjQSJ8vHlvb7fEblLj8+EK85MO
         1CPHk+eMMLTR+VXyphEeuMl1bTqqhQ7IN2hqtW90BAEHuZQeFh1UC28MEhEfJuxxMVrW
         ON/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOylDk6ASSdyGWu8b66NPbdxni2bFwR+PY0KoEdWmO3s+nBgYLbRi0qyOS7lsgxZ7R8tK0Vy2HTZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnr9ltHcz3w2d00VZU9/SH+6qbQQT7WbmNtsELZiQ/ZskxfL6
	2+MlLYk2PuSGSEprLkiP1Y0RhX1NqUQdxECnvyN0DLPyQZBrLAfozylW9/exhp0=
X-Gm-Gg: ASbGncuJCm+yYGLSHrqrRgCrka5pyYHREqzYmO1BwafsHdOjqQZ0u0wOvIIvR82CndU
	iw3cxxBUwbwtsEf4vuoEvAEkJaqXkisMZG9ATYEyc7t6UCsn8YymKaJpY/YZcUKXRHecwfCBi3P
	NRHF/cwUpekC+k59uQdrzsMaJFwLq21Jrh36RxeiRhK+OVdlI2bH+oB8rz0YOAj04Na203O4wLd
	mmiXBlWP38ZG84wxZ/8sbuv+5kMOeRdGEcefObpdcR/LNDIb48/chk07W6zKRNgNjMMtkySf95A
	zvUMecBXjlsL04FzOoCtFoGaX0/xyk35roi9Zcj5kSDD7mJXjSnfptA2EmdaZZOY3/oiomId9Uv
	Erap4tmtMdDL9xmMZWw==
X-Google-Smtp-Source: AGHT+IFd//jznhdxbWQ/ASqwqpXHLpIa55fPVl9ukRjj9Frcfs8XBwPmLkE5fNhS4f+jgFRHBFtmuQ==
X-Received: by 2002:a05:6830:4990:b0:72b:7e3c:7284 with SMTP id 46e09a7af769-731c257c6b7mr3717143a34.18.1746109573152;
        Thu, 01 May 2025 07:26:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0? ([2600:8803:e7e4:1d00:b1ed:e5d7:8ea6:40e0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d350a41fsm116684a34.65.2025.05.01.07.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 07:26:12 -0700 (PDT)
Message-ID: <60986dd1-e03c-47f7-980c-879a5ecf7c44@baylibre.com>
Date: Thu, 1 May 2025 09:26:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
 <0677db3c-9c36-4f34-93c0-5c53d702c4bd@baylibre.com>
 <y6hss7bo25hiwzzplbbhmdodpmqbgpkarqvemn3tn3fig26tb2@753sxtygndaz>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <y6hss7bo25hiwzzplbbhmdodpmqbgpkarqvemn3tn3fig26tb2@753sxtygndaz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 8:35 AM, Angelo Dureghello wrote:
> On 29.04.2025 17:46, David Lechner wrote:
>> On 4/29/25 8:06 AM, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>
>> ...
>>
>>> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
>>> +					struct iio_chan_spec *chan)
>>> +{
>>> +	struct ad7606_state *st = iio_priv(indio_dev);
>>> +	unsigned int num_channels = st->chip_info->num_adc_channels;
>>> +	struct device *dev = st->dev;
>>> +	int ret;
>>> +
>>> +	device_for_each_child_node_scoped(dev, child) {
>>> +		int reg, r_gain;
>>> +
>>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		/* channel number (here) is from 1 to num_channels */
>>> +		if (reg < 1 || reg > num_channels) {
>>> +			dev_warn(dev, "invalid ch number (ignoring): %d\n", reg);
>>> +			continue;
>>> +		}
>>> +
>>> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
>>> +					       &r_gain);
>>
>> Instead of...
>>
>>> +		if (ret)
>>> +			return ret;
>>
>> ... we need:
>>
>> 		if (ret == -EINVAL)
>> 			r_gain = 0;
>> 		else if (ret)
>> 			return ret;
>>
>> Otherwise driver fails to probe if adi,rfilter-ohms is missing.
>>
> 
> Correct, i changed this before sending and could not catch it.
> But not totally sure of applying a 0.
> We are here after chip reset. So conceptually, would not apply any default,
> ince it is already set after reset. What about:
> 
> 		if (ret == -EINVAL)
> 			contnue;
> 		else if (ret)
> 			return ret;

Sure. A comment could help here and the continue makes else not needed.



 		if (ret == -EINVAL)
			/* Keep the default register value. */
 			contnue;
 		if (ret)
 			return ret;

>  
>>> +
>>> +		if (r_gain < AD7606_CALIB_GAIN_MIN ||
>>> +		    r_gain > AD7606_CALIB_GAIN_MAX)
>>> +			return -EINVAL;
>>> +
>>
>> Also, return dev_err_probe() on the returns above would have made debugging
>> easier.
>>
> ack
> 
>>> +		/* Chan reg is 1-based index. */
>>> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
>>> +					  r_gain / AD7606_CALIB_GAIN_STEP);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +


