Return-Path: <linux-iio+bounces-18082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A63A885B0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7840561A94
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9127A111;
	Mon, 14 Apr 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHuUm7tB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20523D289;
	Mon, 14 Apr 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639809; cv=none; b=m+Rdu16kAxa45Ww+GaEkyPI0X8oMhEgbyr8cd/lJCD2oLDN6eNYkPwwp97fS8L3pQ2U2QmIX80rFJmsMFXICtuaaxK6qmcY6UVHOnqXPdxvOXaK/LHv4tQBeRqIr3oUeDg2/TF7Ki5NkqVND2HdZc8pWqmlL6pTJjYW4XOcUmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639809; c=relaxed/simple;
	bh=vlliZdXZ++kEiIyM6dC/4E9eSNr05QSQUnNnkDinvRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATBJH9zslvKTV/ZK3tG3aHgRKrvGIG6KiRdh8+7494wRxTNjTJ8xjakx8J2CQ2QdT2pR7v6l2c7ZK5h1J5V8+ZMq3ZoQjAv2X0IkzMInpyDMVSN+vLeF9jvLMp3ASPYAYDugMjH6saOWrBrGUB8veKQTuICWdj795NjH4hZYhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHuUm7tB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2279915e06eso45253395ad.1;
        Mon, 14 Apr 2025 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744639806; x=1745244606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmOn+oFj0d7pHr8fRjRfQJH33DMT3557rnDIwg1ASzo=;
        b=LHuUm7tB2fDglyG1K7Ljs709wcIfHSV9ch4NUGW+/BOPVMJZaR5hlttDfPqO4ZHfmL
         lNxr3/Tg6FMEkswnfxL2J0+DiFBIAj6FpCsBxSRofmJVQ2QHe+Lr5KwH1QJ1nfuLw98E
         uIq8/4cpgpmiAPoaUEXhqDtlYsEX5O1TcAnOF9AY38A0c1l6+qqq4ExBLNPkPkhH70bJ
         9ctVq3rjiWWpeSJF0oABUYT5PxILRA75M5FRRQfP4/uhShO40HG0PvZejavYTRdaBHQ4
         x31xLSNK1uvISQld0Q2mnMNMohu7HVb94pWiKtRnAEq0/8aUHiXFwbBpVCNox7oR8R3H
         4UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744639806; x=1745244606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmOn+oFj0d7pHr8fRjRfQJH33DMT3557rnDIwg1ASzo=;
        b=sa/9sGZW3p++wcVIHRtfFFAU9Vywe6zYR27WPf9l3pNhUzzNOZoeWQDa8hBEyifsdG
         zSpq7/LESfHQx9tsiFxqcbBveUrZ7QCXls8OTLwBcJnwpDKxAajx3CYq78Lg0PT9uoPL
         7pgA6xYqb7jMQgVpCc1ZcW/2ZOPdQd0vbsnIvwTqQ1jT4ppEzwIYDyhkx4vJEymMvtT2
         xptCYQYn7fdA30qIrjMz3bDAZ6S/1c71BugHUk0Lf+WIDNPhCM8tDsbA2GRNfnfanCrQ
         /pd7VP+wvbFl+BPTrh4x9iH313OzUuWtgdSuCEiNi3lSaD2H+5nwO/iwrg7k/AxfImro
         RRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW82xb2qpUHzNEkZF1VqXQzewaJGNAKhr5ylFhOEgkN10/WPywdfeSyl7pa/fFbYwtkLfikFxNZAKg@vger.kernel.org, AJvYcCWGNcK3zfIF43iStgs2qAuCobkrFwraT7L/md8zWZSMgra1fz36qj7znTFFsKDxB3hwqJsuTW00LA7nBAHF@vger.kernel.org, AJvYcCWgycH0HpcEDmUEaw90g2lLtuPPiDxVW6suIDQ9tS/bLt608slIs+fbcc0isIJTp2W9WLRjot6Btenb@vger.kernel.org
X-Gm-Message-State: AOJu0YwnT+NBbPT8nxmo/p3J8TKI1v6x/7vCXucZWyNHDt6UPvkfEwNv
	nmUkrK7dfn/UDC6nBsxmRxS9UYf62UeTXHPzU7BhtZqGkXAouGL0
X-Gm-Gg: ASbGncuCK3AHSC2t6J5ZR3HKbGcajpnhPwUKdpjEI1PpUPBxmKwetw4XFr1HIYT8x7B
	vhL+Bkfswt9dNAdwuY9bx50cggf1TymmrKARF5vshatNp0sitKFAWUOpZ5egcfU0GR9+OfP5KsG
	yXzP9L7MF+FJNOb1WEOjcJdV4tvql/ddgMkHkWARa1hBxlZnOBXb/7i2u+AJFAP2/qbarNg5m/J
	cZdBC1hN1JPPe0XrKLQhOwqMQQAa/t7a5aFkNR6uBDvE3WQtxVvN/pEHkIY4VPbYb4YqQw9jqwK
	BOOLWuYNo/ZufmG8B+rlGzSC+YwZAEZuc8qfrWCm9KOLKWqu
X-Google-Smtp-Source: AGHT+IFpmOSTusA5gVrkDDqkyM7yH2msjLo0wNeGVBrKewB442d3eRoBO5F5zv2OQxq14VNIJLn64g==
X-Received: by 2002:a17:902:fc4b:b0:21f:85d0:828 with SMTP id d9443c01a7336-22bea4f183bmr214847625ad.41.1744639805632;
        Mon, 14 Apr 2025 07:10:05 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7ccca88sm99049045ad.256.2025.04.14.07.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:10:04 -0700 (PDT)
Date: Mon, 14 Apr 2025 11:11:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 5/7] iio: adc: ad4170: Add GPIO controller support
Message-ID: <Z_0XgTYnDXd2x0b9@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <247566f848cdf2a245a8b6da6a84c22e155beeb7.1744200264.git.marcelo.schmitt@analog.com>
 <6669da27c78714d76ff21f810cd57045e90d701a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6669da27c78714d76ff21f810cd57045e90d701a.camel@gmail.com>

...
> > +static int ad4170_gpio_get_direction(struct gpio_chip *gc, unsigned int
> > offset)
> > +{
> > +	struct iio_dev *indio_dev = gpiochip_get_data(gc);
> > +	struct ad4170_state *st = iio_priv(indio_dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> 
> This claim_direct() makes me wonder if there's any overlap between the GPIO func
> and normal readings? Like, imagine a consumer requests a gpio and no buffering
> is happening so all is good. However, there's nothing stopping us for enabling
> buffering afterwards, right? Wouldn't that be an issue? If there are shared
> pins, I can see this also being an issue even for single shot reading...
> Otherwise, I wonder why we have this iio_device_claim_direct() calls? Is it just
> for using the internal IIO lock?

We need read/write to AD4170 registers to configure/set/read GPIOs so the intent
of claiming direct mode here is to avoid that from happening while we are doing
something else (e.g. a buffered capture). I'm now considering to also lock on the
state mutex to prevent concurrent run with the single-shot read routine.

Thanks,
Marcelo

