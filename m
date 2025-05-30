Return-Path: <linux-iio+bounces-20049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31366AC947D
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655013B90DB
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E5235BEE;
	Fri, 30 May 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UPurXx+5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EB2D600
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625459; cv=none; b=HTr91m0KsZoVoiG3jW4o74GIcDdpC7taEEnC5bUrpX+WWHIDQPDsXsV2HyORtgaVI46Kn/Xgi3FwAdRM7e3AGWd6EkLDTC8Oj/4PVmciUmy6dNdWpU+aGcDFX+E/k+iNSgjIpq5yFYSI2lgHNP/X57fyi5bYotUuR8J38hCNGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625459; c=relaxed/simple;
	bh=u0pudonnZMMkqw9Nfj3bn0eaMI+R5dUwb0hhEPriVT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqikxPlbXbsQ2JqY8FBKLEhCQeZb0Ehy4q0tK94leJcv0/kci0U4xV5RLpcTGnPaddiPIyS+8BvFi6y5BmmsPDj3ykOsY2+UU8vGa/UsbDZallebedUcC7/DnKNDPa45Tu20PMvoB/JAzszO/g8x9LKsmUf4hC1hg5aSCBDafMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UPurXx+5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c16e658f4so1564119a34.1
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748625457; x=1749230257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgMLVyd/FWmR+p0LRFwojmTi1e0nsIp3Am2A4nMf1Is=;
        b=UPurXx+5KunV2HG3dozf8YIEhc8Qby6JmNey1tb4UzyGkOCT1Wsza63vlT7AtoMqZc
         at3/mVeNPekDXku5zD/cl+e4kz32UOkaGy91I3qTnriHi0EJrHePprLns6CGliOPmMJQ
         8UdjdVUYg13/0hr1S96kUT4etwWI1qNHTM6oD6z8mWcZrEh2wZcoNp4YiSQ5touIm1YW
         bHStNlmrDTbSEiV7RcTeUw+3aELk3faeVoxpcNvJAaH0lR/UBbbum6PnfyQKc7nn0TLM
         p8ttLdBoXGMA1kEof0USe61IDedkij1fBALSKjTjjXqWhbIMt6XJqdiktvpJ/eZebL9N
         HT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625457; x=1749230257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgMLVyd/FWmR+p0LRFwojmTi1e0nsIp3Am2A4nMf1Is=;
        b=HJ9pxCrAuCyeOvHuwKS00Dmh6hggHMHALopE10XsaE4D9pCBQWVix0VwYUnUs1Y/fH
         pAmT7W9ppaMZnRmxMiqfRo41WAHR9xkwY9S4CVP7sDWUpnaofOFjk2Eeyx2D3Wds098M
         zuECdck/qHrQjgXczQd6TLINSNhZChObUJzNxuTG4U381XC2tdM9ssMbvjNtaCDy/nMq
         Yw8PtY8Pn037Rm6gGroTIUZX56Po/TNKfEkbnzh0/qQTWBF4Pu0eT/z7jNolIix/He4d
         8V9LjeqPbW55XiRCuvd14Zmq4GQ1r05No9hbj0bNF9SPpDyrObmhrGMJ5XTqPzuOTVTc
         uS4w==
X-Gm-Message-State: AOJu0Yzy55PdWf2VhdOlfO3VmiLqH2i4yy6MMZDdvpP3EyVDamr0L5Ye
	B5u0A/YwaZTq+dDkSv/nIPJ7QUZmcil6wXhrCKHhGnMUSBLh7WPaDcfRZdz1vm450kY=
X-Gm-Gg: ASbGnct1S2Ge/p0nCvAcVUnY+fXUUy/82S81HW6Hq+EDqmcc5f8xPb/YkGh44M8dDf5
	ZQAtu5L9WeQiVqt1vrrftV4xPXsvRsGwyIGNtAh+4GtYRW98iMupsHxjiSe4pmzsfLw4BdkpAD0
	YGswr6iILw1xipbErlqDane6FYMvLFHqXF5JqdF5UstVjiozN6cjFDWrgR6wiTMCObbGwEhm0SH
	qxZKyVXhsEd28Z55ZbQh6WXURgMrU7oNzh2stWLm/szco8uo3qv+AwdyWZxi3bGls9Zq3NfcDMX
	w26cmvfLGW+ywJFjih67lKkQ3YtgiNgtxWmqPkJITBEYiSWuMu4AoW+v96zvTJYLmF36Owu2Jdr
	L6Owjsq/xHzAeD12AEv5HT6Gu3Qsx
X-Google-Smtp-Source: AGHT+IG37fo+p9U9K/BQXLTH02uBUwB2n/lqoTv/Cosxft6lXahHVw3E6hEbyvKq+w9tFJIaBh5n1g==
X-Received: by 2002:a05:6830:4986:b0:72b:9674:93ed with SMTP id 46e09a7af769-73670a7cffcmr3085713a34.24.1748625457300;
        Fri, 30 May 2025 10:17:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm659735a34.3.2025.05.30.10.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 10:17:36 -0700 (PDT)
Message-ID: <455de3ad-73df-4940-91a8-1416ead37b49@baylibre.com>
Date: Fri, 30 May 2025 12:17:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] iio: adc: ad7606: add gain calibration support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
 <20250526-wip-bl-ad7606-calibration-v7-6-b487022ce199@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-6-b487022ce199@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 5:03 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add gain calibration support, using resistor values set on devicetree,
> values to be set accordingly with ADC external RFilter, as explained in
> the ad7606c-16 datasheet, rev0, page 37.
> 
> Usage example in the fdt yaml documentation.
> 
> Tested-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

...

> @@ -1444,6 +1485,13 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
>  	if (slow_bus)
>  		channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
>  
> +	/* Setting up gain calibration for all channels. */
> +	if (st->sw_mode_en && st->chip_info->calib_offset_avail) {

More logical would be:

	if (st->sw_mode_en && st->chip_info->calib_gain_setup_cb) {

> +		ret = st->chip_info->calib_gain_setup_cb(indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	indio_dev->channels = channels;
>  

