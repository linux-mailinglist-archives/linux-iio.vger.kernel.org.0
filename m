Return-Path: <linux-iio+bounces-19197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CFCAAC50E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B62B3A4590
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46428003D;
	Tue,  6 May 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OgG4NkIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81750280009
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536466; cv=none; b=adUgF8BypeHLomxQ1BorS3IO3v0xsKmfXBdwBRHJblF5GUvyylpfQj8JhzQj2rPv59aGLA3Z7KB5Znp4QaX8rAs8NBFaacZr325C5or9J1y1l0pjkUEc+jjIvqW8G58HbJC4uS0U2M2Apc8wgndfkNrLquM+4XtTeNG8avbAq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536466; c=relaxed/simple;
	bh=EYIzdNUSbqL34NsMyE7Y2APXIRDyKxmi9aFbMvhERo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4MgS6dARIVIGSTZqZJp5u8HMdZqmKZxSAq6NZdjUFBB8l6lgtL5+xi6ANHxcgOD1yisALhtDcPkNOUKvTA3qiPBh0IpN9GjDFOLOsSo9mUXOtiu98IcypbG6FtJdOQV3yNP2q5dJ7VNCluyuaDCCzfz7PxIEbh5KJwTCvIRwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OgG4NkIe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so31664845e9.1
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746536463; x=1747141263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GNu47zJZYWC7rY+oMvhGzhb+HWxLrtzvrVuXSwaRas=;
        b=OgG4NkIeQV9yvJtxZ8Lw43o0/ckaX4LanHJRDpStFSM7SYnkviUWtxFkfVr1sEVDfC
         WBL8SFUUkQfBC5ytN57izGSGoRoRu3hrbiaEH8pWATkT6GZ/iwDQeUJFwfoi1Y089KMr
         euua59IZdnPMK4PcGGsh/TPybQcS5e6+3hcdUJKyrl2lzuCFs/k3l4cdBBN9mpHBu0L7
         hywvHRrlTOUO3ccH7bK6CU+aJ0fDFn5haCvFl1FwRAuh2SKEV0cB1ng8mE/F6mJ6XRD6
         faXiu1ezjMTOTb/uBwvp+94sSO2Bl1lefTm6doNiI1seQZ6gobcr7QI+YvXx49wCQ7SF
         fBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536463; x=1747141263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GNu47zJZYWC7rY+oMvhGzhb+HWxLrtzvrVuXSwaRas=;
        b=HmL2Cs1Cmh/BXGHalEtP5VhnP0xczYoiP01xpu7kT5J6P6mHW6EpzUGzAxtGvXHGAr
         xAX2zne7h1/P1Vow+bscJ9osk8M3rRcWw7bGKqvylNh5NgE87bm+5PsnTEn2S7hjYbrr
         InR15KeW/O8h7MkHaZF9KcPGtBZr7WxA5Gr4RVxHC+YTtY9N8JAZPi0U7iPnCaFI+sde
         0QV5iAuA6Qqqs626MPRsVvYJoxrMYj3oyR8bLbD9ER7ByCVBhWB1yBKuzjF8ZJBlUAiw
         QP4LUNj/SL6akOYKp65V1211Vc8bgcHf1Go0iBCkgThJcg4p4TdT9MuLtkqWO0Ck7ss1
         adCw==
X-Forwarded-Encrypted: i=1; AJvYcCURA9Ml3mlG9U/y6yji2leAPbzB7MiH17F6xTX1+yZ56ES8ZtzGW/0kVLcoAFm9pLojqGAVkl/EjM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqHO9bmoaEODfdSBSR0aJx4d4C/fhocdBD8fY40jclI5aNe5s
	oxWtcwStPcG8RsC48Ko1dcsX21uDzkWaXNOmQ+ZkCOe4UNC/lXibgAj6bvemYWA=
X-Gm-Gg: ASbGnctF9L9DQUlG0Ll5pPIUzsFR2HruFoAhx+dO/aM5n9SKGAfqQKJ9A7YPkNscCKP
	RGdDR0Pn1UudqET+UGVmPGif7B5Hczaq6qYGWS2Ti992+rQiq4W/qqTXjII7zhPjysHkgdN2xRZ
	4saeARA5N0HTxueqSOAbZQgdWOvdKfJ2/yavAzr7mvZebYEHM5pidigJ6ArFAlo0iymrtcJz+xc
	cxqF4zdHSHzJZHbrQRIZ+YQ/Y8EyguH6hJ+uRpmxRFtJgjOfSAJtVsmozymB5ma0/CkdsujmNii
	mNrDEA8VJYvWyPEx9I9nqJ0aZi+4rdQFv/8/i9JihZbscuAZ6Ey8h3nfcxZmJpmzltrbmlps2fX
	gDemwnBc=
X-Google-Smtp-Source: AGHT+IFxpsDPUHLkbEcc8hCvw9rBmY9SPds0zPZORDrnRUntARZMdA/JmVZMURS6+lD0arIS4ak9Jg==
X-Received: by 2002:a05:600c:3513:b0:43d:7413:cb3f with SMTP id 5b1f17b1804b1-441d0fbd2f2mr24762665e9.5.1746536462594;
        Tue, 06 May 2025 06:01:02 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20aa6sm217376285e9.27.2025.05.06.06.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:01:00 -0700 (PDT)
Date: Tue, 6 May 2025 14:59:50 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad7606: add offset and phase
 calibration support
Message-ID: <k235e2mj4od3cll5wstpl4oethlkd6d6xytow4d4wzfcsxkx7y@wj7dh3zhn2sh>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
 <20250502-wip-bl-ad7606-calibration-v2-3-174bd0af081b@baylibre.com>
 <aBTLBvw_88hQBbns@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBTLBvw_88hQBbns@smile.fi.intel.com>

On 02.05.2025 16:39, Andy Shevchenko wrote:
> On Fri, May 02, 2025 at 03:27:00PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add support for offset and phase calibration, only for
> > devices that support software mode, that are:
> > 
> > ad7606b
> > ad7606c-16
> > ad7606c-18
> 
> ...
> 
> > +static int ad7606_get_calib_offset(struct ad7606_state *st, int ch, int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = st->bops->reg_read(st, AD7606_CALIB_OFFSET(ch));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = st->chip_info->calib_offset_avail[0] +
> > +		ret * st->chip_info->calib_offset_avail[1];
> 
> Something wrong with the indentation.
> 
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ad7606_set_calib_offset(struct ad7606_state *st, int ch, int val)
> > +{
> > +	int start_val, step_val, stop_val;
> 
> All need to be signed?
> 
> > +	start_val = st->chip_info->calib_offset_avail[0];
> > +	step_val = st->chip_info->calib_offset_avail[1];
> > +	stop_val = st->chip_info->calib_offset_avail[2];
> > +
> > +	if (val < start_val || val > stop_val)
> > +		return -EINVAL;
> > +
> > +	val -= start_val;
> > +	val /= step_val;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_OFFSET(ch), val);
> > +}
> 
> ...
> 
> > +static int ad7606_set_calib_phase(struct ad7606_state *st, int ch, int val,
> > +				  int val2)
> > +{
> > +	int wreg, start_ns, step_ns, stop_ns;
> 
> Ditto.
> 
> > +	if (val != 0)
> > +		return -EINVAL;
> > +
> > +	start_ns = st->chip_info->calib_phase_avail[0][1];
> > +	step_ns = st->chip_info->calib_phase_avail[1][1];
> > +	stop_ns = st->chip_info->calib_phase_avail[2][1];
> > +
> > +	/*
> > +	 * ad7606b: phase dielay from 0 to 318.75 μs in steps of 1.25 μs.
> > +	 * ad7606c-16/18: phase delay from 0 µs to 255 µs in steps of 1 µs.
> > +	 */
> > +	if (val2 < start_ns || val2 > stop_ns)
> > +			return -EINVAL;
> 
> Wrong indentation. Please fix in all places where it happens.

as already said, my code is correct, 1 tab after the if, anywone knows 
why git formats the patch this way ?  

> 
> > +	wreg = val2 / step_ns;
> > +
> > +	return st->bops->reg_write(st, AD7606_CALIB_PHASE(ch), wreg);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

