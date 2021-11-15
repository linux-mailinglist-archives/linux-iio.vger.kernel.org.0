Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424004502CB
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 11:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKOKxu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 05:53:50 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:58144
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231135AbhKOKxq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 05:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp2Mv+3tcnVkc2Fhy+gR2RMh9HtXr760GI9kl5LUeULTZH6i52m6cTZIsd+iyq8UGiZHalwpLHgS5M/GPruEvOAd9TG7YRJ9v4xccjAbtGlnff6vb4PS4tuZs6Yu5jztWXuRMNOv0BpjhjImx+UBgWxMgzZoK2r4imVGoCkX7nrAK/caNviUOTrEFu39pwJf+Lnb6RKjqSx+W7XDNhg9PRMSPNBcXbjy/c7D5z+D0/IaVRMA6/3iYhmsv8QYF1xKgofCAnoirNaioYiCbufqIwCslriBRgA9C5aE5+DglG4Gd3h4YHwB4IXxaFKF4j8M3KtcoivVcmL+hLHcrD7dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX+dbfb8G5ZtBLs34POIZJYtQanfvsf7lbCikmQRvQ4=;
 b=PKslndTLQ4NB896roPqdkI2xqbR1Ko6+9loHbiXWM/oJKhQKi9qCnWDcs7JajnP+TrJ0gDFlZV5QGK/63BJM7NoUmL360W+xvn1+OenpkT3aJVfCiSbPqa0O8AWVTrDz6DFefydf4BdbLZ/Je6scGEVTmRSBxzxfbeDKxM1rQ5Qak4Sq8WGfrVkZWfj8HbtOle1mwvR57M1GQrlvYzLrcsu3Ua6vOzZNfdf+1EKqDWemvJoT4gS66AXRFLhMttxJ/HiIvruJag2xMdEUyshaxJr5HeS0Xmwida3EhiXsccPNRqEWTQomaH4RG57gJQk5zZZBsTVTob3Cqcz+IJGkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX+dbfb8G5ZtBLs34POIZJYtQanfvsf7lbCikmQRvQ4=;
 b=SIc+hron2WejTePpY5TDUJ/m+cc7n8O4+JCHeXMz9eJ88X/FiVnjD8FOL8E90111reF50AS3IQWaveBpj+Aaq+wdLqaS0UYL0v8865OEbKALhPo7ANmcsaEP2J+9X7NIdin1WB0K4HMUI6milC50lr6lvu+xS5dpkvb3jmxjve4=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7247.namprd02.prod.outlook.com (2603:10b6:a03:29b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 10:50:48 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 10:50:48 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>, git <git@xilinx.com>
Subject: RE: [PATCH v8 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Topic: [PATCH v8 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
 documentation
Thread-Index: AQHX1ORkbUMqDXG9/UWa7VvDN1Yog6wAB8iAgARrM5A=
Date:   Mon, 15 Nov 2021 10:50:48 +0000
Message-ID: <BY5PR02MB691622D0B2E43854875ED31DA9989@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-4-anand.ashok.dumbre@xilinx.com>
 <YY6GK3K5B/cgdczY@robh.at.kernel.org>
In-Reply-To: <YY6GK3K5B/cgdczY@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d16deba-7b81-4edc-73c3-08d9a825c8be
x-ms-traffictypediagnostic: SJ0PR02MB7247:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7247A0B3AF8888BDAADAD9C0A9989@SJ0PR02MB7247.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCOnz0xmCGpnQ8/is7snv4/3Am1Jv5180Y2P9YhMXBLqHkrAfxkf121s3W4z7WxlBcUA4gu4LzE3qYiN4scBhqP1+jUfHbiNeHa/zi+c1TVj3d5i2Uj9qQPvJBSoVJJam4X8b30ptlRPySqI3lTKAERM3hNmsNvn8UeXi+b7whnsRIVwQAKw7tWQxWBwySmQ3RlAQvJQ6cKsbfkD7+T500VGg8PeXeZa8S1ODkGAwKanJiqCHEhsR6ySP7gS7Vvs27AHwnmxaX7Knv4OS/l6mUBhGYmU4oweYlbZc0wRxOK4xt5MXSWCndNOeLP4QoAG9/I6Sj0wUlYGQ3H3kLehpJfSAKcl4xN/9SvvWoI17zGqkU7cU2sFQpHrCQEf4ziAOZ4ZI3wziZCye6ypSSLtnU9uAaJrVUZF4brd/xiYvSXcLWG+zsltYkbZY/2qLMc38+qkPYWiwEunRcoSCGM4UItpcBNLkzBeijiNWhP+PRUfRdUHL7BWVddK19i2VKHHZIhpnJZqA/e92RKP+R+ZuMJ/wAEETE28GpuX2hOl4uMA5uFhEshBC+BLMKwYjs2OwmNgHqydwwdUyoS35DQrdLXnadfzuW5cpjh5WCRFFq6TgvTcTel9ctKhW2oTXu2vdnhTJyY84qimaaUXAK0a7AlwZQmmW8WJZADTHrdjG+DCo+58SlRCCF+Kazb8/qpIAluAsMFlYfsy5y6gqvuDKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(4326008)(8676002)(52536014)(76116006)(8936002)(316002)(64756008)(6506007)(33656002)(26005)(2906002)(38070700005)(5660300002)(9686003)(66556008)(83380400001)(122000001)(71200400001)(66476007)(66946007)(6916009)(508600001)(54906003)(38100700002)(86362001)(7696005)(53546011)(55016002)(186003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hhZy5xhqOzrCT83l4HBoVzBffeQ42mrYUYahBzoDAP2OomuBCeMeacpNn6lv?=
 =?us-ascii?Q?UUuycgmPv9939qp9H0FdZA4CS2APXhCWo7EX3gXU1t6hFR7k62f3qPeuuMMk?=
 =?us-ascii?Q?KydsXdB1ujW87FEJ4ZWTO34q+yYdtjryfvDAWym84DQdNeQgZQsKIRhK9NBn?=
 =?us-ascii?Q?OETSEs7MdUVwo7uUbdMD9bhDBnLO7ASWZ+r5R2gO2IcjSz1QNiVWiTPIIfo/?=
 =?us-ascii?Q?tBber3O5xDlyU5N7a5wDK+4i5CgH3wc1+WEEcXynPF8Uu0JoJzV5Om8N9nYw?=
 =?us-ascii?Q?xZOo/RN52wo/+rFxtnWhE/yLijxT6XZa8xhiPbS4XOikkK11p1+f9aozOgQC?=
 =?us-ascii?Q?rrF/0XhjVYJpv0pHiq8GhkmSImobIjwnQHOkspDlYDnnBC0ArSmi8vWu7gAO?=
 =?us-ascii?Q?6YdbUO0J/i1Ib1dl5Q5Ni10Ns1hmNPcY38NQVfH9V4O3jQkdA3j4kfsLI1Pk?=
 =?us-ascii?Q?SsIBJsmoo8ZAyfzjOOVuWD5v0Ev1WLLI7csuxkRm/dNpar3nZBY/ecv6S0op?=
 =?us-ascii?Q?Z6aMFwHcdzkAU/mDFA6h7cK6DHKKhQAB5uZGuhxV0un147O+z19P1PU8GA4X?=
 =?us-ascii?Q?VWk34HOERJHcqn32OgbtdWw0YtdiEZj4k+NeI6XFBy4+srK5lbTsjl+tBLPj?=
 =?us-ascii?Q?m/sDTC8S5DGfLkxX3tbC5EE3u2jcPG019I7RWfA4RCVuOEcyNw3EuAjBoDr3?=
 =?us-ascii?Q?q198p1QjMPgODBXPvZkzJtDg0RBeSBruQiFwTj81dNO6Rh/3ecAlV0vACX1C?=
 =?us-ascii?Q?gXHBvAtyxF+fTS/Tn5IG8VHoygnvNGhSSSXwrdm9zAHl4NsFcwp+7SaiG0gg?=
 =?us-ascii?Q?Bql4Bb+F9rxNxKlVXRrbamMi3bH/quOS8adikVtaZqb1IdZNiGdvinASEm/X?=
 =?us-ascii?Q?ouElYJEjaReqS9WATU/StKlGWatAWSo9d+sJbnKbSV/kR/PNgZP4XJHOt1+z?=
 =?us-ascii?Q?9me3tAixaobXuDOmFAWlER9WCfT314NAYQCELTVv9Z7WSgmwSVGhxbI8JzJg?=
 =?us-ascii?Q?lL0tJvH3tNj0sUajOOkS1zXD6F4pMsj071oXGMGOGxBD8Gnd+JQtqwFnPjCc?=
 =?us-ascii?Q?wYS6Voz9r6Bm1Iz+2ATWCViTrlvIpOrwfjBz26iVvfpvdPwMRa1W+JROG7P5?=
 =?us-ascii?Q?bV8PkhmGm30kVhaflWMGDp+RmAoME88TH+6+p5dljkoYpkEGAN7HqfVEJlHQ?=
 =?us-ascii?Q?nzX5X3G5mQTu3xCBeEXYxQ8SBau2wAY7o6r4vv1apDlb5Ppjug0pvZnD8nXH?=
 =?us-ascii?Q?qNyVfTcQRL7Mw67umEvpFpH034/+lq+V11FRvr2if5UvtAP+gl+h6erhsMv/?=
 =?us-ascii?Q?QvEg2fhrK8AcgMTLKqahOeJGIRpXL31oR6jCn17a/38aHjezgYEWpTz0IuuU?=
 =?us-ascii?Q?0nbjmjVAx0F7oukmsvA0mabcGLCHcJgHKY+ktohai5uVDPdrxHmG0KqVOFVP?=
 =?us-ascii?Q?3OtjmHYJOlgxmnHJ2ydtBxnHVUuvge9nhOqJoXHQ0rMeDOS7VNHn+XArPAtE?=
 =?us-ascii?Q?9DDuEv4JwlA7EOziU2w6/vg0T9KdPFNd0O5rIvQy7ysfRmMTrvEv3vs7BB86?=
 =?us-ascii?Q?pojwQ2M6EvLuWD/cvu9oa/pJMb5uTbvjol4ZoaaAaYIrMlGqOuI7aS5Xy4t4?=
 =?us-ascii?Q?BmpF0Kt4gkYzpcg6S5/Docg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d16deba-7b81-4edc-73c3-08d9a825c8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 10:50:48.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfr55WZo2MVEcJc20ipm7P1ey0apkz/Vjtj2dw3WRA/zthN/BWUWMRCRiBMfwUVs0GBEXjfHklHdUrw12vRyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7247
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday 12 November 2021 3:20 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: lars@metafoo.de; pmeerw@pmeerw.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-iio@vger.kernel.org; Michal Simek
> <michals@xilinx.com>; jic23@kernel.org; git <git@xilinx.com>
> Subject: Re: [PATCH v8 3/4] dt-bindings: iio: adc: Add Xilinx AMS binding
> documentation
>=20
> On Mon, 08 Nov 2021 21:05:08 +0000, Anand Ashok Dumbre wrote:
> > Xilinx AMS have several ADC channels that can be used for measurement
> > of different voltages and temperatures. Document the same in the
> bindings.
> >
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > ---
> >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     | 227 ++++++++++++++++++
> >  1 file changed, 227 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> >
>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions.
> However, there's no need to repost patches *only* to add the tags. The
> upstream maintainer will do that for acks received on the version they ap=
ply.
>=20
> If a tag was not added on purpose, please state why and what changed.

Will keep that in mind.

Thanks,
Anand

