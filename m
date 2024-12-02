Return-Path: <linux-iio+bounces-12977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C79E0D92
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 22:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2237FB29867
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07D1DED71;
	Mon,  2 Dec 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SThf1rvm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9C1DED67;
	Mon,  2 Dec 2024 20:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171756; cv=none; b=ddscd6rWOTwvFL3Lg07fO8LFX6tdhcdmqOWP31aHPLNtQpvnFSB54wtLZt8k1cQSnI3UTGb5NtVdy1yk6aNMm7/+V1OV8Xvu6S4hnYPGx7Mc0ac/Ttix4jndT/l08Zb0RsYcaWvn3NkoEEG6em+hkgKBInvh2rXcdRbgEqgSgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171756; c=relaxed/simple;
	bh=K0SRLS1zBinq9uePKXPGIuJwFWqSYthf1EILnl68Y2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGhcvYSr4Ob+6EtYMnbMwQuzBtxTsramVrhJSmb75dJsQEw1INV4C2Xv8v+8PV417owklP9LYSbg6mXOx+TO6SftuAY2/nubtmnxygrLEWpx9XvmbMJit/ypOHGWOJAVQOihkDNQ/CGtpf0/lQ58Q4MxCdAP6zTI/9KjytYGPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SThf1rvm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a95095efso33766375e9.0;
        Mon, 02 Dec 2024 12:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733171752; x=1733776552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhcWIpnby9xGQEV4fZR6/EyTnMePzY+oDN+hxtPpgdI=;
        b=SThf1rvmnZ5EwFLp0x+VZtT4fdTrpuE+Rw4w2tOa0mu5S3jW1WBnLlZrBNmVvpjNjU
         zRQB9nytMlea6aXyTC4X9mEM/wIOSW3pLAMHfY/wLZx5emQdEGKQjQMUw77kFqnwlPAX
         20YsBEg1burg10fpu1x1u9jpefvsx/YxStt0u0jmcATg5K+PSu4D3LL/4FvoUYe9vFwG
         Bfn1Kr0Q2brXsh+65E7HSbRdKTYaj6od6qVbfk4x3hJi4YwMJKnNElHEZwSGDScDvs0L
         O4TTSKSIJyKhm8BTss5LtKKpFyv2sp5nEdv5qe5HsVFG2iuXOseN+dRy1xcn+yJBMODX
         Izyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171752; x=1733776552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhcWIpnby9xGQEV4fZR6/EyTnMePzY+oDN+hxtPpgdI=;
        b=id/b6GpI/jpnp4fFhuVdeJkZLY6PEI/Wy3a37bWTK0G2/DiR8R21dwNRz1yiTlHhdA
         z9KRGu4B3htyVeuBKgZ220CmWy+LmxP6Z59i/+Olm3KCBl6sdSQUR5JvYrOKtfVrlV8C
         9V6pC4yTEzjPPI4N6FsafX1wOQ4uMjg7M2G/R171YlfqcLxKIhMC4FpWHFszYFgkF400
         QubkxjCfrDq5VbDXtLGjG7pTi18mLd6QSSxuQlxmZ+VZp5EX9znJ6w15MalbA1nwC5Bt
         Dc2xIjRF/Q4oNyk4oCfgm7ue9MaM2LtgOlR9XEmF2vYiGp/yeYOKVBX/whZWlzm2/Tvu
         zGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVWUltzOshFu9R5YxhhH9WOkZlzncSY2AXo0/riMHt+/JyvMFbifUM+hP3Fgm0RfbonSAshRAbm37c8@vger.kernel.org, AJvYcCX+p2VVD9rpNu0SzBUv/wlaAeOs0X68lHdv98cbHdf0JIKVzkg+jBGs5rAxrD/zaZ4LCVFegj/8qUTB@vger.kernel.org, AJvYcCXsCe7LdASVaCgUC7aPAeurebf40yMaXGpV4+jXlvAWokr18u4AUOifAdIKu2NDn0eaNnPynVvQt4g1S7xD@vger.kernel.org
X-Gm-Message-State: AOJu0YycGTiOgTk0o9vSXQqRfjEDitza2g3Ll0hzS6GAonXUPPgGwFCH
	Y4QVem/550o0b4zpM3gE6KyZCX+eo9n4iy7GsSXJUgdDITnAZEY2
X-Gm-Gg: ASbGncusHOkN7FtY8v8+voqsn7XLYBEeeqOtTDmypmTMzJxOiHXIyW6pOT+NvpyAvGR
	LVAur3u/QUk74vy4Vcz0DTqZXyIoTHbK2WGrGT3zO0Iy+MmCD/AHy94J+MHwkyD3xpupjKJiHZc
	TvNqo16F/8fvPI4F48fRz18CNzPYzch/yddSWfSq5/05QFguYGB+h2kB0hPwxtKPdyZMPzQBnD9
	+OYei8/iVMAkZQ8LOrLlESos8drYzXDRrzqNetOLtdCLzpiitC3TNLsZGLX
X-Google-Smtp-Source: AGHT+IEG0celYf1rLgnMGys32FMcLMcNhKL/v7R07oCF0IJqmSNqUGYsJbIgcTev0ZHvzgfCw3GxUg==
X-Received: by 2002:a05:6000:18a5:b0:385:df84:849b with SMTP id ffacd0b85a97d-385df8486eemr12642549f8f.11.1733171752453;
        Mon, 02 Dec 2024 12:35:52 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:ea8a:93ec:a066:eb25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76a8e0sm196001075e9.15.2024.12.02.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:35:51 -0800 (PST)
Date: Mon, 2 Dec 2024 21:35:50 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, u.kleine-koenig@pengutronix.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: chemical: bme680: add power management
Message-ID: <Z04aJg7eoBR9CYKe@vamoirid-laptop>
References: <20241202192341.33187-1-vassilisamir@gmail.com>
 <20241202192341.33187-4-vassilisamir@gmail.com>
 <Z04N6GUSL2H0zt6_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z04N6GUSL2H0zt6_@smile.fi.intel.com>

On Mon, Dec 02, 2024 at 09:43:36PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 02, 2024 at 08:23:41PM +0100, Vasileios Amoiridis wrote:
> > Add runtime power management to the device.
> 
> ...
> 
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = __bme680_read_raw(indio_dev, chan, val, val2, mask);
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> 
> Side note: as long as idle method is not defined (NULL) the above dance is
> already taken into account in the regular put.
> 
> ...
> 

Hi Andy,

Thanks again for the review! Indeed by looking at the code a bit, it
looks like the suspend callback is being called if the idle one is not
found. But I have seen this dance that you mention much more often in
the IIO that's why I used it. We can see what Jonathan has to say as
well, I think what you propose, simplifies things.

> > +static int bme680_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct bme680_data *data = iio_priv(indio_dev);
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	int ret;
> 
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> 
> Either this is broken (if the above can return positive codes), or can be
> replaced with direct return:
> 
> 	return pm_...
> 
> (but I believe it's the former and you wanted something like if (ret < 0)
>  there).
> 
> > +}
> 

Well, pm_runtime_resume_and_get() looks like it returns 0 on success and
negative value on error so I think the if (ret) is correct, no? But I
agree with you that it can be simplified as you proposed.

Cheers,
Vasilis

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

