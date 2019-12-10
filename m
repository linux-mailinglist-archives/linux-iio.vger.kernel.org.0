Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF3118A68
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2019 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJOHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Dec 2019 09:07:09 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:48562 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfLJOHJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Dec 2019 09:07:09 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAE003u011023;
        Tue, 10 Dec 2019 09:07:05 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wragq9j5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Dec 2019 09:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtgXLNI17nRHc/ot0RComAQ4SELZvajvPf+wExU9nWRhyN0sTn3hNxw0Ek6h7/4dxmyYGHj3ax6lG2yHhixI0YmiXDq7ZanxP4nMoVFnXrb03nDpxFoEntEppA8QM4NzYO6eZgpiXFvIlP87qrx+WR3Mv6V4lfFBZuXBl7h3BxHNYmGl9DKSkObvUkqj4NEcfkMVu12v5RMX/d/ot4QXBp96sr+dcDFgXpG7uTWS0QkKuFhmAlsQy+aX8v5KyjRSn0+6cjWZSs/P5/gFhrvv838yPZVwe9daIvESIGSQ5TQA6kNHVFeRnVhymzNOiAvooQ75b1zTtaj6n+vW1gcikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfGtTJqLF6m4Mi27eksU0hyxd3xZ1dxEcbyW00lBasI=;
 b=f7jHMVb4ngvLD7DPubUXniaCzJEJDKeMOzaMbc5aurLbJFDNVHcPO8oL73DQhJm3KfvPGhk42pQvM4mf70OHKNj3g+TZRrl7A0piNV3tyJYn8XkoJxJPW7d3FBYYyhLyGOaiiWeEqrcMId3yiIvb6cmuWgv2M37XvWwipFNNnI6n1I+myH6kvF3080bJNOZtpOjPMSScI5MQkoOG8hIr5n90Gnb1HVhPkKBJ48PJggliw48GspmJtlU1FgBHGjQ0lSAbSrmKWIebPJ2OVpWS07RZkj+SpSMxzySqOq5mqDq6teNdY6m0fk9HdHKQ7T6ZTJhswqxh5sTbu3ocptICfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfGtTJqLF6m4Mi27eksU0hyxd3xZ1dxEcbyW00lBasI=;
 b=YjwrLqOcDInkCH9axOAb5QgAh9ZEg1JphA2u6O/a39w9qIRhZAFzAXLZnorIUh+65ujw4LiD9cdLI2Eb71mPk32rLdztWMLTkT/TuzMIkyf/Kt++DSTAfDDfhV2EpwrFcMQLtDX7SZcReou5Akhxcg28UOgmUdKIcHo9YUzifFY=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5319.namprd03.prod.outlook.com (20.180.13.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Tue, 10 Dec 2019 14:07:02 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 14:07:02 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: adis: use new `delay` structure for SPI
 transfer delays
Thread-Topic: [PATCH] iio: imu: adis: use new `delay` structure for SPI
 transfer delays
Thread-Index: AQHVqnn0TYOpdoKkvkWU7fb/NdYeKaeuh2YAgATp1gA=
Date:   Tue, 10 Dec 2019 14:07:02 +0000
Message-ID: <5401e982a04d32ac17465fa20b34de40dd9bb622.camel@analog.com>
References: <20191204080904.2557-1-alexandru.ardelean@analog.com>
         <20191207110504.6db10b0a@archlinux>
In-Reply-To: <20191207110504.6db10b0a@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4227ae5-a5e7-4ef8-058c-08d77d7a3b1d
x-ms-traffictypediagnostic: CH2PR03MB5319:
x-microsoft-antispam-prvs: <CH2PR03MB5319B661D1EFEFF35DFCD966F95B0@CH2PR03MB5319.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(55674003)(478600001)(5660300002)(6916009)(186003)(6512007)(71200400001)(54906003)(36756003)(86362001)(4326008)(2906002)(6506007)(316002)(26005)(76116006)(81166006)(81156014)(66946007)(8676002)(6486002)(8936002)(2616005)(64756008)(66446008)(66476007)(66556008)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5319;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlninWcuYrc9dUM0oISV/qMPhL92sk1uH4KGTAm2OY3zfqdz0IHhYy+0NI3bbk9K84t0/SflJmoYmuR53Zh0eFaAsy0qPQp1wox8ibEaol+GLYiOacMqYz+RahhH6WjLgBCsCHliPlzC566Ojuewt5e+uXZ1sayYkDuQxMjxT/WnRRZJFHpQRCwwPEQ2CVTaStPOJGv1GJHeRHfju3yZia39zmUXnUvnE7z4kJVroqmOclbzfVNZGhdFX5ncHm8g5s5QHFBU0DJ/+e4c1jmum9ipYG6MzofSuISsJvKNaEEk30lmlQMxGjBpqLlLkvi+wWfWD7UMhjpTC/8MC1qJYma9SXY+oQROffrRjwExO2VMfR/Hmh/ofJH6FXFeAqSDpe3JPSVWOes7tK98yOxgfGNvIikOBO7vagdkgqvPop4InVmxLi09NQE7W/OoJIa62MUrvrzcNvmjqE217d6eIvsOrAEjDenwe64jaKziHgB3UvND2JqN35TgUmzjjSYlAh9tOtKCM4iOryvGLNojkA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7E739224126BD4B87E904F4D19029D3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4227ae5-a5e7-4ef8-058c-08d77d7a3b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 14:07:02.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cigSkA4eCyAx5ArcXE4fD4wjTuZjRdK7iwPGzqP9wK878zH4dEW7Gv1HkY/scd0fhXkZMrdpC63UbjnCF/psIeANgAy/BoSZh7B9Xvkf5jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5319
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_03:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTEyLTA3IGF0IDExOjA1ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBXZWQsIDQgRGVjIDIwMTkgMTA6MDk6MDQgKzAyMDANCj4gQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEluIGEg
cmVjZW50IGNoYW5nZSB0byB0aGUgU1BJIHN1YnN5c3RlbSBbMV0sIGEgbmV3IGBkZWxheWAgc3Ry
dWN0IHdhcw0KPiA+IGFkZGVkDQo+ID4gdG8gcmVwbGFjZSB0aGUgYGRlbGF5X3VzZWNzYC4gVGhp
cyBjaGFuZ2UgcmVwbGFjZXMgdGhlIGN1cnJlbnQNCj4gPiBgZGVsYXlfc2Vjc2ANCj4gPiB3aXRo
IGBkZWxheWAgZm9yIHRoaXMgZHJpdmVyLg0KPiA+IA0KPiA+IFRoZSBgc3BpX3RyYW5zZmVyX2Rl
bGF5X2V4ZWMoKWAgZnVuY3Rpb24gW2luIHRoZSBTUEkgZnJhbWV3b3JrXSBtYWtlcw0KPiA+IHN1
cmUNCj4gPiB0aGF0IGJvdGggYGRlbGF5X3VzZWNzYCAmIGBkZWxheWAgYXJlIHVzZWQgKGluIHRo
aXMgb3JkZXIgdG8gcHJlc2VydmUNCj4gPiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSkuDQo+ID4g
DQo+ID4gWzFdIGNvbW1pdCBiZWJjZmQyNzJkZjY0ODUgKCJzcGk6IGludHJvZHVjZSBgZGVsYXlg
IGZpZWxkIGZvcg0KPiA+IGBzcGlfdHJhbnNmZXJgICsgc3BpX3RyYW5zZmVyX2RlbGF5X2V4ZWMo
KSIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5k
cnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gSSBkb24ndCB5ZXQgaGF2ZSB0aGF0IHBhdGNoIGlu
IG15IHVwc3RyZWFtIHNvIHRoaXMgd2lsbCBoYXZlIHRvIHdhaXQNCj4gdW50aWwNCj4gaXQgZ2V0
cyB0aGVyZS4gR2l2ZSBtZSBhIHBva2UgaWYgSSBzZWVtIHRvIGhhdmUgZm9yZ290dGVuIGFib3V0
IGl0Lg0KDQpBY2suDQpXaWxsIHNlbmQgYSBWMiB3aXRoIGEgdHlwbyBmaXggaW4gdGhlIGNvbW1p
dC1kZXNjIGluIHRoZSBtZWFudGltZS4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4N
Cj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpcy5jIHwgMjcgKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9p
bXUvYWRpcy5jIGIvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+IGluZGV4IDJjZDJjYzIzMTZj
Ni4uOTVhZjY3NDcwNjY4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+ID4gQEAgLTM4LDcgKzM4LDggQEAg
aW50IGFkaXNfd3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQNCj4gPiBy
ZWcsDQo+ID4gIAkJCS5iaXRzX3Blcl93b3JkID0gOCwNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4g
IAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+IC0JCQkuZGVsYXlfdXNlY3MgPSBhZGlzLT5kYXRhLT53
cml0ZV9kZWxheSwNCj4gPiArCQkJLmRlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0+d3JpdGVfZGVs
YXksDQo+ID4gKwkJCS5kZWxheS51bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MsDQo+ID4gIAkJ
CS5jc19jaGFuZ2VfZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRhLQ0KPiA+ID5jc19jaGFuZ2VfZGVs
YXksDQo+ID4gIAkJCS5jc19jaGFuZ2VfZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNT
LA0KPiA+ICAJCX0sIHsNCj4gPiBAQCAtNDYsNyArNDcsOCBAQCBpbnQgYWRpc193cml0ZV9yZWco
c3RydWN0IGFkaXMgKmFkaXMsIHVuc2lnbmVkIGludA0KPiA+IHJlZywNCj4gPiAgCQkJLmJpdHNf
cGVyX3dvcmQgPSA4LA0KPiA+ICAJCQkubGVuID0gMiwNCj4gPiAgCQkJLmNzX2NoYW5nZSA9IDEs
DQo+ID4gLQkJCS5kZWxheV91c2VjcyA9IGFkaXMtPmRhdGEtPndyaXRlX2RlbGF5LA0KPiA+ICsJ
CQkuZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRhLT53cml0ZV9kZWxheSwNCj4gPiArCQkJLmRlbGF5
LnVuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUywNCj4gPiAgCQkJLmNzX2NoYW5nZV9kZWxheS52
YWx1ZSA9IGFkaXMtPmRhdGEtDQo+ID4gPmNzX2NoYW5nZV9kZWxheSwNCj4gPiAgCQkJLmNzX2No
YW5nZV9kZWxheS51bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MsDQo+ID4gIAkJfSwgew0KPiA+
IEBAIC01NCwxOSArNTYsMjIgQEAgaW50IGFkaXNfd3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlz
LCB1bnNpZ25lZCBpbnQNCj4gPiByZWcsDQo+ID4gIAkJCS5iaXRzX3Blcl93b3JkID0gOCwNCj4g
PiAgCQkJLmxlbiA9IDIsDQo+ID4gIAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+IC0JCQkuZGVsYXlf
dXNlY3MgPSBhZGlzLT5kYXRhLT53cml0ZV9kZWxheSwNCj4gPiArCQkJLmRlbGF5LnZhbHVlID0g
YWRpcy0+ZGF0YS0+d3JpdGVfZGVsYXksDQo+ID4gKwkJCS5kZWxheS51bml0ID0gU1BJX0RFTEFZ
X1VOSVRfVVNFQ1MsDQo+ID4gIAkJCS5jc19jaGFuZ2VfZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRh
LQ0KPiA+ID5jc19jaGFuZ2VfZGVsYXksDQo+ID4gIAkJCS5jc19jaGFuZ2VfZGVsYXkudW5pdCA9
IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCX0sIHsNCj4gPiAgCQkJLnR4X2J1ZiA9IGFk
aXMtPnR4ICsgNiwNCj4gPiAgCQkJLmJpdHNfcGVyX3dvcmQgPSA4LA0KPiA+ICAJCQkubGVuID0g
MiwNCj4gPiAtCQkJLmRlbGF5X3VzZWNzID0gYWRpcy0+ZGF0YS0+d3JpdGVfZGVsYXksDQo+ID4g
KwkJCS5kZWxheS52YWx1ZSA9IGFkaXMtPmRhdGEtPndyaXRlX2RlbGF5LA0KPiA+ICsJCQkuZGVs
YXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCX0sIHsNCj4gPiAgCQkJLnR4
X2J1ZiA9IGFkaXMtPnR4ICsgOCwNCj4gPiAgCQkJLmJpdHNfcGVyX3dvcmQgPSA4LA0KPiA+ICAJ
CQkubGVuID0gMiwNCj4gPiAtCQkJLmRlbGF5X3VzZWNzID0gYWRpcy0+ZGF0YS0+d3JpdGVfZGVs
YXksDQo+ID4gKwkJCS5kZWxheS52YWx1ZSA9IGFkaXMtPmRhdGEtPndyaXRlX2RlbGF5LA0KPiA+
ICsJCQkuZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCX0sDQo+ID4g
IAl9Ow0KPiA+ICANCj4gPiBAQCAtMTM4LDcgKzE0Myw4IEBAIGludCBhZGlzX3JlYWRfcmVnKHN0
cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQNCj4gPiByZWcsDQo+ID4gIAkJCS5iaXRzX3Bl
cl93b3JkID0gOCwNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4gIAkJCS5jc19jaGFuZ2UgPSAxLA0K
PiA+IC0JCQkuZGVsYXlfdXNlY3MgPSBhZGlzLT5kYXRhLT53cml0ZV9kZWxheSwNCj4gPiArCQkJ
LmRlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0+d3JpdGVfZGVsYXksDQo+ID4gKwkJCS5kZWxheS51
bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MsDQo+ID4gIAkJCS5jc19jaGFuZ2VfZGVsYXkudmFs
dWUgPSBhZGlzLT5kYXRhLQ0KPiA+ID5jc19jaGFuZ2VfZGVsYXksDQo+ID4gIAkJCS5jc19jaGFu
Z2VfZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCX0sIHsNCj4gPiBA
QCAtMTQ2LDcgKzE1Miw4IEBAIGludCBhZGlzX3JlYWRfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1
bnNpZ25lZCBpbnQNCj4gPiByZWcsDQo+ID4gIAkJCS5iaXRzX3Blcl93b3JkID0gOCwNCj4gPiAg
CQkJLmxlbiA9IDIsDQo+ID4gIAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+IC0JCQkuZGVsYXlfdXNl
Y3MgPSBhZGlzLT5kYXRhLT5yZWFkX2RlbGF5LA0KPiA+ICsJCQkuZGVsYXkudmFsdWUgPSBhZGlz
LT5kYXRhLT5yZWFkX2RlbGF5LA0KPiA+ICsJCQkuZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklU
X1VTRUNTLA0KPiA+ICAJCQkuY3NfY2hhbmdlX2RlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0NCj4g
PiA+Y3NfY2hhbmdlX2RlbGF5LA0KPiA+ICAJCQkuY3NfY2hhbmdlX2RlbGF5LnVuaXQgPSBTUElf
REVMQVlfVU5JVF9VU0VDUywNCj4gPiAgCQl9LCB7DQo+ID4gQEAgLTE1NSwxNCArMTYyLDE2IEBA
IGludCBhZGlzX3JlYWRfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQNCj4gPiBy
ZWcsDQo+ID4gIAkJCS5iaXRzX3Blcl93b3JkID0gOCwNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4g
IAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+IC0JCQkuZGVsYXlfdXNlY3MgPSBhZGlzLT5kYXRhLT5y
ZWFkX2RlbGF5LA0KPiA+ICsJCQkuZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRhLT5yZWFkX2RlbGF5
LA0KPiA+ICsJCQkuZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCQku
Y3NfY2hhbmdlX2RlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0NCj4gPiA+Y3NfY2hhbmdlX2RlbGF5
LA0KPiA+ICAJCQkuY3NfY2hhbmdlX2RlbGF5LnVuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUywN
Cj4gPiAgCQl9LCB7DQo+ID4gIAkJCS5yeF9idWYgPSBhZGlzLT5yeCArIDIsDQo+ID4gIAkJCS5i
aXRzX3Blcl93b3JkID0gOCwNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4gLQkJCS5kZWxheV91c2Vj
cyA9IGFkaXMtPmRhdGEtPnJlYWRfZGVsYXksDQo+ID4gKwkJCS5kZWxheS52YWx1ZSA9IGFkaXMt
PmRhdGEtPnJlYWRfZGVsYXksDQo+ID4gKwkJCS5kZWxheS51bml0ID0gU1BJX0RFTEFZX1VOSVRf
VVNFQ1MsDQo+ID4gIAkJfSwNCj4gPiAgCX07DQo+ID4gIA0K
