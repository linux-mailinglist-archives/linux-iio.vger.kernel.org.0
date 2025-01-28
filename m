Return-Path: <linux-iio+bounces-14677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276ABA20C92
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 16:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D926188A204
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AF1AAE13;
	Tue, 28 Jan 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CstrE2X4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBB1ACEBD;
	Tue, 28 Jan 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076670; cv=none; b=EP83UmlwE5+iJbr8F8n0Ko7CUzH7HEuZKM4qrpZssdXM3PKkf2QXDz0RB+v/ACpDPHzRNT8PflsbBn0HA3IM7oyKhX9ihTrj5ZABUFGswY5XqTysX0M4138tfGThRcbTV3SrCZn3JcChwrylOdkVBblFMUKG0YFUfbK9D3VkViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076670; c=relaxed/simple;
	bh=kgKV8nmTrg4pxRmN//PoCBMWnCk7qZNUlnQaXkNk3Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pursrlda22fcmGrxOmVKVL1lE+/yFwl2TmGXdgTy94yKscPMPfZhK985Zij1bKU1zq2a6Hpgy0B9US1hhTahUDCc8o98xcaLyMA64eyjTkxu0bJhYAG0ZxqF8TSqR+4PYRB5eZUYSWKyzeSMtDQzu2OrQ89vbnqS3GvBvCw4VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CstrE2X4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b702904ec9so45817685a.1;
        Tue, 28 Jan 2025 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076667; x=1738681467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9nGPatu4AoSgeqQMerXE2HoOM54MLq3Opr2JcniEyo=;
        b=CstrE2X4UClp90jXDS9QRmpFqYKH+YlqBNIrsKiAjwpRQ5SlqlTmqPu6fQZ77QR116
         9mPNbwDwT7F6O4ryY3Mr7jAtT0AhiKVKys3GaQiWp/8j/GnOE/B2RWG5ChgEfBPnQ81J
         pb4ypAq5DIz0tN8s36bp+hA+Cnca2vfcaaJyKZyzDDQkH2PIpxOmgVt+B66VMCgQN6kd
         mHQJta5fvBF48hL8gX/sCeI44xvmXdmj7mHv9gRfolhxCu1ahrWunpJ8iWf5exi4we8/
         Bqku/1WbfTQJ899f79lS2dSGMrMGX1On0z//aZK6l46YcfOTbaWmkMlzPeXHs1QbzEE9
         sdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076667; x=1738681467;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9nGPatu4AoSgeqQMerXE2HoOM54MLq3Opr2JcniEyo=;
        b=WCAMQgRH+RJyP743EnB1/V0QbzzIWG3PKJjY0xZ79bh1wOLrolibRQ/U77r2Chhfsp
         X5TQFIWucGpLsN2m2ifnbNTIzVjDkc6UxEAG+J6kC/cFiwD3o6aWSiOdaIgtv3EJOSbS
         Me3PBIWvXcKzE1ztooniyMKImFDG5+VFgxGwwOjdgn2gzk+zU72sertpYwOqEY8eJ1xO
         sYQmO7uYWAkPlzPJh5rMcm4usbGZkSYuKEgbAR17dfyP/9UaKehsJ3QSjJxWYpata1t1
         OOAnO40ndWic40nocMRGjOrYG8KEzDfxDFtFr/RFGQCfUeD0vErPRcH8IXyymu9qpxYU
         54NA==
X-Forwarded-Encrypted: i=1; AJvYcCU/UOktBhVRgyQpPYhh6eQMYNH4kV+eLDAQtKZCozbXutabGByZDeQGzP7g96chVMv21XyINDLJwwNv@vger.kernel.org, AJvYcCUVYfIodzWeLHH3EsLHCnZY+DAQ4PyVCYlP3EuqVu/bIP+TSvf6HSTlxDtiVhOUHvmrmReGGfziMFB5dKsC@vger.kernel.org, AJvYcCWhR7tCU8DVrSuqRBkpn6yNxG/JVawPQoZRCehxAOtBkvna3NCZ9327nYNdSJRcIGAvjaY/ST1CGVa5@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2m4J2PBU7Gwzc39RwYTIqtVxQt+/4Uk1AaGoeRM0RFdpYJAA
	y4vROgNyiQIBtKrMxBawAPuLPtYwfDI+vSzJNQbvNQzKaqZYpKU9
X-Gm-Gg: ASbGncvC1haoiqwnuj8kKiPAmacfsSQyFLTmkU39OlGCq8lAFR4Zwca+ut8HmvlfMwy
	Ly83kbJkax084GF4D1dFy8FdeMEpbpbR9jdmVmyw8ugKnZxS1Q1d8JSIbPKbz4nPl2Lo7aiSFG0
	fohemaGgJdTbZfkMnoiJmghTTZMF1WntP+bp0p9+jlbOfiUR+WQOFGkKEZJx47c38wgC8/etOVQ
	N7hYcpbfl2wnz40B5uoN6brttOO5/ucyh5c20WtTwxqZrarPOGMDkPZVx61BedkEdJ5Z3Wxn5h5
	9YEsTnOrmyllv+JB79fSyb3gd90Xg5RczLje
X-Google-Smtp-Source: AGHT+IGGcb8H+TQsRiSfBAQFuZmW/mVw5NYPGYWMMdrL6edpjU3l9dQ5O6LnNRcqNmi/CX6UKXP8EA==
X-Received: by 2002:a05:6214:c2a:b0:6df:b99d:e65b with SMTP id 6a1803df08f44-6e1b220e5f6mr256890936d6.10.1738076667208;
        Tue, 28 Jan 2025 07:04:27 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e205136c31sm45872026d6.14.2025.01.28.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:04:26 -0800 (PST)
Date: Tue, 28 Jan 2025 12:04:22 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <Z5jx9mJdi3Zh7Mx6@JSANTO12-L01.ad.analog.com>
Reply-To: 0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
 <0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>

On 01/27, David Lechner wrote:
> On 1/27/25 9:11 AM, Jonathan Santos wrote:
> > Add a new trigger-sources property to enable synchronization across
> > multiple devices. This property references the main device (or
> > trigger provider) responsible for generating the pulse to drive the
> > SYNC_IN of all devices in the setup.
> > 
> > In addition to GPIO synchronization, The AD7768-1 also supports
> > synchronization over SPI, which use is recommended when the GPIO
> > cannot provide a pulse synchronous with the base MCLK signal. It
> > consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> > a command via SPI to trigger the synchronization.
> > 
> > SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
> > property. Since adi,sync-in-gpios is not long the only method, remove it
> > from required properties.
> > 
> > While at it, add description to the interrupt property.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v2 Changes:
> > * Patch added as replacement for adi,sync-in-spi patch.
> > * addressed the request for a description to interrupts property.
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index 3ce59d4d065f..3e119cf1754b 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -26,7 +26,17 @@ properties:
> >    clock-names:
> >      const: mclk
> >  
> > +  trigger-sources:
> > +    description:
> > +      References the main device responsible for synchronization. In a single
> > +      device setup, reference the own node.
> > +    maxItems: 1
> 
> We probably actually need 2 here. One for /SYNC_IN and one for a GPIO3 pin
> acting as the /START signal.
> 
> > +
> >    interrupts:
> > +    description:
> > +      Specifies the interrupt line associated with the ADC. This refers
> > +      to the DRDY (Data Ready) pin, which signals when conversion results are
> > +      available.
> >      maxItems: 1
> >  
> >    '#address-cells':
> > @@ -46,6 +56,8 @@ properties:
> >        sampling. A pulse is always required if the configuration is changed
> >        in any way, for example if the filter decimation rate changes.
> >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> > +      In the absence of this property, Synchronization over SPI will be
> > +      enabled.
> 
> Isn't /SYNC_OUT connected to /SYNC_IN required for synchronization over SPI?
> 
> If yes, instead of adding this text, I would make the binding have:
> 

Yes, but the synchronization over SPI is enabled in the absence of the GPIO.
The trigger-sources property would indicate if the sync provider is the
own device or not. As i said below, maybe i misunderstood.

> oneOf:
>   - required:
>       - trigger-sources
>   - required:
>        - adi,sync-in-gpios
> 

Wouldn't be simpler to consider the absence of sync-in-gpio? this way we
have less changes in the ABI.

> >  
> >    reset-gpios:
> >      maxItems: 1
> > @@ -57,6 +69,9 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> >  
> > +  "#trigger-source-cells":
> > +    const: 0
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -65,7 +80,8 @@ required:
> >    - vref-supply
> >    - spi-cpol
> >    - spi-cpha
> > -  - adi,sync-in-gpios
> > +  - trigger-sources
> > +  - #trigger-source-cells
> >  
> >  patternProperties:
> >    "^channel@([0-9]|1[0-5])$":
> > @@ -99,7 +115,7 @@ examples:
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > -        adc@0 {
> > +        adc0: adc@0 {
> >              compatible = "adi,ad7768-1";
> >              reg = <0>;
> >              spi-max-frequency = <2000000>;
> > @@ -109,6 +125,8 @@ examples:
> >              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >              interrupt-parent = <&gpio>;
> >              adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> 
> Don't we need to drop adi,sync-in-gpios here? I don't think we would have two
> things connected to /SYNC_IN at the same time.
> 

I guess i misunderstood the use of trigger-sources. I thought it would
indicate the trigger provider or main device. Like if it points to other
device we should use it to drive the SYNC_IN of all devices.

Then what happens if the trigger-sources points to other node? we would't be
able to driver the SYNC_IN in case of any configuration change?

> > +            trigger-sources = <&adc0>;
> > +            #trigger-source-cells = <0>;
> >              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> >              clocks = <&ad7768_mclk>;
> >              clock-names = "mclk";
> 

