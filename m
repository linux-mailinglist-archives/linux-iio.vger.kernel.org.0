Return-Path: <linux-iio+bounces-11927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE309BD39B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 18:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58EE1F23626
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4DD1E47B9;
	Tue,  5 Nov 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIQCUrTZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBFB1E285D;
	Tue,  5 Nov 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828385; cv=none; b=MpIN2x2wxXkAXkjfC8AeT3a8QhZFHj/gZ8zQOFxqU/pGNp92Xf8yiNUobx605dsOo9fIqEt/Z8iEMSdm7zdAm/Vy75xFv9H3CnbvqQibW+Rk4EnvRS5BO2Atdao8kEvhH/POANWbis4+PVq6T8JoKPyaTC0LBEGnAFOhF2b+KoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828385; c=relaxed/simple;
	bh=//t3fv7IHALZDb+9vEeYfS9gixpboKbA/f3rzebXHIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx33W7/GnN/4Cqz+pk5mT7ZG4HFmYexFYBtyP8CeWjfGXK2I6Zg3iuzNZnP37BdaWPLnFc/j04ft+/HCz4tvq87xfnaQIGhz1Th/k2J1+4WhUO04TYm8cJS9q0kH86+uilnskD+yj4Rxvjfl6ds0l0BfgKKEvBtjzaXc9orYdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIQCUrTZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so4194075b3a.1;
        Tue, 05 Nov 2024 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730828383; x=1731433183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+fe20P1tDN9qmX/MwpVQyjr05QyE2RvNajCiS4GD+Q=;
        b=TIQCUrTZ4ZbfhEinElpzQ+OavCwrZmKj46pVO/EotiAf3oNPwGHZX+UBM7FVIsUbxs
         zKtkNN/qsBtnzfY+oN4p2/Vtoz1eI1peVxiHGx+sjR2ToQKsqUh2jvH0zN6Xn3dsbiCf
         uWe8tcSE8eZqmPVMXoazKwR5cD6eyEeYtjonwhohnPtwri+s443GpeJ+26goTEkZ8CHv
         jZhem/YyzKeURMVUTfZVcfXd3y+X1TgBceCACLCtcQNpgEurY8FQcC4eN6HlBr/gXOkt
         XyHLj2C5PTpDaVZ/C77XbTNcDI3NSyPCgl+XYXtskLvNye1agxQ8jyJfQ8URhfHyDZhq
         gMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828383; x=1731433183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+fe20P1tDN9qmX/MwpVQyjr05QyE2RvNajCiS4GD+Q=;
        b=lKZnrufqJvKGYLlew45aW7Thda+00WayK/8R6y/WMScq7yMCVFEyCnL6o/GGrEE7a4
         Wm1CE8XEJ+O2Hv8WaVBMdUchsqteDpLZN1I4QgrFfyXXTjb4IfnrSINV74hJm/TGPfno
         /iFgFaI1hMgnZUkLE3NFuFu+gLrHsYcEbzU+E2KkMzgnI9oPubJ8NAoDvLBl7UAhucAB
         3+vmeiUzABuIOLm/7WTcZE7YxLaewhNlIBeaoE9SpID0H3FXQzo6MtK/F3EKzL6aCkzd
         OkGb5qwwM+3gr2ia7WUq39CxumA2geDzJiXYiP+v/NacJgHGOsjMBCnOqXdb9YBuDAXM
         HIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU39v85et+rgwLMAeGBdzDISCumaVs84WbgDfXnjqOMZIVjPcbQOipUTPkzvE/cfDJ9+uNKCVa4ZHijyRmH@vger.kernel.org, AJvYcCWw8hvrhTid5xB82FisxeG/mkrh4zjihe4T0GXzimAsRElL52Jm2cmxVrqRRYjvhhLONfxAQydbSok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS7qRiQ8oAIIBN+xzYd9a2669Ch9SdzqmK1/DQGVESICd+QxN
	J8vG7TKrXNefTHsgeYhv/UODXLOMzC/DQ0sGJYcPQKvyiwbJNFpV
X-Google-Smtp-Source: AGHT+IHneVKAeOmejkaaF7F6uzEtsGTngUHMIDr8g/ZYKsQZJoEIWsiIYWYVbuz/PjRR8FuHSZS4xQ==
X-Received: by 2002:a05:6a00:ac4:b0:71e:587d:f268 with SMTP id d2e1a72fcca58-720ab39e43dmr35923944b3a.4.1730828382921;
        Tue, 05 Nov 2024 09:39:42 -0800 (PST)
Received: from Emma ([2401:4900:1c97:5a7:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c9382sm9895501b3a.138.2024.11.05.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:39:42 -0800 (PST)
Date: Tue, 5 Nov 2024 17:39:36 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH] iio: invensense: fix integer overflow while
 multiplication
Message-ID: <zttjwj47aro4xr56c5qwme3zyiv7v5fdu4e5c2sgzllpwljw7e@iasdxaxjylt3>
References: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
 <20241103111827.0894a40a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103111827.0894a40a@jic23-huawei>

On Sun, Nov 03, 2024 at 11:18:27AM +0000, Jonathan Cameron wrote:
> On Sun, 03 Nov 2024 08:43:14 +0000
> Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> 
> Hi Karan,
> 
> > Typecast a variable to int64_t for 64-bit arithmetic multiplication
> 
> The path to actually triggering this is non obvious as these
> inputs are the result of rather complex code paths and per chip
> constraints.  Have you identified a particular combination that overflows
> or is this just based on the type?  I have no problem with applying this
> as hardening against future uses but unless we have a path to trigger
> it today it isn't a fix.
> 
> If you do have a path, this description should state what it is.
>
I found this in the coverity scan with CID:1586045 stating

overflow_before_widen: Potentially overflowing expression ts->min_period * ts->mult with type 
unsigned int (32 bits, unsigned) is evaluated using 32-bit arithmetic, and then used in a 
context that expects an expression of type int64_t const (64 bits, signed).

> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> If it's a real bug, needs a Fixes tag so we know how far to backport it.
>
I thought that this is a fix to this coverity issue thus used fix in the
subject. 
If I have to mention the fix tag for this then can you please let me
know what should I mention in the fix tag.
> > ---
> >  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > index f44458c380d9..d1d11d0b2458 100644
> > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > @@ -105,8 +105,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> >  
> >  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
> >  {
> > -	const int64_t period_min = ts->min_period * ts->mult;
> > -	const int64_t period_max = ts->max_period * ts->mult;
> > +	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
> > +	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
> >  	int64_t add_max, sub_max;
> >  	int64_t delta, jitter;
> >  	int64_t adjust;
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241102-coverity1586045integeroverflow-cbbf357475d9
> > 
> > Best regards,
>  
Thank you,
Karan.

