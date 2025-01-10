Return-Path: <linux-iio+bounces-14111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41EA09D6F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0003A4D62
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF2214202;
	Fri, 10 Jan 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv4MCLp0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7168209F50;
	Fri, 10 Jan 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545929; cv=none; b=jID2VyKmHWGX8vdb1/Oar1FDvgRRnm9Lv0YTAWR/yTO19W1ixDd4qQSHoZGIaoEiehFsI4zT4foLad85jIj7ZEREE4G8DlNc9XS6HGFJUmpxPgGQdIwCOod48fQhB4T3hFu6Nu4J+QO2xwk/ZTbqHu1hiH38B14WjdO6w3pIc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545929; c=relaxed/simple;
	bh=5cRilqtxfdMOGBiTNJzjGd5l+IzwcpborthqSLQW+NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np8YZ1Rf+OTSZwb+cjPFjf2GgB3FrHXha+UySDn6Ig8ZxdsJ45rvio50McHmJbYOJx63GmQC0mAGu2oRgvsOHruI2hsJfFY0aSda/BnK2zdG6g2kG8gsDcn5STy5A786Ep3J4suq861EZwBvimVv6WMSa2y3iUJa62FpCAB6gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv4MCLp0; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afe70b41a8so927417137.3;
        Fri, 10 Jan 2025 13:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736545927; x=1737150727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tZ0bi2Z9yThkshYHVUpv6sP8eop4ARnnyW6YjrsK14=;
        b=Lv4MCLp0p+geujckRQzhMJHNgN+dRMk+b2ulVVgPo6NYX/q1/V7EKWdr4/rZjgH04I
         1g6NYLIN2sRHIY4xPiNrT6gLoIfh0OMgmLevrMsOsdj7MqvNcvpDf4VFdZDPPe89wmb1
         3JrO/SKivVUQcztgpcfFnMrDpEVgLdv3cGTE5Ydps7gfY+ZxUcfbHYpUowaI2Asm8k4a
         0QNAzvOQQWUy/+i0esONLgeJW9DnwGMKwECWLKD6wKbuZZonQ4PCvdFok4V7Q3WV2bhJ
         Ri5SEDqVg8aKEAA4A3/fWUB9B5TVcJgfPkB/NGQi/SD4kYwHCuv5IqWR5GSTDF7lggq0
         MgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545927; x=1737150727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tZ0bi2Z9yThkshYHVUpv6sP8eop4ARnnyW6YjrsK14=;
        b=CupJQDii3aCDAdVKXYoEzCndrKyobSarMBk2mMA0kHdPQ9UmFyUXDbKSwtU6JZbxYR
         3K2O2Ft+KG+jcGRQeOfjr2HifeUdhHIh2RQMCB2yiytdlw8oJyOxSUy4jBJvdw1/jK2X
         9/QYLBdTH4nx3UZdUEgbLP1emyHmsjgnjz1yIuJCBT9sG8oZ6SBCkwKj0VnBO0M+4K7T
         btuy7RM1bi+lT3HfwLVjIuQZiU2AIOsnbqW8gjBwKdGcuJFISG37uRLO/X1plCOSyBYm
         HY1BaD8CJfO5NsBgaZBUqKHa9peW/JzDB5aVug60jfXn0imh+wKufqoMgMmm7W+GQFNa
         BZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW95GcGFjk5qqTZqiYKhAkLZw1/XOG2AvOMVuvgNXTFXXTYqIbUI5LFfaRXLjABdQTG1rKfnv0rJINJ@vger.kernel.org, AJvYcCWh2ex6qVjYJ4Kb88RJ0KOugv5Sd0gDDkvStFqqCbNLb3tDXvEeJr/RPA6FyDgTN31ut10tnMabowKsLZJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMLCuYHl0USOIs/VuwgXld+V2WmYCoeGS7NbvPcNQq1V0MALI
	74giuCdLUJOAi9G3PgmpQ480zwJ8YPtmysovwFOaYQHi2eADMLAD
X-Gm-Gg: ASbGncvTlZ+KnDAi3VKiNFr9xcWA1I3pGl/OdhQodk2wdEqGi+cCRhDbcRNlyrybony
	9DdN1+OEcr7AhW5wSXFEzKfDLieKZSQBkWOjSQh668nQJWdPLyFcipibpde3TuNrAiqHro9UiEl
	sdv5H36fu3kpCYYyhuYWNmO5rdn/E6R3gUFSXPLY9WxdueQKuvPkOYVJtOD97ZKqi746bmhO74f
	auCYaBa6zmlGWjSkQ8e42LxZnDLWVK/7heN65SFYO1BxFXob1uNxLEJqKpGg+orBbQ=
X-Google-Smtp-Source: AGHT+IHz2u/EYknhpRsoxWUpK+VioUZK9PkNMUZXK6MNmf6cINU+02hKEN0OzbidsSpiK939U+OiEw==
X-Received: by 2002:a05:6102:2b9b:b0:4af:dcbe:4767 with SMTP id ada2fe7eead31-4b3d0d9fc34mr13610927137.10.1736545926628;
        Fri, 10 Jan 2025 13:52:06 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8623136226fsm3423816241.11.2025.01.10.13.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:52:06 -0800 (PST)
Date: Fri, 10 Jan 2025 18:52:38 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 04/15] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <Z4GWpjnAoRKtexz2@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 is a fully differential ADC, meaning that the voltage
> conversion result is a signed value. Since the value is a 24 bit one,
Hmm, I think the reason why we sign _raw values should be because of the ADC
output code format. There are differential ADCs that can measure a negative
difference between IN+ and IN- but outputting straight binary data format (not
signed values). In those cases, the _offset attribute is used to "shift" the
_raw value so that output codes that represent IN+ < IN- are adjusted to a
negative decimal value (the _raw + _offset part of IIO ABI to get to mV units).
For AD7768-1/ADAQ7768-1, the ADC output code is indeed two's complement and thus
signed so the code change is correct for it.
Since you are probably going to re-spin on the patch series, will be nice
to adjust the message to something like:
The ad7768-1 ADC output code is two's complement, meaning that the voltage
conversion result is a signed value. ...

With that,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 113703fb7245..c3cf04311c40 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.channel = 0,
>  		.scan_index = 0,
>  		.scan_type = {
> -			.sign = 'u',
> +			.sign = 's',
>  			.realbits = 24,
>  			.storagebits = 32,
>  			.shift = 8,
> @@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ad7768_scan_direct(indio_dev);
>  		if (ret >= 0)
> -			*val = ret;
> +			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
>  
>  		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
> -- 
> 2.34.1
> 

