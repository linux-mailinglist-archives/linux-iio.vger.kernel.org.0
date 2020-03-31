Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C53199074
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgCaJL7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 05:11:59 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:30226 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731146AbgCaJL6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 05:11:58 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V969W6008863;
        Tue, 31 Mar 2020 05:11:35 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 302wsq4v2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 05:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2h/iZ0siDYGzsmfFg7zv4hWXdRtllmT402Rp1dMCqiIeJZGyYn6NnTBEUd23M04gqP079+fsZj9bBs1OqKxQm3YKy95qE1zFrpBNil5MAMqPYwB1wJ68o6MPsWm/wxZN2b1r8m3ASpuu6vjVJYbCRY047BPGxhMUS4TMG1kRQ1x+1FwEb3E7/yp8X3FCNA0fQYMLswQxwjMiQ6KP5NaqyCe41BEbcisWFQgOrDu1iUvhsjC4ySpIjCk2VAt7ALgJOgKLiII2ak+k3wNVRoGwKK8LVQlN8L1PauOIzXuxKdm6Ydg/JFvCgbzEMHiHmW8Y4IGrwvZo3s+kJklyxZKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQKK9Tu3zWEosiIxEVSWUKzWHTq51g9IQqTdxXXRPiQ=;
 b=TiBFP8y/A5txE+S0uTY3IKx2J9KlFxyxEGvG2bMiFiHVGAUg6d+ye4bpyZmFiq6WNOOeK8LDDyDP8r+Y4pHNNO/Y9HeXc27IoXIQBzbwa0N17tHoP6U5BDPu8H11OaW9Z83dE7Gxod6GLf+plXt0R8Cvty1PyYBQvyU3Wvtc7FDdLS6lMDgXBWJSePlslMxo0Pzf7vnUI7+XFP3UXOPPmuj0Y5zgi8qMyQaL3YLQ/BR24fqVcQM9k+JZ3lI2x2RKfSbdGFvgPBeh/YRR0y3N2lGXF7Y0GDtliAARE8YfpibGt5q3C0X08r+bG8xTTW8E+Ot5/66gX2WPV4C8t5h3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQKK9Tu3zWEosiIxEVSWUKzWHTq51g9IQqTdxXXRPiQ=;
 b=AuHXuJPswATe6h8YWYX3I9v2ROcQCIhSVO5XRg2V45adHcsWQG3CgOTrTNHFNqXjx34LWNSR/s2SvqsncyWoZFdP/pgc2L/EIsXsjA1GzfIz7g0A8LfQZYK/pkIVTYdeShvYEN+lLggd6TLmaseDDZ0B0B9gXpNOIL6izjEkTOc=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3154.namprd03.prod.outlook.com (2603:10b6:405:3f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 09:11:32 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 09:11:32 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2 6/6] dt-bindings: iio: Add adis16475 documentation
Thread-Topic: [PATCH v2 6/6] dt-bindings: iio: Add adis16475 documentation
Thread-Index: AQHV+5HNYm3YGmr7KUCstjElbLU1tqhhrZ8AgADS1oA=
Date:   Tue, 31 Mar 2020 09:11:30 +0000
Message-ID: <BN6PR03MB334768BC30B36FFB4692868499C80@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
 <20200316125312.39178-7-nuno.sa@analog.com> <20200330203250.GA14978@bogus>
In-Reply-To: <20200330203250.GA14978@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOThkZmE3M2ItNzMyZi0xMWVhLThhMzAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDk4ZGZhNzNkLTczMmYtMTFlYS04YTMwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNzAwNyIgdD0iMTMyMzAxMTk0OD?=
 =?iso-8859-1?Q?Y0MDUxNDA0IiBoPSJSbHRFM1F5Z0pnRkVEU3BGa29rT1pjWVFkSG89IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURNUkR0YlBBZldBWUFZQUF5Z0R0VUlnQmdBREtBTzFRZ0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQTV1R0RXQUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-originating-ip: [2001:a61:25e8:5601:8594:23ee:fc00:bd03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96c1990d-58e5-4d99-4a8b-08d7d553813d
x-ms-traffictypediagnostic: BN6PR03MB3154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB3154E029B5A930EBE8C1A05399C80@BN6PR03MB3154.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(366004)(6506007)(186003)(7696005)(5660300002)(6916009)(86362001)(66574012)(53546011)(71200400001)(4326008)(33656002)(66446008)(66476007)(66556008)(2906002)(8936002)(107886003)(81166006)(966005)(81156014)(8676002)(64756008)(76116006)(9686003)(66946007)(498600001)(52536014)(55016002)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Ss2U8Zd6j9JGwt0ESlOs2lygDC4lu8y1VXu8FWpZ7YZAz6gBm6nJIcWo6aVJUGlaWCVarTSgmrTvsODpbVsYk5kkxIYl0tNJ63EspA/Zf5Nhnwo+1gq2UQJDXdoDUc4t6TCWpOgj/Vse3nBHYVu4hh/VvCn4DOqrzXfeNjvvISbacJ4dsIfAOcODmnhXG1wrsxQbyTWfcObOpyUP1N1UTcXEdwTnFwA40uFYFMOdUhcYGWZ/7jna6p6I+QfpwqcVUQ1fIafByPuCThrWAXyL+VMwKSJnbb1X9o8lPbzUS6xIdgkFVkavYC638dHXAWHV73vOINzzd3H8YJlC6oJg48Hm2vmAFoNIOFg0IG+DS66sBacQqw02Z2+CMpmefQE4aQM5ziI7IaEXGzIVdipZkhacY505zb8enlYyDfB8O0uVELwSc29/UcXZRCd7A4ypeMz5ApQJwytZHb1thz/sOBK/RjUvQciwPNd3UcyGqGCbKGbZWyb9+1SH/jkL3QSPWWpmgt9CXu0rMpNZSIMxQ==
x-ms-exchange-antispam-messagedata: Ff1MnHgFa7HzEiPTmsrM3VInXcNsPTfJkSo/i+h71JbzD8VZvLW2dNO8h9FKoY64n8yAC2dgWd2o/QdeENsVLVoDAvjvgG+xEA/u3MR0LhkYhW2LzG05ziOcWC6pwW/OqHqyf4pUy2OsMmP6LZMhQMWTS2VO+7Q6lC11MkEYXrBKl2wXVpIN2oe2bpSmfsXXFxLVIL9P6BLEIz8tm1oc4A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1990d-58e5-4d99-4a8b-08d7d553813d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 09:11:32.2824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uQWJIU5Lwil3tgN+3AzjCnSxjFK0D3dfzHdxBLkW3m1nGMgKfIWfPiM7Aep3HiJwTPFZykkEYcIxe8rovSMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310082
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> O=
n
> Behalf Of Rob Herring
> Sent: Montag, 30. M=E4rz 2020 22:33
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; Jonathan Camer=
on
> <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Mark
> Rutland <mark.rutland@arm.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: Re: [PATCH v2 6/6] dt-bindings: iio: Add adis16475 documentation
>=20
> On Mon, Mar 16, 2020 at 01:53:12PM +0100, Nuno S=E1 wrote:
> > Document the ADIS16475 device devicetree bindings.
> >
> > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> > ---
> > Changes in v2:
> >  * Remove burst32 property;
> >  * Rename clk-mode to adi,sync-mode;
> >  * Remove clock-names;
> >  * Add conditionals to state that clocks is only needed depending on
> adi,sync-mode property
> >
> >  .../bindings/iio/imu/adi,adis16475.yaml       | 146 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 147 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.ya=
ml
> b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > new file mode 100644
> > index 000000000000..9eeb42773edd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADIS16475 and similar IMUs
> > +
> > +maintainers:
> > +  - Nuno S=E1 <nuno.sa@analog.com>
> > +
> > +description: |
> > +  Analog Devices ADIS16475 and similar IMUs
> > +  https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADIS16475.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adis16475-1
> > +      - adi,adis16475-2
> > +      - adi,adis16475-3
> > +      - adi,adis16477-1
> > +      - adi,adis16477-2
> > +      - adi,adis16477-3
> > +      - adi,adis16470
> > +      - adi,adis16465-1
> > +      - adi,adis16465-2
> > +      - adi,adis16465-3
> > +      - adi,adis16467-1
> > +      - adi,adis16467-2
> > +      - adi,adis16467-3
> > +      - adi,adis16500
> > +      - adi,adis16505-1
> > +      - adi,adis16505-2
> > +      - adi,adis16505-3
> > +      - adi,adis16507-1
> > +      - adi,adis16507-2
> > +      - adi,adis16507-3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency:
> > +    maximum: 2000000
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Must be the device tree identifier of the RESET pin. If specifie=
d,
> > +      it will be asserted during driver probe. As the line is active l=
ow,
> > +      it should be marked GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  adi,sync-mode:
> > +    description:
> > +      Configures the device SYNC pin. The following modes are supporte=
d
> > +      0 - output_sync
> > +      1 - direct_sync
> > +      2 - scaled_sync
> > +      3 - pulse_sync
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 3
> > +
> > +  adi,scaled-output-hz:
> > +    description:
> > +      This property must be present if the clock mode is scaled-sync t=
hrough
> > +      clock-names property. In this mode, the input clock can have a r=
ange
> > +      of 1Hz to 128HZ which must be scaled to originate an allowable s=
ample
> > +      rate. This property specifies that rate.
> > +    minimum: 1900
> > +    maximum: 2100
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - spi-cpha
> > +  - spi-cpol
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - adi,adis16500
> > +          - adi,adis16505-1
> > +          - adi,adis16505-2
> > +          - adi,adis16505-3
> > +          - adi,adis16507-1
> > +          - adi,adis16507-2
> > +          - adi,adis16507-3
> > +
> > +then:
> > +  properties:
> > +    adi,sync-mode:
> > +      minimum: 0
> > +      maximum: 2
> > +
> > +  if:
> > +    properties:
> > +      adi,sync-mode:
> > +        enum: [1, 2]
> > +
> > +  then:
> > +    dependencies:
> > +      adi,sync-mode: [ clocks ]
>=20
> You can remove this if/then if you...
>=20
> > +
> > +else:
>=20
> > +  if:
> > +    properties:
> > +      adi,sync-mode:
> > +        enum: [1, 2, 3]
> > +
> > +  then:
> > +    dependencies:
> > +      adi,sync-mode: [ clocks ]
>=20
> ...put this if by itself under an 'allOf'. (And then the 1st if should
> go under the 'allOf' too).
>=20

I see. I was being a bit picky here. If I'm understanding correctly I actua=
lly tried that form and=20
when playing with the example and setting compatible to "adis16505" and adi=
,sync-mode =3D <3> (for eg),
I was getting both messages:

 adis16475-3@0: adi,sync-mode:0:0: 3 is greater than the maximum of 2=20
 adis16475-3@0: 'clocks' is a dependency of 'adi,sync-mode'

And in this case, I wanted to just have the first message. Either way, it s=
hould be clear that the first message needs
to be fixed. I will change to allOf...

- Nuno S=E1
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            adis16475: adis16475-3@0 {
> > +                    compatible =3D "adi,adis16475-3";
> > +                    reg =3D <0>;
> > +                    spi-cpha;
> > +                    spi-cpol;
> > +                    spi-max-frequency =3D <2000000>;
> > +                    interrupts =3D <4 IRQ_TYPE_EDGE_RISING>;
> > +                    interrupt-parent =3D <&gpio>;
> > +            };
> > +    };
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f11262f1f3bb..f8ccc92ab378 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1015,6 +1015,7 @@ W:	http://ez.analog.com/community/linux-
> device-drivers
> >  S:	Supported
> >  F:	drivers/iio/imu/adis16475.c
> >  F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
> > +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> >
> >  ANALOG DEVICES INC ADM1177 DRIVER
> >  M:	Beniamin Bia <beniamin.bia@analog.com>
> > --
> > 2.25.1
> >
