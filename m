Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87CAB18C6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfIMHT5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 03:19:57 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13038 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfIMHT5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 03:19:57 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D78QwT008664;
        Fri, 13 Sep 2019 03:19:24 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2055.outbound.protection.outlook.com [104.47.40.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytd1h5fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 03:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/XQWekC+9/Bee/idoftxQJ5q4ZsmJRZSJ0bQLT6msISb686fGRFCdd6mpz7kwBk+rxgvxoPLk6Z5+BlN4r/nrcSZCPW6Iadh1A6V6MgF9+qh29JZo34O5W44DW4kDz1Qb4xbBrJsBFPWXVvdFUiBBUwO+EdzxqnZHP6UvnV91NvMbpL5N38ylQNqV+0fuaBN8V7yBdQb1zcFEcmo793yG5fJZM69vuHsGnurYtojzUQNDdbholrvoOcGSSazQ5T3lCLFzghH1IFhM9NdWFdP1igYdLts8S4vtIbTrpKStwxeVQUwqUH2pspe3H0XbXwTV3yyo4ZuPPW/HwuhtHnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkoNnnv8q5xc/h2JUIn2+/30xsfrqcxiA9UEFZo2dzc=;
 b=AEkPmYBeQbs8xeTY3EYSOPB7N7Nzp2h82spyN90I33EA64EgUV1YjX+Riorr8S32DAjsAyRoxg00NyOXb7cN63XtvFAWsHoyP132zcJFMJiuQyC3HG9y8PrdCOXl9b58QKNhdmuVAKdtdrcGa09uGBXMYvwVgvqWtrAFtb/o6JYpncB0dMjNnSzzSko/uTmPIUp//EEndCH9aHXivNGddoE4rDB4oStdPh2vijHmn7Qv4NAIF+T38wVk2Zw3gNs5f8H24IS1XOIApn0Z5Bx1dchToC9zSvpdct00iAuShszobpsgzKLk1fQaypYQBq54BLW2rxkuj9XSGQz9IdB1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkoNnnv8q5xc/h2JUIn2+/30xsfrqcxiA9UEFZo2dzc=;
 b=NgA8M2mk8qscJNUEQG/dzufAPmg32fo/AMYRi/JOlVqqcWi6ZNi57NGw3IY9HelAionvZT9PTAfttugXVdh+h6w2rnw2qF3Go0rsHeOMUloNUMgHkKiXAse02brNyLBG1wD2kvdq41qq2b/9+6DTOrpRlRnC55mNM5/Kznpw28g=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5222.namprd03.prod.outlook.com (20.180.15.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 07:19:22 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.021; Fri, 13 Sep 2019
 07:19:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
Thread-Topic: [PATCH 4/4] iio: ad7949: fix channels mixups
Thread-Index: AQHVaXiBmIU5gpB/Bkuupm/D5hWhg6cpZngA
Date:   Fri, 13 Sep 2019 07:19:21 +0000
Message-ID: <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
         <20190912144310.7458-5-andrea.merello@gmail.com>
In-Reply-To: <20190912144310.7458-5-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a785ca8a-1c71-4afd-4acd-08d7381ab305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR03MB5222;
x-ms-traffictypediagnostic: CH2PR03MB5222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR03MB5222695FF5737726E668D01CF9B30@CH2PR03MB5222.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(6246003)(2501003)(66066001)(305945005)(2906002)(7736002)(3846002)(6116002)(25786009)(4326008)(66446008)(64756008)(66946007)(66476007)(66556008)(14454004)(76116006)(5660300002)(229853002)(478600001)(36756003)(186003)(476003)(110136005)(11346002)(6436002)(99286004)(2616005)(316002)(6486002)(446003)(8936002)(2201001)(81166006)(86362001)(76176011)(256004)(8676002)(14444005)(81156014)(6506007)(486006)(26005)(102836004)(53936002)(71200400001)(71190400001)(6512007)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5222;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lur03wXYrIeuAy57eG/J8RICKTJ25qp1Id+A8/PMsWsLIYx5JksoS2wFJpSTSa+WamraM8OC9kDaz8LBDGhSHk63kJgQ2Y1KqmhxWupZUvGISv3TF03wgLKpDrgWKdMaO8qDT9kH729Gzq8aFnXAahRxWze9qYb9mg+/T23F2UmzSijidLI5+4cbNYq/Aj9noMczFTzI3vtSOHrwVbJmo8kHRn3jDZHx9vq0xvhL9+FKvAzAIDDm53ioEf5+IzHMdToBcpCtReMrz39KAIwYjfU171Er4AxLAYBx6Edrp7g+3Yt1/hsMrGRprUxRkL2NGL0AmAz6BBFj0aL2l07I5IDyRk1J4+5JWu1mQZhhIEJ1YjO68Ff6FMnGujrliL0vQaahnGttsILDHUPTHaSEsnHGc55CppwNtSFK0dv3vBg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D293CA6BFAF448B89AED784E9A8204@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a785ca8a-1c71-4afd-4acd-08d7381ab305
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 07:19:21.8586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJo3JuzJAZ+nmI2N3nnR4Q8T3Y5WF9NUtrqh/2FWRhizUPkrwFiTCmZCyOu/CD/jDc3xShkyi+zRCXegKDhbaBw/Cevro0cf8pogo6PYh/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5222
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_04:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDE2OjQzICswMjAwLCBBbmRyZWEgTWVyZWxsbyB3cm90ZToN
Cj4gW0V4dGVybmFsXQ0KPiANCj4gRWFjaCB0aW1lIHdlIG5lZWQgdG8gcmVhZCBhIHNhbXBsZSB0
aGUgZHJpdmVyIHdyaXRlcyB0aGUgQ0ZHIHJlZ2lzdGVyDQo+IChzZXR0aW5nIHRoZSBjaGFubmVs
IHRvIGJlIHJlYWQgaW4gc3VjaCByZWdpc3RlcikgYW5kIHRoZW4gaXQgcGVyZm9ybXMNCj4gYW5v
dGhlciB4ZmVyIHRvIHJlYWQgdGhlIHJlc3VsdGluZyB2YWx1ZS4NCj4gDQo+IFRoaXMgZG9lcyBu
b3Qgd29yayBjb3JyZWN0bHkgYmVjYXVzZSB3aGlsZSB3cml0aW5nIHRoZSBDRkcgcmVnaXN0ZXIg
dGhlDQo+IGFjcXVpc2l0aW9uIHBoYXNlIGlzIG9uZ29pbmcgdXNpbmcgdGhlIF9wcmV2aW91c18g
Q0ZHIHNldHRpbmdzLiBUaGVuIHRoZQ0KPiBkZXZpY2UgcGVyZm9ybXMgdGhlIGNvbnZlcnNpb24g
ZHVyaW5nIHhmZXIgZGVsYXkgb24gdGhlIHZvbHRhZ2Ugc3RvcmVkDQo+IGR1dGluZyB0aGUgc2Fp
ZCBhY3F1aXNpdGFpb24gcGhhc2UuIEZpbmFsbHkgdGhlIGRyaXZlciBwZXJmb3JtcyB0aGUgcmVh
ZA0KPiAoZHVyaW5nIHRoZSBuZXh0IGFjcXVpc2l0aW9uIHBoYXNlLCB3aGljaCBpcyB0aGUgb25l
IGRvbmUgd2l0aCB0aGUgcmlnaHQNCj4gc2V0dGluZ3MpIGFuZCBpdCBnZXRzIHRoZSBsYXN0IGNv
bnZlcnRlZCB2YWx1ZSwgdGhhdCBpcyB0aGUgd3JvbmcgZGF0YS4NCj4gDQo+IEluIGNhc2UgdGhl
IGNvbmZpZ3VyYXRpb24gaXMgbm90IGFjdHVhbGx5IGNoYW5nZWQsIHRoZW4gd2Ugc3RpbGwgZ2V0
DQo+IGNvcnJlY3QgZGF0YSwgYnV0IGluIGNhc2UgdGhlIGNvbmZpZ3VyYXRpb24gY2hhbmdlcyAo
YW5kIHRoaXMgaGFwcGVucyBlLmcuDQo+IHN3aXRjaGluZyB0aGUgTVVYIG9uIGFub3RoZXIgY2hh
bm5lbCksIHdlIGdldCB3cm9uZyBkYXRhIChkYXRhIGZyb20gdGhlDQo+IHByZXZpb3VzbHkgc2Vs
ZWN0ZWQgY2hhbm5lbCkuDQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoaXMgYnkgcGVyZm9ybWlu
ZyBvbmUgbW9yZSAiZHVtbXkiIHRyYW5zZmVyIGluIG9yZGVyIHRvDQo+IGVuZGluZyB1cCBpbiBy
ZWFkaW5nIHRoZSBkYXRhIHdoZW4gaXQncyByZWFsbHkgcmVhZHkuDQoNClNvLCBhdCBwb3dlci11
cCB0aGlzIGNoaXAgc2VlbXMgdG8gbmVlZCAyIGR1bW15IHJlYWRzIHRvIGRpc2NhcmQgZGF0YS4N
CldoaWNoIHNlZW1zIHRvIGhhcHBlbiBpbiBhZDc5NDlfc3BpX2luaXQoKQ0KDQpPbmUgdGhpbmcg
dGhhdCBtYXliZSBjb3VsZCBiZSBvcHRpbWl6ZWQgKGZvciB0aGUgZHJpdmVyKSwgaXMgaW4gYGFk
Nzk0OV9zcGlfcmVhZF9jaGFubmVsKClgIHRvIHVzZSB0aGUgY3VycmVudC1jaGFubmVsICYNCm5v
dCBkbyBhIFNQSSB3cml0ZSB0byBjaGFuZ2UgdGhlIGNoYW5uZWwgaWYgaXQgZG9lc24ndCBjaGFu
Z2UuDQoNCkRhdGFzaGVldHMgKGluIGdlbmVyYWwpIGFyZSBub3QgYWx3YXlzIG9idmlvdXMgYWJv
dXQgZGVzY3JpYmluZyBjaGlwIGJlaGF2aW9yIGZvciBTVyAob3IgZm9yIHdyaXRpbmcgYSBkcml2
ZXIpLCBidXQgSQ0Kd291bGQgc3VzcGVjdCB0aGF0IGlmIHlvdSBhcmUgcmVhZGluZyBnYXJiYWdl
IGRhdGEsIGl0IGNvdWxkIGJlIHRoYXQgdGhlIGNoYW5uZWwgaGFzIGNoYW5nZWQuDQpUaGlzIGlz
IHRydWUgZm9yIHNvbWUgb3RoZXIgQURDcy4NCkFuZCByZXF1aXJlcyB0ZXN0aW5nIGZvciB0aGlz
IG9uZS4NCg0KQWRkZWQgQ2hhcmxlcy1BbnRvaW5lLCBzaW5jZSBoZSB3cm90ZSB0aGUgZHJpdmVy
Lg0KU2hvdWQgaGF2ZSBhZGRlZCBoaW0gb24gdGhlIG90aGVyIHBhdGNoZXMgYXMgd2VsbCwgYnV0
IEkganVzdCByZW1lbWJlcmVkLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmVhIE1lcmVsbG8gPGFuZHJlYS5tZXJlbGxvQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2lpby9hZGMvYWQ3OTQ5LmMgfCAxOCArKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDku
Yw0KPiBpbmRleCAyNWQxZTFiMjQyNTcuLmIxZGJlMjA3NWNhOSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9paW8vYWRjL2FkNzk0OS5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDc5NDkuYw0K
PiBAQCAtODUsNiArODUsNyBAQCBzdGF0aWMgaW50IGFkNzk0OV9zcGlfcmVhZF9jaGFubmVsKHN0
cnVjdCBhZDc5NDlfYWRjX2NoaXAgKmFkNzk0OV9hZGMsIGludCAqdmFsLA0KPiAgCQkJCSAgIHVu
c2lnbmVkIGludCBjaGFubmVsKQ0KPiAgew0KPiAgCWludCByZXQ7DQo+ICsJaW50IGk7DQo+ICAJ
aW50IGJpdHNfcGVyX3dvcmQgPSBhZDc5NDlfYWRjLT5yZXNvbHV0aW9uOw0KPiAgCWludCBtYXNr
ID0gR0VOTUFTSyhhZDc5NDlfYWRjLT5yZXNvbHV0aW9uLCAwKTsNCj4gIAlzdHJ1Y3Qgc3BpX21l
c3NhZ2UgbXNnOw0KPiBAQCAtOTcsMTIgKzk4LDE5IEBAIHN0YXRpYyBpbnQgYWQ3OTQ5X3NwaV9y
ZWFkX2NoYW5uZWwoc3RydWN0IGFkNzk0OV9hZGNfY2hpcCAqYWQ3OTQ5X2FkYywgaW50ICp2YWws
DQo+ICAJCX0sDQo+ICAJfTsNCj4gIA0KPiAtCXJldCA9IGFkNzk0OV9zcGlfd3JpdGVfY2ZnKGFk
Nzk0OV9hZGMsDQo+IC0JCQkJICAgY2hhbm5lbCA8PCBBRDc5NDlfT0ZGU0VUX0NIQU5ORUxfU0VM
LA0KPiAtCQkJCSAgIEFENzk0OV9NQVNLX0NIQU5ORUxfU0VMKTsNCj4gLQlpZiAocmV0KQ0KPiAt
CQlyZXR1cm4gcmV0Ow0KPiArCS8qDQo+ICsJICogMTogd3JpdGUgQ0ZHIGZvciBzYW1wbGUgJ24n
IGFuZCByZWFkIGdhcmJhZ2UgKHNhbXBsZSBuLTIpDQo+ICsJICogMjogd3JpdGUgc29tZXRoaW5n
IGFuZCByZWFkIGdhcmJhZ2UgKHNhbXBsZSBuLTEpDQo+ICsJICovDQo+ICsJZm9yIChpID0gMDsg
aSA8IDI7IGkrKykgew0KPiArCQlyZXQgPSBhZDc5NDlfc3BpX3dyaXRlX2NmZyhhZDc5NDlfYWRj
LA0KPiArCQkJCQkgICBjaGFubmVsIDw8IEFENzk0OV9PRkZTRVRfQ0hBTk5FTF9TRUwsDQo+ICsJ
CQkJCSAgIEFENzk0OV9NQVNLX0NIQU5ORUxfU0VMKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJl
dHVybiByZXQ7DQo+ICsJfQ0KPiAgDQo+ICsJLyogMzogd3JpdGUgc29tZXRoaW5nIGFuZCByZWFk
IGRhdGEgZm9yIHNhbXBsZSAnbicgKi8NCj4gIAlhZDc5NDlfYWRjLT5idWZmZXIgPSAwOw0KPiAg
CXNwaV9tZXNzYWdlX2luaXRfd2l0aF90cmFuc2ZlcnMoJm1zZywgdHgsIDEpOw0KPiAgCXJldCA9
IHNwaV9zeW5jKGFkNzk0OV9hZGMtPnNwaSwgJm1zZyk7DQo=
