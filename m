Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62B219ADAA
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 16:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgDAOTM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 10:19:12 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:54712 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732823AbgDAOTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 10:19:12 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031E0Fwo016519;
        Wed, 1 Apr 2020 10:18:51 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-00128a01.pphosted.com with ESMTP id 302wsq8jep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 10:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOhu7vhv5r3/+HKUF52JpeCt/+92t9KIQttA4s4bilOYSzcsORxwqGzWSnzG2wmuSlUjhYirm8GQdZCTl3L+1Dqers+9GGGgJ6736Oc5+30zSbeXVNzFhJDyMzBbe4sJyWnveS3l4tl52p3Ooa9WaJiX5v5ZsnKIqRsJmLZcjdvCFEGS6OHVQk47VpjdSOt/yE4pZnCZhoe6LxcF/zaNZjlm438MgFGz7ukYlVC17etyd/FsIAZHD+6fPLXE8zW4RhnuISITxZ7occHi9wqBPv72gW/1NBpjMTLn2U1aigFHzKgKO2s/2Cx+rNNsRgb3WMD6H3LlEfgWdJ4NnFx5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuC8qRc5ziZXpfSySo0KsaQYfksvnPxwhx5x+2E3u8Q=;
 b=QeeFNlNggTqfFd2OtX8fAYdAsIOPKIX4HVRfoaUqn6Y9qkCNFG/XtCUUqfsQ/FcIwHdHijXt2L0Ln1ERzkdz1u3Okfcrr7cBgoFt+sUAwW09jaZA/GCNq/LkZ4P+1X+DsF0bY8gV7I32oYX9I0FsSPSKdGfr2PX/arB1SBkXDacwbJd4Es9iFD6gnVxS4ROHakWUXfM0fF4UHgsCsSk+6uIxMVQMurb1/khCiVQQjsXcPqwxQkAHGSAbaSyVmULPfPBYvkfDjEgssICNP1TbCgxQyxtAtUu8T2hFOBxnmRitmVFHOQ/3Yv6uegohux4HW3bTXjVbiEA+1GJE+uWauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuC8qRc5ziZXpfSySo0KsaQYfksvnPxwhx5x+2E3u8Q=;
 b=INDs8Yg7EjL9Yg0FQQKEzjsY4GNPVcBlCMeJnReHwvwnzI4RmTZsKBxFfl6YkPJsGzF+YUahpFOQ8NZKAjGVjwABh47NhmQ45vaiAH/xG5CUt256VZhWUElR9mDueeBA0aNev8jsESXejoE64DfDaWZzLM3rPcCyudUJOAWn/GE=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2914.namprd03.prod.outlook.com (2603:10b6:404:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 14:18:50 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 14:18:50 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v3 5/6] iio: imu: Add support for adis16475
Thread-Topic: [PATCH v3 5/6] iio: imu: Add support for adis16475
Thread-Index: AQHWB1JdQRnhX3Zcn0CzNsZZpB/4wahjAhmAgADREuCAAD0vgIAAMSFQgAANPAD//+FScA==
Date:   Wed, 1 Apr 2020 14:18:50 +0000
Message-ID: <BN6PR03MB33475E91FA8665937E8F3AE599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
 <20200331114811.7978-6-nuno.sa@analog.com>
 <CAHp75Vdxtn1gXi=xCJfGOkBYiWB2qsYQLTJyaEGiiFqHvELaHQ@mail.gmail.com>
 <BN6PR03MB3347862A4C434CCA8C1B1E2599C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VfuWMDR4dUmjsYgeMgNMcVDZKdKVCsZ5p6g0m3TLHi5UA@mail.gmail.com>
 <BN6PR03MB3347E5ECF100EAD1453B577D99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75Vcp5Rs53i_74MvbudcRrDYCD=Agfjh2cO_GNc7TXaS73g@mail.gmail.com>
In-Reply-To: <CAHp75Vcp5Rs53i_74MvbudcRrDYCD=Agfjh2cO_GNc7TXaS73g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpXWTFZMk5tTUdJdE56UXhNaTB4TVdWaExUaGhNelF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHVm1OV05qWmpCa0xUYzBNVEl0TVRGbFlTMDRZ?=
 =?utf-8?B?VE0wTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpRNU5T?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXlNVGN4TWpjeU5EUXlOak01SWlCb1BTSkxjR3hsYldW?=
 =?utf-8?B?V1ZuZExTbFZYVTNaQmF5czFSUzg0SzFnd2FXYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRlFPRGRUZUVoM2FsZEJXV2RtSzBKVUwzYzNRWGxwUWk4MFJs?=
 =?utf-8?B?QXZSSE5FU1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVFYxUjBSWFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-originating-ip: [2001:a61:2422:3901:84d7:d7f0:12b0:defb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7194444c-81b6-4b23-cafd-08d7d647996f
x-ms-traffictypediagnostic: BN6PR03MB2914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB29145FFC3AFA8B63819A296699C90@BN6PR03MB2914.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(53546011)(7696005)(81166006)(33656002)(6506007)(9686003)(8676002)(55016002)(2906002)(71200400001)(52536014)(66556008)(6916009)(76116006)(186003)(86362001)(5660300002)(81156014)(8936002)(107886003)(66446008)(64756008)(316002)(66946007)(66476007)(4326008)(54906003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y32yZss9zS6yUtqKKJTTlOtX67eh8oScZ/dYLumA+zb0TPuTmsbWeqF5n45mMiSPXCWNmhE6usx3G9Wq/+SmJGf1dMpmF0mYys75RRWZw94bZpIwzbn14qADyLoCb252TcmwY4WDNMSUTpngqvy/GGBgkmrORYzJmVpGA8Os16JVSXKcOOQ8/pVQD9sEJOZcu4cd8GL8dunQHxZNnm1+c04UxXw7MD5miOHsH6VHhVwqM+7MSVQ1pWCzBHYgWeXG+f1o9meYiafKRsSoeeTPbAjo8i9nwLEEGHdgGmILTDZ8Iv6FiiICt60jD2saBiUDB0m92IFKIvtnOGvuoFDEgYFOct1OUp2kIWhfvWdFHIELppD+71zh9pOeXl8s2xy8PKYzRSec6ABL8JPCBopfc36NwQPWjbfa8yiDY82MxpcVsMOoWNihyiDVHPhqEMUh
x-ms-exchange-antispam-messagedata: myjTQV70rHyF/NQW+M4aNGzj2hBHAdUNK9VkCjBuqU7kF4TUNF0fQLiXCU6Q0Qiy/VyBIvVs81uSFL9Nl1CdEpGuZida1kyKJGkSOQWHup9cr19EYe/YN2yS12ih6ISJnsoKG3ucGKfGKIYHVUuRYfkqT93NXokOHc++VNiFnnF4e51Z4BSZGMi8kUIIwd2K27K42VySFSUdVq98D1ek2A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7194444c-81b6-4b23-cafd-08d7d647996f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 14:18:50.0437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yaM6DKWtL0OvH3uYT6BtLhFMEPOW15xd4fjNvy7o45G7l9WCzmA2r3asCEadP1xkXlyRIFbBxxwG5qh+AwE2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2914
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNl
bnQ6IE1pdHR3b2NoLCAxLiBBcHJpbCAyMDIwIDE2OjA2DQo+IFRvOiBTYSwgTnVubyA8TnVuby5T
YUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
PjsgZGV2aWNldHJlZQ0KPiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBD
YW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gSGFydG11dCBLbmFhY2sgPGtuYWFjay5oQGdt
eC5kZT47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPjsNCj4gUGV0ZXIgTWVl
cndhbGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtk
dEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFyZGVs
ZWFuLA0KPiBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFsb2cuY29tPjsgSGVubmVy
aWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0IGZvciBhZGlzMTY0NzUN
Cj4gDQo+IE9uIFdlZCwgQXByIDEsIDIwMjAgYXQgNDoyNyBQTSBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPiB3cm90ZToNCj4gPiA+IE9uIFdlZCwgQXByIDEsIDIwMjAgYXQgMTA6MTMgQU0g
U2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVl
LCBNYXIgMzEsIDIwMjAgYXQgMjo0OSBQTSBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
PiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiA+ID4gPiA+ICsgICAgICAgZm9yIChpID0gQVJS
QVlfU0laRShhZGlzMTY0NzVfM2RiX2ZyZXFzKSAtIDI7IGkgPj0gMTsgaS0tKSB7DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBXaHkgdGhvc2UgbWFyZ2lucz8gc2l6ZS0yIGFuZCAxID8NCj4gPiA+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgLTIgaXMgbmVlZGVkIHNpbmNlIGluZGV4IDcgaXMgbm90
IHZhbGlkLiBUaGUgMSBJIGhvbmVzdGx5IGRvbid0DQo+IHJlbWVtYmVyDQo+ID4gPiB3aHkgSSBk
aWQgaXQNCj4gPiA+ID4gbGlrZSB0aGlzLiBVc2luZyA+IDAgaXMgdGhlIHNhbWUgYW5kIG1vcmUg
ImNvbW1vbiIuLi4NCj4gPiA+DQo+ID4gPiBNb3JlIGNvbW1vbiBpcyA+PSAwLiBUaGF0J3MgbXkg
cXVlc3Rpb24gYmFzaWNhbGx5Lg0KPiA+ID4gQW5kIGlmIDcgaXMgbm90IHZhbGlkIHdoeSB0byBr
ZWVwIGl0IGluIHRoZSBhcnJheSBhdCBhbGw/DQo+ID4NCj4gPiBXZWxsLCBJIGNhbiByZW1vdmUg
dGhlIDcuIEkgaG9uZXN0bHkgdG9vayBpdCBmcm9tIGFub3RoZXIgZHJpdmVyIGFuZCBJIGd1ZXNz
DQo+IHRoZSBpZGVhDQo+ID4gaXMgdG8gbWFrZSBleHBsaWNpdCB0aGF0IDcgaXMgbm90IHN1cHBv
cnRlZC4gU2luY2UgdGhpcyBpcyBhIDMgYml0IGZpZWxkIGFuZCB0aGUNCj4gZGF0YXNoZWV0DQo+
ID4gZG9lcyBub3Qgc3RhdGUgdGhpcyBkaXJlY3RseS4NCj4gPg0KPiA+IEFzIGZvciB0aGUgPj0w
LCBJIHByZWZlciB0byBoYXZlIGVpdGhlciBhcyBpcyBvciA+MCBzaW5jZSB3ZSBkb24ndCByZWFs
bHkgbmVlZCB0bw0KPiBjaGVjayB0aGUNCj4gPiBpbmRleCAwLiBJZiAxIGZhaWxzLCB0aGVuIHdl
IHdpbGwgdXNlIDAgZWl0aGVyIHdheS4uLg0KPiANCj4gSXQgbWFrZXMgc2Vuc2UgdG8gY2hlY2sg
dG8gZ2V0IGJldHRlciBvcHRpbWl6YXRpb24gKGFuZCBpbmNyZWFzZWQgcmVhZGFiaWxpdHkpLg0K
PiBMb29rIGZvciB0aGlzDQo+IA0KPiBpID0gQVJSQVlfU0laRSguLi4pOw0KPiANCj4gd2hpbGUg
KGktLSkgew0KPiAgLi4uDQo+IH0NCj4gDQo+IEl0J3MgbXVjaCBiZXR0ZXIgdG8gcmVhZCBhbmQg
dW5kZXJzdGFuZC4NCg0KV2VsbCwgYWJvdXQgdGhlIHJlYWRhYmlsaXR5IGl0J3MgYSBiaXQgc3Vi
amVjdGl2ZSDwn5iKLiBJdCBkZXBlbmRzIHdobyBpcw0KcmVhZGluZyB0aGUgY29kZS4gSnVzdCBj
dXJpb3VzLCBob3cgd291bGQgeW91IGdldCBiZXR0ZXIgb3B0aW1pemF0aW9uDQpieSBkb2luZyA+
PTAgaW5zdGVhZCBvZiA+IDA/DQoNCkVpdGhlciB3YXksIEkgZG9u4oCZdCBoYXZlIGFueSBzdHJv
bmcgZmVlbGluZyBhYm91dCB0aGlzIHNvIEkgY2FuIGRvIGFzDQp5b3Ugc3VnZ2VzdC4NCg0KLSBO
dW5vIFPDoQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChhZGlzMTY0NzVfM2RiX2Zy
ZXFzW2ldID49IGZpbHRlcikNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ID4gPiA+ID4gKyAgICAgICB9DQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJk
cywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
