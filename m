Return-Path: <linux-iio+bounces-23727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A81B448A8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBB3BD08B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49592C11F6;
	Thu,  4 Sep 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rblHqW69"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB501EDA02
	for <linux-iio@vger.kernel.org>; Thu,  4 Sep 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021798; cv=none; b=C0s2ecgsou0Q7L39I5mJ98dkMy6KzgT/PHaIKCq96vKoNaWvq3etGF02hVfv4GqBqj4UoDQHIIFbhYPMiMvzAc6h1gSCDdQkl/5VWHKR1JwP/fRSkwT/AXlVM4pRweTiOOEmLmlk4QzTdjvBvQtOBoWi/OkayGiqTKjO0LnB8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021798; c=relaxed/simple;
	bh=7CzmPfMQy+yfaTvGUJ5I488Q7O3xDmbX1jz1pgUJ5bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UI8JaPyBtOMWiOev6amuLnXw+cr7YlDrtOGDCCETSEVheAqIxoDio14CJARJ8ChKgbZPeuQsLTf7XYPmOPXHRvKgNCgAc/4KRjUvTBNS/NVtw++zAAEmahV4fwfNCq6qgymLnnyeyfzBCPIO3ESRrtrgdAosumqs9s9MihMEZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rblHqW69; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-745a415bf72so458351a34.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Sep 2025 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757021795; x=1757626595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2ksK33O2Gh+zayfz9iUY+WpS0hxyQwgAZC6r3ahBbc=;
        b=rblHqW69LUPEE0IgIzBO57xVsY1DEr8uGx63kQm6tisj1Gub6qdmbvgO01A2VTJ+si
         iYG6PXp1acn3eviDevDMgZ55o01MZsQc9O0jMpgGxR62KW4KVZteOG8e+FqoImWUe8EE
         JdM161uqCeZcmwG/fQMF/Jm6MSpzJlVKoZnvGu2gkQmTx9QcvDdEkLLyarRm/qGwbL/x
         8UP5JbPVUIH5xcXvbedDaa25VlhrY+Y+0OQZawQmo4HVj0LUoyvBMWrVIIiQiYBxybt/
         cLPgVU0eVmP6dDU+nol+6MdR0IS9XlS4OVjWTi+YjDEZcOxAYvzgMD1G8TrwjiWjTh2x
         Nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757021795; x=1757626595;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2ksK33O2Gh+zayfz9iUY+WpS0hxyQwgAZC6r3ahBbc=;
        b=L7iwzpqj0aZiIKwU02aChusZqb5W5qKdAXXYle96elwMDjQkNBOt4KZYsVAbQj4wT8
         MH2FzYfXY87QaG5vppK3yw9UVt5zqrni83k2ytLQlMd2NJevzKo56zkvbh8AMIXrqDgE
         LoXvG3oGZBXvE9M5HZgWZiVyB8VWWtID4nllpOxQ3FS6u++ucJGhcf+k/fMDQXZ9DQSx
         8ByB+W/AV3Ma6A7lXwcf2ygJ0LFonirDu2jyt3hPvkJPAMSa9dtrndFakflmZmSPVnEy
         3YQbS3p6NDoHMy30xUumDwVLkqx7L5I2j6EsXuxfO/4kcVNNFjVWVLET5o3Y+z8J2z0B
         T3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnMOrcYOF1LXnDK7rFSTgLa6neQIOu1wdA3lQVkoiQghxedLiwgrfblKd8kgOESH3ngASspoxinsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxePghGs7uQgmdQ3RdiHAPmusgVII5Wi2jyAfVzA40cPcCTN8
	lqM9mwn1xsH4hOSeylmQP/S6HRnoxHeWV9gamsRGIVQFCRVKN9YUfT2CxsauHVhT4YE=
X-Gm-Gg: ASbGncvT2lrdMeIIR+2OprzPF25+d6kJ2H4lWud5bK8CDNXNdmS5Uw9+/IBh20X0q+M
	teXQdQElTndBrZkDk1J3VNEdhdkMybbizDSO+6xaHmkVotw3Tvcjef1PsoKLG+80xxj3YURq/en
	UcXBx5SIrVLV5dSYkhbN/fj5YQ2htaP8VK94tsMtRQ3RnULUGQO6sEBGS/itpwSBvXZnSsiz6hw
	rBRS38SOfWEHmIT/3jKOx/Uww+iO6bAQEWLbI23f9LtZ9x5JY/VUa/aGG2uEDjA3orMK+oDls7Z
	ahn1XnzDaSkiqf6Yw7Ec9u8re45qxSIof/MO9/O2xLlZcnv4RMUQhWEnZ0Chaued1FURp0CaIp2
	elEhxB7SvH/7LfdgcYHAIWAeJWZXhkkq41PGHzirsgbdO8OpGWJxJaiQE+m+guTrD4RsFhB72GO
	gszR332ZYXZw==
X-Google-Smtp-Source: AGHT+IEkZaYGqTaVEBhg/NH0XJNUU/u00tkVS5TwqBNVwmkgoIkNoMb3Fp5vF6Y8P21aL8iacPxIWw==
X-Received: by 2002:a05:6830:d83:b0:745:9a08:c9b2 with SMTP id 46e09a7af769-7459a08ced9mr3566127a34.5.1757021795594;
        Thu, 04 Sep 2025 14:36:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745742a5a9bsm3617905a34.11.2025.09.04.14.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 14:36:35 -0700 (PDT)
Message-ID: <88936759-77f5-479c-8cdb-121fc08f068f@baylibre.com>
Date: Thu, 4 Sep 2025 16:36:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7124: fix sample rate for multi-channel
 use
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com>
 <aLnYk6RPePeACmex@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aLnYk6RPePeACmex@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 1:21 PM, Andy Shevchenko wrote:
> On Thu, Sep 04, 2025 at 11:19:56AM -0500, David Lechner wrote:
>> Change how the FS[10:0] field of the FILTER register is calculated to
>> get consistent sample rates when only one channel is enabled vs when
>> multiple channels are enabled in a buffered read.
>>
>> By default, the AD7124 allows larger sampling frequencies when only one
>> channel is enabled. It assumes that you will discard the first sample or
>> so to allow for settling time and then no additional settling time is
>> needed between samples because there is no multiplexing due to only one
>> channel being enabled. The conversion formula to convert between the
>> sampling frequency and the FS[10:0] field is:
>>
>>     fADC = fCLK / (FS[10:0] x 32)
>>
>> which is what the driver has been using.
>>
>> On the other hand, when multiple channels are enabled, there is
>> additional settling time needed when switching between channels so the
>> calculation to convert between becomes:
>>
>>     fADC = fCLK / (FS[10:0] x 32 x (4 + AVG - 1))
>>
>> where AVG depends on the filter type selected and the power mode.
>>
>> The FILTER register has a SINGLE_CYCLE bit that can be set to force the
>> single channel case to use the same timing as the multi-channel case.
>>
>> Before this change, the first formula was always used, so if all of the
>> in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
>> a buffered read with 1 channel enabled would result in the requested
>> sampling frequency of 10 Hz. But when more than one channel was
>> enabled, the actual sampling frequency would be 2.5 Hz per channel,
>> which is 1/4 of the requested frequency.
>>
>> After this change, the SINGLE_CYCLE flag is now always enabled and the
>> multi-channel formula is now always used. This causes the sampling
>> frequency to be consistent regardless of the number of channels enabled.
>>
>> Technically, the sincx+sinc1 filter modes can't currently be selected
>> so there is some temporarily dead code in ad7124_get_avg() until filter
>> support is added.
>>
>> The AD7124_FILTER_FS define is moved while we are touching this to
>> keep the bit fields in descending order to be consistent with the rest
>> of the file.
> 
> ...
> 
>>  	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
>> +		AD7124_FILTER_SINGLE_CYCLE |
>>  		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
> 
> Seems to me that this is not indented correctly, with that in mind I would
> 
> 	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
> 	      FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits) |
> 	      AD7124_FILTER_SINGLE_CYCLE;
> 
> 

All 3 of these lines are being removed in a later patch (haven't sent it to the
mailing list yet). So I will leave this as-is to keep the diff to a minimum.


