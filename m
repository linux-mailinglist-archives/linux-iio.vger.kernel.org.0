Return-Path: <linux-iio+bounces-23141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE7B317FD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DC81D02208
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FB2FB63C;
	Fri, 22 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL9uhbjg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2F2FB62D;
	Fri, 22 Aug 2025 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866206; cv=none; b=haS/nUH8Vwgzvu5+j/lvHyfeR0YEvhsrPXJd3QtAFJ26avGfooEhLY2v1v7R1+QMCpHY9P+to6s51xdSOFLD1vSJk9xM3qYrAkajEoxhvbJBnhSgbslUzN27H2xlfW8tX+kZowe6aorG1y/XXHpYaTWNOHnUxJPQRhSactfBPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866206; c=relaxed/simple;
	bh=oIde0TlaVmSW9RW3Vxdsr4fR2WlErknPKwu1GrYxy5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew3Ul3kCapmf1QJK+qkgx8lOb/Tk4m7lpshZIwsNinJOSTj9oVubTuQDANGup3FL0kdUYU10twn47JDcdqxMBVCHSNsVnntkCPQDabDNkUdV38BKg/UGfdOShucUTJPZwfpdFNtPjq47lANqeMnRuqWlXGDmNhglE/zYUe8t4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL9uhbjg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso11745245e9.3;
        Fri, 22 Aug 2025 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755866203; x=1756471003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bx/4A3+Gx2aFj8IGwK89M2ZsIpiYLL8axuyOuMZrEXE=;
        b=gL9uhbjgBk0aAtCVndPg5PlNAVfioJz80qFEXgXnZw4oHxVpsxqBXkBElEpUXFw43e
         hp2HmDTs9gmw5d6M6ZFfbYD0trS2z5Njc3jftXRCPa06QNX5RXWqX+P1mAS5Lkv+N1Ro
         nNscCSVaZ8BJYBWxMDwExlOrufAEvlCc/QFXzKI+sfYWBnBLbgB0Y/RxwBggPSQ5gV6m
         gJw6D9CLiwSX+BQZYQMF3GTfdPGho8lH6gP7azhDgJCyNLptteWHOZlm5VrdyU2iX6jm
         GAeK37UsQwcxtJS4VKqr3uIylJ03Pn+cOjhCPAunpw/DShjPkSs0m4We3cw01p1RYO9F
         YQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755866203; x=1756471003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx/4A3+Gx2aFj8IGwK89M2ZsIpiYLL8axuyOuMZrEXE=;
        b=MS5F2exYAMfWcHxudY0wQwkiHkY/KUBue9ojN9dN9REpvN5CdG+w2Ee7gax+809JHp
         jNnDt4wOil0/k/9DkiU6/7opLYWBQ7egWhVL7dLVyjSL0q9U/T9VivRTXQTBS4s2Qsuu
         iYnkHAhBanMJsv2MF2HBUCPghjCN4g/Ln5T6n7J0LGc9ndZd0T5jpvVzqfdhsvKZnyHh
         nzpz7doE2D0mcnREUZn/QEnSDPukmccuSkEZ0+QCqrkilX2BuEwEjK5VmOCNH/n8EptL
         DxmtPWxWMX/npwSAkreDrvTbt68HkkbBREGcLI8sJL9qNbsntHjlRSUKCm5znWeBli80
         VGuw==
X-Forwarded-Encrypted: i=1; AJvYcCUhGfts2oKs8qnZCUaq7b4IKqAU8YBwrxaygewN/pPT1LpeFgKIvg8XGDVX3daPEhlf21LgFv9OprmDEmfI@vger.kernel.org, AJvYcCVs0yc62ULWhHu/ZqE4nPT/pNIGIWyQZbX0y85gSmYRQcrYEpK570m8P0PDv4YyDFNzoy0e0lzpZcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbJLsYiFedXWRg3NLkBbQlO6s6FOw3pq8AGVoVeXJ4zO7V4re
	ZXHH9afn5oc3DqvxzIL2JtoieboV+9yCoh8vTkMSkqnE1PKG2EmblteE
X-Gm-Gg: ASbGncuY+HvLMauRbvEDMVTuFv8iX9CRnihAkbr0Y25+l8PBLNyjgdcoObdtJV5gAWH
	XJeK7/kuBNct/pCPEdVXbNINElC0pnnMRwV09PBerNENCpgtmiDOtFiS9/JLyQrvL1KJZFRvuCx
	zhTdWG8SYHcrfCDbxYZ5WFefd+aCRkW6xxlLHmRVWFur+BoZaF90qBXKXavm46v5vYkVX/vXh+y
	mR7xU+xP6PmpGkzwyYpsFRCVrCnkEvsRwh9RN3advtxXXiLehKhFHg8J92W+0ZXaSJk8tLpWjDh
	+94mEm1lbNNs+UWX20y61amOSq8a5YKdJu8xQqZamKJD0ORn6HDAW6ILfCsHDutIfCWjQzUT51j
	8k6kZpL2VeyJp5UyB1mHY
X-Google-Smtp-Source: AGHT+IGLHePYvKetdZF0ttglnEALzl+yrK+mHjXKOrhefcCSe1sTmJGdI5xkl0FH1V6Q5aDp/8oHxA==
X-Received: by 2002:a05:600c:1c87:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-45b5179cdd5mr19741695e9.2.1755866203245;
        Fri, 22 Aug 2025 05:36:43 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:65a:1400:1ebe:eb51:3a97:3b47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc4c55sm36618485e9.4.2025.08.22.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:36:42 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:36:41 +0200
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
Subject: Re: [PATCH 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Message-ID: <20250822123641.GA19315@legfed1>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
 <20250821-hdc3020-units-fix-v1-1-6ab0bc353c5e@liebherr.com>
 <aKc-2WHDTtGcXmCJ@smile.fi.intel.com>
 <aKc-_j84oUwCquHk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKc-_j84oUwCquHk@smile.fi.intel.com>

Am Thu, Aug 21, 2025 at 06:45:02PM +0300 schrieb Andy Shevchenko:
> On Thu, Aug 21, 2025 at 06:44:25PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 21, 2025 at 05:23:54PM +0200, Dimitri Fedrau via B4 Relay wrote:
> 
> ...
> 
> > >  		if (chan->type == IIO_TEMP)
> > > -			*val = 175;
> > > +			*val = 175000;
> > >  		else
> > > -			*val = 100;
> > > +			*val = 100000;
> 
> > Perhaps  use " * MILL" uin both cases?
> 
> Perhaps  use " * MILLI" in both cases?
> 
>
Ok.

Best regards,
Dimitri Fedrau

