Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0751ACDDFB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJGJKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:10:35 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:8118 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbfJGJKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 05:10:35 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9797vCe009339;
        Mon, 7 Oct 2019 05:10:07 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2054.outbound.protection.outlook.com [104.47.33.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2veqt57b56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 05:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R012DHq4tnM7k7qOLNjghwyzuh+Ym0EGdEOFlo/fY8U87Z4lwEcAnfN0dBkaFphP+1N8dCZOnGewdffFP4CMnsutuEUirJqEPJPkkxPJ/We13FoZiToonPoEQ2YHwaJap6r1N/3aDL1tspuKgl6jvNrkONP1YIYJ8oxOudcTfehkef/Dt3ORblZzJsOH9wvCIU96co2oaoh8zlGDW/DmdZ8MXgXN5MNBcH7+7Q9KdzyrEIlR30nuuMCqR4CW9nvyGtSVM+KZ25IwRtl+Lrv6683IGt9qN52yvT8rrbEqMnvZtj3niFaFKjo1Fcpqgp10XMIR4txaQF0/HoVJPoJpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pclF3/1P8RGxbZL34L9/tulyL4hNjWrMB37WflSXIYE=;
 b=ckz7Ej4KtxT5uLv+6qjcqDkTd7desyufDvTvw+5SuLDipr3mRNYPSP1DWPozW0/5gKaU7og/1aMuWXUKfSWOkG0nLCjqPxSSf21eZpKn0mSx86teHh8XMvRKU+iupziv7Sl1nQHXF8AeaE6n8gpxS3WJn3xANZ1EqLubm8k0odT9hQgpCLQAObLq1/ZMGQe9Wj+eldgRXBXgPX0+z2shhZqqP3XchuOU6uwdLeng4bFLpD1euZDwcBpbqGVoeIhLsgYqfQAESwooD36may4zfY5Xk8fpc0aj1gpGrj5QGZtSIulZepWjJI3YJoxfcm2pP1o8/5H/DmggUvvz2zWYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pclF3/1P8RGxbZL34L9/tulyL4hNjWrMB37WflSXIYE=;
 b=89Q0JkfCV0Xg1LIRqV8gzCcjgN3xZIwAtrfqZfTgMQoCK20FwLN4oy9WxBekRT1TYgmsQlf+3+/q3+6WiYLiII5CbO3pYkXioB6ZW/qAGMZyEjrIZKKk0Ha4Q5D7Bs9ETbkMTuXzBqSQ929osmKcjkWwWPTXjLEJlHZxlw63JYw=
Received: from MN2PR03MB5117.namprd03.prod.outlook.com (52.132.171.137) by
 MN2PR03MB5312.namprd03.prod.outlook.com (10.186.146.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 09:10:06 +0000
Received: from MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5]) by MN2PR03MB5117.namprd03.prod.outlook.com
 ([fe80::8c20:8f3b:b536:dca5%7]) with mapi id 15.20.2327.025; Mon, 7 Oct 2019
 09:10:06 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Thread-Topic: [PATCH v3 1/2] iio: temperature: Add support for LTC2983
Thread-Index: AQHVertqUpI7UfsRN06rgGD7cfaxBadNbqcAgAF6B4A=
Date:   Mon, 7 Oct 2019 09:10:06 +0000
Message-ID: <fcddb48f722392578431ecccce4862288bbec6ba.camel@analog.com>
References: <20191004135519.191657-1-nuno.sa@analog.com>
         <20191006113732.1ffd597c@archlinux>
In-Reply-To: <20191006113732.1ffd597c@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4d53629-199c-4e0f-7a0b-08d74b06255d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR03MB5312:
x-microsoft-antispam-prvs: <MN2PR03MB5312DB4A6F1DC5E3532E23E3999B0@MN2PR03MB5312.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(36756003)(478600001)(76176011)(14454004)(118296001)(446003)(99286004)(11346002)(2616005)(476003)(486006)(2351001)(2501003)(6916009)(91956017)(66476007)(66946007)(66446008)(64756008)(66556008)(305945005)(76116006)(7736002)(5660300002)(86362001)(6506007)(66066001)(102836004)(26005)(81166006)(81156014)(6246003)(186003)(8676002)(71190400001)(316002)(229853002)(71200400001)(3846002)(6116002)(2906002)(14444005)(256004)(54906003)(5640700003)(4326008)(6436002)(6512007)(6306002)(25786009)(6486002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5312;H:MN2PR03MB5117.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPFSQBvfEw/Xkp78v6tP9aN4bz+ysX3Lvd7FbrtVBiF/ugkuGScZeIXRNeJpHyiVZlu5Jt0HVyLW2oPw5HCtIqeo70RzaNgPBJUw4Rv37DDVdg/pQ8F5B0huFybwvWKaSXlF/qQgr80fiK0VX98kerPu2W6sIZTL5d7TFybqjZ8vx8rtnC+LJ515+vAVxbtlQGfyAolYvi02TiKDNjAvNHo/lyIDSdEzJQ5UbyvIu2+uIBcLhYfBsSTGbCWeAfTtGNob7dyMYbTo8/D1Il3j1Rcl7Y5giYvsOF6rj3GNdYlUbTh6LhKfyPoV826t71y4sxys6LXWbzKZ3VYI0hmGynHWTEf1aG+lRw3Y3EHAa3eNsubOhZj9SSfSNTEnB5KdS/kHxyx65QEaaHDZHYKr0gWu+T0GKnlvblKpLHpQ2dA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <932B993D895C0449852C886EAAA22454@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d53629-199c-4e0f-7a0b-08d74b06255d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 09:10:06.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vw6CyMGtBWeU9xEBC9GSlSOawSxambtcZoaabvNnDqHFEDtEOii1SicLW/rPnxfhhyz1IspUTZDvHdeUjJeS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5312
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_01:2019-10-03,2019-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910070095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTA2IGF0IDExOjM3ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDQgT2N0IDIwMTkgMTU6NTU6MTggKzAyMDAN
Cj4gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBMVEMy
OTgzIGlzIGEgTXVsdGktU2Vuc29yIEhpZ2ggQWNjdXJhY3kgRGlnaXRhbCBUZW1wZXJhdHVyZQ0K
PiA+IE1lYXN1cmVtZW50IFN5c3RlbS4gSXQgbWVhc3VyZXMgYSB3aWRlIHZhcmlldHkgb2YgdGVt
cGVyYXR1cmUNCj4gPiBzZW5zb3JzIGFuZA0KPiA+IGRpZ2l0YWxseSBvdXRwdXRzIHRoZSByZXN1
bHQsIGluIMKwQyBvciDCsEYsIHdpdGggMC4xwrBDIGFjY3VyYWN5IGFuZA0KPiA+IDAuMDAxwrBD
IHJlc29sdXRpb24uIEl0IGNhbiBtZWFzdXJlIHRoZSB0ZW1wZXJhdHVyZSBvZiBhbGwgc3RhbmRh
cmQNCj4gPiB0aGVybW9jb3VwbGVzICh0eXBlIEIsRSxKLEssTixTLFIsVCksIHN0YW5kYXJkIDIt
LDMtLDQtd2lyZSBSVERzLA0KPiA+IHRoZXJtaXN0b3JzIGFuZCBkaW9kZXMuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gDQo+IFR3byB0
aGluZ3MgaW5saW5lIHRoYXQgSSdkIG1pc3NlZCBiZWZvcmUuIE90aGVyd2lzZSBsb29rcyBnb29k
Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdl
cyBpbiB2MjoNCj4gPiAgKiBBZGRlZCBzb21lIG5lZWRlZCBibGFuayBsaW5lcyAoZm9yIHJlYWRh
YmlsaXR5KTsNCj4gPiAgKiBBbGxvY2F0ZSBpaW9fY2hhbiBpbiB0aGUgc2V0dXAoKSBmdW5jdGlv
bjsNCj4gPiAgKiBSZW5hbWUgcmVzZXQgdG8gc2xlZXA7DQo+ID4gICogUmVtb3ZlIHVubmVlZGVk
IGRldl9kYmcgY2FsbHM7DQo+ID4gICogUmVtb3ZlIHVubmVlZGVkIGxpbmUgd3JhcHBpbmc7DQo+
ID4gICogUmVtb3ZlIHVubmVlZGVkIGNvbW1lbnRzOw0KPiA+ICAqIFJlbW92ZSBleHRlbmRfbmFt
ZXMuIFVzZSB0aGUgc3RhbmRhcmQgQUJJOw0KPiA+ICAqIEFkYXB0IHRoZSBzY2FsZXMgdG8gcmVw
b3J0IGluIG1pbGxpdm9sdCBhbmQgbWlsbGkgZGVncmVlczsNCj4gPiAgKiBBZGFwdCB0aGUgb2Zf
cHJvcGVydHkgcmVhZGluZ3MgdG8gdGhlIHJlbmFtaW5nIG9mIHRoZQ0KPiA+IHByb3BlcnRpZXM7
DQo+ID4gICogRm9yIGN1c3RvbSB0aGVybWlzdG9ycywgZXhjaXRhdGlvbi1jdXJyZW50IGNhbm5v
dCBiZSBzZXQgdG8gQXV0bw0KPiA+IHJhbmdlLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6DQo+
ID4gICogVXNlIG5vcm1hbCBgZGV2bV9yZXF1ZXN0X2lycWA7DQo+ID4gICogSGFuZGxlIGFuZCBk
ZWNvZGUgdGhlIG5ldyBkZXZpY2V0cmVlIHByb3BlcnRpZXMgZm9yIHNlbnNvcg0KPiA+IGNvbmZp
Z3VyYXRpb24uDQo+ID4gDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICB8
ICAgIDcgKw0KPiA+ICBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9LY29uZmlnICAgfCAgIDEwICsN
Cj4gPiAgZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvTWFrZWZpbGUgIHwgICAgMSArDQo+ID4gIGRy
aXZlcnMvaWlvL3RlbXBlcmF0dXJlL2x0YzI5ODMuYyB8IDE1NTQNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE1NzIgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvbHRjMjk4
My5jDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4g
PiBpbmRleCBmMGMwMzc0MGI5ZmIuLjE0YTI1NmU3ODVjYSAxMDA2NDQNCj4gPiAtLS0gYS9NQUlO
VEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTk0OTEsNiArOTQ5MSwxMyBA
QCBTOglNYWludGFpbmVkDQo+ID4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9paW8vZGFjL2x0YzE2NjAudHh0DQo+ID4gIEY6CWRyaXZlcnMvaWlvL2RhYy9sdGMxNjYwLmMN
Cj4gPiAgDQo+ID4gK0xUQzI5ODMgSUlPIFRFTVBFUkFUVVJFIERSSVZFUg0KPiA+ICtNOglOdW5v
IFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+ICtXOglodHRwOi8vZXouYW5hbG9nLmNvbS9j
b21tdW5pdHkvbGludXgtZGV2aWNlLWRyaXZlcnMNCj4gPiArTDoJbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ICtTOglTdXBwb3J0ZWQNCj4gPiArRjoJZHJpdmVycy9paW8vdGVtcGVyYXR1
cmUvbHRjMjk4My5jDQo+ID4gKw0KPiA+ICBMVEM0MjYxIEhBUkRXQVJFIE1PTklUT1IgRFJJVkVS
DQo+ID4gIE06CUd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCj4gPiAgTDoJbGlu
dXgtaHdtb25Admdlci5rZXJuZWwub3JnDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL3Rl
bXBlcmF0dXJlL0tjb25maWcNCj4gPiBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL0tjb25maWcN
Cj4gPiBpbmRleCA3MzdmYWEwOTAxZmUuLjA0YjVhNjdiNTkzYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2lpby90ZW1wZXJhdHVyZS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9paW8vdGVt
cGVyYXR1cmUvS2NvbmZpZw0KPiA+IEBAIC00LDYgKzQsMTYgQEANCj4gPiAgIw0KPiA+ICBtZW51
ICJUZW1wZXJhdHVyZSBzZW5zb3JzIg0KPiA+ICANCj4gPiArY29uZmlnIExUQzI5ODMNCj4gPiAr
CXRyaXN0YXRlICJBbmFsb2cgRGV2aWNlcyBNdWx0aS1TZW5zb3IgRGlnaXRhbCBUZW1wZXJhdHVy
ZQ0KPiA+IE1lYXN1cmVtZW50IFN5c3RlbSINCj4gPiArCWRlcGVuZHMgb24gU1BJDQo+IA0KPiBT
ZWxlY3QgUkVHTUFQX1NQSSBuZWVkZWQgSSB0aGluay4NCg0KYWNrLg0KDQo+ID4gKwloZWxwDQo+
ID4gKwkgIFNheSB5ZXMgaGVyZSB0byBidWlsZCBzdXBwb3J0IGZvciB0aGUgTFRDMjk4MyBNdWx0
aS1TZW5zb3INCj4gPiArCSAgaGlnaCBhY2N1cmFjeSBkaWdpdGFsIHRlbXBlcmF0dXJlIG1lYXN1
cmVtZW50IHN5c3RlbS4NCj4gPiArDQo+ID4gKwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMg
YSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZSBtb2R1bGUNCj4gPiArCSAgd2lsbCBiZSBjYWxs
ZWQgbHRjMjk4My4NCj4gPiArDQo+ID4gIGNvbmZpZyBNQVhJTV9USEVSTU9DT1VQTEUNCj4gPiAg
CXRyaXN0YXRlICJNYXhpbSB0aGVybW9jb3VwbGUgc2Vuc29ycyINCj4gPiAgCWRlcGVuZHMgb24g
U1BJDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJlL01ha2VmaWxlDQo+
ID4gYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9NYWtlZmlsZQ0KPiA+IGluZGV4IGJhY2E0Nzc2
Y2EwZC4uZDZiODUwYjBjZjYzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL3RlbXBlcmF0
dXJlL01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy9paW8vdGVtcGVyYXR1cmUvTWFrZWZpbGUN
Cj4gPiBAQCAtMyw2ICszLDcgQEANCj4gPiAgIyBNYWtlZmlsZSBmb3IgaW5kdXN0cmlhbCBJL08g
dGVtcGVyYXR1cmUgZHJpdmVycw0KPiA+ICAjDQo+ID4gIA0KPiA+ICtvYmotJChDT05GSUdfTFRD
Mjk4MykgKz0gbHRjMjk4My5vDQo+ID4gIG9iai0kKENPTkZJR19ISURfU0VOU09SX1RFTVApICs9
IGhpZC1zZW5zb3ItdGVtcGVyYXR1cmUubw0KPiA+ICBvYmotJChDT05GSUdfTUFYSU1fVEhFUk1P
Q09VUExFKSArPSBtYXhpbV90aGVybW9jb3VwbGUubw0KPiA+ICBvYmotJChDT05GSUdfTUFYMzE4
NTYpICs9IG1heDMxODU2Lm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vdGVtcGVyYXR1
cmUvbHRjMjk4My5jDQo+ID4gYi9kcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9sdGMyOTgzLmMNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjg5OWMxZDc1
ZjhhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL3RlbXBlcmF0dXJl
L2x0YzI5ODMuYw0KPiA+IEBAIC0wLDAgKzEsMTU1NCBAQA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRp
YyBpbnQgbHRjMjk4M19jaGFuX3JlYWQoc3RydWN0IGx0YzI5ODNfZGF0YSAqc3QsDQo+ID4gKwkJ
CWNvbnN0IHN0cnVjdCBsdGMyOTgzX3NlbnNvciAqc2Vuc29yLCBpbnQgKnZhbCkNCj4gPiArew0K
PiA+ICsJdTMyIHN0YXJ0X2NvbnZlcnNpb24gPSAwOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCXVu
c2lnbmVkIGxvbmcgdGltZTsNCj4gPiArCV9fYmUzMiB0ZW1wOw0KPiA+ICsNCj4gPiArCS8qDQo+
ID4gKwkgKiBEbyBub3QgYWxsb3cgY2hhbm5lbCByZWFkaW5ncyBpZiBkZXZpY2UgaXMgaW4gc2xl
ZXAgc3RhdGUuDQo+ID4gKwkgKiBBIHJlYWQvd3JpdGUgb24gdGhlIHNwaSBidXMgd291bGQgYnJp
bmcgdGhlIGRldmljZQ0KPiA+IHByZW1hdHVyZWx5DQo+ID4gKwkgKiBvdXQgb2Ygc2xlZXAuDQo+
ID4gKwkgKi8NCj4gPiArCWlmIChzdC0+c2xlZXApDQo+ID4gKwkJcmV0dXJuIC1FUEVSTTsNCj4g
PiArDQo+ID4gKwlzdGFydF9jb252ZXJzaW9uID0gTFRDMjk4M19TVEFUVVNfU1RBUlQodHJ1ZSk7
DQo+ID4gKwlzdGFydF9jb252ZXJzaW9uIHw9IExUQzI5ODNfU1RBVFVTX0NIQU5fU0VMKHNlbnNv
ci0+Y2hhbik7DQo+ID4gKwlkZXZfZGJnKCZzdC0+c3BpLT5kZXYsICJTdGFydCBjb252ZXJzaW9u
IG9uIGNoYW46JWQsDQo+ID4gc3RhdHVzOiUwMlhcbiIsDQo+ID4gKwkJc2Vuc29yLT5jaGFuLCBz
dGFydF9jb252ZXJzaW9uKTsNCj4gPiArCS8qIHN0YXJ0IGNvbnZlcnNpb24gKi8NCj4gPiArCXJl
dCA9IHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBMVEMyOTgzX1NUQVRVU19SRUcsDQo+ID4gc3Rh
cnRfY29udmVyc2lvbik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4g
Kw0KPiA+ICsJcmVpbml0X2NvbXBsZXRpb24oJnN0LT5jb21wbGV0aW9uKTsNCj4gPiArCS8qDQo+
ID4gKwkgKiB3YWl0IGZvciBjb252ZXJzaW9uIHRvIGNvbXBsZXRlLg0KPiA+ICsJICogMzAwIG1z
IHNob3VsZCBiZSBtb3JlIHRoYW4gZW5vdWdoIHRvIGNvbXBsZXRlIHRoZQ0KPiA+IGNvbnZlcnNp
b24uDQo+ID4gKwkgKiBEZXBlbmRpbmcgb24gdGhlIHNlbnNvciBjb25maWd1cmF0aW9uLCB0aGVy
ZSBhcmUgMi8zDQo+ID4gY29udmVyc2lvbnMNCj4gPiArCSAqIGN5Y2xlcyBvZiA4Mm1zLg0KPiA+
ICsJICovDQo+ID4gKwl0aW1lID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZzdC0+Y29t
cGxldGlvbiwNCj4gPiArCQkJCQkgICBtc2Vjc190b19qaWZmaWVzKDMwMCkpOw0KPiA+ICsJaWYg
KCF0aW1lKSB7DQo+ID4gKwkJZGV2X3dhcm4oJnN0LT5zcGktPmRldiwgIkNvbnZlcnNpb24gdGlt
ZWQgb3V0XG4iKTsNCj4gPiArCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwkvKiByZWFkIHRoZSBjb252ZXJ0ZWQgZGF0YSAqLw0KPiA+ICsJcmV0ID0gcmVnbWFwX2J1
bGtfcmVhZChzdC0+cmVnbWFwLA0KPiA+IExUQzI5ODNfQ0hBTl9SRVNfQUREUihzZW5zb3ItPmNo
YW4pLA0KPiA+ICsJCQkgICAgICAgJnRlbXAsIHNpemVvZih0ZW1wKSk7DQo+IA0KPiBJJ2QgbWlz
c2VkIHRoaXMgYmVmb3JlLiAgcmVnbWFwX2J1bGtfcmVhZCBjYW4gZGlyZWN0bHkgdXNlIHRoZQ0K
PiBzdXBwbGllZCBidWZmZXINCj4gZm9yIGRtYS4gIEhlbmNlIGl0IG5lZWRzIHRvIGJlIGRtYSBz
YWZlLiAgVGhhdCBtZWFucyB5b3UgaGF2ZSB0byBoYXZlDQo+IGl0DQo+IGluIGl0J3Mgb3duIGNh
Y2hlbGluZS4gIFRoZXJlIGlzIG5vIHdheSBvZiBlbmZvcmNpbmcgdGhhdCBvbiB0aGUNCj4gc3Rh
Y2sgc28NCj4gZWl0aGVyIGFsbG9jYXRlIGl0IGxvY2FsbHkgZnJvbSB0aGUgaGVhcCwgb3IgcHV0
IGl0IGF0IHRoZSBlbmQgb2YgdGhlDQo+IGRhdGEgc3RydWN0dXJlIGFuZCBtYXJrIGl0IF9fY2Fj
aGVsaW5lX2FsaWduZWQgKHdlIG1ha2Ugc3VyZSB0aG9zZQ0KPiBzdHJ1Y3R1cmVzDQo+IGFyZSBh
bHNvIGNhY2hlbGluZSBhbGlnbmVkIGFuZCBvbiB0aGUgaGVhcCBzcGVjaWZpY2FsbHkgdG8gYWxs
b3cgdXMNCj4gdG8gZG8gdGhhdA0KPiB0cmljaykuDQoNCkp1c3QgZm9yIG15IHVuZGVyc3RhbmRp
bmcuIEkgZG8gc2VlIHRoZSB0aGUgbmVlZCBvZiB1c2luZw0KX19jYWNoZWxpbmVfYWxpZ25lZCBv
biB0aGUgc3RydWN0IHBhcmFtZXRlciB3ZSB3YW50IHRvIGFsaWduLiBJIHdhcyBub3cNCnRyeWlu
ZyB0byB1bmRlcnN0YW5kIHlvdXIgY29tbWVudCBvbiBwYXJlbnRoZXNpcy4gV2h5IGRvIHdlIG5l
ZWQgdGhhdA0KdHJpY2s/IFdvdWxkbid0IGJlIHN1ZmZpY2llbnQgdG8gaGF2ZSB0aGUgc3RydWN0
IGVsZW1lbnQgbWFya2VkIHdpdGgNCl9fY2FjaGVsaW5lX2FsaWduZWQ/DQoNCj4gDQo+ID4gKwlp
ZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJKnZhbCA9IF9fYmUzMl90
b19jcHUodGVtcCk7DQo+ID4gKw0KPiA+ICsJaWYgKCEoTFRDMjk4M19SRVNfVkFMSURfTUFTSyAm
ICp2YWwpKSB7DQo+ID4gKwkJZGV2X2Vycigmc3QtPnNwaS0+ZGV2LCAiSW52YWxpZCBjb252ZXJz
aW9uDQo+ID4gZGV0ZWN0ZWRcbiIpOw0KPiA+ICsJCXJldHVybiAtRUlPOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCXJldCA9IHNlbnNvci0+ZmF1bHRfaGFuZGxlcihzdCwgKnZhbCk7DQo+ID4gKwlp
ZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJKnZhbCA9IHNpZ25fZXh0
ZW5kMzIoKCp2YWwpICYgTFRDMjk4M19EQVRBX01BU0ssDQo+ID4gTFRDMjk4M19EQVRBX1NJR05f
QklUKTsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiAuLi4NCg0KVGhhbmtzIQ0K
TnVubyBTw6ENCg==
