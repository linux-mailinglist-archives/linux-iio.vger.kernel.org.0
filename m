Return-Path: <linux-iio+bounces-18349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FF6A9453A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F00178EB5
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 19:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833818A6A5;
	Sat, 19 Apr 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrJ4nwLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144238F54
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745090366; cv=none; b=hdcp+6hrpSoL21tiRdQa8gkZ0ARd7kWan4JchBS/qo6rKOf8mK4iJomAVHn1wJBVoOAu7sNqAIRLQpXs2asKEZbZ+gYGzn6J54GylZ5ZSKkD8Cm4puUwosL5RsrRgybgVGI7DUqErKgxelEpgt1atmaXIy5fxhNJLx8Pi+0iCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745090366; c=relaxed/simple;
	bh=oPCTEo+ndGI1XWlCv8GFeh4yiX8Ybt057MZmLMShBrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHcnID+AvT/NwSQrX5ibr1WA/Dz8I+GbVRx3/157MVHgRZiSz++epiTP+x+TJBmyHNgKTil+yWESxbU3D9l2kQbYqB0baRENi1ri4PVkKF8K/b8kPQpREIH1Z/IrV0uScTSh/sqUd9sDcv7q+wY+xdUjef8akNAorCVmKJqmZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrJ4nwLt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso2736357b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745090364; x=1745695164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ac3vbODzlo0MaYymz8aIlgvdkaWAapBqVEQ+wAFlAVo=;
        b=jrJ4nwLt7P+peOvZ7AnQDmIkG7MUtBpWT6rh2xz4dg7M7Pnb22mXH5KNRrejfgOBLL
         MomlTUYZDelNTovvjIBLfZWud04/XweZAyUelT/eZ8x8zi/1T1do0gUyfgClzjdWYkqX
         MWXWhzhnEpWsD7qyr0GBacWmap0NTw9reKqOIxlyv/IirxmfWrEQUa4tYPHP4f0ggITQ
         vKCfZ1NLzk775CEyiINIsDwt0u1xmpaDfutVThMJTLGQrEERPBHfgCBtiGXse2rfm8Lo
         XmKs2dMDr3q/u4QpN8sawfSReTIfX6Efv0Ky1V8oTfgCFvGRC8X6xR0e+4JvURX7lfQV
         Rytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745090364; x=1745695164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac3vbODzlo0MaYymz8aIlgvdkaWAapBqVEQ+wAFlAVo=;
        b=TEEAEWMiwCRkTo1F58hSKkT8gMU/Yhj+PQ41uDeaS2cEXQj28u4egjKVjPfCcIJWaW
         qvJNgjUbnvS6E2eYMvKIqHCTFVWSq7qQqojxT0AxWfjF0y0TCeMydyPcLzgrCpS9VD4Q
         SOkPwCOUK5LN4Tp0x9Q0Vnkmu/oPSA0Cn8xIGltERPxwj7w0CJ7DBoXTCVloYaEPX6jo
         1Pkt8Ugx+FfxV4UCNUtEUd6SKx3p5afuvQI10xQrGY53QE26z0LhzcV/hG0iId1FLGHR
         ikYGog5ej636Yoj7V7VnJGgQi3Q5UoAIhUzYFvi2G4suY5/5QOwdOm0HyMN53FCiCWEH
         WCqA==
X-Forwarded-Encrypted: i=1; AJvYcCXDgTW7WbpIbOWrlghDmHQyGS0zWjfk8oHVrcicWK0Ch4JZ79H0/5u9SVWAP629TwDX3QevIQzeuNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3SRYwYswf7muXQFKg5/u+k/yrm7FHyniHtQWB3u5KgRCk3Hl
	zUAUUC6RO4MPguVbCUdgcHylcmCVymYDLESe9ooGoo1zVWvhLXBX
X-Gm-Gg: ASbGncswnwnkyuSZAWKwea7CurPLEcqqJU9CO+fOT7E26mS1Jiva+s+WqY1zI9Mi/Kq
	pp3hhFC5FRFzsHmsdttDc0dmzbzzU+b5ho9PxYdzIB9vTS2bv1YTEWhG1gQ9iYXwOc9Eh5JZu5t
	nB4TADsCkgiNbQBqzz51cKXjkaom2KbIXM5IDJhuBezZ4SRIf6VlYjxl0A0h4+NibFH6ZeoWMh1
	3sD+I9pHxLcQkUicjGtUwTqZVQDRgGvOImV/6vJhxqJ2/bjVZHgUNuwpY3e/2W8yUL+C2Ec9NMc
	IUqACzv8OYCawZf2vHZRN1F/oCJIrlmdOr8nkwcKfskKuEs=
X-Google-Smtp-Source: AGHT+IFmayMqTZnsGnk75fZlPMh6S89j22or2hq8fTo0az/iumj2RnQ/GU+xIiEoDEWahgh8GrbdFg==
X-Received: by 2002:a05:6a00:374d:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-73dbe4e3a0dmr8399759b3a.1.1745090364155;
        Sat, 19 Apr 2025 12:19:24 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfaeb282sm3746375b3a.176.2025.04.19.12.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:19:23 -0700 (PDT)
Date: Sat, 19 Apr 2025 16:20:33 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Arthur Pilone <art.pilone@gmail.com>, jic23@kernel.org,
	marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
	arthurpilone@usp.br, bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v1] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
Message-ID: <aAP3gbRT95b6Ip7g@debian-BULLSEYE-live-builder-AMD64>
References: <20250419161347.28157-1-arthurpilone@usp.br>
 <906f8d69-d08d-4150-9f84-2ce714cccb3c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <906f8d69-d08d-4150-9f84-2ce714cccb3c@baylibre.com>

...
> > diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> > index 092ddea0f395..1b4e0ef43260 100644
> > --- a/drivers/iio/adc/ad7091r-base.h
> > +++ b/drivers/iio/adc/ad7091r-base.h
> > @@ -17,6 +17,8 @@
> >  #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
> >  #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
> >  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> > +#define AD7091R_IS_VOLATILE_REG(reg) (reg == AD7091R_REG_RESULT \
> > +	|| reg == AD7091R_REG_ALERT)
> >  
> >  /* AD7091R_REG_RESULT */
> >  #define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
> 
> TBH, I think the old code is more readable than hiding the values in a macro
> even if it is duplicating a few lines of code.
> 
> But if everyone else thinks this is better, I would at least suggest to make
> the macro AD7091R_IS_READ_ONLY_REG instead of volatile. Using not volatile
> as an indicator of writable seems really strange. But using readonly as an
> indication of volatile seems more logical. A comment to the effect of "the
> read-only registers also happen to be the only volatile registers" in the
> ad7091r_volatile_reg() function would help too.
> 
From my side, no strong preference between having the expanded code or a macro.
About the name, I was thinking about it the other way around. All
ad7091r-2/-4/-5/-8 registers are writeable, except the ones that are updated by
the device itself and those are read only. Of course, that logic only applies
because ad7091r happens to not have any read only reg that is not volatile
(e.g. a device or vendor ID reg). Agree though that it would be nice to add
a comment clarifying why volatile regs are read only and vice-versa.

