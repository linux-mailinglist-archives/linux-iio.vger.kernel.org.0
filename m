Return-Path: <linux-iio+bounces-12934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F39DFD22
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A5116258A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078881FAC3D;
	Mon,  2 Dec 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jW5QDmOt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB51F9EB4
	for <linux-iio@vger.kernel.org>; Mon,  2 Dec 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131717; cv=none; b=Iw0yWqbrFaFtk9ngx1lcwlwUQryi/EmO41IGluOXzSEAPc6vU1G3IpQ0KW19UtjPjAAhSJ7vDhyI9f5QGvdStV+Vt+mVOgwb0dKLQmlbMMdDdtHXc2IdgyLP36nRfQ7J73lLUL6aUf0lmtvAD0kVb+DBdJq/kwppI7bMr8TOen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131717; c=relaxed/simple;
	bh=rCZakYHRwI2gNpuFPFg1qN+AD8WP9HUtJZUnB9PZYe4=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaKrJxLr2rk7JKlnJ8pP50lk1LMih5spJ5cL1YiYLdPx/vgNjeFsCrRBVoEjXcDmhPrnMgXTz7YH/pEY3uD4vvIoFIlJBogGueNbTYXo2xG5ukI4pp6LXMxMv3oSaL8uKGRoLYOpph8jkQvBpwOykf5y7ExNhrnAtttQlL8ufbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jW5QDmOt; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea4acd3ed2so1738630b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733131714; x=1733736514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RV931aVv2htGElL/ZMwKdLdUqmXtd6/lhHmQtH8EMFk=;
        b=jW5QDmOtAsJ9nMWQMXES1tZMqUNv5t7UAq+F267FS8gpfgAlGpuFfDDVDswBO/YkHW
         HQUxhNBvCwgNQ1oRPuMiKHKnWhgjsA8goeasUrksfxhygIZqn02s6mEekBM2fX01UEEf
         phdqNvbNlLsu9LmcRX3eHKyEzr/KXDuo0pnq4pPo0xAcxJIr47MS4WqLmPdbpHUlzrRS
         rtLsTLgedDXh1J1+qnqFhTEqYi3jl4ZJ8knQwlG4IIh3P7n/LgaKjzfUHmJqiosv0pb+
         1/u0Hk8DUbjbu5NXnAx1mXASQrL4WiI+Il9rC1vxJQveIYbfmsPYFrAc7eQbIj9E+hG6
         iL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131714; x=1733736514;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV931aVv2htGElL/ZMwKdLdUqmXtd6/lhHmQtH8EMFk=;
        b=fAGPFsSwTW+MhtA2jlc8Rp7ri+IxuddbIQP4PwzDO80KZJZoMzXSLn0W5SL/ItNL+g
         Q64mijV6pnAqC9wuGuQcDugjKTebjWzTLO439jVK3SPWBcyB76lApa87eJOlkN82sgUU
         Mv8jZhPfuSX+ndC8VfA8L0GAyvXgrOJiGNG5MaDDL7T7qP1Zse26kuqmQ+y2m1HBDtE5
         JU7HpPwmNA0/JKjEmWZG/D+IivA45EYuLQu1TN9YyrRYzupVz17tnIktnZN/kr+FLEjV
         Xuw4/dGjqps8I1HJbjC9dMvyfcLUZqaXPDuXkex1qiatwHNI+tymYkmQEiWFDvXHl+Ao
         dqyw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4Zf8GpYT7NDDAgJDvqGnV2pbqjLXXOIjGWhnZmaCdVOPR6vtuCdclgtAujADbvnpvVzPtFbNevc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSeUky1SXye46RfIub2U0HumHFSS/RG8wYit9Q8sSbd3oWXo3
	Qq8voyVWoWwGBgKzA/aIt5nd3zrh4wyXJJprFIyFFJswuFRUZoccvqH8bnMHu93P8fXCQJ/q0tZ
	fjyKeBEuEOguOluV5aCiWWK7CN/tdAIgG+ITWjw==
X-Gm-Gg: ASbGnctlnpl0qe7KLgCsYnHnWyRMIw2z5YClM1MO27ua9pObotDS2q6hz//Mj4bkLpK
	RnVfH6PKzXkpVIfu5TB0k3isZMz1BJA==
X-Google-Smtp-Source: AGHT+IEGZkG4gnt3sT5I6vRt244jgAKsbU7HG/WXJSz43M0i5AD+X+shq/h2EvfLpQRvztAn/Ardkm+wY18lF+5QQO8=
X-Received: by 2002:a05:6808:d50:b0:3ea:6a8d:c57d with SMTP id
 5614622812f47-3ea6dd9171amr13472475b6e.40.1733131714441; Mon, 02 Dec 2024
 01:28:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Dec 2024 03:28:33 -0600
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.9
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
 <20241127-ad411x_calibration-v2-2-66412dac35aa@baylibre.com> <20241130190633.34489853@jic23-huawei>
In-Reply-To: <20241130190633.34489853@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Dec 2024 03:28:33 -0600
Message-ID: <CABnWg9spJfANirbMZX0gUSTP5i0eRnWXa=ixW0Q__ipc-jKHog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad-sigma-delta: Document ABI for sigma
 delta adc
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 20:06, Jonathan Cameron <jic23@kernel.org> wrote:
>On Wed, 27 Nov 2024 10:06:14 +0100
>Guillaume Ranquet <granquet@baylibre.com> wrote:
>
>> Add common calibration nodes for sigma delta adc.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>Hi Guillaume.
>
>I think there are some issues with the old docs that should be tidied up whilst
>we are here :(

Hi Jonathan,
No problem, will do :)

>
>Just fix them up in this patch then mention it in the patch description.
>Or if you prefer move and then fix in separate patches.
>
>
>Jonathan
>
>> ---
>>  .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   | 23 +++++++++++++++++++++
>>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 | 24 ----------------------
>>  2 files changed, 23 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..c2c55a966163736aea8d46fc5089c08dac747b84
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
>> @@ -0,0 +1,23 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
>in_voltageY_sys_calibration
>
>(as indices are capital letters and X is used earlier).
>
>
>> +KernelVersion:
>Make an estimate of this I'll never remember to fill them in whilst applying.
>
>It should make the next merge window I hope!
>
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		This attribute, if available, initiates the system calibration procedure. This is done on a
>> +		single channel at a time. Write '1' to start the calibration.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		This attribute, if available, returns a list with the possible calibration modes.
>> +		There are two available options:
>> +		"zero_scale" - calibrate to zero scale
>> +		"full_scale" - calibrate to full scale
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
>> +KernelVersion:
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		This attribute, if available, sets up the calibration mode used in the system calibration
>> +		procedure. Reading returns the current calibration mode.
>> +		Writing sets the system calibration mode.
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
>> index f8315202c8f0df2bd4b7216f5cf8d3c2780fcf3f..28be1cabf1124ac7593392e17e4759ddfac829e8 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
>> @@ -19,33 +19,9 @@ Description:
>>  		the bridge can be disconnected (when it is not being used
>>  		using the bridge_switch_en attribute.
>>
>> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
>Huh.  That would explain the x above. I assume it is per channel?
>
Yes, calibration is per channel.

>> -KernelVersion:
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Initiates the system calibration procedure. This is done on a
>> -		single channel at a time. Write '1' to start the calibration.
>> -
>>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
>>  KernelVersion:
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>>  		Measure voltage from AIN2 pin connected to AIN(+)
>>  		and AIN(-) shorted.
>> -
>> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
>> -KernelVersion:
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Reading returns a list with the possible calibration modes.
>> -		There are two available options:
>> -		"zero_scale" - calibrate to zero scale
>> -		"full_scale" - calibrate to full scale
>> -
>> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
>> -KernelVersion:
>> -Contact:	linux-iio@vger.kernel.org
>> -Description:
>> -		Sets up the calibration mode used in the system calibration
>> -		procedure. Reading returns the current calibration mode.
>> -		Writing sets the system calibration mode.
>>

