Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7601AA934
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633760AbgDON4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 09:56:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59102 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2636336AbgDON4V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 09:56:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FDt8JB008766;
        Wed, 15 Apr 2020 09:56:16 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn7ujb1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 09:56:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJRaloBJSa4qzQCtuDo8ua9ULdv69XxOVdu0SgX/AjIqUnToGU7VNwDtq9UOcppZ5U13lhNEyEDrbG+1F6o2DuYdOmQeOz1/jtV9gp5mh27BtcxIk++XUEOH3OJZ3uFpyOOeLsp6UuHnXLaJ0mDZuBNl8Ip0uJE5QiuW0RBMUuS5z4IGSVfre7DUXxaX/lZniE+H5nA1nsI72kcaY1D8e7YKHK1YnkXChcSNb5jHKqmIs2JoMRwu67UfVrBCu8iVZPe3RaNhBBBovwQD3+N6A6/OSAxbhwNCk1dE+Jn7gqJ6HHRqOuJOjRf2p5RU0oy7PqXxBLcHGw/ReTh1Glpo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2ES/F+k3ogINEdBqcpQyJCZwnZwQBxvmD4fbprsgtg=;
 b=oDyvd1Xwmz516KgyfWsuBD0Zjd/PvlnIUZA8RAo3jN51qVdQt4hyXw0sSDFSqWPaEVJwj9AlZOh98FYEJPzcAHyscFJIcBKUezexHOn0A5szb5L7tD4yO6yhIPFbv6v1+Ir1SW4A8NlDQw8SbE+e3aCgn6XPVLGb7Kgrm9eOcwwC0kpIqQy3YzhAGvVM0eFni6X+T3/buM45sMytuOPmzqkn2tXz0V0qd3TH2WwAnLQpAOlUWt7SoA1URhLQbFpOzwjmf2ShR96uiGp2flDi2Rp4qGvl2/DyMxVpEXkA5IT408p2io/slu2OGoy/kuEempFvHaeY4xAxdzaFKG/DSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2ES/F+k3ogINEdBqcpQyJCZwnZwQBxvmD4fbprsgtg=;
 b=iwBLR+nlAhQklXCz2FXp3bFJPL4xB3nEkpaL/oV0m/Y5AfQ6hwffcEkeFSg02MVAFwi0ZdeB1vefL48CcUfvYUSkRZr8JvPgORRxDd/9udN0u0efy0L9+OoF1eZrcA568j9c2pdvd+f5Ld25B28K7sEsxLFW6PeWK+JFK7OdR8c=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5242.namprd03.prod.outlook.com (2603:10b6:5:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 13:56:14 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2921.024; Wed, 15 Apr 2020
 13:56:13 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
Thread-Topic: [PATCH v2] iio: core: register chardev only if needed
Thread-Index: AQHWEjfBZCWPnaEudUWFdTBfvszEb6h46meAgAFMZwA=
Date:   Wed, 15 Apr 2020 13:56:13 +0000
Message-ID: <761fb0aef92e5e026df78b6679329dbbb55b6226.camel@analog.com>
References: <20200414083656.7696-1-alexandru.ardelean@analog.com>
         <20200414190629.2d85759e@archlinux>
In-Reply-To: <20200414190629.2d85759e@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.135.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d74c1d19-f07e-4a3f-b23b-08d7e144c2da
x-ms-traffictypediagnostic: DM6PR03MB5242:
x-microsoft-antispam-prvs: <DM6PR03MB5242D7D105A43930745F02C5F9DB0@DM6PR03MB5242.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(54906003)(36756003)(71200400001)(8936002)(478600001)(5660300002)(6916009)(2616005)(81156014)(8676002)(6512007)(4326008)(2906002)(76116006)(91956017)(64756008)(316002)(66946007)(86362001)(26005)(66476007)(6506007)(186003)(66556008)(6486002)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8j1XLwAAYgSGecOO85TxPOR5IVDAjGfhJJMX6ACTC+1C8m3LU6SUj4Mst+dfGGns/hwwzKkSB4VrFHNqjlO9fVMcbzs/GyW8gLuYm3bArRMmxTjyoe22wziRGMji2ZOK3DrcZfIz/S37Xf/z4SzRnf0uLV/2fTu66ly5Ht13T+NyqWdxs16/3Ld4ITOVnCY1/sll/gUwJsF25h2gHBp8csXWe6V0CJBNjFV3Qshms8stwmzF4mn64Jr3gdl7dJGy5t9dpYXRW3q1wmk+wHlvSVnCEEpzrECrm32C5NWAsGiC+w7oyozRjS8I2Nymxas583uGYlXjPxGnwruZrwGfjoyZ32ZW4Lj7b0BegEzSBafCSRrMWDqXvzjOpThEBlKkdggch6vL5FeXIPQZvNV2ObVrcRmybzdNnwRtGPjvEfdhv3bW12CR52BBZqjO/Qk
x-ms-exchange-antispam-messagedata: 70lZvN2Ou8sJDBtqpyL8DnkgSLlZzwcVKVvMuNjvkc9WwWL2nBPLlCkgLrso0UxnnexqfQ8tZgyjlvHoAkP5gogl/7P2VHaX6wyAwvyBcsk/8ESDjraQRErgQQDa/yl6Uq5i+uKkrRg14nlfqcByJw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B8D427DD035449B8FD8574FA9B93A9@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c1d19-f07e-4a3f-b23b-08d7e144c2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 13:56:13.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOasM/MIRA7i6XO8f7YicseF6dO85DJl5s79Ds/aOKFgKGvjHHDdq666bevU1cDbpfC+tiRpaqVGMFhi1c192NH0M4tCveirN5bR8/GeLTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5242
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_04:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDE5OjA2ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBUdWUsIDE0IEFwciAyMDIwIDExOjM2OjU2ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgZmluYWwgaW50ZW50IGlzIHRvIGxvY2FsaXplIGFsbCBidWZmZXIg
b3BzIGludG8gdGhlDQo+ID4gaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGZpbGUsIHRvIGJlIGFibGUg
dG8gYWRkIHN1cHBvcnQgZm9yIG11bHRpcGxlIGJ1ZmZlcnMNCj4gPiBwZXIgSUlPIGRldmljZS4N
Cj4gPiANCj4gPiBXZSBvbmx5IG5lZWQgYSBjaGFyZGV2IGlmIHdlIG5lZWQgdG8gc3VwcG9ydCBi
dWZmZXJzIGFuZC9vciBldmVudHMuDQo+ID4gDQo+ID4gV2l0aCB0aGlzIGNoYW5nZSwgYSBjaGFy
ZGV2IHdpbGwgYmUgY3JlYXRlZDoNCj4gPiAxLiBpZiB0aGVyZSBpcyBhbiBJSU8gYnVmZmVyIGF0
dGFjaGVkIE9SDQo+ID4gMi4gaWYgdGhlcmUgaXMgYW4gZXZlbnRfaW50ZXJmYWNlIGNvbmZpZ3Vy
ZWQNCj4gPiANCj4gPiBPdGhlcndpc2UsIG5vIGNoYXJkZXYgd2lsbCBiZSBjcmVhdGVkLg0KPiA+
IFF1aXRlIGEgbG90IG9mIElJTyBkZXZpY2VzIGRvbid0IHJlYWxseSBuZWVkIGEgY2hhcmRldiwg
c28gdGhpcyBpcyBhIG1pbm9yDQo+ID4gaW1wcm92ZW1lbnQgdG8gdGhlIElJTyBjb3JlLCBhcyB0
aGUgSUlPIGRldmljZSB3aWxsIHRha2UgdXAgZmV3ZXINCj4gPiByZXNvdXJjZXMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5A
YW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBDaGFuZ2Vsb2cgdjEgLT4gdjI6DQo+ID4g
KiBzcGxpdCBhd2F5IGZyb20gc2VyaWVzICdpaW86IGNvcmUsYnVmZmVyOiByZS1vcmdhbml6ZSBj
aGFyZGV2IGNyZWF0aW9uJzsNCj4gPiAgIGknbSBnZXR0aW5nIHRoZSBmZWVsaW5nIHRoYXQgdGhp
cyBoYXMgc29tZSB2YWx1ZSBvbiBpdCdzIG93bjsNCj4gPiAgIG5vIGlkZWEgaWYgaXQgbmVlZHMg
J0ZpeGVzJyB0YWc7IGl0IGlzIGEgYml0IGZ1enp5IHRvIHBvaW50IHRvIGEgcGF0Y2gNCj4gPiAg
IHdoaWNoIHRoaXMgd291bGQgYmUgZml4ZWQgYnkgdGhpczsgaSdtIGd1ZXNzaW5nIGl0IHdvdWxk
IGJlIGZpbmUNCj4gPiAgIHdpdGhvdXQgb25lDQo+IA0KPiBJJ2QgYXJndWUgaXQncyBhbiAnb3B0
aW1pemF0aW9uJyByYXRoZXIgdGhhbiBhIGZpeCA6KQ0KPiANCj4gU3RpbGwgbG9va3MgZ29vZCB0
byBtZSBidXQgSSdkIGxpa2UgaXQgdG8gc2l0IGZvciBhIGxpdHRsZSB3aGlsZSB0bw0KPiBzZWUg
aWYgYW55b25lIHBvaW50cyBvdXQgc29tZXRoaW5nIHdlIGFyZSBib3RoIG1pc3NpbmchDQo+IA0K
DQpUaGlzIGlzIG5vdCBnb29kLg0KSXQgc2VlbXMgdGhhdCBJIGRpZCBub3QgcHJvcGVybHkgdGVz
dCBhbGwgY2FzZXMuDQpJIGhhZCB0byBicmVhayBhIGRldmljZSB0byBub3QgaGF2ZSBhbiBldmVu
dF9pbnRlcmZhY2UgdG8gbm90aWNlIHRoYXQgdGhlIHN5c2ZzDQpkb2Vzbid0IGdldCBpbnN0YW50
aWF0ZWQgZWl0aGVyIGJlY2F1c2UgZGV2aWNlX2FkZCBpcyBtaXNzaW5nLg0KDQpXaWxsIGRvIGFu
b3RoZXIgdHJ5Lg0KDQoNCj4gVGhhbmtzIGZvciB0aWR5aW5nIHRoaXMgdXAuDQo+IA0KPiBKb25h
dGhhbg0KPiANCj4gPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyB8IDE3ICsrKysr
KysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tY29yZS5jIGIvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLQ0KPiA+IGNvcmUuYw0KPiA+IGlu
ZGV4IGY0ZGFmMTlmMmEzYi4uMzJlNzJkOWZkMWU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
aWlvL2luZHVzdHJpYWxpby1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFs
aW8tY29yZS5jDQo+ID4gQEAgLTE2NzYsNiArMTY3NiwxNSBAQCBzdGF0aWMgaW50IGlpb19jaGVj
a191bmlxdWVfc2Nhbl9pbmRleChzdHJ1Y3QgaWlvX2Rldg0KPiA+ICppbmRpb19kZXYpDQo+ID4g
IA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzIG5vb3Bfcmlu
Z19zZXR1cF9vcHM7DQo+ID4gIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0
aW9ucyBpaW9fZXZlbnRfZmlsZW9wcyA9IHsNCj4gPiArCS5yZWxlYXNlID0gaWlvX2NocmRldl9y
ZWxlYXNlLA0KPiA+ICsJLm9wZW4gPSBpaW9fY2hyZGV2X29wZW4sDQo+ID4gKwkub3duZXIgPSBU
SElTX01PRFVMRSwNCj4gPiArCS5sbHNlZWsgPSBub29wX2xsc2VlaywNCj4gPiArCS51bmxvY2tl
ZF9pb2N0bCA9IGlpb19pb2N0bCwNCj4gPiArCS5jb21wYXRfaW9jdGwgPSBjb21wYXRfcHRyX2lv
Y3RsLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgaW50IF9faWlvX2RldmljZV9yZWdpc3RlcihzdHJ1
Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBzdHJ1Y3QgbW9kdWxlDQo+ID4gKnRoaXNfbW9kKQ0KPiA+
ICB7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+IEBAIC0xNzI2LDcgKzE3MzUsMTAgQEAgaW50IF9faWlv
X2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiA+IHN0cnVjdCBt
b2R1bGUgKnRoaXNfbW9kKQ0KPiA+ICAJCWluZGlvX2Rldi0+c2V0dXBfb3BzID09IE5VTEwpDQo+
ID4gIAkJaW5kaW9fZGV2LT5zZXR1cF9vcHMgPSAmbm9vcF9yaW5nX3NldHVwX29wczsNCj4gPiAg
DQo+ID4gLQljZGV2X2luaXQoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaWlvX2J1ZmZlcl9maWxlb3Bz
KTsNCj4gPiArCWlmIChpbmRpb19kZXYtPmJ1ZmZlcikNCj4gPiArCQljZGV2X2luaXQoJmluZGlv
X2Rldi0+Y2hyZGV2LCAmaWlvX2J1ZmZlcl9maWxlb3BzKTsNCj4gPiArCWVsc2UgaWYgKGluZGlv
X2Rldi0+ZXZlbnRfaW50ZXJmYWNlKQ0KPiA+ICsJCWNkZXZfaW5pdCgmaW5kaW9fZGV2LT5jaHJk
ZXYsICZpaW9fZXZlbnRfZmlsZW9wcyk7DQo+ID4gIA0KPiA+ICAJaW5kaW9fZGV2LT5jaHJkZXYu
b3duZXIgPSB0aGlzX21vZDsNCj4gPiAgDQo+ID4gQEAgLTE3NTQsNyArMTc2Niw4IEBAIEVYUE9S
VF9TWU1CT0woX19paW9fZGV2aWNlX3JlZ2lzdGVyKTsNCj4gPiAgICoqLw0KPiA+ICB2b2lkIGlp
b19kZXZpY2VfdW5yZWdpc3RlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiA+ICB7DQo+
ID4gLQljZGV2X2RldmljZV9kZWwoJmluZGlvX2Rldi0+Y2hyZGV2LCAmaW5kaW9fZGV2LT5kZXYp
Ow0KPiA+ICsJaWYgKGluZGlvX2Rldi0+YnVmZmVyIHx8IGluZGlvX2Rldi0+ZXZlbnRfaW50ZXJm
YWNlKQ0KPiA+ICsJCWNkZXZfZGV2aWNlX2RlbCgmaW5kaW9fZGV2LT5jaHJkZXYsICZpbmRpb19k
ZXYtPmRldik7DQo+ID4gIA0KPiA+ICAJbXV0ZXhfbG9jaygmaW5kaW9fZGV2LT5pbmZvX2V4aXN0
X2xvY2spOw0KPiA+ICANCg==
