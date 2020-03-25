Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB65192532
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCYKNC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 06:13:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3550 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCYKNB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 06:13:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9tSkE028369;
        Wed, 25 Mar 2020 06:12:41 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs65643-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 06:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyMgog0rHUK3YUSeuMjt3qoIp8PutodAJ9ped/pKmhsi8d9bfFGil5OywH0pEPciGFlEkCe8riJ0ak1lPjX6GDjV9jZ2kJOs7UHQRte4WD1w6ozn1juy+TKqIPyS5O6Mr/NXmzCuHAyEbxCUM+ziM4eY7P/4pthrkZfEt3Vt7673mSG+1bntjXw1zPNM/dg8dJ4GUxJf/mhmdGiNSWhRZKMAQjYmO6qmJjnSWNLAONocP2XIrqJkdVOfCpl8no15bUT4J0Xm888AeiKTUOp87aoP5DVgy8ZVKQDR4lAiQblPLKB6I/fZzKEtumTubaRL1L+bGOfLwYydu/6xVeglaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHm2r9tT+3394KqeB4biXUtZG9W91/YgqSfdHcgDBk4=;
 b=FM+SYf7Ib8sy59bWZGzGyhXOFm9LF5HE5MOb7DyErNJAuSmkoWSlwvSBwjvklEhZAJZd6zD2QAMPh0E9DLC4xtKGzfSibLJtdqXjRKSQ9wBFDNihEupM6Imb9MluF0m5MMVu1Gih5ExNys/un+exb4PicS+LLmaxBF4A/IgN8Gqgr8N3lk4yUi8nvbplaq+MHpRoqS89zGVWnGWtgFG670T0rTpL61nmArp3rYyeN/gaJUvncpSH0tUAtdDsEMgsq2CLXnYg6Vlqzf/Zq94sYpJ+WSknTO445/WbjGos+3lWcR8UrOJzFb6gmKoDbr3JeMfv+VABCUt/4jAtGrEe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHm2r9tT+3394KqeB4biXUtZG9W91/YgqSfdHcgDBk4=;
 b=lH+tuMFZr0DaAlO3LcrDcWchDvuUuSs6PJRsYn4btM5a2c8Af0v78yISdp/2nzNjA0t3I+TKozxzNxsi8PZrxOTbHBujmu9vAfpWXmPAM2BLF72njgIvazWM24J1TyqltkpUkO/vkBVhfA+COrW8bgJETCKN3E01Su/WzQcgcHA=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB3594.namprd03.prod.outlook.com (2603:10b6:5:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 10:12:40 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:12:40 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Topic: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
Thread-Index: AQHWAoxiXsh0om2yLEiNKsKsJIqrVahZF7WA
Date:   Wed, 25 Mar 2020 10:12:40 +0000
Message-ID: <934b37d485571d842be297e5a2ab0d9cb881c4e8.camel@analog.com>
References: <20200320104031.31701-1-alexandru.ardelean@analog.com>
         <20200325100112.85107-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200325100112.85107-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.26.73.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68036605-2404-469d-fffb-08d7d0a50d12
x-ms-traffictypediagnostic: DM6PR03MB3594:
x-microsoft-antispam-prvs: <DM6PR03MB35944CF632826B7ABACEF8B9F9CE0@DM6PR03MB3594.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(346002)(376002)(2906002)(6506007)(5660300002)(86362001)(6512007)(4326008)(2616005)(26005)(66556008)(71200400001)(186003)(64756008)(66446008)(66476007)(66946007)(6486002)(478600001)(76116006)(91956017)(8936002)(316002)(81156014)(36756003)(110136005)(8676002)(54906003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3594;H:DM6PR03MB4411.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HonWsXWQC/KOK2TFwvlHmVfoyzrkfXjE8Sw3YhH+kOoty5VgtFmFiMGJf9KeLQbIUmbyoSLU3Ax9ijJiRQYit07mAMJgskORznHGxI9IKUb1zEn5cyPJTAOyUQGXZ4r/Qg/qUgGhtqecoVpCnLDJ+pHAbD1dYgfZ9TvtaIu0egYNXPNUYR7c7HvXzEWx3kV2NVg0PhHZExoie66EnJYifnfozCydYonf3/Dju1F2/9WaJDUr3rQxkowYnUNCIV21o7g2ZSefyMPTVbSkI7LYGoolVf6RmEFAZVl0q1bORajHhz+l3/V4IzezZ/+NIdfTYnb9y1ESX/EMfS4kU0lCcJh1lmfa24vbTHhGxvjxd3R4qyb6sFG+OhbmTjB9TxNU1L2ULbMxOxBRAdjVkUEWWgJ0Qp/cxIVOAliLgft4cJE6Apw0iAEhk2t/PBrGkC5H
x-ms-exchange-antispam-messagedata: xCNEsPNHTd++xEdHJRRFVCkV+FvqcnwDxknHVmJ7XM43u5K+2W9ZJhNtL0T0vc9W9cY49KzDpry1hpq6DxyEkBHuWox5UmW5xbQpo0RmPHyv9tun6453AI7X3RA84GX/JZRqMtImYoR0hVswtZ87nQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <582209CD0B30BA4B955E3A167BC00AF5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68036605-2404-469d-fffb-08d7d0a50d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:12:40.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiGV+k/8FhIF0j1UnD7xeHj6VIGJoLIBaghkoJ+PjIRRQl+MxiKsH+8W0RumPp8tjzhno6Vfh+I+PrAkYjydBKAzTA+aLgf15Fu6hkKm0vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_04:2020-03-23,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=956
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTI1IGF0IDEyOjAxICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IEZyb206IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiANCj4g
QmVmb3JlIGFjdGl2YXRpbmcgYSBidWZmZXIgbWFrZSBzdXJlIHRoYXQgYXQgbGVhc3Qgb25lIGNo
YW5uZWwgaXMgZW5hYmxlZC4NCj4gQWN0aXZhdGluZyBhIGJ1ZmZlciB3aXRoIDAgY2hhbm5lbHMg
ZW5hYmxlZCBkb2Vzbid0IG1ha2UgdG9vIG11Y2ggc2Vuc2UgYW5kDQo+IGRpc2FsbG93aW5nIHRo
aXMgY2FzZSBtYWtlcyBzdXJlIHRoYXQgaW5kaXZpZHVhbCBkcml2ZXIgZG9uJ3QgaGF2ZSB0byBh
ZGQNCj4gc3BlY2lhbCBjYXNlIGNvZGUgdG8gaGFuZGxlIGl0Lg0KPiANCg0Kb29wcywgaSBnb29m
LWVkIHBldGVyJ3MgZW1haWwgb24gdGhpcyBzZW5kOw0KWyBjb3B5ICsgcGFzdGUgZXJyIF0NCnNo
b3VsZCBiZSBmaXhlZCBub3c7DQoNCj4gQ3VycmVudGx5LCB3aXRob3V0IHRoaXMgcGF0Y2ggZW5h
YmxpbmcgYSBidWZmZXIgaXMgcG9zc2libGUgYW5kIG5vIGVycm9yIGlzDQo+IHByb2R1Y2VkLiBX
aXRoIHRoaXMgcGF0Y2ggLUVJTlZBTCBpcyByZXR1cm5lZC4NCj4gDQo+IEFuIGV4YW1wbGUgb2Yg
ZXhlY3V0aW9uIHdpdGggdGhpcyBwYXRjaCBhbmQgc29tZSBpbnN0cnVtZW50ZWQgcHJpbnQtY29k
ZToNCj4gICAgcm9vdEBhbmFsb2c6fiMgY2QgL3N5cy9idXMvaWlvL2RldmljZXMvaWlvXDpkZXZp
Y2UzL2J1ZmZlcg0KPiAgICByb290QGFuYWxvZzovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2
aWNlMy9idWZmZXIjIGVjaG8gMSA+IGVuYWJsZQ0KPiAgICAwOiBpaW9fdmVyaWZ5X3VwZGF0ZSA3
NDggaW5kaW9fZGV2LT5tYXNrbGVuZ3RoIDIgKmluc2VydF9idWZmZXItPnNjYW5fbWFzaw0KPiAw
MDAwMDAwMA0KPiAgICAxOiBpaW9fdmVyaWZ5X3VwZGF0ZSA3NTMNCj4gICAgMjpfX2lpb191cGRh
dGVfYnVmZmVycyAxMTE1IHJldCAtMjINCj4gICAgMzogaWlvX2J1ZmZlcl9zdG9yZV9lbmFibGUg
MTI0MSByZXQgLTIyDQo+ICAgIC1iYXNoOiBlY2hvOiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1
bWVudA0KPiAxLCAyICYgMyBhcmUgZXhpdC1lcnJvciBwYXRocy4gMCB0aGUgZmlyc3QgcHJpbnQg
aW4gaWlvX3ZlcmlmeV91cGRhdGUoKQ0KPiByZXJnYXJkbGVzcyBvZiBlcnJvciBwYXRoLg0KPiAN
Cj4gV2l0aG91dCB0aGlzIHBhdGNoIChhbmQgc2FtZSBpbnN0cnVtZW50ZWQgcHJpbnQtY29kZSk6
DQo+ICAgIHJvb3RAYW5hbG9nOn4jIGNkIC9zeXMvYnVzL2lpby9kZXZpY2VzL2lpb1w6ZGV2aWNl
My9idWZmZXINCj4gICAgcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmlj
ZTMvYnVmZmVyIyBlY2hvIDEgPiBlbmFibGUNCj4gICAgMDogaWlvX3ZlcmlmeV91cGRhdGUgNzQ4
IGluZGlvX2Rldi0+bWFza2xlbmd0aCAyICppbnNlcnRfYnVmZmVyLT5zY2FuX21hc2sNCj4gMDAw
MDAwMDANCj4gICAgcm9vdEBhbmFsb2c6L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTMv
YnVmZmVyIw0KPiBCdWZmZXIgaXMgZW5hYmxlZCB3aXRoIG5vIGVycm9yLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+
DQo+IC0tLQ0KPiANCj4gQ2hhbmdlbG9nIHYxIC0+IHYyOg0KPiAqIG1vdmVkIGNoZWNrIGluIGlp
b192ZXJpZnlfdXBkYXRlKCkNCj4gKiBhZGRlZCBkZXZfZGJnKCkgbWVzc2FnZTsgc2hvdWxkIGhl
bHAgc29tZSBmb2xrcyB1bmRlcnN0YW5kIHRoZSBtZXNzYWdlDQo+ICogZG9jdW1lbnRlZCBzdGVw
cyB0byByZXByb2R1Y2UNCj4gKiBhZGRlZCBGaXhlcyB0YWc7IGhvcGVmdWxseSB0aGUgdGFnIGlz
IHRoZSBnb29kIG9uZTsgaWYgbmVlZGVkLCBpdCBjYW4gYmUNCj4gICBkcm9wcGVkOyB0aGlzIGhh
cyBiZWVuIGFyb3VuZCBmb3IgfjggeWVhcnM7IG5vIGlkZWEgaWYgaXQncyB3b3J0aA0KPiAgIGJh
Y2twb3J0aW5nDQo+IA0KPiAgZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIHwgNyAr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jIGIvZHJpdmVycy9paW8vaW5k
dXN0cmlhbGlvLQ0KPiBidWZmZXIuYw0KPiBpbmRleCA1ZmYzNGNlOGI2YTIuLmU2ZmExYTRlMTM1
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWJ1ZmZlci5jDQo+ICsr
KyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1idWZmZXIuYw0KPiBAQCAtNjg2LDYgKzY4Niwx
MyBAQCBzdGF0aWMgaW50IGlpb192ZXJpZnlfdXBkYXRlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYsDQo+ICAJYm9vbCBzY2FuX3RpbWVzdGFtcDsNCj4gIAl1bnNpZ25lZCBpbnQgbW9kZXM7DQo+
ICANCj4gKwlpZiAoaW5zZXJ0X2J1ZmZlciAmJg0KPiArCSAgICBiaXRtYXBfZW1wdHkoaW5zZXJ0
X2J1ZmZlci0+c2Nhbl9tYXNrLCBpbmRpb19kZXYtPm1hc2tsZW5ndGgpKSB7DQo+ICsJCWRldl9k
YmcoJmluZGlvX2Rldi0+ZGV2LA0KPiArCQkJIkF0IGxlYXN0IG9uZSBzY2FuIGVsZW1lbnQgbXVz
dCBiZSBlbmFibGVkIGZpcnN0XG4iKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiAr
DQo+ICAJbWVtc2V0KGNvbmZpZywgMCwgc2l6ZW9mKCpjb25maWcpKTsNCj4gIAljb25maWctPndh
dGVybWFyayA9IH4wOw0KPiAgDQo=
