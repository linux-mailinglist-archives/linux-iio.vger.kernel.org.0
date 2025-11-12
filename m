Return-Path: <linux-iio+bounces-26187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC08EC54A29
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F34E3216
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1C2E1C63;
	Wed, 12 Nov 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgTEENXw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0651F2DC788
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983480; cv=none; b=R5QYCIRvki5WVdDcdeRIWoCi0sYAbfuoIqnwDPjusTu+2Xa33HNbyLZnVjeFfEuLJLmzF8xfLmzLtm4SbkAPUBF5egOfDs0q5ZwGsnmCQsZXuTYsnu+VqlZ5b7UEBAUssjWWlnfq1bz4K7ofiiXB8ahu7anVGufwdWMI/5ZCla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983480; c=relaxed/simple;
	bh=+bUleK0B8PiE7Fk0SaUF+J+QNb/VCv1zue5xnjCOWY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1y/KUmodGhWzHM/rASdkpBySxOI7ZRosgIP1Wvco5zL2YSlbBxnXj7tqeI5eM1W5OmdrENhgtGcUgIJFo/PrymDTimv54INVAVOrRQIIXUBiduePmMCPvjz0yFz1e/0reHKTKOHB+xoV9PN3wvgAYmRcqazHOMIpFkVxBgTJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgTEENXw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477563e28a3so988425e9.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762983477; x=1763588277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4evj7W1RMWi1DGU6HCMJFRDOHQDQQckuWXz5qPHKAuA=;
        b=SgTEENXwXrs74kTMQbThyXnkys1A6gZLa3d1WHDrC6/TMD2l3++C49aCIiKGttnrih
         ConG8RSwlQk13NCsGtQqov+KrOZsNUVgYM75HAkfcAz370LT4dfAkZlfvbQ+oLUTSvVz
         /0IK3Izf8I/+tjfaUnxK2hu6+dwJCeutLY/oD9wskfeZYLqk5ludPX1Rgzi5uh+GZwmo
         dKbhwxbUT1I68+D2FnxU7+shM+aTpJpqf2JaGqplFyeYbGkybwL9Z7bbgwnOPVabkd3R
         sBlfQa6pBC0YtnNAHaW9iVGRuMD0ssASooVXLxZxlzjb7pg/C58jOqtlL4rcFn+8r37B
         WGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983477; x=1763588277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4evj7W1RMWi1DGU6HCMJFRDOHQDQQckuWXz5qPHKAuA=;
        b=KAFi1ahJ36K4weezOS9ikLjVb3l43fMf83iN3Y5EH8s6NuOyFKEPBFW4kCUAUsGYMd
         RZ8/L2uT350ydxvt86T+5UfA0kpH64abRNa9hgI/eR64KnHsos23n/2XhHTzdafqtmUS
         u1n1vgelgN4Kap9GqxQKxIHzSRW8M9J7ujKE5QEvP0d2/DKqp+gYQJVYdnvkqs9P4mxc
         1YEXjrjW/1s8z7X7FWDd0asc/W42kYMzNAsl0bMDpzbtvTSUR/iRTLvx+UDCxxubfLy7
         1U1sxyT//2vgWCzjVBZuJij5uHYUrn0X9ct27R6S5AndxRsQ95G3s6bJVAhrOxTq6BRw
         OwHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/yiKKv6fawcVW/VUthPdfWCHLmVfDdgyQvNclqesgx11BEcVqmD+gnZuTWFT8ilOUobunbkwSWxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuLFsC4jQxHcFeKfvF8mLm25yErmP4ZmQwRZW6xb7NugiJizZ
	pFhY926qqglfByqJH8XsjigAzRH0bDmdOBE7bdRoPT60/B1QiSgb29GGIgxl0YSw
X-Gm-Gg: ASbGncvfcr5ZwshFnCimY5e0qLlDMrWVhE1lXbcO/5qczQ39VBmVlloYK3uS5Ai4vDa
	Jwpz8n3Wq+8FGeyiHpNLPMMdOuaRDqIxnoe4+xrjKvRtIRFAEUD6JPikRTNPVrikLFz2P54D4bN
	EsoFtygVlPHM9i+2GE5/CS11mrggDhbK02mrim0vI2Jj8695khuxiRTxT3O3sOnJbSDQs5mzavv
	l1F9Ta3xagAhWoFI7r7ritqq+XHoAIrhJknGGwxtnk/nWZMQ9ZUGE3SL6j5ATCQ/fiiGkS7xLMO
	cTSqGxpD9PxfJqjNirMOYAEo0X4G2oKOCAxuW2RdF37gyzpAczH7PpCjiq0JhlkEn1uaHF3iWXO
	OTc8hqT1jNoREALBVc3wLlCDxtId0w97GNwDD25vfk72dU7uoXS2Zfq8qPme58Mesqd3n4ugq+f
	taegngz33ghjSzwu+1ijR5TyUYN3U2/eIRtu+7fomqRM3atW1CyAma7N/dkLBSVB2GP6qpcAzBa
	CPzy/4+c1iY5GsN2AscBMwSezKBXXCGyzChYXAc1VyewYFJ
X-Google-Smtp-Source: AGHT+IFVREUT6iLk315iqZFQJC6ImzRQ9dAqU1Gfy56ootTo9We7Wq3zsRANNkZ3GC+r7RPmOIr7dg==
X-Received: by 2002:a05:600c:4ed0:b0:475:d9de:952e with SMTP id 5b1f17b1804b1-4778bd2ccf9mr9501615e9.1.1762983477135;
        Wed, 12 Nov 2025 13:37:57 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com (aftr-82-135-81-2.dynamic.mnet-online.de. [82.135.81.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm54307145e9.14.2025.11.12.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:37:56 -0800 (PST)
Date: Wed, 12 Nov 2025 22:37:55 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: Change adxl345 depend to negate adxl35x
Message-ID: <whsmsygljixaqh3mfs34fnnlcyptxxxxlsujljawdj7jyl2ce2@a6oshhvsi6dv>
References: <20251031-adxl345-allow-adxl34x-mod-v1-1-cd65749ba89c@analog.com>
 <aQSL0wCr56zr5Y35@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQSL0wCr56zr5Y35@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 12:13:39PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 11:05:08AM +0100, Jorge Marques wrote:
> > Change 'depends on INPUT_ADXL34X=n' to '!(INPUT_ADXL34X)' to allow both
> > drivers to be compiled as modules. The user then can use the blacklist
> > to block loading one.
> 
> > ---
> > There are two drivers for the compatible:
> > 
> > - adi,adxl345
> > 
> > * IIO: 
> >   drivers/iio/accel/adxl345_core.c
> >   drivers/iio/accel/adxl345_spi.c
> >   drivers/iio/accel/adxl345_i2c.c
> > * Inputs:
> >   drivers/input/misc/adxl34x-spi.c
> >   drivers/input/misc/adxl34x-i2c.c
> > 
> > To disallows both being complied, the depends INPUT_ADXL34X=n
> > was added to ADXL345 symbols. However, it should be possible to compile
> > both as modules, then blacklist one of them in the /etc/modprobe.d/blacklist.conf
> > file. This patch changes the rule to !(INPUT_ADXL34X) to allow both as
> > modules, but still disallow INPUT_ADXL34X to be built-in and ADXL345 as
> > module.
> > 
> > The following compatibles are not shared between both drivers:
> > 
> > * IIO:
> >   adi,adxl375 spi/i2c
> > * Inputs:
> >   adi,adxl34x i2c
> 
> I like the idea, but I think this needs to be clearly stated in the Kconfig
> help for both symbols. So user will _know_ that in such a case it's their
> responsibility of properly made choice. On top of that you might want to
> investigate existing DTS in the kernel and see if some of the choices may be
> made at the platform / CPU level.

Sure, I will add a info for the user in the symbols. I think the choice
is on the defconfig that the user uses, the driver is a accelerometer,
but one exposes as an IIO device while the other as input (e.g., for
screen rotation).

Best regards,
Jorge
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

