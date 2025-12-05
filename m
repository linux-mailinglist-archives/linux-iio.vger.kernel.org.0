Return-Path: <linux-iio+bounces-26790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 607FACA7B4D
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 751F3302B051
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E733711E;
	Fri,  5 Dec 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1LXGo3P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D50337105
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938926; cv=none; b=AWDKGvcihE1d1cARZHSoXeZhoaSkgD8p+vOLApooRZrYKFvVbOu0H47mGM/kjegStUAlRd7VF91OUXW+1W8uIqzdVgYAccwmnnIdcIsWNPYMWqwvF/OwXJ3eCeEJZft8uSg+k54gIOMLhlOhwWqA6NhddCH3A5jMPflvqOSRU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938926; c=relaxed/simple;
	bh=lSNiJQ1hWv2H33MlCLh9IZa2Uo/O6wrA1GmmBJ4ngcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIkoASamM3x+E2vG6PRZUflGTmiwcKTCKReGKViHazvZssvaUDPtrTsYwCrfN1K4HV9xLMP/CQ089zy8NQ94byGOr/histMlbe8w5zZTwFeqgbZpj9LIKCwNCViC95pqu8tXZsTzPQgdg87imzA5Hhw67S7BpzR1dYuEKNfGR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1LXGo3P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso3281058b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764938916; x=1765543716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8TfSQdqzSVt80P55nncCARa3JN8Npg0bjx7e6GoNp4=;
        b=X1LXGo3PzlBQ+5uc/v2/1MGQqJaQu+IbjGL/h+qtTVbab2MZXbsM8oVBQ3XOXWuecK
         0bxBaJmQPfiwKuoBvoVKyvXodZ7LbNEBNv+rBH0AOl5AthjvdpvpyClsxNcOVaYsDSa2
         4vQGRag1JzOZqTF6qgpWl3LEukdBTK4wyIfFVes7Yb2Cpfb3d7gk4Nz7dQAKNxRjks3/
         xKz4piiOdMyVGcAOaKuApEPSiPB1t1cy8nZFWqfY6UpAAfAQbZD785nr3bUj9oKUIuks
         MyV/U9YRfQu0GHSvwjLeIyKOsjCW6waKR4KmG4T6Dp3bON3y93Vbm4Eic7CNOhIxWW2P
         M/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938916; x=1765543716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8TfSQdqzSVt80P55nncCARa3JN8Npg0bjx7e6GoNp4=;
        b=Q6QZI6sYJ29eIS56YGzBHVsa9/+HamglaC8vnHRnobxZ4KHzAWRTAD6H1ZYTYvPFZA
         wOKMvJm+yEZtQRZflfs75WJ1jFViyHXrcWAvZNsPt2u9QM2AVs7I5NU2iL9yurckybKQ
         gzcP9ODmhNvULt8OO79kvZ8hmrHdhDvLuOLExwdvktKSrPbKXmgR2AvYAJxPMnpyDYue
         Di09F+sn4HPRujdSm8Y4INp4TJxarrEXQqmi1Px8FHDSSzSww7kf1LwcKHS5ppGxfaxs
         Fx1omp+qvYZqb3meytd6b9OuGItz7dAjrQaQC7ufdcxaIp8/WXaQsBuefD/bmB12U1us
         vomA==
X-Forwarded-Encrypted: i=1; AJvYcCXwbrMvZ7BAp/HZbUIw1BDll8FwSlRY0m6w7i2z4uIEsvfIcE9Awn6i9QaZaKKCeNPzeHbosMEHMu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TC5BRJ+o0I8e+t/vQ7ZKQhmjdqJId7L0G8Rsgrtb2o2ITg39
	O5CYTyPTC46xaK2d7uVno3CUS0KEME6Q9C07roB86wWL4Cw4Qn8+NiNc
X-Gm-Gg: ASbGncvWb0jNcSBrEEvq0mkGMyaWHR1+qiBCimID5P9b5ekoCavq9Z7IaasNIAYjdex
	ebDhOjy6AZZC70Rg6RLMeIQx5jle7JANNX13sIGsGcUzsXe6mwCfKFrgfkC0tsj607T4JeZ5k44
	XWw7D0dWtoo4K9Bds9kXY3HeawYXYIekS+pZJKEAEEganLO2uUybGYOUexG4+MrOLh4veHMcbby
	fksRW0r22PweUBigReP9vaQ85r8nOVIFNzL0P4tNiM2PePt3jlJOE217/ZrCBsSrg10/7S+4dn3
	fB64u+JcYl4WLEiRChw1PGLV6gyFnfV7U8LOmBrudKGys7hnOnFFuntyckbc6OcQPgt4rOnQXKQ
	s0rYi/9SN5XCHAes/YpcZoJ8b6OX+TwdF2qWb3nAPljlQHgWRHejSTNOPg55PcAtW+vtmlcPLfu
	jLe16dXFRHAsKHO1iJ3HS8VkbZNMQ5V1U=
X-Google-Smtp-Source: AGHT+IEjzb7U9ofM4A37xXKz1ctej3Hg6VdyG9/RNNT0ZH2QqjidYtcKGEfTZb6PcdctwKhrBgNzQg==
X-Received: by 2002:a05:701a:c949:b0:11d:f682:e475 with SMTP id a92af1059eb24-11df682e6f1mr2793043c88.40.1764938915794;
        Fri, 05 Dec 2025 04:48:35 -0800 (PST)
Received: from localhost ([2804:30c:2712:fd00:9579:9ff6:e506:6147])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11df7703bd7sm20366748c88.10.2025.12.05.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 04:48:34 -0800 (PST)
Date: Fri, 5 Dec 2025 09:50:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <aTLVAAQH-I8Rc372@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
 <95dfb96e-f7b8-45df-a704-2984bd0a2946@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95dfb96e-f7b8-45df-a704-2984bd0a2946@vaisala.com>

On 12/05, Tomas Melin wrote:
> Hi,
> 
> On 02/12/2025 22:55, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
> > sampling, precision ADC.
> > 
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v2 -> v3:
> > - fixed typo in powerdown-gpios description.
> > - picked up Conor's review tag. 
> > 
> >  .../bindings/iio/adc/adi,ad4134.yaml          | 198 ++++++++++++++++++
...
> > +description: |
> > +  The AD4134 is a quad channel, low noise, simultaneous sampling, precision
> > +  analog-to-digital converter (ADC).
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4134.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +    maxItems: 1
> > +
> > +  adi,asrc-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
> > +      Describes whether the MODE pin is set to a high level (for master mode
> > +      operation) or to a low level (for slave mode operation).
> > +    enum: [ high, low ]
> > +    default: low
> Since minimim I/O mode is only one currently supported, this should
> always be low, right? Is the property needed at this point?

Correct, it is expected that adi,asrc-mode will always be low for minimum I/O mode.
The property is not _needed_ but, according to dt-binding guidelines [1], it is
desired.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.18#n17

> 
> > +
> > +  adi,dclkio:
> > +    description:
> > +      DCLK pin I/O direction control for when the device operates in Pin Control
> > +      Slave Mode or in SPI Control Mode. Describes if DEC0/DCLKIO pin is at a
> > +      high level (which configures DCLK as an output) or to set to a low level
> > +      (configuring DCLK for input).
> > +    enum: [ out, in ]
> > +    default: in
> > +
> > +  adi,dclkmode:
> > +    description:
> > +      DCLK mode control for when the device operates in Pin Control Slave Mode
> > +      or in SPI Control Mode. Describes whether the DEC1/DCLKMODE pin is set to
> > +      a high level (configuring the DCLK to operate in free running mode) or
> > +      to a low level (to configure DCLK to operate in gated mode).
> > +    enum: [ free-running, gated ]
> > +    default: gated
> In minimum I/O mode datasheet mentions this should always be gated.
> Perhaps this and adi,dclkio can be left out and added when driver gains
> other support than I/O mode?

Yes, that's also correct. A few properties are actually not needed for minimum
I/O mode (i.e. can have their values inferred from the minimum I/O mode requirements).
Sure, from developer's perspective it's easier to document only what the driver
uses. adi,dclkio, adi,dclkmode, adi,asrc-mode, powerdown-gpios, regulators, could
all be left to a latter time. Fine by me if dt maintainers agree with that.

With best regards,
Marcelo

