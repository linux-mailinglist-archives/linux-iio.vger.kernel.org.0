Return-Path: <linux-iio+bounces-23400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D64B3C346
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 21:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE575A10A6
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E2223322;
	Fri, 29 Aug 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H3O+12gQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95B54279
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496831; cv=none; b=q+3OZBWKRhMkZ7nrF80pUViMEJvmsBN3r1Zlgc7+BWbRUzPO+AtLbgP59ChCgmAgUz9gec023glANwNUkwSuR9DlB0DNukOy5lQpN7efwfnPPxSb8Gua+QAeUDF6S42A+ferzX6l3ckiuZCAhHVIhLttU2bwP8V5wVXxKvwPpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496831; c=relaxed/simple;
	bh=01xYwzEgQqARR+trB3+eOkbrnHfqiRT5HTlVuT4VGJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MF6bjRBIGIVOQaSAsgXaSB5594JXwyZaFfMa9WStqvwRmidO9FdXsEEqciuaeQPpKwivt9+HQVnLxS05Lg1aVuylwB95ySRBW+J0w1eqYfbYKfVf/1box5YEJlRnrDAaRk6GhteUJ9/auWYJtC4PcpzJU/US9imj4/aL3k2pHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H3O+12gQ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7454a992f7dso1587354a34.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756496828; x=1757101628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVGUg0SDLAjEzLHUVtikB/WVSwbBEdHlzNQeODDBtr8=;
        b=H3O+12gQhMEoHO+spTEJmboBEeydxF0GtBvT+vg+4/AqsbIcOdFPk/gpwx9h+fOtwo
         O+/UDYztpqt1tZUnZ5Db452Ue2g/xhtOXAC6sFOd1BteRdP8f0javz8rX50QtaSZqJ5w
         rDpkdOO+PXORbNJMLJLSFUg4IXSvYc15kfJbAw1i3RU7jt2MoO1zXO4JxNQUpCXaIFQe
         aG/DwSBb21ISzOuzZ4vTK6JC/y1w/8fas1AxunVEa+o0wbdTDRPNsyKWxTB0RqaVehPQ
         rz+rK/479O4f1dQOk9tmrTEwDN0IBjIEHVgax1BAP/OcUXhan9fcwtgDaFPk55vgC7wX
         ZJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496828; x=1757101628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVGUg0SDLAjEzLHUVtikB/WVSwbBEdHlzNQeODDBtr8=;
        b=uREIB519HY7f7jRfa3+JaCN58jidP8NBuzH7c/Gb/6+vitTMGkGWSIA/9lrrgfS0JU
         pt2FWSWnP6h8ehNbNtkeaLzARJ2Cf6pnit7HWgRJrXaak9P86QmzNuuX2BBL+4NtVedm
         dr/WpL3X6u4XBDalJxt1F/4WyC+b8JazayLA/x3J/4lrJhYLbsxnr+d4HwjEJ8GQ72Ve
         sU/T0hTLk6xUszWkC8Y43z01w0fcEpZ7YOeRtyiEXI5IxXPNModBjBGFLgFS9DVeg0lM
         pL1xh6rH8T5IfC4lPP4M5g9eEkTkeaLBmJzwu8pJkhACPX095o6N5joK93hG3O59beMp
         2vLA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnYXvjVXSENhnlTPtuCmFQ/EcNtEVcJBfvZWxtwophbd0ATzTzrfFFAgK7RO9PDn01VoGHyoC9Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCEkmLC3OiUYIqmDao/MdCEO6eJP3GDSqcUDtPDk8PjAtzkzP
	KEWEA9gXUAkp8K7SfHjI571Q9AwFqtyxY+o7M0sqMbf93ndTgS/Tml/RgSBJo+LK3X8=
X-Gm-Gg: ASbGnctj1G7vcd5uB/ULDqiCmhTyyulcdMdUySpQVM9rIEyR8dzvUP/NPTlJpBcJKWH
	SvdQ4PxEVkjZdYVEZabRVZb9fi4XXknaQI/czfio77XtWrt+nQzlC2lNrxa+j3IkMtVX7OuLqzH
	k0bfYks7va+jH9U7ukOQfAWc+p2IAQIqWUSpxpXXJWlDCSkdix7Ec8HRAibOak9lSreeBWOIMRn
	9nGYhly8qW4s1CYbQyAD6xbANJy0m9faDrCMoqdUu50nm8q0HVJlFevhO1Bjdo8FzIr/fWHfUb0
	ZB/vkntzDkvmjhBuzhk2WqC6UuIEFDfSGnYLYX5zsMdwsj11ac/yLceSKaDPAtXMxz0nZEFfqwZ
	SnsCLxXRnlHhBjgoRPwDGlIQ0DyoWkx9h7ZnL9xy9KRqczwUa0s6NwcMFs+pgFtHELh+pfN3sHC
	c=
X-Google-Smtp-Source: AGHT+IHkZbHxDOuHzCi5F+tf8HGqWEtfZdGb6ilH+q4mQdnXgfq0WBgXtPNPqptAdN4u6rI4AG7U/w==
X-Received: by 2002:a05:6808:a5c7:10b0:437:ae34:16b7 with SMTP id 5614622812f47-437ae341c86mr6947930b6e.31.1756496828382;
        Fri, 29 Aug 2025 12:47:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afc5a74asm1579763fac.11.2025.08.29.12.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:47:07 -0700 (PDT)
Message-ID: <1350f948-85d3-410d-9e9c-8d0fe4237a32@baylibre.com>
Date: Fri, 29 Aug 2025 14:47:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iio: add power and energy measurement modifiers
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power
> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)
> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value

The message doesn't match what got implemented in the patch.

> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 8c9098668772..9e372ed38552 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -153,6 +153,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PITCH] = "pitch",
>  	[IIO_MOD_YAW] = "yaw",
>  	[IIO_MOD_ROLL] = "roll",
> +	[IIO_MOD_RMS] = "rms",
> +	[IIO_MOD_ACTIVE] = "active",
> +	[IIO_MOD_REACTIVE] = "reactive",
> +	[IIO_MOD_APPARENT] = "apparent",
>  };
>  
>  /* relies on pairs of these shared then separate */
> @@ -190,6 +194,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
>  	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
>  	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
> +	[IIO_CHAN_INFO_POWERFACTOR] = "powerfactor",
>  };
>  /**
>   * iio_device_id() - query the unique ID for the device
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index ad2761efcc83..34eebad12d2c 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -70,6 +70,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_ZEROPOINT,
>  	IIO_CHAN_INFO_TROUGH,
>  	IIO_CHAN_INFO_CONVDELAY,
> +	IIO_CHAN_INFO_POWERFACTOR,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 3c3cc1497a1e..6d269b844271 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -109,6 +109,10 @@ enum iio_modifier {
>  	IIO_MOD_ROLL,
>  	IIO_MOD_LIGHT_UVA,
>  	IIO_MOD_LIGHT_UVB,
> +	IIO_MOD_RMS,
> +	IIO_MOD_ACTIVE,
> +	IIO_MOD_REACTIVE,
> +	IIO_MOD_APPARENT,
>  };
>  
>  enum iio_event_type {


Do we need to add these to tools/iio/iio_event_monitor.c as well?

