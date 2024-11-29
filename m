Return-Path: <linux-iio+bounces-12836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3109DEDA7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 00:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20471636AB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FD199E94;
	Fri, 29 Nov 2024 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQgiuqm1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E614F9F9;
	Fri, 29 Nov 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924265; cv=none; b=pRc6bL5GRmsYKf30sY8kMEJ/oHAzpX5veyd63R6nZOdmqxqMPMczUpYBEUgebqltkxByAXhVg7zldrNQEbZrSLBDfq1x1IzFrb2Ds0YZduKtEp/Y7NkJKEjl1He5f6rSjJeIuKdLhvCQwhhC9KpwxlCw/wFpMe2z+6TLxm6azIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924265; c=relaxed/simple;
	bh=jkdoO1NkDFpFBlCKtfkR94CgjFQ5kxMpKUY+e/6A+9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLP+IIpfXv9L153huffwHdWEj0qz+RYbjDlAtyt+2n5bBgwUUh5RKKM4H8F619/gUHYUKX7TYMMKqEBN5FzSXC8SacjoWrpGMPYOfvjwTqk8ISRrOeVjGQdDi5ULm459ebUD3kg7A+4SBeiD5k368LjICyWBeo9JXWXkqjxi2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQgiuqm1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a766b475so21647315e9.1;
        Fri, 29 Nov 2024 15:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732924262; x=1733529062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcWbAEzlfDDqzPtKprmN+4tMt/iXTCwU4JOmM2OQpT8=;
        b=eQgiuqm1juMPjCI8os+lGw99SsljJPYiW6iWj5lTlZ3TLV9wUAf73SwqJ0H0ooH2X2
         04tGU598Bqe9XouvxPtg6Eo65bsWSGAAXdiXoiFrMm4aykx+iT8+v81UKcZh8sJ0bqYL
         xOgYr0cyo7NbBwGVj2lslQoKSkylt7o1y5ColqPYz90FzwOCEqfkMPrY6i2LMwPe70eI
         L+1Ma7Ie15ZJj3pO1E/yNxkJjR5IdDC9DmifsvTt5xAlOiTuCmC6wTxSFOscBVhfBk6J
         ukiVEDlIpNeFNvF4ylgGXy5xe5Zwh+c7+EH6hs7VGCDKPFAGKTmQ7vFrz3N/yr+TM5v+
         Yx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732924262; x=1733529062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcWbAEzlfDDqzPtKprmN+4tMt/iXTCwU4JOmM2OQpT8=;
        b=YFwdHQddDmyzi+cTDbN3qjWQKNb1PtW4ld0QAVRXp/3vBobiYyJskaGQaQVU82eyPV
         IN8qVgGbXMbCfwzg2BkLylQ8hzX6IF99ydO1g1soR2Va9G15gw6xXlu9pAgbIfj3jlWW
         7vDXGIaT7YV6KN9YvJ/z7g/f9JcapSHDIm4lm3+0tmXvj4p7XYiTvHHFKaOdPhjAwggk
         j9ssMhGJxoHxBSMwqiJ6SDraTOYwZd4hRfY3dxkrlD7MG+UqvV+ijTfcg2tnumVJ2L3u
         1O7PtTGtJk75YfTw2WKEm2lM6Fjf713BQmVoECSSNs4hJDlGjmWT/X0GM0kdLKa7OiE6
         +jeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgvIEPQlkKiPmr7IpNbrd7QSVajmumDlSjEbLq+t5uT/vmUBzRhvxC+lnaA36AX6yQcBjVW+b8e8Jh@vger.kernel.org, AJvYcCUsFlvKBzKdscCh5LRIHMbHXpsdZ4vd+tadyYWUeI8LMXeE1INB/M0lYHLE7ZncXPvH5Aff197CZaDaU/oI@vger.kernel.org, AJvYcCUtUfNlm6mcWE2m2gmG3M0yZzEXrbdVHtGxk4pgw2eKW4nV/MOuUa/ainpLhhiPGiX3D+8RpDpGbHl1@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUhiN3ULWBPc6AWQPKsmvhzY44JRQkUkwqNjkDjw4BrgPbm3L
	xPSsQLhTIh6CwytnzYcbrRpFG5vvnC5FzerIz5IZxF5cM9JJcDkf37PRZW1h
X-Gm-Gg: ASbGnctHqqCkGVg7xUMXWhUHC0Sk/35ulR//KZadHQcG5FzBIyXoMrvogZgzdppg4QG
	UXGErQbWouNbbpdZBt0lgRYoJbeURJvi/iBnmEdXfmmQB2eumfHNLFM134G2fgEQFWCfR+0Y5tG
	w6+Zx+9cBiA5syo36Cg1bF0d5zVJkvUNDemZCIbrhFWYr3GEdEIPp6NiXm0+YBEeM/6CFAekF1A
	jPf3c/Peom6s5eWNFpMJGgZ1qxGRilcvfOHcUT1B4Bh+NuVt079VQI5UBE=
X-Google-Smtp-Source: AGHT+IFzVn0st36oaOl77PbCBfVjVQkqVH2Ij3vvuhjvZKMPsfe6O3ReZZTSbq9iC/PYq8Ts/UyXWg==
X-Received: by 2002:a05:600c:1907:b0:434:a0bf:98ea with SMTP id 5b1f17b1804b1-434a9dc3c40mr130248145e9.9.1732924261473;
        Fri, 29 Nov 2024 15:51:01 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:2250:4c83:a8d5:547])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbfa2csm68523565e9.17.2024.11.29.15.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 15:51:00 -0800 (PST)
Date: Sat, 30 Nov 2024 00:50:58 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: chemical: bme680: add power management
Message-ID: <Z0pTYltyzN7cbmIs@vamoirid-laptop>
References: <20241128193246.24572-1-vassilisamir@gmail.com>
 <20241128193246.24572-4-vassilisamir@gmail.com>
 <Z0nQm_HX326_xcSu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0nQm_HX326_xcSu@smile.fi.intel.com>

On Fri, Nov 29, 2024 at 04:32:59PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 28, 2024 at 08:32:46PM +0100, Vasileios Amoiridis wrote:
> > Add runtime power management to the device.
> 
> ...
> 
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(dev);
> > +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> 
> Does it make sense to read something if previous call failed?
> Most likely you wanted to use
> 
> 
> 	ret = pm_runtime_resume_and_get(dev)
> 	if (ret)
> 		return ret;
> 
> 	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> 
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return ret;
> 
> ...
> 
> > +static int bme680_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> 
> Ditto.
> 
> ...
> 
> > +{
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +
> > +	pm_runtime_get_sync(dev);
> 
> No error check?
> 
> > +	return 0;
> > +}
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hi Andy,

Thank you very much for the review once again!

To be honest, it was a bit difficult to find out exactly which functions
to use from the PM API. It was a bit tricky to understand which ones are
overlapping. Indeed, what you propose here looks better. I will fix it
in the next round. Thanks.

Cheers,
Vasilis

