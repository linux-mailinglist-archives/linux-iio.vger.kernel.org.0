Return-Path: <linux-iio+bounces-14333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68102A0FD9F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F2A18880B0
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 00:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DFD1DFF7;
	Tue, 14 Jan 2025 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjjsUgRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA432F9D9;
	Tue, 14 Jan 2025 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736815271; cv=none; b=Ah/mO7bhwCLfAEyRT30vbqu6f33zEYrBwco6dddOZbH+3140J1MzbyLtGpjRL1S4gKPBt2Fh5d5ONSs2ALzWrCX5JHTOg1SCYlSTWteNNSks6dyO+EKhpIRFsZhVD2yQCTuh993m5jDUMVY41YY50kyL2GfgKj0P1UKJcYqNUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736815271; c=relaxed/simple;
	bh=sl4tJTfqf7yM/lz8xuDqdnj4fClRaGCP1vS4v6nWkdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctU5pD8H7pFb4c8gWURsEOYykPXVPgnaJTRibTa+k0NXurA5wWyIQBdeM2DWSuhIuoqT3y23ASvmONF6fz4+2OZshPhNOTFSIXZednDHkz1Cqjc88ml/i0sw7s6+NefmJD+qbRWZ73MY3OP6hm++rJFgsAb3Q/TDOXEInNPfUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjjsUgRH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b854e69bdbso50210185a.3;
        Mon, 13 Jan 2025 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736815269; x=1737420069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyTck6NZOEJxlNfneFH0AEe99MjBa5o5Mg5o9l0PLwI=;
        b=HjjsUgRHBQv1j4T2SJXb+1r9Fgj0IP1cYhQwScDaCDQN507iHYpBn87VkLrZlZcRaH
         Opr2jBJYNiJhtrhEgdowj9Hx31UDC6VE8Plskgj8CCBU9QwRZhO8SncPHO63/kZOT6/8
         OPKY8HFZ6MOhHIXt/TxmZ1Iykq3Iuw5i6MK5Nw3ZS1EQvR7v5HkZiTr/mAccvTXOEhbU
         3xm4x8eL0x/SqRlj9dOlBKoK01wFUTOS8iPq/X+1qPtczdbauYdwG5OQSkbWztP5knpC
         3BKs8vC+vscy7jfVLLN/O8AGCGkBWXYvykAn32r5ZyKkpXmOfwF5Rsh7jmqnrm2YF2+H
         u74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736815269; x=1737420069;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyTck6NZOEJxlNfneFH0AEe99MjBa5o5Mg5o9l0PLwI=;
        b=uzfRVgeRILA3+dCBLkhgcHUG8xxNT2VnZhwbrJf6FjVMcKoLzGHC/A7Vk2xHjrVAwB
         W+1XDnIG8pJYZPlPQ2x0E8o7450vocv62BOF3SP/6ddw/limIGxFHSAu3SicCYAehsgM
         Zv2+wwoUROmgSe1/MB/2ydiBR7V5MK2HBg0shndnUg+hqdRcxcVOtn910lY3XUiXsWJj
         iUFQ27LmeIBDtg6YziT4IDGeGj1bDJy1ZNNDh4TUlUrPUrXQzHqLhafrCF+D6WUt/RVO
         FHAMDFwP+1GANHkLAwTN2VB5c10t7qr4dw4PaoC/v3ikkVAWiLwYFGBbYAKx1eGH4JI/
         id6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1EixPtBVgi3M15fM7E0qLx9oMR06Y/S3DrK9LL4+7KqrpCL8UbBkieZM5D0fv6rmH3wrWp4irFUYEwQ4Q@vger.kernel.org, AJvYcCV30MbHf8sH5xSQZ3oehaobATziAILikGKpHeY3X9CiP4XObcYvCDrPRFnXPqpUrkZmt9zNGXvDeEml@vger.kernel.org, AJvYcCVYvnICZTtgXNfl05wVa1u6VfBjnpSF0HWgoCja2qFcuN0u/yFnsu0+pRl0W8c8d9lPtSu94Z9gNzAx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7hr1wWWQIvrvrkE90OKQ7Y3FbqPpKR6h4IxfghbLAf02zpOK
	iLC1krEvzgpafGPFasL5fd2UhDantS9Etbja9ql0qar9WmUVOzub
X-Gm-Gg: ASbGncudeNbrfskJ4W2PDC/NzRTW/zLaOdaKK0fr+HgTEkKNiegQNQDlFY19XaD6Ws/
	rGvPwM+1koWAQJWjEaDlK685kjWeQNiu8PaCifJL4KvYmiLN93QdznrY2kegitsKACkeW5pXDOi
	oBdgmRtHkwQpiGl1WBSkKY4U+Knouf9ORqMViV0HaxbFlAwjswZmqR6OoQjjOiqB44xOPLkJF+k
	zmZVhq1w7DEYVtFutay+Os7XllGKT+C7AxfBydhrWHB2NP+Qj0wZp509nluT0YT1M/fPQvC2G8a
	3Q==
X-Google-Smtp-Source: AGHT+IF+fg0OggwIQggN3MmKsDnmqsUuUGtmy4Dt9EsuE7lpUmMu8je5pUNMs/2VQaa5d5ZVtrufFw==
X-Received: by 2002:a05:620a:46a0:b0:7b6:e196:2219 with SMTP id af79cd13be357-7bcd97264ffmr1418933585a.2.1736815268537;
        Mon, 13 Jan 2025 16:41:08 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87324982sm47141191cf.6.2025.01.13.16.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:41:08 -0800 (PST)
Date: Mon, 13 Jan 2025 21:41:04 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <Z4WyoPoSmOosyioE@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112120530.1950a265@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
 <Z4GWSgruwnkDfYSg@debian-BULLSEYE-live-builder-AMD64>
 <20250112120530.1950a265@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112120530.1950a265@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 18:51:06 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 01/07, Jonathan Santos wrote:
> > > Add adi,sync-in-spi property to enable synchronization over SPI.
> > > This should be used in the case when the GPIO cannot provide a
> > > pulse synchronous with the base MCLK signal.
> > > 
> > > User can choose between SPI, GPIO synchronization or neither of them,
> > > but only if a external pulse can be provided, for example, by another
> > > device in a multidevice setup.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > index 3ce59d4d065f..55cec27bfe60 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > @@ -47,6 +47,15 @@ properties:
> > >        in any way, for example if the filter decimation rate changes.
> > >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> > >  
> > > +  adi,sync-in-spi:
> > > +    description:
> > > +      Enables synchronization of multiple devices over SPI. This property is
> > > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > > +      should be routed to the SYNC_IN pins of the other devices.  
> > So, if I'm getting it right,
> 
> Datasheet on this is indeed complex!
> 
> >/SYNC_IN may be driven by a GPIO (ADAQ7768-1 datasheet Figure 131),
> 
> For that we expose a gpio binding already. If that's present we know what is going on.
> 
> >/SYNC_IN may be driven by own device /SYNC_OUT (ADAQ7768-1 datasheet Figure 133),
> 
> This is the default - no information provided so it isn't wired externally.
> We don't normally bother to describe required chip to chip connections.
> I couldn't entirely figure out if this is 'required' if we aren't driving explicitly
> from GPIO or another chip but i think it is(?).
>

It is. If the device is not being driven by a GPIO or an external
device, the user should connect the /SYNC_OUT to /SYNC_IN. We could
assume that this is the case if the GPIO is not present in the
devicetree, maybe put that into the description. The sync-out-sync-in
property as a boolean can be quite redundant, since we also need to
remove the GPIO.

> >/SYNC_IN may be driven by other AD7768-1 > /SYNC_OUT pin (also Figure 133).
> This is only case we are about for sync in I think.
> 
> As long as there isn't a valid 'not connected' It think we are fine with a boolean.
> 

If opt for a single node instace, thats ok; otherwise, David's
trigger-sources suggestion seems to be the best approach. 

> > That is too much to describe with a boolean.
> > 
> > If David's suggestion of using a trigger-source doesn't fit, this property
> > should at least become an enum or string.
> > 
> > > +    type: boolean
> > > +
> > >    reset-gpios:
> > >      maxItems: 1
> > >  
> > > @@ -65,7 +74,6 @@ required:
> > >    - vref-supply
> > >    - spi-cpol
> > >    - spi-cpha
> > > -  - adi,sync-in-gpios
> > >  
> > >  patternProperties:
> > >    "^channel@([0-9]|1[0-5])$":
> > > @@ -89,6 +97,20 @@ patternProperties:
> > >  allOf:
> > >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >  
> > > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > > +  - if:
> > > +      required:
> > > +        - adi,sync-in-gpios
> > > +    then:
> > > +      properties:
> > > +        adi,sync-in-spi: false
> > > +  - if:
> > > +      required:
> > > +        - adi,sync-in-spi
> > > +    then:
> > > +      properties:
> > > +        adi,sync-in-gpios: false
> > > +
> > >  unevaluatedProperties: false
> > >  
> > >  examples:
> > > -- 
> > > 2.34.1
> > >   
> 

