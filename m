Return-Path: <linux-iio+bounces-20556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A447AD72E0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708CC3B0897
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83D24678F;
	Thu, 12 Jun 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTS+CL3G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BC1514E4;
	Thu, 12 Jun 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736880; cv=none; b=JPNMhsRmpYd9q9BW8V97ub58le1XTPV1Ub9lupd1AHLTKTxX9zoymSD+zdDuFfvHVUzbgLyS9ncqBrz8qF1wV8P2GT07jEtQ5wMJFaUT8kleF0jX+150UWvY2Y2B7xz94/YwiCfyYw9oRCLt+kMPb/i7/xC/2pZTW5XkcQIyNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736880; c=relaxed/simple;
	bh=YPxMTxw3oYrovaTdA0xeKAG6x+IDWmVWaIS2Zqn0zaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx9LJkWM+UVT61CyIMy3SYz5nDTv64S8jZS5EBQKuDjdWrlmoQz1TD789xFb9aYbtJGs5Oaedj7pl2o3R0Pq7Iwqonw+uhghX/C+2YOj54ks/WcUzwUxr7Alm9fVUJnTO3qMg9PHt45J6cOwnEzvVnoR1qTLAr+dROl/fkV7BS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTS+CL3G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9ea8d08so10241075ad.1;
        Thu, 12 Jun 2025 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736878; x=1750341678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrUaDDGPJzFKUiQFGAoTVMOx8+jgdrUvU/jOz6JWMNw=;
        b=UTS+CL3Gjh838bYLJBzKh2eeK/oG0HizVwk/p8sl8Xj8Om1xYTb5tAS5BDCHHc/I4j
         fq/zUMGvOOGtBnJImBw+l60aqJTU0ydmxOY2xXip7N685CBdw3LWOTor0Nuybi3uaJNV
         wqtrXNMdbjNpimT3syBfML+uFwT1TAypwB9hS7T1Mo2m4Z9va6XEakrtum6cCIf43RNv
         9iWte9czJvvijbWnuQiyumZV9ETVWTg/WvHj/0fCuc0+53419GjMlltJJRtkMpBTyaM3
         OjRrDoJNmVg3MgmA/yvuAmaE5CByotXHhY7ZFJyPT/v0bQ2OHqANcRG29lTGTzHvDVc7
         SJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736878; x=1750341678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrUaDDGPJzFKUiQFGAoTVMOx8+jgdrUvU/jOz6JWMNw=;
        b=CPFG6qyDZZBGwSO96tgyXHVRZIY79vXVMOaYY6pMJgmbzAjFm8v4DFY5QymTkPfK56
         +sw2TC9RrzuwoTq1dRY7uUJPOuOiCd58nLhu+45TNuYu/Zv+c5oXPFbDz3iFC1zPLsKW
         QzHyjW7vKX4MB4fIJdaK4kAT2v6wnWurdgTmH2Abk96odrmqOYQ4K4SIisLOOBbyaeql
         QQ7mGY5tUV1up5VwvHa7k6Hn3M+8Z8ihTHqq+mUa/zk0BCqLNgq459XGVlj3Uek/veUW
         nMtoZGvIlIk3YyRi1a6E9ZxP6/Gpm6/CpA1RiYQIwl2IG79BULBaoyZtVMgKybqdPEcr
         ZxnA==
X-Forwarded-Encrypted: i=1; AJvYcCUjZ2AifQbPnpI026JI1EINjKXBSLMWzH4XoK7P87qL4cMnIEUGLklmK6P1/1zTSxMgo+oxOByLu6TZ@vger.kernel.org, AJvYcCUpmz/M8J/A6xTTMIr59rmtdOxzm++3ZHuZL2x5PlAyQqjSn/3Slbn5IRN94n985wIA69A1UiSoSJAwnQ==@vger.kernel.org, AJvYcCVGJcYa+RqR8XlLbsciFb3kL1Evj6c6/GsqGJLtRPWxzIR6bju8PqTgZH18VRmA4xH6XKEiGGvPZKwHBxXc@vger.kernel.org, AJvYcCW+6Cjdsp8I94WzlMZQzAvwWt8DNg1GLzVtfKib7xKEqOuY6cU27BLqSdV3bURxmpkCbXaQW2QnvBzk@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMtDMRjHTqsVepc6KsR5bnDiVZgNYBJbYjozlUyQOI7v5Bw4R
	cJ7cbd/vT3OxbLAVyK/ltDmdRj1s+w0bBh2emPWvJOA+o8ybygtZTeeG
X-Gm-Gg: ASbGncuavj2E90z1j9L4f/6rLtkghpyH2UCTN3EtSMThFHE4wmgVQiDEijgC5ibrtOl
	t9KqA3XrnXc6TNSQ7bXWe1QPgyHMvNLTM97DIVp/12NboXFLKsh5lahTGfmeE4c4A5NVNyH+Gcn
	Q6YJT327578ovzpAPndWHo3SCHGNAyDXl2wo6zdU1ley9HHfKzPRWlezk3mtcD7EPU6SA7A6WMy
	PmcfQR0f2kSnmd5YeN7KfhT9bMNBXUBNQo8kF8prj7TdGiDxz/MI9d810Zs+GzF7Sd6M5+LC2q6
	hwJUDAcqOjv58uTC20qH2d2V/FtQqiw1J+O4b9ITGOlX/nY94EP2fBGkxLMYxEptX3eU/RGIHt2
	CgdpuwA==
X-Google-Smtp-Source: AGHT+IG8MPbeD44xaQLw4mhm0dmlhPEtylSTie6+7pb/0KZ3veLVzkzsT+ldEJIwVLhZFtndrz6dYQ==
X-Received: by 2002:a17:902:e74e:b0:234:8ec1:4af6 with SMTP id d9443c01a7336-23641b3291amr103085065ad.45.1749736877677;
        Thu, 12 Jun 2025 07:01:17 -0700 (PDT)
Received: from localhost ([2804:30c:4000:5900:b4c4:6073:1a92:4077])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2364e6d9c65sm14079355ad.111.2025.06.12.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 07:01:16 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:03:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aEreFQUZXsdsgBSm@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <aEifWXPV1nsIyWbT@smile.fi.intel.com>
 <aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
 <aErMgh6AKVStF4rQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aErMgh6AKVStF4rQ@smile.fi.intel.com>

On 06/12, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 06:04:49PM -0300, Marcelo Schmitt wrote:
> > On 06/11, Andy Shevchenko wrote:
> > > On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > > > +	return spi_write(st->spi, st->tx_buf, size + 2);
> > > 
> > > ... + sizeof(reg) ?
> > 
> > The size of the specific ADC register is stored in the size variable.
> > The result of sizeof(reg) can be different on different machines and will
> > probably not be equal to the size of the register in the ADC chip.
> 
> Hmm... But shouldn't we have a variable type that respects the sizeof() of the
> register in HW to keep it there? 2 is magic.
> 
I'll add a define for that constant.
For clarification, there is a 2 byte instruction phase during which the driver
sends the R/W flag and register address. After that, it sends the data to be
written to the register. There are 1 byte, 2 byte, and 3 byte long registers.
So, the total transfer length is 2 + reg size.

...
> 
> > > > +	/* Assume AVSS at GND (0V) if not provided */
> > > > +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
> > > 
> > > -ret ?!?!
> > 
> > That's because AVSS is never above system ground level (i.e. AVSS is either GND
> > or a negative voltage). But we currently don't have support for reading negative
> > voltages with the regulator framework. So, the current AD4170 support reads
> > a positive value from the regulator, then inverts signal to make it negative :)
> 
> This needs a good comment and ideally a TODO item in the regulator framework.
> (It might be easy to implement by adding a flag without changing the type of
>  the field, if it's unsigned.)

I'll add a TODO mark and expand the comment in the driver.
Not sure about sending a patch only adding a TODO to the regulator framework.
Aren't developers expected to propose things?
I'm anticipating 'talk is cheap, show me the code' coming.


Thanks,
Marcelo

