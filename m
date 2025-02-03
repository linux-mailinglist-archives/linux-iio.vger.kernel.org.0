Return-Path: <linux-iio+bounces-14951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D6A263E3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A421886343
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447E1E7C03;
	Mon,  3 Feb 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t95rlNLP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D31482F2
	for <linux-iio@vger.kernel.org>; Mon,  3 Feb 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611683; cv=none; b=ghbs2YP8v26JWMf5KjBj2ln78JIaBbdKVFt0DjIjj8XE6diV3dM6FoPSH+bhD7s5uvJA0paVIW3PyeYEGzx8bcizagBP/1zbZ1UAyaXVu/mO3j00vKIfi6wXkkMH0KWZ/u5+duE+iaZG1RsNvVtJlD8b0ZRW+Li3tpu7+1P0yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611683; c=relaxed/simple;
	bh=C2rIhJCYgLZHofyOC36e6wr55qi2ZJaXCF/8/4URIVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUBqRRLkjsV+e0juys1qH+FIGuZzHR+zK2oQlxG7JmjBvBnmb7ygljWXY893485HrA5iRWnxPrAmKnLucD+fJIysRs9aJUKQLoF6o63mVeB390R9u89ZAx5cU0BSADkM8GAFxbkpmBKsv8sw05gI+gsWuHqEBPCV3QHK08mkdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t95rlNLP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71e1e051e50so1278312a34.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Feb 2025 11:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738611680; x=1739216480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YppiSqGC2tFNDurF8FBbMGB85ESIBegHPAFelTZuV6s=;
        b=t95rlNLPrbcBv9Uo/BeuNrGH7LEFgSm0RBN/ZxjmrJtb5Np2kE5m6WbXJsi8u9z6D+
         F10scF65mSetwwq/AuuRmA1QNRKnRG+Wzed3+Y383VmGXn469RBhH8k3VmklufMqRcPo
         dBc88EWRdLRgiwFK7oG9+0lcAuFH/USuewrVF87Ig+EueBcDtmWgsw2QdpTBwABJYWMl
         UGirutvDx4qGFfURCxG155LyQWV2ejbv2FBV+PvSr4DhQeunenVqUtxGpz36X8tV41gv
         e85W/nwZ2qf6GZCPwh89d9QEJUBHVKcDutW1BHgi62Z/bVIS7AYfAZApj3IyzXbbPY+5
         cu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611680; x=1739216480;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YppiSqGC2tFNDurF8FBbMGB85ESIBegHPAFelTZuV6s=;
        b=u+kp7PgrzATp/Elgylse/j/AXVkLG84EfR1vOOpgSAn+PiYGc13IUzcWszM8XkuUcW
         tDJ7VZ3SnGwsjTQo1lEyqNrWspmjvLNsAa4+BxjLhCyHLtKP2pW2RARWnh/EpcYfk3kN
         GDVjgYqS5H7apbvpbWqJ2RbpR2mkmZe7N0nN+LDzbUvKbkQmstG1b/Nhp05FPp3T7juZ
         xy2Q+DxTbg+QQvJ6YBZD8bIAkB93oFy5Iuno+SS8UI0cIVkom9yOZSWla8FIN6w6eago
         1cz61WlruNorDpzMmR+uewRwaIaVEFQuDwNsxq7L3PRx2h3m2YzPvFKgln4YgaMhdM10
         zEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0NUksayp8LFiXp179wfJ7qh/kDqQxuCuSyS6KcMAwnRUlZaHrqzxMbuYRJcs/J2Cbf5nwM1CwXVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oEblxPwsc5y1KV1nds/cd7NQfXrAcEL1P+d4pisGcjzhqV2z
	EOxeT+ybSFoxy7BYlVt7s0k+xttxUn0p4npQcT/XzL05GtS8T0OYLqEl2lZv1qI=
X-Gm-Gg: ASbGnctTAKCfPoyaHUEw89NL5NhYxM1bz+V2hINgPakz3K7N6dmmjBGR1paI1xuDsdf
	AFTpWQ5HAUw2Qakk6HnN6q6vDpkCfhRbszCqk6gMJKKU+Go+C6kHEFTfcEfYGFQP7r6K9UZn0iD
	GRz13PvknQE5ED8endGICDqfss/Ok+1zvSyPS/Lqm5z56gOoWmaFjPNI7ia9iEFP4O1+vEj2gZY
	NoXv8O4+zrwp8QPEAe+nruBoCPn6PBzgCSgU6wjYaKpqfalAzt58OLoxPw85DQZKCjok/uW1G1c
	Hh+vIFp0yf83WwE0/NmHZWU8noyjPL5+dg90wwGTogobPpD0MFeN
X-Google-Smtp-Source: AGHT+IEQz7OUSD6AXEJ8r5qtD8jUHGuAC+qm8pf8qvOq6RQJOACIueUVlB1z2UcBizH91IDpylQdnA==
X-Received: by 2002:a05:6830:6887:b0:71e:57b5:2251 with SMTP id 46e09a7af769-72656763fe0mr13740128a34.11.1738611680379;
        Mon, 03 Feb 2025 11:41:20 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc22514e0bsm1951705eaf.29.2025.02.03.11.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 11:41:19 -0800 (PST)
Message-ID: <322c34f8-a920-41d1-b77c-09537554ad04@baylibre.com>
Date: Mon, 3 Feb 2025 13:41:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Documentation: ABI: IIO: Re-add
 sysfs-bus-iio-adc-ad4130
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: cosmin.tanislav@analog.com, jic23@kernel.org, lars@metafoo.de,
 granquet@baylibre.com, u.kleine-koenig@baylibre.com,
 marcelo.schmitt1@gmail.com
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <0d73303f2bca3312ccf2abfeb2c654c228fa7f60.1738608986.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <0d73303f2bca3312ccf2abfeb2c654c228fa7f60.1738608986.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> in_voltage-voltage_filter_mode_available attributes to user space. A
> previous patch merged the documentation for those attributes with the
> documentation for filter_type/filter_type_available into sysfs-bus-iio.
> Filter mode and filter type refer to the same feature which is the digital
> filter applied over ADC samples. However, since datasheets use the term
> `filter type` and ad4130 driver is the only one using filter_mode,
> deprecate the filter_mode ABI in favor of filter_type and keep the docs
> separate to avoid confusion and intricate attribute descriptions.
> 


> The digital filter helps shape the noise rejection bandwidth and is
> supposed to be adjusted according to the signal of interest. Depending on
> the particular ADC design, the digital filter configuration may have an
> impact on the output data rate (ODR) (which is equivalent to the sampling
> frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff frequency of
> the filter (`_low_pass_3db_frequency` attributes), or settling time.
> 
> Digital filters are a common feature among sigma-delta ADCs and
> IIO drivers set digital filters according to different attributes.
> ad4130 and ad7779 filter options are supported through dedicated
> filter_mode/filter_type attributes in sysfs.
> ad7768-1 and ad7173 set the sinc filters according to the
> sampling_frequency attribute. No filter_type attribute.
> ad7124 sets the digital filter according to a filter_low_pass_3db_frequency
> attribute so it doesn't export filter type attributes to user space.

These last two paragraphs seems a bit excessive and could be dropped.

> 
> Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio       |  1 -
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ff9cc09360dc..e4fd99c92d81 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2277,7 +2277,6 @@ Description:
>  		representing the sensor unique ID number.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available

Instead of removing the line, I think we need to replace it with:

/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_type_available

(change mode to type)

This attribute is used in the previous patch.


>  KernelVersion:	6.1
>  Contact:	linux-iio@vger.kernel.org
>  Description:
With those changes...

Reviewed-by: David Lechner <dlechner@baylibre.com>

