Return-Path: <linux-iio+bounces-12983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862789E0F39
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 00:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47193281F44
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6FF1DFDB2;
	Mon,  2 Dec 2024 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VdnCDlVV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34A1DED42
	for <linux-iio@vger.kernel.org>; Mon,  2 Dec 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180732; cv=none; b=e15SHfqxCZlalEnmurVCFXtO6oQ2ej42kNH/HZP9BWAt3cdVmZx2G9wQKwbr4n3g4DLk94nlUmwbYkDdDDkS64DDzkzG/mSmNNdU0+Y6k8QRWfw4uFMqygyAgckZuYG+GwZhvyxBsF2wsbHig8GR072z17V+3FUuX6dhDFAG/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180732; c=relaxed/simple;
	bh=jPK3s7MvXUAv9tE+0zBLYxJdkSDpEVCvEn5z5oAuHKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQ9ZIRvLcYDKpc101Wf905xBjcD3RLgLJpid2I4NcH1JaucrAKLq5z2QliDGkNdAdWcMXmcZiuiqE2FccbOHSQ7/U3NIHAJPFzytnCSKP7QFxKqwl7haXHJIDkLk/gMc8UlNoAb98nS8vKIc3e7wd/TKYLk7mtMB/Pzylmmitjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VdnCDlVV; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2965e10da1bso2424523fac.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733180727; x=1733785527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGCPVYRn5OSGT6f5dVv/ceurIa62iRGC5aQpQ1hOOnk=;
        b=VdnCDlVVYedwyJdr0A1+c1E9refjiro0Eij3epn8cOxfhFpSCGms1e0Hbc10HjMm86
         Qe6KTI4l32JTplyPFp3b0HZaGO8OQjrYRpJd3gcMdLWXOSG/hJkIxYCjIh/uc6je+PHS
         3mYKndlbZc8krKZkapDybbbeiQ0n9EjpMe+7aLtdZ0BBVzmwvZU7lVMLbh1cO/ZmCXMQ
         tHTtEjLI+BfXmZK8nylrvJMMrAnjYMLep+LMbQLld7r+o5hvRDTa90HFd25aaDEteq7c
         McOdwVJmj0qqonZ+jhBsgmfD/pGJQcdz/jbX259DMEgBQEnF1lkD7iWqnjcVSg3PI9Fd
         V1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733180727; x=1733785527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGCPVYRn5OSGT6f5dVv/ceurIa62iRGC5aQpQ1hOOnk=;
        b=GdlGWffgsFYMu+kIkzflkMm/5C6sAebcO9HpGbN2TwxxQQK6lodK22eqO/3IKUM5JL
         +D7XRdgtYMnOLO/HOUsIdISrFq1vSY6MLilpxX6ggR05UyzGj1kdUU6kvaIKWK3XbfGB
         tRrY5HyWCg+qFKnvTc8pb7BEgoBhQKbGJUHv9/9ZTvapNrQF1AVGdrhOox2Hvmgub47Q
         77CnFj8x1R2IKzVkBquP0yL6o4JRfKO+mnlfiwkj9KHVfi8sS3pxCLmrujhGr5rwWdlY
         ai9CsRew4VdDlHGnoIFeW7lqEGdIYJXMpH6BNKPxAwwzJT9YaMnw3DLpDm/+4OB6cPnY
         rmYA==
X-Forwarded-Encrypted: i=1; AJvYcCUhbP+95kxFjObESV/jhAFEd7X9iReQO20AzaUmuHP8EoiaeTElQNFznb6ISev3UYpQDhujME51uHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRG0HK782uUVVj2Yz5B2oN5CKurhgmmugjTgZ035SqvFubZsIg
	00yKonTrCv8cU4x+DqX8uZNmHvTw5pHIF5HbflUOejdSIkOSjtIvbWTdwlNyNeAZkUrWQIg0QoF
	6
X-Gm-Gg: ASbGncuu2Dc8EtTYsp4kLR0KlXIe7hr9OKcVI3DAG4bDxygEeietVt2RzcQUj6vz59p
	kaWzdZelTXCb1qT9HpPl2LNlX8KgXoMwWJXaf66Ro6oXHKDiKvFhG2U9Nkb8xxJixYvq0w8VuDG
	XNy3PRukr2Zn7SXb8aALkP8CZzDnxmvjo6V1MobJySpQ25H73gyy/2y4vv+4dnD6Ej9GPkw9Ea1
	JUXV1pYzGjgQdbW23ciZSv+TH1aOrl6+RxrQWSTHFPj6jcuGDGSwXhaaCaWpAyYm03R85troGkq
	dmK30GRhIlc=
X-Google-Smtp-Source: AGHT+IGi4VfwgKHUVkydn6ADMuAuaO1y9v+fPGdB0tYX90iGwS+zN1xd6HcGdq43J7pH2hZET2mb7Q==
X-Received: by 2002:a05:6870:d886:b0:29e:532d:8f3d with SMTP id 586e51a60fabf-29e8867f8b9mr256796fac.10.1733180727203;
        Mon, 02 Dec 2024 15:05:27 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29e3d3fb1c3sm2042449fac.8.2024.12.02.15.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 15:05:25 -0800 (PST)
Message-ID: <52513d34-8484-4c4b-8f87-29cbbdcefc06@baylibre.com>
Date: Mon, 2 Dec 2024 17:05:24 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: ABI: IIO: Re-add
 filter_type/filter_mode
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, marcelo.schmitt1@gmail.com,
 Guillaume Ranquet <granquet@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 12:22 PM, Marcelo Schmitt wrote:
> The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> in_voltage-voltage_filter_mode_available attributes to user space.
> The ad7779 driver exports filter_type and filter_type_available.
> Add (back again) documentation for filter_type/filter_mode attributes.
> 
> Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Digressing a bit away from the specific ABI used by ad4130 and ad7779,
> the sinc3/4/5 filters are called `filter_mode` in ad4130 driver while other
> drivers (ad7779, ad7124, ad7768-1) call sinc3/4/5 filters a `filter_type`.
> Datasheets use the term `filter type`.
> 
> Depending on the particular ADC chip/design, the sinc3/4/5 filter configuration
> may have an impact on the output data rate (ODR) (which is equivalent to the
> sampling frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff
> frequency of the filter (`_low_pass_3db_frequency` attributes), or settling
> time.
> 
> ad7768-1 sets sinc3/4/5 according to the sampling_frequency attribute. No
> filter_type attribute.
> 
> ad7173 sets the filter_type according to sampling_frequency too, though it
> looks like support for only one filter type is implemented.
> 
> ad7124 sets sinc3/4/5 filters according to a filter_low_pass_3db_frequency
> attribute so it doesn't export filter type attributes to user space.
> Missing `in_voltageY-voltageZ_filter_low_pass_3db_frequency` documentation?
> follow up patch?

cc: Guillaume and Uwe since they are working on these last two drivers
currently. Maybe something they could address?

> 
>  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..704c9033cb5b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2268,6 +2268,20 @@ Description:
>  		An example format is 16-bytes, 2-digits-per-byte, HEX-string
>  		representing the sensor unique ID number.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> +voltageY_filter_type_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the channel. When the filter mode
> +		changes, the in_voltageY-voltageZ_sampling_frequency and
> +		in_voltageY-voltageZ_sampling_frequency_available attributes
> +		might also change to accommodate the new filter mode.
> +		If the current sampling frequency is out of range for the new
> +		filter mode, the sampling frequency will be changed to the
> +		closest valid one.

I think it can be safely assumed that changing any IIO attribute can
cause any other to change, so we probably don't need to mention the
sampling frequency interaction here, especially since it doesn't apply
to every possible user of these attributes.

Some other useful things to add instead:
* Mention that the values are the same as the ones listed in the
  "..._available" attribute docs.
* We should deprecate one of the names and recommend the other for
  future drivers to use. Since "type" is used more than once and
  "mode" only once, it seems natural to keep using "type" going
  forward.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
>  KernelVersion:	6.1
> 

