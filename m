Return-Path: <linux-iio+bounces-27932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276CD399C4
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7BE3007D91
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 20:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04D2F533E;
	Sun, 18 Jan 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fyXTbG4s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D750096D
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768768406; cv=none; b=Z24l9x1g8mzeuRMe4A6H2LJ8Uic7SckFkD4OIN83Is5Aj1n4cGBfDOBr+a8pzqNdEsLHZZ5TewRkVBKmRDgR7OjaiRQK5DVVtEzEC1B2aW1+hyc88C+oIKMh/vjJ5Ovc3QX9I2T+ZEFRMuSBvv8dpLFyrIyzn7Nrz/P4H8yeH1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768768406; c=relaxed/simple;
	bh=aEvzWJbMT8Ptmsy9HlfjCiHCeplMxGKJq9qtbbuYkM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7LZgvrUqozcly7OLk3UKi/NZy+9hkYMNKEmVt2kYhq1uPOskWYPWSn7Y2Q9lrDRg2PBc+FRg+T3He7ESNx5j9VPw/duhkPk+smN8WHKeERmH0xhsKHX8PHd1Qb7DGGsliinTSH+iwLJkk691iIkfADX0Eyt/gF5S3yqmh3ZLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fyXTbG4s; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c87d82bd2so2597396b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 12:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768768402; x=1769373202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPH+taeAKn5LL6n6jgYLFIek/YNyqbS4BtS3n56/e7A=;
        b=fyXTbG4ss/qd0CNnnwFJ5XqRDgh5ad9bKQJ9Qiq/DILpyT44BBPEhD0oaqKv1+zAPu
         F9248O5wsR+uoPI4CHkxBPWwjkTUvWC4Q/L98wRW3S+RuYBf3txRIt1QlGjPMMwPH7R4
         WJwUaa+eduMeslbPkw3JCjc71qT1ICpw1bihro6YHNVEby8zVcFyKx09FhQuh+2QHEej
         rPlI7sJrfKdthW+LDq2TBVZiCz8rPvrNCcjTf9csozg9DNecyFp/S1QdW/vLshfelyQu
         8M+gefqwazsqVkgOstLTnUjmllhwDzunApiBxZSD6oMwobQaadzSoScUCYX5Ykzd4J9o
         6IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768768402; x=1769373202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPH+taeAKn5LL6n6jgYLFIek/YNyqbS4BtS3n56/e7A=;
        b=e4GhX3GBlIJ41UOkMF1Ooy8iOVF9Gytv8MORh+rro6o3dVzUrbISsDl4MlNEJ0lEzk
         9ZHaISyLZza7lIeqBiH//yFkKTVEMU08IiJR5vsgR6xfSSeysDBIAkXYw8zN2fgYBQFO
         RKBYrYmfUprex2Y5w1Ol/UfoPZ9/HC404FJ+ps6pQ8rtSNwi/dl8Ub3N1B22gGeEH2E0
         IaxCL/qJJpkrlHzUxTE0UlAzKyzGfdDM6x3KHz1kQCIyzLMdBydbuSOIFXFYXFKisuw7
         aITvBQJN0G9CXgjveV18I86BZVxnJdw0fgeJ/5qSrRRtNZBbxGFg5y5qyixh3XjSr9L6
         LWcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwt9yGRwf9R2pLb/3hGblVD2mB5+WqwZpSA3uklCaY9zypBj6D2AekqCfvV+x996MvXfHGT/ljTE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGg8qqfUKgmlVwloX9tplBSH5ppOydEAV++SU+4Z+HEBUPWWEM
	KQAsSc+mt9ZhCxPR8pC2vqWnyp0BPi3+TaSV5ZVZT3q3khV4vHO7ImmiB8Yk3mmIyt8=
X-Gm-Gg: AY/fxX63w7CplEDMYZjaU4wBiW5f3YT2wbqkteYphRrvHCgyBxgvnWWvvzl9b4CwGz+
	IVq9l4gKYWV/3yAf+hqdpx5+MKvPo2SXM1xpkU3u9V1G8ZmQaP1PBbeqcW0KSbabs2j6jQWn82R
	3gw8pwKZquN/Uv3aFk88E5OtmENOg1zTRXuGopuRzGUynqEo8Lo9IdbsijszpINmP9ly34NFc4f
	uBlskh0wyqPJEqEYzvll1tBrzA7dQsA4mnhAGOqho9blmo6EsspRlTPy+0fK68+WYL/dsfNTaji
	Xa57Ei+biAE9OZIOJD3Wl/ujsyNQJEdM+bSNaT+sAKDwFdsE3B5c+WdU2K5ERZuNDVWX0Yq+EL1
	RM6uGTueKM2Yh95ImbpuTf8YA0PXA88UjaBBkO83b7hFI5+e+YxlfSt9ErDx4cXt5k2PJNBPsuU
	aJao+HSJgR4PG0R7Y2VTwM9T4pdgteGjNfxdD1t1Rh6fmersibDhM6SpAyusUln7C9IigNyHI=
X-Received: by 2002:a05:6808:2447:b0:45a:8cdc:5f6b with SMTP id 5614622812f47-45c9bf8a60bmr4408710b6e.9.1768768402123;
        Sun, 18 Jan 2026 12:33:22 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d542:af69:64b6:f7df? ([2600:8803:e7e4:500:d542:af69:64b6:f7df])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd5c64asm5752986fac.16.2026.01.18.12.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 12:33:20 -0800 (PST)
Message-ID: <4a04fa3f-c056-4443-a55a-e8622feb1c2a@baylibre.com>
Date: Sun, 18 Jan 2026 14:33:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/9] iio: Expand IIO event interface for real-world
 unit handling
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
 andy@kernel.org
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/26 12:18 PM, Marcelo Schmitt wrote:
> This patch set adjusts and complements the IIO event ABI docs making them
> coherent with the fact that not all threshold value attributes had a _raw/_input
> indicator set in their names. In addition that, the latter patches on this
> series update the IIO event infrastructure to actually enable drivers to provide
> _input threshold value attributes.

I generally like the idea. There were a number of times recently when
adding events where we had to do complex calculation to convert to/from
raw units for the event value because it needed to match the in_..._raw
scaling. In these cases it would have been much more convenient to be able
to use SI units for the event value while keeping raw+scale for the actual
sensor value.

> 
> I'm actually proposing this set just for the sake of solving the event ABI
> naming inconsistency. I recall the event ABI was a bit puzzling to understand
> when I was having a closer look at that a while ago [1].
> [1]: https://lore.kernel.org/linux-iio/cover.1703013352.git.marcelo.schmitt1@gmail.com/
> 
> Also, I'm doing this set entirely on my spare time and just because I wanted
> to have the ABI naming inconsistency fixed. This is also a late reply to [2].
> [2]: https://lore.kernel.org/linux-iio/20251109164312.781de64c@jic23-huawei/
> 
> I've tested this with ad7091r8 driver and result is:
> 
> Before event extension (current IIO teting branch):
> root@localhost:~# ls /sys/bus/iio/devices/iio:device0/events
> in_voltage0_thresh_either_hysteresis  in_voltage4_thresh_either_hysteresis
> in_voltage0_thresh_falling_en         in_voltage4_thresh_falling_en
> in_voltage0_thresh_falling_value      in_voltage4_thresh_falling_value
> in_voltage0_thresh_rising_en          in_voltage4_thresh_rising_en
> in_voltage0_thresh_rising_value       in_voltage4_thresh_rising_value
> in_voltage1_thresh_either_hysteresis  in_voltage5_thresh_either_hysteresis
> in_voltage1_thresh_falling_en         in_voltage5_thresh_falling_en
> in_voltage1_thresh_falling_value      in_voltage5_thresh_falling_value
> in_voltage1_thresh_rising_en          in_voltage5_thresh_rising_en
> in_voltage1_thresh_rising_value       in_voltage5_thresh_rising_value
> in_voltage2_thresh_either_hysteresis  in_voltage6_thresh_either_hysteresis
> in_voltage2_thresh_falling_en         in_voltage6_thresh_falling_en
> in_voltage2_thresh_falling_value      in_voltage6_thresh_falling_value
> in_voltage2_thresh_rising_en          in_voltage6_thresh_rising_en
> in_voltage2_thresh_rising_value       in_voltage6_thresh_rising_value
> in_voltage3_thresh_either_hysteresis  in_voltage7_thresh_either_hysteresis
> in_voltage3_thresh_falling_en         in_voltage7_thresh_falling_en
> in_voltage3_thresh_falling_value      in_voltage7_thresh_falling_value
> in_voltage3_thresh_rising_en          in_voltage7_thresh_rising_en
> in_voltage3_thresh_rising_value       in_voltage7_thresh_rising_value
> 
> After event extension:
> root@localhost:~# ls /sys/bus/iio/devices/iio:device0/events
> in_voltage0_raw_thresh_either_hysteresis  in_voltage4_raw_thresh_either_hysteresis
> in_voltage0_raw_thresh_falling_value      in_voltage4_raw_thresh_falling_value
> in_voltage0_raw_thresh_rising_value       in_voltage4_raw_thresh_rising_value
> in_voltage0_thresh_falling_en             in_voltage4_thresh_falling_en
> in_voltage0_thresh_rising_en              in_voltage4_thresh_rising_en
> in_voltage1_raw_thresh_either_hysteresis  in_voltage5_raw_thresh_either_hysteresis
> in_voltage1_raw_thresh_falling_value      in_voltage5_raw_thresh_falling_value
> in_voltage1_raw_thresh_rising_value       in_voltage5_raw_thresh_rising_value
> in_voltage1_thresh_falling_en             in_voltage5_thresh_falling_en
> in_voltage1_thresh_rising_en              in_voltage5_thresh_rising_en
> in_voltage2_raw_thresh_either_hysteresis  in_voltage6_raw_thresh_either_hysteresis
> in_voltage2_raw_thresh_falling_value      in_voltage6_raw_thresh_falling_value
> in_voltage2_raw_thresh_rising_value       in_voltage6_raw_thresh_rising_value
> in_voltage2_thresh_falling_en             in_voltage6_thresh_falling_en
> in_voltage2_thresh_rising_en              in_voltage6_thresh_rising_en
> in_voltage3_raw_thresh_either_hysteresis  in_voltage7_raw_thresh_either_hysteresis
> in_voltage3_raw_thresh_falling_value      in_voltage7_raw_thresh_falling_value
> in_voltage3_raw_thresh_rising_value       in_voltage7_raw_thresh_rising_value
> in_voltage3_thresh_falling_en             in_voltage7_thresh_falling_en
> in_voltage3_thresh_rising_en              in_voltage7_thresh_rising_en

We can't be breaking ABI like this. There are some alternatives though. We
could register duplicate attributes with both the old and the new name (or can
we make the old name a symlink to the new?). Or we could add a 3rd option to the
unit of IIO_EV_UNIT_NONE and use that on existing drivers so that they don't
change the attribute name.

> 
> The difference is the '_raw' element in thresh_(rising|falling|either) attributes.
> 
> Why posting it as an RFC?
> 1) ABI changes a sensitive topic.
> 2) There are 77 drivers that will go through collateral evolution with the event
> interface update. A 77+ patch set is probably not a good idea? I recall the
> claim_direct stuff was split into 2 or more patch sets. This might need a
> similar approach (if accepted).
> 3) My coccinelle semantic patch does a nice job in updating the vast majority
> of the drivers but, it produces diffs longer than needed. E.g.
> 
> @@ -844,7 +844,8 @@ static int adxl313_read_event_value(stru
>  				    enum iio_event_type type,
>  				    enum iio_event_direction dir,
>  				    enum iio_event_info info,
> -				    int *val, int *val2)
> +				    enum iio_event_unit unit, int *val,
> +				    int *val2)
> 
> could be
> 
> @@ -844,6 +844,7 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
>  				    enum iio_event_type type,
>  				    enum iio_event_direction dir,
>  				    enum iio_event_info info,
> +				    enum iio_event_unit unit,
>  				    int *val, int *val2)
> 
> I'll try to figure out how to make it generate smaller diffs, or do the changes
> by hand if needed.
> 

Just throwing out an idea here without thinking about it too much...

Instead of adding a new field/parameter for units, could we extend
enum iio_event_info to add IIO_EV_INFO_VALUE_RAW and IIO_EV_INFO_VALUE_INPUT
(and same for HYSTERESIS). Really, the units only make sense for these
two info types anyway.

This would work like my suggestion above that existing drivers would continue
to use the old enum value, but we would encourage using the new enum values
in new code. And it would eliminate the churn of having to touch every existing
user.

And if someone really wants to take advantage of the new naming for a driver
with existing events, we could do the duplicate attribute thing I mentioned
above still.


