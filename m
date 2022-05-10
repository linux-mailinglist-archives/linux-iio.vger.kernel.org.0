Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01F520D5F
	for <lists+linux-iio@lfdr.de>; Tue, 10 May 2022 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiEJF7B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 May 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiEJF7A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2022 01:59:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237824F209;
        Mon,  9 May 2022 22:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnl37Rr+CVXKC4s6nEC4XD+6c3BVHTObptkpWuinVZv7Uk388tkvIVSaUOCVDSfVL1hX/RuHv7Qd2mEqKl+3/YMvzBVBTnx2Txr+LzMXJr2GrcnRZQgLriYr4HiEb7MQPLzd6mQx5K4lKq4g+b1aE/RqFlMRvwqtihQn4Hh4oTmKG4x9paEgDNwlV9i4AUlp6wy9SFeqfb6DqNlMcWBXYV7BxiNwr/RrbH03FsWg04iaulfvS/EID8Js2vMln4WRRFcsNGejwriKWOyelZH3ju2VCjg1GoyfOUC0C1ZUkQfQRrN9C8UrGXzZPOIrIHV9BXgxeZKyiHEB2FwyhPwaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTTD2C0SWuYn8oQ5K06h7uQze2oD5mLf9el3Ub/kbUM=;
 b=F+kOahxCT0tW2heFHPa6aMqlPs34koqzY4Py0+9Bty3AmA1ACgdVXGC2xmFMPF6BmZYK0/dN6elL+JC8cF20/7dK9wz0h167kpQR3Uepw9KmbJ8kvmPv8BxLBmDSrAlenmNMUKx5clJ2NaEQDXjTNx1iuMUebO24mcG4oaAZcS8cvrNpL2EgxDrbgwOJEqaBCFqEgkjtMy2tobVn788OzObit691dgseMvvM6WeWZS772R8cBDKbOyRlHacecD6HnrA4h8OHuvSNHyZOnTAV2RrJKZzQnpschlBBkm5fq+lhKqd9BeLe2G3YBAfoUY/4Chfw6MWDpstl1/fcqJrDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTTD2C0SWuYn8oQ5K06h7uQze2oD5mLf9el3Ub/kbUM=;
 b=f3sz+YuIURI5mioEmLnjlQ4CuokLJbg0SbEjDYfyCz7l3FU4Eg386jMnAb1SJDp/p3Asj8HQYhAceVyhsz/Lgj+2Fdy7jQ6jDiOYHw4T5bBMXZbTDhsPmYi3LOvgtvGKkOTESzqsPN654HbsuYdQV10z2xvNPsEPharm+ghw8k4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9517.jpnprd01.prod.outlook.com (2603:1096:604:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 05:55:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 05:55:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL
 ADC
Thread-Index: AQHYYK+lDsvUpPE0qE2rS+QRz8CKdq0RcTaAgAASxFCABQDbAIABHEGg
Date:   Tue, 10 May 2022 05:54:59 +0000
Message-ID: <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
In-Reply-To: <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f3c80a-8051-4c73-f259-08da32499e85
x-ms-traffictypediagnostic: OSZPR01MB9517:EE_
x-microsoft-antispam-prvs: <OSZPR01MB951703B9DD263F5F56467FC186C99@OSZPR01MB9517.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oANwAHEPYQK3rtwdjgduWVzHvkRTg2IHa3hGJ/k2krH9onJjktwwTWhgDdcaMhFo1NjGNviKwlxOfTcK82Gs5jmYCqqRSl6clnBwxB1+wDWt9fXmh1qzwtkx3SgGyeqjQ3N78mdbvbuIsBwJCXBVQYUZYtE0fWEpT51PAohV8r9xg7nmO0HrVbVI6pZcSvUoY3zeb8sFz7OKsLSZiw/eVV/r20zPERbOIpawA+Fndp91DMfzalLnvlJdNV/JmxHpgukSgBtWkJzsNmm+VL748nsdiQQFdEvqMQVMe+Y1yujmvwIRfQj2OGFlNWjWxt+hMt115vzPgrmN15YwYAiMuo1wrB8TPDzeP+cju6v51n0JOlOBGBb8Vma2vp3BsiTyk51m14IvPb68lv4ruE2vM+Ahr5Y5+nuHtv0kHFGQpFlGTRUWITZEJgeIp37C1DpyH1IsMtLVK2H6J2v3jiGIOrDgpSunLZpqSSAUx0MwVC/9bi4dCtaMO7fI5ze6JWxFDCgkgDuMzhnFxCuSV8QSVkts2M1ZHENTmX2dC0nEdpDRViiVK094MVKtT/MfYd72OT/HRt8vd61CDW8+570P4JoMMG0dcCNCD31PSxc5QqJYUc4CwgoST2MK6fj15rIvKvhYPKpts9tTwwWF/OKIn9Y9h9S+61HVXsyj0uUFWNIX/+OiPAExC+WiITX9TlmgWwqAJvRYET63acjlNe3cdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(66476007)(64756008)(76116006)(66946007)(316002)(66446008)(55016003)(66556008)(2906002)(26005)(186003)(7696005)(54906003)(8676002)(4326008)(71200400001)(6916009)(86362001)(38100700002)(122000001)(33656002)(52536014)(8936002)(6506007)(38070700005)(83380400001)(107886003)(53546011)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFEtx2/5dHqq9iqu+e+8PekDTztDQXHSJnJfCwpIpf2kWG02O3iG6QhyvCTH?=
 =?us-ascii?Q?6upCO6TPSGpMHfrUI0kgcwy8TpumvF6eVCTuwooOvJahm1QE7JHNS7lPSm6g?=
 =?us-ascii?Q?8jytbc+f9l+0QYukSE//SLW/pjdYHjVNybECmyBQRHpLb/xq2wsQLPXCJdex?=
 =?us-ascii?Q?33EViJ3BmA499XM5HxKyxs6GMz8jSWOB/38lz6HLYOZe8cWpTobxX2t3VpT8?=
 =?us-ascii?Q?0EvQ9Gd3CK7ZNvZoCpSaCa2bJ1VWtkNW+XqBUQbiiS+tsDdU21MJLjBDFFSZ?=
 =?us-ascii?Q?OWOksyUJixG/hlnAAWNx5IvP5haIZNVna6HUZ/3rBbK1+ci6zVe4eBwPAQGP?=
 =?us-ascii?Q?Umw1HI4J9rvXmKcEe5Vhii/AiiiD/CgV9wrpzHeGQKNlzexNHy+RVXm3uet2?=
 =?us-ascii?Q?sIiuW+OmVOQsjTq8D5BcmII4OgARr+9m91Cy5/8G1NZUnGNeth7xV52oD5Sa?=
 =?us-ascii?Q?I67KHSIe32QAHJ7Sz6/35A3m3xQWVt0zFnDOkpvrdnooshZ4IhEZO+Z2L3FY?=
 =?us-ascii?Q?stM7OlVI+FCFjc1EVHgzpg1mQwjvBHt+YY7vPwrGOwaoNZ7Z42gt5V34PK7G?=
 =?us-ascii?Q?EOaYGxJI7DuzS1C4LsOJ3QISd6V65R2uneUz/Q3exvmazIUlZ85zbhm5VC6g?=
 =?us-ascii?Q?aZdAREPfWOzQpHfoTOd0ElVcalS0FcsjGeYqWugvX2QKQoq34nWrUC5C8lpW?=
 =?us-ascii?Q?ZyXaxh8eb4kfgO8Mj+54LgMDt29GlAqsJ+olkoEbVcwuF/wQb5ThEiyC0gsh?=
 =?us-ascii?Q?nN3HtpNJv9ewVzbTO/gVTrh/JQjh85YhW78gv8PmWjnxl7PkrDd5SO3Nfwrf?=
 =?us-ascii?Q?Vpn+2Vm0vQekofOQKX7clnMbFb/CPxt0B3e71MjQCjkF5WvXahSxYgI+Kpco?=
 =?us-ascii?Q?kY/wwKnggx7mw39em4i5u9xCdj+0QNfhu9L7m+XilKjS58j0oXJJH9buWxN5?=
 =?us-ascii?Q?uWhCYN3DVVbca2zQ5oBWcc69iAzx3ODxQuW76O7/tj80K57sqglT0Bgy/lH0?=
 =?us-ascii?Q?eQ4eePtANUD35bRROzRkXtpFnrliqDGoRyqVXYjmWDFdoocmSwaxxZZmIlv9?=
 =?us-ascii?Q?EFx5R3DeJl2CPE8F7G5u6rAADvoAorhfagzO1hK+GaTwIuCAKChHes/zwgyB?=
 =?us-ascii?Q?qPaAVSq7k+ZwvuUDYjCVANAZKNRHe4aLbsCw6juVQ0TTqVYt4il8fZGB3IBK?=
 =?us-ascii?Q?UB9LrmZFWWYnfAXv57MBn1/naEYIG4PN/9t4Wdv/9dDFaCM+zh5zz8Rzwv5j?=
 =?us-ascii?Q?9gIHDIVWBQdb24jsUGYxnxM9fa5tnM8eI5el7vdIX+AWKXjh9AzMSsddRTj0?=
 =?us-ascii?Q?ernp4zzJUB7MgYljjaGME5npFLXHoRwwiPOuvI0+g1IEhEOZpibBwwf5HteT?=
 =?us-ascii?Q?khrMn4ucZ5XJV3jhrCva75onWjEufxqQMYxH3BDDf95w71V+dcp5fsHTY0ZS?=
 =?us-ascii?Q?3sOYO71f6/27z+Vr3ritGvA6inFKw92KFEWWel8Gwux2zwRccI4bN8OEro9U?=
 =?us-ascii?Q?Gqt9mLLL4mY/CWO01VHGAUe75sM92ydW2Bbhjl7yU+t/5EjjZ05HReghBu2p?=
 =?us-ascii?Q?5jYzZAX3FtD0WaduNBHCeNhce5kcQAvn7ZOCf2zsJOZOHa+stY0Rzj5wEeWx?=
 =?us-ascii?Q?cswnCeSd1TaOD/HFuqZIgLd6ZCyTTIkROjtq6vF42b2otaSHTqCu7e7745Iq?=
 =?us-ascii?Q?NSH3cYAefaX+jTqg5PaAh/MxBmVJ5Ea9GiUlXqSb9vq4OtZ2w0jUsAKkNwzw?=
 =?us-ascii?Q?3aBdXoi50Wu82je+KPcNadoQLGRzAks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f3c80a-8051-4c73-f259-08da32499e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 05:54:59.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+nrAdX+/NB657LbopNMcfhKEu90cAQ4XHdq0QoN9LW7bcYXE4CmPTDr1t+a30OnWcx4cSDKh4j/jHQPMzxyIlTGFdXzWJOgrKR/5BBTIII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9517
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2=
UL
> ADC
>=20
> Hi Biju,
>=20
> On Fri, May 6, 2022 at 10:40 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas
> > > RZ/G2UL On Thu, May 5, 2022 at 8:40 PM Biju Das
> <biju.das.jz@bp.renesas.com> wrote:
> > > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost
> > > > identical to RZ/G2L, but it has 2 analog input channels compared
> > > > to 8 channels on the RZ/G2L.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> > > > ---
> > > > a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.
> > > > +++ yaml
> > > > @@ -74,18 +75,48 @@ patternProperties:
> > > >        Represents the external channels which are connected to the
> ADC.
> > > >
> > > >      properties:
> > > > -      reg:
> > > > -        description: |
> > > > -          The channel number. It can have up to 8 channels numbere=
d
> from
> > > 0 to 7.
> > > > -        items:
> > > > -          - minimum: 0
> > > > -            maximum: 7
> > > > -
> > > > +      reg: true
> > > >      required:
> > > >        - reg
> > > >
> > > >      additionalProperties: false
> > > >
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: renesas,r9a07g043-adc
> > > > +    then:
> > > > +      patternProperties:
> > > > +        "^channel@[0-7]$":
> > >
> > > [0-1]
> >
> > Looks like with this change, validation doesn't work as expected.
>=20
> OK, keep it at [0-7].

OK.

>=20
> > > > +          type: object
> > > > +          properties:
> > > > +            reg:
> > > > +              description: |
> > > > +                The channel number. It can have up to 2 channels
> > > numbered from 0 to 1.
> > > > +              items:
> > > > +                - minimum: 0
> > > > +                  maximum: 1
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - renesas,r9a07g044-adc
> > > > +              - renesas,r9a07g054-adc
> > > > +    then:
> > > > +      patternProperties:
> > > > +        "^channel@[0-7]$":
> > > > +          type: object
> > > > +          properties:
> > > > +            reg:
> > > > +              description: |
> > > > +                The channel number. It can have up to 8 channels
> > > numbered from 0 to 7.
> > > > +              items:
> > > > +                - minimum: 0
> > > > +                  maximum: 7
> > > > +
> > > >  additionalProperties: false
> > > >
> > > >  examples:
> > >
> > > The rest LGTM, but I'm wondering if more of the channel subnodes
> > > description can be factored out to the common part?
> >
> > You mean above reg: true?? ie, add as part of the below description??
> >
> > type: object
> >     description: |
> >       Represents the external channels which are connected to the ADC.
>=20
> I think I've found a solution while converting the R-Car Gen2 USB PHY
> bindings.  You can mark channels 3-7 false on RZ/G2UL, cfr. the second
> channel on RZ/G1C in "[PATCH] dt-bindings:

I just added similar check for RZ/G2UL by making channel@2-7 false and But =
dt-binding checks is passing
with channel@2-7 present in the example. Validation should fail, but it is =
passing. I will go with current implementation, as it does proper validatio=
n.

+if:
+  properties:
+    compatible:
+      contains:
+        const: renesas,r9a07g043-adc
+  then:
+    properties:
+      channel@2: false
+      channel@3: false
+      channel@4: false
+      channel@5: false
+      channel@6: false
+      channel@7: false
=20
 additionalProperties: false
=20
@@ -125,7 +105,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
     adc: adc@10059000 {
-      compatible =3D "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
+      compatible =3D "renesas,r9a07g043-adc", "renesas,rzg2l-adc";

$ make ARCH=3Darm64 DT_CHECKER_FLAGS=3D-m DT_SCHEMA_FILES=3DDocumentation/d=
evicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml CROSS_COMPILE=3D~/gcc-arm=
-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu- dt_=
binding_check -j8
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.examp=
le.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.examp=
le.dtb
  CHECK   Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.examp=
le.dtb

Cheers,
Biju

