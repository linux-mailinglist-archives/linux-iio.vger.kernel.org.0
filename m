Return-Path: <linux-iio+bounces-5207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDD8CD10C
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AEEB209DC
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75F145A11;
	Thu, 23 May 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6lCag6+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82D144D0E;
	Thu, 23 May 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462886; cv=none; b=bzJ5iqoeH0r9/WpjLByq9x+qxe8wTTqqJXRePkOTKiQBFbDFhQhzrpOZv1aVUDU2j1CzG/8bd9K4F5Qr4SzFeIcRB7XD6ugHbj6OAJavWGo65/sfV7bhOms19MJ9cjDAHihqitHRukp+XPA1LStc/rGASvv80jgsl519uVpUtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462886; c=relaxed/simple;
	bh=8n6nu/lTr7f8BK8EmXMpV/7Mr500bB6UmP2ECf0sGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBfoGH5/VgorvzReg5jPYJ/DVvN/Af7OR+6XNMUTyaelfMUekaMDe45mzRAeT0gZEhLs1iIlx+ttFC5uw4REm5R9KTq4sjJ+zVPa+pPMf36nQW8kit23OQoiuKoyfERf93YH0eUWxn6dpc+rdLbrsfhujuqlHUnkpNuYhpPaGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6lCag6+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so12477319a12.0;
        Thu, 23 May 2024 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716462883; x=1717067683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPc6oaYLUIIGqFx5m3Yc4i8wcC4CESeJfJvk9pDUTzs=;
        b=J6lCag6+rl+22jYeYNGrX6kj35ZhAQ9ZnmnKoeUMKXJUsoZm81cGHwiUohclbQ7UH5
         GiWtIe5e0upq2/8GBs4t2uFZiFciSO47/JJ1hB/BalPOxdS/1PwIDYl+fzwFcRi3gTk4
         TsYJobP/gA8KwUtrw9J5ChszVySGoDMgySNgRz27X3SxnnWzN5FlSArXABN2B0KekNVY
         R82UtkmY15pS3EesRVt7ycrEIZvUbp/CTYywsUH/Y+BhQlVCplhXtCxfnIGKGanpajUE
         +Vk/qI+KNJPBKjkubxFNMiwAnbDee4R8RNa76J6P5WBDXJ4tssbG2o+Nfy/cvSBnL4hT
         fcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716462883; x=1717067683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPc6oaYLUIIGqFx5m3Yc4i8wcC4CESeJfJvk9pDUTzs=;
        b=KFfGPl7tiBqk4WxPDtjzRKepnKIJmFBzJnka8zAREHtAbsKNPmqDvE0gNwIbtTQYNd
         Xy707gZkFjfNbKclVKIVoGLJsTPMEl4z2+wqbz2ggxuylkLKEzN8mp0uTRh84WKdN9Ng
         Rk3v5W9y2/c7zE13LvvCwuT06CnV7Q6Wm6neETIQcevN/87ppsPVQW0tbfNyCuTuKxGf
         VzcsELhnv3aheDbKaA5TI6LbNcZwHzGGQjhNoFXIcHFR0nL+4MqSTV1L8kTO/9Ro49R1
         gc0lxAoNuglvEd4MF2Kon0X9QuZxfFmIeEKxIzdSRKefNZjdR+hSqa+IYlJUiwMz4Jr/
         urTw==
X-Forwarded-Encrypted: i=1; AJvYcCWTDzqPK/b7qnv4TlhvEAHOdftfG6C549bb6spJvOowDISyt025vJMdvYs36Yxw4aH7VYKeRTIGp9ZnRRP2ap0DrL4cm7cgv1JyJfT23X1eSJ7+UHslthJHSUIkH5TjuK/IGyHygM1b
X-Gm-Message-State: AOJu0YwROEwg7A9A+BfroosLVVobZr4R98Dqo25m0rEwpqr7vqzEGokq
	Zbvl1LoCZDZkBW5TAcu618n0p7XXX4WiadjpB1wc1MP/8x2o8n97
X-Google-Smtp-Source: AGHT+IH4WazQgFCrLINa6YVkA20c3EBt/5RUNd6fAmHu1NvenP/fjy1zrgd/5ZMDPuq042lL4tH/eA==
X-Received: by 2002:a17:907:75c6:b0:a59:c833:d275 with SMTP id a640c23a62f3a-a622807c913mr270829066b.30.1716462883107;
        Thu, 23 May 2024 04:14:43 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a69148b97sm1463925566b.114.2024.05.23.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:14:41 -0700 (PDT)
Date: Thu, 23 May 2024 13:14:39 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240523111439.GA513807@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
 <20240517081050.168698-3-dima.fedrau@gmail.com>
 <20240519174248.69f00448@jic23-huawei>
 <20240519210036.GB10322@debian>
 <20240520131850.00003430@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520131850.00003430@Huawei.com>

Am Mon, May 20, 2024 at 01:18:50PM +0100 schrieb Jonathan Cameron:
> On Sun, 19 May 2024 23:00:36 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > Am Sun, May 19, 2024 at 05:42:48PM +0100 schrieb Jonathan Cameron:
> > > On Fri, 17 May 2024 10:10:50 +0200
> > > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> > >   
> > > > The device has four programmable temperature alert outputs which can be
> > > > used to monitor hot or cold-junction temperatures and detect falling and
> > > > rising temperatures. It supports up to 255 degree celsius programmable
> > > > hysteresis. Each alert can be individually configured by setting following
> > > > options in the associated alert configuration register:
> > > > - monitor hot or cold junction temperature
> > > > - monitor rising or falling temperature
> > > > - set comparator or interrupt mode
> > > > - set output polarity
> > > > - enable alert
> > > > 
> > > > This patch binds alert outputs to iio events:
> > > > - alert1: hot junction, rising temperature
> > > > - alert2: hot junction, falling temperature
> > > > - alert3: cold junction, rising temperature
> > > > - alert4: cold junction, falling temperature
> > > > 
> > > > All outputs are set in comparator mode and polarity depends on interrupt
> > > > configuration.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>  
> > > Hi Dmitri  
> > 
> > Hi Jonathan,
> > 
> > > Please make sure to address all questions in earlier reviews, either by
> > > changing the code, or directly answering the question.
> > >  
> > I did, see: https://lore.kernel.org/linux-iio/20240509204559.GB3614@debian/T/#u
> > or did I miss anything ? I'm a little bit confused.
> 
> I think some emails went astray :( Sorry I didn't check the archive.
> 
> Anyhow, thanks for providing the links.
>
Just thought you were to busy to reply and that's because I had send a new
version of the series.

> Jonathan
> 

