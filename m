Return-Path: <linux-iio+bounces-5405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FB8D1FB1
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 17:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5362F1C22ACD
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16317106A;
	Tue, 28 May 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GKTxlkHf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1779F6;
	Tue, 28 May 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908692; cv=none; b=f/UXb6Obr7mkZvnfUJQqk/ZJNY/s/3/6Pxe6okazdOvIlpWizQuh2b5qXW3DXFBXcTbTFdCKEp8bL30086XyWiPLtrA76Xpeitw/c5rRS0a/9pvTHXsGfksfIjLKvZQ9+UziJQU0eV2hlzoVQRk30khEQjKQTCZ0MKPm4Z49tEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908692; c=relaxed/simple;
	bh=BwvsFxWDlcOv3tQAGZN5M4cNSSA1vcWV3iHt2gZ5Rco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqjTSmj38UQ5HxEtg+NoEilLtIaX+8IKvMW3ttsNsHBmq+srU9tA21WdRAuWhJEccluUHRYGfXhaQBp6O738irD5j8KJGUahOeAQuddB1tLcsdRzasHC4Yz+V16NYjOD4cZdvO0qulWYfl3xP3GPxtX4/xkH4wLCQX3rjHJ3rTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GKTxlkHf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2CF8820278;
	Tue, 28 May 2024 17:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716908684;
	bh=Mw7dQ5Ws41dd40RAuJHYbCmnUUSNoqloqrnpXxX8AmE=; h=From:To:Subject;
	b=GKTxlkHfChssQjm59qXgvH4xTT0SvaA9SVy9L7JTaDGOK7+o05hB/H+qbbWzd2u9P
	 rEUyyula8tQ2UfeO61kVG/dIThRWVri1yIRoeQ0icF+JI5/BeoHIwwqAtQB/xIZDph
	 P+u+0Nwu+R8aPT6kj/oyfQbOkWLdc+Rvukj/ig8YvSegkUkKK97ypht6zx71gusqAj
	 qgrmB+u0pmDFP+V2Qfvz7dqWI+g3Y3cIzpI323e/yNC83LgeTGolgFE+rOBs/RiYbl
	 YwMR6mmSoQqNWYhLT2WasY3IveqW+N+SSQ/z0kadq+cx0XYHcYa0Zj03dz/JCtaBR3
	 4FJHvEfcP952w==
Date: Tue, 28 May 2024 17:04:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240528150440.GA15947@francesco-nb>
References: <20240527154050.24975-1-francesco@dolcini.it>
 <20240527154050.24975-2-francesco@dolcini.it>
 <20240527-ecosystem-mountable-d9a6eebc7607@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-ecosystem-mountable-d9a6eebc7607@spud>

On Mon, May 27, 2024 at 05:29:37PM +0100, Conor Dooley wrote:
> On Mon, May 27, 2024 at 05:40:49PM +0200, Francesco Dolcini wrote:
> > From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > 
> > Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> > with I2C interface.
> > 
> > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 129 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > new file mode 100644
> > index 000000000000..ab4f01199dbe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> > @@ -0,0 +1,122 @@

...

> > +patternProperties:
> > +  "^channel@([0-6])$":
> > +    $ref: adc.yaml
> > +    type: object
> > +    description: |
> > +      ADC channels.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          0: Voltage over AIN0 and AIN1.
> > +          1: Voltage over AIN2 and AIN3.
> > +          2: Voltage over AIN1 and AIN2.
> > +          3: Voltage over AIN0 and GND.
> > +          4: Voltage over AIN1 and GND.
> > +          5: Voltage over AIN2 and GND.
> > +          6: Voltage over AIN3 and GND.
> 
> Take a look at diff-channels.

Yes, we looked at this and at the beginning we did not think this was a
right idea. This is pretty much copying what is done in
Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.

We could describe this using the diff-channels, however the MUX in the
ADS1119 cannot do any combination, but only a subset (AIN0-AIN1,
AIN2-AIN3 and AIN1-AIN2).

Are you aware of a way to validate this in the DT?
Would something like that work?

adc@40 {
    compatible = "ti,ads1119";
    reg = <0x40>;
    #address-cells = <1>;
    #size-cells = <0>;
    #io-channel-cells = <1>;
    
    channel@0 {
        reg = <0>;
        diff-channels = <3 4>;
	label = "AIN0_AIN1"
    };
    
    channel@1 {
        reg = <1>;
        diff-channels = <5 6>;
	label = "AIN2_AIN3"
    };
    
    channel@2 {
        reg = <2>;
        diff-channels = <4 5>;
	label = "AIN1_AIN2"
    };
    
    channel@3 {
        reg = <3>;
	label = "AIN0"
    };
    
    channel@4 {
        reg = <4>;
	label = "AIN1"
    };
    
    channel@5 {
        reg = <5>;
	label = "AIN2"
    };
    
    channel@6 {
        reg = <6>;
	label = "AIN3"
    };
};


> > +        items:
> > +          - minimum: 0
> > +            maximum: 6
> > +
> > +      ti,gain:
> 
> What makes this a property of the hardware?
> Also, missing unit.

This is a hardware gain from the ADC and it is dimensionless.

> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          PGA gain value.
> > +        enum: [1, 4]
> > +        default: 1
> > +
> > +      ti,datarate:
> 
> Ditto here, why's this a property of the hardware? Usually this gets set
> from sysfs..

The sample rate is a hardware property, you can configure the ADC device
to do the acquisition at a specific rate.

Both these properties are inspired from
Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml.

We could do what you are suggesting here. I am just a concerned on how
this interacts with the iio/afe/ bindings. Specifically, how could I
configure the gain or the data rate when this ADC is used by a
voltage-divider? Maybe iio-rescale driver needs to be extended for such
use case?

Francesco


