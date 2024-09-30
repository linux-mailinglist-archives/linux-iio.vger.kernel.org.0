Return-Path: <linux-iio+bounces-9925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6198A38C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE011F260A9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DD18E751;
	Mon, 30 Sep 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KhOGiAG9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAB18DF6F
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700812; cv=none; b=cfgpbrHjRYB/EnrKP6qy6SOBSJmM8eqxtesWn6/H9mDf+6b9Hb2scNyiJK1GVnjxm/rpIfkwRva0nZpfeSps9LfaA+XkKOmZJEGg+cSY7bvvpjjRQ/yNmGs9b5wSRklekNmRedmsLCYzHIvDiPO+8DCSWE6XGu52BSwaCnJbhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700812; c=relaxed/simple;
	bh=FI6P/Vz2G1P9FtQdIR02rYpG8hPx1kHCzzvah3QhfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQgYvbkatSU96LR3q+ClX524Rb+dTpv7jPlQE0nXSMFVXWF9DfsKa+nb4KumdiC0g3zyUkxe9PuLrTAjfRUr9lRNZoSKZu4MHDEMTujhAXsP9DHpk13aiwHF2htHCL1kKnZbe61ScH2oXNwDLlo/Du5HVQS04BU4MAPGLJDy24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KhOGiAG9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb2191107so34996755e9.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727700808; x=1728305608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h849igZr4Ixq8Z3CBdQvzfuVtVpkRBJfrNu7EAZT8oc=;
        b=KhOGiAG9x7rt54sFgjlrYMWehkvltRzsi27TmeuM0bRCGH7OVRlOudlwCWY5Ihn7yL
         61c/B8e2g7IkJL2XKGDEzIsx4CRMKwTXNi9tbu8F5CTgTe6R+pbXLToGPna2o+JcRVNP
         W0OKCuwDk449W4kiOgH+9awyGrL8ljE5HG34CER+krRYLfV75ZmyqltoRdww7YxVUt9H
         LJyUyRAWqwnOhNJsAdF8cAhYI6ZuO0c/Ff12x8PBAwjTOJ0LcrISB2j1AMNb8KwK6i5d
         KdojA448eeZOOsQxPOt0ax2/NfCJAnmvksjj2gSFR/bGCYsjCNkU5fOmdmry77jIPouK
         4x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700808; x=1728305608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h849igZr4Ixq8Z3CBdQvzfuVtVpkRBJfrNu7EAZT8oc=;
        b=aX4L231+/XXZSwG7ANM0PToPU8S8acciLQN5X70pYs+eskGIAr8BUOTt4inMORgyuV
         RINdcxzZQyqMenZAm4yYOBlZ69Ej/fH+25n8eGuPQjjvye8PwPUTQwaftWyb96mfDKkI
         oyjMQReQ5dI9BClAx898DENrYVWlm0E4gbzzvUkXH3P/UqMNDwv/wZwV496HGWiTc4zh
         55cWfG9A80J7b5Iza01TGy5gkEbRwWdG9dbAF2HlM41xzWVfG8mAKHPo2/qRIwys4B03
         AbaJP0MMilQrapIpPaP3MEEfDbJXUC+qo7YUDkamKpaRbc1/hLJX2w0cgeS8hptDgKLJ
         mafg==
X-Forwarded-Encrypted: i=1; AJvYcCVwPWMvOPgu/G32E2l3hcE53VHg61VcNaed3injHjb9AaJ414OmPqGUnzDsFFr/sKJolvWcbqvgXuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydtU3utg4fk4Cm6BGotsyZhnn4Ym37XeYJZgoCgbU10q/iorzO
	tqFpxouE+1VGDema0OQIeFG9vwQFkV+k/IFHbt7cGQL0NGRX3pvtM6ISeAz6Yxk=
X-Google-Smtp-Source: AGHT+IGGEtHWxlpRHRB4xGyRHsYZF85KLKYWr8ofp+5/Ypf02UC8nfqWCvvKeV7hxj3tjVwUYi4U0Q==
X-Received: by 2002:a05:600c:4f14:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-42f5840e765mr93078445e9.2.1727700807785;
        Mon, 30 Sep 2024 05:53:27 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6547sm9076767f8f.58.2024.09.30.05.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:53:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:52:10 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r axi
 variant
Message-ID: <sowmuxfsedwdshyothf7jc6mcrbzqbs2vzw7x4p3tg3iqnlnjt@5qa3kazkce46>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
 <20240929114606.7500ba7e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929114606.7500ba7e@jic23-huawei>

On 29.09.2024 11:46, Jonathan Cameron wrote:
> On Thu, 19 Sep 2024 11:19:58 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using an additional QSPI
> 
> I'd drop the word additional as I assume it is an 'either/or' situation
> for the interfaces.
> 
> Do we have other devices using this same IP?  I.e. does it make
> sense to provide a more generic compatible as a fallback for this one
> so that other devices would work without the need for explicit support?
> 
>
no, actually ad3552r-axi is only interfacing to ad3552r.
I could eventually set adi,axi-dac-9.1.b as a fallback, since it
is the "gneric" AXI implementation.
 
> I'd also ideally like a view point from Mark Brown as SPI maintainer
> on how we should deal with this highly specialized spi controller.
> Is he happy with us using an SPI like binding but not figuring out how
> to fit this engine into the SPI subsystem.
> 
> Please +CC Mark and the spi list (done here) on future versions + provide
> a clear description of what is going on for them.
> 

Ok.
Actually i fixed the bindings for v4 setting axi-ad3552r as an
spi-controller, and the target ad3552r as a spi-peripheral (child node).
This axi-ad3552r is not only a pure spi-controller since providing
some synchronization features not typical of a spi-controller. 

> Maybe with the binding fixed as spi compliant, we can figure out the
> if we eventually want to treat this as an SPI controller from the
> kernel driver point of view even if we initially do something 'special'.
>

> Jonathan
> 
> 
> > DDR interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 40 ++++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > index a55e9bfc66d7..6cf0c2cb84e7 100644
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
> > @@ -41,22 +43,54 @@ properties:
> >    '#io-backend-cells':
> >      const: 0
> >  
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> >  required:
> >    - compatible
> >    - dmas
> >    - reg
> >    - clocks
> >  
> > +patternProperties:
> > +  "^.*@([0-9])$":
> > +    type: object
> > +    additionalProperties: true
> > +    properties:
> > +      io-backends:
> > +        description: |
> > +          AXI backend reference
> > +    required:
> > +      - io-backends
> > +
> >  additionalProperties: false
> >  
> >  examples:
> >    - |
> >      dac@44a00000 {
> > -        compatible = "adi,axi-dac-9.1.b";
> > -        reg = <0x44a00000 0x10000>;
> > -        dmas = <&tx_dma 0>;
> > +      compatible = "adi,axi-dac-9.1.b";
> > +      reg = <0x44a00000 0x10000>;
> > +      dmas = <&tx_dma 0>;
> 
> If it makes sense to reformat then separate patch
> please as this is hard to read as a result of this
> change.  Also, as pointed out, be consistent with spacing.
> 
> > +      dma-names = "tx";
> > +      #io-backend-cells = <0>;
> > +      clocks = <&axi_clk>;
> > +    };
> > +
> > +  - |
> > +    axi_dac: spi@44a70000 {
> > +        compatible = "adi,axi-ad3552r";
> > +        reg = <0x44a70000 0x1000>;
> > +        dmas = <&dac_tx_dma 0>;
> >          dma-names = "tx";
> >          #io-backend-cells = <0>;
> >          clocks = <&axi_clk>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        /* DAC devices */
> >      };
> >  ...
> > 
> 

-- 

  o/ QW5nZWxvIER1cmVnaGVsbG8=
   www.kernel-space.org
    e: angelo at kernel-space.org
      c: +39 388 8550663
       

