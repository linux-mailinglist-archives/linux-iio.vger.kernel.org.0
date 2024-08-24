Return-Path: <linux-iio+bounces-8761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A757C95DD95
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C191F221EF
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B315F3FB;
	Sat, 24 Aug 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWFQYn8j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31395154BFF;
	Sat, 24 Aug 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724499317; cv=none; b=s4FYlQlPYDaIdG4CjPM4Y2ViBIn/aM6atgtpVTBvjASPJ4gfItDAi5tzXUkGdxtV/m7XZ3ucR6itpAENtOqdHFkEmpcXwteT7h729J2TeALKsBd4seWF9IXRvkOKgZdWuJZE9ovciObcNUPnAhBBFPi3vZI6jo2Y3iayHSLaV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724499317; c=relaxed/simple;
	bh=t/tL6ehLjV4OWhky2j+jkzqdbt2qnhGbcM6j/gEegpw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc1NHWOlYEpZb/SOqKQx/3AbeVMdvL63VUGxgC/wydLL6zK8pARuIijCnkz72z0yyeiVDRUiwbNFLE5UeLcBmXpqdKgvgU5TgWqNXNkzmyo9oM/A+N0+/KVyiIM8zDCAFnZJhY9T77czzUXVM0e87bMTj1xtpioBVoUmeFaFSTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWFQYn8j; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371b098e699so2005034f8f.2;
        Sat, 24 Aug 2024 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724499314; x=1725104114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXOM2KHFDkv7tZuZv571SO8T4HJDxtBCPL9tMZDTfeY=;
        b=JWFQYn8jAZM3yHfZi6G+yB/MqBPZmeZUcPk9ZCO2SiY6spG4PGYmrsgKhAtMp4XkMs
         qrsPLeojL+vzxSoTUNQ3nZpz3MpvPnTSjlRZchr8jr/HrddhO5xlMp14uwFb25c57dCO
         lnyGtXbmrya0PXYac2Hx2H3tZFcOaFfEiSiMKPJD+PXm/7Drb+1WL+6elhO2rRFeAuVl
         JhZBQw/hrMNVitUglxi4RjeA3fvCceudQKGlqXzxsZlcX0rnGEtwq4A+xJ1P1PNL/B/M
         CLYMYn4Ub09WdyJI3trtLEUvhyPnkm/j7eFHVqrqQdlE3eUCGRFH0VicxT8bk4U4fnCu
         A9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724499314; x=1725104114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXOM2KHFDkv7tZuZv571SO8T4HJDxtBCPL9tMZDTfeY=;
        b=BpLDkopaezMELIlrvYMcI02fE/IGE5jL1IHUc66iv9kvcMHL3GzU5qzqFqiSJhGWyj
         5j/pbL1wKDMGK+T8d/OAU7hp0AYQh0OsHuWKoun7mXn7+ImwsXvsueD0FP5VM/VnpVhR
         3fxA/HqnxsrlrPuXDu9xv2nICssqv+6YtKqLV02g0ksjk2HAH5o8VG41byCB1pL0etTQ
         yAe9xalkLQJHhQVau2Z4a4UzQtY5N9Yi68bJaiIziB4c9eJKp96oHnO+DvK8JQZu7pEM
         e15DK9o5Ljcxw5nI68t0eIl1eFjW2E4AFYsBmBUrPFWybOcoDLB4n+P81S6qLXVy18Xt
         sQGA==
X-Forwarded-Encrypted: i=1; AJvYcCURYCz+rrE5C+HJWgrAREdg1XnebVXmYJy+J4K6cF4MT4YWDA4rtva5AgabjsjkVHxZAqT5CuRSOHPr@vger.kernel.org, AJvYcCUrS8tW6HWX9XiI1GHM40q/dfSYkDGCFMp/5qBhGp6T1ulKZqFhELuHxP6UGzaWsIpuCjblv//WzyH7R5gl@vger.kernel.org, AJvYcCVIigcGf5IgzC7xFikKAkxkO+lZn+ZSBoH7Rn1Mhf1NL+X0t+tUuDQdL6AaaVrt0/0uiHhaDv2m2OSj@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKYHd4TUeRKfjFqEFW75xPFb4ROWjHMuZtlIVYdoZfsQMe286
	Yn8fA9vknsKTOPMOqpc30rOgtz0Npc5Ygenrb/T/bE/58B+SJvBN
X-Google-Smtp-Source: AGHT+IG9K8hxz6buL8YPyj7RwlUEs5tHu9FteE311/SNhdU0HADUGvJ27BcVUSR7Ma9mfgZeDPvLEg==
X-Received: by 2002:a05:6000:82:b0:368:e634:1520 with SMTP id ffacd0b85a97d-373118e3d6fmr3815569f8f.59.1724499313814;
        Sat, 24 Aug 2024 04:35:13 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a4bfsm6362353f8f.62.2024.08.24.04.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:35:13 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:35:11 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240824113511.GF9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-6-vassilisamir@gmail.com>
 <7eqtnkkgnyskkmecv7dtiyzd6invdl7xa56cih6fbuuu2jrprx@s4jpi4ls6dxn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eqtnkkgnyskkmecv7dtiyzd6invdl7xa56cih6fbuuu2jrprx@s4jpi4ls6dxn>

On Sat, Aug 24, 2024 at 09:45:43AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 23, 2024 at 08:17:12PM +0200, Vasileios Amoiridis wrote:
> > Add interrupt options for BMP3xx and BMP5xx devices as well.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > index 6fda887ee9d4..eb1e1ab3dd18 100644
> > --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> > @@ -48,9 +48,14 @@ properties:
> >  
> >    interrupts:
> >      description:
> > -      interrupt mapping for IRQ (BMP085 only)
> > +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
> 
> Supported by driver or device?
> If the latter, this should be constrained per device variant in
> allOf:if:then:.
> 

Hi Krzysztof,

Supported by some devices controlled by the same (just 1) driver.
Thanks for the hint, I will take a look how other drivers do it :)

> 
> >      maxItems: 1
> >  
> > +  drive-open-drain:
> 
> Missing type, unless some other core schema defined it? But then I
> actually wonder if we need it.  Maybe this should be interrupt flag?
> Just like GPIO has such.

I took it from the bindings/iio/imu/bosch,bmi323.yaml example which is
the same. You think something needs to change?

Cheers,
Vasilis

> 
> Best regards,
> Krzysztof
> 

