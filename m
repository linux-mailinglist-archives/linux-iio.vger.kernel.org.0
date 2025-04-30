Return-Path: <linux-iio+bounces-18907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B61AA5149
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC0A1C04F3C
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A79262802;
	Wed, 30 Apr 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jRzGVYJV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4925A2CB
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029674; cv=none; b=BxL2k/j/xWWlULVNk+GucyTrzJ1MeStgQCfAl7jWW5xPPDmPievrozbaH7jdi+pQ5/nrCLV8oBAGyKG7afcEzQgW3IIgCqICs9iYZy+cLTYqsbMNbr2jeFapS3Qlnj9qjoDQKsISy0bf7qRan2Czd32hRYG53qlBLWQRDVFb16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029674; c=relaxed/simple;
	bh=Kxa5TrbMk8cQnyYSEkEDzIOulNCQdwC3lUTarSwq244=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thsgo6yD+jWNnl4lae38cHAVME8+YL8q/QBp0K5D9gtF1YvK6ipmoD13aypa5daR4dhWglGG3L8X7zC+90DHXSYpp5M+i34AfRQkwrSpb26xW8LOUh0qnIZnyxfEFPyBr5bUmwMvXnivWUgQP4Cj0h2eSuc8Zec/jC7Ve0AxtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jRzGVYJV; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c172f1de1so4615786a34.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746029671; x=1746634471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FyGIaGBEw+UPtig6v2xIFrKQgtBaHFHeiU2fAQceqg=;
        b=jRzGVYJVZw9Y4KfWDfVhw9jwHtJ3UPTruCUoxnHcqeLO/9siJCLvz0BP6cLDuAuioL
         TaFDGrGnep0Cb5xljGpcsNNHs2G7R70ab1qpQzTZCVNi6L+rkt6M30eb1mrOQNK2TP6f
         Sx+kjYB9IpUHZMaaQxfJ7hoFXgqGNhrail9/k1I4icG8lcGW+Nx2UEzgLpU4EPGpgLwb
         bhDl/cgYtJF7KtpdaQ0JOsspX1CMQJ3eJZ7ojD4hT6YgJHXy/enkPJPCvsRMQcGkvXHl
         ksUGpms3y9N6u0TS8g6mTckiPr0QwOZVe64Pmh76grZm53hpKBM/IRamJ6mPyDb4+TIJ
         jwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029671; x=1746634471;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FyGIaGBEw+UPtig6v2xIFrKQgtBaHFHeiU2fAQceqg=;
        b=WNEDjLdbfYxseFmkGEa7J5jJhQKpHfLazekL8+Jk8+0f1s6ouKDYCGV/FX5vBmTeas
         OZOSErqtg1hlFzK9Dbw8EpyKAqj80cOcoOMxGXW1vNS9OMFZUKE62aav8maRLKVYy3oF
         /x9P2ahKGs6GbeylBFGaOS2M3Vakc/1yBeYvSwGYm5sfHVAHs7ob/1NaBuMo6Nu3JVjH
         RY6PnpAhqHZfhOe7tV+Eqg1ve64C8sUSOkelyWi/bJOvx8s3xC2CPEVuJPIPwaHaFu7D
         5iLyf7Q9lnw2eIGTnlWV9oNGJHW1lyMawq6RXBHzmmBu7STMkWfIfWCzAODwKTrV9iO+
         +bSg==
X-Gm-Message-State: AOJu0Yxd/nFj/5LhdOcpwAGtZsfxlu1Kr6hv+IMLjmvCeaHZLXWBNvfo
	oU/0W/Er3rIDXXsxfVCCTir8XoGIArZAl4e+7AMBuGVcGhWenP47y/hkvXkW99g=
X-Gm-Gg: ASbGncv5QFHj6+wZiidxed4NR7FbdxBvp+zx+zI2Xt5hmGPuIyDkRObij5znLnD1Sgv
	G2Ap7cQL22jW5TTvAeX8QAr2VeE2XhKwkGXihziO7UVGb31b/Ko3M931TozTcIvOAAfZ6KH5MeQ
	Jg+fX/Zub8zooLuRoPy8CpCHTUzfhKE6oyp24DqWM/bcPb/OVXvwm+jbDX6PFUoiVdrT+H2tuB4
	7TNXBju1mbYHbd/mG6ZRlNA+0zF/5yBRUrmG7kkk+eZ9IPB0WFemcHFGMvv56m7Qfe3aBHZAEnw
	PmUSxQdvSU7XK2iWeyKqkBpdRU4DiWfTWyaFPeUYWbn3erjTy2yocSpxwIK3q4wzgIMdsetjuII
	OT/oCp6UhAJfb0V0=
X-Google-Smtp-Source: AGHT+IHp04MZ7CRXwXM9dWLEKyOrxJqAlVfMAqGQuVTd6bwNrFBUZvRBm/0NddDjTQACxj8asi04FQ==
X-Received: by 2002:a05:6830:6688:b0:72b:87bd:ad49 with SMTP id 46e09a7af769-731c09e5867mr2243162a34.6.1746029671146;
        Wed, 30 Apr 2025 09:14:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7308b131071sm936548a34.32.2025.04.30.09.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:14:30 -0700 (PDT)
Message-ID: <9c02b2bd-dabf-4818-8adf-83c9127946d1@baylibre.com>
Date: Wed, 30 Apr 2025 11:14:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
 <d273fa78cb3986da5249bd800dd25c4c0bcfde7e.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <d273fa78cb3986da5249bd800dd25c4c0bcfde7e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/30/25 10:36 AM, Nuno Sá wrote:
> On Tue, 2025-04-29 at 15:06 +0200, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add support for offset and phase calibration, only for
>> devices that support software mode, that are:
>>
>> ad7606b
>> ad7606c-16
>> ad7606c-18
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>  drivers/iio/adc/ad7606.c | 160
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/iio/adc/ad7606.h |   9 +++
>>  2 files changed, 169 insertions(+)
>>
>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>> index
>> ad5e6b5e1d5d2edc7f8ac7ed9a8a4e6e43827b85..ec063dd4a67eb94610c41c473e2d8040c919
>> 74cf 100644
>> --- a/drivers/iio/adc/ad7606.c
>> +++ b/drivers/iio/adc/ad7606.c
>> @@ -95,6 +95,22 @@ static const unsigned int ad7616_oversampling_avail[8] = {
>>  	1, 2, 4, 8, 16, 32, 64, 128,
>>  };
>>  
>> +static const int ad7606_calib_offset_avail[3] = {
>> +	-128, 1, 127,
>> +};
>> +
>> +static const int ad7606c_18bit_calib_offset_avail[3] = {
>> +	-512, 4, 511,
>> +};
> 
> From the DS, it seems this is 508?
> 
>> +
>> +static const int ad7606b_calib_phase_avail[][2] = {
>> +	{ 0, 0 }, { 0, 1250 }, { 0, 318750 },
>> +};
>> +
>> +static const int ad7606c_calib_phase_avail[][2] = {
>> +	{ 0, 0 }, { 0, 1000 }, { 0, 255000 },
>> +};
>> +
>>  static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
>>  					  struct iio_chan_spec *chan);
>>  static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
>> @@ -164,6 +180,8 @@ const struct ad7606_chip_info ad7606b_info = {
>>  	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
>>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>>  	.offload_storagebits = 32,
>> +	.calib_offset_avail = ad7606_calib_offset_avail,
>> +	.calib_phase_avail = ad7606b_calib_phase_avail,
>>  };
>>  EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
>>  
>> @@ -177,6 +195,8 @@ const struct ad7606_chip_info ad7606c_16_info = {
>>  	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
>>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>>  	.offload_storagebits = 32,
>> +	.calib_offset_avail = ad7606_calib_offset_avail,
>> +	.calib_phase_avail = ad7606c_calib_phase_avail,
>>  };
>>  EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
>>  
>> @@ -226,6 +246,8 @@ const struct ad7606_chip_info ad7606c_18_info = {
>>  	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
>>  	.sw_setup_cb = ad7606b_sw_mode_setup,
>>  	.offload_storagebits = 32,
>> +	.calib_offset_avail = ad7606c_18bit_calib_offset_avail,
>> +	.calib_phase_avail = ad7606c_calib_phase_avail,
>>  };
>>  EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
>>  
>> @@ -683,6 +705,40 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev,
>> unsigned int ch,
>>  	return ret;
>>  }
>>  
>> +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
>> +{
>> +	int ret;
>> +
>> +	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = st->chip_info->calib_offset_avail[0] +
>> +		ret * st->chip_info->calib_offset_avail[1];
>> +
>> +	return 0;
>> +}
>> +
>> +static int ad7606_get_calib_phase(struct ad7606_state *st, int ch, int *val,
>> +				  int *val2)
>> +{
>> +	int ret;
>> +
>> +	ret = st->bops->reg_read(st, AD7606_CALIB_PHASE(ch));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = 0;
>> +
>> +	/*
>> +	 * ad7606b: phase delay from 0 to 318.75 μs in steps of 1.25 μs.
>> +	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
>> +	 */
>> +	*val2 = ret * st->chip_info->calib_phase_avail[1][1];
>> +
>> +	return 0;
>> +}
>> +
>>  static int ad7606_read_raw(struct iio_dev *indio_dev,
>>  			   struct iio_chan_spec const *chan,
>>  			   int *val,
>> @@ -717,6 +773,22 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>>  		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
>>  		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
>> cnvst_pwm_state.period);
>>  		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_CALIBBIAS:
>> +		if (!iio_device_claim_direct(indio_dev))
>> +			return -EBUSY;
>> +		ret = ad7606_get_calib_offset(st, chan->scan_index, val);
>> +		iio_device_release_direct(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_CALIBPHASE_DELAY:
>> +		if (!iio_device_claim_direct(indio_dev))
>> +			return -EBUSY;
>> +		ret = ad7606_get_calib_phase(st, chan->scan_index, val,
>> val2);
>> +		iio_device_release_direct(indio_dev);
>> +		if (ret)
>> +			return ret;
>> +		return IIO_VAL_INT_PLUS_NANO;
>>  	}
>>  	return -EINVAL;
>>  }
>> @@ -767,6 +839,64 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev,
>> int val)
>>  	return 0;
>>  }
>>  
>> +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
>> +{
>> +	int start_val, step_val, stop_val;
>> +
>> +	start_val = st->chip_info->calib_offset_avail[0];
>> +	step_val = st->chip_info->calib_offset_avail[1];
>> +	stop_val = st->chip_info->calib_offset_avail[2];
>> +
>> +	if (val < start_val || val > stop_val)
>> +		return -EINVAL;
>> +
>> +	val += start_val;
> 
> Shouldn't this be val -= start_val?
> 
> I also don't think we have any strict rules in the ABI for units for these kind
> of interfaces so using "raw" values is easier. But FWIW, I think we could have
> this in mv (would naturally depend on scale) 
> 
> - Nuno Sá
> 

From testing, it seems to be working as expected for me, so I think this is
correct. The register value is not signed. 0x80 is no offset.

Also, I like having the scaling so that the units are the same LSB as the raw
value like it is now. It makes calibration easy since I can generate a constant
voltage and do a buffered read. Then I can take the average of all samples and
see how it compares to the expected value. Then take the difference and that is
the exact value to enter into the attribute. Millivolts would work to but that
requires applying the scale to the average of the raw values to get the number
that you would need to enter into the calibration attribute.

