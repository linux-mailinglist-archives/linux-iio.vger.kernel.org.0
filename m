Return-Path: <linux-iio+bounces-20930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E070EAE5459
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 00:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE01BC123E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D041F8722;
	Mon, 23 Jun 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhsXH1xJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E66136;
	Mon, 23 Jun 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715992; cv=none; b=oN/C5KyEzo6ovA69VjVt78qvYKBl3+DKUTR8cybFvpHwp8YwmGncEFYd57GN8FLNF8Y18/B24S53iC7LMtfCWaxv6S+he8xPW/Lc1SUHzBvoed2IjblMZnK+Y2cfmOh9hUGADzTJ6prR+rT8b3VMgeMexI3Zyw60GfiFEc79uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715992; c=relaxed/simple;
	bh=StgcPpVZ497N1//lGJ9yCK+fqaV+JDtj0HOaYky53vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iH/YHnp5s2DldEd+BJymUNOVyuaM8040NMVHngTMhgQNcPzgBUlDDa/NdDlyAYHiNwm9c70iVCFpXPJLAZGh3RE8QsWg/YaIKPBnRLT26yATYhbIuBVgWq+dygc03chw9FeJOvFVQdB1//xBaEcplx5dU+hLqjWXXcKEsobQVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhsXH1xJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45377776935so12044845e9.3;
        Mon, 23 Jun 2025 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750715988; x=1751320788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip8dhZ1sJDlEejolJHuVeAQ9mpvoSRnykXLF2ahUZGs=;
        b=LhsXH1xJcRjRPEDqj8c9kvkjO+BVuMh7GglKdQoguzfs6EayM5voTaKewf4uL7owkp
         Iiz4sFWnOmJm1wlC+82c5xjjxJcs4J7128/8cNPadTb9CiT+mwfoNbAhYP5GAMCM5HGB
         7F6zvRfccjqysGuJxjjh5YCTxsn0SgTVKkKLQ/l9q+CHXJXveD8w1gZ/NNPA7cdgYrUH
         36Cvpq1IlzNoOFUXddmcOjRc0kJvObSH5KPrfGbkAsYaMGw/sCfzYjLf+PkmFG3p7Tiu
         yOJs8buFRtjpJC60GM8Aa74Y9QbSAok/bi3iviFr0mDUkJUHirQ6lN9uyRBxys472riN
         l9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715988; x=1751320788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip8dhZ1sJDlEejolJHuVeAQ9mpvoSRnykXLF2ahUZGs=;
        b=eL52pLqAAJywy1adcbLSwRyRIwXwAnFn3xWN4UU0EYVgh8G9/ryO5ETZcT76oOsEyV
         rhDFbfG2CE+b6G5k971siiWtMM6Q+zgRYAoartnKJ+IPY43cA+hzwAoMPEN/u/mGM1vj
         cerShJ0ImTicNpaEq0lPX7Df766g4QiV2pxLbfwuZm2VR5V3Da1z0/fQ0PLzER3aqUnY
         xlJnZ0vOYfGPuI8dNvk8O4h/KQVs+dl6+x2OKNYV65iEDHhOBd9QKzUI8EHaFPh64GTs
         0v2vTY2CrsZBVg8B4ssoTesx8c0/bK9UtzmQsVA8DH2MMzamjWjQbAohSZ/AJdx3Upbx
         wXcg==
X-Forwarded-Encrypted: i=1; AJvYcCVEYNu4K+sfIj0EU0xX4R/VnjUtBfBp9tGr4iG5A86FQ4OqD/xptJwQIaluH++CeQdoKnBmrQo/DOkqraN8@vger.kernel.org, AJvYcCWq7VpMkFrwR+9bfbqot32qYg3JOjrV9UbElmYRmqg98gkQqfmDeXFUiQFmWV5paakpCF33IKm2KTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzshb+lyVvalwrFn9c1vJLGw2NL225Tuv6/ch2D3ynPvzU/zJm1
	GVMK2QajYgiFR/PzqovCQZCkLJ5qXadMC18kLbS3wSz1Uv1BKr9L/PKh
X-Gm-Gg: ASbGncva/fR6IHaS3WxrKQ6md3TtD8kKzcSEa5H9NZzNfWw9fVBaQSSBd73855fCKJK
	7SJWiAbJOiU0f5Anw9umpP/Xh1+VFyTBW0hrvqI7tdRbMBDwlE31ftouu9jChrLS8mBOajFQlUf
	zCn1DYU4DAicIKEJqMH1+HbB6ggM7amo2sunJDH/Y43PvE/5oKxInzNqIXBhmQ1JzUQzUSyxO81
	KtzkAIHhRU+8Zc1wmszbYsA0KVjcWy4OR2nBemGxaxKtHxwc05pF7DEhLGxjHKe3KEGi3x9ccOA
	dPO7lFy9VXMYDAt4EhyyqvO0T8rb4vD9Gp5r0zcwBw1qya5DGQZluIRhE8YMzG28G8ocfmZ3
X-Google-Smtp-Source: AGHT+IHqTxpIkerb+h6RMY5xuHSr1zJnD1N0TihC92lCQzng+TwXpFcTGs+HRLN63KWj5qqq5W+sig==
X-Received: by 2002:a05:600c:190e:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-453659dccc3mr140504545e9.18.1750715988141;
        Mon, 23 Jun 2025 14:59:48 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:82ed:fc07:b207:2c59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805dc32sm218789f8f.29.2025.06.23.14.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:59:47 -0700 (PDT)
Date: Mon, 23 Jun 2025 23:59:45 +0200
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: "Mereena Mathai Liquancin (MS/EHM4-BST)" <liquancin.mereenamathai@in.bosch.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"ZHANG Xu (BST/ESA2)" <Xu.Zhang@cn.bosch.com>,
	"BIAN Maoting (BST/ESA2)" <Maoting.Bian@cn.bosch.com>
Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and
 support
Message-ID: <aFnOUVOE8LseQ0xm@vamoirid-laptop>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
 <aFj9FGSpJyZjL_bj@smile.fi.intel.com>
 <DB9PR10MB64516B74B8FE3077E1CCE622C079A@DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB64516B74B8FE3077E1CCE622C079A@DB9PR10MB6451.EURPRD10.PROD.OUTLOOK.COM>

On Mon, Jun 23, 2025 at 07:37:51AM +0000, Mereena Mathai Liquancin (MS/EHM4-BST) wrote:
> Hi All,
> 
> I apologize for submitting such a large code patch earlier. I am currently reworking the driver to simplify the implementation and make the code easier to review and maintain.
> 
> Regarding the BMP2 and BMP3 devices, there are significant differences at the register level, so direct reuse of code is not feasible. However, I will carefully consider all the valuable feedback provided by the team to ensure the next version addresses the concerns raised.
> 

Hi Liquacin,

Probably I didn't explain enough in my previous message.

The driver I mentioned under driver/iio/pressure/bmp280-core.c
is driving all the BMP085, BMP18x, BMP28x, BME28x, BMP38x, BMP58x.
Even though it is called "bmp280-core". Since the BMP39x is 100%
(or almost 100%) reg compatible with the BMP38x, you can use the
existing driver to control your device.

While writing this message I went to the code to give you some
guidelines on how to add support for the chip but I noticed that
the BMP390 is already supported here [1] since
Commit b19ac45bfe50 ("iio: pressure: bmp280: Add support for BMP390").

This commit does not add a specific compatible for the BMP390 device,
but it looks like if you use the compatible = "bosch,bmp380" on your
device-tree it should work with your sensor.

I hope the situation is more clear now.

Cheers,
Vasilis

[1]: https://github.com/torvalds/linux/blob/master/drivers/iio/pressure/bmp280-core.c#L1958

> I also plan to remove some unnecessary device tree nodes and redundant logic to streamline the driver further.
> 
> Thank you for taking the time to verify and review the patch. I appreciate the constructive comments and will incorporate them into the revised submission.
> 
> Best regards,
> 
> Liquancin Mereena Mathai
> 
> BST Projects (MS/EHM3-BST)
> Bosch Global Software Technologies Private Limited
> (CIN: U72400KA1997PTC023164) | KGISL Infrastructures Private Ltd - SEZ Keeranatham Village | Coimbatore | Tamil Nadu - 641035 | INDIA | www.bosch-softwaretechnologies.com
> Liquancin.MereenaMathai@in.bosch.com
> 
> Registered Office: Bosch Global Software Technologies Private Limited - (CIN: U72400KA1997PTC023164)
> (Formerly known as Robert Bosch Engineering and Business Solutions Pvt. Ltd.)
> 123, Industrial Layout, Hosur Road, Koramangala, Bengaluru - 560095, India
> Managing Director: Mr. Dattatri Salagame
> 
> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> Sent: Monday, June 23, 2025 12:37 PM
> To: Mereena Mathai Liquancin (MS/EHM4-BST) <liquancin.mereenamathai@in.bosch.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; jic23@kernel.org; dlechner@baylibre.com; nuno.sa@analog.com; andy@kernel.org; vassilisamir@gmail.com; marcelo.schmitt1@gmail.com; javier.carrasco.cruz@gmail.com; ZHANG Xu (BST/ESA2) <Xu.Zhang@cn.bosch.com>; BIAN Maoting (BST/ESA2) <Maoting.Bian@cn.bosch.com>
> Subject: Re: [PATCH v1 0/2] Add BMP390 IIO driver, device tree bindings and support
> 
> On Fri, Jun 20, 2025 at 10:24:53AM +0530, liquancin.mereenamathai@in.bosch.com wrote:
> > From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> > 
> > This patch series adds support for the Bosch BMP390 pressure sensor to 
> > the Linux IIO subsystem. It includes the main driver implementation as 
> > well as the necessary device tree bindings for integration on supported platforms.
> > 
> > Patch 1 adds the IIO driver for the BMP390 pressure sensor.
> > Patch 2 introduces the device tree bindings documentation.
> 
> >  16 files changed, 7296 insertions(+)
> 
> You are kidding me.
> Please, take your time to start with something really basic.
> Also, can you explain how this driver is not duplicate of the (any of the) existing ones in IIO?
> 
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

