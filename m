Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8324619A62E
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbgDAHWd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 03:22:33 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32042 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731818AbgDAHWd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 03:22:33 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0317GaJt019217;
        Wed, 1 Apr 2020 03:22:11 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 3023g5bgc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 03:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgCFumkWTQemiK77QlV6EAJjeeMEr8YdDkYxJD3dLrbxpD5QmqWr86h4b0049Efuq/5P5msOa3BL85cYqOum0975AEXmNcVFvcwXen09zMsyjgBCGHz5kj9zA35k7qghWvp7JJFEi3Dxx2RR00QI4I+2J8NYz6j69aIRxlCmjJ9K9Pe2gP8jEH4wTVNDGcltVRQmKOsPCOQ5uKizwKzrt7FSjyzmJ1vb8d3KPvEO2VIaNJq/CauqnvVY6THAbOPYc/JZocrGSKNE29X2UzoOQt8COY/uTv77HEmBWkdetjDhyDLkJQWZI5WTV2BXgMURPH55iRw2pdR5Q5+Lb160Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McVCNtb1ktXuB+K/2g/MdJQokSWscfo6FS9y1JgMI8c=;
 b=GNXTy0wr1Wakjf5FnEXR+6n4FOBXAGkVSbaxQSvfy3eKnJxhLnmgJ8epzpRUW0ha46B8JjcxZoVarSRGAOga1s8BlrmHCMYEWiZPZmHyHXroKx97dDXAxJBFF8oHbPOw8v+/6CXIP5FkiXLW7eHPjnc4T1Dq2AiH+L/Cew9gBvG8kTa8VDoQiH6ONhA0VmxW355KK7Yv0vfDgFrTQ+VXndV+qlCoovAueA62a1rtjZXmy0fAZGhTY5h6V0/6deEzuk2PCpgfigoMEzIGvQjl0/RuqpK3tHdN02FvVmfTAvKKlyXSNHMuqD+gU9W2PNaO3HbI3vyf+UNNiGJqH1PKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McVCNtb1ktXuB+K/2g/MdJQokSWscfo6FS9y1JgMI8c=;
 b=pvcxg5g54EM+eRG863Oicy1FaGbnmrsFSH9YtsvO0oHFjl7heX6pcI8cW4yWJggDBzjnqCxFr2jfm3p8CmAcS3OMPGCN27kZ+ohaNptqjSpdKuFtFgXMAPiajRDvctozU97tzQlLwTLx6JhYUnZt6p1j/OLGf8mtVCCJdSmGO7o=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB2996.namprd03.prod.outlook.com (2603:10b6:404:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 07:22:09 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 07:22:09 +0000
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
Subject: RE: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
Thread-Topic: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
Thread-Index: AQHWB1JXGSpmkJ3opUGHDYpi/3D/j6hi+CsAgADjkaA=
Date:   Wed, 1 Apr 2020 07:22:09 +0000
Message-ID: <BN6PR03MB3347F9B31FE4E82904ED3E8C99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
 <20200331114811.7978-3-nuno.sa@analog.com>
 <CAHp75VfXS1P-EJaKERojK=-3erYi5MxyDMjfrELyY2X3PZEN1A@mail.gmail.com>
In-Reply-To: <CAHp75VfXS1P-EJaKERojK=-3erYi5MxyDMjfrELyY2X3PZEN1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE4yUTBOREl4TVdZdE56TmxPUzB4TVdWaExUaGhNekV0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEZGtORFF5TVRJd0xUY3paVGt0TVRGbFlTMDRZ?=
 =?utf-8?B?VE14TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTWpRMU1T?=
 =?utf-8?B?SWdkRDBpTVRNeU16QXhPVGt6TWpZMk56YzJNamN4SWlCb1BTSkZPR3hwWjBo?=
 =?utf-8?B?blRFeG5halZ0ZWxaS1NFb3JhRUZNTlhGUWVqZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUlFRMHcwTHpsblpsZEJVVEZFZFVKS1JXZzROMlpFVlU4MFJX?=
 =?utf-8?B?dFRTSHAwT0VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [2001:a61:2422:3901:c912:5684:2cfe:d6d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa713ba2-0505-492c-837c-08d7d60d63cd
x-ms-traffictypediagnostic: BN6PR03MB2996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR03MB2996850BA94DE847AB2582B999C90@BN6PR03MB2996.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(2906002)(316002)(86362001)(66574012)(4326008)(107886003)(186003)(6916009)(8676002)(52536014)(478600001)(81156014)(64756008)(8936002)(81166006)(9686003)(76116006)(53546011)(6506007)(54906003)(33656002)(7696005)(66946007)(71200400001)(66446008)(5660300002)(55016002)(66476007)(66556008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYRdA+OnRPrtOrz6A+qfnW3z9AIIwaPE7fr5+CqyfiZYNSh2R3ZWYBa0gqDf/uKU8NhsGTzcO7OvEZPdMRYUBILH4qIAvF4xoY3MbmvozRkxGDPjVA387E/Ska423l5oBV5a/2zwZc6suo+9JiP+VyXkCKIleExbJ7m5CQXgZfA4f9+zHIsgwHBofR1JqqpAPQ+SR+AI8TCaVcg91J4eqmPDEmYriXI3fug5ci0ux8TtoZHlUdtsdooE6lroo/I7rZlf5uMMze7FYySLSdDSt3tP3P4wTdbL+CQb/PAeILAzOBRzstP1tWoRQaLP/SS5X++EldMi6DOtAUSWd0gyibSknd7wrNajeL7XyfOkLUhPigdE+oflppi8+BbuF1BVa8RQ084jPD/AykkuvCBSIgRvc/iyMhPtv1ddgAqBY2bbT9Lk0FJaB/clGAZKd6Qg
x-ms-exchange-antispam-messagedata: LSXUZTNf9nCVIefCxbs5cETExLLJtXnKw8lEN5ghbPCUr5BYz21UnS1Gc7BCDaF6Dqfi1PrMX3gWApZZWp2OGsUp5EJUtAq8dinQ71IlV84Bd8nosoUjrhWazTYzqUzHyQBgRH/uYb1hXWh34IQZHUh5D7ID0Wxf+l1E9wpLkJyhkDauur8hGrpyobYFlidktCKymRi8Mkfdc8wiWfE2Pg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa713ba2-0505-492c-837c-08d7d60d63cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 07:22:09.2007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdGYDdk4Fk8f0RGrC4qHX2daE+FbTIi/khqlAfocSWMoMezG4w8xkKAQJrCnR02au9Rw1RVL3BKpZ9JsYPD5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2996
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010066
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBsaW51eC1paW8tb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1paW8tb3duZXJA
dmdlci5rZXJuZWwub3JnPiBPbg0KPiBCZWhhbGYgT2YgQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6
IERpZW5zdGFnLCAzMS4gTcOkcnogMjAyMCAxOTo0MA0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FA
YW5hbG9nLmNvbT4NCj4gQ2M6IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47
IGRldmljZXRyZWUNCj4gPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz47DQo+IEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBnbXgu
ZGU+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IFBldGVyIE1lZXJ3
YWxkLVN0YWRsZXIgPHBtZWVyd0BwbWVlcncubmV0PjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRA
a2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBcmRlbGVh
biwNCj4gQWxleGFuZHJ1IDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT47IEhlbm5lcmlj
aCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAyLzZdIGlpbzogaW11OiBhZGlzOiBBZGQgaXJxIG1hc2sgdmFyaWFibGUN
Cj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgTWFyIDMxLCAyMDIwIGF0IDI6NDkgUE0g
TnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGVyZSBhcmUg
c29tZSBBRElTIGRldmljZXMgdGhhdCBjYW4gY29uZmlndXJlIHRoZSBkYXRhIHJlYWR5IHBpbg0K
PiA+IHBvbGFyaXR5LiBIZW5jZSwgd2UgY2Fubm90IGhhcmRjb2RlIG91ciBJUlEgbWFzayBhcw0K
PiBJUlFGX1RSSUdHRVJfUklTSU5HDQo+ID4gc2luY2Ugd2UgbWlnaHQgd2FudCB0byBoYXZlIGl0
IGFzIElSUUZfVFJJR0dFUl9GQUxMSU5HLg0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgaW50
IGFkaXNfdmFsaWRhdGVfaXJxX21hc2soc3RydWN0IGFkaXMgKmFkaXMpDQo+ID4gK3sNCj4gPiAr
ICAgICAgIGlmICghYWRpcy0+aXJxX21hc2spIHsNCj4gPiArICAgICAgICAgICAgICAgYWRpcy0+
aXJxX21hc2sgPSBJUlFGX1RSSUdHRVJfUklTSU5HOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gDQo+ID4gKyAgICAgICB9IGVsc2UgaWYgKGFkaXMtPmlycV9tYXNrICE9IElSUUZf
VFJJR0dFUl9SSVNJTkcgJiYNCj4gDQo+ICdlbHNlJyBpcyByZWR1bmRhbnQuDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgICAgICBhZGlzLT5pcnFfbWFzayAhPSBJUlFGX1RSSUdHRVJfRkFMTElORykg
ew0KPiANCj4gQnV0IHRoaXMgY29uZGl0aW9uIHJpc2VzIHF1ZXN0aW9ucy4gV2h5IGkgY2FuJ3Qg
Y29uZmlndXJlIGJvdGg/DQo+IFdoeSBJIGNhbid0IGNvbmZpZ3VyZSBvdGhlciBmbGFncyB0aGVy
ZT8NCg0KQm90aCB5b3UgY2FuJ3QgYmVjYXVzZSBpdCBpcyBqdXN0IGhvdyB0aGVzZSB0eXBlIG9m
IGRldmljZXMgd29yay4gRGF0YSBpcyByZWFkeSBlaXRoZXINCm9uIHRoZSByaXNpbmcgZWRnZSBv
ciBvbiB0aGUgZmFsbGluZyBlZGdlIChpZiBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZSkuLi4NCkkg
YWdyZWUgdGhpcyBjb3VsZCBjaGVjayBpZiBvbmx5IG9uZSBvZiB0aGUgZmxhZ3MgYXJlIHNldCBp
bnN0ZWFkIG9mIGRpcmVjdGx5IGNvbXBhcmluZyB0aGUNCnZhbHVlcyAoaW52YWxpZGF0aW5nIG90
aGVyIGZsYWdzKSBidXQgSSB3b3VsZCBwcmVmZXIgdG8ga2VlcCB0aGlzIHNpbXBsZSBmb3Igbm93
Li4uDQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoJmFkaXMtPnNwaS0+ZGV2LCAi
SW52YWxpZCBJUlEgbWFzazogJTA4bHhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
YWRpcy0+aXJxX21hc2spOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
PiArICAgICAgIH0NCj4gDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gQW5k
IGFjdHVhbGx5IG5hbWUgb2YgdGhlIGZ1bmN0aW9uIGlzIG5vdCBleGFjdGx5IHdoYXQgaXQgZG9l
cy4gSXQNCj4gdmFsaWRhdGVzICpvciogaW5pdGlhbGl6ZXMuDQoNCldlbGwsIHllcy4gSXQganVz
dCBzZXRzIHRoZSBtYXNrIHRvIHRoZSBkZWZhdWx0IHZhbHVlIHRvIGtlZXAgYmFja3dhcmQgY29t
cGF0aWJpbGl0eQ0Kd2l0aCBhbGwgdGhlIG90aGVyIGRldmljZXMgdGhhdCBkb24ndCBzdXBwb3J0
L3VzZSB0aGlzIHZhcmlhYmxlLi4uDQoNCi0gTnVubyBTw6ENCj4gDQo+IC0tDQo+IFdpdGggQmVz
dCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
