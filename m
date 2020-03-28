Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDA1964DA
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 10:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgC1JqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 05:46:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:57414 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgC1JqT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 05:46:19 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02S9k3e8021996;
        Sat, 28 Mar 2020 05:46:03 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 3020bb0dm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Mar 2020 05:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRmsJ0wHoxfQ4MVz5qYye/cRNyXWk04el1uJmYQI8WSrb6iD5lfKNi9sRlqL305gUmJXljkc3SKsItRw3zqSr5B/jyXRMyWvz5+4P1n1Fo5z8OZcTv088O8wnAKqQqisnhF8HzKAGbKGzEyAjFlhm9bcCOWvu5oQHLW4aD0xEFxnwx3eMtSejRHVRjtFJukio0M4KXK/jQKWC+K3ji8QlnG4fMpbte5hOhl+rZFYHrJTpVrDU0JQl8a9gQglIVEy5gxkyLXiVRDGMTmF+jSkq/IsDmPoQEDAyx9umebJvifDbdfVwXoLKLAIIH44/PlOeH4rTphoEnXq0DuUIEbyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksJ8RkZUqkWci3z2vtr1p598bFkqG/eyOKlIlLLE9Ow=;
 b=PIxLBD7uIiVslBoYkvYipmooKEq5ofmx6x40vDvafnJD+pOYw0HwlIYoaX3x9DGSdvf/a985x1nEKOfCp95P+BwmahfaaJv3W0uUgyMsO+SKKTA/Ia3u3xwA5WWaBfHP12JSm/5KzWr/SpI72z6MONjwVV7kP/+Esgd1dOMHVywutVVLbkHUOjwquOxlcKeCEipS5i1PAo4TJh/hL2F7pzp0/8s5rf8sVn+5kFWD8w3EsQGjW1AGpbrQQLzK6JdszHb9b8OFPU/DJ2rxN23Lz8C+b64chKJPHlepU30YTNm0vYOSpg2indMSbgSrw+f2fa2X0C4gEI178b9yJWcA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksJ8RkZUqkWci3z2vtr1p598bFkqG/eyOKlIlLLE9Ow=;
 b=Qd2AcpXPc4KB0BUZCXP3qseGU8m+DXFDSSf24JFvwF57SEmZxIDvKUgHPie2MX3r6+hnXNrFCeiFJYqCjqysW2ymeS8H1YNtbyGQH11Ehjy4wKi0tyy+UjxERuSJnfk4HjKc93WIUkkNtxkGsJCYjtObwKuTHt2Ye+I2BZfp7aE=
Received: from BN6PR03MB3347.namprd03.prod.outlook.com (2603:10b6:405:3d::35)
 by BN6PR03MB3250.namprd03.prod.outlook.com (2603:10b6:405:42::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sat, 28 Mar
 2020 09:46:01 +0000
Received: from BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979]) by BN6PR03MB3347.namprd03.prod.outlook.com
 ([fe80::4097:be14:fb64:1979%7]) with mapi id 15.20.2835.023; Sat, 28 Mar 2020
 09:46:01 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: iio: Fix adi,ltc2983 uint64-matrix schema
 constraints
Thread-Topic: [PATCH] dt-bindings: iio: Fix adi,ltc2983 uint64-matrix schema
 constraints
Thread-Index: AQHWBIlecL/819QfxkqwA7SEmcm996hdwddw
Date:   Sat, 28 Mar 2020 09:46:00 +0000
Message-ID: <BN6PR03MB3347F56F6C3396083F16113199CD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200327224501.18590-1-robh@kernel.org>
In-Reply-To: <20200327224501.18590-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpXUTVNRGcxTmpFdE56QmtPQzB4TVdWaExUaGhNbVF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHVmtPVEE0TlRZekxUY3daRGd0TVRGbFlTMDRZ?=
 =?utf-8?B?VEprTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTkRRNE55?=
 =?utf-8?B?SWdkRDBpTVRNeU1qazROakl6TlRrNU5EQTVPVEE0SWlCb1BTSjBNVkJoUW5K?=
 =?utf-8?B?S09IRjRSR2xxY0dnNU4yaE5NMlpDUXpVMllVRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUXdaWFZ4ZGpWUlZGZEJXV2sxVjBWaWFVRlFURmRwVEd4WlVu?=
 =?utf-8?B?VkpRVGgwV1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-originating-ip: [2001:a61:255c:3401:d8fe:91cd:c864:1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae867837-d695-43c5-0baa-08d7d2fcd31f
x-ms-traffictypediagnostic: BN6PR03MB3250:
x-microsoft-antispam-prvs: <BN6PR03MB32500CCA3F785F773107777D99CD0@BN6PR03MB3250.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR03MB3347.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39850400004)(376002)(396003)(346002)(366004)(66476007)(5660300002)(53546011)(6506007)(33656002)(64756008)(86362001)(110136005)(54906003)(66946007)(316002)(55016002)(66556008)(186003)(81156014)(4326008)(8936002)(66446008)(9686003)(7696005)(81166006)(8676002)(478600001)(52536014)(2906002)(71200400001)(76116006)(142933001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0Xm0HohlxeNq4njJ9JABSf4xiDDLEQit3GYzH0dIrDDztiLa6GYiDfzZkgXwgou8idLTAuywjaLCpgPI5R5NmWGgZHYrhvb76zTFOCm3kUCSR7zZhc/qXVyCmI7I4iallsDRhBBD82iNitvJCcZ1ck4O3JTyjjHIkoe90h87wXjPCnE0gdunYkrkWG+S8/746aMUL1a3Jx520OGScOf9jmNwWkvP82EuFZ8VtHn56WTD/LWD+4sfU7CPl+/XfqspDkCXTOLJ1zXfo+qIR3/kMIshyXAaPEAvPUkd5bQZHjNgBYCwpeJN2Ui06J+dYhbUXiOOS+uFOLbKOot4EJjSR8DCUefv8Kpn2UVKsEfBVa48zeb2J7YgKj/TymIM9KuxN+ZBigGT/pU5Dl5PlFifq5HtPgKXCHP6Agb3keXLkBEmne8SNLq3zD7iZkPecBb5UO0D1Vznq5glCH7xa9GyCzvdn7akPlC2Nt3iZbJ8al0JT5OedMZGNOcUF70PsPf
x-ms-exchange-antispam-messagedata: Djg1c1DE6Gr5JAhCZm4pSsayJjJpoSET2HcmIXVbm6+MJzhAl+mJM6nlMjJ7TthT+hTuPzhucjRdzPpcqaAfLlOZCl2BqQBr5NsHMgmvC5hDJ0ROgWOcKXehkYtXUD0HXEubXojbB1RQ1G/SxNUCkdFQ/LaZFSuD6IZfvT0ugNcADm/vlZCWjlOXxPsGoqErMCzMCiLi71ZD2X5SIPS/6g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae867837-d695-43c5-0baa-08d7d2fcd31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 09:46:01.1373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sIb0whJDkJTb/WBE++70nhTvO/xz6AF9vr32kcRSZzXyt+18fInDDV69Mnw5I965lPHl6kIQkAJNt5tWyz10qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3250
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-28_03:2020-03-27,2020-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003280092
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogRnJlaXRhZywgMjcuIE3DpHJ6IDIwMjAgMjM6NDUNCj4g
VG86IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsNCj4gSm9uYXRoYW4gQ2Ft
ZXJvbiA8amljMjNAa2VybmVsLm9yZz47IEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBnbXguZGU+
Ow0KPiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IFBldGVyIE1lZXJ3YWxk
LVN0YWRsZXINCj4gPHBtZWVyd0BwbWVlcncubmV0PjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBpaW86IEZpeCBhZGksbHRjMjk4MyB1
aW50NjQtbWF0cml4IHNjaGVtYQ0KPiBjb25zdHJhaW50cw0KPg0KPiANCj4gJ21pbkl0ZW1zJyBh
bmQgJ21heEl0ZW1zJyBhcHBseSBhdCB0aGUgc2FtZSBsZXZlbCBhcyAnaXRlbXMnIHNjaGVtYXMg
YXMNCj4gdGhlIGtleXdvcmRzIGFwcGx5IHRvIGFycmF5cy4gV2hhdCdzIGN1cnJlbnRseSBkZWZp
bmVkIGlzIGEgMw0KPiBkaW1lbnNpb25hbCBtYXRyaXggd2l0aCB0aGUgb3V0ZXIgc2l6ZSBiZWlu
ZyB1bmRlZmluZWQuIFRvIGZpeCB0aGlzLA0KPiBtaW5JdGVtcy9tYXhJdGVtcyBuZWVkcyB0byBi
ZSBtb3ZlZCB1cCBhIGxldmVsLg0KPiANCj4gV2l0aCB0aGlzIGZpeGVkLCB0aGUgZXhhbXBsZSBm
YWlscyB2YWxpZGF0aW9uLiBGb3IgbWF0cml4IHR5cGVzLCB0aGUgZHRzDQo+IHN5bnRheCBtdXN0
IHVzZSBicmFja2V0cyAoPD4pIG1hdGNoaW5nIHRoZSBzY2hlbWEgZGVmaW5pdGlvbi4gSW4gdGhp
cw0KPiBjYXNlLCB0aGUgaW5uZXIgYXJyYXkgc2l6ZSBpcyAyIGVsZW1lbnRzLCBzbyBsZXQncyBh
ZGQgdGhlIGNvcnJlY3QNCj4gYnJhY2tldGluZy4NCj4gDQo+IEZpeGVzOiAzOTg2YTE0ODcwY2Ig
KCJkdC1iaW5kaW5nczogaWlvOiBBZGQgbHRjMjk4MyBkb2N1bWVudGF0aW9uIikNCj4gQ2M6ICJO
dW5vIFPDoSIgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gQ2M6IEpvbmF0aGFuIENhbWVyb24gPGpp
YzIzQGtlcm5lbC5vcmc+DQo+IENjOiBIYXJ0bXV0IEtuYWFjayA8a25hYWNrLmhAZ214LmRlPg0K
PiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IENjOiBQZXRlciBN
ZWVyd2FsZC1TdGFkbGVyIDxwbWVlcndAcG1lZXJ3Lm5ldD4NCj4gQ2M6IGxpbnV4LWlpb0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gLS0tDQo+IEknbGwgdGFrZSB0aGlzIHZpYSB0aGUgRFQgdHJlZSBhcyBJIGhhdmUgYW5v
dGhlciBjaGFuZ2UgdGhpcyB3aWxsDQo+IGNvbmZsaWN0Lg0KPiANCj4gUm9iDQo+IA0KPiAgLi4u
L2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55YW1sIHwgMzggKysrKysrKysr
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIwIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFtbA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvYWRpLGx0YzI5ODMueWFtbA0K
PiBpbmRleCBhY2MwMzBjMWIyMGUuLjhmYjQ2ZGU2NjQxZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby90ZW1wZXJhdHVyZS9hZGksbHRjMjk4My55
YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVy
YXR1cmUvYWRpLGx0YzI5ODMueWFtbA0KPiBAQCAtMTIzLDEyICsxMjMsMTEgQEAgcGF0dGVyblBy
b3BlcnRpZXM6DQo+ICAgICAgICAgICAgc2lnbi4NCj4gICAgICAgICAgYWxsT2Y6DQo+ICAgICAg
ICAgICAgLSAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50NjQtbWF0
cml4DQo+ICsgICAgICAgIG1pbkl0ZW1zOiAzDQo+ICsgICAgICAgIG1heEl0ZW1zOiA2NA0KPiAg
ICAgICAgICBpdGVtczoNCj4gLSAgICAgICAgICBtaW5JdGVtczogMw0KPiAtICAgICAgICAgIG1h
eEl0ZW1zOiA2NA0KPiAtICAgICAgICAgIGl0ZW1zOg0KPiAtICAgICAgICAgICAgbWluSXRlbXM6
IDINCj4gLSAgICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ICsgICAgICAgICAgbWluSXRlbXM6IDIN
Cj4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPiANCj4gICAgIl5kaW9kZUAiOg0KPiAgICAgIHR5
cGU6IG9iamVjdA0KPiBAQCAtMzI4LDEyICszMjcsMTEgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+
ICAgICAgICAgICAgNzggYW5kIDc5Lg0KPiAgICAgICAgICBhbGxPZjoNCj4gICAgICAgICAgICAt
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQ2NC1tYXRyaXgNCj4g
KyAgICAgICAgbWluSXRlbXM6IDMNCj4gKyAgICAgICAgbWF4SXRlbXM6IDY0DQo+ICAgICAgICAg
IGl0ZW1zOg0KPiAtICAgICAgICAgIG1pbkl0ZW1zOiAzDQo+IC0gICAgICAgICAgbWF4SXRlbXM6
IDY0DQo+IC0gICAgICAgICAgaXRlbXM6DQo+IC0gICAgICAgICAgICBtaW5JdGVtczogMg0KPiAt
ICAgICAgICAgICAgbWF4SXRlbXM6IDINCj4gKyAgICAgICAgICBtaW5JdGVtczogMg0KPiArICAg
ICAgICAgIG1heEl0ZW1zOiAyDQo+IA0KPiAgICAgICAgYWRpLGN1c3RvbS1zdGVpbmhhcnQ6DQo+
ICAgICAgICAgIGRlc2NyaXB0aW9uOg0KPiBAQCAtNDY1LDE2ICs0NjMsMTYgQEAgZXhhbXBsZXM6
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBhZGksc2Vuc29yLXR5cGUgPSA8OT47IC8vY3Vz
dG9tIHRoZXJtb2NvdXBsZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgYWRpLHNpbmdsZS1l
bmRlZDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGFkaSxjdXN0b20tdGhlcm1vY291cGxl
ID0gL2JpdHMvIDY0DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8KC01MDIy
MDAwMCkgMA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgtMzAyMDAwMDAp
IDk5MTAwMDAwDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKC01MzAwMDAw
KSAxMzU0MDAwMDANCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwIDI3MzE1
MDAwMA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQwMjAwMDAwIDM2MTIw
MDAwMA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1MzAwMDAwIDUyMjEw
MDAwMA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDg4MzAwMDAwIDcyMDMw
MDAwMA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEzMjIwMDAwMCA4MTEy
MDAwMDANCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxODg3MDAwMDAgOTIy
NTAwMDAwDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNDYwNDAwMDAwIDEw
MDAwMDAwMDA+OyAvLzEwIHBhaXJzDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8KC01MDIyMDAwMCkgMD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
KC0zMDIwMDAwMCkgOTkxMDAwMDA+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPCgtNTMwMDAwMCkgMTM1NDAwMDAwPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDwwIDI3MzE1MDAwMD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA8NDAyMDAwMDAgMzYxMjAwMDAwPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDw1NTMwMDAwMCA1MjIxMDAwMDA+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgPDg4MzAwMDAwIDcyMDMwMDAwMD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA8MTMyMjAwMDAwIDgxMTIwMDAwMD4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA8MTg4NzAwMDAwIDkyMjUwMDAwMD4sDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA8NDYwNDAwMDAwIDEwMDAwMDAwMDA+OyAvLzEwIHBhaXJzDQo+ICAgICAg
ICAgICAgICAgICB9Ow0KPiANCj4gICAgICAgICAgfTsNCj4gLS0NCg0KQWNrZWQtYnk6IE51bm8g
U8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQoNClRoYW5rcywNCi0gTnVubyBTw6ENCg0K
