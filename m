Return-Path: <linux-iio+bounces-23117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B853B30BF2
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 04:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0983B79C4
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC33212566;
	Fri, 22 Aug 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiPWYt9i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7F1FDE09;
	Fri, 22 Aug 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830431; cv=none; b=f0jxChg5uX1sAOtaOddLyDHUk5sRZjldXctRLE991n4Js3CtKHLk8qs7g/86JqDcMitut5y2ANCO0K6gt8XhWYrgbxHs9EQGWbp886d8S7e72WNey5ujKsmkkt4F0OQBkXjia3Rf99CN3cFwjcNfXXrR+4ThlrFGMyfl6cW4SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830431; c=relaxed/simple;
	bh=UEXnKRf3mD8f0fCGxXElWXXYh45iG/Jat56fxEbcdaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umjtFJx1yNzlKH3k3JPCidkwVuvNgv02WLc3RN57G8P0awLtJhZQdNBJnE6DTDvSH2OxNYCEZfUMfolk5ERQDy/G9aArUTHD6wxCqO09vYhM+CDXE8aQeMhMux2hz6D2oIktsrXAwAVRpREHfNfVIUZmNNULeSQiOF8nC3I4ejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiPWYt9i; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458194d83so13951285ad.2;
        Thu, 21 Aug 2025 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755830429; x=1756435229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmvNAnTZATirx63QNW/bi/wjuXppZJGFct7U0B/kgqk=;
        b=hiPWYt9iz33srmOrOKkLbqLrD0Hn1WMt9sdWQ44ANnbcKJOwDab+L0HC8e6GdWDneD
         VvwxpNtlIax2S8BR6ARvaXen+isotk2C37SwEQJXRp//1eACq+xbxe4gIG4BWKaPm2Iy
         e41YFiA2yS+4pFK2BKLBwM4t7+tWYw+Vm+O8AC3Our1NiDyH1mjfI/xO5rsBDxROgUeo
         Ei7pby/eEBIafAmAHaUZ7H5sr5OhoiEDfqKpzmbHFAtYj7J3H4KKKT7nG9M4zXYWUjaD
         uqCfxk5umPP0ft3hFnkCtm6HBdYIbSxaeunrkJedPCqHkmYCWxNiV1nx+BTgP1r5DO5n
         qHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755830429; x=1756435229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmvNAnTZATirx63QNW/bi/wjuXppZJGFct7U0B/kgqk=;
        b=N7BZnNPB0ZlF3q5VC86/aC/+fck/NHUIEJuwEaVAT/VpnApofFXFvvOY++o7hpAS29
         0WN2fY9wH2Y113eRZq2o/vdpy6iiBhtfFo2wERs21l2tRaa96zWltLzF76U4A9RC4fVN
         6G+bolgxHYlDZ34LeTRtICISZjyR3OH9YuKeo15GNzPAdF0iGQIbvAdhZQRVjGATfvX7
         ijcCW58g7dGHGMfUvnSff06jPCCcRG12PLeljhAMH1lLwzYnck7bakE+WnKqw294zmrP
         ZzDEr488ecnNiRuzXria/gyNYqdQxG34gH6e/64zLpAa39N0r0D0V3zcnHEZXo3RtgKS
         yXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJqUuObR6K2ZsLc2SzYiciyTXcJbeGw1juGpaxN/PDS7P/J7/w4TD6tJGFhjssQdGarxw3wWtg4t87@vger.kernel.org, AJvYcCVGi2yDYwJ0rQ16EHkyNYUsTm584E+kM08x7vCRBlYMQjcbKdSj9A2capCjYDzUHNQysJnWXjUObnKxH6Bs@vger.kernel.org, AJvYcCWOQzJGP11P+Hz/3ZLQbJi0TulSSPt+9p67fCCabiIOjYXdelH/66LbegQzTfLfaPMknwPgZ5hopxU2@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8MV+3HLw/1KjQ5UrjM3h0E6odF1OSe2rxLTUAJtAgUBWXE2U
	jjT9NCmXBpqEwpPRzWBCUAQu28eO2S5hM+MFzSdNJi397Dv8BLJ0OQ7vPuwyGFXs
X-Gm-Gg: ASbGncvH/9Uz8ecE+cthp6KuDes37kPJR/HrW6EErCfWwZXr71gK++AhcJU870E0I4X
	/AlWP8Mr1vEeJ8Z3wS4BIH/bilwLN41RxorQa4d8aeThPbprqjVzdNDSuHR8xCYZtYkumnmWDtq
	Pj9KEw/TZxApHKZiQG3KQhMqXe/4ees65yskHtgJ5zgd1b3HtxGHHZT4wPoE9A+ESsC61KRCu/B
	QXKLJvJyvkOcAd0qzXjkdi3KN2A1cUpUZcu2unvfSLONqRAoVIXwq2lQlkPDw+YvDDkJHfXHLCL
	h/ffstvdwa+9r3lbbmX/i8aJIEhSmx4yzituXusDg9BiYz/0bhgUvSDfS6q4YKUQ/IZ/CPgUbn2
	Ct159g/90LEHJazMt8Vtr
X-Google-Smtp-Source: AGHT+IFytykecvrBPA/1/PLvPPDO1rJvEes1V0ZtApwJlR0ery/qJrkcNhzy1lk95OeOs9onGVk0Uw==
X-Received: by 2002:a17:902:f688:b0:246:61f:e977 with SMTP id d9443c01a7336-2462ef9e616mr15378225ad.60.1755830428872;
        Thu, 21 Aug 2025 19:40:28 -0700 (PDT)
Received: from dixit ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f3cada79sm58097645ad.48.2025.08.21.19.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 19:40:28 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:10:20 +0530
From: Dixit Parmar <dixitparmar19@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aKfYlP-yWdQi34db@dixit>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com>
 <aKaMPMnGRyvKqTny@dixit>
 <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>

On Thu, Aug 21, 2025 at 10:41:03AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 21, 2025 at 6:02 AM Dixit Parmar <dixitparmar19@gmail.com> wrote:
> > On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > >  st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
> > > >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
> > > >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
> > > >
> > > > +obj-$(CONFIG_INFINEON_TLV493D)             += tlv493d.o
> > > > +
> > > >  obj-$(CONFIG_SENSORS_HMC5843)              += hmc5843_core.o
> > > >  obj-$(CONFIG_SENSORS_HMC5843_I2C)  += hmc5843_i2c.o
> > > >  obj-$(CONFIG_SENSORS_HMC5843_SPI)  += hmc5843_spi.o
> > >
> > > I haven't got the ordering rules here and in Kconfig. Can it be alphabetical?
> > From what I can see, the order is alphabetical based on the CONFIG option in the
> > Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFIG_IIO_ST*.
> > Isn't it in correct order? or my understanding is incorrect?
> 
> I dunno, The file name there is with the vendor prefix, in many cases
> the configuration option is with vendor prefix as well, but the file.
Hi Jonathan, Can you please suggest best possible way here?

> 
> > > Interestingly that you have used 100 limit and suddenly don't do it here
> > > and maybe elsewhere. Why inconsistent style? Please, go through the whole
> > > file and make sure the style is consistent in all of the aspects:
> > > - C style used
> > > - comments style (one-line and multi-line)
> > > - indentation
> > > - etc.
> > I tried to follow 80 limit(except few places where it was just on border or not
> > clear to read). I belive the standard is to use 80 limit(correct me if I referred
> > wrong place) and I will recheck to meet that.
> 
> There are two standards, the old and strict one -- 80 characters, and
> this subsystem _tries_ to follow it and relaxed with 100 limit.
> The exceptions are possible when it affects readability.
Understood, I will go with 100 limit and make sure everything is well within it.

Thanks,
Dixit

