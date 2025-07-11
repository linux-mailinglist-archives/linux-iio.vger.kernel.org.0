Return-Path: <linux-iio+bounces-21589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA88B0247E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95F3A40606
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78312F272B;
	Fri, 11 Jul 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SO/yxq0/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFA1DF25C
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261800; cv=none; b=P4CKXNbciXj823EcgbxfhJKQwFkQ9oL/Uayx4qsRZokruZAAtRgcteV/2xmxE380litcWG31gbPaiixb/T9PVr755spfxxMVv69AdAYES62UCYCHLEr5IS5ECWWFDzptixiV+5wY16rS0MMzuqUTVZcUzt9i6XFZVplxYUY1a6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261800; c=relaxed/simple;
	bh=CT8j4G71nN8Lnzk6rXI/vvQAsHcH1biWkLypZw72nnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XghvS27R7iSAT3O3/C5CY5Vr88z9Vd0uAfdvkGc5RxW0XW8OBkTVfIY5qG2UWNtuI/miH1MmvRO96gfx+6YcwQag+JotFuuX9iky1z6sXa/gF8D86tP3gl7XeTIPbgNY2uYuYzWUciR5mB+ok9T73NQWOrw9SUckep/Q4C0So2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SO/yxq0/; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2efbbf5a754so1515076fac.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752261796; x=1752866596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbQ4gjhcKf1FV36kcI6WczoSoNZh07OMTR5d0NMFKgo=;
        b=SO/yxq0/FRnxLsWSB0dHlPrVIoH7rvokZ0CzCMznRyEWj/b/i7hfgImcY8V+8euTmT
         nS2YBQ4Jj6ZtPo6j+NDOVsJPq057qNI4i0hE27Z+KYexi57+kWDB4XWm1VCY1qCOKNCy
         49YFfbKEqkbQ0lVaU2LfZaRreGmGMQRNpGZJ32vNbSIVM78IesYYQvncddXFXyOJWPgU
         4yF6g71RYm2BhiYL8O7xWxOs+DkAzJdwe/KfnwmsYSD7vY/Qhmi+BiokalCeSzRruX9x
         NDVIZ+59ypj2R15B3vJF1BM/CJgofmiiVsOlDy7MiQrYwjA8Ir3AVQoBNlm8bHgq0mei
         1DMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261796; x=1752866596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbQ4gjhcKf1FV36kcI6WczoSoNZh07OMTR5d0NMFKgo=;
        b=ab/BPmjhOPEMRzb3mWVZn6rzTIw+NbGTpBEi2mNmIl0paPrFKRqqKLveEyLUKul56X
         lCjDcIDwX/BjBVgxpVpGzSI9Y+swdThaJNFht1sU4P8nfq0rQHnZz+aCmeqcv915Zj9m
         nrkpKaBH/HuMr3rqhsR9tG9YAc+DkVOHokGbQPAp1ay6yziKvtmkUQdHuVWo8yyLd0jT
         Hb7zuGmO1HACE5Rlbtn558lf/5mH0CL1KNC7QzTxVtjN++qDekEbNpqgo7MRSalXEE42
         eW2ohZgcJYzTgftKDoE9xU2xhaWCNuM5Doo/2BvHtEphwd2qacxMxwFH4LHVXyVuk5b1
         bJPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+nxFHT6+QYzm1LvXaGVoaRG6WrmcXMRnW5QspHLj9w8eH31DTGt90om6BGKb0nhi6LAbuSohh7SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua4lbCR7SbMKpz3D9qP3zQIjalqu0zIzUoa60N3OlTBRrlVLq
	Vv70xcl3vlW8l67RiWfCcVmNQ7Vx0+k1aCakHK1/Xyl0oDWCiDqgM97BwPPavC4OX+g=
X-Gm-Gg: ASbGnctwpBPQBAk8Q8p0Z3hBW7/VYBpxF7Bg3MWUfe907otX0BjqFWldMB4i+qRCWsp
	dijTu26RxtdDsID80AnInyqTBb0ss+0hxP1Ru7Xsa9mANPajBPRF4GbmLq8Jz3vJoHhB8Wc4nF7
	maBzqATXgUHX9X+Ady2Lt1WWM4qu3Qw0TjaqqiCoKdvqrhWJgiK932GzdsZc9J0UP7mxSda4rTF
	OzGdLn3HiCR0BOXxPaCEBNDZhG8bSamTWvqmD3+yBuEYPFj44BiCikA6+5l0oFytspYqZ9DvLgn
	CJEr0konNvmBdP8EpMlwn+YCFtwikmYNrH0pjoLAbZlAYv5aGwbP7D+ffWhJ3K2kPXJ19n7C/Z4
	iSIW+FPPRphMtunlI7k8lsEwnFQZnnHBJjdQsAvbFHX1U7dEENd9VkDIuKdQT28moM4tPrXhU6G
	EliZoJT94LDg==
X-Google-Smtp-Source: AGHT+IHJJG1pjfMfHbXCiP2mYhrjtaG+ds4ATps3yE0wgdEBzivun4Aw8g8ipsQFhpaLwTypjmt8jw==
X-Received: by 2002:a05:6871:3518:b0:29e:69a9:8311 with SMTP id 586e51a60fabf-2ff27099808mr3221078fac.36.1752261796031;
        Fri, 11 Jul 2025 12:23:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4601:15f9:b923:d487? ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d3550sm846917fac.34.2025.07.11.12.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:23:14 -0700 (PDT)
Message-ID: <1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
Date: Fri, 11 Jul 2025 14:23:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: add power and energy measurement modifiers
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
 <20250711130241.159143-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250711130241.159143-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power

These make sense a modifiers since they are components of a single
measured value.

> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency

This one seems like there should just be a separate channel
with IIO_POWER + IIO_MOD_REACTIVE since it is measuring a different
value.

> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)

Power factor seems like it should be a IIO_CHAN_INFO_ rather than
IIO_MOD_. It is also unitless, so doesn't make sense to be part
of power_raw which would imply that it shuold be converted to Watts.

> 
> Energy modifiers:
> - IIO_MOD_ACTIVE_ACCUM: Accumulated active energy
> - IIO_MOD_APPARENT_ACCUM: Accumulated apparent energy
> - IIO_MOD_REACTIVE_ACCUM: Accumulated reactive energy

As below, this one seems like there should be a separate
energy channel for accumulated energy.

> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value

Suprised we don't have something like this already. altvoltageY isn't
clear about if the value is peak-to-peak or RMS.

> - IIO_MOD_SWELL: Voltage swell detection
> - IIO_MOD_DIP: Voltage dip (sag) detection

These sound like events, not modifiers.

> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 19 +++++++++++++++++++
>  drivers/iio/industrialio-core.c         | 11 +++++++++++
>  include/uapi/linux/iio/types.h          | 11 +++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3bc386995fb6..d5c227c03589 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -143,6 +143,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_rms_raw

This should be on altvoltage, not voltage.

Also, the exisiting i and q are wrong for the same reason.

> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_swell_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dip_raw
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -158,6 +161,7 @@ Description:
>  		component of the signal while the 'q' channel contains the quadrature
>  		component.
>  
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
> @@ -170,6 +174,11 @@ Description:
>  		of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_fund_reactive_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_factor_raw

As above, power factor doesn't have units of watts so doesn't belong here.

>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -178,6 +187,7 @@ Description:
>  		unique to allow association with event codes. Units after
>  		application of scale and offset are milliwatts.
>  
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -1593,6 +1603,12 @@ Description:
>  
>  What:		/sys/.../iio:deviceX/in_energy_input
>  What:		/sys/.../iio:deviceX/in_energy_raw
> +What:		/sys/.../iio:deviceX/in_energyY_active_raw
> +What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
> +What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
> +What:		/sys/.../iio:deviceX/in_energyY_active_accum_raw
> +What:		/sys/.../iio:deviceX/in_energyY_reactive_accum_raw
> +What:		/sys/.../iio:deviceX/in_energyY_apparent_accum_raw

I think the accumulated would just be a separate channel, not a modifier.

>  KernelVersion:	4.0
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1600,6 +1616,7 @@ Description:
>  		device (e.g.: human activity sensors report energy burnt by the
>  		user). Units after application of scale are Joules.
>  
> +

Stray blank line.

>  What:		/sys/.../iio:deviceX/in_distance_input
>  What:		/sys/.../iio:deviceX/in_distance_raw
>  KernelVersion:	4.0
> @@ -1718,6 +1735,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_rms_raw

Interesting that we don't have altcurrent like we do altvoltage.

And there don't appeary to be any users of i and q modifiers on current
so that can be dropped.

>  KernelVersion:	3.17
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1733,6 +1751,7 @@ Description:
>  		component of the signal while the 'q' channel contains the quadrature
>  		component.
>  
> +

Stray blank line.

>  What:		/sys/.../iio:deviceX/in_energy_en
>  What:		/sys/.../iio:deviceX/in_distance_en
>  What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_en
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f13c3aa470d7..daf486cbe0bd 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -152,6 +152,17 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PITCH] = "pitch",
>  	[IIO_MOD_YAW] = "yaw",
>  	[IIO_MOD_ROLL] = "roll",
> +	[IIO_MOD_RMS] = "rms",
> +	[IIO_MOD_ACTIVE] = "active",
> +	[IIO_MOD_REACTIVE] = "reactive",
> +	[IIO_MOD_APPARENT] = "apparent",
> +	[IIO_MOD_FUND_REACTIVE] = "fund_reactive",
> +	[IIO_MOD_FACTOR] = "factor",
> +	[IIO_MOD_ACTIVE_ACCUM] = "active_accum",
> +	[IIO_MOD_APPARENT_ACCUM] = "apparent_accum",
> +	[IIO_MOD_REACTIVE_ACCUM] = "reactive_accum",

If we end up keeping any of the two-word modifiers, the actual string
needs to omit the "_". The readability isn't so great, but it makes it
much easier to machine parse if we can assume the modifier is always
"oneword".

> +	[IIO_MOD_SWELL] = "swell",
> +	[IIO_MOD_DIP] = "dip",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 3eb0821af7a4..9e05bbddcbe2 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -108,6 +108,17 @@ enum iio_modifier {
>  	IIO_MOD_ROLL,
>  	IIO_MOD_LIGHT_UVA,
>  	IIO_MOD_LIGHT_UVB,
> +	IIO_MOD_RMS,
> +	IIO_MOD_ACTIVE,
> +	IIO_MOD_REACTIVE,
> +	IIO_MOD_APPARENT,
> +	IIO_MOD_FUND_REACTIVE,
> +	IIO_MOD_FACTOR,
> +	IIO_MOD_ACTIVE_ACCUM,
> +	IIO_MOD_APPARENT_ACCUM,
> +	IIO_MOD_REACTIVE_ACCUM,
> +	IIO_MOD_SWELL,
> +	IIO_MOD_DIP,
>  };
>  
>  enum iio_event_type {


