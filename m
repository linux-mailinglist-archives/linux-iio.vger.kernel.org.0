Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2CAEDD85
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 12:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDLM3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 06:12:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37994 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbfKDLM2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 06:12:28 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4B85Hr004294;
        Mon, 4 Nov 2019 06:12:26 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e171v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 06:12:26 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xA4BAZsq006757;
        Mon, 4 Nov 2019 06:12:25 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2056.outbound.protection.outlook.com [104.47.48.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w2a4e171t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 06:12:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6puQoCyYymvez1yOjxmztkWeg1IPWCOK//xzmHMhUUOFM7Gy4ewrh8IJhmByF0tDBowX6f1vBjo72UEWmwGHax8QgqCgNLXRWXWtqebhg1y6iuPbp/yEZSxAJVE1N29iWXjnYkVIf8ZN8ytF0e8Y0SUdcuqcKw2KXsqQLtQ8HR7bljQJvyQP2HDOV4lJNnbdib6KK0WkZ31BqJCynvmCFCTcaL87VXjeVitVEFCUgCVZJuO9tMdUfbpQ5BaPmWcP4TPy4P6weyq3OAro8WO9RYI2XPfTiFQT8m9k7MvIKVnf2RI05XdA0A++4KBpyMidN3UuyfA2JuobUpLCHz+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGlR6AmZQ8w41QIzC5aUa4oFFEk/axfyDAZySwrkoJs=;
 b=cR75zS1WX4n4IVNTmp22DgPgQdKshE/zcFIByAL4WBZUt6rRiYKMokLVH7G6zCyjmSL9EcmbdetYa2XIlO9qw1P+3EqL6WjA38tyqX9XUSdTM0/Hj/2tyZB2xvUP/ZeZRxTHA2dGpSB8dkzcHULKKECxMiOSBW2vmVB/Fl9Y8wNc4esUUa5k7SZKm4sDZCpXJp18H0IdAUuXrXW9fidWQCcey7ptz4NCORV5iPhOXUXkAOD5EvkjHj1ecvxb0iYlQqbn783DSOa5eV8M3KhfK0PYk0sEtu8ubun+GoieVrL4Ow6cB7aCHNtYM3BE3wuyEU/SlgxkwleZO0vJ2R92Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGlR6AmZQ8w41QIzC5aUa4oFFEk/axfyDAZySwrkoJs=;
 b=GM5ePp7jcC0SJ2H4GH5ExBuKsWOlqpxCwmdNnez/svXXUXtFHCWvnMVolwsTOjzb8t6a0eaEsIghxxg18VIdnapUUrruoWf4sR2JpcL3UO+c38veu0bpHjXpym7yv9V36o0XlGaeFl0/MOk8TXXQ841ARQ4GeYnnkewb3NM5+go=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5320.namprd03.prod.outlook.com (20.180.15.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 11:12:24 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 11:12:24 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Subject: Re: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Topic: [PATCH 1/2] iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Index: AQHVjvtrBj5Qf5upT0iyFDGx/fmGzady5qIAgAAFgQCABmi+AIABjp6A
Date:   Mon, 4 Nov 2019 11:12:24 +0000
Message-ID: <f12d9cae7f120898a5bccbd50466a9d9efd4f889.camel@analog.com>
References: <1572423581-59762-1-git-send-email-zhongjiang@huawei.com>
         <1572423581-59762-2-git-send-email-zhongjiang@huawei.com>
         <fb8722ad2c1ef51944dc814a7b24433f4348721e.camel@analog.com>
         <5DB958DA.7080305@huawei.com> <20191103112540.5fdfccad@archlinux>
In-Reply-To: <20191103112540.5fdfccad@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f160e06f-d85f-4114-cab1-08d76117de94
x-ms-traffictypediagnostic: CH2PR03MB5320:
x-ms-exchange-purlcount: 2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5320084B27E0C4D27CEC9CF2F97F0@CH2PR03MB5320.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6246003)(54906003)(110136005)(478600001)(14454004)(99286004)(2616005)(36756003)(118296001)(76176011)(4001150100001)(86362001)(316002)(6506007)(53546011)(26005)(186003)(107886003)(102836004)(5660300002)(476003)(71190400001)(229853002)(14444005)(6486002)(256004)(6512007)(2906002)(71200400001)(76116006)(66946007)(7736002)(6436002)(25786009)(11346002)(66066001)(81166006)(6116002)(3846002)(305945005)(2501003)(4326008)(446003)(8936002)(81156014)(66556008)(64756008)(66446008)(6306002)(966005)(8676002)(66476007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5320;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tjjx3HOy3glidQccq9r5gPfs16vDS7QWkwmZalXVpTMBuCHe2FaL4PxdC5Ops3YPGDliVXi1mWTWet5N5QTbbnMk6lsKZNyffi+3pid4fHdOHluuD6yMs33MmciqsfUnQ7PEIawfxs46GbzfTvqU6kq0q6EqIlTPutMqFhYNDVsR4uL9lTQ4FCnJ3bau6Cvh/WeUa70HKJpCzJZeY23gZ6uACra3WDjbtTejDF3y7sF4LN4Juqhzy/plzJ/khAgHI//jz5UG3GpBvKajFsoQbwe0T76n0JW1kPU9iyHrNG9faYHeM5vgGWS0SZ6QmTISraRMdGdPRVxGzi7jNJ4+Ocro1bs6dGF8iBhpgTyEcfif4iPjzQfBfCyJxh/bdOrjRJTmw00dvA+Rdv3TD0nIXHbN19OKlEbIdMOKjVlKjPhIYe0tQe7e/pGI2vbyPCXLxh9rPsSZf92zTcjXn/9YDGZroWaSxFwKfryCB8vRI6I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99335FA53A4274185BD400E5A199CF3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f160e06f-d85f-4114-cab1-08d76117de94
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 11:12:24.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97mMrlrpFTrl9rCasQ5ecWsm1lJeZLR2ZMXYyhcGVjsiGpNH5DjSCwNl0EX3g7Fm+vKfRLpiQvrwv95+x0tO23mjfjfbK+kHa4DJVMouhak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5320
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTExLTAzIGF0IDExOjI1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBXZWQsIDMwIE9jdCAyMDE5IDE3OjMzOjE0ICswODAwDQo+IHpob25nIGppYW5nIDx6
aG9uZ2ppYW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gPiBPbiAyMDE5LzEwLzMwIDE3OjEz
LCBBcmRlbGVhbiwgQWxleGFuZHJ1IHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMDE5LTEwLTMwIGF0
IDE2OjE5ICswODAwLCB6aG9uZyBqaWFuZyB3cm90ZTogIA0KPiA+ID4gPiBbRXh0ZXJuYWxdDQo+
ID4gPiA+IA0KPiA+ID4gPiBJdCBpcyBtb3JlIGNsZWFyIHRvIHVzZSBERUZJTkVfREVCVUdGU19B
VFRSSUJVVEUgdG8gZGVmaW5lIGRlYnVnZnMNCj4gPiA+ID4gZmlsZQ0KPiA+ID4gPiBvcGVyYXRp
b24gcmF0aGVyIHRoYW4gREVGSU5FX1NJTVBMRV9BVFRSSUJVVEUuICANCj4gPiA+IE5vdCBzdXJl
IGlmICJtb3JlIGNsZWFyIiBpcyB0aGUgd29yZC4gIA0KPiA+IFNob3VsZCBiZSBtb3JlIGNsZWFy
bHkuIDotKQ0KPiA+ID4gQnV0IGl0IGlzIG1vcmUgY29ycmVjdCB0byB1c2UgREVGSU5FX0RFQlVH
RlNfQVRUUklCVVRFKCksIHNpbmNlIHRoZXkNCj4gPiA+IGFyZQ0KPiA+ID4gZGVidWdmcyBhdHRy
cy4NCj4gPiA+IA0KPiA+ID4gSW4gYW55IGNhc2UsIHRoaXMgaXMgbm8gYmlnIGRlYWwuDQo+ID4g
PiBTbzoNCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxl
eGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiAgDQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IHpob25nIGppYW5nIDx6aG9uZ2ppYW5nQGh1YXdlaS5jb20+DQo+IEkgc3RhcnRlZCBsb29r
aW5nIGludG8gd2h5IHRoaXMgYXR0cmlidXRlcyB3ZXJlIGludHJvZHVjZWQuDQo+IFRoZXJlIGFy
ZSBwb3RlbnRpYWwgaXNzdWVzLCBzbyBBbGV4IGNhbiB5b3UgY29uZmlybSB5b3UndmUgdGVzdGVk
IHRoaXMNCj4gc2VyaWVzLiAgV2hpbHN0IGl0IGxvb2tzIHJpZ2h0LCBpdCBzZWVtcyBzb21lIG90
aGVyIHBhdGNoZXMgbWFraW5nIHRoaXMNCj4gY2hhbmdlIGhhdmUgaGFkIHRvIHN3aXRjaCBvdmVy
IHRvIHRoZSB1bnNhZmUgcmVnaXN0cmF0aW9uIGZ1bmN0aW9ucy4NCg0KSSBoYXZlbid0IHRlc3Rl
ZCB0aGlzIGxvY2FsbHkgeWV0Lg0KV2lsbCB0cnkgdG8gYWxsb2Mgc29tZSB0aW1lIGZvciB0aGlz
Lg0KDQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMDUxNzI1Lw0K
PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xMC8zMC8xNDQNCj4gDQo+IFRoZSByZWZlcmVu
Y2UgY291bnRpbmcgaXMgc3VidGx5IGRpZmZlcmVudCBiZXR3ZWVuIHRoZSB0d28gdmVyc2lvbnMu
DQo+IFNlZW1zIHlvdSBhcmUgZ2V0dGluZyBzb21lIHB1c2ggYmFjayBvbiBzaW1pbGFyIHBhdGNo
ZXMuDQo+IA0KPiBQZXJoYXBzIGEgdjIgd2l0aCByZWZlcmVuY2UgdG8gdGhlIG90aGVyIHRocmVh
ZHMgaWYgdGhvc2UgZ2V0IHJlc29sdmVkDQo+IHRvIHNheSBpdCBpcyBzZW5zaWJsZSB0byBtYWtl
IHRoaXMgY2hhbmdlLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IA0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NjAuYyB8IDYgKysrLS0t
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0
NjAuYw0KPiA+ID4gPiBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NjAuYw0KPiA+ID4gPiBpbmRl
eCA2YWVkOWU4Li4yZTdhNTgyIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUv
YWRpczE2NDYwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9paW8vaW11L2FkaXMxNjQ2MC5jDQo+
ID4gPiA+IEBAIC04Nyw3ICs4Nyw3IEBAIHN0YXRpYyBpbnQgYWRpczE2NDYwX3Nob3dfc2VyaWFs
X251bWJlcih2b2lkDQo+ID4gPiA+ICphcmcsIHU2NA0KPiA+ID4gPiAqdmFsKQ0KPiA+ID4gPiAg
DQo+ID4gPiA+ICAJcmV0dXJuIDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IC1ERUZJTkVfU0lNUExF
X0FUVFJJQlVURShhZGlzMTY0NjBfc2VyaWFsX251bWJlcl9mb3BzLA0KPiA+ID4gPiArREVGSU5F
X0RFQlVHRlNfQVRUUklCVVRFKGFkaXMxNjQ2MF9zZXJpYWxfbnVtYmVyX2ZvcHMsDQo+ID4gPiA+
ICAJYWRpczE2NDYwX3Nob3dfc2VyaWFsX251bWJlciwgTlVMTCwgIjB4JS40bGx4XG4iKTsNCj4g
PiA+ID4gIA0KPiA+ID4gPiAgc3RhdGljIGludCBhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkKHZv
aWQgKmFyZywgdTY0ICp2YWwpDQo+ID4gPiA+IEBAIC0xMDUsNyArMTA1LDcgQEAgc3RhdGljIGlu
dCBhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkKHZvaWQgKmFyZywNCj4gPiA+ID4gdTY0DQo+ID4g
PiA+ICp2YWwpDQo+ID4gPiA+ICANCj4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4gIH0NCj4g
PiA+ID4gLURFRklORV9TSU1QTEVfQVRUUklCVVRFKGFkaXMxNjQ2MF9wcm9kdWN0X2lkX2ZvcHMs
DQo+ID4gPiA+ICtERUZJTkVfREVCVUdGU19BVFRSSUJVVEUoYWRpczE2NDYwX3Byb2R1Y3RfaWRf
Zm9wcywNCj4gPiA+ID4gIAlhZGlzMTY0NjBfc2hvd19wcm9kdWN0X2lkLCBOVUxMLCAiJWxsdVxu
Iik7DQo+ID4gPiA+ICANCj4gPiA+ID4gIHN0YXRpYyBpbnQgYWRpczE2NDYwX3Nob3dfZmxhc2hf
Y291bnQodm9pZCAqYXJnLCB1NjQgKnZhbCkNCj4gPiA+ID4gQEAgLTEyMyw3ICsxMjMsNyBAQCBz
dGF0aWMgaW50IGFkaXMxNjQ2MF9zaG93X2ZsYXNoX2NvdW50KHZvaWQNCj4gPiA+ID4gKmFyZywg
dTY0DQo+ID4gPiA+ICp2YWwpDQo+ID4gPiA+ICANCj4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+
ID4gIH0NCj4gPiA+ID4gLURFRklORV9TSU1QTEVfQVRUUklCVVRFKGFkaXMxNjQ2MF9mbGFzaF9j
b3VudF9mb3BzLA0KPiA+ID4gPiArREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKGFkaXMxNjQ2MF9m
bGFzaF9jb3VudF9mb3BzLA0KPiA+ID4gPiAgCWFkaXMxNjQ2MF9zaG93X2ZsYXNoX2NvdW50LCBO
VUxMLCAiJWxsZFxuIik7DQo+ID4gPiA+ICANCj4gPiA+ID4gIHN0YXRpYyBpbnQgYWRpczE2NDYw
X2RlYnVnZnNfaW5pdChzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KSAgDQo=
