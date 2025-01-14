Return-Path: <linux-iio+bounces-14332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC20A0FD4C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3037D7A1022
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 00:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22D08F5A;
	Tue, 14 Jan 2025 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdHfJLYa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F64A0F;
	Tue, 14 Jan 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813941; cv=none; b=VnozOOwFojaCQcjla4aBuw2HOtAyUWG5FhD+2DOqOpycY3rE/i67xvrjLk5Y/TTv0fBkB0YrhUX2xs/CnJVIn5JrAxRV8aG4uDthStW3/ySLx1F2UWU4MHPGjOVFcnLW/ROJEVqyR2YwcHYb5vnLS9J7IOXGQqQxNZzb0EUo19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813941; c=relaxed/simple;
	bh=5NtjgTeVG76VME5kPVrnOepFDRL2Km4QlR/YDSsTQsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn5btDEUAOjnuMNw4KW7y2PRjrkH4TBMMj1m0j3UUaM/V0Kk7+lKGVA/xIukTA7NfNoS01uBAxAwn35PnEsG5jfy+OGA1Kd++FLT/iaS6ObhRG3ELdi/UTxFOEfTfRReAwOxnqrGR2Vtd8+q/V5qR7zG8UYubM6xsntKEdxvaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdHfJLYa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ebcec3aaso39073385a.0;
        Mon, 13 Jan 2025 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736813939; x=1737418739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VVhqziPCjVPYmd6jcqm141EF5w5B3KXG8Iitf4lFYQ=;
        b=OdHfJLYab7VYcPvnJ7jzDzEnIRzUM3fsciR1rZXvzzZatsCLddx6gQd5OKKGHMb6BN
         NRA2mwFSECnEQJQWlwz1ieyuJ5TeyUIPygNmtZ9ObTtVe1B08zVwz/B8uoKABBP9Tqxw
         DpZXIQqf5drHn0KojRHyhNOQB4yIZ8X4NlPntvfKvGc2IKinssDs8V0P9/doigFxbDEk
         ax63Zj5ETO6ugy2VJWJln+Ya+LrtYPqrC39DdIokoc0GxXqywcd65lPQ79bk707AvBAp
         xDRjydta0TVMm3bJE58aObkaafcqR11gSe/0pDsL8kkYSIUku8Ole1S1M+1bRQ9ibCE3
         Ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813939; x=1737418739;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VVhqziPCjVPYmd6jcqm141EF5w5B3KXG8Iitf4lFYQ=;
        b=bOMQiXOlCadtsiBX2il70YGBBO3BzfB1Q6UpZt4wn6G1Hj5P69kyL7bCBZKD9c9n5A
         WYxSvnsk6jHSOkMUo6uN+g+FIpCIvGe5JlxLOdEEU0edZ1NJRu+VbVjBr5k+6StKYB/n
         iU1KJmozaVeMjPlRZZBHubC9LYRt3QRco4RsRf/wqG7gWQtUm7lcMLiv0Lri/QK+pLWY
         kByG8jfjbC5JhY0utSZkYl2RfPc/m7vzdMPe1q/Zb+xiLUncGF0gGNhEYk7vz/PpUBQZ
         /UOcXjx8VbxZq+1PF+BVTW3DJiyIKD1bbWDD/x01VXAy/8R1q5eCuo3o02+s0aX/L0Bo
         K+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUUCR2I02rAlikKPS+20kUl1MSd8rNieHEqgvRnM3rUi9q1hbge5PI9vlYCupCLxtaweC3Zg3NRkWFK@vger.kernel.org, AJvYcCWq+/oEZQfAETTO/fCxlU/rujVvmZAxyVNv0cm1UHEFa158fbBCMXeZh7fRJpvEvq5J3MzrJoyi3irSE+Wq@vger.kernel.org, AJvYcCWritpIIaEywtbQAr82Bx6W4bWMuGswF7NhQqQdPpjljfl8KFl8IFsgTqIHHkN/Xcx6pSKHeh9N1yZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwO6NlgA54cTT9fAogvRwETOsoHjrhaOmguNLht/+E2xXescz3C
	crloKdUS1MBOIXxBG6dSE4zu7e1HhG3MGx8Xqa2UztfEfw46U0jV
X-Gm-Gg: ASbGncsRRlHmItxQAicv9Peg9xApKhHE836Bd8QcRI54VhqAZNzj2LPjKppGz0se3zX
	rYDEMmd8FMOXCx/fI3yRkoy+PHTPLm+upP41M04WWhbzTamxOqFrnz8iqLeYGY2D3iDWv8/qOWD
	DVkhVNRJZEnp+XKHBZeAueN3MhqtZuHt3CpOBQY3hsRuxvl5V9/8AF7+Fh5+CsZ020NCatW7LBM
	s63c2RJlQRC+2rChwYu/jdovbfYFs39+H0AayqwY3AbIkLy/GwqfwA0JkRk4IpcLTZ8QNjdvzHd
	lw==
X-Google-Smtp-Source: AGHT+IHC75y1LWLfSFPfnaIMCwmT5iCmksgqyuBDXFnVW5pUaMj3YOr8kzJsoS87g/hCAIfpnqqQYw==
X-Received: by 2002:a05:6214:29e8:b0:6d8:8cb0:b403 with SMTP id 6a1803df08f44-6df9b2d8623mr125925396d6.11.1736813938761;
        Mon, 13 Jan 2025 16:18:58 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87321cfcsm46748611cf.14.2025.01.13.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:18:58 -0800 (PST)
Date: Mon, 13 Jan 2025 21:18:53 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <Z4WtbRG3gWQCwTmE@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112120530.1950a265@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
 <dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
 <Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
 <20250112121229.5bc7545c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112121229.5bc7545c@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Sat, 11 Jan 2025 19:34:14 -0300
> Jonathan Santos <jonath4nns@gmail.com> wrote:
> 
> > On 01/07, David Lechner wrote:
> > > On 1/7/25 9:24 AM, Jonathan Santos wrote:  
> > > > Add adi,sync-in-spi property to enable synchronization over SPI.
> > > > This should be used in the case when the GPIO cannot provide a
> > > > pulse synchronous with the base MCLK signal.
> > > > 
> > > > User can choose between SPI, GPIO synchronization or neither of them,
> > > > but only if a external pulse can be provided, for example, by another
> > > > device in a multidevice setup.
> > > >   
> > > 
> > > While we are fixing up these bindings, we could add some more trivial things,
> > > like power supplies.
> > > 
> > > Also, the interrupt property could use a description since the chip has multiple
> > > output pins. I assume it means the /DRDY pin?
> > >   
> > 
> > Right! Yes, the interrupt pin refers to the /DRDY.
> > 
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > index 3ce59d4d065f..55cec27bfe60 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > @@ -47,6 +47,15 @@ properties:
> > > >        in any way, for example if the filter decimation rate changes.
> > > >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> > > >  
> > > > +  adi,sync-in-spi:  
> > > 
> > > If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
> > > should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
> > > we should just be describing how things are wired up, not how it is being used.
> > > 
> > > But if we also need to consider the case where SYNC_OUT of one chip is connected
> > > to SYNC_IN of another chip, we might want to consider using trigger-source
> > > bindings instead (recently standardized in dtschema).
> > >   
> > 
> > Do you mean the trigger-sources used for LEDs? I can try to see if it works, but would it
> > handle the non-GPIO case? While testing a multidevice setup, I found it simpler to 
> > have a single device to manage everything. It lets us toggle the GPIO or /SYNC_OUT
> > without referencing another device and makes simultaneous buffered reads easier.
> 
> Daisy-chain mode (figure 131)?  In that case we normally end up with a single presented device
> with a 'lot' of channels. (See the electric car style battery charging chips, those can
> be chained in very large numbers!)
>

Actually, it is more like Figure 133 , but the premise is similar. We
have here a Quad setup.

> Probably similar for figure 133 (which is a dual SPI setup) as the SPI clock must
> be shared so we still see it over a single interface.
> 

We could view them as a single device with multiple channels, and since
the goal is to read them simultaneously with buffered reads, some parameters
such as sampling frequency should be equal to all devices.

However, there are some implications: If we do the above, we have
limitations in the customization of the "channels", they would have
the same filter, frequency modulator and scale (we plan to add support
for ADAQ776x-1 series, which include PGA and AAF gain).

To customize them separetely, we would need to assert only the
corresponding chip select, which is only possible with different
instances, as far as I know.

> If those are the only two options then keeping this within the driver is fine.
> For daisy chain there are examples in tree and it normally means we have to
> have a DT parameter that says how long the chain is, though we maybe can
> do that with per channel nodes as well if those make sense here.
> 
> Jonathan
> 

Those are the options in the datasheet and in hardware so far. I was 
considering other scenarios in case the user combine them differently.
I believe keping within the driver covers the main cases. 

> 
> > 
> > Maybe we could stick to synchronization within the chip for now.
> > 
> > > > +    description:
> > > > +      Enables synchronization of multiple devices over SPI. This property is
> > > > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > > > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > > > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > > > +      should be routed to the SYNC_IN pins of the other devices.
> > > > +    type: boolean
> > > > +
> > > >    reset-gpios:
> > > >      maxItems: 1
> > > >  
> > > > @@ -65,7 +74,6 @@ required:
> > > >    - vref-supply
> > > >    - spi-cpol
> > > >    - spi-cpha
> > > > -  - adi,sync-in-gpios
> > > >  
> > > >  patternProperties:
> > > >    "^channel@([0-9]|1[0-5])$":
> > > > @@ -89,6 +97,20 @@ patternProperties:
> > > >  allOf:
> > > >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > >  
> > > > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > > > +  - if:
> > > > +      required:
> > > > +        - adi,sync-in-gpios
> > > > +    then:
> > > > +      properties:
> > > > +        adi,sync-in-spi: false
> > > > +  - if:
> > > > +      required:
> > > > +        - adi,sync-in-spi
> > > > +    then:
> > > > +      properties:
> > > > +        adi,sync-in-gpios: false  
> > > 
> > > I think this can be simplified to using oneOf: to provide XOR validation
> > >   
> > 
> > Right!
> > 
> > > > +
> > > >  unevaluatedProperties: false
> > > >  
> > > >  examples:  
> > >   
> 

