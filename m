Return-Path: <linux-iio+bounces-8653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54295A286
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375791F218C8
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780C14E2F9;
	Wed, 21 Aug 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aE8WUzzL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC6313AA2F
	for <linux-iio@vger.kernel.org>; Wed, 21 Aug 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256738; cv=none; b=rKVEyJWtxxMIUWrGsq3gfqFhE4rwFfCQT/hsIzFnOvrcSYseHdmDz++o2Sx3aemTDxsvIHFPyagZjF/yzFMJ49dkoPGiVdvmdXmteaNm+EheBnn0waJh7qbkyipXIN6syAoNPhAPFIjNWBJK0ZFa05Yuo1XP8Gxoz3zAjhQMoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256738; c=relaxed/simple;
	bh=GiHkNbhAoNVAwuHFl3bjnZEwOJGblxOioBGhme1Nht0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvXVFON8oXi7SawtB1kJ7k6xqnXKuBJPRcc9SMF7qM4l6FJGNZlWTivqAkANXqZoIluILwEPl+30NcwVKmED8ATCM2L1fX2TYEWARBVDWlC40htITgYxXL0GX9iCHzbWuNUapyBVTiGXRopLHC3JsK4Of4bH/9hXzzsPhPsnkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aE8WUzzL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2701824beeeso3619754fac.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Aug 2024 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724256733; x=1724861533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnfDZ37Jifa/aayYZd2s3k/LSyC3W6b7TK8bqHxO3SQ=;
        b=aE8WUzzLwhr4mZrAcyhrC79qNen828OPYs6nMILrqL98r78r/TqSYy2fAjI52j1aY+
         8Bekx/66mCxy1QclN8dA9Z+eGpggxFiYuI4sbHMHDHiBkDxodf1ugGrt8Lnr26BnH73i
         mjK9BmIivrmTSGBoo6fVm7jwH8oWvl/v7eCSvvYEVzXgUTneVgCnJUAEYIZROJFWvyoq
         nsJ96gI2TnvtL/Vvzx2sx4GBOkcPUcQS900o6l+47t/w/p2To8+/bMFbDLXz2i58Y+kF
         XH51t8/QXqsp7OOYe0SxBfiDSWgblb6tf/9mxY/37Mq1zOzQBoxml9ofo0TBVmsZouJa
         sprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256733; x=1724861533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnfDZ37Jifa/aayYZd2s3k/LSyC3W6b7TK8bqHxO3SQ=;
        b=xKSeNSwKVDmHNCvWI2S7VfxZiqg1x8ZqH3HdFcA4StABcGWZcqyb1dR7zwqellqujW
         z8NYZscHdhWLe7tG6RJT/CNGmm+sO/tki3xkDsFsB4+3Iqs/EjZOMgYNKdVorWVJFnWG
         Xg1zAxJjjuUTyuMbQKel5h5BKPeBheM7FJEaf6wNNQ4jBqYqWHj5Cj64eXu5J7eN6pwn
         tBEgNXqHoAYV8moa5A2bRVzhpOGzJ3/rLgY0UVPFZcMCUqN8nDITToBdEQg8d7+ok8CD
         WG5iNdK8Ef6O3ZAPrfIzR11elLsZ8LthRTTgHn37JSdf6uu91UWa8W3WVHo5OINFewgc
         Crog==
X-Forwarded-Encrypted: i=1; AJvYcCWt17prlpGHF+LwmwXWTpgbeDbTlIdOBz1Ox1X4YktzjXAd6dGsjqQTNl50mjw6b/GdEb1s1CxPsxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjG8JHO6tqtYWQrWCUOPyh8YOgOo0tfieuc4K6mh7V055KJ1V3
	+INm6S4uHJ6v8ZBfHwgAR70EdnLcj7ijWTdVCQEFXFnGGjhLPLikFcsBBzYGEhg=
X-Google-Smtp-Source: AGHT+IGFDPVYkCbpqjpATt6tyqSHN4Ch0InX07LFuFMroYF8geSstXUWO3pXzq89fAfkr9NGLRJbFA==
X-Received: by 2002:a05:6870:a449:b0:261:6c0:8a2a with SMTP id 586e51a60fabf-2737ef038admr2662265fac.20.1724256733589;
        Wed, 21 Aug 2024 09:12:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-270049bb39bsm4305550fac.41.2024.08.21.09.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 09:12:13 -0700 (PDT)
Message-ID: <e2401290-5504-4a17-93bd-af8684a82a7a@baylibre.com>
Date: Wed, 21 Aug 2024 11:12:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: adc: ad4695: implement calibration support
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
 <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
 <20240821141615.00006ebe@Huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240821141615.00006ebe@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 8:16 AM, Jonathan Cameron wrote:
> On Tue, 20 Aug 2024 10:58:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> The AD4695 has a calibration feature that allows the user to compensate
>> for variations in the analog front end. This implements this feature in
>> the driver using the standard `calibgain` and `calibbias` attributes.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
> 
> Whilst some of the messy value manipulation is unavoidable
> (oh for signed integer zero!), I wonder if we can at least
> move one case into the core.
> 
> See below.
> 
>> +
>> +static int ad4695_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ad4695_state *st = iio_priv(indio_dev);
>> +	unsigned int reg_val;
>> +	int ret;
>> +
>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>> +		switch (mask) {
>> +		case IIO_CHAN_INFO_CALIBSCALE:
>> +			switch (chan->type) {
>> +			case IIO_VOLTAGE:
>> +				if (val < 0 || val2 < 0)
>> +					reg_val = 0;
>> +				else if (val > 1)
>> +					reg_val = U16_MAX;
>> +				else
>> +					reg_val = (val * (1 << 16) +
>> +						   mul_u64_u32_div(val2, 1 << 16,
>> +								   MICRO)) / 2;
> Maybe worth extending iio_write_channel_info() to handle
> IIO_VAL_FRACTIONAL_LOG2()?
> It'll look much like this and you'll need to provide write_raw_get_fmt()
> so the core know what to do with the value formatting.
> 
> I don't really like the mixture here between the read path being able
> to rely on the core code to deal with the /2^X and the write path not.

Sounds like a good idea to me.

It seems like we would need to add an extra out parameter to 
write_raw_get_fmt to say what we want the X in 2^X to be. For
example, we would want to make sure the val2 we get in write_raw
for this driver is 15.

>> +
>> +				return regmap_write(st->regmap16,
>> +					AD4695_REG_GAIN_IN(chan->scan_index),
>> +					reg_val);
>> +			default:
>> +				return -EINVAL;
> 
> 
> 


