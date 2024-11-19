Return-Path: <linux-iio+bounces-12398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D339D24B9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7587CB24BCC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279791C6F47;
	Tue, 19 Nov 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBligGuG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D24F1C4A08;
	Tue, 19 Nov 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015346; cv=none; b=J4KMlAS6G+1SX6mAuDr2af2i5sKvYMp28iLUiUvjXgOnzoe8Oq7xMavS/0KoOysHV8AOe7uTNvFcTo8hPHgvrw7A1oeLIpsMSHDbTsOeaR7kPmctWYDofsQE8AL0qxY4aHllE2vn0Sv7RAE9PWbn89X/8sFerCIdl1MdIlpUSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015346; c=relaxed/simple;
	bh=s5ETrXY55LebHUHKMiZ1o04YRrW/b57PlPPfpOBKVEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4RVPVG5OF+B6N385wiw84Yk4O6My2FZIa53yMiCX6DgJw2v4tLpc9zvt2YixcvEACC0umKfPg8NtBLd2hCSkDO+mQULtkxU3F3dMfl1WRqa+hRoOJwNaC0CgpmkoEDfNIhhs23kcKcdQCkAlgnsC1/jJdUZR3ARUSjk4LWlojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBligGuG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cf3e36a76so42678185ad.0;
        Tue, 19 Nov 2024 03:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732015345; x=1732620145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGgRP8LyCA/ZR4LXi34oYBVO/Mzz1ZaBNCtp6VsfHdA=;
        b=kBligGuGQHzCwjJTIVQJfeyZGkQpx/xn1jqpuSs8nOUB1/UmROylcy7xXw6RarDGdg
         SKzvXdxEkW6N4b3+09ZesSba979JcjHtio3uu2jMq+yI4skOtCcT+XxeFh2UpR1dl9ZG
         srMtMIj40480VYEqxuhI1/V13ZDDY/gp2DoQGjaEu9ddaKvPCCaIl6X/RDVC1tnem6dq
         V4UfrWY1pjd2j/AyomVbxc067ytW3GyKp2G+3THGpWKdjEBMi5StZdVCCytyChqlOwYz
         DmEqyqZxEsrhJCPPIg/8LxPV2rxyda8uh9d5NtaQNI+VvC26xzkgsG66S2KTVajI6U1Z
         TTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015345; x=1732620145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGgRP8LyCA/ZR4LXi34oYBVO/Mzz1ZaBNCtp6VsfHdA=;
        b=XFjzNSQZpo9Jw0T8Bbs/CTpP/1fb9bwvTr6lmnBUnxfJEXECT3DJ/ozrSDgSn53SCC
         /eM5DrJUNuOcvWNKSCbo9wwiVL1uBQyS5bnSW8MOO48dbzih3I5iCbUnIDhHBOTrd24m
         rgk/UAblyxWJkjCwWsrH4lpxM5BiyZdal3Vp9rTicF4z8q8vdqBfzLL3538a0aQCQ7LI
         Sa9tQeBAC/OX/5BZh3RUZApxo12dvzTMWW4XuuV0XJMJf65khvApXZZM2vPBum6vZUkR
         a+a4d0LImMXqOxABxzzgb+6t7KObDR0utVGIp+mrMpWcZ90lMHXIMM4x/MrkAUhtT/U1
         eq0w==
X-Forwarded-Encrypted: i=1; AJvYcCUeo0YzoPxeb+og3Sz8ayhzfte2fCecP6o2xLOuKpezncibUj2HoPV7E3fX3T6IPer/lToAemwtOuoo@vger.kernel.org, AJvYcCWNAvIllJFZw/ki9Il+yrGnggtPYGdochseT69mX+N1rLKa0Yz05DvI2Dhifh4M1UTrbm+zb1pqmOiG@vger.kernel.org, AJvYcCWsCBnBTJaRHLMQ3lTRrUuTp84ITXQq8BDHIyfMSMFCBpWNvnZpJuzP6rkOPwNgUD/z3eonLkfaYCd3Z2Rf@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjQZYB5fPMlyzXgdj7c/Qrh6r0uWQE85ZN51VBWLFP+KAhbWt
	HTTY9sY1GrXUGOBbpdcrcA5Pm9KgTBD/XiaA2wv5PwkEMR7q7Xk4R3KsbG07
X-Google-Smtp-Source: AGHT+IFarKhUqFYEoXpabqdId4ulB0jJiaGXNXCAQB82kibPT6v7z3Bx6epHnuzaHen6wC2saKb4fw==
X-Received: by 2002:a17:902:da90:b0:212:42d1:1e44 with SMTP id d9443c01a7336-21242d1240fmr56337735ad.54.1732015344902;
        Tue, 19 Nov 2024 03:22:24 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea45daccbesm5384046a91.15.2024.11.19.03.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:22:24 -0800 (PST)
Date: Tue, 19 Nov 2024 08:22:45 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: ad4000: Use device specific timing for
 SPI transfers
Message-ID: <Zzx1BWSVhd2Y_wtN@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731953012.git.marcelo.schmitt@analog.com>
 <284478615dd32deff29e4e10815cb49fa7d3b5d0.1731953012.git.marcelo.schmitt@analog.com>
 <74ae05a9-6fff-4088-a46c-0a68a5b64614@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ae05a9-6fff-4088-a46c-0a68a5b64614@baylibre.com>

On 11/18, David Lechner wrote:
> On 11/18/24 12:53 PM, Marcelo Schmitt wrote:
> > The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
> > timing specifications. Use device specific timing constraints to set SPI
> > transfer parameters. While tweaking time constraints, remove time related
> > defines including unused AD4000_TQUIET1_NS.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
> ...
> 
> > +/*
> > + * Same timing specifications for all of AD4000, AD4001, ..., AD4008, AD4010,
> > + * ADAQ4001, and ADAQ4003.
> > + */
> > +static const struct ad4000_time_spec ad4000_t_spec = AD4000_TSPEC(320, 60);
> > +
> > +/* AD4020, AD4021, AD4022 */
> > +static const struct ad4000_time_spec ad4020_t_spec = AD4000_TSPEC(350, 60);
> 
> I actually liked the way you did it in v1 better. This makes it harder to
> see which number is which.
> 
May I add your reviewed-by tag if I change it back to v1 time_spec? :)

