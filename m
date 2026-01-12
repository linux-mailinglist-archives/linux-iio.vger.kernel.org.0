Return-Path: <linux-iio+bounces-27633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79CD11ABD
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD57F30C38D6
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D66277818;
	Mon, 12 Jan 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLv8bhia"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312E27A133
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211797; cv=none; b=nnz4DmNb2sRMBDM+5skW79bFOKydvJx0+JaTxayPIgICuZbQtpBTYJSuFcXZAdJBYx6G4/GIWr6j+MebXYdJ5t1+ZYS3suFQzfbI2bYln3diu34PCH2rTyz18mynRyVZdzUqLCXp0+jY1dvqrKIp/py2UQcC/oHFvzkEyFJaVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211797; c=relaxed/simple;
	bh=3s/FMAtzszYcu9PdHJfF317mWoWH9YpJ2wK1w4fpfk4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIiuae1A8tNRgo0XfwIaGNBdS+nx3quh5s+ePu6jqsS10i/F/AjB++ZMBbCnKz8BMDfLDPDKuX74DB07bWVd0IL5tGV4Q1FDg05UDGvcxCT0847hfGI9d3i5YF9PD6tBLhk1Wg++vkMnPhU6vFN7dIR01dRT4DRUyI9uMAZallU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLv8bhia; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8907f0b447aso70910886d6.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 01:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768211795; x=1768816595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MnATEC3zLg0tL86MlP2EV/1JLZWPopkEABO3EE71r+k=;
        b=kLv8bhiaFBSoPdw8udk652N6eQ3DrGMy7A8juzduVpU/b+SCTLEkYlxl0MUQdYjClg
         vFZ7q5WmR7K365Mkf3+a2O3mYsmFba8dzJ0sgM0BzDL+WhrjX4mFAq5prBzTnUchtRSK
         5j6Jlzcp63ldFzkcCPh8osqTfFcEyedyrSJVg76j1C14HVkkFXddPRc07q00sJtwhBmZ
         3JZUI/ZfAxXC8H95GQMlQ+aCVEufhjbXBl3wUoe6s1yawKQ2bZOO0W5ekxvvmVHZ5CXi
         hz1oj0XGX2AFF3qC/+98UfqUgT1xe/VZND0VodCc9vcBWq8dZwOpBFRNgLG9Tn4wAPBo
         6XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768211795; x=1768816595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnATEC3zLg0tL86MlP2EV/1JLZWPopkEABO3EE71r+k=;
        b=WOccdXQVm8crIabd5fOAn1YAynBdCF/BEd/K1kVjSM0up8YCtCm6YtTjGki0zuAfpw
         JBjBsbKHMGT3j81yD1ld/Wl7MeSVfxF/TIeOvd9rqLw1gUS4Za0mPgpTRkHYYZaOML6U
         RhgMAaz8OQaHKSYWnpPywUStVzjVN948QAfrQcjlamDUrO4qpFLXoh5kveVmpF9qmfzz
         xGlOipKWnCXkuXrLJ7I7EVe1qfkUlzLZMCzFtiY9yPAyHzojz4DkhoJV2ajlBDM2ynIA
         tLOxmE0jMuwwDX5YEd39Q4ZxAX0rEYf9WcHibet0UbVj/RltxugLESQdaLRBrWJh2+Xg
         n6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW1xK2s6gZQ2KHJWblypCnuKybJpfsALQj1niv/XRcorPXgI/V1cSBASj6DPFLRFYkkVJISJABbOGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJwanehU1KL5qBiCBzbSMdOVkO8bYmY1kbtsqCZWJ8LlGEViI
	tA6LOHXnoboAwTFhfjb7+i7ARSjXBWSCdNl0vDLYB3ftkt4UEqAamjJi
X-Gm-Gg: AY/fxX40ccfpGUHxgzc7twTEYb6YV+szEfQgor60V4c+olXciYk07VRqd+DRillJXGR
	Vy2mk9EEHjsGNMhHDppLg/6Ls00iVeeCU0cN7PmcPru+cq4fZYHYrVgA9nXGZLCwg9WtPss5WvY
	e8IWDC/0XngRSgGOBSqiXuy76xcDyA6j84aXanoPuo6tOGk1huKf3X0SBHk1m3QS7eKxyxbzd2/
	eQISyB00hqkpstfXDALSbYbitVjVJYnxLOr5GI3vnEzuSxS6jx2UFMOYF/iNL7R482Bzr50QGTo
	7Zp2y/fpX8vzLdXF9vFvu9dWwOXd42K3hjKKLPy6o19GXr0geJ7Iqd5PA0Cda21yWsBAFeqqfVa
	5Ay5mjNuMmmDlrRCqCqALfj2FQHcxWw5AbDA/koQWyRh3wBIAO2sur18GO10omdQUMn4vkIBMp3
	MrMXfl08iOpI9u/N70rvcq3cvK42njIcMUVbuMKMXcjzj663PLbg65JoWGt+BG2bm4O+Tt+z1nx
	xTx
X-Google-Smtp-Source: AGHT+IGfjbR1JItQWWDS/6nxRJ8tfrCJBireKBKEmFX+tFc5HJk5PzGCIGvKimxXJ2znJZjE+wGwRQ==
X-Received: by 2002:a05:6214:3bc7:b0:880:498e:a63e with SMTP id 6a1803df08f44-8908417a374mr295137846d6.2.1768211795213;
        Mon, 12 Jan 2026 01:56:35 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2aa5sm135606526d6.19.2026.01.12.01.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:56:34 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 12 Jan 2026 09:56:25 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <6hcqrcy3meskddrklb3jtlpca2snrs4upwms56lhq7mkes7krm@vdiaqkfc6lgg>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
 <aWFPEa9HI4wmYLpn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWFPEa9HI4wmYLpn@smile.fi.intel.com>

On 26/01/09 08:55PM, Andy Shevchenko wrote:
> On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The driver is based on existing PLL drivers in the IIO subsystem and
> > implements the following key features:
> > 
> > - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> > - High-resolution frequency calculations using microhertz (µHz) precision
> >   to handle sub-Hz resolution across multi-GHz frequency ranges
> > - IIO debugfs interface for direct register access
> > - FW property parsing from devicetree including charge pump settings,
> >   reference path configuration and muxout options
> > - Power management support with suspend/resume callbacks
> > - Lock detect GPIO monitoring
> > 
> > The driver uses 64-bit microhertz values throughout PLL calculations to
> > maintain precision when working with frequencies that exceed 32-bit Hz
> > representation while requiring fractional Hz resolution.
> 
> ...
> 
> > +/* Specifications */
> > +#define ADF41510_MAX_RF_FREQ			(10000ULL * HZ_PER_MHZ)
> > +#define ADF41513_MIN_RF_FREQ			(1000ULL * HZ_PER_MHZ)
> > +#define ADF41513_MAX_RF_FREQ			(26500ULL * HZ_PER_MHZ)
> 
> We need HZ_PER_GHZ. I think it's easy to have one be present in units.h.
>

26.5 GHz is not going to use HZ_PER_GHZ, so for consistency I think it makes
sense to keep HZ_PER_MHZ for the others.
 
> ...
> 
> > +#define ADF41513_MIN_REF_FREQ			(10U * HZ_PER_MHZ)
> > +#define ADF41513_MAX_REF_FREQ			(800U * HZ_PER_MHZ)
> > +#define ADF41513_MAX_REF_FREQ_DOUBLER		(225U * HZ_PER_MHZ)
> 
> How does "U" help here?

not much really, will remove.

> ...
> 
> > +#define ADF41513_MIN_INT_4_5			20
> > +#define ADF41513_MAX_INT_4_5			511
> > +#define ADF41513_MIN_INT_8_9			64
> > +#define ADF41513_MAX_INT_8_9			1023
> 
> Not sure if we want (BIT(x) - 1) for the limits as we have non-0 minimums.
> 
> ...
> 
> > +#define ADF41513_MAX_CLK_DIVIDER		4095
> 
> Sounds like a candidate for (BIT(12) - 1).
>

limits for INT are taken from the datasheet as is, so I think it makes to leave them
like this, as for CLK1/CLK2 max divider, indeed I can make it (BIT(12) - 1) as it
refers to a 12-bit register field.
 
> ...
> 
> > +#define ADF41513_MAX_PHASE_MICRORAD		6283185UL
> 
> Basically I'm replying to this just for this line. 180° is PI radians, which is
> something like 31415926... Can we use here (2 * 314...) where PI is provided in
> one of the used form? This will help to grep and replace in case we will have a
> common PI constant defined in the kernel (units.h).
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

kind regards,

Rodrigo Alencar

