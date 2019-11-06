Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4EF109E
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfKFHrA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 02:47:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34739 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKFHq7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 02:46:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so24957509ljf.1;
        Tue, 05 Nov 2019 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=av47Q/iim9RNgqgq4Bmm3HSeM8JMpXROtypRo+EI6qQ=;
        b=ShlBgR1n9Sk0PdCClS/t8wlllquptCN1V/q2gzdIn/lYs4TeosBLdKratWLBcjVOX9
         F1DZz+6kxyVcGLLcygLT880qORC4Vy2MZxan5p+NUbdGpx2e6CcuTApFaN2yTY0CeJ2I
         t6l5jPtBQGb21I9kvyMe3gznx5E90lirlDcdrbOK+x7r6moFkv/uzczOVUt5C28usqwK
         c7XrZTcqLMhXQliVrg3KBipGYV3n1ABlJHEY+b6mJiYxusLSFGguv98tVK6jgtcUCTQu
         8gCmV/c4+whCRiX6CWc8/pkZpqWzq+f/s+LVL3scCejHa04wooqArTrcbAFSZep/w7Yf
         Qodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=av47Q/iim9RNgqgq4Bmm3HSeM8JMpXROtypRo+EI6qQ=;
        b=Y47gTxUWKTASpHP1f81gI5SKXmmxc1z8Dp+FUb5h3aoi/vx33jUKC+j9nOVLTC+bqv
         bo6hK+vHhuMdPNOqPxWzt2/z0OURoNTVCgK0uS6iKvhKphHDH6/qUdY/UdcMADzeV5g0
         s57RWy9f4GWaILXRVPJImcjQcUX93RX5FkhDw+HsopY6tmS7/fzFW5DMg4JyLSd69Has
         v24t54zysI7iZNVuiRD5i8I4inoEMSurcYn7w/lPAl5NBVaiW9WW/j/uPP2kTLGuJMDv
         kWxKE9y6rlGBRzxil/pff7/E1qoerPCX+bQ75wRyVkoy3vO2JNXEQsRvU9hRCxyeRbYV
         EFyA==
X-Gm-Message-State: APjAAAXZIrrUo64wLpGw1ELty5bsdYdv1vnn6AunPoUoEwpa9mvPkV29
        oW0YkAwD9QR6d8Bcffq/V6wI3/5CrZm6+A==
X-Google-Smtp-Source: APXvYqz135mVKLw+H2DIsJPov4sRirJ60o0BH6yAXNe4gTREjzSpKrdjtA3qWGvKyul7lKO65hpsww==
X-Received: by 2002:a2e:9841:: with SMTP id e1mr813101ljj.19.1573026417271;
        Tue, 05 Nov 2019 23:46:57 -0800 (PST)
Received: from gmail.com ([94.234.51.156])
        by smtp.gmail.com with ESMTPSA id p88sm15335721ljp.13.2019.11.05.23.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 23:46:56 -0800 (PST)
Date:   Wed, 6 Nov 2019 08:49:35 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Kent Gustavsson <kent@minoris.se>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Migrate MCP3911 documentation to
 yaml
Message-ID: <20191106074935.GA1200@gmail.com>
References: <20191029211142.14650-1-marcus.folkesson@gmail.com>
 <20191106034920.GA15882@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106034920.GA15882@bogus>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Thank you for comment. See inline comments.

I will apply the changes to this pending patch as well.
Subject: [PATCH] dt-bindings: iio: dac: Migrate LTC1660 documentation to ya=
ml

On Tue, Nov 05, 2019 at 09:49:20PM -0600, Rob Herring wrote:
> On Tue, Oct 29, 2019 at 10:11:42PM +0100, Marcus Folkesson wrote:
> > Rewrite bindings to use json-schema vocabulary.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mcp3911.txt   | 30 --------
> >  .../bindings/iio/adc/microchip,mcp3911.yaml   | 72 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 73 insertions(+), 31 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.t=
xt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip=
,mcp3911.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt b/Do=
cumentation/devicetree/bindings/iio/adc/mcp3911.txt
> > deleted file mode 100644
> > index 3071f48fb30b..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -* Microchip MCP3911 Dual channel analog front end (ADC)
> > -
> > -Required properties:
> > - - compatible: Should be "microchip,mcp3911"
> > - - reg: SPI chip select number for the device
> > -
> > -Recommended properties:
> > - - spi-max-frequency: Definition as per
> > -	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> > -	 Max frequency for this chip is 20MHz.
> > -
> > -Optional properties:
> > - - clocks: Phandle and clock identifier for sampling clock
> > - - interrupt-parent: Phandle to the parent interrupt controller
> > - - interrupts: IRQ line for the ADC
> > - - microchip,device-addr: Device address when multiple MCP3911 chips a=
re present on the
> > -	same SPI bus. Valid values are 0-3. Defaults to 0.
> > - - vref-supply: Phandle to the external reference voltage supply.
> > -
> > -Example:
> > -adc@0 {
> > -	compatible =3D "microchip,mcp3911";
> > -	reg =3D <0>;
> > -	interrupt-parent =3D <&gpio5>;
> > -	interrupts =3D <15 IRQ_TYPE_EDGE_RISING>;
> > -	spi-max-frequency =3D <20000000>;
> > -	microchip,device-addr =3D <0>;
> > -	vref-supply =3D <&vref_reg>;
> > -	clocks =3D <&xtal>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp391=
1.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > new file mode 100644
> > index 000000000000..bfcf6a5fb44e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2019 Marcus Folkesson <marcus.folkesson@gmail.com>
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/bindings/iio/adc/microchip,mcp3911=
=2Eyaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Microchip MCP3911 Dual channel analog front end (ADC)
> > +
> > +maintainers:
> > +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> > +  - Kent Gustavsson <nedo80@gmail.com>
> > +
> > +description: |
> > +  Bindings for the Microchip MCP3911 Dual channel ADC device. Datashee=
t can be
> > +  found here: https://ww1.microchip.com/downloads/en/DeviceDoc/2000228=
6C.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,mcp3911
> > +
> > +  reg:
> > +    description: SPI chip select number for the device
>=20
> No need to describe common properties if you have nothing special for=20
> this device to say.
>=20

OK

> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    description: |
> > +      Definition as per Documentation/devicetree/bindings/spi/spi-bus.=
txt.
>=20
> Same here.
>=20
> > +    maximum: 20000000
> > +    maxItems: 1

Should I keep the maximum property?

>=20
> Not an array, so drop.
>=20
> > +
> > +  clocks:
> > +    description: Phandle and clock identifier for sampling clock
>=20
> Same comment on descriptions.
>=20

I describe it a little bit more. Thanks

> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: IRQ line of the ADC
> > +    maxItems: 1
> > +
> > +  microchip,device-addr:
> > +    description: Device address when multiple MCP3911 chips are presen=
t on the same SPI bus.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [0, 1, 2, 3]
> > +      - default: 0
> > +
> > +  vref-supply:
> > +    description: Phandle to the external reference voltage supply.
> > +    maxItems: 1
>=20
> Drop this *-supply is always 1 item.
>=20

OK

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      adc@0 {
> > +        compatible =3D "microchip,mcp3911";
> > +        reg =3D <0>;
> > +        interrupt-parent =3D <&gpio5>;
> > +        interrupts =3D <15 2>;
> > +        spi-max-frequency =3D <20000000>;
> > +        microchip,device-addr =3D <0>;
> > +        vref-supply =3D <&vref_reg>;
> > +        clocks =3D <&xtal>;
> > +      };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e51a68bf8ca8..fbccc9d450ff 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10723,7 +10723,7 @@ M:	Kent Gustavsson <kent@minoris.se>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/iio/adc/mcp3911.c
> > -F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
> > +F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> > =20
> >  MICROCHIP NAND DRIVER
> >  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> > --=20
> > 2.23.0
> >=20

Thanks,
Marcus Folkesson

