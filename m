Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C33CDC32
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfJGHHU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 03:07:20 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13890 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbfJGHHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 03:07:20 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9772vYG007801;
        Mon, 7 Oct 2019 03:07:17 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2052.outbound.protection.outlook.com [104.47.41.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2veqt5749p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 03:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFIx3hbdGElCD4b5KCMNBiBu8ANaix/IcQJMrkcpd27yacgLthukX4s/jz8S0djjaevu5Nz0sd6ykBa0RhVq33TNg9ZfhPTwiVVZp527kT338CUe9wIHvE/ZT2HpfFlGMMMdIBZtUQzWd8RcVxcLsJYlNKT5lRWAldnjdOJky+FDJ/iCHXLJYlhHQpHITKL35WyTYgmWqpngubpsfAzfshlmzLkaoG45C7YWEh0Ag3SvjMtyP4JQ/Bu6L93FJI5YTvLIgQ6/1OzLtoX1BJUUZHjlryGn5f0HAG8Y2WoB8KNGf21rQoF9OvgePNTydYlwFky+99ZpFpzqCcyElSGNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et4Xxp6T7FhVu/pTVp/B7OCKdL51kX7sP4aotdZCqVU=;
 b=H7YZZ8I037mEprdT9jdzamqZ/Coy9MoOKLW43e+ehYZM5OueodfwgKbGMk6n+wmmPDGPyedRR8oKjK3lN4cbwkHAd4CJ3eVjtPXX3XURxmq8eNOfEhifHuDxEui8q/LUVhxYZw5G4pEdv2I2YTROijw2/X0elFA9G/3/2OLn4JX9FCkE1xaDuW5nvZr78bXx5uK3G+KiqLmIy95xsGEWz2FMLCHYNG3minNp/IMe9nekwzZWZ9J05iQpJJFDwcsCkf24LQ7Fv9WGugL7dtDFfWn4xzZF/b981rtGmSEqGxm7e8S2GK2BJCedAAqzjV7jsnbp9PQmUaymY0T56QQenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et4Xxp6T7FhVu/pTVp/B7OCKdL51kX7sP4aotdZCqVU=;
 b=m8tPKkzgeDpTO2/GBwGm/RNb47F9XipoIIjkMu9Wcmcp+fgAq5fUTemHWavB8Bk5/nTGmG2P7Qd0Q0jZmBJwChcxRrZ9oKTU9aVgncxZWzQLR5GZYgW/3D5ujbiz9UREMNQXlUNdAsFSj4AQPuJ3RCQzUZ4+p3hcqWZ0u7JQIe4=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5349.namprd03.prod.outlook.com (20.180.14.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 07:07:15 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2305.023; Mon, 7 Oct 2019
 07:07:15 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adis16130: remove mlock usage
Thread-Topic: [PATCH] iio: gyro: adis16130: remove mlock usage
Thread-Index: AQHVbVlMQyShGHYJPU+rR1l5TLQv96dMGr0AgALGTIA=
Date:   Mon, 7 Oct 2019 07:07:14 +0000
Message-ID: <cf2dc88e2990df71d0f8d0b7aa4cf8dcf893dfa9.camel@analog.com>
References: <20190917161023.3176-1-alexandru.ardelean@analog.com>
         <20191005134508.27361c46@archlinux>
In-Reply-To: <20191005134508.27361c46@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f25c9781-737e-4a7c-aa7b-08d74af4fbbf
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5349:
x-microsoft-antispam-prvs: <CH2PR03MB5349A9DE02BED190A8898406F99B0@CH2PR03MB5349.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(39850400004)(346002)(199004)(189003)(52314003)(66946007)(256004)(6436002)(66066001)(186003)(14444005)(66556008)(64756008)(66476007)(66446008)(229853002)(76116006)(14454004)(71190400001)(71200400001)(25786009)(316002)(6486002)(6916009)(6246003)(36756003)(99286004)(3846002)(6116002)(118296001)(81166006)(81156014)(486006)(8676002)(5640700003)(478600001)(5660300002)(102836004)(6506007)(6512007)(11346002)(446003)(26005)(4326008)(2501003)(2906002)(8936002)(476003)(305945005)(86362001)(7736002)(2616005)(76176011)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5349;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0H229Myy45uZFz4PbyTZPihpEKNpqCIZqmEnIm7FAfx88kaQZOY+Vbfhow8C3fvJIrTdEYGrmY56Cq6kCyhy0dbzXqPCJV8TXd2JZSf83YVfNaJQ1npUEjQE2fE9Tjde3B24qbyB4bULHLKFs2AS6aX/6UDA95Qeomgpn6SA11Pd+vg87yW2VAvV0lFLNVZhS5sUFVNi5a4UWeu+1sfmyEdg742ncx4hzwshuXdMeEETqUpEQBWB0++FfsScBQz8CJsx5DQWPNxb7e65VVmcUxKLRXHmPK3j5NcF14MedxV9me1wcyv7e9I+ilJo5j7JGWoW0WiaW6782BD3lukm8Hq0h0ooijTls/IuUsRbVbH0DVK4xhGjAgYDMvvYrU8PdVwj6g5n3W1IhqNt264wlJcglEw7XyOHJ1Op3eOSoOE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA819065F992748A7BD89CA0C87BBAE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c9781-737e-4a7c-aa7b-08d74af4fbbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 07:07:14.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b79nIkzKxSL/TwuQTJqX1w3nMkmLq+MlMiHs2HBWSjfdIpOfxYwIKcPsClh7iX94vt/Y5J/mIsHLRkI0neS4ouPxeeZRTsN0GgPyM9ZwB3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_01:2019-10-03,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTEwLTA1IGF0IDEzOjQ1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDE3IFNlcCAyMDE5IDE5OjEwOjIzICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgdXNlIG9mIGluZGlvX2RldidzIG1sb2NrIGlzIGRpc2NvdXJhZ2Vk
LiBUaGUgZHJpdmVyIGFscmVhZHkgZGVmaW5lcw0KPiA+IGl0J3Mgb3duIGBidXNfbG9ja2AgaW4g
YGFkaXMxNjEzMF9zcGlfcmVhZCgpYCwgc28gdXNpbmcgdGhlIG1sb2NrIGlzDQo+ID4gcmVkdW5k
YW50Lg0KPiA+IA0KPiA+IFRoZSBwYXJ0cyBzdXBwb3J0ZWQgYnkgdGhpcyBjaGlwIGFyZSBvYnNv
bGV0ZWQgYW55d2F5LCBzbyBmb3Igbm93IHdlDQo+ID4ganVzdA0KPiA+IHJlbW92ZSBtbG9jayBh
cyBwYXJ0IG9mIGEgZ2VuZXJhbCBjbGVhbnVwLCB1bnRpbCB0aGUgZHJpdmVyIGdldHMNCj4gPiBy
ZW1vdmVkLg0KPiBIbW0uIFJlbW92aW5nIGEgZGV2aWNlIGRyaXZlciBsaWtlIHRoaXMgd2hpY2gg
aXNuJ3QgaW4gc3RhZ2luZyBpcyBnb2luZw0KPiB0byBiZSBjb250cm92ZXJzaWFsLiAgVGhlcmUg
bWF5IHdlbGwgYmUgbG9uZyB0ZXJtIHN1cHBvcnRlZCBkZXZpY2VzIG91dA0KPiB0aGVyZSB1c2lu
ZyBpdC4gIFdlIGhhdmUgbm8gd2F5IG9mIGtub3dpbmcsIHNvIG15IGluY2xpbmF0aW9uIHdpbGwg
YmUNCj4gdG8gbGVhdmUgaXQgdGhlcmUgdW5sZXNzIGl0IGlzIGEgc2lnbmlmaWNhbnQgbWFpbnRl
bmFuY2UgYnVyZGVuLg0KDQpJJ2xsIGFkbWl0IEknbSBzb21ldGltZXMgYSBiaXQgdHJpZ2dlci1o
YXBweSBbc3RpbGxdIGFib3V0IHJlbW92aW5nIGRyaXZlcnMNCnRoYXQgYXJlIG1hcmtlZCBvYnNv
bGV0ZSBvbiB0aGUgY29tcGFueSBwcm9kdWN0LXNpdGUuDQpUaGlzIHVzdWFsbHkgW2ZvciBtZV0g
Z29lcyBhd2F5IHdpdGggdGltZSBbdGhlIHRyaWdnZXItaGFwcGluZXNzXS4NCg0KPiANCj4gVGhl
IGRyaXZlcnMgaW4gc3RhZ2luZyBhcmUgYSBkaWZmZXJlbnQgbWF0dGVyIGFzIHdlIG5ldmVyIG1h
ZGUgYW55DQo+ICdwcm9taXNlJyBvZiBzdXBwb3J0aW5nIHRob3NlIQ0KPiANCj4gSSdsbCBoYXph
cmQgYSBndWVzcyB0aGF0IG1sb2NrIGhlcmUgd2FzIGN1dCBhbmQgcGFzdGUgZnJvbSBhbm90aGVy
IGRyaXZlcg0KPiBhbmQgdGhhdCBkcml2ZXIgc3VwcG9ydGVkIGJ1ZmZlcmVkIG1vZGVzLiAgSW4g
dGhvc2UgY2FzZXMgaXQgd291bGQgbmVlZA0KPiB0byBtb3ZlIHRvIHRoZSB1dGlsaXR5IGZ1bmN0
aW9ucyB0byBlbnN1cmUgd2UgYXJlIG5vdCBpbiBidWZmZXJlZCBtb2RlLg0KPiANCj4gSGVyZSB5
b3VyIGZpeCBpcyByaWdodCB0aG91Z2ggZ2l2ZW4gdGhlIGRyaXZlciBvbmx5IHN1cHBvcnQgc3lz
ZnMgcmVhZHMuDQo+IA0KPiBBcHBsaWVkIHRvIHRoZSB0b2dyZWcgYnJhbmNoIG9mIGlpby5naXQg
YW5kIHB1c2hlZCBvdXQgYXMgdGVzdGluZyBmb3INCj4gdGhlIGF1dG9idWlsZGVycyB0byBwbGF5
IHdpdGggaXQuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9neXJvL2FkaXMxNjEzMC5jIHwgMiAtLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vZ3lyby9hZGlzMTYxMzAuYw0KPiA+IGIvZHJpdmVycy9paW8vZ3lyby9hZGlz
MTYxMzAuYw0KPiA+IGluZGV4IGRlM2Y2NmY4OTQ5Ni4uNzllNjNjOGEyZWE4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvaWlvL2d5cm8vYWRpczE2MTMwLmMNCj4gPiArKysgYi9kcml2ZXJzL2lp
by9neXJvL2FkaXMxNjEzMC5jDQo+ID4gQEAgLTc2LDkgKzc2LDcgQEAgc3RhdGljIGludCBhZGlz
MTYxMzBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2LA0KPiA+ICAJc3dp
dGNoIChtYXNrKSB7DQo+ID4gIAljYXNlIElJT19DSEFOX0lORk9fUkFXOg0KPiA+ICAJCS8qIFRh
a2UgdGhlIGlpb19kZXYgc3RhdHVzIGxvY2sgKi8NCj4gPiAtCQltdXRleF9sb2NrKCZpbmRpb19k
ZXYtPm1sb2NrKTsNCj4gPiAgCQlyZXQgPSBhZGlzMTYxMzBfc3BpX3JlYWQoaW5kaW9fZGV2LCBj
aGFuLT5hZGRyZXNzLCAmdGVtcCk7DQo+ID4gLQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1s
b2NrKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJCSp2YWwg
PSB0ZW1wOw0K
