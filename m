Return-Path: <linux-iio+bounces-12374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C339D0FC9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87F4B254CF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27937197A92;
	Mon, 18 Nov 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1aJyXbV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B20190493;
	Mon, 18 Nov 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929061; cv=none; b=brvxpE7wLlLVBqqb05IVnacmXjCBmzRtFSmvrgUUYUSCmJne5pc5wn5ZPd+RIkEH//+lkNtIv2V5Gi3vhcZY/NFYcexqokANMOhYdCeAmiKazJq7JCgZetRyBKDjIDVcw4DTfwk8eX39sqMzBS3urgdvf7vwPfU1OFQ4hGmdHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929061; c=relaxed/simple;
	bh=cwfWqKb2oPi2VN5fRBTiB9MYZwt5qGyqB4hWNJzllj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzsYv4p/dMfQE+iAl5wd/sOBIRcl4d5eeUlrTgBl4ySZmRBrCQs+WeOOwHW6+bcbr4SmkIQdEUjbIDtaSALSXLJddEdHk9ChMn/HKpXjg1R3cY5hY9QhX9C4r7UzxcUJssz0eRwFnO4YTXTDJOlXLezSon9EUA5Ar0SS68gkEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1aJyXbV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-723f37dd76cso2421209b3a.0;
        Mon, 18 Nov 2024 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731929060; x=1732533860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQ2rPkNXPPvcolTw44Nc6tDll7Wen7YOVi3JKZbs/yI=;
        b=A1aJyXbV9YDWwPPWhWVuafMtrLCgNVVBEbB7N0aEykHuYN30ILKWULuhT0y3PLT1Wb
         uGXd/5gAA8bOUTgLZcNOQTGrY6WMXBM/nBonbpyLvJBGcyMUK5+X7w9QsvYwpnRumPJ1
         H5wyefF+zUXCBFhsgmeXzbGz1mhLzzi//OfZeEdnpEHoZw5FrLCshblXkxSCRmGVJXtL
         wTok+SdZLHajdXSBmNYEp7qzjwRfsjDdawfI+NgCEgleILxQ99m8H3CYPjdaSz868aWS
         jrR3s4i6UwYvu3jQ39a4F3wWo/aiVLyVM06wEzM3PdgK4K1nD0273wcCEMJk43iis2s3
         nKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929060; x=1732533860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ2rPkNXPPvcolTw44Nc6tDll7Wen7YOVi3JKZbs/yI=;
        b=B5vfZMwXC7JIpEOb7pGrD+EAkpKJ3ZafNfJpnwRmv5UTliErBYHfRABIpr8DPGi+4v
         MBs+E2hi63EW7sLkeBglVDb8Hw3Efq0gzf5hzA4AlhNjht40ldWGqHDGJRiGmm0VtQAX
         SMYsAWuJ2FraB9qE+b2Bk5B/hbsp9ZXIV/OSWdeGLr0Uq4tPblHn/NHzFE3KOw+el4B2
         2fGETgJmrmWXZ5hhidJZ42/fikWPiT6g7sLQvPLeZDdP/gN2+fsDzzrXYosIUFMoEuLU
         y0cgwYH6Bk+/57IA5euNPiy1T9d2Id9osMWYvMZGuC3xbLVpVzAWN68qCHeLL7R417IT
         0Wlg==
X-Forwarded-Encrypted: i=1; AJvYcCUO4sfcNnT1es/KtKzbgmhmbb9dEEXudVOdrjatzcJxA6lneQYDVcxox0pe7IN5tlO3Dbjjp4RAC7Rm@vger.kernel.org, AJvYcCUdhVsGY71HhbedjmM2FMTnEdGjgDnakNw3docUcC4ELm4gacqN4CbSjy6PC/xTv34YbtAYfNTkjNWfd9KH@vger.kernel.org, AJvYcCUgnK9bAGoGIYQXNG9QWrlWVA++xCyvyp5nAKa9hfrdt7tJ7lZUIyW4IPUr+NI0Tz+6kc9sxpEQhYmh@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZ+DqUdBKYlS//nz4XfICudY46/UynPeSLb/Q0sv0YQGAJ1Ov
	y9lQ0APIouS2gHLImMtIBQwZ8Id4kVhcboxKTsD1d47IukPKmOlL
X-Google-Smtp-Source: AGHT+IFtMQFJC1y6uYyHpQbY8vkIy3CfXLJjbydMNPSXbqdvu3VmA4+1HEEbkkSSN4MxoMPyrmDoiA==
X-Received: by 2002:a05:6a00:1890:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-72476bb01dbmr14956848b3a.12.1731929059402;
        Mon, 18 Nov 2024 03:24:19 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724772012fcsm6093086b3a.187.2024.11.18.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:24:18 -0800 (PST)
Date: Mon, 18 Nov 2024 08:24:39 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <Zzsj9_HVBO5wrJv_@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
 <a155d0d0fb1d9b5eece86099af9b5c0fb76dcac2.1731626099.git.marcelo.schmitt@analog.com>
 <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8a2d07-feea-409f-a850-7ee0c752a949@baylibre.com>

On 11/15, David Lechner wrote:
> On 11/14/24 5:50 PM, Marcelo Schmitt wrote:
> > Extend the AD4000 series device tree documentation to also describe
> > PulSAR devices.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 115 +++++++++++++++++-
> >  1 file changed, 114 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > index e413a9d8d2a2..35049071a9de 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > @@ -19,6 +19,21 @@ description: |
> >      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> >      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7694.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
> 
> It would be nice to sort these lowest number first.

Ack

> 
> >  
> >  $ref: /schemas/spi/spi-peripheral-props.yaml#
> >  
> > @@ -63,6 +78,38 @@ properties:
> >  
> >        - const: adi,adaq4003
> >  
> > +      - const: adi,ad7946
> > +      - items:
> > +          - enum:
> > +              - adi,ad7942
> > +          - const: adi,ad7946
> > +
> > +      - const: adi,ad7983
> > +      - items:
> > +          - enum:
> > +              - adi,ad7980
> > +              - adi,ad7988-5
> > +              - adi,ad7686
> > +              - adi,ad7685
> > +              - adi,ad7694
> > +              - adi,ad7988-1
> > +          - const: adi,ad7983
> > +
> > +      - const: adi,ad7688
> > +      - items:
> > +          - enum:
> > +              - adi,ad7693
> > +              - adi,ad7687
> > +          - const: adi,ad7688
> > +
> > +      - const: adi,ad7984
> > +      - items:
> > +          - enum:
> > +              - adi,ad7982
> > +              - adi,ad7690
> > +              - adi,ad7691
> > +          - const: adi,ad7984
> > +
> 
> IMHO, having fallbacks just makes the bindings harder to use and doesn't
> actually provide any useful benefit.
> 
Having fallbacks was a suggestion from a dt maintainer to the ad4000 series.
I assumed they would ask it for PulSAR too. Will wait a comment from a dt
maintainer to change it.

> And with this many chips, it can be easy to overlook a small difference
> in one chips, like ad7694 not having VIO pin, so is it really fallback
> compatible? Easier to just avoid the question and not have fallbacks.
> 
The absence of a VIO pin does not change how the driver handles the devices.
They are compatible from software perspective.

> >    reg:
> >      maxItems: 1
> >  
> > @@ -129,10 +176,76 @@ required:
> >    - compatible
> >    - reg
> >    - vdd-supply
> > -  - vio-supply
> >    - ref-supply
> >  
> >  allOf:
> > +  # AD7694 doesn't have a VIO pin
> 
> It sounds like using not: could make this if: a lot shorter.

Ack

> 
> Also, it looks like ad7983 doesn't have the pin either.

Ack

> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad4000
> > +              - adi,ad4001
> > +              - adi,ad4002
> > +              - adi,ad4003
> > +              - adi,ad4004
> > +              - adi,ad4005
> > +              - adi,ad4006
> > +              - adi,ad4007
> > +              - adi,ad4008
> > +              - adi,ad4010
> > +              - adi,ad4011
> > +              - adi,ad4020
> > +              - adi,ad4021
> > +              - adi,ad4022
> > +              - adi,adaq4001
> > +              - adi,adaq4003
> > +              - adi,ad7685
> > +              - adi,ad7686
> > +              - adi,ad7687
> > +              - adi,ad7688
> > +              - adi,ad7690
> > +              - adi,ad7691
> > +              - adi,ad7693
> > +              - adi,ad7942
> > +              - adi,ad7946
> > +              - adi,ad7980
> > +              - adi,ad7982
> > +              - adi,ad7983
> > +              - adi,ad7984
> > +              - adi,ad7988-1
> > +              - adi,ad7988-5
> > +    then:
> > +      required:
> > +        - vio-supply
> > +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
> 
> To me, the more interesting thing to say here is that the sdi
> option is omitted because these chips don't have a programmable
> register.

Yes, that's correct. But the adi,sdi-pin property is about what is connected
to the SDI/MOSI pin so I kept the comment about hw connections only.
We could in theory connect SDI to host MOSI and set MOSI idle high (if the
controller supports that), but that is harder to describe.

> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7685
> > +              - adi,ad7686
> > +              - adi,ad7687
> > +              - adi,ad7688
> > +              - adi,ad7690
> > +              - adi,ad7691
> > +              - adi,ad7693
> > +              - adi,ad7694
> > +              - adi,ad7942
> > +              - adi,ad7946
> > +              - adi,ad7980
> > +              - adi,ad7982
> > +              - adi,ad7983
> > +              - adi,ad7984
> > +              - adi,ad7988-1
> > +              - adi,ad7988-5
> > +    then:
> > +      properties:
> > +        adi,sdi-pin:
> > +          enum: [ high, low, cs ]
> > +          default: high
> 
> For the similar ad7944, Rob suggested that the default should be the equivalent
> of "cs" since that is most like "regular" SPI. So I think it makes sense do the
> same here. (The adi,spi-mode property in the ad7944 binding is named a bit
> different, single = high, chain = low and _property omitted_ (default) = cs)
Ack

> 
> >    # The configuration register can only be accessed if SDI is connected to MOSI
> >    - if:
> >        required:
> 

