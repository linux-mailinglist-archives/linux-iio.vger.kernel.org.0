Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BD2AEB4
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 08:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfE0G3R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 02:29:17 -0400
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:52175
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfE0G3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 May 2019 02:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wY0WrsI615sEZcihf/3X8BbpJgThopGPIRtwmBnNwM=;
 b=AjZJd2QzuCrnB/7BLGT0iwJAqR8NyuaE5yvrcG2ZhSQBQQMbV9NjlgJrrrICAYCsyy6h0c2yDF+FESUZifwVKzZA0GmWjsAvOWhpzDDgcl9C4b1Eh9gyWJbAWW2aQfGtV5p/i+wl4nSkxn1t2B6sofNh8E+bL87ifnEDY8LkrZo=
Received: from BN3PR0301MB0897.namprd03.prod.outlook.com (10.160.156.14) by
 BN3PR0301MB0882.namprd03.prod.outlook.com (10.160.155.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.23; Mon, 27 May 2019 06:29:12 +0000
Received: from BN3PR0301MB0897.namprd03.prod.outlook.com
 ([fe80::15cb:dfcc:c2a0:b950]) by BN3PR0301MB0897.namprd03.prod.outlook.com
 ([fe80::15cb:dfcc:c2a0:b950%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 06:29:12 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Renato Lui Geh <renatogeh@gmail.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml
 binding
Thread-Index: AQHVEpjqxVu70i5+Hk68EKl5wZYIFKZ9neWAgADnlsA=
Date:   Mon, 27 May 2019 06:29:12 +0000
Message-ID: <BN3PR0301MB0897E42E948C8067DABFF9858E1D0@BN3PR0301MB0897.namprd03.prod.outlook.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
        <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
 <20190526173911.57ae3d11@archlinux>
In-Reply-To: <20190526173911.57ae3d11@archlinux>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.Hennerich@analog.com; 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7158220-6c05-49e6-3fcb-08d6e26ca268
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN3PR0301MB0882;
x-ms-traffictypediagnostic: BN3PR0301MB0882:
x-ms-exchange-purlcount: 6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0301MB088249B58679A19231E988F68E1D0@BN3PR0301MB0882.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(13464003)(189003)(199004)(316002)(14454004)(86362001)(74316002)(305945005)(6436002)(6246003)(55016002)(33656002)(6306002)(52536014)(186003)(5660300002)(53936002)(7736002)(2906002)(110136005)(14444005)(256004)(26005)(53376002)(54906003)(6506007)(53546011)(9686003)(4326008)(25786009)(966005)(8936002)(486006)(3846002)(229853002)(76176011)(478600001)(76116006)(66946007)(66476007)(73956011)(81166006)(71190400001)(71200400001)(8676002)(68736007)(66556008)(66066001)(99286004)(72206003)(81156014)(476003)(102836004)(11346002)(6116002)(446003)(7696005)(66446008)(64756008)(7416002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB0882;H:BN3PR0301MB0897.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fi9aga58FwNAGVKu//toj5btl11VLQljKYxTXbWnzIrr+GbxFQ4A/y9KiWG3Tpycg3qYXI+gZnAaS8C0JXlyTkrLWs3Kr9Vew9jKZbhcZ8S6IDxi0T5scHX8KPBxW0gf/XvlXrXLxSraBESopo2LUyaQG8ganeK5U93RR7H+/1ClRRzz+WL3lJ1j2+GIMyKi28BdqXsj7ARfemiLqb2TpUpsrRk7o0DPlhLKzeZsMKmPbqhlq0/ES9bOfjIwJiyR/jNlGo0iBMzPHgJhH0bGyQMHw099ZMkTfiALCeNaOUvu06eHvQ2QKbIki8GymuGVAjFrunYgqdCz/H7UOCOUgkQtJ3efi43XjoqA9X5Lptli/+T0yl9jA9w8NX9quzhV94DjNDS2u6U+nYPawlqlYlWNlIg4GnCxL2rtxwEqyng=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7158220-6c05-49e6-3fcb-08d6e26ca268
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 06:29:12.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Michael.Hennerich@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB0882
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Sonntag, 26. Mai 2019 18:39
> To: Renato Lui Geh <renatogeh@gmail.com>
> Cc: lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>; k=
naack.h@gmx.de; pmeerw@pmeerw.net;
> gregkh@linuxfoundation.org; Popa, Stefan Serban <StefanSerban.Popa@analog=
.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>; robh+dt@kernel.org; mark.rutland@arm.com=
; linux-iio@vger.kernel.org;
> devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; kernel-usp@goog=
legroups.com; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml bi=
nding
>=20
> On Fri, 24 May 2019 22:26:30 -0300
> Renato Lui Geh <renatogeh@gmail.com> wrote:
>=20
> > This patch adds a YAML binding for the Analog Devices AD7780/1 and
> > AD7170/1 analog-to-digital converters.
> >
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> Looks good to me, but I'm still finding my feet with these so will
> leave it for a few days for others to have time to comment.
>=20
> Michael, looking for a quick reply from you to say if you are happy
> being explicitly listed as maintainer for this one, or if you'd
> rather land it on someone else.  Same applies for patch 2.

Hi Jonathan,

Listing me as an maintainer is ok.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>


>=20
> Renato, if I seem to have forgotten this in a week or so, feel
> free to give me a poke. I've been known to loose patches entirely!
>=20
> Thanks,
>=20
> Jonathan
> > ---
> > Changes in v2:
> >  - vref-supply to avdd-supply
> >  - remove avdd-supply from required list
> >  - include adc block in an spi block
> >
> >  .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
> >  .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
> >  2 files changed, 87 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad778=
0.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad778=
0.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b=
/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > deleted file mode 100644
> > index 440e52555349..000000000000
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> > +++ /dev/null
> > @@ -1,48 +0,0 @@
> > -* Analog Devices AD7170/AD7171/AD7780/AD7781
> > -
> > -Data sheets:
> > -
> > -- AD7170:
> > -     * https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7170.pdf
> > -- AD7171:
> > -     * https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7171.pdf
> > -- AD7780:
> > -     * https://www.analog.com/media/en/technical-documentation/data-sh=
eets/ad7780.pdf
> > -- AD7781:
> > -     * https://www.analog.com/media/en/technical-documentation/data-sh=
eets/AD7781.pdf
> > -
> > -Required properties:
> > -
> > -- compatible: should be one of
> > -     * "adi,ad7170"
> > -     * "adi,ad7171"
> > -     * "adi,ad7780"
> > -     * "adi,ad7781"
> > -- reg: spi chip select number for the device
> > -- vref-supply: the regulator supply for the ADC reference voltage
> > -
> > -Optional properties:
> > -
> > -- powerdown-gpios:  must be the device tree identifier of the PDRST pi=
n. If
> > -                 specified, it will be asserted during driver probe. A=
s the
> > -                 line is active high, it should be marked GPIO_ACTIVE_=
HIGH.
> > -- adi,gain-gpios:   must be the device tree identifier of the GAIN pin=
. Only for
> > -                 the ad778x chips. If specified, it will be asserted d=
uring
> > -                 driver probe. As the line is active low, it should be=
 marked
> > -                 GPIO_ACTIVE_LOW.
> > -- adi,filter-gpios: must be the device tree identifier of the FILTER p=
in. Only
> > -                 for the ad778x chips. If specified, it will be assert=
ed
> > -                 during driver probe. As the line is active low, it sh=
ould be
> > -                 marked GPIO_ACTIVE_LOW.
> > -
> > -Example:
> > -
> > -adc@0 {
> > -     compatible =3D  "adi,ad7780";
> > -     reg =3D         <0>;
> > -     vref-supply =3D <&vdd_supply>
> > -
> > -     powerdown-gpios  =3D <&gpio 12 GPIO_ACTIVE_HIGH>;
> > -     adi,gain-gpios   =3D <&gpio  5 GPIO_ACTIVE_LOW>;
> > -     adi,filter-gpios =3D <&gpio 15 GPIO_ACTIVE_LOW>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > new file mode 100644
> > index 000000000000..d1109416963c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital co=
nverters
> > +
> > +maintainers:
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +
> > +description: |
> > +  The ad7780 is a sigma-delta analog to digital converter. This driver=
 provides
> > +  reading voltage values and status bits from both the ad778x and ad71=
7x series.
> > +  Its interface also allows writing on the FILTER and GAIN GPIO pins o=
n the
> > +  ad778x.
> > +
> > +  Specifications on the converters can be found at:
> > +    AD7170:
> > +      https://www.analog.com/media/en/technical-documentation/data-she=
ets/AD7170.pdf
> > +    AD7171:
> > +      https://www.analog.com/media/en/technical-documentation/data-she=
ets/AD7171.pdf
> > +    AD7780:
> > +      https://www.analog.com/media/en/technical-documentation/data-she=
ets/ad7780.pdf
> > +    AD7781:
> > +      https://www.analog.com/media/en/technical-documentation/data-she=
ets/AD7781.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7170
> > +      - adi,ad7171
> > +      - adi,ad7780
> > +      - adi,ad7781
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description:
> > +      The regulator supply for the ADC reference voltage.
> > +    maxItems: 1
> > +
> > +  powerdown-gpios:
> > +    description:
> > +      Must be the device tree identifier of the PDRST pin. If
> > +      specified, it will be asserted during driver probe. As the
> > +      line is active high, it should be marked GPIO_ACTIVE_HIGH.
> > +    maxItems: 1
> > +
> > +  adi,gain-gpios:
> > +    description:
> > +      Must be the device tree identifier of the GAIN pin. Only for
> > +      the ad778x chips. If specified, it will be asserted during
> > +      driver probe. As the line is active low, it should be marked
> > +      GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  adi,filter-gpios:
> > +    description:
> > +      Must be the device tree identifier of the FILTER pin. Only
> > +      for the ad778x chips. If specified, it will be asserted
> > +      during driver probe. As the line is active low, it should be
> > +      marked GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@0 {
> > +            compatible =3D "adi,ad7780";
> > +            reg =3D <0>;
> > +
> > +            avdd-supply      =3D <&vdd_supply>;
> > +            powerdown-gpios  =3D <&gpio0 12 GPIO_ACTIVE_HIGH>;
> > +            adi,gain-gpios   =3D <&gpio1  5 GPIO_ACTIVE_LOW>;
> > +            adi,filter-gpios =3D <&gpio2 15 GPIO_ACTIVE_LOW>;
> > +        };
> > +    };

