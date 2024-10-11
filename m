Return-Path: <linux-iio+bounces-10476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6799AC60
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1991C26D3D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AE1D0E25;
	Fri, 11 Oct 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUEiWDj6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D511D0DD3;
	Fri, 11 Oct 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673439; cv=none; b=XR9gBclTRGZqUqkyadTrjrTCbdU9S4uqly5zdws9uDuI26VARw4E1NvsGSlRmKIpRu/V2zXnD4OVYUY9tkkZQb8QVortV8ZHo1aXIQXg3qNzPpWtoMM94rU79GdkWWWVF8P95GMSq1PnhxrFqGeEi1n5ZTf3jrxqIlOlkWKEe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673439; c=relaxed/simple;
	bh=WlP/FCifnOrKhbazzBzI81pbhMO5hkxne+UmSRyXtRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnu1DCHguERZ3ZGJup7Wh/VAV0zsIIstku96n9USiyZBHWUyMeXfGiVvVRrI9LCFnBAbXS0M6ksd05ez9I6AOsttvOFN+xrHatNQNjjcpfrmkgonmDalCxPM6qKP+IOqC2RRaYA/hiskC+/jkfV53CiTxmeNXxwp8fMfwyEI4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUEiWDj6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4612da0fso1820713f8f.0;
        Fri, 11 Oct 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728673436; x=1729278236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OsHWe2r3nFYDfmLuS55NyUOEjJaqs99PygKj8+ReFQI=;
        b=hUEiWDj6/cZvbjCfhANrG2rp8YVLRJndNQb00H1/FClzD1zldGggV/e847rk195PCe
         JzLO0z3baQT6EiMFAxP9zUmkcwPO6PH/JyJNCTeS5jP0Mp/ObGdbz+SbHBxvKELrUMCK
         GzBc6Nf8RIC/fhz9fH4eJ1WgMh4NxagzfgsgFHBkbUERyljFB+cDX0mzpovTMO+6GZjz
         kyvzPYuAwOX7AUMhcgBoGFNHmhP5L1lZoqWnbjR0Oc5vrniq57G/2aDlMeBoyPcIX3b0
         yvR8DzstqhMseVwiS2EscSscgFIdvJfPLOmQTIr82s2FwwIWmT14cicLqUih4Vep9XH8
         qE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728673436; x=1729278236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsHWe2r3nFYDfmLuS55NyUOEjJaqs99PygKj8+ReFQI=;
        b=TQxOaQo5zqiWfDT/e1N1+iMx08Jv9MpNWCzXPlg2BYHll1CMefpIdo/BJsoOqXjjgb
         dBQYQyV5PngM6V32hOtICsuibHk9FJdAmZJUwzEf75ppI8n+NwPaaKAtAlE/t0S7uB/1
         McUCxhvKIyL2OZvOXzvxxSm436i2INbwa2bkls8N/RtIAB3n9OO4jVQUN4Yubf6YW9es
         y5nX2LUHwLsIBohv+AuPpukd+Bh+paCDcivHVGZNh+5AuBYTDy8iZ7wtCsion3EO2oXn
         Wizpkg89Ch44BcPRVJV5L2/lNCcoLPmSywsIsNarqIuuPK20x4w3L0luy3LxokM8Ni3G
         VWhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFGUSS1DEbhnvIQQ2ekw4Ho3WB8pG1Fe03Dqk+lXuauTiE332ZMfXD1NYHMILOjhjaRZf0G1g5z/cs@vger.kernel.org, AJvYcCV5PyGtjUquytpHQk2s2jP91wXDbzKllEweLp6GNV+18f4N+cT9R1E8pxN79HMCoowu69C/u73Ajwok@vger.kernel.org, AJvYcCWWgpaACL4+lugxMqbxb1VCNXAqVsPVBpl2rD+v6m8mDCCaO3R+l6i50SaV4QAdNWdAznUSTqfcAkwZAVzr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6taeAmijrAaEyt2ClIgVT7VkMERNGwr8x9Zx+PyKC6HxqFjA0
	kcYcj/UKsTXXPe+s1ZuYwVPVI9LK28ZGgyPVgnqgBuePPh+Ue8Of
X-Google-Smtp-Source: AGHT+IF4NO0c31vpJOWOuLc8Oj4TNzZJRVvLcd3iIg8z6/Fnvv55fVTb27xtl3TK7SDd+dYdJ//hlg==
X-Received: by 2002:a5d:424c:0:b0:37d:3e42:be32 with SMTP id ffacd0b85a97d-37d54e0c9e9mr2665352f8f.0.1728673435660;
        Fri, 11 Oct 2024 12:03:55 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a88c9sm4568235f8f.20.2024.10.11.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:03:54 -0700 (PDT)
Date: Fri, 11 Oct 2024 21:03:52 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/13] iio: chemical: bme680: Move ambient temperature
 to attributes
Message-ID: <Zwl2mIWP22MiwG4T@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-10-vassilisamir@gmail.com>
 <Zwj6BQNhyRp_oN2M@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj6BQNhyRp_oN2M@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:12:21PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:26PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Remove the ambient temperature from being a macro and implement it as
> > an attribute. This way, it is possible to dynamically configure the
> > ambient temperature of the environment to improve the accuracy of the
> > measurements.
> 
> ...
> 
> > -	var1 = (((s32)BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
> > +	var1 = (((s32)data->ambient_temp * calib->par_gh3) / 1000) * 256;
> 
> MILLI? KILO?
>

I could do it yes.

> ...
> 
> >  static struct attribute *bme680_attributes[] = {
> >  	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> > +	&iio_dev_attr_ambient_temp.dev_attr.attr,
> >  	NULL,
> 
> Side note: Perhaps a patch or an additional change in the existing one to drop
> the trailing comma here.
> 

I could add an additional change if you think it is worth the churn.

> >  };
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

