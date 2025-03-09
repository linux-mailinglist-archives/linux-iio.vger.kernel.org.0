Return-Path: <linux-iio+bounces-16648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E8A58842
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 21:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397E5188C821
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AFE21CA14;
	Sun,  9 Mar 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpS6HHWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D21EF386;
	Sun,  9 Mar 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553376; cv=none; b=cym+d+9a9sGhQM5LCZwIcGqgmtf2fIv4d6TCcIjQj+wKpIvyyHE5pKGwfnKNSaaj9Gp7ilgtfZksaOhziwepzGqAuTmeiRyd+lpq+BkjMKmXkp0W71aPdkhvdoOsYzdzdtvO38x5efgGg8uG177fy8S4/CRObeA7KcYgeNEXBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553376; c=relaxed/simple;
	bh=sVMlgFXYI7g+vJR6TKddPiu5AZClUdsWRZqI8kc3mRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BssBGevz/tr4nDMnKqOZDzGJwP3WLBK687TDpGsEQDgiznNp8UITTjL+KvFEjR4ok6/TBRNukYgEWtgc6QxctOLgl6mKs6xTgDQ6OPuZvivxwzdIRsqINhjLB6xmm6tkEvgyDQcEPXip9q4b+sPWS7OA1y4eYcRwW6LwSICOfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpS6HHWH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223594b3c6dso61403995ad.2;
        Sun, 09 Mar 2025 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741553375; x=1742158175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ymok4K4qVgWMasIZ+aZcHfy9Zvm1PfjXlbvHfdpv2Y=;
        b=KpS6HHWHc4LkJvJAeJ7NaEPtVxLIhHcsnyX6PuOZUzmvMDAKTm+hYqM+U+5PI1fXih
         HkocWNL266FnB85+Rv8WZCSJYi0ElU+Zm2zXAX1LBUA6v9DU1M/zeVjMCop0SAWAiep3
         Xkv+uWBr2ZeXfvPgAtmzsSAuvRC4WBJswRn2KmWUd+z33blE1+EHps6WxtFvr9UCDCji
         fF14Muc+iwqmjUlD4X/VhSlyUItoEwvRk5/rePgwTbC8ofKOqPW3X+ReRCKG+s6DvvRt
         HjPT0wZjZLbUOzljzmG1w0REA2tHYLO5Mr+v7pTun++nQt+7gbAe9upMEWpkUYhvaYKM
         47+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741553375; x=1742158175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ymok4K4qVgWMasIZ+aZcHfy9Zvm1PfjXlbvHfdpv2Y=;
        b=IMbi/Dl1Eq5sH3L9kE6LFlAzJEX8T9t83+tRuAsUVKXLnCHZIZ04GcFXyoig+yOhtn
         fujGVJnO8LsKnUY48gvhL1BYOyq8QunS7U8QTN/bwhZRtNTGVOL/nKvbEZXfFc9E+2Jt
         L7O/x2hC3REVNL4jeTTGE/yKO9vk50ybb2+XbIZG854eimqnw1Y7jSgPUsVnqJuPduNP
         jdIT/6mWFAkIpD2dS0jzfw1tl8xx2Sw+f2CAczgii4DjUadn2wGj8qTm3npz2daCcRH7
         zkgebA7Zs8wI9tjLwk5J0Suz7vg3FNl8zlz2H6pH36cJGiDgiU6p11s2izWy5xo88xIs
         7yJA==
X-Forwarded-Encrypted: i=1; AJvYcCUAnhQ9t0qICrMQr8ldQlBlZ054ZEJ5jnYHBqOpVEXfsaBTqlmEO9v0Spb11V5Dm8aSSFQaPaor64To@vger.kernel.org, AJvYcCUcpOwVhUm/VOgdZQ/BtwBphjkW4cHM/Z5EEP5scnIRF2xBgLQeTNk72bMT+6zKeDbXYszLhPLDrMF3wBl8@vger.kernel.org, AJvYcCVCsx59vYP83gXUMxyAxtE8nTdWpeuvPg7otpQrQQ6PLQUzP9rL/Ybna3TrcAsKsAQZJs3uI1Il4b6f@vger.kernel.org, AJvYcCWBQ9R/0rxeOZUN1zmC45ppzSbYOqvyJV2fZHQ8TCpEcRueg9GJORr7sIm0ujaicL+dS6205BJF1YNB@vger.kernel.org
X-Gm-Message-State: AOJu0YwPACDndp92h49BUdfySb1Lmsh6sqrU3LAgZKGV0Z9kJEB5dIrF
	A+FCGx9dMdBKrwXwtKneHj1cJLRoArqvxO2bGgA9eB5VzRGuJy0R
X-Gm-Gg: ASbGncuo+8PoFrhNWe/yOuQSHE881RdCaeaCPMFtgDJZgJScZVneultzvs+YhAIXyai
	Fm8jzKNZdvwV8hvAOMsVWQIW1qgZL3FsZDXAH0UuM3qCM294q0qXoxE4VCkuF0oJZCIW3OjtXsv
	B+H8r/f1bsaUs7pIUUY6wpPVT3xVRTG7OojfO9xEdi5VQ5fkoamL6dpXe7+hI40U6rKFZp8OnqP
	cfUi0pOZ0ZRa8uUCwhECpMDeYS0x+fuN9xpjNy5bPyCyRRJ1aisF5oP6FqzMhZqmpt0gd5v9FIt
	TZuM/F+PmlaiuxkDpam1xRVYHcnvzrW8e+fnADyd/Nw914gokQuULC/t6ZNYSRBbWhzyDq5b
X-Google-Smtp-Source: AGHT+IGgIPes28XROfmEhOPj/ChhxDfpGBkxv23MfingUFJ3I+yMwDE65ANstHXsl9HArbcKzSpX3Q==
X-Received: by 2002:a17:90b:28c5:b0:2ee:e113:815d with SMTP id 98e67ed59e1d1-2ff7ce6f0demr18243256a91.8.1741553374683;
        Sun, 09 Mar 2025 13:49:34 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:2455:1853:7000:fc49:126f:e12d:f79c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e789387sm8397251a91.25.2025.03.09.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 13:49:34 -0700 (PDT)
Date: Sun, 9 Mar 2025 21:49:24 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
 <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>

> > +.. list-table:: Driver attributes
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Description
> > +   * - ``in_voltage0_raw``
> > +     - Raw ADC voltage value
> > +   * - ``in_voltage0_oversampling_ratio``
> > +     - Enable the device's burst averaging mode to over sample using
> > +       the internal sample rate.
> > +   * - ``in_voltage0_oversampling_ratio_available``
> > +     - List of available oversampling values. Value 0 disable the burst
> > +       averaging mode.
> > +   * - ``sample_rate``
> > +     - Device internal sample rate used in the burst averaging mode.
> > +   * - ``sample_rate_available``
> > +     - List of available sample rates.
> 
> Why not using the standard sampling_frequency[_available] attributes?
Because sampling_frequency is the sampling frequency for the pwm trigger
during buffer readings.
sample_rate is the internal device clock used during monitor and burst
averaging modes.

> > +
> > +Threshold events
> > +================
> > +
> > +The ADC supports a monitoring mode to raise threshold events.
> > +The driver supports a single interrupt for both rising and falling
> > +readings.
> > +
> > +During monitor mode, the device is busy since other transactions
> > +require to put the device in configuration mode first.
> 
> This isn't so clear to me. Is this saying that events do not work
> while doing a buffered read? Do you need to do need to read the
> in_voltage0_raw input to trigger an event?
> 
No, the device monitor mode and trigger mode autonomously samples using the
internal clock set with the sample rate property.
I rephrased that to:

 The feature is enabled/disabled by setting ``thresh_either_en``.
 During monitor mode, the device continuously operate in autonomous mode until
 put back in configuration mode, due to this, the device returns busy until the
 feature is disabled.

The reasoning is that during configuration mode no ADC
conversion is done, including if the previous mode was autonomous.
If instead of return busy the driver hided this and resumed monitor mode
after the access, a hidden (to the user) monitoring down-time would and
thresholds crossings could be lost, undermining the feature.

> > +SPI offload support
> > +===================
> > +
> > +To be able to achieve the maximum sample rate, the driver can be used with the
> > +`AXI SPI Engine`_ to provide SPI offload support.
> > +
> > +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
> 
> This diagram show a PWM connected to the CNV pin on the ADC, but I
> didn't see a pwms property in the DT bindings to describe this.
> 
It is not clear to me where the pwm property should be in the DT
bindings, since the PWM node now belongs to the offload-capable SPI controller.

> I didn't have time to read the full datasheet or look at the driver
> code yet, but can do that next week.
Ok, thank you for the review

Jorge

