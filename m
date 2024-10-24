Return-Path: <linux-iio+bounces-11084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3889AE0D2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 11:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D33284698
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F01B219E;
	Thu, 24 Oct 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VUcJ5P75"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0761B393E
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762190; cv=none; b=fgr4kTXGs0vpkP/3pGELqbQVjcG8fQTbmUz7cPMH5YfRECE/YnWsKFqETmgKFXvGXxbX7yLFhc1ERMCRsIT/Q8XAtHqemuheLBAZnz2Ke3k5GoffAoAKtMdQ+kiLPefIjJ+9zG7rddwWIWTelLvnL1tT1kY/KEMT1SnFjTXVTPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762190; c=relaxed/simple;
	bh=7GLMKjoFMHeu21FwG9v6K0Az4LLutw0rnj4PK+vdB84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDzCzYrXbOTApjUl7KuctsiMum1tMJb+fjBbn8XrOwtDBv93xuzYgoDe8rIugplm4m/R54fhkoOu4y8zG0BduiiE5RnAjUyaKSGH96UggprJ2BPGbl9tkCUcYLYonnN1vgn7ZznkFccjCMGRa6NstD/La+MRcYAOYyMtG6iQ6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VUcJ5P75; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so7233005e9.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729762184; x=1730366984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=umDPNaddrw8s7LRTfU20jVzV71EK0gpRXjXBcrPfdR4=;
        b=VUcJ5P75hhSQERFiAUJkcvjR38deR8nARh7R/pZDTsTLZC/ukgY3qgyKj0vqzthPiy
         CihOCTaV6blzVFc51B3mwNXm7a8nn4LdNDL7U4rFjE5akxtQZ7RV3gUBMeJqblOjg6yl
         OxbVGrx7Oq3Wq4FygKgB3NkfVQZcNx29aSk5ecKmaA3+4oIKx053MOve2aBx8vI5nDrW
         SGJN7PHwUg+hYJ9LD1bKDiP9nkGvyyrPRyQ7g4MmKJ0C5kcC2n+tEAyiwn9QEPMkG4Jn
         n6ID8zlFAyn1xMJTY2hsJqiT0sl4TKU+Pm/uQ2K9QvRNft5Rr6u7KzNUwIIxxER/B6VS
         PN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762184; x=1730366984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umDPNaddrw8s7LRTfU20jVzV71EK0gpRXjXBcrPfdR4=;
        b=Q6QR5296UYGIceu0folRX3JNwYjlLshZFrP9ZXXjrAg4MseoP+g68NMMCXf7ER0bQ4
         NgSkrto7J5pv3EMpiSR7HRyooxINVryXCC5BNG8FJrNo6Mr83SgDF2ZJHXzs2rhHyqSl
         Z23w4CBg1JpkTj/pNxCzCnr/sE3u3WsNYyJSUJKpB9riC/VyQMy+IElrY94/+jMOOGcj
         JAGhph2qzKjZ7M4Q6u2RQOR9ih/XF2HlElAPp5WB+sM51uq8IhuPbUahCbvfBSUQHef/
         MGvfD+eggEWsyZVi1N/qvtS+aGBXwT1cATQKmFT/Vs+tKg/fA+t8PHmuuyvTxmE6Zdap
         uojA==
X-Forwarded-Encrypted: i=1; AJvYcCUq9b87RQF/Q326B5KYuPT3dtL6jP2454KIrVGQsVMGH059a8JJ/nrZTnsnOUqktyHSKvORgUkt9lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJ+jCrtMDMbgJdRT2wVxseDrn6Ot67z50CmZc0tijdelpUWZG
	o9fUhCHw0at7HisiqdnENJcwfO0t9AgLNcVjwDZ1vKUTpRkmaKnGoBsCD4sVCEg=
X-Google-Smtp-Source: AGHT+IHTibw7Z57bMSTW7jJ8HbWjR1xpaNPqq+EEvaB8gOserl9u9FOnRWOtXqAUaSCVT0K/dJMLOQ==
X-Received: by 2002:a05:600c:6045:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-4318c8df606mr10485325e9.31.1729762184261;
        Thu, 24 Oct 2024 02:29:44 -0700 (PDT)
Received: from dfj (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bde1b5sm39559315e9.12.2024.10.24.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:29:43 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:28:27 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <zfggfhasl3njyux5n44j2au4dlyjlngbtt4fps2xqzpngbwn42@72icpspkogtz>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>
 <20241022-flagpole-subject-51e68e81e948@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-flagpole-subject-51e68e81e948@spud>

Hi Conor,

On 22.10.2024 18:22, Conor Dooley wrote:
> On Mon, Oct 21, 2024 at 02:40:12PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using a QSPI DDR
> > (dobule-data-rate) interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Note, #io-backend is present because it is possible (in theory anyway)
> > to use a separate controller for the control path than that used
> > for the datapath.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 69 +++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > index a55e9bfc66d7..0aabb210f26d 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > @@ -19,11 +19,13 @@ description: |
> >    memory via DMA into the DAC.
> >  
> >    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> >  
> >  properties:
> >    compatible:
> >      enum:
> >        - adi,axi-dac-9.1.b
> > +      - adi,axi-ad3552r
> >  
> >    reg:
> >      maxItems: 1
> > @@ -36,7 +38,12 @@ properties:
> >        - const: tx
> >  
> >    clocks:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> >  
> >    '#io-backend-cells':
> >      const: 0
> > @@ -47,7 +54,31 @@ required:
> >    - reg
> >    - clocks
> >  
> > -additionalProperties: false
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,axi-ad3552r
> > +    then:
> > +      $ref: /schemas/spi/spi-controller.yaml#
> > +      properties:
> > +        clocks:
> > +          minItems: 2
> > +          maxItems: 2
> 
> Is this maxItems required? It matches the outer maximum.
> 
> > +        clock-names:
> > +          items:
> > +            - const: s_axi_aclk
> > +            - const: dac_clk
> 
> The names are the same in both cases, you can move the definitions
> outside of the if/then/else stuff and only constrain it here.
>
thanks, could you maybe have a look if it's ok now ?
(maxItems not needed for a const list)

  clocks:
    minItems: 1
    maxItems: 2

  clock-names:
    items:
      - const: s_axi_aclk
      - const: dac_clk
    minItems: 1

  '#io-backend-cells':
    const: 0

required:
  - compatible
  - dmas
  - reg
  - clocks

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: adi,axi-ad3552r
    then:
      $ref: /schemas/spi/spi-controller.yaml#
      properties:
        clocks:
          minItems: 2
        clock-names:
          minItems: 2
    else:
      properties:
        clocks:
          maxItems: 1
        clock-names:
          maxItems: 1

unevaluatedProperties: false

...

> > +    else:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +        clock-names:
> > +          items:
> > +            - const: s_axi_aclk
> > +
> > +unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > @@ -57,6 +88,38 @@ examples:
> >          dmas = <&tx_dma 0>;
> >          dma-names = "tx";
> >          #io-backend-cells = <0>;
> > -        clocks = <&axi_clk>;
> > +        clocks = <&clkc 15>;
> > +        clock-names = "s_axi_aclk";
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    axi_dac: spi@44a70000 {
> > +        compatible = "adi,axi-ad3552r";
> > +        reg = <0x44a70000 0x1000>;
> > +        dmas = <&dac_tx_dma 0>;
> > +        dma-names = "tx";
> > +        #io-backend-cells = <0>;
> > +        clocks = <&clkc 15>, <&ref_clk>;
> > +        clock-names = "s_axi_aclk", "dac_clk";
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            compatible = "adi,ad3552r";
> > +            reg = <0>;
> > +            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
> > +            io-backends = <&axi_dac>;
> > +            spi-max-frequency = <20000000>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            channel@0 {
> > +                reg = <0>;
> > +                adi,output-range-microvolt = <(-10000000) (10000000)>;
> > +            };
> > +        };
> >      };
> >  ...
> > 
> > -- 
> > 2.45.0.rc1
> > 



