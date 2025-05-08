Return-Path: <linux-iio+bounces-19306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B6AAFC0B
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B814E1BC5969
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099C422D4DF;
	Thu,  8 May 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojI6nTSz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407A1E5215
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746712259; cv=none; b=q70piFwC8QpjfMl0epsayBVD5PQuV1+IoFunSpwrcehmrmyILEQpbEM1KbCItGflNOwApz8OVMuanVPyn1kVoag7/WfS9boh161MVXpxk5kvUPbPZBVP3u1V1ZB4cBhe6eVvDcAgpymKFegIe+Vz7SshtzhsHkFwZ1OiF6R6IKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746712259; c=relaxed/simple;
	bh=lJyOeEHegvLhoKBd+hxBA2/76N09zRsPJWC0/e4pNcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVky1pfis03sbYCFALMVDLVYvi4SUGZttPl688qD4WuheityKfacNPi8CNL6wHBGpQMOK4e1hrL1nE+Ve8eFglUf41CSrFpapiAeuzINu8i4G2qQleFW3cj77a80dBsEhpYd+gTUarBlfSed1SjppNr3CgivzxIxiY7cjm89v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojI6nTSz; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f94b7bd964so934962b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746712257; x=1747317057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouj0qfvFepL9kOLcYrh4tsGA66IJWwOPF0qOB3iRvnM=;
        b=ojI6nTSzB0FAs45s8pBE4cuCm4RNFUzDbu6brVJPpeCqTiK1rHpJMug416boPAsCBp
         T8cj653RqLyjvVhcF0HQp+UkFGlaQdPCdV6XwR7aIl1LH1M0y7Kj1x9GDbzu3NBEoikJ
         5zC5y32kaQH32kEk0RvxfRGYhL6ncUqoPbvs7YH9jmjHl4FNeTY+ithJvc3GQjJhcmMN
         hlLrtIsq2lh9/8y7T3nlQcqPGkMavbhSM1f0oy0Fx77dcgEohn8GbEQe5ks6e4A+T0/w
         xmi28YkRmKPVMAT9ERHaoGqjsbAef7U0UfYbXJ3V0HCYmiKa0fmcB92PmahuOHlSl/TJ
         LCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746712257; x=1747317057;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouj0qfvFepL9kOLcYrh4tsGA66IJWwOPF0qOB3iRvnM=;
        b=nanQzqGH66DPyLPSbdYzAdwwqkIX/898dqxPcDAk8wifGPKZi6xQkm/DVPSe4CwNZb
         WRot8MM7EpqTtahsd4HsqlDydv85SOFCGo70uL4IpKG9nEs16MePb7P2+rQtT9UUQTb5
         L1d86iUm+GmqO1zrfRMRu5CUTgZWeHkV80iGjdPS7Hjm5Q8IPuXyZPJs5mynHRoZCTTa
         SsNxbOlDnqyZ4TjYa8NRmwG3ptfe5Zi0IVDGPcxwfbjtH/dXNnz97ZGbbSnwRhBNt5jZ
         HsBZFXHVg0/3M7F5lKgHnicBTOGmDvLWTrPp4Wm4DcHZsYS6cHrxzKPZCRdJpBrDrckF
         EIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSCCCkLcM2dNfZyacztNoa57NSOeqyWjGVNNW3H81ke6DRxSN6tZQDeJFmZsv+ZCyFMQ/bkHiQjMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Qb0JVBsV3hsD6qiXd6OLav8HUbY0oxCfyNovq737ovYOYUjt
	JZcucw5aRkCeZp6Khw7clOxPUp7dRkMEAHXGilVxsBN70yFBvvFR8MeAgIgYC+I=
X-Gm-Gg: ASbGncuXRDQynwUnAnwXVyKHJt9N9vxQ3lJsWqzqnOsUKyf6641re9Pus4RqixsBNSj
	9zw7gai487maQAVNlkvtNDZu3Fnm07aMICCsevHOpmC/t48BKwHAoF1Rssv/VOoB8wk89xtm/wn
	ZYATMQnTCvFBnmrnvGMmrPhpgZz4kqjHz4F6GQue1ZFG37dXDq+jsafFxO7VIbNxuo4x48FdHiB
	2KH2bfZdvlERiaO2aeUmyXEIJeBKahdyRf+wl61vEgLFOjmMD0Xz75nw5IZoXVtKB0fagtAVpo3
	csQiWc1Gm4CjF/ANInlznxJdPi95zVcxR1nmFAVkbwdOLezl1fa2p5oyANVtaLqTV1nSVVeLDs3
	DFeE3GYzm4D/J7RbHig==
X-Google-Smtp-Source: AGHT+IHCPN64NvcV87IbwF3LkvQkpqFNuSONFbX3+kLtH8kqD7JwExKv4iDlgXtZ/SWM+8ccZ3oj8w==
X-Received: by 2002:a05:6808:6f96:b0:403:371d:e56b with SMTP id 5614622812f47-40377f88f0dmr2261392b6e.32.1746712257128;
        Thu, 08 May 2025 06:50:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4036f3406fbsm1247028b6e.22.2025.05.08.06.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 06:50:56 -0700 (PDT)
Message-ID: <7f5f75c1-7750-4966-9362-2a46c5e5ba3e@baylibre.com>
Date: Thu, 8 May 2025 08:50:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
 <20250506-wip-bl-ad7606-calibration-v3-5-6eb7b6e72307@baylibre.com>
 <c999800bb5f6c1f2687ff9b257079dcf719dd084.camel@gmail.com>
 <qaiqdak4pieewavl2ff4mpr2ywhw2bvnoob55buiinkisacar5@q6jhlb5klcf6>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <qaiqdak4pieewavl2ff4mpr2ywhw2bvnoob55buiinkisacar5@q6jhlb5klcf6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/8/25 4:16 AM, Angelo Dureghello wrote:
> Hi all,
> On 07.05.2025 07:14, Nuno Sá wrote:
>> On Tue, 2025-05-06 at 23:03 +0200, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>

...

>>> +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev,
>>> +					struct iio_chan_spec *chan)
>>> +{
>>> +	struct ad7606_state *st = iio_priv(indio_dev);
>>> +	unsigned int num_channels = st->chip_info->num_adc_channels;
>>> +	struct device *dev = st->dev;
>>> +	int ret;
>>> +
>>> +	device_for_each_child_node_scoped(dev, child) {
>>> +		u32 reg, r_gain;
>>> +
> 
> working on further features, i noticed this function is called
> for each channel, that is not correct, so need to fix this,
> will send a v4.

Why is this not correct? Each input could have an amplifier with different
series resistor value so this seems correct to me.

> 
> Regards,
> angelo
> 
>>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		/* channel number (here) is from 1 to num_channels */
>>> +		if (reg < 1 || reg > num_channels) {
>>> +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
>>> +			continue;
>>> +		}
>>> +
>>
>> Sorry Angelo, just realized this now. Any reason for not treating the above as a real
>> invalid argument? It's minor and not a big deal but odd enough...
>>
>> - Nuno Sá
>>
>>> +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
>>> +					       &r_gain);
>>> +		if (ret == -EINVAL)
>>> +			/* Keep the default register value. */
>>> +			continue;
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (r_gain > AD7606_CALIB_GAIN_MAX)
>>> +			return dev_err_probe(st->dev, -EINVAL,
>>> +					     "wrong gain calibration value.");
>>> +
>>> +		/* Chan reg is 1-based index. */
>>> +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
>>> +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +

