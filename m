Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DF2E85D9
	for <lists+linux-iio@lfdr.de>; Fri,  1 Jan 2021 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbhAAWy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Jan 2021 17:54:28 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:58166 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727147AbhAAWy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jan 2021 17:54:27 -0500
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jan 2021 17:54:25 EST
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 101MfaIc028160;
        Fri, 1 Jan 2021 22:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=28082020;
 bh=xpXNwzYa6dlyY+uvsPvL04IT4LHnpEb9aAZqxVnuYYk=;
 b=PiI3bXhan/VE3olBc1s7wV24Hx6F4POz3VRbNMGbZkrx5IZv+A/kKtIc/V5tiybIRl2O
 80pvC3hRMMi5y6F/qGVfFhHG56TQccpFnJVWrgYLc4xqNQo4FeVasRvVUz/uJEWP7ka7
 ZUUmsIfCZj5YOpoUa3m/P4XcdSsIKoSz1XIaOsr9OnnKxa/S7VGuWJA9+ateOllzeHua
 vtbzU/dvz0r/hsE5bOYihlKVrXafAyIyHx5Hufl6hFWP2xdbgTLB909rnx4oprHgEhbo
 Tgy+hom2TypPVFim+C8Jy9eP88M835wkrpS7zChv8KyX9Y1jQlwCUl6bDUMoJYT6bxCX Ow== 
Received: from atgrzso8132.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 35ppj3xr9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jan 2021 22:41:36 +0000
Received: from pps.filterd (atgrzso8132.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8132.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 101MfZa8010865;
        Fri, 1 Jan 2021 23:41:35 +0100
Received: from atgrzsw3764.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8132.avl01.avlcorp.lan with ESMTP id 35s8n70bef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jan 2021 23:41:35 +0100
Received: from atgrzsw3758.avl01.avlcorp.lan (10.37.149.11) by
 atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Fri, 1 Jan 2021 23:41:35 +0100
Received: from atgrzsw3758.avl01.avlcorp.lan ([fe80::1b:6a9e:8e32:d7f]) by
 atgrzsw3758.avl01.avlcorp.lan ([fe80::1b:6a9e:8e32:d7f%6]) with mapi id
 15.01.2044.012; Fri, 1 Jan 2021 23:41:35 +0100
From:   "Denis, Tomislav AVL DiTEST" <Tomislav.Denis@avl.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x
 ADC driver
Thread-Topic: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x
 ADC driver
Thread-Index: AQHWxPV40HuizBD+dUyQ+WMkqBA8zandauSAgDYipEA=
Date:   Fri, 1 Jan 2021 22:41:35 +0000
Message-ID: <60ea32f43ac4485db97684ad9a94cfbf@avl.com>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
        <20201127194240.15060-3-tomislav.denis@avl.com>
 <20201128123417.7259ef13@archlinux>
In-Reply-To: <20201128123417.7259ef13@archlinux>
Accept-Language: en-US, de-AT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.100.12]
x-exclaimer-md-config: f9e74532-fb7d-4806-8539-2b9574eafa9a
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-01_07:2020-12-31,2021-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101010143
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-01_07:2020-12-31,2021-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101010144
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for great review and hints that you gave me.
A few comments inline.

BR,

Tomislav

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 28 November 2020 13:34
> To: Denis, Tomislav AVL DiTEST <Tomislav.Denis@avl.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131=
E0x
> ADC driver
>=20
> On Fri, 27 Nov 2020 20:42:40 +0100
> <tomislav.denis@avl.com> wrote:
>=20
> > From: Tomislav Denis <tomislav.denis@avl.com>
> >
> > Add a device tree binding documentation for Texas Instruments
> > ADS131E0x ADC family driver.
> >
> > Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
> Hi Tomislav,
>=20
> A few comments inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 145
> +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 146 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> > b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> > new file mode 100644
> > index 0000000..92da193
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/adc/ti,
> > +ads131e08.yaml*__;Iw!!Oq50-tQ!_S4huPtQ7bwYwG-
> J3eOtmYscvX_TjlRfR7tjpa6
> > +d2dqUQ67RUNI9X1VKpsiphO1jsQ$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> > +aml*__;Iw!!Oq50-tQ!_S4huPtQ7bwYwG-
> J3eOtmYscvX_TjlRfR7tjpa6d2dqUQ67RUN
> > +I9X1VKpsi1XPH8nA$
> > +
> > +title: Texas Instruments ADS131E0x 4-, 6-, and 8-Channel ADCs
>=20
> Not currently supporting 6 channel variants?

It should be working without problem! But since I don't have HW to test I'v=
e left it out.=20

>=20
> > +
> > +maintainers:
> > +  - Tomislav Denis <tomislav.denis@avl.com>
> > +
> > +description: |
> > +  The ADS131E0x are a family of multichannel, simultaneous sampling,
> > +  24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> > +  built-in programmable gain amplifier (PGA), internal reference
> > +  and an onboard oscillator.
> > +  The communication with ADC chip is via the SPI bus (mode 1).
> > +
> > +
> > + https://urldefense.com/v3/__https://www.ti.com/lit/ds/symlink/ads131
> > + e08.pdf__;!!Oq50-tQ!_S4huPtQ7bwYwG-
> J3eOtmYscvX_TjlRfR7tjpa6d2dqUQ67R
> > + UNI9X1VKpsjgTd5HaA$
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads131e04
> > +      - ti,ads131e08
> > +
> > +  reg:
> > +    description: |
> > +      SPI chip select number
>=20
> That is entirely standard so no real need to put a description of reg for=
 an spi
> device.
>=20
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  clocks:
> > +    description: |
> > +      Device tree identifier to the clock source (2.048 MHz)
> > +      Note: clock source is selected using CLKSEL pin
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: adc-clk
> > +
> > +  interrupts:
> > +    description: |
> > +      IRQ line for the ADC data ready
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description: |
> > +      Optional external voltage reference. Has to be supplied, if
> > +      ti,vref-sel equals 2
> > +
> > +  ti,vref-sel:
> > +    description: |
> > +      Select the voltage reference source
> > +      Valid values are:
> > +      0: Internal reference 2.4V
> > +      1: Internal reference 4V
> > +      2: External reference source (vref-supply is required)
>=20
> With optional external references we normally just use their presense to =
indicate
> that they should be used.
>=20
> You'll still need a parameter to pick the internal reference though.
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2]
> > +    default: 0
> > +
> > +  ti,datarate:
> > +    description: |
> > +      ADC data rate in kSPS
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8, 16, 32, 64]
> > +    default: 1
>=20
> Why is this a devicetree element rather than runtime controllable?

Number of data bytes per channel depends on data rate. To be able to change=
 data rate=20
dynamically would require to change scan_type.realbits also dynamically! I =
am not sure
if that make sense and also if it is possible to do it?

>=20
> > +
> > +  ti,gain:
> > +    description: |
> > +      The gain value for the PGA function
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8, 12]
> > +    default: 1
>=20
> Isn't this per channel?  Also this explanation should mention why it is a=
 board
> related characteristic rather than a runtime tuneable (I'm fine with havi=
ng it here,
> but good to add a bit of info on that to the description).
>=20
> > +
> > +  ti,adc-channels:
> > +    description: |
> > +      List of single-ended channels muxed for this ADC
> > +      - 4 channels, numbered from 0 to 3 for ti,ads131e04
> > +      - 8 channels, numbered from 0 to 7 for ti,ads131e08
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> We've fairly recently introduced a generic adc channel binding that I'd p=
refer is
> used in drivers going forwards.
>=20
> See Documentation/device-tree/bindings/iio/adc.txt (or yaml if I've appli=
ed that
> patch before you get to this).
>=20
> That adds a subnode per channel and gives us an easy way to then provide =
per
> channel parameters.  It's heavier weight than what you have here, but muc=
h
> more flexible.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - spi-cpha
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - ti,adc-channels
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ti,ads131e04
> > +
> > +  - then:
> > +      properties:
> > +        ti,adc-channels:
> > +          minItems: 1
> > +          maxItems: 4
> > +          items:
> > +            minimum: 0
> > +            maximum: 3
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: ti,ads131e08
> > +
> > +  - then:
> > +      properties:
> > +        ti,adc-channels:
> > +          minItems: 1
> > +          maxItems: 8
> > +          items:
> > +            minimum: 0
> > +            maximum: 7
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spidev@0 {
> > +      compatible =3D "ti,ads131e08";
> > +      reg =3D <0>;
> > +      spi-max-frequency =3D <1000000>;
> > +      spi-cpha;
> > +      clocks =3D <&clk2048k>;
> > +      clock-names =3D "adc-clk";
> > +      interrupt-parent =3D <&gpio5>;
> > +      interrupts =3D <28 IRQ_TYPE_EDGE_FALLING>;
> > +      vref-supply =3D <&vref_reg>;
> > +      ti,vref-sel =3D <2>;
> > +      ti,datarate =3D <1>;
> > +      ti,gain =3D <1>;
> > +      ti,adc-channels =3D <0 1 2 3 4 5 6 7>;
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS index 28bc5f9..0c351c7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17224,6 +17224,7 @@ TI ADS131E0X ADC SERIES DRIVER
> >  M:	Tomislav Denis <tomislav.denis@avl.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
> >  F:	drivers/iio/adc/ti-ads131e08.c
> >
> >  TI AM437X VPFE DRIVER

