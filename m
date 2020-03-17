Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04824188A9C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgCQQlQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 12:41:16 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65326 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgCQQlQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 12:41:16 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HGOk15007166;
        Tue, 17 Mar 2020 12:40:52 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yrs47jwmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Mar 2020 12:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RevGFdiPdkz0HYldOn71rj8fhI3kt8Ax3mF7VJMWmJ/z+nxXAxHg46zfXCDLpLxqgap6Uk9useIaPWtE/d+iZNERYV57Oz1ceKbdc+llPM5iS+KJIKEhTMZPPVyH/tszbgvwvpBUPpuX1aOkFzZQK16mE+++eejyQwz3cBpuJixHon5HDe3MjQeMAamHOfJc0J88qLmT1VPf9EI3W1BwwerUhtzlRcGfucdoyGlTUyr7aoAWeIovM7fdALOOhqIV9FlisCXyT1J5Ud5jQ5aJRYKhkKuISC+ex7+zR6GOSlhfaPD6heE+GmcjDiBMc925daqDX/x3uDgNaj2DT+qhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k2hMLMvVykiYMx4LXj4/oBjP7c9/1Xy4O/sCzMQpEk=;
 b=lmUwl2STlyRxhd3TeYyP9gTdrE3hQUGwukQEKApV9AFlaOvP12tsphgHVeN03sYK1PAhXztuaodX8Odgx3NShkhv1o6XVecUDQqR9k/0b2c5qtyQrZvc5Yiw/w9nurr1VfmTm/XufWRloBC4fxsiWIP/gwU9Getoykj3Ep7EWjHlBDHEFtw1xm53DxuDD0FQ2LK5vG+Gd4gY4x0qyr8m+cqiugEmiuLkQ3ZR7CiFjtYjJR5vDlcCPLYb+lVDi8Rr7Sv/Mvz9kt9IeqYHr/mwnJr1+Sv9NYhttYp5+lN4fTUOr8wxz1HZhUanAC0Z8N+Kp3TT4gkYc+nWwk4Sy04Wcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k2hMLMvVykiYMx4LXj4/oBjP7c9/1Xy4O/sCzMQpEk=;
 b=NBsqlfLTgS48JjfFLa63rjMyafT/xrER2Tl6kxL7ZC9oqdaXNZYTLx5hgHP9iKFcehNa51qBDzs5yZakDaubYiOi7uDq63A3nHQ3dBHGVfX1bqofe7Rp+R8PTv/tfQNn63P+Wy2N6z1UQtPHa/FDrN6LO6/4brq3g1P0+A78c+8=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2802.namprd03.prod.outlook.com (2603:10b6:404:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Tue, 17 Mar
 2020 16:40:51 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 16:40:50 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2 5/6] iio: imu: Add support for adis16475
Thread-Topic: [PATCH v2 5/6] iio: imu: Add support for adis16475
Thread-Index: AQHV+5HNSNkkbM6x9Eep6xJ7DP90FahLRqKAgAGyQKA=
Date:   Tue, 17 Mar 2020 16:40:50 +0000
Message-ID: <BN6PR03MB334727AEEEDD8FDC424A633E99F60@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
 <20200316125312.39178-6-nuno.sa@analog.com>
 <07c41ab8-7b09-0eb3-ce9d-d7773f5186b8@metafoo.de>
In-Reply-To: <07c41ab8-7b09-0eb3-ce9d-d7773f5186b8@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1HUmlOV1E1T1dNdE5qZzJaUzB4TVdWaExUaGhNakl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQmtZalZrT1Rsa0xUWTRObVV0TVRGbFlTMDRZ?=
 =?utf-8?B?VEl5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTmprM01T?=
 =?utf-8?B?SWdkRDBpTVRNeU1qZzVNelk0TkRnMk5EQXlORE0xSWlCb1BTSmtVblV2U1hG?=
 =?utf-8?B?eFNWaHhZVWxGTUc5WVRXSlNXbXBZVEc5U2VtYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZMZDBKQlFVTkVWMVJJVVdWMmVsWkJZa1ZCUmxWNlNIQnFWbmh6VVVGV1ZF?=
 =?utf-8?B?MWxiVTVZUlVOQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJPRUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRWEl4VWxWUmQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJaRUZDY0VGSFZVRmpaMEY0UVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVNVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?Q?UFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-originating-ip: [2001:a61:24f1:dc01:fc89:b8db:83ae:9678]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9768858-574b-4809-802a-08d7ca91f3fa
x-ms-traffictypediagnostic: BN6PR03MB2802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2802461AC83B0D9571AFA22D99F60@BN6PR03MB2802.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(136003)(199004)(81166006)(9686003)(186003)(81156014)(54906003)(66446008)(64756008)(66556008)(66476007)(71200400001)(52536014)(66946007)(8676002)(8936002)(55016002)(86362001)(76116006)(316002)(478600001)(107886003)(110136005)(33656002)(5660300002)(2906002)(6506007)(7696005)(53546011)(4326008)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2802;H:BN6PR03MB3347.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bj3ySyVVcD/t72uxtZSRfi+b6iHjGPelN9EkPiPBlT7fueVZr7qDjjMO/XNEovslk153X1GMWZvOXJX0l+30TIo+n6uYd2KoYubY6f1UmnzAmQkX9eArJYT/XzzWX4gGaoYy9Tcg9txjY3p7OhhDbbVmW1AKqQQ8Ag46hN/2NdpJF0rP6hbY/n7BbpWRjhZ3ZdDE5X3koGM+/+1GpQztgkX4jqiLhVzHUZB7XYcmRkVOXW3q0H4mDXi0IgeZ+8U374yqhZKAYU2gza0vG6ex9liEeQXYrntsqjhMypGBplUL+oYuSl6Kphsr2qOcHU/zq00JyJ9CCzDpQJctDOa2KYgPKqcqkUGGC5JcwgN1IswtecNdnbyLz9GDCIk4Xeu2biDSvzlDV51GBLSfIBYMVxT72evGKy1wa306XrpvA358G1AB3Q71dCBSFyEwBR6j
x-ms-exchange-antispam-messagedata: B5iZ7U8STsPWxyVCC+f03wdV72PktfznQK9BnIhj2lm7eRnCanEj6bp6pHjWzK/6Eh7W8uOoCuJJwF18cTbMn5E4iaV5pcr2SVHhHZ6wQh99blX97NR4RkzKWPFw+7MbGvlz+UARYsSsHtq0XLzFwKg4CZVgd+4ZUNFGXZagO+gF/RqIsycCL5mK56gIoY4alJT3d3oo/JkDXxFwoj8TYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9768858-574b-4809-802a-08d7ca91f3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 16:40:50.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsgaHoPCna+ZOcwrrLSUc90G4hqfah22u2vLor3IEUgMu4YP+/o85tJ+HmEvBDI7QBAol5LtLI3dfsSJEom1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2802
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_06:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNl
biA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTZW50OiBNb250YWcsIDE2LiBNw6RyeiAyMDIwIDE1OjI3
DQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEpvbmF0aGFuIENh
bWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBIYXJ0bXV0IEtuYWFjaw0KPiA8a25hYWNrLmhAZ214
LmRlPjsgUGV0ZXIgTWVlcndhbGQtU3RhZGxlciA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBSb2INCj4g
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRA
YXJtLmNvbT47DQo+IEFyZGVsZWFuLCBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRlbGVhbkBhbmFs
b2cuY29tPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvNl0gaWlvOiBpbXU6IEFkZCBzdXBwb3J0
IGZvciBhZGlzMTY0NzUNCj4gDQo+IE9uIDMvMTYvMjAgMTo1MyBQTSwgTnVubyBTw6Egd3JvdGU6
DQo+ID4gU3VwcG9ydCBBRElTMTY0NzUgYW5kIHNpbWlsYXIgSU1VIGRldmljZXMuIFRoZXNlIGRl
dmljZXMgYXJlDQo+ID4gYSBwcmVjaXNpb24sIG1pbmlhdHVyZSBNRU1TIGluZXJ0aWFsIG1lYXN1
cmVtZW50IHVuaXQgKElNVSkgdGhhdA0KPiA+IGluY2x1ZGVzIGEgdHJpYXhpYWwgZ3lyb3Njb3Bl
IGFuZCBhIHRyaWF4aWFsIGFjY2VsZXJvbWV0ZXIuIEVhY2gNCj4gPiBpbmVydGlhbCBzZW5zb3Ig
Y29tYmluZXMgd2l0aCBzaWduYWwgY29uZGl0aW9uaW5nIHRoYXQgb3B0aW1pemVzDQo+ID4gZHlu
YW1pYyBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IFRoZSBkcml2ZXIgYWRkcyBzdXBwb3J0IGZvciB0
aGUgZm9sbG93aW5nIGRldmljZXM6DQo+ID4gICAqIGFkaXMxNjQ3MCwgYWRpczE2NDc1LCBhZGlz
MTY0NzcsIGFkaXMxNjQ2NSwgYWRpczE2NDY3LCBhZGlzMTY1MDAsDQo+ID4gICAgIGFkaXMxNjUw
NSwgYWRpczE2NTA3Lg0KPiA+DQo+IExvb2tzIHZlcnkgZ29vZCwganVzdCBhIGZldyBjb21tZW50
cyBhbmQgcXVlc3Rpb25zLiBJIGxpa2UgdGhlIHNvbHV0aW9uDQo+IGZvciB0aGUgMzItYml0IHJl
Z2lzdGVycy4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWRpczE2NDc1X3NldF9mcmVxKHN0cnVjdCBh
ZGlzMTY0NzUgKnN0LCBjb25zdCB1MzIgZnJlcSkNCj4gPiArew0KPiA+ICsJdTE2IGRlYzsNCj4g
PiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaWYgKGZyZXEgPT0gMCB8fCBmcmVxID4gc3QtPmNs
a19mcmVxKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gTWF5YmUgcm91bmQgZG93biBp
ZiBmcmVxIGlzIGxhcmdlciB0aGUgbWF4aW11bSByYXRlLiBJIGJlbGlldmUgd2UgZG8NCj4gdGhh
dCBzYW1lIGZvciBvdGhlciBkcml2ZXJzLg0KDQpDYW4gZG8gdGhhdC4uLg0KDQo+ID4gKw0KPiA+
ICsJZGVjID0gRElWX1JPVU5EX0NMT1NFU1Qoc3QtPmNsa19mcmVxLCBmcmVxKTsNCj4gPiArDQo+
ID4gKwlpZiAoZGVjKQ0KPiA+ICsJCWRlYy0tOw0KPiA+ICsNCj4gPiArCWlmIChkZWMgPiBzdC0+
aW5mby0+bWF4X2RlYykNCj4gPiArCQlkZWMgPSBzdC0+aW5mby0+bWF4X2RlYzsNCj4gPiArDQo+
ID4gKwlyZXQgPSBhZGlzX3dyaXRlX3JlZ18xNigmc3QtPmFkaXMsIEFESVMxNjQ3NV9SRUdfREVD
X1JBVEUsIGRlYyk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0K
PiA+ICsJLyoNCj4gPiArCSAqIElmIGRlY2ltYXRpb24gaXMgdXNlZCwgdGhlbiBneXJvIGFuZCBh
Y2NlbCBkYXRhIHdpbGwgaGF2ZSBtZWFuaW5nZnVsbA0KPiBUeXBvOiAibWVhbmluZ2Z1bCINCg0K
QWNrDQoNCj4gPiArCSAqIGJpdHMgb24gdGhlIExTQiByZWdpc3RlcnMuIFRoaXMgaW5mbyBpcyB1
c2VkIG9uIHRoZSB0cmlnZ2VyIGhhbmRsZXIuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghZGVjKQ0K
PiA+ICsJCWNsZWFyX2JpdChBRElTMTY0NzVfTFNCX0RFQ19NQVNLLCAmc3QtPmxzYl9mbGFnKTsN
Cj4gPiArCWVsc2UNCj4gPiArCQlzZXRfYml0KEFESVMxNjQ3NV9MU0JfREVDX01BU0ssICZzdC0+
bHNiX2ZsYWcpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsv
KiBUaGUgdmFsdWVzIGFyZSBhcHByb3hpbWF0ZWQuICovDQo+ID4gK3N0YXRpYyBjb25zdCB1MzIg
YWRpczE2NDc1XzNkYl9mcmVxc1tdID0gew0KPiA+ICsJWzBdID0gNzIwLCAvKiBGaWx0ZXIgZGlz
YWJsZWQsIGZ1bGwgQlcgKH43MjBIeikgKi8NCj4gPiArCVsxXSA9IDM2MCwNCj4gPiArCVsyXSA9
IDE2NCwNCj4gDQo+IDE2NCBpcyB0aGUgb25seSBvbmUgdGhhdCBkb2VzIG5vdCBmb2xsb3cgdGhl
IHBhdHRlcm4gb2YgNzIwIC8gKDIqKm4pLg0KPiBOb3Qgc3VyZSBpZiB0aGF0IGlzIG9uIHB1cnBv
c2UuIEJ1dCBlaXRoZXIgd2F5IHdoZXJlIGRpZCB5b3UgZmluZCB0aGUNCj4gYmFuZHdpZHRocyBm
b3IgdGhlIGRpZmZlcmVudCBmaWx0ZXIgc2V0dGluZ3M/IEkgaGFkIGEgcXVpY2sgbG9vayBhdCB0
aGUNCj4gZGF0YXNoZWV0IGFuZCBjb3VsZCBub3QgZmluZCBhbnl0aGluZy4NCj4gDQoNClNvLCB3
aGVuIEkgc3RhcnRlZCB0aGUgZHJpdmVyIGFuZCBsb29rZWQgdG8gb3RoZXIgZXhhbXBsZXMgSSBh
bHNvIHdvbmRlcmVkIGFib3V0DQp0aGlzLiBTbywgYmFzaWNhbGx5IEkgYXNrZWQgKGludGVybmFs
bHkpIGFib3V0IHRoaXMgdGFibGUgdG8gdGhlIEFwcGxpY2F0aW9uIGVuZ2luZWVyDQpyZXNwb25z
aWJsZSBmb3IgdGhpcyBwYXJ0cyBhbmQgZ290IGFuIGV4Y2VsIHNoZWV0IHdpdGggdGhpcyB2YWx1
ZXMgY2FsY3VsYXRlZCBmb3IgYQ0Kc2FtcGxpbmcgcmF0ZSBvZiAya2h6Lg0KDQo+IE1heWJlIGl0
IGFsc28gbWFrZXMgc2Vuc2UgdG8gY29uc2lkZXIgdGhlIGNsb2NrIHJhdGUgd2hlbiBydW5uaW5n
IGluDQo+IHN5bmMgbW9kZSBhcyB0aGUgYmFuZHdpZHRoIHdpbGwgYmUgYSBmdW5jdGlvbiBvZiB0
aGUgc2FtcGxpbmcgcmF0ZS4NCj4gDQoNCkhtbSwgdGhhdCBpcyB0cnVlLiBUaGUgc2FtcGxpbmcg
cmF0ZSBhbHNvIGNvbnRyaWJ1dGVzIHRvIHRoZSBzeXN0ZW0gYmFuZHdpZHRoDQpOZWVkIHRvIGNo
ZWNrIGlmIHdlIGNhbiBjYWxjdWxhdGUgdGhpcyBpbiB0aGUga2VybmVsIHRob3VnaC4uLg0KDQo+
ID4gKwlbM10gPSA4MCwNCj4gPiArCVs0XSA9IDQwLA0KPiA+ICsJWzVdID0gMjAsDQo+ID4gKwlb
Nl0gPSAxMCwNCj4gPiArCVs3XSA9IDEwLCAvKiBub3QgYSB2YWxpZCBzZXR0aW5nICovDQo+ID4g
K307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ3NV9nZXRfZmlsdGVyKHN0cnVjdCBh
ZGlzMTY0NzUgKnN0LCB1MzIgKmZpbHRlcikNCj4gPiArew0KPiA+ICsJdTE2IGZpbHRlcl9zejsN
Cj4gPiArCWludCByZXQ7DQo+ID4gKwljb25zdCBpbnQgbWFzayA9IEFESVMxNjQ3NV9GSUxUX0NU
UkxfTUFTSzsNCj4gPiArDQo+ID4gKwlyZXQgPSBhZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywg
QURJUzE2NDc1X1JFR19GSUxUX0NUUkwsDQo+ICZmaWx0ZXJfc3opOw0KPiA+ICsJaWYgKHJldCkN
Cj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCSpmaWx0ZXIgPSBhZGlzMTY0NzVfM2Ri
X2ZyZXFzW2ZpbHRlcl9zeiAmIG1hc2tdOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFkaXMxNjQ3NV9zZXRfZmlsdGVyKHN0cnVjdCBhZGlz
MTY0NzUgKnN0LCBjb25zdCB1MzIgZmlsdGVyKQ0KPiA+ICt7DQo+ID4gKwlpbnQgaTsNCj4gPiAr
CWludCByZXQ7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gQVJSQVlfU0laRShhZGlzMTY0NzVfM2Ri
X2ZyZXFzKSAtIDE7IGkgPj0gMTsgaS0tKSB7DQo+ID4gKwkJaWYgKGFkaXMxNjQ3NV8zZGJfZnJl
cXNbaV0gPj0gZmlsdGVyKQ0KPiA+ICsJCQlicmVhazsNCj4gPiArCX0NCj4gDQo+IElmIHRoZSBm
aWx0ZXIgZnJlcXVlbmN5IGlzIGxlc3Mgb3IgZXF1YWwgdG8gMTAsIHRoaXMgd2lsbCBwaWNrIDcg
Zm9yIGkuDQo+IEJ1dCB0aGUgY29tbWVudCBhYm92ZSBzYXlzIHRoYXQgaXQgaXMgYW4gaW52YWxp
ZCBzZXR0aW5nLg0KPiANCg0KR29vZCBjYXRjaCEgSSBiZWxpZXZlIHRoZSBwYXJ0IHdpbGwganVz
dCBhdXRvbWF0aWNhbGx5IGNvbnZlcnQgaXQgdG8gNi4gRWl0aGVyIHdheSwNCmJldHRlciBwbGF5
IHNhZmUuDQoNCj4gPg0KPiA+ICtzdGF0aWMgdTE2IGFkaXMxNjQ3NV92YWxpZGF0ZV9jcmMoY29u
c3QgdTggKmJ1ZmZlciwgY29uc3QgdTE2IGNyYywNCj4gPiArCQkJCSAgY29uc3QgYm9vbCBidXJz
dDMyKQ0KPiBSZXR1cm4gdHlwZSBpcyB1MTYsIGJ1dCB0aGUgcmV0dXJuIHZhbHVlIGlzIGJvb2wu
IEFsc28gdmFsaWRhdGUga2luZCBvZg0KPiBzdWdnZXN0cyB0aGF0IGl0IHJldHVybnMgdHJ1ZSBp
ZiB2YWxpZCwgYnV0IHJpZ2h0IG5vdyBpdCByZXR1cm5zIHRydWUgaWYNCj4gaW52YWxpZC4NCj4g
PiArew0KPiA+ICsJaW50IGk7DQo+ID4gKwl1MTYgX19jcmMgPSAwOw0KPiANCj4gSSBmaW5kIGhh
dmluZyBib3RoIF9fY3JjIGFuZCBjcmMgYSBiaXQgY29uZnVzaW5nLCBtYXliZSBnaXZlIHRoZW0g
bmFtZXMNCj4gd2hpY2ggYmV0dGVyIGRlc2NyaWJlIHRoZW0uIE1heWJlIGNvbXB1dGVkX2NyYyBv
ciBleHBlY3RlZF9jcmMuIE9yIGFzIGFuDQo+IGFsdGVybmF0aXZlIEkgdGhpbmsgYWxzbyBqdXN0
IGNyYyAtPSBidWZmZXJbaV0gaW4gdGhlIGxvb3AgYW5kIGNyYyAhPSAwDQo+IGF0IHRoZSBlbmQg
c2hvdWxkIHdvcmsuDQo+IA0KDQpIbW0sIEkgbGlrZSB0aGUgYWx0ZXJuYXRpdmUuLi4NCg0KPiAN
Cj4gPiArCS8qIGV4dHJhIDYgZWxlbWVudHMgZm9yIGxvdyBneXJvIGFuZCBhY2NlbCAqLw0KPiA+
ICsJY29uc3QgdTE2IHN6ID0gYnVyc3QzMiA/IEFESVMxNjQ3NV9CVVJTVDMyX01BWF9EQVRBIDoN
Cj4gPiArCQlBRElTMTY0NzVfQlVSU1RfTUFYX0RBVEE7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0g
MDsgaSA8IHN6IC0gMjsgaSsrKQ0KPiA+ICsJCV9fY3JjICs9IGJ1ZmZlcltpXTsNCj4gPiArDQo+
ID4gKwlyZXR1cm4gKF9fY3JjICE9IGNyYyk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2
b2lkIGFkaXMxNjQ3NV9idXJzdDMyX2NoZWNrKHN0cnVjdCBhZGlzMTY0NzUgKnN0KQ0KPiA+ICt7
DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsJc3RydWN0IGFkaXMgKmFkaXMgPSAmc3QtPmFkaXM7DQo+
ID4gKw0KPiA+ICsJaWYgKCFzdC0+aW5mby0+aGFzX2J1cnN0MzIpDQo+ID4gKwkJcmV0dXJuOw0K
PiA+ICsNCj4gPiArCWlmIChzdC0+bHNiX2ZsYWcgJiYgIXN0LT5idXJzdDMyKSB7DQo+ID4gKwkJ
Y29uc3QgdTE2IGVuID0gQURJUzE2NTAwX0JVUlNUMzIoMSk7DQo+ID4gKw0KPiA+ICsJCXJldCA9
IF9fYWRpc191cGRhdGVfYml0cygmc3QtPmFkaXMsDQo+IEFESVMxNjQ3NV9SRUdfTVNHX0NUUkws
DQo+ID4gKwkJCQkJIEFESVMxNjUwMF9CVVJTVDMyX01BU0ssIGVuKTsNCj4gPiArCQlpZiAocmV0
IDwgMCkNCj4gPiArCQkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCQlzdC0+YnVyc3QzMiA9IHRydWU7
DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBJbiAzMmJpdCBtb2RlIHdlIG5lZWQgZXh0cmEgMiBieXRl
cyBmb3IgYWxsIGd5cm8NCj4gPiArCQkgKiBhbmQgYWNjZWwgY2hhbm5lbHMuDQo+ID4gKwkJICov
DQo+ID4gKwkJYWRpcy0+YnVyc3QtPmV4dHJhX2xlbiArPSA2ICogc2l6ZW9mKHUxNik7DQo+IA0K
PiBJIGJlbGlldmUgdGhpcyBicmVha3MgaWYgeW91IGhhdmUgbW9yZSB0aGFuIG9uZSBkZXZpY2Ug
aW5zdGFuY2UgYXMNCj4gYWRpcy0+YnVyc3QgcG9pbnRzIHRvIGEgZ2xvYmFsIHN0cnVjdCB0aGF0
IGlzIHNoYXJlZCBiZXR3ZWVuIGFsbA0KPiBpbnN0YW5jZXMuIGV4dHJhX2xlbiBzaG91bGQgcHJv
YmFibHkgYmUgcGFydCBvZiB0aGUgYWRpcyBzdHJ1Y3QgaXRzZWxmDQo+IGFuZCB0aGVuIG1ha2Ug
dGhlIGJ1cnN0IGZpZWxkIGNvbnN0Lg0KPiANCg0KVXBzLCBkZWZpbml0ZWx5IGEgcHJvYmxlbSEg
VGhpcyBleHRyYV9sZW4gaXMgYWN0dWFsbHkgc29tZXRoaW5nIHRoYXQgSSBkb24ndCBsaWtlLiBJ
IGhhdmUNCnNvbWUgbG9jYWwgcGF0Y2hlcyB0byBnZXQgcmlkIG9mIHRoaXMgdmFyaWFibGUuIFNv
LCBidXJzdF9sZW4gaXMgYmVpbmcgY2FsY3VsYXRlZCBsaWtlIHRoaXMNCg0KLyogQWxsIGJ1dCB0
aGUgdGltZXN0YW1wIGNoYW5uZWwgKi8NCmJ1cnN0X2xlbmd0aCA9IChpbmRpb19kZXYtPm51bV9j
aGFubmVscyAtIDEpICogc2l6ZW9mKHUxNik7DQpidXJzdF9sZW5ndGggKz0gYWRpcy0+YnVyc3Qt
PmV4dHJhX2xlbjsNCg0KVGhpcyBpcyBkb25lIGluIHRoZSBsaWJyYXJ5IHdoaWNoIGluIG15IG9w
aW5pb24gaXMgd3JvbmcuIFRoZSBsaWJyYXJ5IHNob3VsZCBub3QgYXNzdW1lIHRoYXQNCmEgdGlt
ZXN0YW1wIGNoYW5uZWwgaXMgZGVmaW5lZC4gSU1ITywgaXQgd291bGQgYmUganVzdCBzaW1wbGVy
IGFuZCBkaXJlY3QgaWYgdXNlcnMgZGVmaW5lIGJ1cnN0X2xlbg0KZGlyZWN0bHkgKHJlcGxhY2lu
ZyBleHRyYV9sZW4pIHdoaWNoIGlzIGFjdHVhbGx5IGNvbnN0YW50IGluIGEgbG90IG9mIGRldmlj
ZXMuLi4NCg0KRWl0aGVyIHdheSwgd2Ugc3RpbGwgbmVlZCBhIHZhcmlhYmxlIGluIHRoZSBhZGlz
IHN0cnVjdCB3aGljaCBjYW4gYWN0dWFsbHkgY2hhbmdlIHBlciAiaW5zdGFuY2UiLi4uDQpNYXli
ZSBJIGp1c3QgZ28gd2l0aCB5b3VyIHN1Z2dlc3Rpb24gYW5kIGxlYXZlIHRoZSByZXBsYWNlbWVu
dCBvZiBleHRyYV9sZW4gZm9yIGEgZnV0dXJlIHBhdGNoLg0KDQotIE51bm8gU8OhDQo=
