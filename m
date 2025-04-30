Return-Path: <linux-iio+bounces-18899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4733AA4E3D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198274E7E12
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1A25D1F7;
	Wed, 30 Apr 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ngKm6RbQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571B4685
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022594; cv=none; b=npSwij8t2NP3JaYz5zHSFpuLSw/uq+mHSkJChQH1t5EkwXr8HCwLMxHlFol5jZdxHNoOcSIJFQSwQylIanxPSrEPp91oAIZNpimygrZ2H/ODqWlPP1fPOVRGuJllNBsM/3895deAcs43gnst9QzQqtIk+8ICzCISkpSmAbRCu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022594; c=relaxed/simple;
	bh=AVLzC4whPM4VWTPc+bxpJ0J6VswlHdbhpVLvOK4rnO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj8QOWWuuHQWzDGwph7EC8CDVaFGVtYbnykc/lO3XviIDa8LEGpei16BaHRM2am8GKGAmAXlKwxb3BJdmjIBoo2P7mm/1datC///gDniAXCoUMBn5o2+g9RunUZYf+QA0EvsDVAHyvFmpJjJJACekeS7bAwn+GfmKJaVQjC3LCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ngKm6RbQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso69957955e9.1
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746022590; x=1746627390; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YpL2lxVH2obCDZhbOHkOyzZwrFHmrVV/PKeHOtCQPg=;
        b=ngKm6RbQPAgNtAOA7skACgSoOq/rF8hQgtmZwzGCajDUtH9Uo5kAE1EAh/oBLaP74A
         9SHfC/nt3EoDeS/u6Hlcl87k0n4Wscc3YMWRcpJUlZXwy2MWX3DWPKn9WJ2c61LY7cFF
         b3JBG9z1+YVvb2kAj2kLVlCLdvFtqYNWev+3iPFN3QZJJYQ7LbNAM4Ll31YY8uewUnB0
         wD+hvd30JCeT/otWBRXiR572NxBDljRlc+z3l1ubZHq5ThKkFKYALSrrIdCRoPAbGHl+
         HELI8HhWbA1tK32jIMgg8dWSf196k1kOlvOIb7nZEl66ii9gaMKbCBKS1HTqX/FC6+Ik
         e5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022590; x=1746627390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YpL2lxVH2obCDZhbOHkOyzZwrFHmrVV/PKeHOtCQPg=;
        b=bSb4+RTECzYq9CmhTHwsAPIYlr8fX20UGxb+fczPdg70P+P7pMj3UrHPj/vxK38xrG
         qEVbzrI1GYzom1rBK7CBLg98d8zY/QVMDgXv7gdv/jalm5CiaFcd9X0Qskj5b69P9Eaf
         ZXDDYGkrs9hWcIwazUo3a6SYS2Z+3Y5cLSxKJ0mQvdQ9lxjk2/+cDj9DO+yQaHNygpar
         LUmjL9dvM09/JErPgx5CKQyjftaZuRFBIlPn9FFnqbVMjg4GV8jnLogSF7DrKqRsURwU
         q/BEC9mNx+BKXTAot8jRlYNq9n3D71kLPLSwwUFlbB/15CbTtvshJ3zwYRoNnEWmP8rC
         PQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCX5Uy78m9XbiuoW0jVs+N2lfPQSgyCix5ZKiAiyjsPQF3STJInuyZrq8JSFXR0i2kATbf2n/MuxsKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzo/SVahueQG5GbL5SUu3BPe98iT9H1PkPZ9TnTqwdqTOULX5
	rtnbiUKfogmAxFQj1WAxUhgx5l6fQBj3Ys+SHtnTsw641tFdI5Y41keba51lGZSO9hOXQoc040t
	5
X-Gm-Gg: ASbGncvdcUNH+FvaOrqB5iDYOzXDWNabNCzmWqnXCFuLOyXQddVrReRd1t0IHYYHXcY
	Y+v+VAEncduUi7N11ip86P6/j5rUF8onP/mVNan8rnCh7YskIb4+0rEsinNefIthdX8zjsSOROs
	XCtQg/NAlaqed7suWzFQMf1w+qbNt5EhP5qS6StX3MJ6xHSY96LhRpW/FyZm3wH5DrUxsnMbu9d
	XofO2YANT6Sp+ch7EXiRHIeRY/MAOs9tiDnm1mmABzYBzXySKCwLO+n/jkukktFrvA4og8TBjXI
	2DziXNM9mwef8wihThJVKq3L1y92BbEAzbN2rkOPFdVD9th/dYm0S/xYNIAjN9Up9A2oVITZXb4
	5gOqGnTo=
X-Google-Smtp-Source: AGHT+IEbrCNFMu0SFw520s5aIW7UoiCgn38+jJzqIxcI9w0ze0IO171/JSl/nJcS9fmtEe2edXcq1Q==
X-Received: by 2002:a05:600c:458a:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-441b1f5c846mr26732225e9.21.1746022590215;
        Wed, 30 Apr 2025 07:16:30 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad81c19fsm41853825e9.0.2025.04.30.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:16:29 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:15:19 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] iio: dac: adi-axi-dac: use unique bus free check
Message-ID: <l6vu54ltxd7pydkzl6xbbq55gedumzbsllfxnljyngwcg4c6zd@w6qxgn2vby75>
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
 <20250409-ad3552r-fix-bus-read-v2-2-34d3b21e8ca0@baylibre.com>
 <Z_alpFoaQQUlWdfo@smile.fi.intel.com>
 <udqm2qkw3yrewmovua54twfzbsfduojc5f5uoj4nptxldpbbr5@75bb2pldwq7f>
 <CAHp75VfpgqNnLOn4n+Tf03mmLFMj36SsV7j06TvhEhyqmmGgVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfpgqNnLOn4n+Tf03mmLFMj36SsV7j06TvhEhyqmmGgVw@mail.gmail.com>

Hi Andy,

On 30.04.2025 01:05, Andy Shevchenko wrote:
> On Tue, Apr 29, 2025 at 5:34 PM Angelo Dureghello
> <adureghello@baylibre.com> wrote:
> > On 09.04.2025 19:51, Andy Shevchenko wrote:
> > > On Wed, Apr 09, 2025 at 11:16:55AM +0200, Angelo Dureghello wrote:
> 
> ...
> 
> > > > +   if (ret == -ETIMEDOUT)
> > > > +           dev_err(st->dev, "AXI bus timeout\n");
> > >
> > > Why do you need this? The error code will go to the user space at the end? If
> > > yes, it will be enough to have it printed there, no?
> > >
> >
> > This warning means something very bad happen at AXI level. I never seen
> > this warning issued, but it may help to debug AXI/HDL issues, would not
> > remove it.
> 
> But wouldn't user space get the error code and translate to a message if needed?
> 

depends, bus access is done also at probe level, you would get a generic
-ETIMEOUT, then you need to put traces to understand who is causing it.
I think the message may be useful to check issues, like a buggy HDL.
Anyway, would not re-issue another patch just for this.


Regards,
angelo

> > > > +   return ret;
> 
> -- 
> With Best Regards,
> Andy Shevchenko

