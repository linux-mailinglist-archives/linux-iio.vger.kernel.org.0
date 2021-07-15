Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56743C9946
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhGOHBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 03:01:55 -0400
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:33760
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230310AbhGOHBz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 03:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihad026eZvB1TChhjhtSdx547FpGmDJKCfzUaWdBKFDyIn0QpT7Cih2LmxAR9c1ECR9UPqIm+M6X+fpkXlasjdl+7eYHBj/uX7OaBuYsVQ3nA/z//E7Y+Xp4R6YzgvGFYnc8jh/yKjyY5PfKShqpOhcetaS46hfqefkqxP/doqvNFjAfztlhkRR3TxrnH5oXCzFUmmRdzhTFlbaHAZY0SNPePAUInGf/446oNhtRTbwHU61Y8ci2vfX8zvak1spkNLsujyQ6Tu9kbR1m+2fe8/DWBaQJJfG0vGYWUSzDZvzR81WMpZgNsIke45nIFgVPurjl/tm80rmp/gPlIzNgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv0T1JNgyBAzrwPdYqwS+EQNzcYgOIFguqENorRyf2A=;
 b=epOqnAizwRmnVK1QI+x4veg/+6NgXToMJJzH25l/eE8tYxDSY7Az/AdFjUObcslzuz7T4F64hHjaxFgJQzb1seNNt8JuQnfasV6NphzEviPbiIZa8yLd+RriHVyoShXGt35z8MAFQepiEc+w3voinDQ4Atprqt0WjRRCiaAHYvwwpiljLuCTs8uqFwwMSov+NGLNVLJBiuthnIei0psyVnENu/CXz+5Rxbr5N34P/pbhTCVGT4SmjE/ihLvBOolZrfOQj0aH3EBlRkorRtPWd5k1hNNHxBL/53Ea47yx43G12GImYOsNIOabUY05pNz205PlR+fXuvRa8/3IA+exvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv0T1JNgyBAzrwPdYqwS+EQNzcYgOIFguqENorRyf2A=;
 b=UPSAIEvvHvIS+goSA8ixTovUWIlo1X8XhPG1IOfGsFI9D+LlTno446ay1GecVDpPrWx0f6KPeSHTzxUaY+926ZQAQc5xAlUO08yz+6EGkGPUh12gOcYLp9EjGJwSbtxl9nSEkOWZ9oSZYj87UngUjaUKTtUCxCChE9DLlqaSwfQ=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB5685.namprd02.prod.outlook.com (2603:10b6:a03:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 06:58:53 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06%9]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 06:58:53 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git-dev <git-dev@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Topic: [PATCH v6 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Index: AQHXaSbwCYj7+t6LGkuDMpU62fO/sqtBm0AAgAIeS7A=
Date:   Thu, 15 Jul 2021 06:58:53 +0000
Message-ID: <BY5PR02MB6916D1527E06A88645D921D8A9129@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
 <20210624182939.12881-4-anand.ashok.dumbre@xilinx.com>
 <20210713223110.GA959341@robh.at.kernel.org>
In-Reply-To: <20210713223110.GA959341@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dfaaabf-04fe-4446-fa5c-08d9475e01fe
x-ms-traffictypediagnostic: BYAPR02MB5685:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB56854A5DC6CC209503127F44A9129@BYAPR02MB5685.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FiOcu1ZfgwfL+/wCnyAykVl+FiM0bAFXLa3ZJbebjMybIrvdfaZU5qW4z3RDzW9OiyjwPEtrdxAfT0CPP5jEsp3YBE4gmrvLVSsEYMFAHMnTrJhIIMyIdcYKiB44QDjEG4sOJ8wuDV9t4S15ZVA7r3unyCTh/ra+oxdJmHKCvaZODqmELWk7e8BcQzAqAIYCP098Pi54m1zJqaela8izwtyfp4nc88c1YFIo7A6P3o2x0Unr8Z2CVcuL6zfLka7RsrSSHrsWi8wuRTyvsVSoSQTy5iI5QMrR2E6nqcqEoFwZAors77O+NNqHeCBl183AaqhB/xB3mNFHU9rtlLtXbPbzXBSlgJwykBFaMgXDnFllL0L05Cr9J9Omr+W00KqCYKVa7g/fPfAfCiThiJHP1gkVd5HcYJC9MJ3unAYUGZLi/MtxTxsLkfoaJN08a9yniLdFcvGHwulvRyVlECNa48m73YEfAtJFB7piktGQ6gj1WjHPNTJUSkzR3CG0hNjLP/R38O7E8diRo1vfWsgn5lzXK+E25P92akruT+HjcM9nmuVTamwIGaubJ/l2EgI3OVih/En80/QdwGVv772pEXg/rUHJKSCdayWtkRcV7Xs2xPbjLawPkE0HV2XKBdYbseoF3L1gkhSVHQEuSBOpV7EFZCKWEj5StIv0FWfZ2s+mX13tiR+EnOaWQh4h4CWWT1C192Elh0uceB/WKcxN5JvwVq62px0VrEsSBqLpXxrmEGznK6irLq9+2fl8Y/An8rTh61lsTLdGnRSQ0DJ6bjQRapW2gCKILDM7kegJVrL/w8UP1skKD+eEqyOky5hw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(71200400001)(76116006)(6506007)(26005)(8936002)(186003)(55016002)(33656002)(86362001)(30864003)(54906003)(4326008)(66556008)(66476007)(64756008)(66446008)(53546011)(6916009)(9686003)(66946007)(38100700002)(83380400001)(122000001)(966005)(478600001)(52536014)(316002)(2906002)(5660300002)(7696005)(8676002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IcpwhDeYJh3wPQmXfX+CDHQ9aftcZqqgv5gffZJDCTnlLCT8Hwo0HqCZc0oB?=
 =?us-ascii?Q?PB1ELC/jkPySpT1YCBe+7GnueQDZpa31bp3Z5ewdM0W8s6WhnGms6JpeyPtI?=
 =?us-ascii?Q?rdRDe/lfnUNaqpPtAoALAjGjVe2AnWuE1i1PwIuc5dnj9cwbTlLCoHgdvLMf?=
 =?us-ascii?Q?OtvpEPaePmICiD4+oJ7szH4dfceAzhrI7jXYeSxnj1ve4KUgTa55Z1ohFIHV?=
 =?us-ascii?Q?iWE4BAmMzuDtbqXGJdKyLa8FUsEK7RI2NNtEcsza0o5fPP53Nay984DIBcAa?=
 =?us-ascii?Q?Q09Ja7iA9yqnQkahiIdxUeiFF1ahPYY/51A+IwzQzIimGj7EcfSu5LNmJgvQ?=
 =?us-ascii?Q?abbRW2irZTvx9EM61PhvF7K/GjNYU41H4XquX59/aqtp7tNYHDVJxPxEgsxt?=
 =?us-ascii?Q?ZB8B2XmCRKX/dDg4FG49Nx97owvFHl24pa5y042nvolyeoBFqe7bAqbUyDFG?=
 =?us-ascii?Q?YPbAvmMIdwiZ4+GITCwe9kN+dr3xeC/9eT90SuVe05ge0n7TPRGgs3mt4hTk?=
 =?us-ascii?Q?MzL1s4YTaMNDEZ2l0OzW7asIQqXtHVYhBDg3JEV+ADbzufPe/pprW2L6A3nj?=
 =?us-ascii?Q?IfPpc7bzcfqciXwFvsZR5GIliE5WNDaeUYZExBdyWephTjD7oQzXhaltymq8?=
 =?us-ascii?Q?ZTG77WNecx1wxpb0YttcqaOs2rUhjIavAD0+ZeJ60QL9cQIr52UFmQGRAKr/?=
 =?us-ascii?Q?xpl65sDnrzXDbvkOISKnGJFiHz0VZToG6HFLvwJPAbAQILKm4hgVY8PkBfQi?=
 =?us-ascii?Q?vzGigfael6RVLuU3K+uV8qiCLtj1QLYprQNI0ayBclHpTC6vURRCe8C1/A0c?=
 =?us-ascii?Q?feJ+qfOWPSJsbCxsBrGf7AkK0VFig3FweNl0F0osdMs/RwNJOW/rhDdhsT/e?=
 =?us-ascii?Q?SF0EN74UBtxglKu93eWJuoL5qfz76/E4i0vOujSUBTV8x0mE0Lk0Cv5bXSus?=
 =?us-ascii?Q?1cLBAhUqQo9LogUTtRizhLdZ/P12xC0GsaBcC4gcVwkgin4o35Hp4IqfrS++?=
 =?us-ascii?Q?SSfHqpsZMt405buccFWjreJnh5ROaXYlBZPwLAq9KzLz5rLltTau6uzIxI4x?=
 =?us-ascii?Q?6o35gWLihT3MREoKBh0hMSh5+CLJAGQg4NpoPZ3XZ5Mq2zbriBYbSO1Ff8MI?=
 =?us-ascii?Q?terCb/F0E86+8EO55JYKk0rxtdFkm57XqJL1b0HHueYdmHhwBI/UPFKZ3lIZ?=
 =?us-ascii?Q?wgzNyk/1qeKuznqR68Sn1x04+ctcQUJqU8oIAsxldrqH6ebcudEKW63HwbxX?=
 =?us-ascii?Q?ccGrBEnrqg5+xxqqZSNp1ZWBiNY7WbAE+Z+CrowmPnE4QJSQj2AUeg4zQFb3?=
 =?us-ascii?Q?GK0nSdNaNIPZ761qXNy6Ld26?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfaaabf-04fe-4446-fa5c-08d9475e01fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 06:58:53.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaWSxKVmae2S1mu3BRr62oUl8j9Wd2pXingeTpsrn1daDFv3QHzgBjluApTq1HLitroQ8NYUm7ClVgGnomlczw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5685
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Thank you for reviewing the patch.

My responses in line.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday 13 July 2021 11:31 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: jic23@kernel.org; lars@metafoo.de; linux-iio@vger.kernel.org; git-dev
> <git-dev@xilinx.com>; Michal Simek <michals@xilinx.com>;
> pmeerw@pmeerw.net; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
> documentation
>=20
> On Thu, Jun 24, 2021 at 07:29:38PM +0100, Anand Ashok Dumbre wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the
> bindings.
> >
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > ---
> >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 228 ++++++++++++++++++
> >  1 file changed, 228 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > new file mode 100644
> > index 000000000000..a065ddd55d38
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > @@ -0,0 +1,228 @@
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
> > +  Sysmon Block  |Channel|                       Details
> |Measurement
> > +                |Number |                                             =
                  |Type
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  AMS CTRL      |0      |System PLLs voltage measurement, VCC_PSPLL.
> |Voltage
> > +                |1      |Battery voltage measurement, VCC_PSBATT.
> |Voltage
> > +                |2      |PL Internal voltage measurement, VCCINT.
> |Voltage
> > +                |3      |Block RAM voltage measurement, VCCBRAM.
> |Voltage
> > +                |4      |PL Aux voltage measurement, VCCAUX.
> |Voltage
> > +                |5      |Voltage measurement for six DDR I/O PLLs,
> VCC_PSDDR_PLL.       |Voltage
> > +                |6      |VCC_PSINTFP_DDR voltage measurement.
> |Voltage
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  PS Sysmon     |7      |LPD temperature measurement.
> |Temperature
> > +                |8      |FPD temperature measurement (REMOTE).
> |Temperature
> > +                |9      |VCC PS LPD voltage measurement (supply1).
> |Voltage
> > +                |10     |VCC PS FPD voltage measurement (supply2).
> |Voltage
> > +                |11     |PS Aux voltage reference (supply3).          =
                  |Voltage
> > +                |12     |DDR I/O VCC voltage measurement.
> |Voltage
> > +                |13     |PS IO Bank 503 voltage measurement (supply5).
> |Voltage
> > +                |14     |PS IO Bank 500 voltage measurement (supply6).
> |Voltage
> > +                |15     |VCCO_PSIO1 voltage measurement.
> |Voltage
> > +                |16     |VCCO_PSIO2 voltage measurement.
> |Voltage
> > +                |17     |VCC_PS_GTR voltage measurement (VPS_MGTRAVCC)=
.
> |Voltage
> > +                |18     |VTT_PS_GTR voltage measurement (VPS_MGTRAVTT)=
.
> |Voltage
> > +                |19     |VCC_PSADC voltage measurement.
> |Voltage
> > +  --------------------------------------------------------------------=
---------------------
> ----------------
> > +  PL Sysmon     |20     |PL temperature measurement.
> |Temperature
> > +                |21     |PL Internal voltage measurement, VCCINT.
> |Voltage
> > +                |22     |PL Auxiliary voltage measurement, VCCAUX.
> |Voltage
> > +                |23     |ADC Reference P+ voltage measurement.
> |Voltage
> > +                |24     |ADC Reference N- voltage measurement.
> |Voltage
> > +                |25     |PL Block RAM voltage measurement, VCCBRAM.
> |Voltage
> > +                |26     |LPD Internal voltage measurement, VCC_PSINTLP
> (supply4).       |Voltage
> > +                |27     |FPD Internal voltage measurement, VCC_PSINTFP
> (supply5).       |Voltage
> > +                |28     |PS Auxiliary voltage measurement (supply6).
> |Voltage
> > +                |29     |PL VCCADC voltage measurement (vccams).
> |Voltage
> > +                |30     |Differential analog input signal voltage meas=
urment.
> |Voltage
> > +                |31     |VUser0 voltage measurement (supply7).
> |Voltage
> > +                |32     |VUser1 voltage measurement (supply8).
> |Voltage
> > +                |33     |VUser2 voltage measurement (supply9).
> |Voltage
> > +                |34     |VUser3 voltage measurement (supply10).
> |Voltage
> > +                |35     |Auxiliary ch 0 voltage measurement (VAux0).
> |Voltage
> > +                |36     |Auxiliary ch 1 voltage measurement (VAux1).
> |Voltage
> > +                |37     |Auxiliary ch 2 voltage measurement (VAux2).
> |Voltage
> > +                |38     |Auxiliary ch 3 voltage measurement (VAux3).
> |Voltage
> > +                |39     |Auxiliary ch 4 voltage measurement (VAux4).
> |Voltage
> > +                |40     |Auxiliary ch 5 voltage measurement (VAux5).
> |Voltage
> > +                |41     |Auxiliary ch 6 voltage measurement (VAux6).
> |Voltage
> > +                |42     |Auxiliary ch 7 voltage measurement (VAux7).
> |Voltage
> > +                |43     |Auxiliary ch 8 voltage measurement (VAux8).
> |Voltage
> > +                |44     |Auxiliary ch 9 voltage measurement (VAux9).
> |Voltage
> > +                |45     |Auxiliary ch 10 voltage measurement (VAux10).
> |Voltage
> > +                |46     |Auxiliary ch 11 voltage measurement (VAux11).
> |Voltage
> > +                |47     |Auxiliary ch 12 voltage measurement (VAux12).
> |Voltage
> > +                |48     |Auxiliary ch 13 voltage measurement (VAux13).
> |Voltage
> > +                |49     |Auxiliary ch 14 voltage measurement (VAux14).
> |Voltage
> > +                |50     |Auxiliary ch 15 voltage measurement (VAux15).
> |Voltage
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
> > +    maxItems: 1
> > +
> > +  reg:
> > +    description: AMS Controller register space
> > +    maxItems: 1
> > +
> > +  ranges:
> > +    description:
> > +      Maps the child address space for PS and/or PL.
> > +    maxItems: 1
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
> > +  "^ams-ps@0,400$":
>=20
> If your going to hardcode the unit-address, then it's a fixed string and =
should
> be under 'properties' instead.
Can you point me to an example?
When I tried putting it under just properties, I was not able to do so and =
was getting errors when I ran check_dt_bindings.
The only way I was not getting the error was by putting it under pattern pr=
operties.

My node looked something like this,

   "ams-ps@0":
	type:object
	...
	...

>=20
> The unit-address is also wrong. This is memory-mapped ranges, right? If s=
o,
> this should just be '0' and the next one '400'.

I will fix this.
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
> > +        enum:
> > +          - xlnx,zynqmp-ams-ps
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
> > +  "^ams-pl@400,400$":
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
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^channel@([2-4][0-9]|50)$":
> > +        type: object
> > +        description:
> > +          Describes the external channels connected.
> > +
> > +        properties:
> > +          reg:
> > +            description:
> > +              Pair of pins the channel is connected to. This value is
> > +              same as Channel Number for a particular channel.
> > +            minimum: 20
> > +            maximum: 50
> > +
> > +          xlnx,bipolar:
>=20
> Don't we have a common property for this now?
>=20
> > +            $ref: /schemas/types.yaml#/definitions/flag
> > +            type: boolean
> > +            description:
> > +              If the set channel is used in bipolar mode.
> > +
> > +        required:
> > +          - reg
> > +
> > +        additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
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
> > +            reg =3D <0x0 0xffa50000 0x0 0x800>;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <1>;
> > +            #io-channel-cells =3D <1>;
> > +            ranges =3D <0 0 0xffa50800 0x800>;
> > +
> > +            ams_ps: ams-ps@0,400 {
> > +                compatible =3D "xlnx,zynqmp-ams-ps";
> > +                reg =3D <0 0x400>;
> > +            };
> > +
> > +            ams_pl: ams-pl@400,400 {
> > +                compatible =3D "xlnx,zynqmp-ams-pl";
> > +                reg =3D <0x400 0x400>;
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +                channel@30 {
> > +                    reg =3D <30>;
> > +                    xlnx,bipolar;
> > +                };
> > +                channel@31 {
> > +                    reg =3D <31>;
> > +                };
> > +                channel@38 {
> > +                    reg =3D <38>;
> > +                    xlnx,bipolar;
> > +                };
> > +            };
> > +        };
> > +    };
> > --
> > 2.17.1
> >
> >
