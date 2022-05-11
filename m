Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE3522C0E
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 08:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiEKGD6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 02:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbiEKGDy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 02:03:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2111.outbound.protection.outlook.com [40.107.114.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F5A6FD37;
        Tue, 10 May 2022 23:03:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHjYdUp/Dmy3/uiWpECkmdC7AF/FTtFNNooxhTM84nsCbHbWIW1Jy6ab9VsrB0TwKaQ0XPSIW99dYEgtDBLr/YYt4DPcPSssExEmMj4gdZKYir1fEoA31mLpk98vqLGO3W7EbUArCjhvb9/+4tRGaiJR3CHSvNSd/2zMdQopJ5W2XR43D85IO5iNHTCLMf3c+rVSlm09DKYI/2AmYML9TOrdd8t8PXhkGbPUDCyIzbgPjkFfrHgyn8K8JGuxyXXEiwfX9XMlgFNE+lP3MkaS/Wcz5b8rAxWG0E3UMTOckJJC2ZVTOWPX1c3XT/1sQuVbNFsCrV9aarFjjtnIi+Vm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESZ+GG7/Zo4Lu0UrRWvqjdsXoU0Jdd2VQoLSmWbh4iI=;
 b=J8lmZ9VsrZ4rxYxxSpvSLg2Evk0JpqM5MDtZfRPenA3iPiVFC54vXbFKQEXfyvVFY5xH9btpgm638dtoGNGlnSD/S47yh02DNASb0CCwYo8x9kjpookrr3LSqk/tLHj2vTrqAxCBv50b06k+eG4k608B9TRBY0OS6fuLNmL22hsW740sgFPsvfHVrIBPoGSztlsk6Qw9m/lf+8lYt6oNEoR5su5vA/BS44dzSp5Dj2jWT9R2eOCVz6OgbDJjmndi25ndFvCDMGg1WrqlvwysFAETUfvvUWKADFTBtugFoSk4e1lGt6CPVXf/bslv0vG0uWJCCnDxRi3YosCboivplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESZ+GG7/Zo4Lu0UrRWvqjdsXoU0Jdd2VQoLSmWbh4iI=;
 b=pfUt2tIluiYy6jicWLl7Yh29AeQHevCYy0SdV9uHVv/a5BTz8XLGe9AxGamzY90qKY8xEKiq6qkx4yygECZCl7em7eu6L+O5xEJVDxS4ciQhZwBrb/eJD6IKC0WBUnDnr6840OQqnznZDS10/E8PUE7wPu37YfxYRV6MDljvP0g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8745.jpnprd01.prod.outlook.com (2603:1096:604:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 06:03:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 06:03:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
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
Thread-Index: AQHYYK+lDsvUpPE0qE2rS+QRz8CKdq0RcTaAgAASxFCABQDbAIABHEGggACve4CAACORYIAAw64w
Date:   Wed, 11 May 2022 06:03:49 +0000
Message-ID: <OS0PR01MB592294F0DCC8CF4FB75BBC1086C89@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
 <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
 <CAMuHMdVV=MB8xa-Q-c_aZx9LGrW=9aP9iC3P-FMRSf-HiovOzA@mail.gmail.com>
 <OS0PR01MB59224E3B5A9E5D8FD5E55B2886C59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXDCDLhOSGgy9WWwawiHpE8C6isU2dLn6uSpY2gFAr38g@mail.gmail.com>
 <OS0PR01MB5922CD6D965A6138721F9A5886C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YnqPTQVUNADk/YO4@robh.at.kernel.org>
 <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59222568C4189A74FE83D6B186C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2ca41d-65b0-4bee-9bbe-08da331404c4
x-ms-traffictypediagnostic: OS3PR01MB8745:EE_
x-microsoft-antispam-prvs: <OS3PR01MB87454C186D83110D3A1F0E2B86C89@OS3PR01MB8745.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4j+Kkl0QbS2KcwkT6ycEsidCX7Dg3kQLsA6JvPquDx5yOp68iSdEGcnuhtCD+t71N6pQOzH5Nv+ERtMeGnqVJTGZVDNqNLbdExRA+mXQN/gZabfNFSpvYJnnm9GgS4hTzRlClG87AZ459gomdHjvtT07576pKShwktvsjN/nNf6zKE2jZ2ASg3iXbBSQv5USZEj2zbv+4X+5OBgUrFGHnegP4tk3u7BWQ4PhuaeJr/pZiCUezmh2n6tgEinRWxY4IDvPzaHf3qYjdWedG4taV7xiEeTK7iwpcc/MZXr9wCy4lAKz5gqIMqOVn/81L3N14E27AyrwcjA+Q7Urh5EOcrxeyWYZ5O8drhPuA8cK6yCizdR7q5L/eanmWygOI/JZhfnF0LEl1bab5cZB+FxMec0YayLc3utrscM+eQAdcjSofGz8w7RdMh/uD5HjMaRy44PN1lrTz1CfgPzkWOeos/Gvcq0zvArXTEWjkUDYePH3+fcVNJQh9TAamzx5nHRgCF0Pn97PrCvtU6dc6NCqgJSduksdoXGq+9jRIN3oB8Sw5hSrT5PARxHMlAwsEQ5NxjFsFcbyVxK4jOy7BTMRC8WPEvlMfSwpGMfzXL6+qMZd6bYB1JYuvF9rFQaM8FVCbOrMIiOWAvJ/OALyXddWfrxec6vLb5mTMFqflW56Mw1aSbuyQPLAaKHWOSbpT9tKRhskUCKRKtrEoWM1617J5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(71200400001)(54906003)(186003)(316002)(83380400001)(508600001)(8676002)(38100700002)(38070700005)(33656002)(107886003)(2906002)(110136005)(55016003)(5660300002)(4326008)(7696005)(9686003)(66476007)(66446008)(66946007)(66556008)(53546011)(52536014)(122000001)(6506007)(64756008)(8936002)(26005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2eYAvyeIGllkAzBpPQ7GcPt5JqpI4pYazvqoZNh0LG8fTEEze3wpmCw/G0B?=
 =?us-ascii?Q?ak371fjjKwJTU4gs9MvW43e0oNBnsgRkCpdqlslYiE8BL1xUQ1qVI1s2CwMr?=
 =?us-ascii?Q?kth6sRv6qUXNY4wETRAYvXEn/NHSqjv9YAYTYw8GRjX0noo0Npqzr5r2G62L?=
 =?us-ascii?Q?4DdCOubcEVgfPfRhVRs/HgUOEEImYYQ8OTW5j3TLLm3xSWfTvPIXxjLOHcLY?=
 =?us-ascii?Q?C4p2gIqUok70u5uGB1ZmBabYFzQM2/WmP3c+8CgeCdFdtSQMcpp/gvUH47y7?=
 =?us-ascii?Q?JJpqKuwcL85fio1QDM2RAqIYeZFJ60QhfQKbIIjvcUPxMFcN8mdgv2Rv6zVw?=
 =?us-ascii?Q?SoE7LUdU41H+3AsfU59743kchWEU5mXnKniaZnmQJjaBP7XtWchNz3q47TND?=
 =?us-ascii?Q?yktXNtCUTnK8iEGjRBn8/WIPAgI/UxSbQigoecW7ebWWMBNeSzfsLvneR56+?=
 =?us-ascii?Q?TBBSgOiyTQFat7CcaqyaWdOvaZh5uqLQaVBFC0hS7I1trlkPyfOTCraERCTZ?=
 =?us-ascii?Q?C2HK5FGDiiwcYuaJiMgrDb5tnPZu9Rxx2qqC7gvaamFI9tV745pKP2GSclss?=
 =?us-ascii?Q?V12k/keyGAjjEQuzgWVCMOqQ2lMBWPB5Vf4bfcQU5OVctCMVs38lS1peI+PP?=
 =?us-ascii?Q?KAp/OO2zSevbyA2KRd7uvTXaNUl81VyJcP8DIr2VcnxfaV30/rmB5Zy0zp/E?=
 =?us-ascii?Q?4P1L0b8KKZpmYI/zBqfEOA/KNGL91vq9q4/3AOoPSXJsbCAHzRLcptczVvlh?=
 =?us-ascii?Q?sxN4pPbAd46LVh+CfZdDBn5UswDO0uxtPGFyQceYcSBYsiVTh/cZu1Y9LWZH?=
 =?us-ascii?Q?iB9bxCmsBopbQhdmO5mnT3xnQ+KgVOV1XcLJekDDWYp1OU9UKHNj421I+ubT?=
 =?us-ascii?Q?Nnz10FtlegIp9MLZ5bwBCp9xlmCerS6Yib1BbssKWb2s5Tks8qmCNSOTaIh2?=
 =?us-ascii?Q?QsnhzW5HGqZxCCCJ+Wmzo0STZ4SD3cbP0OhHamxpf1EAj3cRn68YROB8Pt+G?=
 =?us-ascii?Q?t3pTIQhrzWrGfpSBqmhyWQpxwRSltU+HgrIxTXILCCEIdvybXh9cSFQ38k2Q?=
 =?us-ascii?Q?u7ncp5tnI45LlaYY6cRynFm9W+XuCkKSWu8EGn/FxcZ8HYAZQIGbU53zlkDB?=
 =?us-ascii?Q?PTan233BLY8S1vUI0Pvtw6BB7iiuB6/xPID4LJG9MP3zAlciRHjzxMTYkxX9?=
 =?us-ascii?Q?MLGy6AOIQW2IyjV2fGjtC+eDaLZDKOnkGJjUpiv8PDyOjDXccdj3+kXGGvOz?=
 =?us-ascii?Q?9dVytVg2Wj7I3PfqVfs2aC64WDtpGYQ1QjUFfaV31gKukoNHrCzRA73tohzi?=
 =?us-ascii?Q?nrtPJpVQkClO5tkQajMlE3n8iHmiCd/EngIpq2RepP2Fbt5NNEC9uNwg4f7Y?=
 =?us-ascii?Q?IJuIvqkFju+thPs4d+RZyvml5KMHpNMA6VO712c5/yN5MVHSkr5YjvGhRKqG?=
 =?us-ascii?Q?OJtHLtmv1DyeeP/T/RYNbFsnyGM4Y2VXl1LFQjK+SMbrUEwgK3OIN13aTeQk?=
 =?us-ascii?Q?jGL+Kio1URuAdbYCeKAkWXleaHJwXWsalAD4iGKxxvzA8t2Kug05JFXH4h5j?=
 =?us-ascii?Q?QMNACmm1vsD8Yl25JCjRrXv7STYB8SMw5SuusCL0PkyKFUCiOKpBgjvesNeK?=
 =?us-ascii?Q?vs4CfdmMNcivCD5WhfgFgkyG3VHgYPjcbp757qvsRyOgQmnl46Cj8Lg0WBmL?=
 =?us-ascii?Q?1m9I9KhFFDDR5NO2rK2Zw9qlY0x6y5cgwaLwuHzIckNVRq0FN28SgeAy5F2K?=
 =?us-ascii?Q?FnwQvI3SfytC9CaXXkcq6AVv8IS6Oso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2ca41d-65b0-4bee-9bbe-08da331404c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 06:03:49.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoR4mPHwFIjsbedHUtTFAWzTMZIUJyz/W7k4u0e6IBd9WXo+fW3YzhAIDqK7q+VSuT3IxSi63Ym/e5iu4SXiOKLmqcNo41gEkuLtTp4YW2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8745
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 10 May 2022 19:31
> To: Rob Herring <robh@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>; Jonathan Cameron
> <jic23@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Lars-Peter Clausen
> <lars@metafoo.de>; linux-iio@vger.kernel.org; Linux-Renesas <linux-renesa=
s-
> soc@vger.kernel.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
> BINDINGS <devicetree@vger.kernel.org>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das@bp.renesas.com>
> Subject: RE: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2=
UL
> ADC
>=20
> Hi Rob,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas
> > RZ/G2UL ADC
> >
> > On Tue, May 10, 2022 at 05:54:59AM +0000, Biju Das wrote:
> > > Hi Geert,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document
> > > > Renesas RZ/G2UL ADC
> > > >
> > > > Hi Biju,
> > > >
> > > > On Fri, May 6, 2022 at 10:40 AM Biju Das
> > > > <biju.das.jz@bp.renesas.com>
> > > > wrote:
> > > > > > Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Document
> > > > > > Renesas RZ/G2UL On Thu, May 5, 2022 at 8:40 PM Biju Das
> > > > <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost
> > > > > > > identical to RZ/G2L, but it has 2 analog input channels
> > > > > > > compared to 8 channels on the RZ/G2L.
> > > > > > >
> > > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc=
.
> > > > > > > yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2
> > > > > > > +++ l-
> > adc.
> > > > > > > +++ yaml
> > > > > > > @@ -74,18 +75,48 @@ patternProperties:
> > > > > > >        Represents the external channels which are connected
> > > > > > > to the
> > > > ADC.
> > > > > > >
> > > > > > >      properties:
> > > > > > > -      reg:
> > > > > > > -        description: |
> > > > > > > -          The channel number. It can have up to 8 channels
> > numbered
> > > > from
> > > > > > 0 to 7.
> > > > > > > -        items:
> > > > > > > -          - minimum: 0
> > > > > > > -            maximum: 7
> > > > > > > -
> > > > > > > +      reg: true
> > > > > > >      required:
> > > > > > >        - reg
> > > > > > >
> > > > > > >      additionalProperties: false
> > > > > > >
> > > > > > > +allOf:
> > > > > > > +  - if:
> > > > > > > +      properties:
> > > > > > > +        compatible:
> > > > > > > +          contains:
> > > > > > > +            const: renesas,r9a07g043-adc
> > > > > > > +    then:
> > > > > > > +      patternProperties:
> > > > > > > +        "^channel@[0-7]$":
> > > > > >
> > > > > > [0-1]
> > > > >
> > > > > Looks like with this change, validation doesn't work as expected.
> > > >
> > > > OK, keep it at [0-7].
> > >
> > > OK.
> > >
> > > >
> > > > > > > +          type: object
> > > > > > > +          properties:
> > > > > > > +            reg:
> > > > > > > +              description: |
> > > > > > > +                The channel number. It can have up to 2
> > > > > > > + channels
> > > > > > numbered from 0 to 1.
> > > > > > > +              items:
> > > > > > > +                - minimum: 0
> > > > > > > +                  maximum: 1
> > > > > > > +  - if:
> > > > > > > +      properties:
> > > > > > > +        compatible:
> > > > > > > +          contains:
> > > > > > > +            enum:
> > > > > > > +              - renesas,r9a07g044-adc
> > > > > > > +              - renesas,r9a07g054-adc
> > > > > > > +    then:
> > > > > > > +      patternProperties:
> > > > > > > +        "^channel@[0-7]$":
> > > > > > > +          type: object
> > > > > > > +          properties:
> > > > > > > +            reg:
> > > > > > > +              description: |
> > > > > > > +                The channel number. It can have up to 8
> > > > > > > + channels
> > > > > > numbered from 0 to 7.
> > > > > > > +              items:
> > > > > > > +                - minimum: 0
> > > > > > > +                  maximum: 7
> > > > > > > +
> > > > > > >  additionalProperties: false
> > > > > > >
> > > > > > >  examples:
> > > > > >
> > > > > > The rest LGTM, but I'm wondering if more of the channel
> > > > > > subnodes description can be factored out to the common part?
> > > > >
> > > > > You mean above reg: true?? ie, add as part of the below
> description??
> > > > >
> > > > > type: object
> > > > >     description: |
> > > > >       Represents the external channels which are connected to
> > > > > the
> > ADC.
> > > >
> > > > I think I've found a solution while converting the R-Car Gen2 USB
> > > > PHY bindings.  You can mark channels 3-7 false on RZ/G2UL, cfr.
> > > > the second channel on RZ/G1C in "[PATCH] dt-bindings:
> > >
> > > I just added similar check for RZ/G2UL by making channel@2-7 false
> > > and But dt-binding checks is passing with channel@2-7 present in the
> example.
> > Validation should fail, but it is passing. I will go with current
> > implementation, as it does proper validation.
> > >
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: renesas,r9a07g043-adc
> > > +  then:
> > > +    properties:
> > > +      channel@2: false
> > > +      channel@3: false
> > > +      channel@4: false
> > > +      channel@5: false
> > > +      channel@6: false
> > > +      channel@7: false
> >
> > patternProperties:
> >   '^channel@[2-7]$': false
>=20
> This fixes the validation for channels. But how do we restrict reg index
> between 0-1 ?
> The below example is passing instead of failing.
>       channel@0 {
>         reg =3D <5>;
>       };
>=20
> The Current implementation restricts both channel and reg to [0-1] for
> RZ/G2UL.

Looks like the below change is restricting both channel and reg to [0-1] fo=
r
RZ/G2UL. I will send next version based on this.

+        "^channel@[2-7]$": false
+        "^channel@[0-1]$":

Cheers,
Biju
