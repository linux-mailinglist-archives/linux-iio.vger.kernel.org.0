Return-Path: <linux-iio+bounces-8185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18C946917
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4A9B218A5
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6413633B;
	Sat,  3 Aug 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVee2Pn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095481ABEA7;
	Sat,  3 Aug 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681608; cv=none; b=jMIOG0vVwIrlheEOlGOf6LQUlxEp/VeULlsOBSqkA2I8PshVrpPSlyS9gwfr3Ba0UbEYUbWJqAT00gqkSpH2BfmE3Zw46PsF719EFdL3F+0qFv/6mbF8cS7GzgrRfPy3I9FrYXe6h2v59jBqjuZTJPVc0WsBp1+n5+lYaArSa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681608; c=relaxed/simple;
	bh=ty1lvCzRcfP3px8gHvkWz0iOMc8sRwThm1AFIKF/IVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYO1/WVlAPtLq+37RAYvm5x+MLg7m65KNs9NTYvcOfBmS10S3506XcV7lXJ7f/baPLgjCzVgQ5UxrCyCOnTiPIz22O71qDMlgyCfzcZ1CQxsAHx4koxCJeguPZ7GL8B8v82d6QCZFEys5EYcfv5W7KxWSf2PIozeBi0beqRskeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVee2Pn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5C1C116B1;
	Sat,  3 Aug 2024 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722681607;
	bh=ty1lvCzRcfP3px8gHvkWz0iOMc8sRwThm1AFIKF/IVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVee2Pn2fvtcvRa/Ij9Rd1q+cTJPD970Y62CiyUSID2kcAAck1f4lTKxj5JcCl5/9
	 qWl5ToA0XL1Pz1Rhg+xttrxZa6mm9f784SlFzHwm3BTETJOkVsVDk6HTRltBGiZi4Z
	 ncsv63E4H7Pb2ZjkkH9p8hNCRkWBnAfgghhzTPesX8VKJWhu014xU2PiXDs2ho5ylM
	 10kigJx6wrMBC9YSNMEEHLRxzIJOhi96LJWyeknNuIMIHUSBdncuG+JullpykL2UNs
	 fEyDmuN0G/bNcSl+r1wGl3tYO2YnesPN3SMnPDBVCOEzd5/CkZOZh/Vfcm7lfAVkcF
	 bCXj434nBhzLw==
Date: Sat, 3 Aug 2024 11:39:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
Message-ID: <20240803113959.12aa0c4a@jic23-huawei>
In-Reply-To: <368cc5a8-3ec1-4e91-ae1d-59068f25d8e0@kernel.org>
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
	<20240731-sg2002-adc-v3-1-5ac40a518c0a@bootlin.com>
	<368cc5a8-3ec1-4e91-ae1d-59068f25d8e0@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 15:57:27 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 31/07/2024 14:24, Thomas Bonnefille wrote:
> > The Sophgo SARADC is a Successive Approximation ADC that can be found in
> > the Sophgo SoC.
> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>  
> 
> A nit, subject: drop second/last, redundant "binding documentation". The
> "dt-bindings" prefix is already stating that these are bindings and this
> is documentation. Cannot be anything else.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> 
> > ---
> >  .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 48 ++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > new file mode 100644
> > index 000000000000..79d8cb52279f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-saradc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title:
> > +  Sophgo CV18XX SoC series 3 channels Successive Approximation Analog to
> > +  Digital Converters
> > +
> > +maintainers:
> > +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > +
> > +description:
> > +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:  
> 
> Drop
> 
> > +      - items:  
> 
> Drop, use const directly.
> 
> 
> > +          - const: sophgo,cv1800b-saradc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - clocks
> > +  - compatible
> > +  - reg  
> 
> Odd order. compatible is always first. Anyway, list here has the same
> order as "properties:".
> 
> > +
> > +unevaluatedProperties: false  
> 
> I don't see any other $ref. Don't you miss adc.yaml? Or channels? Or
> some more properties? This looks incomplete for ADC.

It's acceptable on ADCs in particular (but more generally)
to just assume all channels are exposed.  They may all be wired
to internal power lines anyway, in which case what is there is
a chip feature.  This only works if their isn't any channel specific
configuration, then not providing the channels child nodes is fine.

However, that requires us to be fairly sure there won't ever be
a per channel thing that needs configuring from DT.
That's generally only the case in simple devices.

So might be better to put the channels nodes in there and deal with
dynamic channel configuration (so don't present any without
a channel node) from the start as it's more future proof.


> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    adc@30f0000 {
> > +        compatible = "sophgo,cv1800b-saradc";
> > +        clocks = <&clk CLK_SARADC>;
> > +        interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
> > +        reg = <0x030F0000 0x1000>;  
> 
> Hex is *always* lower case, see DTS coding style.
> 
> Order the properties correctly, so again, please read DTS coding style.
> 
> > +    };
> >   
> 
> Best regards,
> Krzysztof
> 


