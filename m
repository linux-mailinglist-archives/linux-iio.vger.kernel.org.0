Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6223EB34EF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfIPG6P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 02:58:15 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35324 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbfIPG6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 02:58:15 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G6qkfB027590;
        Mon, 16 Sep 2019 02:58:11 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2054.outbound.protection.outlook.com [104.47.48.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0t2936en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeUpHcAmt0DrQINCGs6sP7/rZYVJ51h6UaWekG1c/UdDLg8VIKYgt9GdKM1CCvgL7yR0E8vJmw50uTAUNUDnjVgWQs/4gHmh19ceI8iZyQcH2ndufcygzn1YKHNox3GwM6IG6ZKT1OO/bKDHej52XE4v9BLkq6LfDw8/5UVadqzi11RxPNhkqpsdIq20XEupLoRISAzRTrNk9cCMEUTL5IRllnpGS5gDd5uMVI7IPItvLBVL8RRXLvReKecJEMNPwdPaYn2ucc/NPEWsJW0Z2+tGdmOaWWSUaDok87rgFfrwbT/3azy8k0B8cPXov9kwYpyK29hbv13kdsYmTJ139A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHUX5SwrWA/2xgVL95RFjzjh3sM8wc7NY2FZ+eMaUd4=;
 b=mXwWqh1wyeRLQ9TQaJiPWawTLbb7ktLhgBqTe3WZd4dwx/qWpCii/KL7uC+Tsz7AbaSBAG91LKAv4+eKlBnjcauJ9TbX5VYgV9/zBE4Reji8HYB54YNZHVCJErSISPFtzlOdA3TJsLu6n3e8Wwl2gyeUPvR0JjYgUnIaop4fXYMqlA4XY1/70JyedJl8DEcdImrSYhFc4aCEU/08EtytXo62AtREc/U4215wrErUbFFRbLmJWk/3eNETtqXIr/8biGQDHYQelBjRyaGhislxeD5XlECZsm/BYigTqvjX0AhqOQJPJPYtj9mywAO5vQMLeF4L5pQTKSW9K2MDZZj4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHUX5SwrWA/2xgVL95RFjzjh3sM8wc7NY2FZ+eMaUd4=;
 b=6+l82x6/uUYatOLA6VWV+EkbRGOhOZRX79AA+sUp5ZuWiyhs6eNjY7WSe6sC0O1oTINxsQBtPNcakCp29eusN2YONsZXlQGt9Nv/j9L7MeDGrGgYVOQ6KoaICXdcdJL0Ix4X6sjrzBVa5JUABLolxYZrBYnji9VuHiPPZ0PVbmE=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5365.namprd03.prod.outlook.com (20.180.4.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 06:58:09 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::344d:7f50:49a3:db1b%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 06:58:09 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: adis: convert cs_change_delay to
 spi_delay struct
Thread-Topic: [PATCH v2 4/4] iio: imu: adis: convert cs_change_delay to
 spi_delay struct
Thread-Index: AQHVahEV1X7DT+4/ZE6p031keAb6UqcsiKUAgAFbSYA=
Date:   Mon, 16 Sep 2019 06:58:08 +0000
Message-ID: <4bf1afcd8c913cdf3b48b72cd74d5255a6413cf9.camel@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
         <20190913115549.3823-5-alexandru.ardelean@analog.com>
         <20190915111442.27e3c221@archlinux>
In-Reply-To: <20190915111442.27e3c221@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0e3225c-704d-45d7-5d35-08d73a733b8f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR03MB5365;
x-ms-traffictypediagnostic: CH2PR03MB5365:
x-microsoft-antispam-prvs: <CH2PR03MB53659B82C229E86A7A5A3C11F98C0@CH2PR03MB5365.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39850400004)(136003)(199004)(189003)(8936002)(305945005)(14444005)(256004)(4326008)(476003)(5660300002)(6486002)(2616005)(316002)(66946007)(66476007)(66556008)(64756008)(66446008)(36756003)(478600001)(14454004)(76116006)(86362001)(11346002)(446003)(66066001)(6916009)(25786009)(2501003)(7736002)(26005)(102836004)(76176011)(3846002)(6116002)(6506007)(53936002)(8676002)(118296001)(81166006)(81156014)(54906003)(229853002)(486006)(6436002)(71200400001)(71190400001)(2351001)(6246003)(186003)(99286004)(6512007)(5640700003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5365;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qWrlSuMYisL59tpS0fHxLVzzQqQYGO9okbkqSkeLI3ctOA9ba1SPQdLMvex2/tNFmKf9YidlMz4TNP9GAKhaftncqYNQqdvk5min1ihNzQcDarWqpaMXgeqx+pPYteGv4yTEd+4TdCCfi/bc5EXFOk0jK0SGM6RpE64j0wtvy50uQdJXV4d+j9sqBQN+2es1VSKPvjVF7YRxSK+v/tZaYMy+nquxznLTdqSHgyFdtSFoos7e9Aejr+G1q2zVu/YZo4nkbHDAsvGQ4ibs+LU+C7jBUUbm2PR0NRNCNwknB5jAmHDYpU2C2PZtvgmOSDt4avpZwJzBfs4Qox9QlTLPOzk0atAIDaWRufyk/ysb4Qqgw2c2vAV5hp+ezPkU5WTv5IIbpVIBifEmHPKDEnGBoABMb1pTZcdy73TrDErAATw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E191D0DC14DEB6409C9749DA8DAC5203@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e3225c-704d-45d7-5d35-08d73a733b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 06:58:08.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4eTA+veKdCsfVUAElVzBYOb+M1Rig/MafmorYKfPog6FJGtO+szfD8w1dDMLpr88iXjOcvwwKH5p0Bn/tUPSqC9hG5iqCBIWEEz4FtEHIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5365
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_03:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909160074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE5LTA5LTE1IGF0IDExOjE0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDEzIFNlcCAyMDE5IDE0OjU1OjQ5ICswMzAw
DQo+IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+IHdy
b3RlOg0KPiANCj4gPiBUaGUgQURJUyBsaWJyYXJ5IGlzIG9uZSBvZiB0aGUgZmV3IHVzZXJzIG9m
IHRoZSBuZXcgYGNzX2NoYW5nZV9kZWxheWANCj4gPiBwYXJhbWV0ZXIgZm9yIGFuIHNwaV90cmFu
c2Zlci4NCj4gPiANCj4gPiBUaGUgaW50cm9kdWN0aW9uIG9mIHRoZSBgc3BpX2RlbGF5YCBzdHJ1
Y3QsIHJlcXVpcmVzIHRoYXQgdGhlIHVzZXJzIG9mIG9mDQo+ID4gYGNzX2NoYW5nZV9kZWxheWAg
Z2V0IGFuIHVwZGF0ZS4gVGhpcyBjaGFuZ2UgdXBkYXRlcyB0aGUgQURJUyBsaWJyYXJ5Lg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVs
ZWFuQGFuYWxvZy5jb20+DQo+IA0KPiBMb29rcyB0byBtZSBsaWtlIHRoZSBidWlsZCBpcyBicm9r
ZW4gYmV0d2VlbiBwYXRjaGVzIDMgYW5kIDQuDQo+IERvbid0IGRvIHRoYXQgYXMgaXQgYnJlYWtz
IGJpc2VjdGFiaWxpdHkuDQo+IA0KPiBJZiB5b3UgYXJlIGNoYW5naW5nIGFuIGludGVyZmFjZSBs
aWtlIHRoaXMgaXQgaGFzIHRvIG9jY3VyIGluIG9uZSBwYXRjaCwNCj4gb2YgeW91IGhhdmUgdG8g
aGF2ZSBpbnRlcm1lZGlhdGUgY29kZSB0aGF0IGRlYWxzIHdpdGggdGhlIHNtb290aCB0cmFuc2l0
aW9uLg0KPiANCj4gT3RoZXJ3aXNlLCBsb29rcyBsaWtlIGEgc2Vuc2libGUgYml0IG9mIHJld29y
ayB0byBtZS4NCg0KSSB0aG91Z2h0IGFib3V0IGl0LCBidXQgd2Fzbid0IHN1cmUuDQpXaWxsIGNy
ZWF0ZSBhIHYzIHdpdGggcGF0Y2hlcyAzICYgNCBzcXVhc2hlZC4NCg0KVGhhbmtzDQpBbGV4DQoN
Cj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpcy5j
IHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9paW8vaW11L2FkaXMuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gPiBpbmRleCAx
NjMxYzI1NWRlYWIuLjJjZDJjYzIzMTZjNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9p
bXUvYWRpcy5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiA+IEBAIC0zOSwy
NCArMzksMjQgQEAgaW50IGFkaXNfd3JpdGVfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25l
ZCBpbnQgcmVnLA0KPiA+ICAJCQkubGVuID0gMiwNCj4gPiAgCQkJLmNzX2NoYW5nZSA9IDEsDQo+
ID4gIAkJCS5kZWxheV91c2VjcyA9IGFkaXMtPmRhdGEtPndyaXRlX2RlbGF5LA0KPiA+IC0JCQku
Y3NfY2hhbmdlX2RlbGF5ID0gYWRpcy0+ZGF0YS0+Y3NfY2hhbmdlX2RlbGF5LA0KPiA+IC0JCQku
Y3NfY2hhbmdlX2RlbGF5X3VuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUywNCj4gPiArCQkJLmNz
X2NoYW5nZV9kZWxheS52YWx1ZSA9IGFkaXMtPmRhdGEtPmNzX2NoYW5nZV9kZWxheSwNCj4gPiAr
CQkJLmNzX2NoYW5nZV9kZWxheS51bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MsDQo+ID4gIAkJ
fSwgew0KPiA+ICAJCQkudHhfYnVmID0gYWRpcy0+dHggKyAyLA0KPiA+ICAJCQkuYml0c19wZXJf
d29yZCA9IDgsDQo+ID4gIAkJCS5sZW4gPSAyLA0KPiA+ICAJCQkuY3NfY2hhbmdlID0gMSwNCj4g
PiAgCQkJLmRlbGF5X3VzZWNzID0gYWRpcy0+ZGF0YS0+d3JpdGVfZGVsYXksDQo+ID4gLQkJCS5j
c19jaGFuZ2VfZGVsYXkgPSBhZGlzLT5kYXRhLT5jc19jaGFuZ2VfZGVsYXksDQo+ID4gLQkJCS5j
c19jaGFuZ2VfZGVsYXlfdW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICsJCQkuY3Nf
Y2hhbmdlX2RlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0+Y3NfY2hhbmdlX2RlbGF5LA0KPiA+ICsJ
CQkuY3NfY2hhbmdlX2RlbGF5LnVuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUywNCj4gPiAgCQl9
LCB7DQo+ID4gIAkJCS50eF9idWYgPSBhZGlzLT50eCArIDQsDQo+ID4gIAkJCS5iaXRzX3Blcl93
b3JkID0gOCwNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4gIAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+
ICAJCQkuZGVsYXlfdXNlY3MgPSBhZGlzLT5kYXRhLT53cml0ZV9kZWxheSwNCj4gPiAtCQkJLmNz
X2NoYW5nZV9kZWxheSA9IGFkaXMtPmRhdGEtPmNzX2NoYW5nZV9kZWxheSwNCj4gPiAtCQkJLmNz
X2NoYW5nZV9kZWxheV91bml0ID0gU1BJX0RFTEFZX1VOSVRfVVNFQ1MsDQo+ID4gKwkJCS5jc19j
aGFuZ2VfZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRhLT5jc19jaGFuZ2VfZGVsYXksDQo+ID4gKwkJ
CS5jc19jaGFuZ2VfZGVsYXkudW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICAJCX0s
IHsNCj4gPiAgCQkJLnR4X2J1ZiA9IGFkaXMtPnR4ICsgNiwNCj4gPiAgCQkJLmJpdHNfcGVyX3dv
cmQgPSA4LA0KPiA+IEBAIC0xMzksMTYgKzEzOSwxNiBAQCBpbnQgYWRpc19yZWFkX3JlZyhzdHJ1
Y3QgYWRpcyAqYWRpcywgdW5zaWduZWQgaW50IHJlZywNCj4gPiAgCQkJLmxlbiA9IDIsDQo+ID4g
IAkJCS5jc19jaGFuZ2UgPSAxLA0KPiA+ICAJCQkuZGVsYXlfdXNlY3MgPSBhZGlzLT5kYXRhLT53
cml0ZV9kZWxheSwNCj4gPiAtCQkJLmNzX2NoYW5nZV9kZWxheSA9IGFkaXMtPmRhdGEtPmNzX2No
YW5nZV9kZWxheSwNCj4gPiAtCQkJLmNzX2NoYW5nZV9kZWxheV91bml0ID0gU1BJX0RFTEFZX1VO
SVRfVVNFQ1MsDQo+ID4gKwkJCS5jc19jaGFuZ2VfZGVsYXkudmFsdWUgPSBhZGlzLT5kYXRhLT5j
c19jaGFuZ2VfZGVsYXksDQo+ID4gKwkJCS5jc19jaGFuZ2VfZGVsYXkudW5pdCA9IFNQSV9ERUxB
WV9VTklUX1VTRUNTLA0KPiA+ICAJCX0sIHsNCj4gPiAgCQkJLnR4X2J1ZiA9IGFkaXMtPnR4ICsg
MiwNCj4gPiAgCQkJLmJpdHNfcGVyX3dvcmQgPSA4LA0KPiA+ICAJCQkubGVuID0gMiwNCj4gPiAg
CQkJLmNzX2NoYW5nZSA9IDEsDQo+ID4gIAkJCS5kZWxheV91c2VjcyA9IGFkaXMtPmRhdGEtPnJl
YWRfZGVsYXksDQo+ID4gLQkJCS5jc19jaGFuZ2VfZGVsYXkgPSBhZGlzLT5kYXRhLT5jc19jaGFu
Z2VfZGVsYXksDQo+ID4gLQkJCS5jc19jaGFuZ2VfZGVsYXlfdW5pdCA9IFNQSV9ERUxBWV9VTklU
X1VTRUNTLA0KPiA+ICsJCQkuY3NfY2hhbmdlX2RlbGF5LnZhbHVlID0gYWRpcy0+ZGF0YS0+Y3Nf
Y2hhbmdlX2RlbGF5LA0KPiA+ICsJCQkuY3NfY2hhbmdlX2RlbGF5LnVuaXQgPSBTUElfREVMQVlf
VU5JVF9VU0VDUywNCj4gPiAgCQl9LCB7DQo+ID4gIAkJCS50eF9idWYgPSBhZGlzLT50eCArIDQs
DQo+ID4gIAkJCS5yeF9idWYgPSBhZGlzLT5yeCwNCj4gPiBAQCAtMTU2LDggKzE1Niw4IEBAIGlu
dCBhZGlzX3JlYWRfcmVnKHN0cnVjdCBhZGlzICphZGlzLCB1bnNpZ25lZCBpbnQgcmVnLA0KPiA+
ICAJCQkubGVuID0gMiwNCj4gPiAgCQkJLmNzX2NoYW5nZSA9IDEsDQo+ID4gIAkJCS5kZWxheV91
c2VjcyA9IGFkaXMtPmRhdGEtPnJlYWRfZGVsYXksDQo+ID4gLQkJCS5jc19jaGFuZ2VfZGVsYXkg
PSBhZGlzLT5kYXRhLT5jc19jaGFuZ2VfZGVsYXksDQo+ID4gLQkJCS5jc19jaGFuZ2VfZGVsYXlf
dW5pdCA9IFNQSV9ERUxBWV9VTklUX1VTRUNTLA0KPiA+ICsJCQkuY3NfY2hhbmdlX2RlbGF5LnZh
bHVlID0gYWRpcy0+ZGF0YS0+Y3NfY2hhbmdlX2RlbGF5LA0KPiA+ICsJCQkuY3NfY2hhbmdlX2Rl
bGF5LnVuaXQgPSBTUElfREVMQVlfVU5JVF9VU0VDUywNCj4gPiAgCQl9LCB7DQo+ID4gIAkJCS5y
eF9idWYgPSBhZGlzLT5yeCArIDIsDQo+ID4gIAkJCS5iaXRzX3Blcl93b3JkID0gOCwNCg==
