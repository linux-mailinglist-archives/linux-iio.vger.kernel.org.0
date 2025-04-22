Return-Path: <linux-iio+bounces-18488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DBA95F78
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516EF3BA1EA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F401DF751;
	Tue, 22 Apr 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL8p8AEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C781E5716;
	Tue, 22 Apr 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307040; cv=none; b=cA9rqyt0qOxfjQ7HrbiAT03ubpsOILP0QBjasogSxZnB6r16GJSwWbXZ3jI5QVXHnbht9FbAgddMKSZfeCsNEDTaBDCqwnpiRahz/aqYB6p6XWoHVvj1RLuxbeKMMUqetAUKmcKRoknwV/ixfajV8ChJZUI5ESov0MHskys93bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307040; c=relaxed/simple;
	bh=pPkJ2UTy3GDrAFVJl5Jk/KG0cAq5qNEz0JxEE9mXplM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixstUwKBJmwxB1iv4joRYwjDBoKeaa/nwe5jCcrv8I97Q5U7zMC5VSLeIOFkpxzyp2cKyqlGwKLtvJOZKoPqCc8cUzDEUfvWlWRC/9f/oUpiRNhDqjj6QKppxCMMEt8p/1yMf5anNBJSGr3kBkF45tIP76nr2QYZW7v3s8JtbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL8p8AEO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso801806366b.3;
        Tue, 22 Apr 2025 00:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745307037; x=1745911837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RAy9pBhdgknyNhYYMd1xC1L3axBJqlU74RKhr7quB0A=;
        b=kL8p8AEOEv0+qgaBow6XRJz0YXM0m6+eJyVkuaRY2e356M00yAeVuvaMsFdPM1b4/q
         dxQjlCQpHTVviIKwsYu6s5JtmZUqAUAvUWyMNNuy1o63F1iwPBvEFfain5712kHa1GIZ
         FR5K8OxUzKoZ/Oi2e16uC3gK+CJeQQfFS4qrHQ+iBwMFAQHlqE9XOUdnOd0i5XC4Jd8j
         XMFYRO+tSA0nVQf6zpMjBydexu2ERCgTAj8AuqJCNqrAYimXjHl2oVgeaQB15yu5aMoP
         +j9lNr7ji6oePhQ4IHbULTlbaO3igwHyFYPZbvAn/DNDFxN+xnAS14JlDUs4OnH4vrH7
         zWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745307037; x=1745911837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAy9pBhdgknyNhYYMd1xC1L3axBJqlU74RKhr7quB0A=;
        b=cjDLqPKMAWkYaYvso70fz5hjPyitURaNrBrylW/SdyMVuX1bverWr11KAnvsD/yJe0
         t++xUFT1f+pqj5uRVI5UU1iwLw7rHTygoXYm2MUQWRfAJHq5Ez8B4ND6qCdCFGpyUzn2
         oF5Iez+1XdEDhxd9rSCPkzDmTFavpZ/eMxtA2OGF1byicaP7O40zw+a+77DdW5ab6NDr
         q6IxRYwfcAoTxHsQpd+5Qr/naXOqZYd0Fem4mSdhcimoNz3USN4BH5hkIo+0NZKpO/ha
         JQbYIWbrVdhStrH4LtDxtBY6ZXuzCqd2IS0XTNUu0VGbUma6t6ynbmpjgzYvtaH8kbkr
         Vmjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ovtebouRbW+t6XJ+oPjNTsaWwFlDO1DHtZcFs2/a4V77+lHc1HzbT1YA4czMAguRpW/1h5ZwlVk=@vger.kernel.org, AJvYcCXdSfMe94IvN71/lruN8pzwPTJv6//Pu65QieQ/QJdKYF0lepJczhm+trxJ6mvUzfybDzkgZ00QQ9v69fqj@vger.kernel.org
X-Gm-Message-State: AOJu0YxfjQZnbLKYV5Vj+Crj1KogQqTMAM4jhEz9G8Tcxz7+tA1XqBM4
	y0aRc+CHQh8Oh4C+e3TOEXi4gkXw+A4+cc+TRvnRj4xGGDEXwTli
X-Gm-Gg: ASbGncsro5Lz5vyrRXETa9stkCzNuN41Id+bnSHOdmDMMRElOLCyXudGxnFrB8OerI7
	0EyPqJsPUI9iK5f3vY1IyKxWr3lcBGFrTvwvRk88OhFyLpwgbM4thPTeJyzbEVDGzKhyZqYhliR
	Cbp2ILsO1P6kYi/fnHPw+XJEUE81S8uRpYTZ5CRJnzM7TBYbV6u3DtwkiSS0dsGzmTjCy/1XD8u
	euk/MpfAgFbOFzLu8sh3n5eeJhAn6iJz3O0LSy5fd2Lpimn9JI4sO1EiwHvlvq6fs60s6CHmYWd
	w/W2lUNd4T2s5n4VE8WslZgo9PM4fHxBstP3OF7nJpsOn7etgPih8ChEt3/ojQ==
X-Google-Smtp-Source: AGHT+IHrXC1x/a4uRViWvguC886vRxzfCqbfHOZEp6PE84oxoaS8TGNIpPYM0AFyGjDYGudTYJ0Y2w==
X-Received: by 2002:a17:906:d554:b0:aca:d831:8fb1 with SMTP id a640c23a62f3a-acb74e09fe0mr1347246666b.51.1745307036759;
        Tue, 22 Apr 2025 00:30:36 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec90950sm618245766b.75.2025.04.22.00.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:30:36 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:30:33 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <6rgtuq2mtk3a63d3tlzbgjhauslkztgemn7566qyi3mzwywprq@lxhsvwofnvg2>
References: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-abi-oversampling-events-frequency-v2-1-4059272b7364@analog.com>

Hi Jonathan, David

Should this patch be submitted differently, such as under the AD4052 V2
series? Or are further modifications needed?

Regards,
Jorge

On Tue, Apr 08, 2025 at 10:20:29AM +0200, Jorge Marques wrote:
> Some devices have an internal clock used to space out the conversion
> trigger for the oversampling filter,
> Consider an ADC with conversion and data ready pins topology:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   ++++    ++++    ++++    ++++    ++++
>   ADC data ready      *       *       *       *       *
> 
> With the oversampling frequency, conversions are spaced:
> 
>   Sampling trigger |       |       |       |       |
>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
>   ADC data ready         *       *       *       *       *
> 
> In some devices and ranges, this internal clock can be used to evenly
> space the conversions between the sampling edge.
> In other devices the oversampling frequency is fixed or is computed
> based on the sampling frequency parameter, and the parameter is
> read only.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
> Some device families such as Analog Device's max1363, ad7606, ad799x, and
> ad4052 contain internal clocks used by monitor modes and oversampling.
> Devices' monitor modes are exposed as IIO events.
> The max1363 driver included the events/sampling_frequency in
> commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> and ad799x in
> commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> hysteresis")
> but went undocumented so far.
> 
> The oversampling sampling frequency is a planned feature to be patched
> onto the ad7606 driver.
> In this particular device, it is called oversampling padding.
> The upcoming ad4052 linux driver will utilize both entries,
> it is worth noting, however, there is a single register for both
> options. Since the device is never concurrently in both modes, the
> values will be safely cached on the device state.
> ---
> Changes in v2:
> - Updated oversampling frequency description according to discussion 
> - Don't include already applied
>   commit 3a8fee68faf2 ("Documentation: ABI: add events sampling frequency in sysfs-bus-iio")
> - Link to v1: https://lore.kernel.org/r/20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 722aa989baac43f694076074b307d134867b4533..6f5c4060704742ae5f5672a861271b88084ac8f8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -138,6 +138,23 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Hardware dependent values supported by the oversampling filter.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Some devices have internal clocks for oversampling.
> +		Sets the resulting frequency in Hz to trigger a conversion used by
> +		the oversampling filter.
> +		If the device has a fixed internal clock or is computed based on
> +		the sampling frequency parameter, the parameter is read only.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> +KernelVersion:	6.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Hardware dependent values supported by the oversampling
> +		frequency.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> 
> ---
> base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
> change-id: 20250321-abi-oversampling-events-frequency-436c64fcece0
> 
> Best regards,
> -- 
> Jorge Marques <jorge.marques@analog.com>
> 

