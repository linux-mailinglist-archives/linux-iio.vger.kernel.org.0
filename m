Return-Path: <linux-iio+bounces-27659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB89D16869
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 04:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA323029C58
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD034A782;
	Tue, 13 Jan 2026 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFI7UuR7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7323D294
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275155; cv=none; b=CpvFf58VQFtDeBYkrOvFHxiEiGY3F3gPDK13ojqurUqaTVvRoRCPFRc/RqaUYTlfYa2yj8pRC2Y3lc3/L2EWR/2DD1WBqLCT/VFzbPWStSvCc6GPSXjO9h5P1iJu/bOI6dkcZpRxzi2KTqvXMin3HRnyeHJepBQTPaIIBWHVrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275155; c=relaxed/simple;
	bh=VBvnDLdfB6iwcfRLrlJ/kuNKTe4GcJzd0Rz2MGm7M04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7xhSP8iHTYDx9zEvqGb3wnfdc5S23xT8Sn9Ox7qID7YqCdWp4CDsBuc/Q/DOZuarvpen+94DQzwi/qyd/2bcVsslPuwrU9drzZ66tx/cqaJRq9wJBatnUybtEdyNI0k64B9VtvxPmaSLBtJVFgLe5rUtwL7SbktkOVY397GI4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFI7UuR7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ee12fda47bso10189811cf.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 19:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768275153; x=1768879953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oV5NIaorlKMCTvp26ZszHHcSIm+HDcOR72Vp7/q9+SY=;
        b=cFI7UuR7lRv47brkD0FFaMhFUHCkWsJjAAh+BbAMNDTigoAMpCW22c3LJrMPEIsXJq
         PglKf66Lc52ZEUDqLzl/Pc4Fqdi6j4I2SQn0pO1OXqEnC172hCPxdkG3pGlhJe/EZ8oN
         LqU7YYp0dRtV6NhahAzcjUGAXGguNPXdkKu56tyQT+98qAkLZKAUGEq0CfxYQMKfRkCe
         a4EB/014DWzbnjGveCJPyaHSFr0PjfXBu60o9zfOijQajeROTwiquMTSSDNN+vFX2sbI
         f90i6DnA+BQ9rZHv1/J6lK0yo0DSXsVGIcPkdcGNFwJy2WSKIxPGlKc4xr2FugXZN5uF
         G9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768275153; x=1768879953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oV5NIaorlKMCTvp26ZszHHcSIm+HDcOR72Vp7/q9+SY=;
        b=tO0/4638vSTWwMuedAAu5h8ZTdwISYjfV9GaH4XiuCy7Bnx7gB6TSMKoU4KzHOPNR6
         ArU1gLv7hkj9QWOpu0rNKaGynQnRQwPSIKoswtojlpSSs1YpH4qqvNOJCo7ElG1GYGgN
         vk3/k0zLshFb96GcTOfsTzkLL0yTQnl6X9fViJLSsZrjWb2oMqMHllprCGB+bnAeIrnM
         OJp5AIhytYs5r9ZtlqIAFq4rBlimLo4OYmsbunh+pfciVKwPO5L+zNOsjCYMud0ISsUD
         vVLMAenWA/eOkh/tXXoZgYTyjFdzkVDBXYFvTIPto7cOBTioI666hF2C4Np3aq/WuaU/
         qUPg==
X-Forwarded-Encrypted: i=1; AJvYcCXFxoDnM9cNPSm4oz3Csgg57QUnQrZqhKoZnPp1ygbh7cMfSZ3P1uZ2qeozk/MPgRMqR8fLBA3ZoWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8b+y2m/uKZjrFUdqEmxHudGzhC77wEITgFI7AKPP7OooqfTCA
	CZqJJ3hJMpNmEGQD/VOOTZtVC/nrUa0Pq3KimnTuWoimN5pzjG03uxYJ
X-Gm-Gg: AY/fxX4KWGkDCV3sYAuuzzVcx9BhLRwrXqVSDWvbD/wgOt1kllTFRXGx8s5eB85mq4M
	5TuXYspwHBmMDV4b7Sj0AkRM5Y1JkBOOe2PUPx/+CvsrD88uk5nuroWF7J0jNsCXiUnFjegO4wh
	rqOpK321XMcA0ELG96vds2b/NxBm/g9G8YzGgP1ZhRBRpDhGtH/n6SFgMfkpIyLKudeI2FqOnJY
	rF82BhWKazKAmXlLXsNFiPsDEWHWHLLW74uWYQ9YJ22dWht6lev/gyYLnvRKB5a/soQRdbVm6OF
	Vc9yhedu3sgRThSqyLFDjEyyDZ9/nYzpq3NBTOt78/yXBC3oOH4Xbq1nPKOxTNT7GzwYegRzC9X
	GiuQ9dyOml5IaEcMV+CEqW3M1Y6ZitobDOMm6MZtsW2+jEwgTq0k/c9BXof6YPcM84MXQYeD9rG
	JzJc1qRvyfRBnlSL36wbY1YCyHdQarPGwQNTV3V+8=
X-Google-Smtp-Source: AGHT+IFUp5OFF4KEikizn6MysRARr9EShs8KxKd0mg/n83f3PKFKfM8PRx8cj6fUpU2eiwtqBDh5hA==
X-Received: by 2002:a05:622a:211:b0:4ee:1367:8836 with SMTP id d75a77b69052e-4ffb48b6d14mr229624801cf.5.1768275152656;
        Mon, 12 Jan 2026 19:32:32 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([179.146.84.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077234ca1sm148878436d6.36.2026.01.12.19.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:32:32 -0800 (PST)
Date: Sat, 10 Jan 2026 23:11:55 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
Message-ID: <aWMG6+ORRTy4ll8d@JSANTO12-L01.ad.analog.com>
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
 <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
 <20251227155525.6d712f42@jic23-huawei>
 <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd0n+aTkdzMC53y9LrPW4t0mckpzmmud4Ez5gXbAdLeVg@mail.gmail.com>

On 12/27, Andy Shevchenko wrote:
> On Sat, Dec 27, 2025 at 5:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 17 Dec 2025 02:52:45 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
> ...
> 
> > > +/*
> > > + * Percentage and basis point units
> > > + *
> > > + * Basis points are 1/100th of a percent (1/100), commonly used in finance,
> > > + * engineering or other applications that require precise percentage
> > > + * calculations.
> > > + *
> > > + * Examples:
> > > + *   100% = 10000 basis points = BASIS_POINTS
> > > + *   1%   = 100 basis points   = PERCENT
> >
> > I don't understand the final equality in these examples.
> > The top line is as it says 10000 basis points but you have it equal
> > to BASIS_POINTS?
> 
> Also there are pp (percentage points) and others like per mille
> 
> https://en.wikipedia.org/wiki/Percentage_point (see "Related units" section).
> 

Hi, Andy. Thanks for the suggestions,but I am still questioning how
the percentage points would be implemented, since it is defined as the
difference between two percentages and we cannot use floating points.

Also, should we keep this approach of unit conversion?
Example:
value / PERCENT -> converts a value from percent to ratio
value * PERCENT -> converts a value from ratio to percent

Just to make sure it is consistent with the rest.

> > > + */
> > > +#define PERCENT              100UL
> > > +#define BASIS_POINTS 10000UL
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

