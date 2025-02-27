Return-Path: <linux-iio+bounces-16157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B36A48A81
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 22:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB21E7A50FB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2B271275;
	Thu, 27 Feb 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lreVmJ5F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738331EFF91;
	Thu, 27 Feb 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691812; cv=none; b=g8qw2i126SmVfOVYsk6vpqMkDJtZLacQ/tAZjxq9bmef6NnQlcPJNXk/RjRK8MFbetqt/uNzJbZCD+GGNPnH88JN82T3jsj7Ex5QwvW2wE7Xvs1w+WBwk/WCoTZ6z1ttoF8b3wXyr+whvOEUMgOe5YOxggGRzC57AOFuoQae/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691812; c=relaxed/simple;
	bh=aBIsue5zuSFDdPtGkH1BrG+z8sCiyZ4OfesmbqTq3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od3KzC0/7gql0zOqAEJ0PgIoc47YQ4xIEGLSP5poz+jnnGMW8E9vdVebUqnXMC+bojLPihI0JSpfSbPYAYKDlY5yynA0ikAeOy3x0oVxOPnl2aoYWqNXR08PK6kpMGKUoCr15oj8LdoaONVPIM+OgHZ/e7AqrI2V+NNif1lziVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lreVmJ5F; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0e3688f92so28115185a.1;
        Thu, 27 Feb 2025 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740691809; x=1741296609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlS3JSHpI5pHJwFBGOh2HyZd1Zh+M5HnpWiAkan9ed8=;
        b=lreVmJ5FfjoGodbAkgQ/InUcUij6bs6p2ytJTuP+jibqdRqVRSosbmX1WhtGkPKcWX
         6P/1tN8rxZMQ0iqqxHFVQxbumg0bVvdgZYMaXuf7116fZKhlrlkZebo3/vxgaadYzK9G
         w8t+7A12vuA5VYHWY21Ud9Ao9LBDaWJJuDPrl0yBYFGaQOMpgYuRrGVv1UBM4jq0rWST
         lV8CAgHdESISVD2GeI5lu/UikSUSvVUD/TmPcW29dIP00IWfrbGCknRBNJRpCPOCDqqk
         zpxCcP4cC2Ee3qBxB804tLE6HSGnYlRZhi3exPWTsCmPPW21B7+2BaF1EJQ/b98yTKav
         0+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691809; x=1741296609;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlS3JSHpI5pHJwFBGOh2HyZd1Zh+M5HnpWiAkan9ed8=;
        b=bTE+4yyzxFRNAEyvejHLAmFL5mc+R2yz8FttE0syn2+XEE52lqfrkNGp/4hn0UTvec
         ui4dvWeWKwoxb/YjpuOmCpU3VHzdcoXcMxNwVGOVD/R0fi+LUYRUm3siLX2bDn63IzJp
         cEyutAhxyTIetHNivcwNAoClm/xBoNVipTbE/te3cMoa49mtB0OWGPc52ZsGhXn7dIU+
         KgCoqCE1NLgvGD8/0QWbZcXxS524AwO1wP1Gn9NlZQd3CbrJBaB5xbyfvGOrSWZ0c1NG
         wttXCWVDD2yDWsIqBqCHpi0IRbs1VzxhSt2K9mq61h6Gx/dj8B0PS63CKkMFvqDLe8fz
         A4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUdPC06Ax9eV03s77m0UogBnu8wC3z5EO+kZZprjP5JiRtabHGSsS7/IJTfq2zW0rs1McIPb+eOQpf0RqIj@vger.kernel.org, AJvYcCVemVvQlk0Y3JLvk6BCKWNjZOYE7hVcLlrZj3/V8q/+R2RyUdpdsGuWzZKwFPiWY9C34kMptPS3NcsM@vger.kernel.org, AJvYcCXkxnWO27moPujX2s+SRRD0KoUn+sOFj5FTTjMugBF5KrgX0TyF9RDqFejlGFXLBmW8LLv4zCth2dyb@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCkPJeueXzc7rrqmLdKMAkgkHOASbmJBgud/TIqVSqMroIsfY
	OWO32l8k5FCzcocWNmSXHjXoNgrfm7/SmwRhCBoI4+1R+mpDWUfj
X-Gm-Gg: ASbGncvb74DOQuDsS9VpN2O3FB4jyRYjJC1GcqL55dhlmWSA2YfU6yHTbAE8FXmbTGL
	9dX6mNSz/pr7SfBUxMpRMiBqixTVZa8VF+5rzNpMKQxHqX1Z5PSazN1NcMxF9z7SJG6xYNfwjKM
	TDVK4YowPoQa4nxrHPqKwu3wv0ElThyICIdkJR5l46L1AWUdhn9Xe5R28vEBJMlPl+CHe79m7S8
	HDLyqRGkZDGpfOd6TNsu3Mjn7gWiaJrjS3f22x85bEsMZOLokVCwkFq64trs2WE/GggB/fmhBvW
	QJgVH+OtJ++lPtv8jrjfCqgFM95jF0JjSeetNjxJQ/BPxN0=
X-Google-Smtp-Source: AGHT+IE2zW29zbUhd4JanqPdsbSePwmtscfZpisxuK2vZRZJO2vqLJws6sLgRJpbvC8HDMqDMtzTSA==
X-Received: by 2002:a05:620a:4e6:b0:7c3:9ce6:3fa6 with SMTP id af79cd13be357-7c39ce65a8fmr29777885a.10.1740691809108;
        Thu, 27 Feb 2025 13:30:09 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897634904sm14179316d6.19.2025.02.27.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:30:08 -0800 (PST)
Date: Thu, 27 Feb 2025 18:30:04 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com
Subject: Re: [PATCH RESEND v3 03/17] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <Z8DZXAivPexoPJkN@JSANTO12-L01.ad.analog.com>
Reply-To: 20250213-sympathy-suspend-2c414b383195@spud.smtp.subspace.kernel.org
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <4136b5259df75221fc314bcd4a57ecaeeab41a45.1739368121.git.Jonathan.Santos@analog.com>
 <20250213-sympathy-suspend-2c414b383195@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-sympathy-suspend-2c414b383195@spud>

On 02/13, Conor Dooley wrote:
> On Wed, Feb 12, 2025 at 03:16:16PM -0300, Jonathan Santos wrote:
> > In addition to GPIO synchronization, The AD7768-1 also supports
> > synchronization over SPI, which use is recommended when the GPIO
> > cannot provide a pulse synchronous with the base MCLK signal. It
> > consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> > a command via SPI to trigger the synchronization.
> > 
> > Add a new trigger-sources property to enable synchronization over SPI
> > and future multiple devices support. This property references the
> > main device (or trigger provider) responsible for generating the
> > SYNC_OUT pulse to drive the SYNC_IN of device.
> > 
> > While at it, add description to the interrupts property.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v3 Changes:
> > * Fixed dt-bindings errors.
> > * Trigger-source is set as an alternative to sync-in-gpios, so we
> >   don't break the previous ABI.
> > * increased maxItems from trigger-sources to 2.
> > 
> > v2 Changes:
> > * Patch added as replacement for adi,sync-in-spi patch.
> > * addressed the request for a description to interrupts property.
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index 3ce59d4d065f..4bcc9e20fab9 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -26,7 +26,19 @@ properties:
> >    clock-names:
> >      const: mclk
> >  
> > +  trigger-sources:
> > +    description:
> > +      Specifies the device responsible for driving the synchronization pin,
> > +      as an alternative to adi,sync-in-gpios. If the own device node is
> > +      referenced, The synchronization over SPI is enabled and the SYNC_OUT
> > +      output will drive the SYNC_IN pin.
> 
> Maybe a silly question, but why is self-reference needed here?
> sync-in-gpios is a required property at present, so why can't you
> operate under the assumption that neither the trigger-sources when
> neither are present? Is it because only one of the sources could be
> external and one internal, or there could be either one or two internal
> sources? Self-referencing properties always feel like a bit of a
> mistake.
> 
We have one internal synchronization source and two external ones.
The internal is when /SYNC_OUT drives /SYNC_IN (in this case with self
referencing). The external sources include using a GPIO to drive the 
/SYNC_IN (sync-in-gpio case) or using an external /SYNC_OUT, the last one
is described in the datasheet for multi-devices setup.

The trigger-sources property is inteded to indicate wheter the /SYNC_OUT
signal originates from within the device or from another source. currently
we are only handling the internal case. We are not sure yet how to handle
the external sources.

> > +    maxItems: 2
> > +
> >    interrupts:
> > +    description:
> > +      Specifies the interrupt line associated with the ADC. This refers
> > +      to the DRDY (Data Ready) pin, which signals when conversion results are
> > +      available.
> >      maxItems: 1
> >  
> >    '#address-cells':
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
> > @@ -65,7 +80,6 @@ required:
> >    - vref-supply
> >    - spi-cpol
> >    - spi-cpha
> > -  - adi,sync-in-gpios
> >  
> >  patternProperties:
> >    "^channel@([0-9]|1[0-5])$":
> > @@ -89,6 +103,13 @@ patternProperties:
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >  
> > +  - oneOf:
> > +      - required:
> > +          - trigger-sources
> > +          - "#trigger-source-cells"
> > +      - required:
> > +          - adi,sync-in-gpios
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > @@ -99,7 +120,7 @@ examples:
> >          #address-cells = <1>;
> >          #size-cells = <0>;
> >  
> > -        adc@0 {
> > +        adc0: adc@0 {
> >              compatible = "adi,ad7768-1";
> >              reg = <0>;
> >              spi-max-frequency = <2000000>;
> > @@ -108,7 +129,8 @@ examples:
> >              vref-supply = <&adc_vref>;
> >              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >              interrupt-parent = <&gpio>;
> > -            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> > +            trigger-sources = <&adc0 0>;
> > +            #trigger-source-cells = <0>;
> >              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> >              clocks = <&ad7768_mclk>;
> >              clock-names = "mclk";
> > -- 
> > 2.34.1
> > 



