Return-Path: <linux-iio+bounces-12498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00129D6163
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C39B2632E
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE016A332;
	Fri, 22 Nov 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqbQBJRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290013AC1;
	Fri, 22 Nov 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289573; cv=none; b=KWv4NN2T9ug1tP/GnY4s8nc8queTWbwL18rJf4M9PBGnKuNEVU6KaHNpWbg1mO2Jkbiew06on+pJO+8cGIkOMjSMV1vJJS2WBN6kLYSYmUT0XxNcdY4YPZC9tqrgoL21N+sj2BIkCL+PFZg4Ovrgqvfe2iLtL9bwKgZ+UXQYA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289573; c=relaxed/simple;
	bh=0FclO1/fy/StBe40uIFRtdGhOrnTErVR8/u5v+4B8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2SkM7CFYPIqQTiamf4zt0nzwTksPcoBpCVDo24rj/EfpcYbxqoRY057nd3UZezj1p06EMWxci+nOjk6J9MAFajkdTOjeqWsMBxWjyO2RGxTfnvbt+UITgYIdjPgVErTe130jk24LHF4x4n3hSi2klAGKZxGS1/Pel6dQ7Os31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqbQBJRj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21262a191a5so21023025ad.0;
        Fri, 22 Nov 2024 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732289571; x=1732894371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEihtZELJslqzYx1qKoHiiJG/a0GTxJmxX3Q8r6D26c=;
        b=MqbQBJRj5ucYUPpz6RxQAouHQp/7KzI/bRGxOIuPPdCF+3sxbE66NoCrNr1Q/MCouA
         xJuJP93uPSVkNwR6ScTbbjzCqb1zPtFY3pzKEU7sJs0PaI/OaR+ae9kGycPt+O2J06NA
         QUB5Nkhq3zVPp/GGSGWmWqyg4+2/GiO0tMcvUQ4vEo1jakByufoZtBzJOeBw2ghEPgTP
         /MdAgaiL1vRuqjFEOnfwfudz42Xbk0PtA5hroaFqrrFo5m6cNSKxYkZ3zBIpY35ib6fJ
         ojLkEQqyAF/IpJboE1d403p6iztmwtxR06zNSCjAeDWX6PXAAFzOe5upPDBI7NRDzrQ3
         KKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289571; x=1732894371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEihtZELJslqzYx1qKoHiiJG/a0GTxJmxX3Q8r6D26c=;
        b=QEuyyGhNw4IYjR9G2JyAJSW0I2zeBO7ip28hEurFQIqkcBNQqc7JB20/McqaVTuWE+
         xDOjRfS+WNXbdt+za6f3opMzFQ/IRFTTvcVdc/na8QdU4U7GMQxGElY+TVzhN/VVxDUC
         xdRxQPNult9wtbZZHdpAMHA3wBHNQhJEgX9DefNQeUZRIGyQyZWGxDE78Frmq7gOU3M1
         dUSSbaAQA5HXWBc/sY9MmLAwZhll1Z+a2xrkhdmRqsPaFnkztqn+yRKNa6wM5nLXjbSC
         /z3p/eLMwBWMLzlUeVKLZALMPMv+QZmPQG7QGTfi8AE2n/RX7TqnsjdxbvnK9xMGa/Hj
         35cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCiTauoduooxYP7EEN0+o3QJP9xz5NRFRFU1ffwtLLkPuUIVlCA0M3FURr7SpjfTk9mNta3NiXM86J@vger.kernel.org, AJvYcCXBetW8b1sS0pP71j6mopHfv96HU108AwOVV9kPV06tAoBPGWxtkLz0edi8Py9PvOEjrhfrozBykLFD@vger.kernel.org, AJvYcCXrWNq8payfRYV/LSIU7BDdxJku6vKEKljA1PbDZfqoQCtjFcdtV5PGs06C2lBFuRD8BgmI37jOeOgpD4ld@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiZ8pRqojeuftSDLb5VOLo8/EA4JwHgvAONNbcuLSOsVMbZZU
	oSavqkN7s/vrtOaN93QfpOAvOoTjBhv4CimUOzRFWPhfHxM5EjSa
X-Gm-Gg: ASbGncseQKmhowILgYIVcVjDD0PGW0NBoAn6edtqhe9iU3vbVuqZZEx1TImtIwH/5YH
	1rK7dPqMRpkkhtm/jaIZVgA14I/h6QkbODzrxVz+SmYoCqwtEZBzYQcQbdRpvkSrg//FX6Z9IAy
	5FIx7q1/TLNxiHeQbuqeCk7Nwky27c4iiefHy0iaGgXntHmnfyrRUq9uYhvzkk+LyulTFiLT4tg
	b5j1pnC3NDNXTx4JtblfD3GvTgjIzvKIw1zTm1/O8H0F1B1Y3A6xgmKmAFl
X-Google-Smtp-Source: AGHT+IFz6WAw7NYuRZ7C2FqbMDhOZ1uFfidu6y5aHIwF3/RrVeM5N56quWuhGpWrbBCgLUylhAm/0Q==
X-Received: by 2002:a17:903:2311:b0:20c:6bff:fc88 with SMTP id d9443c01a7336-2129f239d0bmr37000985ad.28.1732289571066;
        Fri, 22 Nov 2024 07:32:51 -0800 (PST)
Received: from localhost ([2804:30c:1618:9800:694b:286f:2b3a:5414])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2aaccsm17485065ad.278.2024.11.22.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:32:50 -0800 (PST)
Date: Fri, 22 Nov 2024 12:33:13 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <Z0CkOTGhGhfV18OG@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
 <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>
 <5kz6ghe56yiprlvhyduv7olcrajvejyvulcpjav6doiyvr6dcl@6qlt4nebp4gb>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5kz6ghe56yiprlvhyduv7olcrajvejyvulcpjav6doiyvr6dcl@6qlt4nebp4gb>

On 11/20, Krzysztof Kozlowski wrote:
> On Tue, Nov 19, 2024 at 09:53:40AM -0300, Marcelo Schmitt wrote:
> > Extend the AD4000 series device tree documentation to also describe
> > PulSAR devices.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > No changes from v2 -> v3.
> > 
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > index e413a9d8d2a2..4dbb3d2876f9 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > @@ -19,6 +19,20 @@ description: |
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
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
> >  
> >  $ref: /schemas/spi/spi-peripheral-props.yaml#
> >  
> > @@ -63,6 +77,37 @@ properties:
> >  
> >        - const: adi,adaq4003
> >  
> > +      - const: adi,ad7946
> 
> All such cases are just one enum. That's the preferred syntax.
> 
Ack

> 
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
> 
> Keep alphabetical order.

Do the fallbacks declared here have any impact on the match try order or on how
the compatible list should be ordered?
The only significant difference between each group of devices is the sample rate.
A faster device can read at slower sample rates so if somebody knows to have
a 16-bit pseudo-differential PulSAR but doesn't know about the exact model they
could have a compatible like
      compatible = "adi,ad7980", "adi,ad7988-5", "adi,ad7686", "adi,ad7685",
                   "adi,ad7988-1", "adi,ad7983";

to try from fastest to slowest device.
The dt doc would indicate that order in the fallback list?
      - items:
          - enum:
              - adi,ad7980    # Fastest 16-bit pseudo-differential ADC
              - adi,ad7988-5  # 2nd fastest 16-bit pseudo-differential ADC
              - adi,ad7686    # 3rd fastest 16-bit pseudo-differential ADC
              - adi,ad7685    # 4th fastest 16-bit pseudo-differential ADC
              - adi,ad7988-1  # 5th fastest 16-bit pseudo-differential ADC
          - const: adi,ad7983 # Slowest 16-bit pseudo-differential ADC

https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
has a nice table with the different devices and sample rates.

writing-bindings.rst says "DO use fallback compatibles when devices are the same
as or a subset of prior implementations."
But, how can we use fallbacks properly?
From Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml I'm
inferring only one fallback should be provided per group of devices.

> 
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
> >    reg:
> >      maxItems: 1
> >  
> > @@ -133,6 +178,32 @@ required:
> >    - ref-supply
> >  
> >  allOf:
> > +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7685
> 
> Why do you need this? It's fallback is already here.

So dtbs_check can provide an error message if for example compatible = "adi,ad7687";
and adi,sdi-pin = "sdi";

zynq-coraz7s-ad7687.dtb: adc@0: adi,sdi-pin:0: 'sdi' is not one of ['high', 'low', 'cs']
> 
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
> 
> Best regards,
> Krzysztof
> 

