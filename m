Return-Path: <linux-iio+bounces-14338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452AA0FE2E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120933A4619
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396022FE0D;
	Tue, 14 Jan 2025 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+y1JCH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3B212D70;
	Tue, 14 Jan 2025 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818752; cv=none; b=jFUjgZ5Vt/jSIzRNflwCie5vjYix85iNVTkLG9b9GlaP0rAtgn8CIIGZaNoxC7nu2fHQ+589I00j7vFrOpMsAGRbJq1uisdl7qJhJcbINL2JDAfHsv79eRSvZmT2Dzb3qjvfrE/noUU3E52P7hpEoxUBowN26us9rU1lwD0Cb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818752; c=relaxed/simple;
	bh=QjXQnC3m88Tvct8v6cQxi3wtUpqS+ezrv0Pa3DF25OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMOTD8h/qH371t0yCXAsCzD8ujlTPGnI2mNHYX15DoR+znAH5QItAKj6i56idHWT1kY/AmWIwIZuKF3W8HS40qmZWvWizk8UT/HTmAaWVGC8nlkGMDen6C91B09C51E1M0CBNNHF8qa/4McB04uJXMeAuY4/dH4B97KFMDXxVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+y1JCH9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6dfa69e6922so4843266d6.2;
        Mon, 13 Jan 2025 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818750; x=1737423550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oON0wCmXlIW0fT9gHxRj+F7jSIjXPNusV6zFg/CqJjg=;
        b=I+y1JCH9C5ZpQS/oDM/wov6lyTmz+Jk0tJDQtZRo07+GNyeVRB8nzZMVZp089Aeoz8
         tME2H3tx0sxabUyQVEvrRBGzIZKyUtm2dVE5YAAo0/cvkl9XSt3eAuDxFsPef9zqp712
         lz0wB9u3vlPAjRArd3EjJ0dSFH5Dg/3EGwsYkCQvMROzP++lvJWPyQaBebx/0aZAvL74
         sh52rlE5dTe9O2WI6e22cKOOybZ8V/OtMG66bdWOK0RSMaUNhSrQ3dIZcPM57Xc3gbhD
         Q42WmxOnKLrKtDILbUIl52GTElCaGAWrPZTNebUrVIz/z+tXfseSmp9cEkBUtTK5Rr/Q
         /ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818750; x=1737423550;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oON0wCmXlIW0fT9gHxRj+F7jSIjXPNusV6zFg/CqJjg=;
        b=FuQvDa3lyxyUvj2cKbn4UfFUaUA6q9/VaVeiJuepJoUvxMst8fXdOpq9uBYMhfRv6j
         iU54YEzEu4nlW8I/yvNVY7RWXIpkIEcv6jRpE8Kh0rVgCWpdsV5mLtWkLLdpqaJB8Zsi
         nWN8z2GPFTOB4Io8ZPJuR8baAsbIuH3RQ8jjAfC4s2Xrzy06cKcEsLt6RjvV9exmUPxW
         rmxykWKpUQd6vKpf6tWZATUAXA8ej4h9OMq8I8s/oB0yXUwa1j1B0TUXnojtosLOYe0Q
         ZyO3tD0hoocvIaAaknpoM235fOw+Sg/XeRWUvlqAF2eTlUaFdQCncd8goNTS1vemyk0/
         8wDA==
X-Forwarded-Encrypted: i=1; AJvYcCURVZDj/naRvn3lAzcZ/IOEWD04vrd7DCo0xH58itTUx1M9ZPF01xzO/NFHkch6CLHCtd0FKibAsyva@vger.kernel.org, AJvYcCUvjsPRcNRUuQ/hIdHpwYnkShMWCri01xRVGuSUr5oq0cmQ4/Mh+7cWMskpDxWAAfccmwPFz/QOn9VXSDwH@vger.kernel.org, AJvYcCV9pHFzj5XgD19shtK3zF4vfNFlIf8YzQxG0h3jgWbIsXAr3zTF87UhibQavxuv90Zv+VIYXLeFTk2J@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+ISiwIzTp8HGfxF0TJtXS1tjolm3r6uYzeVB+qWEn5MLzdjA
	R+8Pf8ytD+0To29PaBvI4YweLyB8cXi5NbnNlUsTlhZ/DHPKVz82y4AzDJmkfWY=
X-Gm-Gg: ASbGncvQ7yTtKfYKH0LDOhIRP+aIItOFL4PBTAzdSHivDss1Bhbp2eaCGqJOYD5d1Wh
	ivsQTMIvHWFFsa7bYon+rGtvcldRMc1a4KoRl8fEVCPZGWkanxF/r9cU1plhG42qNlMLgcXpR9h
	IJaBVBu97SDZkqWF17VdBjsocY4JopLDxSSHVgr1Lyd6xTc1Efb7CjOA4CEcWai9FgJ28ybS0TX
	pxSAw7KBWQLxXm1um8LjLrX+DF6aFXFOW+O2pskw3TN8PYOWK5wu41JEyJkqbgrhHxklwl19+mM
	ew==
X-Google-Smtp-Source: AGHT+IE0Bf3qQqbhV97CAlSY0dSPj/TIcn9mgqXUo/+eoaW7OZ/ZvtNzpffXTVpGg6E7SdwRZsVyHA==
X-Received: by 2002:a05:620a:244f:b0:7b6:d089:2749 with SMTP id af79cd13be357-7bcd97184demr1263663685a.7.1736818749740;
        Mon, 13 Jan 2025 17:39:09 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73250sm47519736d6.79.2025.01.13.17.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:39:08 -0800 (PST)
Date: Mon, 13 Jan 2025 22:39:03 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	PopPaul2021 <paul.pop@analog.com>
Subject: Re: [PATCH v1 15/15] iio: adc: ad7768-1: add filter type and
 decimation rate attributes
Message-ID: <Z4XAN+aVJwChONzQ@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112130426.29b660b1@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <b88a167234c49a66792c0d3e182bb40b5b695b5c.1736201898.git.Jonathan.Santos@analog.com>
 <5d492f38-b103-4850-8d13-ef1fd1d2c483@baylibre.com>
 <20250112130426.29b660b1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112130426.29b660b1@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 17:50:56 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 1/7/25 9:27 AM, Jonathan Santos wrote:
> > > Separate filter type and decimation rate from the sampling frequency
> > > attribute. The new filter type attribute enables SINC3 and WIDEBAND
> > > filters, which were previously unavailable.  
> > 
> > See related comments in my reply to the documentation patches about wideband vs.
> > FIR and decimation rate vs. -3dB cutoff.
> > 
> > > 
> > > Previously, combining decimation and MCLK divider in the sampling
> > > frequency obscured performance trade-offs. Lower MCLK divider
> > > settings increase power usage, while lower decimation rates reduce
> > > precision by decreasing averaging. By creating a decimation attribute,
> > > users gain finer control over performance.  
> > 
> > It seems like we would also want a power_mode attribute. We already have an
> > attribute for this for used by accelerometers so there is some precedent for
> > such an attribute.
> 
> I'm not sure that attribute was ever a good idea :(
> So would prefer we don't use it again unless we are really really stuck.
> 
> Usual assumption tends to be if anyone wants to reduce power they
> should be able to do so with other controls (i.e. reduce sampling rate or
> oversampling). Those are easier to interpret than magic low power mode
> attributes.
> 
> Jonathan
> 

I tend do agree with Jonathan in this one. the power mode is directly linked to
MCLK divider, which is under sampling frequency now. Basicly, we assume
that higher sample rates lead to an increase in power usage.
Even oversampling does not affect the power mode. 

Configuring an inadequate power mode, depending on the mclk divider, may
result in malfunction.

> 
> > 
> > > 
> > > The addition of those attributes allows a wider range of sampling
> > > frequencies and more access to the device features.  
> > 
> > 
> 

