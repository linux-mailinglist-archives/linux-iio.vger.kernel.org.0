Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F931E07FF
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbgEYH2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 03:28:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45420 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388948AbgEYH2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 03:28:33 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04P7Ostp030909;
        Mon, 25 May 2020 03:28:20 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 316wkavtn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 03:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRhtsXNToKnhh6LflBrxePltYhm1V7PFCTPjchegr6hPTQ7fiztmEhvRl/xpTNwVSiQcnQzXq3g4MLJkLVNeAEJvyDILKrbH0YQYgoSQrSSN5fQN/SbpQzsme39kesspJ3CWsceQOJ9VmiFHRsK0seZBA5jq4u1knnbjR4CGN0zD22vbTyW7IdRMh8vMJshmB73KK0bx50QdyVwcY9PUhI9gtIXBRizDjiqXEn6SBAIWfc+zBon7vw+yTymSbD/vOzrT8M0SkEjtmwFpZCpJkLvVzzMGirRgk7vzcs+cREJMnyWOLIxpEwL47xXYNU3twkFMiSpcgeqQLyG8RGuOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HwrWnUxx5clNnEFDmm/wPAFVWlSf/0ZUH8r/WFWqtg=;
 b=TsdMSqsaQxvWB3IWWGzZppk5S2J3W+Psc4sIaY8hEsjVTek9OS4Szqd3x4CEN0hpGHe1fYhzJjvbO2tKBxuh87pn6eg23H4x5kJtUpzIwFnnB/C8mZmLgx0uue2nKdYjKNHFskNNQdDUKevq6TTVokctDiJIrMd0mF03TOhgyQoaKcx2+i4TtfccsCRgz/zrfRVI13jNPLiXGYMJ/vJ2n5ODNrorpBSJ0UXYb+JlAECTrs7d5+bEuhhY49LaH+lcD6EUYYcuOSqtTkWBMr+vlSz8qchJAt+ynlxBlifOBJp58OrJP8I1QwcF7V8Nddpxuk5TsdnA8f33FpH6kI4QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HwrWnUxx5clNnEFDmm/wPAFVWlSf/0ZUH8r/WFWqtg=;
 b=osX2TseziNM1SbYAvRKfXz5ZlPC2uwawAAkU7fqChQEjdcqjNQS6L6gCzJg9FiiJU252PfBThkh9VJdPOAWXoWVshI64o5cg5xkTvXWWvt1RHIIPAmno4No0vLH9/y6QBxtGlzpm89WizUof75p3PoObI388a3/pSnYyDsmjq5w=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4715.namprd03.prod.outlook.com (2603:10b6:5:181::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 07:28:18 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 07:28:18 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 09/14] iio: buffer: split buffer sysfs creation to
 take buffer as primary arg
Thread-Topic: [RFC PATCH 09/14] iio: buffer: split buffer sysfs creation to
 take buffer as primary arg
Thread-Index: AQHWJUAnkln7T4FO0EyrckgrUIba/Ki3jAUAgAD1pIA=
Date:   Mon, 25 May 2020 07:28:18 +0000
Message-ID: <cfcc097a2cf6582cc8a5cc47d9ea8b868eda0ed9.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
         <20200508135348.15229-10-alexandru.ardelean@analog.com>
         <20200524174916.2ff91965@archlinux>
In-Reply-To: <20200524174916.2ff91965@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 153710ec-6a15-4174-0924-08d8007d323d
x-ms-traffictypediagnostic: DM6PR03MB4715:
x-microsoft-antispam-prvs: <DM6PR03MB4715E79EE1E3AB8E99D87DB7F9B30@DM6PR03MB4715.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leqqjfs6XucY9SuvuMPJ+bznemO1xEUsA9rM2ytndl6pPYdBHnAVLfvYg91k269cXYInQs5eoGKCbJ6ovOVCvtujjjVmRB1Xwvb207OPPel4XfEDlj2eB9jq/cujXVu4NP4h+n9CqgqCnVAol1XY6XCrpyRTldfk8RJIJgw3nLWHENScQZXAPKbKsdUsS+B6cSPyfuBZTS/I6FgjMiE6JJKCob/5BybbhagG872Q3TtYc3TqmCEmCtCKbScrxaRilLzWdcQByfBjnzrvAlO9qnWFebetWF7BKNaDRiETVHUS1c2/3k7J0tBNCNUuaf2w0V2I+6r1SPd6UBZtQdnM3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(2906002)(76116006)(91956017)(66556008)(64756008)(316002)(8936002)(8676002)(66476007)(6916009)(66446008)(66946007)(4326008)(186003)(26005)(2616005)(71200400001)(36756003)(86362001)(54906003)(5660300002)(478600001)(6512007)(6486002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rtTbicGJiF2y/Ux8ZQhLKE/v00g9BTKrXsjA79QHoKTIzrjC9khL9jFT/fHbYDNftts0biWd94x/XCfQsu7ar6i10zSWvahFaB6Qpk7C9gBxiVZWgrLTLFXxmmgzKBuy2C13NAixw+8fJB9cuxQxrBVr41VUMadcMrNyLd3vwlWF74sxHJ5eISi6sKDP1/B3JqupFje4MGlzJfHivPi8NGboN5yBPXZUSmuEcKWRnS1eH8Au4e6EnscAj5y55ZeY/ll/BFcz6+fH3vJcXCr77RCRiEQ5GrP36ilDMQDoOF9oPHohaXaZZHwopmbElmhA24xj8Zhttpri8VXe8bGO8mQGJQ3zFkOLD5NvzYLt4nkJfWbnpkzkoGhl4GpJazL/ePoibUA/ESBmcrbQTqdm7JC+XZ+uLYslk7+QGM5hHgTVy0sFc16ujhwMXRVC9dv7kRl27BI/Uanth366qgQ0tTHw+zb9rDGprCnKHcF3HM0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <800BC4FD3F186A4E92C693C78E35A3F7@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153710ec-6a15-4174-0924-08d8007d323d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 07:28:18.5118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkyPlgNXWUHz3oQfZwrfSQIXVOaFYhmh6uwiKLE7Q+VsC6plqX31yEcdwXQuBCrgSMK/GsZ/CUBjo3nARf1xROCifeBxVvdEk/cP5lq+8uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4715
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-25_02:2020-05-22,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 cotscore=-2147483648 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005250059
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIwLTA1LTI0IGF0IDE3OjQ5ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDggTWF5IDIwMjAgMTY6NTM6NDMgKzAzMDAN
Cj4gQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IEN1cnJlbnRseSB0aGUgaWlvX2J1ZmZlcl97YWxsb2MsZnJlZX1fc3lzZnNf
YW5kX21hc2soKSB0YWtlICdpbmRpb19kZXYnIGFzDQo+ID4gcHJpbWFyeSBhcmd1bWVudC4gVGhp
cyBjaGFuZ2UgY29udmVydHMgdG8gdGFrZSBhbiBJSU8gYnVmZmVyIGFzIGEgcHJpbWFyeQ0KPiA+
IGFyZ3VtZW50Lg0KPiA+IA0KPiA+IFRoYXQgd2lsbCBhbGxvdyB0aGUgZnVuY3Rpb25zIHRvIGdl
dCBjYWxsZWQgZm9yIG11bHRpcGxlIGJ1ZmZlcnMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gDQo+
IExvb2tzIGdvb2QgdG8gbWUuICBXZSdsbCBuZWVkIHRoaXMgd2hhdGV2ZXIgdGhlIGludGVyZmFj
ZSBlbmRzIHVwIGJlaW5nIGFzDQo+IG5lZWQgdGhlIHNlcGFyYXRlIGNvbnRyb2wgaW5mcmFzdHJ1
Y3R1cmUuDQoNCkkgd2FzIHdhbnRpbmcgdG8gc3BsaXQgdGhpcyBpbnRvIGl0J3Mgb3duIHBhdGNo
IGF0IHNvbWUgcG9pbnQgYW5kIHNlbmQgaXQgbm93Lg0KSSdsbCBwcm9iYWJseSBkbyBpdC4NCg0K
PiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaWlvL2luZHVzdHJpYWxp
by1idWZmZXIuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMgYi9kcml2ZXJz
L2lpby9pbmR1c3RyaWFsaW8tDQo+ID4gYnVmZmVyLmMNCj4gPiBpbmRleCBlN2E4NDdlN2IxMDMu
LjZiMWI1ZDUzODdiZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8t
YnVmZmVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tYnVmZmVyLmMNCj4g
PiBAQCAtMTMxMiwyNiArMTMxMiwxNCBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqaWlvX2J1
ZmZlcl9hdHRyc1tdID0gew0KPiA+ICAJJmRldl9hdHRyX2RhdGFfYXZhaWxhYmxlLmF0dHIsDQo+
ID4gIH07DQo+ID4gIA0KPiA+IC1pbnQgaWlvX2J1ZmZlcl9hbGxvY19zeXNmc19hbmRfbWFzayhz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICtzdGF0aWMgaW50IF9faWlvX2J1ZmZlcl9h
bGxvY19zeXNmc19hbmRfbWFzayhzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyKQ0KPiA+ICB7DQo+
ID4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gYnVmZmVyLT5pbmRpb19kZXY7DQo+ID4g
IAlzdHJ1Y3QgaWlvX2Rldl9hdHRyICpwOw0KPiA+ICAJc3RydWN0IGF0dHJpYnV0ZSAqKmF0dHI7
DQo+ID4gLQlzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVmZmVyID0gaW5kaW9fZGV2LT5idWZmZXI7DQo+
ID4gIAlpbnQgcmV0LCBpLCBhdHRybiwgYXR0cmNvdW50LCBhdHRyY291bnRfb3JpZyA9IDA7DQo+
ID4gIAljb25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyAqY2hhbm5lbHM7DQo+ID4gIA0KPiA+IC0J
Y2hhbm5lbHMgPSBpbmRpb19kZXYtPmNoYW5uZWxzOw0KPiA+IC0JaWYgKGNoYW5uZWxzKSB7DQo+
ID4gLQkJaW50IG1sID0gaW5kaW9fZGV2LT5tYXNrbGVuZ3RoOw0KPiA+IC0NCj4gPiAtCQlmb3Ig
KGkgPSAwOyBpIDwgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHM7IGkrKykNCj4gPiAtCQkJbWwgPSBt
YXgobWwsIGNoYW5uZWxzW2ldLnNjYW5faW5kZXggKyAxKTsNCj4gPiAtCQlpbmRpb19kZXYtPm1h
c2tsZW5ndGggPSBtbDsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlpZiAoIWJ1ZmZlcikNCj4gPiAt
CQlyZXR1cm4gMDsNCj4gPiAtDQo+ID4gIAlhdHRyY291bnQgPSAwOw0KPiA+ICAJaWYgKGJ1ZmZl
ci0+YXR0cnMpIHsNCj4gPiAgCQl3aGlsZSAoYnVmZmVyLT5hdHRyc1thdHRyY291bnRdICE9IE5V
TEwpDQo+ID4gQEAgLTE0MTEsMTkgKzEzOTksNDUgQEAgaW50IGlpb19idWZmZXJfYWxsb2Nfc3lz
ZnNfYW5kX21hc2soc3RydWN0IGlpb19kZXYNCj4gPiAqaW5kaW9fZGV2KQ0KPiA+ICAJcmV0dXJu
IHJldDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtdm9pZCBpaW9fYnVmZmVyX2ZyZWVfc3lzZnNfYW5k
X21hc2soc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAraW50IGlpb19idWZmZXJfYWxs
b2Nfc3lzZnNfYW5kX21hc2soc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAgew0KPiA+
ICAJc3RydWN0IGlpb19idWZmZXIgKmJ1ZmZlciA9IGluZGlvX2Rldi0+YnVmZmVyOw0KPiA+ICsJ
Y29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNoYW5uZWxzOw0KPiA+ICsJaW50IGk7DQo+ID4g
Kw0KPiA+ICsJY2hhbm5lbHMgPSBpbmRpb19kZXYtPmNoYW5uZWxzOw0KPiA+ICsJaWYgKGNoYW5u
ZWxzKSB7DQo+ID4gKwkJaW50IG1sID0gaW5kaW9fZGV2LT5tYXNrbGVuZ3RoOw0KPiA+ICsNCj4g
PiArCQlmb3IgKGkgPSAwOyBpIDwgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHM7IGkrKykNCj4gPiAr
CQkJbWwgPSBtYXgobWwsIGNoYW5uZWxzW2ldLnNjYW5faW5kZXggKyAxKTsNCj4gPiArCQlpbmRp
b19kZXYtPm1hc2tsZW5ndGggPSBtbDsNCj4gPiArCX0NCj4gPiAgDQo+ID4gIAlpZiAoIWJ1ZmZl
cikNCj4gPiAtCQlyZXR1cm47DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IF9faWlvX2J1ZmZlcl9hbGxvY19zeXNmc19hbmRfbWFzayhidWZmZXIpOw0KPiA+ICt9DQo+ID4g
IA0KPiA+ICtzdGF0aWMgdm9pZCBfX2lpb19idWZmZXJfZnJlZV9zeXNmc19hbmRfbWFzayhzdHJ1
Y3QgaWlvX2J1ZmZlciAqYnVmZmVyKQ0KPiA+ICt7DQo+ID4gIAlpaW9fYnVmZmVyX2ZyZWVfc2Nh
bm1hc2soYnVmZmVyKTsNCj4gPiAgCWtmcmVlKGJ1ZmZlci0+YnVmZmVyX2dyb3VwLmF0dHJzKTsN
Cj4gPiAgCWtmcmVlKGJ1ZmZlci0+c2Nhbl9lbF9ncm91cC5hdHRycyk7DQo+ID4gIAlpaW9fZnJl
ZV9jaGFuX2RldmF0dHJfbGlzdCgmYnVmZmVyLT5zY2FuX2VsX2Rldl9hdHRyX2xpc3QpOw0KPiA+
ICB9DQo+ID4gIA0KPiA+ICt2b2lkIGlpb19idWZmZXJfZnJlZV9zeXNmc19hbmRfbWFzayhzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaWlvX2J1ZmZlciAq
YnVmZmVyID0gaW5kaW9fZGV2LT5idWZmZXI7DQo+ID4gKw0KPiA+ICsJaWYgKCFidWZmZXIpDQo+
ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCV9faWlvX2J1ZmZlcl9mcmVlX3N5c2ZzX2FuZF9t
YXNrKGJ1ZmZlcik7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmls
ZV9vcGVyYXRpb25zIGlpb19idWZmZXJfZmlsZW9wcyA9IHsNCj4gPiAgCS5yZWFkID0gaWlvX2J1
ZmZlcl9yZWFkX291dGVyLA0KPiA+ICAJLnJlbGVhc2UgPSBpaW9fYnVmZmVyX2NocmRldl9yZWxl
YXNlLA0K
