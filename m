Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9859859955C
	for <lists+linux-iio@lfdr.de>; Fri, 19 Aug 2022 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiHSGcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Aug 2022 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHSGcw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2022 02:32:52 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7CD0745
        for <linux-iio@vger.kernel.org>; Thu, 18 Aug 2022 23:32:51 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J43OTB021444;
        Fri, 19 Aug 2022 02:32:47 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j0qt8asut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 02:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls3iJsPtozhWnHctFmsGL215GRVg78Mn0VYFZTpTiOjLpAIZHI3FzrmQJiGE1JYSK0iiR78ZxucGGsMhyLTalu0PEW8Ylqk9OWHyCqMeoI38Ptxirn1YCOU4PvSRG76Zxp4Feavh9TR2gcLbwIxyjKq+jK37ibLJUq+A4h1GKEi3wXbA/ahakZRDVsVh28em017riE31fEQ7FCR7wRxiyTesKSnwA+F5sy4Wg/3Q8n6DRNnoNVLxV6IsCVvutu0UQMndjehs1LZ9LVaGrLUBAIDhu1xg59M7lGO8PWTSr73Ii9X3pwzdFDKjc/jmFO+J/TxzhrshJRWlJ5QkDjMsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE9EWBi3Al6ardVpr2hUzDzQv8JVj2A9CGNg7BfvnIg=;
 b=kqBope+CRvSWC/Df/kCViyNq5TiDQ9cfCn60FO/U5P84hzC7qqbeTwmPYxfJnGXDWL99mbasipb7IVJAAbuDqUVIDBVi/jVK/u6mwsDNfKoHl6+8d3HtVmdANKO6Bz5Xyn+OIXkpZd8/jR0y3OvXB7Nr60jm4eLgnqurJKIx2UAA/sC/2jYw2cecowYPZICMEL4yjrdsE19UgM2oOccpSRgl2E8wpLJBN5kgZkGotwdIVfLvcMaOdMl1UkNYUIBLi/5KnAdIeXOFhrPrYGBKRV7o7lFyvA5DRVY6NxLcXqzb73l2QbYs1IPMld2BHi2ufHyvtAHijlsZZlQcDFbKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE9EWBi3Al6ardVpr2hUzDzQv8JVj2A9CGNg7BfvnIg=;
 b=RurlICTrRk+9Vrh1SNYp+1mkDzIBoWhn1Zef8d2Mmhc713FGL1BB1yJ31BudAZ0fUJXgTu9TNXvYUigPoLJhqRVzA0O9Fv8k7r2/MyRRn2daQYVsznRiFQv6WAcw1zx74EGeLXWL5lO/2PUwe4mzn3gcHYZSBXqjppiPst/DONU=
Received: from MN2PR03MB4751.namprd03.prod.outlook.com (2603:10b6:208:106::18)
 by SN4PR03MB6749.namprd03.prod.outlook.com (2603:10b6:806:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 06:32:43 +0000
Received: from MN2PR03MB4751.namprd03.prod.outlook.com
 ([fe80::5ced:3f65:bfb7:55cd]) by MN2PR03MB4751.namprd03.prod.outlook.com
 ([fe80::5ced:3f65:bfb7:55cd%4]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 06:32:43 +0000
From:   "Bolucu, Nurettin" <Nurettin.Bolucu@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v3 2/2] dt-bindings: iio: adc: add adi,max11410.yaml
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: adc: add adi,max11410.yaml
Thread-Index: AQHYrYhKATSSj5XrPEOOhY5dcbyjdq2ukZoAgAc8ajA=
Date:   Fri, 19 Aug 2022 06:32:42 +0000
Message-ID: <MN2PR03MB47518AF619C17F5FB2F32333986C9@MN2PR03MB4751.namprd03.prod.outlook.com>
References: <20220811134243.111-1-Ibrahim.Tilki@analog.com>
        <20220811134243.111-3-Ibrahim.Tilki@analog.com>
 <20220814165554.4dabd716@jic23-huawei>
In-Reply-To: <20220814165554.4dabd716@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58cfda6f-e544-4fe8-5efe-08da81ac9f12
x-ms-traffictypediagnostic: SN4PR03MB6749:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlc1v69FGoxK1mBR5ppnjbh20bjsDQSYzV+3dsdlU0kPKLTabiwwkAsuAsnAQQwxJDs1LdO2Tq0T3F3ZFLf0qlcLCfdphJJCF3T2ZezybLZUMNvE71P98+vyy/IKKek5TmEEVv3qJHrFAeokJypFMbMa4YH+JYEepbQLc6tqNZaks9re8v8TB7Cuc3MPGIatMmf2X33cG64QpKXLq95YIH6R9U6c/2dd3ufq7PA7RXDWmZkEo07b2VGkIS2UFi2hge3GKIpJnBDK8VdP4/zeVhXSdiKsnunW2xyoqTfFVJHTKhE0MD3PnQItKJ7zGyz79bXE12+p4qQvlQ/RyBZCuiknZZ9LC0WeR4Ym3o53g20HGqD2Tl7WmXYepHx8WrIOfwbgQNAQyFoa7HOSfxqSq9UHwGsjVrRcQ0jJC5Y27LouPCGhC3qSzjKnN08VNTJEDOFZZ8SNpF0x2uxseiFOg7bfdBktcANqyG1+BcfGrFvAkmqNkbvTawxRYAYkMwG0ZQ92B986FqdMFKR+tBiyuODG1pJelDVZJAy3Gdk4Q6gl7+2CwLpApJ8FhdlgKRa/+7+b6e4HPpZe62NJzSalzQQ9UZL/hHb2BJ5rbFJ4e2EOGlbhOPsJep6ZPze08m4SBMJ7kwfZHnPKw3ZC8ODAbaWJI+b3RerINSRD2uGU3Cc+0dX0OBuTVkTx656HyFxXLUBohM1AG5CEeoidKn7gO7Eu+WghjwAdPCQ3vEtyc0OVnHrgbIf9nytIma1CNr48Shj0yOjrKwFyJoWyZTlFc6mCuRU4auAsmyRKFv0fH+lV1Z+ZaRcwPLpzhn6bHcqmbDlfKRakP/RrsCN01ykBZMN6d5KTrouDuBEl3tbDPw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4751.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(966005)(53546011)(76116006)(66556008)(33656002)(66446008)(66476007)(478600001)(64756008)(7696005)(8676002)(38070700005)(40140700001)(66946007)(2906002)(41300700001)(107886003)(86362001)(9686003)(52536014)(186003)(26005)(4326008)(5660300002)(8936002)(54906003)(110136005)(6506007)(6636002)(316002)(38100700002)(55016003)(83380400001)(122000001)(71200400001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qEBw3vHocw7nD+TBYYlthTysJ3ihOCEm7n2xEBs+az6R9YOyJzAHGqfIQl?=
 =?iso-8859-1?Q?HjbyzAQG9dlOoRTGqTzf7QXIKIj1TNYYjq5cPIWmqN+KyX/fFi5Q+XxJ+3?=
 =?iso-8859-1?Q?hMEMy7e3mOfrvRrUtIC6WMdTJrPmSjYIZDwH+U+H8c8xTnSmi3aMzHa1ua?=
 =?iso-8859-1?Q?QrG9rYWsv5DCF2m2P8D0cYmHFcr7C7n4qPFAyQ6TzqhZhI4Ewglw9TYTKT?=
 =?iso-8859-1?Q?eWVvTuLQqu7o8QD+1SxHqkXC+KslnrE8Q1yjSOh4G3J5dXvvwBXbgZ9Epx?=
 =?iso-8859-1?Q?rDU2wQt0SG1NTUSewW0AePdvHNo0g79Yyq84EOK525TJh+t8DP/XFPF1gE?=
 =?iso-8859-1?Q?ceLZzs6AmpkV79cXTiEdJtZ8mkqOA7ULq0TJA+dBlIf4Zrl5zqVpdE7jhZ?=
 =?iso-8859-1?Q?ZjperMAQp/5fADnPlEsdO2iMlcu+maEREWV6fbbMwMCQHpUYGKuL7z7vw8?=
 =?iso-8859-1?Q?v5C8ZUsX/rq0x99gZzlTTgKSVMASGmlv++Y09P1HdfjQpv/OiihkEbCwgT?=
 =?iso-8859-1?Q?CxXTWK6wVJPyKBqo5No37KDdxCMj0k8e5ItWLSWTq/T9EIe0SlQEWHGKLx?=
 =?iso-8859-1?Q?yk/6UAA2kg31/k8EjODPddrOFaUncFt+/BgL7C6nGE9+xzmcfChHZSpCM4?=
 =?iso-8859-1?Q?JaAmGsitfDTpuWyPkqwFZ363mHSGFsSzr7rXJiyIc61RbO2fzIVLJBL0Mm?=
 =?iso-8859-1?Q?g4jwHweu+A3aYOfSgSPouU8hzaH5yFDIaNocXTLWnqo/fTB5gjZYK0Eolf?=
 =?iso-8859-1?Q?b73bOiXZ/tNMKQf9DKW3vtpENqZIz9TgMCs8YoMX2cu2N6T4TtgLJn6HSA?=
 =?iso-8859-1?Q?eKoqOOEQQ+UzgiVUakwS3Jr+otjjulHyPFkCeKxNUG+BmS2pob9BvU+qLR?=
 =?iso-8859-1?Q?k4ahbu5fKa9fpGoSQ89mBIshHsmeYMLXprmwiBtGNNSD4WBdK1NpTMSu9U?=
 =?iso-8859-1?Q?C4dNZFMOMNTpT5ydnt6CuUsW4UZPd4GJL0GUXCsq1eIu56T7rucddj37sG?=
 =?iso-8859-1?Q?9MLISGVPjEqlaD2dSDDTY7sQ5Yem1eds/gA6beeF9058usZR8k/g5KrgGV?=
 =?iso-8859-1?Q?LkkzQb+my//CPjYDgVINQJya/v5jBtBvKpy2mByMC4kvboMeofgiBDjMbT?=
 =?iso-8859-1?Q?yu0v0GlSWBzVLRfRDLaLkfUD8PfpqmvZ17W1H0nhbs6LPOoiETV4DUR1cx?=
 =?iso-8859-1?Q?AdwfnbH8dWYCU83bWCE185inKfPS9wEXdQcIlB3w+/2zGy0SYk2RwU6KvQ?=
 =?iso-8859-1?Q?a3L+ogPJFyq75tujXCzOKRzIHnafS05oLr/JgqRGhVX+lUVEHHCEytyFF2?=
 =?iso-8859-1?Q?RpAhrYtoASxQeIL2OMhT4HQ/it2fUNkgpEyWL/6PPGOx0Yyo+JWVC2Mp4I?=
 =?iso-8859-1?Q?pYkKb/46ALvvaUrSiQYwiJSMxJcQTQgcevif3LjVAXLnFP50fUrOlVUxdp?=
 =?iso-8859-1?Q?6GphVJNnGlRO+sPQpTR7hsXBPl0suwTLllMi8qyzDb2lL77dNJLyDU/EPd?=
 =?iso-8859-1?Q?fvEBUhkhF7TcuCgq2cjFdBGgXmPSd8AbNU9b9GHK/VWAaz6TTGpnmddlnJ?=
 =?iso-8859-1?Q?W+QS9rydE3kdu+va7BafB8u6ZLKHV1omDO1x9Z6Di/6oCDait7bRkYvpty?=
 =?iso-8859-1?Q?ndET4+dswPIAtTP+l9YB5loROweflkhvJiAQh+eJIvrRJ2pxZsjvCLgw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4751.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cfda6f-e544-4fe8-5efe-08da81ac9f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 06:32:42.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZJhaD6bqijB5Stkx8NPytTq8B5ZTGif8DdmQRgp0Z1AvxKIQEtSqyaDe3SoPNJ1kHdH2gNUf840wlwO0OQCZvy/EdPSxins8KcWFEvSASg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6749
X-Proofpoint-ORIG-GUID: wTsagtGw2LuWH8vrEXBTh2nMAZMbpLCY
X-Proofpoint-GUID: wTsagtGw2LuWH8vrEXBTh2nMAZMbpLCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190025
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

We are using private GitHub repository and review our projects during Pull =
Request. We reviewed the MAX11410 Linux driver based on the general correct=
ness, best practices, Linux coding style and IIO Driver implementation. The=
 repository also contains test scripts that we can review the test coverage=
 as well.


Best Regards,

Nurettin Bolucu
Senior MTS, Software - Istanbul Software Design Center
Eski Buyukdere Cad. Maslak No.1 6th Floor 34485 Sariyer Istanbul TR

Office=A0=A0=A0=A0=A0 90 (212) 952-5168
Mobile=A0=A0=A0=A0 90 (506) 992-7486
Web=A0=A0=A0=A0=A0=A0=A0=A0 analog.com

=A0 =A0=A0=A0=A0=A0=A0










-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sunday, August 14, 2022 18:56
To: Tilki, Ibrahim <Ibrahim.Tilki@analog.com>
Cc: linux-iio@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Bolucu, Nuret=
tin <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add adi,max11410.yaml

[External]

On Thu, 11 Aug 2022 13:42:43 +0000
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding devicetree binding documentation for max11410 adc.
>=20
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>

As a general rule, prefer to see review on list.
Whilst Analog folk are usually good at doing reviews properly some other co=
mpanies have been known to add reviewed-by tags without doing a proper job =
of review.  Hence we prefer to hear from the reviewer on the public list if=
 possible, even if it's a quick note to say what sort of review they have d=
one (general correctness / check against datasheet / detailed subsystem int=
eraction review etc) as that reduces the focus others may put on the same a=
reas.

I regularly do this wrong in Huawei code btw as we still do more review bef=
ore posting than we perhaps should :)

A few comments inline. Biggest is the interrupts description needing to be =
more general to avoid us having problems if we extend it in future to cover=
 the other possible pin.

> ---
>  .../bindings/iio/adc/adi,max11410.yaml        | 165 ++++++++++++++++++
>  1 file changed, 165 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml=20
> b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> new file mode 100644
> index 000000000..a782bfcaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2022=20
> +Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id:=20
> +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/adc/adi
> +,max11410.yaml*__;Iw!!A3Ni8CS0y2Y!7sok_RjOsQmX2sw37vgNw48j1VkwrSqKY0l
> +gDlIAlxYUTh6-mbuZqS6ysSEQcFSTmpRIinW_-cwEpcG7BSg$
> +$schema:=20
> +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> +aml*__;Iw!!A3Ni8CS0y2Y!7sok_RjOsQmX2sw37vgNw48j1VkwrSqKY0lgDlIAlxYUTh
> +6-mbuZqS6ysSEQcFSTmpRIinW_-cwEqTILbNA$
> +
> +title: Analog Devices MAX11410 ADC device driver
> +
> +maintainers:
> +  - Ibrahim Tilki <ibrahim.tilki@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can=20
> +be
> +  found here:
> +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max11410
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

There are at least two possible pins, so this binding needs to take into ac=
count which one / ones are wired.  Hence you need interrupt-names and the d=
river needs to route things appropriately or at very least give a clear 'I =
don't support
GPIO0 usage' error message.

> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  avdd-supply:
> +    description: Necessarry avdd supply. Used as reference when no expli=
cit reference supplied.
> +
> +  vref0p-supply:
> +    description: vref0p supply can be used as reference for conversion.
> +
> +  vref1p-supply:
> +    description: vref1p supply can be used as reference for conversion.
> +
> +  vref2p-supply:
> +    description: vref2p supply can be used as reference for conversion.
> +
> +  vref0n-supply:
> +    description: vref0n supply can be used as reference for conversion.
> +
> +  vref1n-supply:
> +    description: vref1n supply can be used as reference for conversion.
> +
> +  vref2n-supply:
> +    description: vref2n supply can be used as reference for conversion.
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +patternProperties:
> +  "^channel(@[0-9a-f]+)?$":
> +    $ref: "adc.yaml"
> +    type: object
> +    description: Represents the external channels which are connected to=
 the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 10

the @ address seems to allow more than 0 to 10. Perhaps need to bring those=
 inline and make them both hex?  Curious. What's the 11th channel if max is=
n't 9?

> +
> +      adi,reference:
> +        description: |
> +          Select the reference source to use when converting on
> +          the specific channel. Valid values are:
> +          0: VREF0P/VREF0N
> +          1: VREF1P/VREF1N
> +          2: VREF2P/VREF2N
> +          3: AVDD/AGND
> +          4: VREF0P/AGND
> +          5: VREF1P/AGND
> +          6: VREF2P/AGND
> +          If this field is left empty, AVDD/AGND is selected.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5, 6]
> +        default: 3
> +
> +      adi,input-mode:
> +        description: |
> +          Select signal path of input channels. When PGA path is selecte=
d,
> +          hardwaregain property is enabled for channel. Valid values are=
:

A binding should not mention details of what the linux driver is doing, so =
drop that bit about hardwaregain.  Whilst bindings exist in the Linux tree =
they are used by various other bits of software.

> +          0: Buffered, low-power, unity-gain path (default)
> +          1: Bypass path
> +          2: PGA path
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        default: 0
> +
> +      diff-channels: true
> +
> +      bipolar: true
> +
> +      settling-time-us: true
> +
> +      adi,buffered-vrefp:
> +        description: Enable buffered mode for positive reference.
> +        type: boolean
> +
> +      adi,buffered-vrefn:
> +        description: Enable buffered mode for negative reference.
> +        type: boolean
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "adi,max11410";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <8000000>;
> +        interrupts =3D <25 2>;
> +        interrupt-parent =3D <&gpio>;
> +
> +        avdd-supply =3D <&adc_avdd>;
> +
> +        vref1p-supply =3D <&adc_vref1p>;
> +        vref1n-supply =3D <&adc_vref1n>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        channel@0 {
> +          reg =3D <0>;
> +        };
> +
> +        channel@1 {
> +          reg =3D <1>;
> +          diff-channels =3D <2 3>;
> +          adi,reference =3D <1>;
> +          bipolar;
> +          settling-time-us =3D <100000>;
> +        };
> +
> +        channel@2 {
> +          reg =3D <2>;
> +          diff-channels =3D <7 9>;
> +          adi,reference =3D <5>;
> +          adi,input-mode =3D <2>;
> +          settling-time-us =3D <50000>;
> +        };
> +      };
> +    };

