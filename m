Return-Path: <linux-iio+bounces-16646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988DA5880B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 21:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F9D16A70E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 20:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551B21A45D;
	Sun,  9 Mar 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY4tCMSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E21DA109;
	Sun,  9 Mar 2025 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741551097; cv=none; b=PtZ4Sw2e6JeUvpX8Gzq6zyjaNg4CQycwNTIfDTaSKT/QwPzHCJcb/Yb86kcw4mbfmCf3vlk2aUCzJwtxJ148nae2EHrnwkSqkxuacwWduxvwQHw7jucsLF/yQdKL5lC5fETr7WmUJUfjMOt1Gr4+NQKshh4dH6hO8ChJVyAgJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741551097; c=relaxed/simple;
	bh=Q/M8NAapKWyYjFf4cnrs1aG5fBikbTR5bGwIx1rcekU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTRn0EcaU4yZz0vWbFRleSFjatvs8uSfn3CxKU6PajatxELbmKUikAg9pLuGaVbFvISXB72712EOxrguKah3nhhNr+KveSS8sJM1cRsKIlBNKfQK5W2/53x1Dy04jqHi69+WytbUWO6ijpARIFIE5vZsNnyleUAXZIvxEYrINY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY4tCMSi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22334203781so82052045ad.0;
        Sun, 09 Mar 2025 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741551095; x=1742155895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNejAKjgnWESebI83OMmJQdcgreJZfPq0NGeb8QDIKU=;
        b=lY4tCMSiKmu9LCLGtFODlQSP9fnNHC3ALVszdbazdw+wy1Sm0yu7XAXCe7c3eSvF6P
         nzvKRznTehoPkDqFIMIaQRysMZKsnQyc6juNlXAzDZG0y0mDOiV+t87xjfOV2eVeqouQ
         tMfxX1Oz+IaEuw9m/OfGWnC34vv4PQ3/fA5egxvXVS2bp4OrEAEmfjGML6nPYktn40j0
         iDthToVV60mJRyUyyGj/wdcvHYuyMfaUXeqZrVGDP2FcA3/oLm3j23W87q70tatk4Tba
         A63L3tSdbLnBFDA72Kh+zO5MahzCTwLtVCABj4SbuEUqamsVL91qO1LIjyLO0J+bfG+v
         ceBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741551095; x=1742155895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNejAKjgnWESebI83OMmJQdcgreJZfPq0NGeb8QDIKU=;
        b=EHMF/53DkDvAIwHA0amQ3/bwAVfKmkwbCUAoeKCb8lG3K3G+khSB2JSGdKUYYiFZxc
         SwPfNCsbA7+icoMVFDaGrWIs33l28gkSF534rJ0iLaIoNaVugXcP7Arhy459qg6SlnUB
         7P2Wdr5Hql8BcrUKTqrhx5bP4FbLw+w5r+tKL7oG65KctKx9S7iaK2fx5Djxyxn0psZz
         V0zikN1a7JZeI/CcboSiba/i81Dd8OlRmvcnSWRkP+LuIDR/yc/zDwnkziMlEvmoiv6s
         D0+P4SNSaas1HaJG8J6OQpDphMj5sIoYED6Vu8WwcuaNinw17FQIQ0V7UqtrA4fCzNiJ
         Kaqg==
X-Forwarded-Encrypted: i=1; AJvYcCUgEz6v4dMwz23LZq9sXa+x9YCrbXYVVrjZuAM5mnqVYcqqtcH6fZxDCgYcTfnXgihQB1pII73xs+bE@vger.kernel.org, AJvYcCVTRk2z258zQMAwQxr1VSr5YAxFkV2CCIFB/6TysFRcu7c6R+/td1jswX4dgaCPgloq8/9Pngzjc5OC@vger.kernel.org, AJvYcCWdhNVOAAcxHUOgCLWaNMTcQ7cdy4WPVOg+5T5PJIaOmJVq0dWUZ0e7mHsilgMJq74O4z3N/KX22cVOdHQM@vger.kernel.org, AJvYcCXbtpz2JZ6G1X/0WO5RJCJDeGYKvMuCnziZGGMZ7R0QKs2KtvPNSSSH1ziQ1UMSO5+wO3H+U/parcfC@vger.kernel.org
X-Gm-Message-State: AOJu0YzLD1rHYyD12Ocg77StrhQu45Id5JKBXYklZGPDZUSVc2++aXtu
	03XineuIJBar6AXmJX5LF09/244y6xKMhHKRPPZmHDQPOVHFg5im
X-Gm-Gg: ASbGnctLwjbWpswuj5HZev+cGniPxF5rPu4m1M7w4FqlawaILl6nYN7ggkdBNmsmZ/t
	Y8vrQxnZTp+OV1ngIDpqzdeeJ4mVdnWmNiK56ico6qE/FCDLqOwOWzRFzbVAZmkzgYrVutXZpxY
	mUEF0uXFyU2+f9ReEPOkiOVtksnfQlwNaeR/6JZ6LA8LR3Plq3XiL+4VrK9ZN7GKE1gvAD0IF8t
	GVLkhBi8Z5Q39wd10jbBnWx2mrOQMEEEnmY5WYAGWJO7qoCNk7BhBZkWvA1sC074B6KDVVIouCR
	3xvu7N0iNx/AL8hwi+TK3AO0fZ3nnvG2rosEBjQ/LGXn6gVwec78uqAJOki8M+VYEilc281s
X-Google-Smtp-Source: AGHT+IH3nC1e4uINKW8r5n+EJqUFHBohM2It53DiNQAen36ckMdbrXoW1M/rkNjgcaet1ChpeYZhrA==
X-Received: by 2002:a05:6a00:8cc2:b0:736:bced:f4cf with SMTP id d2e1a72fcca58-736bcedf541mr7491933b3a.0.1741551095151;
        Sun, 09 Mar 2025 13:11:35 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:2455:1853:7000:fc49:126f:e12d:f79c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736aead3439sm5038874b3a.64.2025.03.09.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 13:11:34 -0700 (PDT)
Date: Sun, 9 Mar 2025 21:11:24 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <f427772xllbmabozmr7xbaizetypscasbufyqc3teylwghpagl@5jo4c527avay>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
 <CAMknhBHeqhkGaSM0S_zahC1ZrKTfoYj87fFEwL362FhhjNOfpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknhBHeqhkGaSM0S_zahC1ZrKTfoYj87fFEwL362FhhjNOfpA@mail.gmail.com>

> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052.pdf
> 
> The links above don't work for me. Instead...
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050-ad4056.pdf
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052-ad4058.pdf
Thanks!

> > +  clocks:
> > +    description:
> > +      Reference clock
> > +    maxItems: 1
> 
> I don't see any pins in the datasheet about a "reference clock" input.
> Is this for the CNV pin? If this is for the internal clock, then we
> don't need a property for it.
Indeed, this will be removed.

> 
> > +
> > +  interrupts:
> > +    items:
> > +      - description: threshold events.
> > +      - description: device ready and data ready.
> > +
> 
> Since there are multiple interrupts, we should also have an
> interrupt-names property. Also, the interrupts should be named after
> the pin they are connected to, not the function. So the interrupt
> names should be "rdy", "gp0", and "gp1".
Agreed.

> 
> > +  cnv-gpios:
> > +    maxItems: 1
> 
> Not necessary, but I would not mind having a description that says
> that the CNV pin may also be connected to the CS line of the SPI
> controller if it is not connected to a GPIO.
Included.

> 
> > +
> > +  spi-max-frequency:
> > +    maximum: 62500000
> > +
> > +  vdd-supply: true
> 
> > +  vdd_1_8-supply: true
> 
> This one seems redundant and should be dropped.
> 
> But there is also a possible separate reference voltage supply, so we
> should have a ref-supply property.
> 
> > +  vio-supply: true
Yes, I overlooked the supplies, vio, vdd are mandatory, and vref is optional.
Also noted Jonathan's comment that the aim is to reflect what should 
be provided, not what Linux does with it.

> 
> These chips also have GPIO pins, so we can add the gpio-controller and
> #gpio-cells properties to the bindings even if we don't implement this
> in the driver.
Good to know, added as suggested.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> 
> The chip won't work without vcc-supply and vio-supply so they should
> be required. ref-supply is clearly optional though.
Aggreed.


