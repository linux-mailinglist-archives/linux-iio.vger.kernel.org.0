Return-Path: <linux-iio+bounces-24329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CFB8D1AD
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 23:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C461B24F2E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6128467B;
	Sat, 20 Sep 2025 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGCB6x6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A42236E8
	for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758404652; cv=none; b=gzBg0uSIdD8gAAE/iugex0jeH/sWwJ3GK5leQMeU1H+JGHUd8swQdy9l5s8NtqHAsjaHmbG9uRjXQhCGV3977Io2CKRnDmKfnmlywVLH4vxFmM7EnaavGIMM9YOhnl84jju5qIYr1QY+TSkIN01Xid1lIwBofITTs5BHVUvXx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758404652; c=relaxed/simple;
	bh=DVCcp2q5VKcd7KC9g3EJSBxxRQgEDpwWkfmRLnIh1Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCFRKmHSGQkBcsogHv430SsjTgLHjLxQh5/aVFgUfKiOPR7Roq+jd+k0ywAG/IQxZ1a16kTjd1gQaIWQyBhc0s/ee/Ga+rj6eUhw5qXm26aKyVY4m2LdRKoxOKz+ftZV96hGlSG5G4jiyyXCguVTS9/E4TWKqJYHx58ljcyWD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGCB6x6m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26a0a694ea8so16714305ad.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758404650; x=1759009450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XaK3Ga5I4OskdvUpK/KRvj93+5lScsBFICoRwq2vUw=;
        b=JGCB6x6mP5ozvGnpZuiO6YO8WAsnhGdkS9KRxIH7POkfsJWk5CaOfkPNjZBn3O0XEx
         pKPPFuqlsQgeKTF1hdV7pMDq7KQCjytDu4LvIz/6/ULoBqtmvaPDJO4RonWCR83c0Q+7
         vIhdj8tAT8DEmV3ewr4TV16zU0s8glyt9e3NxNkSR8kA+tk+LCY280X+XpuSvT6gmvbt
         qK0SO84rHCxd0DB7KyykFpXgdZil341JV7mnp9GtFu1QtGgdDkV4Uh03bqJprT66H7rn
         1Jhp+EZPomENlrqzed0ABy6MSgX/szhR4Ajw7uKKMZsxWG6K2+1TE/cneO98Xg6w+TBu
         Pwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758404650; x=1759009450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XaK3Ga5I4OskdvUpK/KRvj93+5lScsBFICoRwq2vUw=;
        b=Y03nWi8q/yXYPMTi+j9raziIzoh03ztH7vhlUrjVoxh5L7Lh5SgYqfioLSNMBcDLo/
         gkKM4KKiUYG/cERA1346Xu8zny5X6Ds3DfkakQWT1L6A/nQrhz/gf6w1ntipB73B858f
         xX5IoeOYIZN9pryXak712Y7/BCkxec3CaGUyxPvnU+jsvdLCF7J5Tq6VeEEQUMoJyFCN
         d3pDmVx8PFFPdaGIFUo7nzeEZEEgSItNtWthR74rfJP+9TSS+DL+qMFGu1ps2B/AA34u
         s6PsfSSx8/w+vH1EpZU4g+0qsujMcOF/nDFZidkQQr9OSfyEUEj8hB7sBOlbYyjRbSZ5
         +gJg==
X-Forwarded-Encrypted: i=1; AJvYcCWVVgGoPPuZcDQVFG6BzKuXhfD/snVJ18EwR/1zyCfmupqVTaykdMg8BIbxc3aK9LN5330esY72Dbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPhiCUOR+H0nzNlwBga+g2Ibq5LU3xLVx3FgvgFLNNIrmem5Ro
	jmG1u7HP+7wY8kD1vzS+JlySIx4LBdaPuVvigjGRoKF2A5vBuNmpDb3H
X-Gm-Gg: ASbGncsfFvOLMScXO4ZmSI+FxjSh1DrNZw2hO5b7+p+7VNqVg/EvQ0/9ozzcUGuHjuN
	/sVruCdKVK2My9bp+Isp7d+G2UCYoaP3TGpdHnanPZk20FEUix7ANQ3/eSdwa4miC/LT7pfhROG
	kb4G/ctl2+LZv0KHKOCrfYScFGcWw2LcqIKmkIYhi9dmYHomErqldHPXCTO9Ag3gV8LCOikLVEd
	EP1KnjBYYGV5PGNs8cpQAez7hcU+wEkQO8HWU7POTenVZPMOwpHq4FyAlhoePrlR80uXiC082aA
	iYQ9zu0+uRgNnZlUQ87zLxPJaM1PDO5ZyUZXjnm67EP5AuCaDbsNbCm2b+mhHhZsVCKLhZP6rXx
	H8gZQEDb0qdIYepZxUa0FCrLLHm9sBzk=
X-Google-Smtp-Source: AGHT+IGstBVeN4BQ2EHAw6pn8u8U0MiwUr1OFBQKcuOmxzx9i3nxQXrFoOaA2+s/lnUkyZn6bVvZmQ==
X-Received: by 2002:a17:903:2284:b0:269:9adf:839 with SMTP id d9443c01a7336-269ba427cb8mr100761545ad.19.1758404649948;
        Sat, 20 Sep 2025 14:44:09 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-330606509e9sm9225974a91.9.2025.09.20.14.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 14:44:08 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:44:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
Message-ID: <aM8gVOVEujP6Yzxx@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
 <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
 <20250916-alto-vaseline-f8dafbab03e9@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-alto-vaseline-f8dafbab03e9@spud>

...
> 
> > > +  interrupts:
> > > +    minItems: 1
> > > +    items:
> > > +      - description: |
> > > +          Asserts high when ADC readings exceed the upper threshold and low
> > > +          when below the lower threshold. Must be connected to the COUT pin.
> > > +      - description: |
> > > +          Alert output that asserts low during a number of different error
> > > +          conditions. The interrupt source must be attached to FAULT pin.
> 
> These descriptions read wrong to me. They __are__ the COUT and FAULT
> pins, given what David responded to above, not something that can be
> connected to these pins (if they were, they would be represented as
> -gpios rather than interrupts most likely). Unless you mean that these
> pins can have some other use and are only available on the COUT/FAULT
> pins when some register value is set - but even in that case saying
> "must be" doesn't fit since the interrupt property could be used to
> configure the device accordingly.

COUT and FAULT are just two pins on the ADC chip that can be used to generate
interrupts. Would a description like the one below sound better?

  interrupts:
    minItems: 1
    items:
      - description: |
          cout: Comparator output signal that asserts high when ADC readings
          exceed the upper threshold and low when readings fall below the lower
          threshold.
      - description: |
          fault: When fault reporting is enabled, the FAULT pin is asserted low
          whenever one of the monitored fault conditions occurs.

Best regards,
Marcelo

