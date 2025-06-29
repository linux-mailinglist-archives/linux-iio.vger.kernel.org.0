Return-Path: <linux-iio+bounces-21138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EEAED027
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 21:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6903D1895833
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403E1E5B6A;
	Sun, 29 Jun 2025 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gN74XoHQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09816E863
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751225582; cv=none; b=r/BhGpJevkqWSGDnu9TxucfRIZuKKq1FBeaj+dv9tHvJppbHGpna1hsY8rj+eCuum6Oi4fjXuGkPmuNi8MoBeLKTuNAvh9FKHutSBVntMeC1eKnKCLu1wp5cKhO7oSaZpHIvwMU0nvn6S+M5zR5VgYXMbO7TLmkVWbWS1aP3Xis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751225582; c=relaxed/simple;
	bh=AJLTGfqS/5tOlPMV5XW2523KDBahtNLYAuFkybM609E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBVmn0jR7Qk6545C2Px0K5T49Er0lfWjj9w960CNpYwbek5uxR9upAGKUizwgU1CB8mzc2VoL7BRuU9Ka0We0EglcVTIJ9LQS4qIp7koRE69DwRwPp+b5+C68oOhDUC6Xze3HOmfHTCuuL7gun8AUOSK9UwOd9njOMxdgDxK5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gN74XoHQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-237311f5a54so9028935ad.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751225580; x=1751830380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bgLzcaCH/vEPMnZRhHHq+CXVUi9PA+EScD24rqexGK4=;
        b=gN74XoHQmuy2ZZCnEBR4NQRIUvsTmU1ihYKJAOOwwSuAeqE7lkL9bsDLxtYjGgxeAI
         hGR2hL36cCvsHzKKEH9CRbldmXxP11PD3ssxSu1SGRRPIc7A8AFnjTZ3yKB7HOsaLCMZ
         3Ntjp4SemuLFqygzX3yZPTUbSlrsw7M0vvLoQLo4wp5JOU7EhevxVWp0CbYAKwwHdlS7
         7MBc+yzjEiNx5plBnlGESvQclhkfxWj6W/zIAA+KVmUQMPWboH/bRJ8Rt0+oNb0yoCrr
         QfM2/Vw5UTrXMvHCGkB551Mmd4em44ylMY/qngzs5x4DONUGyVeobNGVDL/kQ0xivUvq
         6A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751225580; x=1751830380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgLzcaCH/vEPMnZRhHHq+CXVUi9PA+EScD24rqexGK4=;
        b=IQFIObb9NlNav7DEdwfDc06NQ5EbskKybIiWwFsdaqvT9qx+dBTOzgcp1NwGfM2Yq5
         pIZqcDSDomg77NgulKfxr0v9pDOqQfGTsL0XppuCZWhNQzqJfXYLbnTVwfzOR+lEVMAN
         P00Px06QHtnZF3BIoxqHb4d2XMYHXxgLoHWN/yv1UeqZFlFqt/DVF+NZnwgzs+dnAiK1
         GMgYpjmX9jWhPOF3AcVvClJl/1QZbimSd/+ouqLTneSyMlVnH0ECllSqz/64x4yt8w22
         sK1IP+OSgWrKPyzPRYiKur5e+zFiQ8k5Rv3BW06xvlTP34SlJt9DWNNb6VUj+SBSBsbb
         7z+w==
X-Forwarded-Encrypted: i=1; AJvYcCUKtc4UZXSt+12pG7qru7h365dfKzjdZGlviuaxJ7zQhp0Yq47+FtCLw3jQP5vBMAh23i54ekWdN7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCX3oEmlCev1h0ya/w4JpNXAmFMCNMOZs4lNuOk9GFlcFmtiN9
	I2pcv1zPac4PO1dTmuU0jdJXYciFAbTApKMcsZvuRWaOyZfmu98n6qlCOQJcIIGWrlY=
X-Gm-Gg: ASbGncuYd0oK7yo16NpxkGC4U0eoJiuCr1OHGgYp/jjyUOTnEURA2OQuulb9pUALyD8
	eHfdvqF3riC0g4I1ijTXQ2X3bUUa0qdvvbFdSJUf8rY0Kaup9CLEd/ABNXUrW8nd5Uh+uvumSt0
	FXjHOMgZ43CcXuP0RZ0bbWn5kjAMq3rfXmXmLBlfdfTqkGDfRb4faXDDeD+kMiv1rOdlGoG2vn4
	mDb9bvcNcq0/ZSArm/FRvOiqd8A42X8sgE6aGL2o1XFBEJQydYov3tLhjBMazqMLTOpviww0cvO
	gBPXdFgtMGSA9jROhjGMrp/jiZaETHYZS6DIsC4DklYsm77f3wV/QslNaKUi1aECn5iCmwgPlBM
	mWWa7plZODI2qehGSFeSk2w==
X-Google-Smtp-Source: AGHT+IFR5OwbLIe+zzlcoErz34GP7sC9TYblSfNZdc+JTsF9CYaAFybDf1lF35GHnh0xkSJRdozeng==
X-Received: by 2002:a17:902:e551:b0:234:9375:e081 with SMTP id d9443c01a7336-23ac460719bmr160637285ad.42.1751225579780;
        Sun, 29 Jun 2025 12:32:59 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bcd2sm66533055ad.131.2025.06.29.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 12:32:59 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:32:47 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for
 adc121s021
Message-ID: <aGGU3+EPIIRkOF8z@dev-linux>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
 <20250625170218.545654-2-l.rubusch@gmail.com>
 <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com>
 <20250626192802.0079d579@jic23-huawei>
 <aGCCIwknL25yAyHL@dev-linux>
 <CAFXKEHZcUpEpKPQP0CuJmiw20igrDUUEkB19RyQ=FHRqy+JiUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHZcUpEpKPQP0CuJmiw20igrDUUEkB19RyQ=FHRqy+JiUg@mail.gmail.com>

On Sun, Jun 29, 2025 at 06:13:54PM +0200, Lothar Rubusch wrote:
> On Sun, Jun 29, 2025 at 2:00 AM Sukrut Bellary <sbellary@baylibre.com> wrote:
> >
> > On Thu, Jun 26, 2025 at 07:28:02PM +0100, Jonathan Cameron wrote:
> > > On Thu, 26 Jun 2025 08:24:41 +0300
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > >
> > > > Hi Lothar,
> > > >
> > > > On 25/06/2025 20:02, Lothar Rubusch wrote:
> > > > > Add support for the single channel variant(s) of this ADC.
> > > > >
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > >
> > > > Thanks for this addition. In principle, this looks good to me but I am
> > > > afraid there is another colliding series being worked on:
> > > >
> > > > https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre.com/
> > > >
> > > > Maybe you can align the effort with Sukrut?
> > > +CC Sukrut.
> > >
> > > >
> > > > What I specifically like (and think is the right thing to do) in
> > > > Sukrut's series is replacing the 'adc122s021_channels' -array with
> > > > individual structures. In my opinion the array is just unnecessary
> > > > complexity and individual structures are simpler.
> > > >
> > > > Other than that, this looks good to me.
> > >
> > >
> > > Sukrut, perhaps you could add this to the end of your series, rebased
> > > to those changes?  Would save a synchronization step for your v5 (and
> > > later if needed)
> > >
> > > No problem if not, but I agree with Matti that we should take your
> > > series first.
> > >
> > > Jonathan
> > >
> > Sure, I will add these adc121s0xx to the end of my v5.
> > Thanks.
> >
> 
> Hi Sukrut,
> 
> Since David Lechner still asked for ordering the TI ADC vs Rohm
> entries a bit, and complained about the missing binding entry: Shall I
> fix this rapidly and send in another version?
> 
The ordering of TI and Rohm has been addressed in my series v4 [1].
I will arrange ti,adc121xx in order in v5.

[1]. https://lore.kernel.org/all/20250614091504.575685-4-sbellary@baylibre.com/

> Best,
> L
> 
> ...

