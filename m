Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D02CDF13
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJGKSY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:18:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29976 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbfJGKSY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:18:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97AHhiO005803;
        Mon, 7 Oct 2019 06:18:22 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2050.outbound.protection.outlook.com [104.47.49.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ver39fb3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 06:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YemGq3/V6GbMeZS12GptKEXupQT8ND70wi1d5xGLAtyhdi+vEzrhZeDE3GMF41DYwbnJ53cCkEPH6yq1WhH0FKrIFPW7Jaq3GiuRhSRc0at7kcZtSf76J2e/VztwkBKuGG+UsvqV7MIGt3UPx10nEotaLkaWkCfSkBJukm+1bOzRW6PgyUAZWjD15bFxtuc8B/5QoLrdsdcTCKPcEW/J/mRYJiLSPoqAxjPFdooGZJhp9K0z6bww4MMMbHdpw9gf+wxa+EJCAAna87u+d7YhyK7oYJwpx9PJVn8KAswHBSoVMQfeprVcO0IBQ+CFq+WCCshkZRjaknqVaEudoXfGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6QAaYPwngnZ7NPrTEJfvCRl97qa8X2pxBKJe5JGZwk=;
 b=aukiB71SD96HYr5/0CsqP12+vNLuHaXOnymkGetILBcQwWoKd0IIGSMnWgr4iNDViPBEfh4WGB0LQ0kFT7z26ZII9V+bowbsr9kIINRdbgGljq+Y0vQ5nBYydANtJBxq5M8gvq11caIvaxB1CqsAMDZvA464DLgVC+XygpzHKXVyerSi6IZov/seD58tvqttl6OKR0J7ujnnQ4KgxZiyrivzBaBEmHExqIpGTn1wJbhs9ZhaNIi+vZV8kNdsVUdAdH7uMzvFhHzXFFd7yR/W8wEoqJk2v20rDtByRVt2j0ZvWQNf16LUdaMq1PChw5cLgmO+u+B25OctelTug6El8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6QAaYPwngnZ7NPrTEJfvCRl97qa8X2pxBKJe5JGZwk=;
 b=mUA2M3NKVfBGr+32LB3JzUWVLq1bQXoyPAIKQaxlWApier3TEiZZ7/+m3F7ICzZqmD5HByE4FpGn+Vw0x/GXykKrmIA0qE82iqASI3+NRlmfa0Be4BIGOqwfL59mCqFv7rACNbvPHmT8WFUcCdqXv4iZE2BswK6ZOGVH7BNgwdA=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5157.namprd03.prod.outlook.com (20.180.15.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 10:18:20 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 10:18:20 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 01/10] iio: imu: adis: rename txrx_lock -> state_lock
Thread-Topic: [PATCH 01/10] iio: imu: adis: rename txrx_lock -> state_lock
Thread-Index: AQHVdFweL7rQbVq53US3TEt39UnA06dNXliAgAADiwCAAaaDAA==
Date:   Mon, 7 Oct 2019 10:18:20 +0000
Message-ID: <9475e695fedf1cc8f71191ac25e06c3a8297c8f4.camel@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
         <20190926111812.15957-2-alexandru.ardelean@analog.com>
         <20191006095333.7532cc5e@archlinux> <20191006100604.6425167c@archlinux>
In-Reply-To: <20191006100604.6425167c@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bee3017-d751-4737-9d46-08d74b0fad67
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5157:
x-microsoft-antispam-prvs: <CH2PR03MB5157452CABEC0AACE11E3403F99B0@CH2PR03MB5157.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(229853002)(6486002)(14454004)(6436002)(6916009)(6116002)(8936002)(2906002)(5640700003)(478600001)(3846002)(2351001)(6512007)(76176011)(66446008)(64756008)(66556008)(81166006)(8676002)(99286004)(81156014)(54906003)(25786009)(316002)(14444005)(256004)(6246003)(66476007)(66946007)(76116006)(186003)(4326008)(118296001)(7736002)(102836004)(305945005)(86362001)(71200400001)(71190400001)(26005)(66066001)(36756003)(446003)(11346002)(476003)(486006)(2616005)(6506007)(5660300002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5157;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8dUJ9yJGqcqhWd6d7j+Rd/5qnVqCp2GN1ZXj/Xc5y1+zhNfI88npg3R/+v1m5p9qrO3Dbl/TfTWZ1qR4W4FpMjhYmc7b+2zBtYbdQTrQug2mBYU6gIZDqYU/+1+D5r9Ag7ifkHQBNkvRFgRg56mCeRynY6YSIvZQRP96WONd9/oE9Ru8rWh0kUAi8D+9XRwfuECUblEOniLGPB+x+Xr2I/I1iyx9U2U9p6pXCRJ30QIYbZY9eaWqvLUJIFX3bYo3oWhaOisvGKQLAp3lSmLVRwLj6/qWaT59TvwzCQImG4l6NaIRHCdqydKD3Jtqte9Hss3oySkUbId6pp43JAxpo0y14zXx99JWQLzJPph1XzoyyVxmJljxO3fzPJYlpHSeavlhVcXQZhrdsW5Qglu/p/c7BBNCU0yu238PFbjTZE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <422BCEA666F6E043900B1964F0840ED4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bee3017-d751-4737-9d46-08d74b0fad67
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 10:18:20.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkZhLxklnxRceCTymUOx5XD3mkOXUZuWQ0ZFJBkjKsk56msOa02wFugOzkiEh09c0arJXoguryZ/5h+cvZLtvEo8IajHq4I9ocMxE3I5WGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5157
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTA2IGF0IDEwOjA2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBTdW4sIDYgT2N0IDIwMTkgMDk6NTM6MzMgKzAxMDAN
Cj4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiA+IE9u
IFRodSwgMjYgU2VwIDIwMTkgMTQ6MTg6MDMgKzAzMDANCj4gPiBBbGV4YW5kcnUgQXJkZWxlYW4g
PGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IFRoZSBs
b2NrIGNhbiBiZSBleHRlbmRlZCBhIGJpdCB0byBwcm90ZWN0IG90aGVyIGVsZW1lbnRzIHRoYXQg
YXJlIG5vdA0KPiA+ID4gcGFydGljdWxhciB0byBqdXN0IFRYL1JYLiBBbm90aGVyIGlkZWEgd291
bGQgaGF2ZSBiZWVuIHRvIGp1c3QgYWRkIGENCj4gPiA+IG5ldw0KPiA+ID4gYHN0YXRlX2xvY2tg
LCBidXQgdGhhdCB3b3VsZCBtZWFuIDIgbG9ja3Mgd2hpY2ggd291bGQgYmUgcmVkdW5kYW50LA0K
PiA+ID4gYW5kDQo+ID4gPiBwcm9iYWJseSBjYXVzZSBtb3JlIHBvdGVudGlhbCBmb3IgZGVhZC1s
b2Nrcy4NCj4gPiA+IA0KPiA+ID4gV2hhdCB3aWxsIGJlIGRvbmUgaW4gdGhlIG5leHQgcGF0Y2hl
cywgd2lsbCBiZSB0byBhZGQgc29tZSB1bmxvY2tlZA0KPiA+ID4gdmVyc2lvbnMgZm9yIHJlYWQv
d3JpdGVfcmVnIGZ1bmN0aW9ucy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFu
ZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gIA0KPiA+IA0KPiA+
IFdvdWxkIGJlIGdvb2QgdG8gZG9jdW1lbnQgdGhlIHNjb3BlIG9mIHRoZSBsb2NrIGFzIGEgY29t
bWVudCB3aGVuIGl0DQo+ID4gaXMgZGVmaW5lZC4gIFdoYXQgZXhhY3RseSBpcyAnc3RhdGUnIGlu
IHRoaXMgY2FzZT8NCj4gQXMgdGhpcyBjYW4gYmUgZG9uZSBhcyBhIGZvbGxvdyB1cCBhbmQgdGhl
IHJlc3Qgb2YgdGhlIHNlcmllcyBpcyBmaW5lDQo+IGFzIGlzLi4uDQo+IA0KDQpXaWxsIGRvLg0K
DQo+IEFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91
dCBhcyB0ZXN0aW5nIGZvcg0KPiB0aGUgYXV0b2J1aWxkZXJzIHRvIHBsYXkgd2l0aCBpdC4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IFRoYW5rcywNCj4gPiANCj4gPiBK
b25hdGhhbg0KPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vaW11L2FkaXMuYyAg
ICAgICAgfCAxMCArKysrKy0tLS0tDQo+ID4gPiAgZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVy
LmMgfCAgNCArKy0tDQo+ID4gPiAgaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaCAgfCAgMiAr
LQ0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vaW11L2FkaXMuYyBiL2Ry
aXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gPiA+IGluZGV4IDE2MzFjMjU1ZGVhYi4uM2MyZDg5NmUz
YTk2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+ID4gQEAgLTcwLDcgKzcwLDcgQEAgaW50IGFk
aXNfd3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQNCj4gPiA+IHJlZywN
Cj4gPiA+ICAJCX0sDQo+ID4gPiAgCX07DQo+ID4gPiAgDQo+ID4gPiAtCW11dGV4X2xvY2soJmFk
aXMtPnR4cnhfbG9jayk7DQo+ID4gPiArCW11dGV4X2xvY2soJmFkaXMtPnN0YXRlX2xvY2spOw0K
PiA+ID4gIA0KPiA+ID4gIAlzcGlfbWVzc2FnZV9pbml0KCZtc2cpOw0KPiA+ID4gIA0KPiA+ID4g
QEAgLTExNCw3ICsxMTQsNyBAQCBpbnQgYWRpc193cml0ZV9yZWcoc3RydWN0IGFkaXMgKmFkaXMs
IHVuc2lnbmVkDQo+ID4gPiBpbnQgcmVnLA0KPiA+ID4gIAl9DQo+ID4gPiAgDQo+ID4gPiAgb3V0
X3VubG9jazoNCj4gPiA+IC0JbXV0ZXhfdW5sb2NrKCZhZGlzLT50eHJ4X2xvY2spOw0KPiA+ID4g
KwltdXRleF91bmxvY2soJmFkaXMtPnN0YXRlX2xvY2spOw0KPiA+ID4gIA0KPiA+ID4gIAlyZXR1
cm4gcmV0Ow0KPiA+ID4gIH0NCj4gPiA+IEBAIC0xNjYsNyArMTY2LDcgQEAgaW50IGFkaXNfcmVh
ZF9yZWcoc3RydWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkIGludA0KPiA+ID4gcmVnLA0KPiA+ID4g
IAkJfSwNCj4gPiA+ICAJfTsNCj4gPiA+ICANCj4gPiA+IC0JbXV0ZXhfbG9jaygmYWRpcy0+dHhy
eF9sb2NrKTsNCj4gPiA+ICsJbXV0ZXhfbG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQo+ID4gPiAg
CXNwaV9tZXNzYWdlX2luaXQoJm1zZyk7DQo+ID4gPiAgDQo+ID4gPiAgCWlmIChhZGlzLT5jdXJy
ZW50X3BhZ2UgIT0gcGFnZSkgew0KPiA+ID4gQEAgLTIxMSw3ICsyMTEsNyBAQCBpbnQgYWRpc19y
ZWFkX3JlZyhzdHJ1Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50DQo+ID4gPiByZWcsDQo+ID4g
PiAgCX0NCj4gPiA+ICANCj4gPiA+ICBvdXRfdW5sb2NrOg0KPiA+ID4gLQltdXRleF91bmxvY2so
JmFkaXMtPnR4cnhfbG9jayk7DQo+ID4gPiArCW11dGV4X3VubG9jaygmYWRpcy0+c3RhdGVfbG9j
ayk7DQo+ID4gPiAgDQo+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4gQEAgLTQz
Nyw3ICs0MzcsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChhZGlzX3NpbmdsZV9jb252ZXJzaW9uKTsN
Cj4gPiA+ICBpbnQgYWRpc19pbml0KHN0cnVjdCBhZGlzICphZGlzLCBzdHJ1Y3QgaWlvX2RldiAq
aW5kaW9fZGV2LA0KPiA+ID4gIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBjb25zdCBzdHJ1Y3Qg
YWRpc19kYXRhICpkYXRhKQ0KPiA+ID4gIHsNCj4gPiA+IC0JbXV0ZXhfaW5pdCgmYWRpcy0+dHhy
eF9sb2NrKTsNCj4gPiA+ICsJbXV0ZXhfaW5pdCgmYWRpcy0+c3RhdGVfbG9jayk7DQo+ID4gPiAg
CWFkaXMtPnNwaSA9IHNwaTsNCj4gPiA+ICAJYWRpcy0+ZGF0YSA9IGRhdGE7DQo+ID4gPiAgCWlp
b19kZXZpY2Vfc2V0X2RydmRhdGEoaW5kaW9fZGV2LCBhZGlzKTsNCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiA+ID4gYi9kcml2ZXJzL2lpby9pbXUv
YWRpc19idWZmZXIuYw0KPiA+ID4gaW5kZXggOWFjODM1NmQ5YTk1Li5iZjU4MWEyYzMyMWQgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiA+IEBAIC0xMjMsNyArMTIzLDcg
QEAgc3RhdGljIGlycXJldHVybl90IGFkaXNfdHJpZ2dlcl9oYW5kbGVyKGludCBpcnEsDQo+ID4g
PiB2b2lkICpwKQ0KPiA+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gPiAgDQo+ID4gPiAgCWlm
IChhZGlzLT5kYXRhLT5oYXNfcGFnaW5nKSB7DQo+ID4gPiAtCQltdXRleF9sb2NrKCZhZGlzLT50
eHJ4X2xvY2spOw0KPiA+ID4gKwkJbXV0ZXhfbG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQo+ID4g
PiAgCQlpZiAoYWRpcy0+Y3VycmVudF9wYWdlICE9IDApIHsNCj4gPiA+ICAJCQlhZGlzLT50eFsw
XSA9IEFESVNfV1JJVEVfUkVHKEFESVNfUkVHX1BBR0VfSUQpOw0KPiA+ID4gIAkJCWFkaXMtPnR4
WzFdID0gMDsNCj4gPiA+IEBAIC0xMzgsNyArMTM4LDcgQEAgc3RhdGljIGlycXJldHVybl90IGFk
aXNfdHJpZ2dlcl9oYW5kbGVyKGludCBpcnEsDQo+ID4gPiB2b2lkICpwKQ0KPiA+ID4gIA0KPiA+
ID4gIAlpZiAoYWRpcy0+ZGF0YS0+aGFzX3BhZ2luZykgew0KPiA+ID4gIAkJYWRpcy0+Y3VycmVu
dF9wYWdlID0gMDsNCj4gPiA+IC0JCW11dGV4X3VubG9jaygmYWRpcy0+dHhyeF9sb2NrKTsNCj4g
PiA+ICsJCW11dGV4X3VubG9jaygmYWRpcy0+c3RhdGVfbG9jayk7DQo+ID4gPiAgCX0NCj4gPiA+
ICANCj4gPiA+ICAJaWlvX3B1c2hfdG9fYnVmZmVyc193aXRoX3RpbWVzdGFtcChpbmRpb19kZXYs
IGFkaXMtPmJ1ZmZlciwNCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lpby9pbXUv
YWRpcy5oDQo+ID4gPiBiL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiA+IGluZGV4
IDRjNTM4MTViYjcyOS4uM2VkNWVjZWFhYzJkIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9paW8vaW11L2FkaXMuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9paW8vaW11L2Fk
aXMuaA0KPiA+ID4gQEAgLTYxLDcgKzYxLDcgQEAgc3RydWN0IGFkaXMgew0KPiA+ID4gIAljb25z
dCBzdHJ1Y3QgYWRpc19kYXRhCSpkYXRhOw0KPiA+ID4gIAlzdHJ1Y3QgYWRpc19idXJzdAkqYnVy
c3Q7DQo+ID4gPiAgDQo+ID4gPiAtCXN0cnVjdCBtdXRleAkJdHhyeF9sb2NrOw0KPiA+ID4gKwlz
dHJ1Y3QgbXV0ZXgJCXN0YXRlX2xvY2s7DQo+ID4gPiAgCXN0cnVjdCBzcGlfbWVzc2FnZQltc2c7
DQo+ID4gPiAgCXN0cnVjdCBzcGlfdHJhbnNmZXIJKnhmZXI7DQo+ID4gPiAgCXVuc2lnbmVkIGlu
dAkJY3VycmVudF9wYWdlOyAgDQo=
