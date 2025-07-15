Return-Path: <linux-iio+bounces-21706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341DB06A1B
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 01:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F86562CAC
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280D2D6639;
	Tue, 15 Jul 2025 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrPV4+Ei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9E1FE455;
	Tue, 15 Jul 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623746; cv=none; b=IbLrlaA/MeurROE/7thIRTtyiGpuNU6jj6G3cHvJhkGV+cSnBukwV9kBsbk59dYgVbjiQ5/dXk1fYxdOBHMt8HAP4nfYV0BtL/wVum2qZ3yVzs3VMnqpNo3+BtRsn+1yoUOGEwXWOGJ7pyqpUzg4oKgIHOm4tG9HF/E0hdK+UN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623746; c=relaxed/simple;
	bh=cyHFqr6aetbW8Njyl5dAcxtHeSRwVPBFeJ2HgF3T2qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E67kRMjhUUsEiw0pNXWglDWEaFeN8GESTMwqXA3uLe12qp0Y+n0AiO8A3WsEWEZAfWX3YWpEFy8ClFKV5WVSNwpPye0rmjy5aXo7nquWcwNQPbixv+2CYxDf31NDVSZSWbts51+/GF8ckly/khg+8lmdMckniWqOALp1e6BEYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrPV4+Ei; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31d489a76dso5505099a12.1;
        Tue, 15 Jul 2025 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752623744; x=1753228544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpjiJJ06ISez6RdbXit92RUYXIk3ZZeRe0YSwJhiWVM=;
        b=HrPV4+EizEaMFLQ+isefHR8ynznNM9ATR8yl6Acnlj8HtC/NPfFPKe/26zD7Rk4/vp
         jap6IAf4Oas2uz5ZxM6Me9oiSPvgCoSH43q7DPWsBgw125Q8CxH0COEnVNSCKTZOoVgm
         382iA/MtrXtZZkWA+kbVl5p4lpouQXKCUlNbAqj1PSHWu2H+ky+f5vmgFRds3aW1AtPJ
         IefnsQpsh8et7Bgu86kTkkeeAL1Upsy4XX4wt2s/Ye3ZNEfvQ2Zl3pdP4M6iZVaFa3vA
         gGCsCofLhYj71Em3WPDSsDmd/XDPVryaB7sqNZ2gdbihATxi1NFfZgwh0mAthKSD4a4C
         f13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623744; x=1753228544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpjiJJ06ISez6RdbXit92RUYXIk3ZZeRe0YSwJhiWVM=;
        b=IvFkz5Jiwn5++vhnqZUVcYPTAZrJ9FwqUbzWg0Adxzxl6JSHuXEzoVX+XKDbMcRBNZ
         +ycMKOlu2Y05Q73SSW9Xga2FMpCbfTxi70MSLbvPD8zTQRhoRHOQ8xB63np+FgzxsFJt
         KMAdQm2OaqRUgdkMH+awpNx1Dl2P+KUp7oCjW+y/8GndoN+WCcFCenHr1tA5XG9slRsy
         JcWaj2rM6LyXaOi31LjZxJbjAjvmVJs8nT889Gf7LyM0T0DvIly/VkTBDINww/OjuQ8U
         7aaDx5+ur5KTjbio0H/OnejC9+czy6RUAYuxD354jTYneeVs+0oT9A5yRnvA4Tx/Oiip
         jTWA==
X-Forwarded-Encrypted: i=1; AJvYcCVGrIMXvjHT8FK+C/VAeB6/gD44TWGhoM0kcx0V3JFBzQwfTqXrUNq7RqbXaTTVDt/lAQwBnBal6feoLfvw@vger.kernel.org, AJvYcCXvaNfJFhr/otbn3hF7s6VcOSepOIGwObHNdjhPtA+RskIHv7lG1zTAfYuDG0fIHd6ke4/DM9ihnGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL3VG6jeErLGYEPNK8KTOkh4eEn6VHJcrmWO8HCozCfsOShNR3
	KzaxIVClhzYjrI4Nhw62aXm1aNzWYsf5HExXWpc/Q9BurEiJf/olzZfih0Ds/giW3/g=
X-Gm-Gg: ASbGncu7eekG72sNmRcfC8hoaUB50f1PjNB8xN1eqpqr0fXaszLyljpC1K+34uTYyA8
	fWzSUAcFDez9JjdDGCDH4gEHf6bc7jSjTgqskSVyKfmmdTtTJZe6PG7h+juAHnINWoa1rwC7nyG
	60q93ZMViuoC6/1Id0mqeVyaTEn9AF2IRRtO1yHI9alQWgKZmvIYGmYUEuaK7+0efKode+PpRrB
	4EzUVcc9WpS3i/TDKeBAtQffdd8Qj24K1lI42IzHaJ+3Yh4KzAYqQvj2i8Gs/ftMARji5hm67Lt
	XyjTJ4g5RLWRAYll7ftPIhT5r90C+c2M1n1sYO22Tf9mo1WD6hk/FrURWjvdrmRa3Fc3hDDFRb+
	acn5TOQ==
X-Google-Smtp-Source: AGHT+IF+hLzowXo2oKfDVqP+NyMWWiHAEkSVL0M//T29ZN+3MSdJIC9LZjWLxp1xWV/9uZUWSn5vcA==
X-Received: by 2002:a17:90b:254d:b0:31c:3c45:87c with SMTP id 98e67ed59e1d1-31c9f44b592mr608226a91.13.1752623743782;
        Tue, 15 Jul 2025 16:55:43 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::13a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f21242dsm175375a91.36.2025.07.15.16.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:55:43 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:55:35 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
 <aHYIBReTFqJMtiXW@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHYIBReTFqJMtiXW@smile.fi.intel.com>

On Tue, Jul 15, 2025 at 10:49:25AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:
> 
> ...
> 
> > > +/* 9.81 * 1000000 m/s^2 */
> > > +#define BMI270_G_MEGA_M_S_2				9810000
> > 
> > I thought this is MICRO...
> 
> Btw, what if we use the device on poles and on equator (or even on orbital
> station)? I'm wondering if this constant should be defined in units.h or
> even in uAPI that user space may add a correction if needed.
> 
I certainly hadn't thought about these scenarios.
FWIW, the accelerometer scale values also assume g = 9.81 m/s^2.
For example, 0.000598 = 2 * 9.81 / 32768

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

