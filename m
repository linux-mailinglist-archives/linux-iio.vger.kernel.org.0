Return-Path: <linux-iio+bounces-14334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDBA0FDA8
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5973F1888EF4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BD1F92A;
	Tue, 14 Jan 2025 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8gHDYfn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6D35940;
	Tue, 14 Jan 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815484; cv=none; b=rUBOQeY/YaEufDydk7JDS1z/LsmVfQpcL2aKnbWvoQuRoMEzuDXoO0eAPw5mNP3K4uxMiCV/sDJtl8dN/nuJ7KCx8ZVTO2CSugCFwtrZw7gmrTBHHZl9NOL842yUVDbxK4Sbs5VEHGUNdzIqYXyOrhYE5zyA70BkGmh0bJgkEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815484; c=relaxed/simple;
	bh=Dr56/ZUNN+NWzqYqrWsZW+rik7XiksfiJ3M6ThMMpp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgfDCx+GzMaRCxJxNTH9+vOJAYIqKER/xLv0GuKHgkeyBZf+FQ2gFWOYB+/PkUOvwEpbg03hpAY4rb3t5ia8R9Xbnc7AYMJw8gnux2K21oYDAytsRKT0ci57QyWqefmFNgch/0zwbMvAGOILGtBMsgzjH9YWu1WyJ4P26CRVNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8gHDYfn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6ebcec3aaso39390985a.0;
        Mon, 13 Jan 2025 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736815480; x=1737420280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GE4ZjTIeCod5vEk7KsTlHbMo8hr4rgjC9/L2IcRCXg=;
        b=m8gHDYfnKaPX9zGxMjlWy33LME37p8Kg5pG/HssxoFz4JjBn2UW6Sz7R8V0wOQcdRI
         Nl+t9XXohiIyqBnCY0yjC+c8Mc2kmaebeYwQ1d1GRMQGJ/6l6/Kg+jB2gMp5o+I+LITf
         0Y2zXd4iwcQ87FCJIepgluFuo76DBnyElHV+s/WpjUkcfsGxlBXA+QPjPg7WRimAap+b
         PG3KvhD8cnxlqNosWWU8u9nwjcGbcyDgUsC/Opfvbb+9iDC62jyuKjaUauBKlXEpSxwU
         uLsvKCPwCHMniSH7GQdJlwqaLqX5pPnW4UzWTbS0qgeY4cCvr5UX1torD0AF2vQQHYv/
         Apxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736815480; x=1737420280;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GE4ZjTIeCod5vEk7KsTlHbMo8hr4rgjC9/L2IcRCXg=;
        b=qSJWHSXpO/z2WdnfzoRm6c9l+k7ni3DiC5+tdSwnjtktbKy7ncQy8rRzJsb5nAL6Xx
         W4JwaYct6gKgSHpyMXlaOACiszqTXrBghtP239ut5ZLzbDE2uHWlypDbOJCNH4riMOfY
         rryKUtnCgvbcX6EGlVzeJ1TQDoh6bsQRhsvl0sdb+nWYZZ+93TAboB3JQZDpU4CTA2u5
         pL5cxYx/hJgaIDSa5YVL/UcPeo4bu2UCNTTEv4p3pTEQCKh6Tt/OriwUlSPVIJjbPX4y
         hRbMHWXdSUwWJJzHslPfFGpCwcByeYpmijho7UadCGnTzDmWMC20eem+OFCDFHkKthJs
         dmZg==
X-Forwarded-Encrypted: i=1; AJvYcCU4v0x0hTRbpI5OhXQHzBoyc2zVNgyrwTrxI8Eglg2anCov6qow7s23QQvqTTimUSHRE/cVVb669gJBOiwE@vger.kernel.org, AJvYcCVMg1giomSr5RqH458ZOHC6AV5sonTEd+tI+bddDs7elOgDzjw3NGwObTwDwziG4E5J4B2xvqFcmgTm@vger.kernel.org, AJvYcCWxTruShVmiLia1Q3SUp77IgTdjHgZqlQuKbLL1nN9wkNbG7pf9+pECUOEFSeUUG/8vzkFBRL9+1qTM@vger.kernel.org
X-Gm-Message-State: AOJu0YyCG5EnL1vPYn8cClhlydZuj0gMUlLqAxjSMY2nPcnFXPVkcQMq
	F/d0hapYeu+YqFF9wfaFfEqd42/Q2lE2COmXAGt46r9Xa0Wc7mqD
X-Gm-Gg: ASbGncssqS8y0hWNIfqLcH7QJt5JmSxcEoRvinW7LprnmmeM8BrhXdHPhebFNBdT5Yc
	CLUFlWqXAnQLaAWrS0PgTkoJWsCnZdJfOQZoW7ElBkHAatqBPshbC2ycpoBdn+rJDRwiElw879W
	yfPHXN7q4YZVTRA/NsOALKYhuHlY4snbKGDylxVthpsp7lAVYAm8tiUMFUlIIpMN6VB5ODxx92/
	wLH05LLpybFh/i0Q7W/52nlqjQAWox0dwhvVW4Bkj+VAUObSYcuqboc9txQeVaOMGfpalHWP7N4
	Kg==
X-Google-Smtp-Source: AGHT+IFzqSCljcv4/ZImVYR7WqmlbqaSxQ2K1uIuw2fSrjcvRwQX8tqI2XfvvA2X9I0gkKKyIDfYuw==
X-Received: by 2002:a05:6214:3a01:b0:6d8:b562:efcd with SMTP id 6a1803df08f44-6df9b2b2f97mr119468086d6.7.1736815480343;
        Mon, 13 Jan 2025 16:44:40 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873dbf16sm46980101cf.67.2025.01.13.16.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:44:40 -0800 (PST)
Date: Mon, 13 Jan 2025 21:44:35 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: 8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 02/15] Documentation: ABI: add wideband filter type to
 sysfs-bus-iio
Message-ID: <Z4Wzc+qsAI5Ga+jQ@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112121617.668f90c2@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
 <8601da92-1f08-40e3-9b39-f9b99dbc1507@baylibre.com>
 <Z4L1qrqHBUE5JGdX@JSANTO12-L01.ad.analog.com>
 <20250112121617.668f90c2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112121617.668f90c2@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Sat, 11 Jan 2025 19:50:18 -0300
> Jonathan Santos <jonath4nns@gmail.com> wrote:
> 
> > On 01/07, David Lechner wrote:
> > > On 1/7/25 9:24 AM, Jonathan Santos wrote:  
> > > > The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
> > > > Document wideband filter option into filter_type_avaialable  
> > > 
> > > s/avaialable/available/
> > >   
> > > > attribute.
> > > > 
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > > index f83bd6829285..c4c21a7bfba1 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > > @@ -2291,6 +2291,8 @@ Description:
> > > >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> > > >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> > > >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > > > +		* "wideband" - FIR filter with wideband low ripple passband  
> > > 
> > > I think "fir" would be a more specific filter type name than "wideband". (i.e.
> > > there are wikipedia pages for sinc and FIR filters, but not one for "wideband"
> > > filters)
> > >   
> > 
> > Isn't "fir" a bit too generic for this case? Since Wideband here is a class of a FIR filter.
> > Maybe something like "wideband-fir" or "fir-wideband" would work better?
> 
> 
> Not sure FIR is even useful. That's just a particular filter architecture, not
> related directly to the characteristics userspace cares about.
> You can sometimes at least build a very similar response from an IIR filter.
> The sinc ones describe the pattern they let through, FIR isn't that specific.
> So I'd not mention FIR anywhere.
> 

So is "wideband" ok for this situation? Removing the FIR mention.

> > 
> > > > +		  and sharp transition band.
> > > >  
> > > >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> > > >  KernelVersion:	6.6  
> > >   
> 

