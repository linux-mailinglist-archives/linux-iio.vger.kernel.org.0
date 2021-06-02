Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DE39839E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFBHxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 03:53:08 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:11466
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229618AbhFBHxE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Jun 2021 03:53:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqyKJWX8rnb1qkEhEeHXwmdp6xe/qYbSLfqHy/jDFcQMQR/4NQ1tTIYzH/v5eunBkKNUnvynBv7MNzTwlIVJ57OxvKtYfOYq/iFWcB6Vsy4F7MNnfBG0leDsZLH2y3BCTR3imxKhBf8gyQ7YAYGrvdYN01e/6a2oBq0KD/PwcZSDKc075kCLM3WeUOT/SZiR0xQr4nudw0+/LFMXUBDGMKjcJuVcq7gG2hZV9nh/GE+LX5osOSokhHVYmtLgG1ch0NxpOjboM0CQaRkGNdHXPBE3uDZvvCknZKl/hHo4BUy9MK3pmFmwjxCnihn8lFSMVKjhO/DhF4P1kRAdtHA6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJk8FwHwmyKqmJEr7j+M+pqfuquk9xCHPZyEtWjoME8=;
 b=aEL3NnZnZdHBw5dfUkmM8w4LUKM1bfrzCUHn7YClB5MLgX23CRDm+/DoVxWc3XHk2raDw8oYjLH0haMjKkVUWpLYr6l9cxkVKFq7E0KNJBYydhUs3kMU4vRiV5knyzKQ9VNxhEHLnfUM2xEr6eoSvjtiNKzDG5LxU8xyuE8tAiZ/veo3hiUV9FwQxk4jSxRZ4YlFFSA4VpZi317vNf/qWDattmVn/8d7rtNT176ErnTuYtMrszGptIaf3DiOsMlkSkzKgQfaGC4FNujiTtNGgD2WScyhAMlonjJUjj017zzzvTWai9S5WlKPGk0kgeEUTznJPThgtNShwKlU4ThDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJk8FwHwmyKqmJEr7j+M+pqfuquk9xCHPZyEtWjoME8=;
 b=JWPhepGRlZd8Sq5MymOSAGeek66V9nu1Jjh/q+hvSsoUCRQaI97JjWNGonOqBEeh3j/lVnkH8NFZEzKfGvmfZTo6txT9busjYVli7w/DkYvj1m4WR2kSGi/Y+3eT5HNGonPqjS54CFg/onZi373cjxP9p11RqxNIpbTEj86CAM0=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6626.namprd02.prod.outlook.com (2603:10b6:a03:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 07:51:18 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::6c5f:71ab:5fac:cb80]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::6c5f:71ab:5fac:cb80%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 07:51:18 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git-dev <git-dev@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Topic: [PATCH v5 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Index: AQHXU+ch50CjwBhG3kuEI6tOcqUTnar/oF4AgACtMZA=
Date:   Wed, 2 Jun 2021 07:51:17 +0000
Message-ID: <BY5PR02MB691659C17364A05BA741A89CA93D9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20210528172959.15663-1-anand.ashok.dumbre@xilinx.com>
 <20210528172959.15663-4-anand.ashok.dumbre@xilinx.com>
 <20210601202414.GA950000@robh.at.kernel.org>
In-Reply-To: <20210601202414.GA950000@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [37.228.236.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb35728-e499-43e0-d5bf-08d9259b3480
x-ms-traffictypediagnostic: BY5PR02MB6626:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB662624A1E90BA97A6023BA84A93D9@BY5PR02MB6626.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZTB9eYiTzJIgQcYcWagCKz/+K53Tffjw3ZbZPnJzpRaIqQU9m8uNFTvrFDm3W3009m2KoTrEI6AeUMzCYn+KZUF/FOUp7Gs5Fmaut9Bcnd53E2Z+gUMwCZQCyn8h2DI/Zou/bauA/obR9II76IDcGvsSpCagHT3oFnfAxHJQMKvve4cX4ePI+QxsxJj4DdZO58J37GTYNIvy/ucDgkg+lV5r2u1HhfJOzb8KsVMhFhV/upUVtMsN7U7FfB/dtOAkp1evEmvV5+CzbaBDj/smvjHLJPw7urybgJquaQGKq3KeBeiwnS8ydcqOmAL1K/hNOwrABaQlM5dK6wGOpQqU6iN6vy9G7lXNQdAUUkGWFORFkV8p57GyXNPo8V9Iu9B4sX3sUco32aVDiIFddryHcjDyccCsTdLsv69R4R2QY67TIVwQlarZoVIEJV/IEJmxWAvqhl772qvOKUbI9+QZGmqsTOxph0Yxpjn2hmQeAFVeCa+EKT2zKhQh+RxaTR5o5OKtSxObVtv5z9aJkvYeJ/MJy2s3PC7qIfJUZfEOT9sewvLqRoaaN5yMmzIm3SRrDUkH0LC42HSl7rSpP3EGhvFnAriFRCbI6PpHfNr+maPoz7DZ9RPtR2n3YWsOlpFV2FhBQ5fwVhiej8iVfdV/UIUjXV7taheH3HPNnfn+yBg88Go+BsLrTw4aY8//DdDHm+2xP3uXuC5CPNOo5C/t+MxXi8GFyTwbdoRrl0EYmnkXwjEha3m3i15GHGFTtt2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(186003)(316002)(2906002)(55016002)(9686003)(30864003)(52536014)(6916009)(83380400001)(6506007)(122000001)(5660300002)(8676002)(71200400001)(54906003)(76116006)(66556008)(66946007)(8936002)(66476007)(64756008)(66446008)(38100700002)(86362001)(4326008)(966005)(478600001)(33656002)(26005)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9QYZwPaUm9/we7TsiUkdTylnfIdp4Wt/vTkfpN22Bl8PP6uxMJ4fok3Bir0?=
 =?us-ascii?Q?gKxCTCzN18abXJwMkCxeK7xY3Ym2ktAZeI5bRWSHMobrBV4V7Ua9FXnbB3gc?=
 =?us-ascii?Q?qjPFLruoyIi53WXtZPb6qlDs0Z18PlL1AAKgItQe3qqmPDrWYEFOuW4nM/T8?=
 =?us-ascii?Q?b7evveoACH50Z1/pn6GYlfFRmG7J2zesn8xhqcsTsOjA7wdYHSwYYd1M1YkO?=
 =?us-ascii?Q?69fiD6bnWJltdb3Li76yOUK+wysCkis1gcwIEFwVSNkxL2e2O7yg7HwnRiLg?=
 =?us-ascii?Q?xm0z/8XWeJ5iH7wAgqUD0p9oG9KSNk2lWhH/wXXRZ24Of0GYAFr5ejK9NKiB?=
 =?us-ascii?Q?SmS/Ak8+gc5+sqhw1XSvOHHIwM61IGR3RYvlY1lsOdpU5b9Cn5i5+2phYk5b?=
 =?us-ascii?Q?Thvd2xwAdKTgz6kzArz97TD3jaqpfE6plHOXvD7wE9/2y/KOAJme/X1tXd+A?=
 =?us-ascii?Q?4WWEEUw8uIsfGR7v4Tpnb7tLRM6CKcNOj+9lJjJp7t/gtQEfVF/f1MAWS0et?=
 =?us-ascii?Q?nOCvDasOTFajPfH9tz8jfgup8YFJbpxj4/MTo6bBFZ0ilZucUytS7xDIpnk5?=
 =?us-ascii?Q?Tw9aU0HQaPkf6ksiezXAArOfedbqQRdfv1v02QzqvG0Sr+r7uyuBwv908Syj?=
 =?us-ascii?Q?6KuWE1DTLP6r05ZfGLTY76cgD24neWsXfKp68UAZJs/m2Hdz3AuHSBpK1EwV?=
 =?us-ascii?Q?weT+thrHg87hjBIt0ClbCMGqk2Zs1eFVCHRRdzFaE6R6FSDZvvrUnwbhYNN2?=
 =?us-ascii?Q?kuJ1vSzi+/Qpv0x5KhUnyILfeWytsGjmJTWUA5elS/rS7UCdww94Fdi77eIj?=
 =?us-ascii?Q?Lwv4DI0w7RCHVuNNV87XcnxFQCZaBgVb0ivsVWcypwOI/hjIKTUnmWu4pzGL?=
 =?us-ascii?Q?ytF3jYGPyxr0a5KwLOkCKseKZjvjTQS0iJZT8fsKtCwT5HeZBndGs0ZK5lHJ?=
 =?us-ascii?Q?ZxnyC+x+7jHbufa4mHSLBSePmTPIQId5h8Yi1Hf942S+ZmfwBVv9W2WGdTK2?=
 =?us-ascii?Q?fJkbYc4xg+yM5ovhlhkgp/sBRyPClJy6PJ9cTVPGlONjTon0Kkr2Rago6EOR?=
 =?us-ascii?Q?MKoreZ5/jq8l4tbeXmG7Fj6gh4cMirGxLxgPCvrU/Rc35/vTG7zebFOjf3VM?=
 =?us-ascii?Q?gQhb5XHhG8oOfpL6GCzIgVRrSUGfFNojykm3Af1j+/PPj8M2weeqnmTU5bef?=
 =?us-ascii?Q?J9dQcIzZFfeutSjsAiY1dzY/D6crb84c5kf6qV6Yd1mJPlnc+cZEREB1Fbey?=
 =?us-ascii?Q?hkkAOHD5rddyyAR53vYVzmwBqfzcUXcZfOpRO1R7TIbb1Gd0et9YpntAtQxa?=
 =?us-ascii?Q?X6JQgSp7KEPJmwZAx8uH5rQt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb35728-e499-43e0-d5bf-08d9259b3480
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2021 07:51:17.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04JrUShE7HMvxR8ADltnbtKCV7s5Vo6ej/ss+l+86kbE4yjISKK/ljqGyay1BtsubdMvmwilCR9PqlyLmhY4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6626
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday 1 June 2021 9:24 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: jic23@kernel.org; lars@metafoo.de; linux-iio@vger.kernel.org; git-dev
> <git-dev@xilinx.com>; Michal Simek <michals@xilinx.com>;
> pmeerw@pmeerw.net; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
> documentation
>=20
> On Fri, May 28, 2021 at 06:29:58PM +0100, Anand Ashok Dumbre wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the
> bindings.
> >
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > ---
> >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 265 ++++++++++++++++++
> >  1 file changed, 265 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > new file mode 100644
> > index 000000000000..df3cfca69e2d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > @@ -0,0 +1,265 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/xlnx,zynqmp-ams.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx Zynq Ultrascale AMS controller
> > +
> > +maintainers:
> > +  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > +
> > +description: |
> > +  The AMS (Analog Monitoring System) includes an ADC as well as
> > +on-chip sensors
> > +  that can be used to sample external voltages and monitor on-die
> > +operating
> > +  conditions, such as temperature and supply voltage levels.
> > +  The AMS has two SYSMON blocks which are PL (Programmable Logic)
> > +SYSMON and
> > +  PS (Processing System) SYSMON.
> > +  All designs should have AMS registers, but PS and PL are optional.
> > +The
> > +  AMS controller can work with only PS, only PL and both PS and PL
> > +  configurations. Please specify registers according to your design.
> > +Devicetree
> > +  should always have AMS module property. Providing PS & PL module is
> optional.
> > +
> > +  AMS Channel Details
> > +  ```````````````````
> > +  Sysmon Block	|Channel|			Details
> 			|Measurement
> > +  		|Number	|
> 		 	|Type
>=20
> Use spaces rather than tabs

Will amend in the next series.
>=20
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.
> 			|Voltage
> > +  		|1	|Battery voltage measurement, VCC_PSBATT.
> 		|Voltage
> > +  		|2	|PL Internal voltage measurement, VCCINT.
> 		|Voltage
> > +  		|3	|Block RAM voltage measurement, VCCBRAM.
> 		|Voltage
> > +  		|4	|PL Aux voltage measurement, VCCAUX.
> 			|Voltage
> > +  		|5	|Voltage measurement for six DDR I/O PLLs,
> VCC_PSDDR_PLL.	|Voltage
> > +  		|6	|VCC_PSINTFP_DDR voltage measurement.
> 			|Voltage
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  PS Sysmon	|7	|LPD temperature measurement.
> 			|Temperature
> > +  		|8	|FPD temperature measurement (REMOTE).
> 			|Temperature
> > +  		|9	|VCC PS LPD voltage measurement (supply1).
> 		|Voltage
> > +  		|10	|VCC PS FPD voltage measurement (supply2).
> 		|Voltage
> > +  		|11	|PS Aux voltage reference (supply3).
> 		|Voltage
> > +  		|12	|DDR I/O VCC voltage measurement.
> 		|Voltage
> > +  		|13	|PS IO Bank 503 voltage measurement (supply5).
> 			|Voltage
> > +  		|14	|PS IO Bank 500 voltage measurement (supply6).
> 			|Voltage
> > +  		|15	|VCCO_PSIO1 voltage measurement.
> 		|Voltage
> > +  		|16	|VCCO_PSIO2 voltage measurement.
> 		|Voltage
> > +  		|17	|VCC_PS_GTR voltage measurement
> (VPS_MGTRAVCC).			|Voltage
> > +  		|18	|VTT_PS_GTR voltage measurement
> (VPS_MGTRAVTT).			|Voltage
> > +  		|19	|VCC_PSADC voltage measurement.
> 			|Voltage
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  PL Sysmon	|20	|PL temperature measurement.
> 			|Temperature
> > +  		|21	|PL Internal voltage measurement, VCCINT.
> 		|Voltage
> > +  		|22	|PL Auxiliary voltage measurement, VCCAUX.
> 		|Voltage
> > +  		|23	|ADC Reference P+ voltage measurement.
> 			|Voltage
> > +  		|24	|ADC Reference N- voltage measurement.
> 			|Voltage
> > +  		|25	|PL Block RAM voltage measurement, VCCBRAM.
> 			|Voltage
> > +  		|26	|LPD Internal voltage measurement, VCC_PSINTLP
> (supply4).	|Voltage
> > +  		|27	|FPD Internal voltage measurement, VCC_PSINTFP
> (supply5).	|Voltage
> > +  		|28	|PS Auxiliary voltage measurement (supply6).
> 		|Voltage
> > +  		|29	|PL VCCADC voltage measurement (vccams).
> 		|Voltage
> > +  		|30	|Differential analog input signal voltage measurment.
> 		|Voltage
> > +  		|31	|VUser0 voltage measurement (supply7).
> 			|Voltage
> > +  		|32	|VUser1 voltage measurement (supply8).
> 			|Voltage
> > +  		|33	|VUser2 voltage measurement (supply9).
> 			|Voltage
> > +  		|34	|VUser3 voltage measurement (supply10).
> 			|Voltage
> > +  		|35	|Auxiliary ch 0 voltage measurement (VAux0).
> 		|Voltage
> > +  		|36	|Auxiliary ch 1 voltage measurement (VAux1).
> 		|Voltage
> > +  		|37	|Auxiliary ch 2 voltage measurement (VAux2).
> 		|Voltage
> > +  		|38	|Auxiliary ch 3 voltage measurement (VAux3).
> 		|Voltage
> > +  		|39	|Auxiliary ch 4 voltage measurement (VAux4).
> 		|Voltage
> > +  		|40	|Auxiliary ch 5 voltage measurement (VAux5).
> 		|Voltage
> > +  		|41	|Auxiliary ch 6 voltage measurement (VAux6).
> 		|Voltage
> > +  		|42	|Auxiliary ch 7 voltage measurement (VAux7).
> 		|Voltage
> > +  		|43	|Auxiliary ch 8 voltage measurement (VAux8).
> 		|Voltage
> > +  		|44	|Auxiliary ch 9 voltage measurement (VAux9).
> 		|Voltage
> > +  		|45	|Auxiliary ch 10 voltage measurement (VAux10).
> 			|Voltage
> > +  		|46	|Auxiliary ch 11 voltage measurement (VAux11).
> 			|Voltage
> > +  		|47	|Auxiliary ch 12 voltage measurement (VAux12).
> 			|Voltage
> > +  		|48	|Auxiliary ch 13 voltage measurement (VAux13).
> 			|Voltage
> > +  		|49	|Auxiliary ch 14 voltage measurement (VAux14).
> 			|Voltage
> > +  		|50	|Auxiliary ch 15 voltage measurement (VAux15).
> 			|Voltage
> > +
> > + --------------------------------------------------------------------
> > + ------------------------------------
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - xlnx,zynqmp-ams
> > +
> > +  interrupts:
> > +    description: IRQ line for AMS
>=20
> Drop.
>=20
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: ams-irq
>=20
> Kind of a pointless name. You don't need *-names unless you have more
> than one.
>=20

Agreed, will drop

> > +
> > +  reg:
> > +    description: AMS Controller register space
> > +    maxItems: 1
> > +
> > +  reg-names:
> > +    items:
> > +      - const: ams-base
> > +
> > +  ranges:
> > +    description:
> > +      Keep the property empty to map child address space
> > +      (for PS and/or PL) nodes 1:1 onto the parent address space.
> > +    maxItems: 1
>=20
> This contradicts 'empty'.
>=20

Accepted.=20

> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> > +patternProperties:
> > +  "^ams-ps@0,0$":
>=20
> If you have a non standard unit-address, you need to define the fields.

Will do.

>=20
> > +    type: object
> > +    description: |
> > +      PS (Processing System) SYSMON is memory mapped to PS. This block
> has
> > +      built-in alarm generation logic that is used to interrupt the pr=
ocessor
> > +      based on condition set.
> > +
> > +    properties:
> > +      compatible:
> > +          enum:
> > +            - xlnx,zynqmp-ams-ps
> > +
> > +      reg:
> > +        description: Register Space for PS-SYSMON
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +  "^ams-pl@1,0$":
>=20
> What does the '1' correspond to?

I have updated this in other places, but this got left out.
1 is supposed to be 400 which is the offset at which this node.

>=20
> > +    type: object
> > +    description:
> > +      PL-SYSMON is capable of monitoring off chip voltage and temperat=
ure.
> > +      PL-SYSMON block has DRP, JTAG and I2C interface to enable
> monitoring
> > +      from external master. Out of this interface currently only DRP i=
s
> > +      supported. This block has alarm generation logic that is used to
> > +      interrupt the processor based on condition set.
> > +
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - enum:
> > +              - xlnx,zynqmp-ams-pl
> > +
> > +      reg:
> > +        description: Register Space for PL-SYSMON.
> > +        maxItems: 1
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +    patternProperties:
> > +      "^xlnx,ext-channels$":
>=20
> Not a pattern. Put under 'properties'.
>=20


> > +
> > +        type: object
> > +
> > +        description:
> > +          List of external channels that are connected to the AMS PL m=
odule.
> > +          If this property is not present, no external channels will b=
e
> > +          assumed to be connected.
> > +
> > +        properties:
> > +          '#address-cells':
> > +            const: 1
> > +
> > +          '#size-cells':
> > +             const: 0
> > +
> > +        additionalProperties: false
> > +
> > +        patternProperties:
> > +          "^channel@([0-9]{1,2}|1[0-5][0-9])$":
> > +            type: object
> > +            description:
> > +              Describes the external channels connected.
> > +
> > +            properties:
> > +              reg:
> > +                $ref: /schemas/types.yaml#/definitions/uint32
>=20
> 'reg' already has a type.

Will remove it.
>=20
> > +                description:
> > +                  Pair of pins the channel is connected to. This value=
 is
> > +                  same as Channel Number for a particular channel.
> > +                minimum: 20
> > +                maximum: 50
>=20
> Based on the unit-address, the max is 159.

Will fix it.=20

>=20
> > +
> > +              xlnx,bipolar:
> > +                $ref: /schemas/types.yaml#/definitions/flag
> > +                type: boolean
> > +                description:
> > +                  If the set channel is used in bipolar mode.
> > +
> > +            required:
> > +              - reg
> > +
> > +            additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - interrupt-names
> > +  - reg
> > +  - reg-names
> > +  - ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        xilinx_ams: ams@ffa50000 {
> > +            compatible =3D "xlnx,zynqmp-ams";
> > +            interrupt-parent =3D <&gic>;
> > +            interrupts =3D <0 56 4>;
> > +            interrupt-names =3D "ams-irq";
> > +            reg =3D <0x0 0xffa50000 0x0 0x800>;
> > +            reg-names =3D "ams-base";
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +            #io-channel-cells =3D <1>;
> > +            ranges =3D <0 0 0xffa50800 0x800>;
> > +
> > +            ams_ps: ams-ps@0,0 {
> > +                compatible =3D "xlnx,zynqmp-ams-ps";
> > +                reg =3D <0 0x400>;
> > +            };
> > +
> > +            ams_pl: ams-pl@1,0 {
> > +                compatible =3D "xlnx,zynqmp-ams-pl";
> > +                reg =3D <0x400 0x400>;
> > +                xlnx,ext-channels {
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <0>;
> > +                    channel@30 {
> > +                        reg =3D <30>;
> > +                        xlnx,bipolar;
> > +                    };
> > +                    channel@31 {
> > +                        reg =3D <31>;
> > +                    };
> > +                    channel@38 {
> > +                        reg =3D <38>;
> > +                        xlnx,bipolar;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.17.1

Thanks,
Anand
