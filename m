Return-Path: <linux-iio+bounces-23645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5DB405E5
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5CE1886893
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97530648F;
	Tue,  2 Sep 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsSaQf4y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084E28AB1E;
	Tue,  2 Sep 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821250; cv=none; b=CExRXTV3CU33YTWHCcpUM7p//zvYMf4vj0AhZTrbmmj/U1Cpo6xmdb3sxd9y8n77ujYa09HCUXt0ZEDlYttyOCkGyNUarOX9v7AnJWlB1J/+LnVr9RR1mjWqc/OG0RI+gucSJK/54FZ8//vmq5Gj8nZb8bvzPFU7kLNrz3yrNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821250; c=relaxed/simple;
	bh=69wVv6bbvG6MEXiXXjr7hj29YgvfryWOViB465bVb8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZsIy1v21KGEmZiGN7kHGuU44REvca3wZRIRAGVVbQ+9CKAT6DcqsN3rVeq381+Y24qViXWcoHBpoqmXmOJ0y+msZPLYIQtskbgtcDerXsPFrNe47/iW405CtBIVw4FEFlOX+tBC8PHqPblf/KA2jGLe50XC6pxEBO7YOj79Zu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsSaQf4y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04163fe08dso411394466b.3;
        Tue, 02 Sep 2025 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756821247; x=1757426047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcxMe3QH1ctzyMJBWwg/0kpd4+pnYIbcDb1kDpHMe0U=;
        b=TsSaQf4yMYI9xSZ1YXSlMbSF3ELwEikYNOTYx/B9kv9X9aHzY5XnIu/2Pzf2uTKHkn
         jnBM26fWGbdUNak3IT4sWl1+c6nMr4LhtuR6wv8lR3KeOnR2JWhbmUHkxdZVErGuL33N
         5NqSLX5RYLX7kjyfS6R3gs22k3PxrQQpXwKHZOFs/yvubImbAcw6MUvxRPdvuh1JwnyL
         6Simr2QKnxsVqkpOWi+xQgtWtP12akCmXI9s0oRbgE3JEKzn6e5M5KVaLWZrZW+ujXJ5
         kHoZXGKB/wUiwJqPpXosiRiUg2hPw7bzbrnO8zmdGn1iDgq9e0LeJvHMmaGTDXCBMEdc
         +7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821247; x=1757426047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcxMe3QH1ctzyMJBWwg/0kpd4+pnYIbcDb1kDpHMe0U=;
        b=NpYjRUpr/HdftdMaypvxr8JJ5nnYGH0dm2cpLWE3R6tocZljOhRE1cITPCIws7JXwP
         qmKNz2PO9YeB9b4XlcYtDPyKmghStHdm6KgIp3msIUqk52WRAGR2MX7996CVfN2qfDzO
         s2rBeVjM9X37kPmF/GqrbmOkMQdeRfrFdc9fmu2FKl66YYj8q4cBFgTfHKrzcB52jnIi
         EEV7hekQ5rfD8wsjtorlAZHM9et9xevx3cR0nTtJB9tbFnFJaGY6THG1RkI7XYCiLqG7
         evWtAthDBpt0FnJThvCSGojCT/6jWxSsbsg3ciDjvGgqgfQsMSpXcZ45RJMUtIlDHLvl
         r7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7ShZlw0dqr6fi1AmApkUBWY8llxVmh4vuTzzv4Rw7F0ZLufB7GAx+l2qPiCuMHkuQ/mSD7AKohzc=@vger.kernel.org, AJvYcCXVlLZpVVFMmV6MWyimoh0MM9H/PjMr/9Rbl3d9JRa/bJoL/xUNzKmERM6bC4Z6bpub3nMoOczu+p8hmdxh@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJHcOO4RE67wxkeMOubxvuwr0dMQGkMW6JT1KqEPMnVmTzfCh
	Ow+d/QlVj+SYFJ/J4Jq16teKqPJsG8yE7P3Qb+65vl4cLJq7sxco6kft
X-Gm-Gg: ASbGncvNtgrG7Fa6fco9tOIf6tJce+MmcZHEHaZFxniPc/hvJk3ch+nmXYkhqg9OnPM
	H95Xa9aGDDFyuejVHlXGVehfymZrzcgrS34R1Pg7VOvIg91H4df1xH+OiRTkAEDCvguVVzy66lc
	AiKvZKOqeKy5sA6yd8r/CSJo5EKSaE11wnItufSPSqL/jmM10BCVLQ4naGG/yTkPjHAYCBKWX8g
	dYleUHp3wLHVo5VdW5+S9z9rpEovflSZMr6S9rzNcT3WzsDWJ8Xsbcf5vznZdGzn1Xg1/uKyW1K
	7BQ5uQYmcxJmfCAVVg3P8gkpjeUNwDMcTwFK/BYHT7IybzXEkZOKu3jIuksIBEjl+CywXldoX2d
	7YOa9wWsam9AT/W02O7xNpkXGL57ggPU=
X-Google-Smtp-Source: AGHT+IGENRHM1Pz8hFEdjUOEOg5BzHynebxQ7yjCDQCZKi11h/lXs56X+WsaUOZOeNjIy9LnLTpGzQ==
X-Received: by 2002:a17:907:94c9:b0:b04:2f81:5c35 with SMTP id a640c23a62f3a-b042f817f8cmr699512066b.34.1756821246348;
        Tue, 02 Sep 2025 06:54:06 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:620:3f00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm836219566b.12.2025.09.02.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:54:05 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:54:04 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: dimitri.fedrau@liebherr.com,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH v2 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Message-ID: <20250902135404.GA145952@legfed1>
References: <20250901-hdc3020-units-fix-v2-0-082038a15917@liebherr.com>
 <20250901-hdc3020-units-fix-v2-2-082038a15917@liebherr.com>
 <aLbneKXFd7Nc711T@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLbneKXFd7Nc711T@smile.fi.intel.com>

Hi Andy,

Am Tue, Sep 02, 2025 at 03:47:52PM +0300 schrieb Andy Shevchenko:
> On Mon, Sep 01, 2025 at 07:51:59PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > According to the ABI the units after application of scale and offset are
> > milli degree celsius for temperature thresholds and milli percent for
> > relative humidity thresholds. Currently the resulting units are degree
> > celsius for temperature thresholds and hysteresis and percent for relative
> > humidity thresholds and hysteresis. Change scale factor to fix this issue.
> 
> ...
> 
> >  	/*
> > -	 * Get the temperature threshold from 9 LSBs, shift them to get
> > -	 * the truncated temperature threshold representation and
> > -	 * calculate the threshold according to the formula in the
> > -	 * datasheet. Result is degree celsius scaled by 65535.
> > +	 * Get the temperature threshold from 9 LSBs, shift them to get the
> > +	 * truncated temperature threshold representation and calculate the
> > +	 * threshold according to the formula in the datasheet and additionally
> 
> Replace "formula in the datasheet" by explicit formula
> 

Ok.
> > +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> > +	 * calculating threshold and hysteresis values.
> >  	 */
> >  	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
> >  	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
> >  
> > -	return -2949075 + (175 * temp);
> > +	return -589815 + (35 * temp);
> 
> TBH, I prefer to have the proper units be mentioned in the comment along with
> 
> 	return -2949075 / 5 + ((175 / 5) * temp);
> 

You are right, will add the units again.

> 5 itself can be a definition
> 
> #define ..._PRE_SCALE	5
> 
> and used everywhere.
> 
> ...
> 

The explicit formula in the datasheet:

T(degree celsius) = -45 + (175 * temp) / 65535

The formula before the patch:

T(degree celsius) * 65525 = -2949075 + (175 * temp)

Adding the PRE_SCALE into the formula doesn't improve readability from
my perspective. I would prefer to just scale the result as it has been
done before.

> >  	/*
> >  	 * Get the humidity threshold from 7 MSBs, shift them to get the
> >  	 * truncated humidity threshold representation and calculate the
> > -	 * threshold according to the formula in the datasheet. Result is
> > -	 * percent scaled by 65535.
> > +	 * threshold according to the formula in the datasheet and additionally
> > +	 * scale by HDC3020_THRESH_FRACTION to avoid precision loss when
> > +	 * calculating threshold and hysteresis values.
> >  	 */
> 
> Ditto. "percent scaled by ..." is much better to understand.
> 

Ok.
> >  	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
> >  	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
> >  
> > -	return hum * 100;
> > +	return hum * 20;
> >  }

Best regards,
Dimitri Fedrau

